package Servlet;

import DAO.NotificationDAO;
import Model.Notification;
import Model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "NotificationServlet", urlPatterns = {"/notifications", "/notifications/*"})
public class NotificationServlet extends HttpServlet {

    private final NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Users currentUser = (Users) (session != null ? session.getAttribute("currentUser") : null);

        if (currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Not logged in");
            return;
        }

        String action = request.getParameter("action");

        // Handle JSON API requests
        if (action != null) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();

            switch (action) {
                case "count":
                    // Return unread notification count
                    int count = notificationDAO.getUnreadCount(currentUser.getUserId());
                    out.print("{\"count\":" + count + "}");
                    break;

                case "list":
                    // Return all notifications for current user
                    List<Notification> notifications = notificationDAO
                            .getNotificationsByUserId(currentUser.getUserId());
                    out.print(notificationsToJson(notifications));
                    break;

                case "unread":
                    // Return only unread notifications
                    List<Notification> unread = notificationDAO.getUnreadNotifications(currentUser.getUserId());
                    out.print(notificationsToJson(unread));
                    break;

                case "recent":
                    // Return recent notifications (limit 5) for dropdown
                    List<Notification> recent = notificationDAO.getNotificationsByUserId(currentUser.getUserId());
                    int limit = Math.min(5, recent.size());
                    out.print(notificationsToJson(recent.subList(0, limit)));
                    break;

                default:
                    out.print("{\"error\":\"Unknown action: " + escapeJson(action) + "\"}");
            }
            out.flush();
            return;
        }

        // Forward to notifications page view
        List<Notification> notifications = notificationDAO.getNotificationsByUserId(currentUser.getUserId());
        int unreadCount = notificationDAO.getUnreadCount(currentUser.getUserId());

        request.setAttribute("notifications", notifications);
        request.setAttribute("unreadCount", unreadCount);
        request.getRequestDispatcher("/notifications.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Users currentUser = (Users) (session != null ? session.getAttribute("currentUser") : null);

        if (currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Not logged in");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");

        if (action == null) {
            out.print("{\"success\":false,\"message\":\"No action specified\"}");
            out.flush();
            return;
        }

        switch (action) {
            case "markRead":
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    try {
                        int notificationId = Integer.parseInt(idStr);
                        // Verify this notification belongs to current user
                        Notification notification = notificationDAO.getNotificationById(notificationId);
                        if (notification != null && notification.getUserId() == currentUser.getUserId()) {
                            boolean success = notificationDAO.markAsRead(notificationId);
                            out.print("{\"success\":" + success + ",\"message\":\""
                                    + (success ? "Marked as read" : "Failed to mark as read") + "\"}");
                        } else {
                            out.print("{\"success\":false,\"message\":\"Notification not found or access denied\"}");
                        }
                    } catch (NumberFormatException e) {
                        out.print("{\"success\":false,\"message\":\"Invalid notification ID\"}");
                    }
                } else {
                    out.print("{\"success\":false,\"message\":\"Notification ID required\"}");
                }
                break;

            case "markAllRead":
                int markedCount = notificationDAO.markAllAsRead(currentUser.getUserId());
                out.print("{\"success\":true,\"message\":\"Marked " + markedCount
                        + " notifications as read\",\"count\":" + markedCount + "}");
                break;

            case "delete":
                String deleteIdStr = request.getParameter("id");
                if (deleteIdStr != null) {
                    try {
                        int notificationId = Integer.parseInt(deleteIdStr);
                        // Verify this notification belongs to current user
                        Notification notification = notificationDAO.getNotificationById(notificationId);
                        if (notification != null && notification.getUserId() == currentUser.getUserId()) {
                            boolean success = notificationDAO.deleteNotification(notificationId);
                            out.print("{\"success\":" + success + ",\"message\":\""
                                    + (success ? "Deleted" : "Failed to delete") + "\"}");
                        } else {
                            out.print("{\"success\":false,\"message\":\"Notification not found or access denied\"}");
                        }
                    } catch (NumberFormatException e) {
                        out.print("{\"success\":false,\"message\":\"Invalid notification ID\"}");
                    }
                } else {
                    out.print("{\"success\":false,\"message\":\"Notification ID required\"}");
                }
                break;

            default:
                out.print("{\"success\":false,\"message\":\"Unknown action: " + escapeJson(action) + "\"}");
        }

        out.flush();
    }

    /**
     * Convert a list of notifications to JSON array string
     */
    private String notificationsToJson(List<Notification> notifications) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < notifications.size(); i++) {
            if (i > 0) {
                sb.append(",");
            }
            sb.append(notificationToJson(notifications.get(i)));
        }
        sb.append("]");
        return sb.toString();
    }

    /**
     * Convert a single notification to JSON object string
     */
    private String notificationToJson(Notification n) {
        StringBuilder sb = new StringBuilder("{");
        sb.append("\"notificationId\":").append(n.getNotificationId()).append(",");
        sb.append("\"userId\":").append(n.getUserId()).append(",");
        sb.append("\"type\":\"").append(escapeJson(n.getType())).append("\",");
        sb.append("\"title\":\"").append(escapeJson(n.getTitle())).append("\",");
        sb.append("\"message\":\"").append(escapeJson(n.getMessage())).append("\",");
        sb.append("\"read\":").append(n.isRead()).append(",");

        if (n.getRelatedUserId() != null) {
            sb.append("\"relatedUserId\":").append(n.getRelatedUserId()).append(",");
        }

        if (n.getCreatedAt() != null) {
            sb.append("\"createdAt\":\"").append(n.getCreatedAt().toString()).append("\",");
        }

        if (n.getReadAt() != null) {
            sb.append("\"readAt\":\"").append(n.getReadAt().toString()).append("\",");
        }

        if (n.getRelatedUserFullName() != null) {
            sb.append("\"relatedUserFullName\":\"").append(escapeJson(n.getRelatedUserFullName())).append("\",");
        }

        if (n.getRelatedUserEmail() != null) {
            sb.append("\"relatedUserEmail\":\"").append(escapeJson(n.getRelatedUserEmail())).append("\",");
        }

        // Remove trailing comma and close
        String result = sb.toString();
        if (result.endsWith(",")) {
            result = result.substring(0, result.length() - 1);
        }
        return result + "}";
    }

    /**
     * Escape special characters for JSON string
     */
    private String escapeJson(String text) {
        if (text == null) {
            return "";
        }
        return text
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
