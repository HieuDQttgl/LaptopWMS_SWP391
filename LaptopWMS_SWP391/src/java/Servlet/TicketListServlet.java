package Servlet;

import DAO.TicketDAO;
import Model.Ticket;
import Model.Users;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "TicketListServlet", urlPatterns = { "/ticket-list" })
public class TicketListServlet extends HttpServlet {

    private TicketDAO ticketDAO = new TicketDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String status = request.getParameter("status");
        String type = request.getParameter("type");
        String partnerSearch = request.getParameter("partnerSearch");

        if (status == null) status = "all";
        if (type == null) type = "all";
        if (partnerSearch == null) partnerSearch = "";

        List<Ticket> fullList;
        if (currentUser.getRoleId() == 3) {
            fullList = ticketDAO.getTicketsForKeeper(currentUser.getUserId(), status, type, partnerSearch);
        } else {
            fullList = ticketDAO.getAllTickets(status, type, partnerSearch);
        }

        int page = 1;
        int pageSize = 5;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int totalItems = fullList.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        if (page < 1) page = 1;
        if (page > totalPages && totalPages > 0) page = totalPages;

        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalItems);

        List<Ticket> pageList = new ArrayList<>();
        if (totalItems > 0 && start < totalItems) {
            pageList = fullList.subList(start, end);
        }

        request.setAttribute("tickets", pageList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalItems", totalItems);
        
        request.setAttribute("currentStatus", status);
        request.setAttribute("currentType", type);
        request.setAttribute("currentPartnerSearch", partnerSearch);

        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }

        request.getRequestDispatcher("/ticket-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}