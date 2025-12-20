package Servlet;

import DAO.NotificationDAO;
import DAO.TicketDAO;
import Model.Notification;
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Load data for the form
        List<TicketItem> products = ticketDAO.getAvailableProducts();
        List<Users> keepers = ticketDAO.getKeeperList();

        request.setAttribute("products", products);
        request.setAttribute("keepers", keepers);

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
            // Get ticket data
            String type = request.getParameter("type");
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String keeperIdStr = request.getParameter("keeperId");

            // Get product items
            String[] productIds = request.getParameterValues("productDetailId");
            String[] quantities = request.getParameterValues("quantity");

            // Validate
            if (type == null || title == null || title.trim().isEmpty()) {
                request.setAttribute("error", "Please fill in all required fields");
                doGet(request, response);
                return;
            }

            // Validate keeper is selected
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

            // Check for duplicate products
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

            // Create ticket object
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

            // Add items
            List<TicketItem> items = new ArrayList<>();
            for (int i = 0; i < productIds.length; i++) {
                if (productIds[i] != null && !productIds[i].isEmpty()) {
                    TicketItem item = new TicketItem();
                    item.setProductDetailId(Integer.parseInt(productIds[i]));
                    item.setQuantity(Integer.parseInt(quantities[i]));
                    items.add(item);
                }
            }
            ticket.setItems(items);

            // For EXPORT tickets, validate stock availability
            if ("EXPORT".equals(type)) {
                String stockError = ticketDAO.validateExportStock(items);
                if (stockError != null) {
                    request.setAttribute("error", "Insufficient stock: " + stockError);
                    doGet(request, response);
                    return;
                }
            }

            // Save to database
            int ticketId = ticketDAO.createTicket(ticket);

            if (ticketId > 0) {
                // Notify assigned keeper if one was selected
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

            // Link to ticket detail page
            String link = "/ticket-detail?id=" + ticketId;

            Notification notification = new Notification(keeperId, title, message, link);
            notificationDAO.createNotification(notification);
        } catch (Exception e) {
            e.printStackTrace();
            // Don't fail the ticket creation if notification fails
        }
    }
}
