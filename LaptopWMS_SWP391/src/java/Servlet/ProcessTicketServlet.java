package Servlet;

import DAO.NotificationDAO;
import DAO.TicketDAO;
import Model.Notification;
import Model.Ticket;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet for processing tickets (Complete/Cancel) - Keeper role
 * Notifies ticket creator when ticket is processed
 */
@WebServlet(name = "ProcessTicketServlet", urlPatterns = { "/process-ticket" })
public class ProcessTicketServlet extends HttpServlet {

    private TicketDAO ticketDAO = new TicketDAO();
    private NotificationDAO notificationDAO = new NotificationDAO();

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

        // Only Keeper (role 3) or Admin (role 1) can process tickets
        if (currentUser.getRoleId() != 3 && currentUser.getRoleId() != 1) {
            session.setAttribute("errorMessage", "You don't have permission to process tickets");
            response.sendRedirect(request.getContextPath() + "/ticket-list");
            return;
        }

        String ticketIdStr = request.getParameter("ticketId");
        String action = request.getParameter("action"); // "complete" or "cancel"
        String keeperNote = request.getParameter("keeperNote");

        if (ticketIdStr == null || action == null) {
            response.sendRedirect(request.getContextPath() + "/ticket-list");
            return;
        }

        try {
            int ticketId = Integer.parseInt(ticketIdStr);
            Ticket ticket = ticketDAO.getTicketById(ticketId);

            if (ticket == null) {
                session.setAttribute("errorMessage", "Ticket not found");
                response.sendRedirect(request.getContextPath() + "/ticket-list");
                return;
            }

            if (!ticket.getStatus().equals("PENDING")) {
                session.setAttribute("errorMessage", "Ticket has already been processed");
                response.sendRedirect(request.getContextPath() + "/ticket-detail?id=" + ticketId);
                return;
            }

            boolean success = false;
            String message = "";
            String newStatus = "";

            if ("complete".equals(action)) {
                success = ticketDAO.completeTicket(ticketId, keeperNote);
                message = success ? "Ticket approved successfully! Stock has been updated."
                        : "Failed to approve ticket";
                newStatus = "APPROVED";
            } else if ("cancel".equals(action)) {
                success = ticketDAO.cancelTicket(ticketId, keeperNote);
                message = success ? "Ticket rejected successfully!"
                        : "Failed to reject ticket";
                newStatus = "REJECTED";
            }

            if (success) {
                // Notify the ticket creator about the status change
                notifyCreatorOfStatusChange(ticket, newStatus, currentUser.getFullName(), keeperNote);
                session.setAttribute("successMessage", message);
            } else {
                session.setAttribute("errorMessage", message);
            }

            response.sendRedirect(request.getContextPath() + "/ticket-detail?id=" + ticketId);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ticket-list");
        }
    }

    /**
     * Send notification to ticket creator when ticket status changes
     */
    private void notifyCreatorOfStatusChange(Ticket ticket, String newStatus, String keeperName, String keeperNote) {
        try {
            int creatorId = ticket.getCreatedBy();

            String title;
            String statusDescription;

            if ("COMPLETED".equals(newStatus)) {
                title = "Ticket Approved ✓";
                statusDescription = "approved and completed";
            } else if ("CANCELLED".equals(newStatus)) {
                title = "Ticket Rejected ✗";
                statusDescription = "rejected/cancelled";
            } else {
                title = "Ticket Status Updated";
                statusDescription = "updated to " + newStatus;
            }

            StringBuilder messageBuilder = new StringBuilder();
            messageBuilder.append(String.format("Your ticket has been %s.\n\n", statusDescription));
            messageBuilder.append("Ticket Details:\n");
            messageBuilder.append(String.format("- Title: %s\n", ticket.getTitle()));
            messageBuilder.append(String.format("- Type: %s\n", ticket.getType()));
            messageBuilder.append(String.format("- Status: %s\n", newStatus));
            messageBuilder.append(String.format("- Processed by: %s\n", keeperName != null ? keeperName : "Keeper"));

            if (keeperNote != null && !keeperNote.trim().isEmpty()) {
                messageBuilder.append(String.format("\nKeeper's Note:\n%s", keeperNote));
            }

            // Link to ticket detail page
            String link = "/ticket-detail?id=" + ticket.getTicketId();

            Notification notification = new Notification(creatorId, title, messageBuilder.toString(), link);
            notificationDAO.createNotification(notification);
        } catch (Exception e) {
            e.printStackTrace();
            // Don't fail the ticket processing if notification fails
        }
    }
}
