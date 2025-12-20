package DAO;

import static DAO.DBContext.getConnection;
import Model.Announcement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author super
 */
public class AnnouncementDAO extends DBContext {

    public List<Announcement> getAnnouncements(int limit) {
        List<Announcement> list = new ArrayList<>();
        String sql = "SELECT a.announcement_id, a.user_id, u.full_name, r.role_name, a.content, a.created_at "
                + "FROM announcements a "
                + "JOIN users u ON a.user_id = u.user_id "
                + "JOIN roles r ON u.role_id = r.role_id "
                + "ORDER BY a.created_at DESC";

        if (limit > 0) {
            sql += " LIMIT " + limit;
        }

        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Announcement(
                        rs.getInt("announcement_id"),
                        rs.getInt("user_id"),
                        rs.getString("full_name"),
                        rs.getString("role_name"),
                        rs.getString("content"),
                        rs.getTimestamp("created_at")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addAnnouncement(int userId, String content) {
        String sql = "INSERT INTO announcements (user_id, content) VALUES (?, ?)";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, content);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteAnnouncement(int id) {
        String sql = "DELETE FROM announcements WHERE announcement_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateAnnouncement(int id, String newContent) {
        String sql = "UPDATE announcements SET content = ? WHERE announcement_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setString(1, newContent);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean isAnnouncementOwner(int announcementId, int userId) {
        String sql = "SELECT announcement_id FROM announcements WHERE announcement_id = ? AND user_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, announcementId);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
