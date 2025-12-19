package DAO;

import Model.Notification;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * NotificationDAO - updated for laptop_wms_lite database
 * DB Schema: notification_id, user_id, title, message, is_read, created_at
 */
public class NotificationDAO extends DBContext {

    public int createNotification(Notification notification) {
        String sql = "INSERT INTO notifications (user_id, title, message, link) VALUES (?, ?, ?, ?)";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, notification.getUserId());
            ps.setString(2, notification.getTitle());
            ps.setString(3, notification.getMessage());
            ps.setString(4, notification.getLink());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public List<Notification> getNotificationsByUserId(int userId) {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE user_id = ? ORDER BY created_at DESC";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    notifications.add(mapResultSetToNotification(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return notifications;
    }

    public List<Notification> getUnreadNotifications(int userId) {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE user_id = ? AND is_read = 0 ORDER BY created_at DESC";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    notifications.add(mapResultSetToNotification(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return notifications;
    }

    public int getUnreadCount(int userId) {
        String sql = "SELECT COUNT(*) FROM notifications WHERE user_id = ? AND is_read = 0";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean markAsRead(int notificationId) {
        String sql = "UPDATE notifications SET is_read = 1 WHERE notification_id = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, notificationId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int markAllAsRead(int userId) {
        String sql = "UPDATE notifications SET is_read = 1 WHERE user_id = ? AND is_read = 0";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean deleteNotification(int notificationId) {
        String sql = "DELETE FROM notifications WHERE notification_id = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, notificationId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Notification getNotificationById(int notificationId) {
        String sql = "SELECT * FROM notifications WHERE notification_id = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, notificationId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToNotification(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getFirstAdminUserId() {
        String sql = "SELECT user_id FROM users WHERE role_id = 1 AND status = 'active' LIMIT 1";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("user_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean createPasswordResetNotification(Model.Users requestingUser) {
        int adminUserId = getFirstAdminUserId();

        if (adminUserId == -1) {
            System.err.println("No active admin found to receive notification");
            return false;
        }

        String title = "Password Reset Request";
        String message = String.format(
                "User '%s' (%s) has requested a password reset.\n\n" +
                        "User Details:\n" +
                        "- Full Name: %s\n" +
                        "- Username: %s\n" +
                        "- Email: %s\n" +
                        "- User ID: %d\n\n" +
                        "Please reset their password and notify them.",
                requestingUser.getUsername(),
                requestingUser.getEmail(),
                requestingUser.getFullName() != null ? requestingUser.getFullName() : "N/A",
                requestingUser.getUsername(),
                requestingUser.getEmail(),
                requestingUser.getUserId());

        // Link to user detail page for easy access
        String link = "/user-detail?id=" + requestingUser.getUserId();

        Notification notification = new Notification(adminUserId, title, message, link);

        return createNotification(notification) > 0;
    }

    private Notification mapResultSetToNotification(ResultSet rs) throws java.sql.SQLException {
        Notification n = new Notification();
        n.setNotificationId(rs.getInt("notification_id"));
        n.setUserId(rs.getInt("user_id"));
        n.setTitle(rs.getString("title"));
        n.setMessage(rs.getString("message"));
        n.setLink(rs.getString("link"));
        n.setRead(rs.getBoolean("is_read"));
        n.setCreatedAt(rs.getTimestamp("created_at"));
        return n;
    }
}
