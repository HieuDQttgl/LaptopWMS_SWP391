package Servlet;

import DAO.PartnerDAO;
import DAO.TicketDAO;
import DAO.UserDAO;
import Model.Ticket;
import Model.TicketItem;
import Model.Users;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/edit-ticket"})
public class EditTicketServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null || (currentUser.getRoleId() != 1 && currentUser.getRoleId() != 2)) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int ticketId = Integer.parseInt(request.getParameter("id"));
            TicketDAO ticketDAO = new TicketDAO();
            Ticket ticket = ticketDAO.getTicketById(ticketId);

            if (ticket == null || !"PENDING".equalsIgnoreCase(ticket.getStatus())) {
                session.setAttribute("error", "Only pending tickets can be edited!");
                response.sendRedirect("ticket-list");
                return;
            }

            PartnerDAO partnerDAO = new PartnerDAO();

            if ("IMPORT".equalsIgnoreCase(ticket.getType())) {
                request.setAttribute("partners", partnerDAO.getSuppliers());
            } else {
                request.setAttribute("partners", partnerDAO.getCustomers());
            }

            request.setAttribute("ticket", ticket);
            request.setAttribute("keepers", ticketDAO.getKeeperList());
            request.setAttribute("availableProducts", ticketDAO.getAvailableProducts());

            request.getRequestDispatcher("edit-ticket.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ticket-list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TicketDAO ticketDAO = new TicketDAO();
        try {
            int ticketId = Integer.parseInt(request.getParameter("ticketId"));
            String title = request.getParameter("title");
            String type = request.getParameter("type");
            String description = request.getParameter("description");
            int keeperId = Integer.parseInt(request.getParameter("keeperId"));
            int partnerId = Integer.parseInt(request.getParameter("partnerId"));

            String[] productDetailIds = request.getParameterValues("productDetailId");
            String[] quantities = request.getParameterValues("quantity");

            List<TicketItem> items = new ArrayList<>();
            if (productDetailIds != null) {
                for (int i = 0; i < productDetailIds.length; i++) {
                    TicketItem item = new TicketItem();
                    item.setProductDetailId(Integer.parseInt(productDetailIds[i]));
                    item.setQuantity(Integer.parseInt(quantities[i]));
                    items.add(item);
                }
            }

            Ticket ticket = new Ticket();
            ticket.setTicketId(ticketId);
            ticket.setTitle(title);
            ticket.setType(type);
            ticket.setDescription(description);
            ticket.setAssignedKeeper(keeperId);
            ticket.setPartnerId(partnerId);
            ticket.setItems(items);

            if ("EXPORT".equals(type)) {
                String stockError = ticketDAO.validateExportStock(items);
                if (stockError != null) {
                    request.setAttribute("error", "Stock Error: " + stockError);
                    doGet(request, response);
                    return;
                }
            }

            boolean success = ticketDAO.updateTicketWithItems(ticket);

            if (success) {
                request.getSession().setAttribute("successMessage", "Ticket #" + ticketId + " updated successfully!");

                response.sendRedirect(request.getContextPath() + "/ticket-list");
            } else {
                request.setAttribute("error", "Update failed. Ticket might be processed already.");
                doGet(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            doGet(request, response);
        }
    }
}
