package Servlet;

import DAO.NotificationDAO;
import DAO.PartnerDAO;
import DAO.TicketDAO;
import Model.Notification;
import Model.Partners;
import Model.Ticket;
import Model.TicketItem;
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

/**
 * Servlet for creating new tickets (IMPORT/EXPORT)
 * Notifies assigned keeper when a ticket is created
 */
@WebServlet(name = "CreateTicketServlet", urlPatterns = { "/create-ticket" })
public class CreateTicketServlet extends HttpServlet {

    private TicketDAO ticketDAO = new TicketDAO();
    private NotificationDAO notificationDAO = new NotificationDAO();
    private PartnerDAO partnerDAO = new PartnerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<TicketItem> products = ticketDAO.getAvailableProducts();
        List<Users> keepers = ticketDAO.getKeeperList();
        List<Partners> suppliers = partnerDAO.getSuppliers();
        List<Partners> customers = partnerDAO.getCustomers();

        request.setAttribute("products", products);
        request.setAttribute("keepers", keepers);
        request.setAttribute("suppliers", suppliers);
        request.setAttribute("customers", customers);

        request.getRequestDispatcher("/create-ticket.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String type = request.getParameter("type");
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String keeperIdStr = request.getParameter("keeperId");
            String partnerIdStr = request.getParameter("partnerId");

            String[] productIds = request.getParameterValues("productDetailId");
            String[] quantities = request.getParameterValues("quantity");

            if (type == null || type.trim().isEmpty() || title == null || title.trim().isEmpty()) {
                request.setAttribute("error", "Please fill in all required fields");
                doGet(request, response);
                return;
            }

            if (keeperIdStr == null || keeperIdStr.trim().isEmpty()) {
                request.setAttribute("error", "Please select a Keeper to assign");
                doGet(request, response);
                return;
            }

            if (productIds == null || productIds.length == 0) {
                request.setAttribute("error", "Please add at least one product");
                doGet(request, response);
                return;
            }

            java.util.Set<String> productIdSet = new java.util.HashSet<>();
            for (String productId : productIds) {
                if (productId != null && !productId.isEmpty()) {
                    if (!productIdSet.add(productId)) {
                        request.setAttribute("error",
                                "Each product can only be selected once. Please remove duplicate products.");
                        doGet(request, response);
                        return;
                    }
                }
            }

            Ticket ticket = new Ticket();
            ticket.setType(type);
            ticket.setTitle(title.trim());
            ticket.setDescription(description != null ? description.trim() : "");
            ticket.setCreatedBy(currentUser.getUserId());

            Integer assignedKeeperId = null;
            if (keeperIdStr != null && !keeperIdStr.isEmpty()) {
                assignedKeeperId = Integer.parseInt(keeperIdStr);
                ticket.setAssignedKeeper(assignedKeeperId);
            }

            if (partnerIdStr != null && !partnerIdStr.isEmpty()) {
                int partnerId = Integer.parseInt(partnerIdStr);
                Partners partner = partnerDAO.getPartnerById(partnerId);
                if (partner != null) {
                    if ("IMPORT".equals(type) && partner.getType() != 1) {
                        request.setAttribute("error", "Invalid partner: Please select a Supplier for IMPORT tickets");
                        doGet(request, response);
                        return;
                    }
                    if ("EXPORT".equals(type) && partner.getType() != 2) {
                        request.setAttribute("error", "Invalid partner: Please select a Customer for EXPORT tickets");
                        doGet(request, response);
                        return;
                    }
                }
                ticket.setPartnerId(partnerId);
            }

            List<TicketItem> items = new ArrayList<>();
            for (int i = 0; i < productIds.length; i++) {
                if (productIds[i] != null && !productIds[i].isEmpty()) {
                    int quantity = Integer.parseInt(quantities[i]);
                    if (quantity <= 0) {
                        request.setAttribute("error", "Quantity must be greater than 0");
                        doGet(request, response);
                        return;
                    }
                    TicketItem item = new TicketItem();
                    item.setProductDetailId(Integer.parseInt(productIds[i]));
                    item.setQuantity(quantity);
                    items.add(item);
                }
            }
            ticket.setItems(items);

            if ("EXPORT".equals(type)) {
                String stockError = ticketDAO.validateExportStock(items);
                if (stockError != null) {
                    request.setAttribute("error", "Insufficient stock: " + stockError);
                    doGet(request, response);
                    return;
                }
            }

            int ticketId = ticketDAO.createTicket(ticket);

            if (ticketId > 0) {
                if (assignedKeeperId != null) {
                    notifyKeeperOfAssignment(assignedKeeperId, ticketId, title, type, currentUser.getFullName());
                }

                session.setAttribute("successMessage", "Ticket created successfully!");
                response.sendRedirect(request.getContextPath() + "/ticket-list");
            } else {
                request.setAttribute("error", "Failed to create ticket");
                doGet(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            doGet(request, response);
        }
    }

    /**
     * Send notification to keeper when they are assigned to a ticket
     */
    private void notifyKeeperOfAssignment(int keeperId, int ticketId, String ticketTitle, String ticketType,
            String creatorName) {
        try {
            String title = "New Ticket Assignment";
            String message = String.format(
                    "You have been assigned to a new %s ticket.\n\n" +
                            "Ticket Details:\n" +
                            "- Title: %s\n" +
                            "- Type: %s\n" +
                            "- Created by: %s\n\n" +
                            "Please review and process this ticket.",
                    ticketType,
                    ticketTitle,
                    ticketType,
                    creatorName != null ? creatorName : "Unknown");

            String link = "/ticket-detail?id=" + ticketId;

            Notification notification = new Notification(keeperId, title, message, link);
            notificationDAO.createNotification(notification);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
