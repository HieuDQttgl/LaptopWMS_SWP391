package DAO;

import Model.Users;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * UserDAO - updated for laptop_wms_lite database Simplified schema: user_id,
 * username, password, full_name, email, role_id, status
 */
public class UserDAO extends DBContext {

    public List<Users> getListUsers() {
        return getListUsers(null, null, null, "user_id", "ASC", 0, Integer.MAX_VALUE);
    }

    public List<Users> getListUsers(
            String keyword,
            Integer roleIdFilter,
            String statusFilter,
            String sortField,
            String sortOrder,
            int offset,
            int limit) {

        List<Users> users = new ArrayList<>();
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT u.*, r.role_name "
                + "FROM users u JOIN roles r ON u.role_id = r.role_id "
                + "WHERE 1=1 ");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (u.full_name LIKE ? OR u.email LIKE ? OR u.username LIKE ?) ");
            String wildcardKeyword = "%" + keyword.trim() + "%";
            params.add(wildcardKeyword);
            params.add(wildcardKeyword);
            params.add(wildcardKeyword);
        }
        if (roleIdFilter != null && roleIdFilter > 0) {
            sql.append("AND u.role_id = ? ");
            params.add(roleIdFilter);
        }
        if (statusFilter != null && !statusFilter.equalsIgnoreCase("all")) {
            sql.append("AND u.status = ? ");
            params.add(statusFilter);
        }

        String safeSortField = (sortField != null && !sortField.isEmpty()) ? sortField : "user_id";
        String safeSortOrder = (sortOrder != null && sortOrder.equalsIgnoreCase("DESC")) ? "DESC" : "ASC";
        String finalSortField = safeSortField.equals("role_name") ? "r.role_name" : "u." + safeSortField;
        sql.append(String.format("ORDER BY %s %s ", finalSortField, safeSortOrder));

        sql.append("LIMIT ? OFFSET ?");

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ps.setInt(params.size() + 1, limit);
            ps.setInt(params.size() + 2, offset);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Users user = new Users(
                            rs.getInt("user_id"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getString("full_name"),
                            rs.getString("email"),
                            rs.getInt("role_id"),
                            rs.getString("status"));
                    user.setRoleName(rs.getString("role_name"));
                    users.add(user);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    public int getTotalUsers(
            String keyword,
            Integer roleIdFilter,
            String statusFilter) {

        int total = 0;
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) "
                + "FROM users u JOIN roles r ON u.role_id = r.role_id "
                + "WHERE 1=1 ");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (u.full_name LIKE ? OR u.email LIKE ? OR u.username LIKE ?) ");
            String wildcardKeyword = "%" + keyword.trim() + "%";
            params.add(wildcardKeyword);
            params.add(wildcardKeyword);
            params.add(wildcardKeyword);
        }
        if (roleIdFilter != null && roleIdFilter > 0) {
            sql.append("AND u.role_id = ? ");
            params.add(roleIdFilter);
        }
        if (statusFilter != null && !statusFilter.equalsIgnoreCase("all")) {
            sql.append("AND u.status = ? ");
            params.add(statusFilter);
        }

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public boolean addNew(Users user) {
        String sql = "INSERT INTO users (username, password, full_name, email, role_id, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setInt(5, user.getRoleId());
            ps.setString(6, user.getStatus() != null ? user.getStatus() : "active");

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Users getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Users u = new Users();
                    u.setUserId(rs.getInt("user_id"));
                    u.setUsername(rs.getString("username"));
                    u.setPassword(rs.getString("password"));
                    u.setFullName(rs.getString("full_name"));
                    u.setEmail(rs.getString("email"));
                    u.setRoleId(rs.getInt("role_id"));
                    u.setStatus(rs.getString("status"));
                    return u;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Users getUserByEmail(String email) {
        try {
            String sql = "SELECT * FROM users WHERE email = ?";
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Users u = new Users();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setFullName(rs.getString("full_name"));
                u.setRoleId(rs.getInt("role_id"));
                u.setStatus(rs.getString("status"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Users getUserById(int userId) {
        try {
            String sql = "SELECT * FROM users WHERE user_id = ?";
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Users u = new Users();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setRoleId(rs.getInt("role_id"));
                u.setStatus(rs.getString("status"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updatePassword(int userId, String newPass) {
        try {
            String sql = "UPDATE users SET password=? WHERE user_id=?";
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, newPass);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void updateUserRole(int userId, int newRoleId) {
        String sql = "UPDATE users SET role_id = ? WHERE user_id = ?";

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, newRoleId);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean updateProfile(int userId, String fullName, String email) {
        String sql = "UPDATE users SET full_name = ?, email = ? WHERE user_id = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setInt(3, userId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateProfilebyAdmin(int userId, String username, String fullName, String email) {
        String sql = "UPDATE users SET username = ?, full_name = ?, email = ? WHERE user_id = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, fullName);
            ps.setString(3, email);
            ps.setInt(4, userId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public String updateStatus(int userId, String newStatus) throws java.sql.SQLException {
        String username = null;

        String selectSql = "SELECT username FROM users WHERE user_id = ?";
        try (Connection con = DBContext.getConnection(); PreparedStatement psSelect = con.prepareStatement(selectSql)) {

            psSelect.setInt(1, userId);
            try (java.sql.ResultSet rs = psSelect.executeQuery()) {
                if (rs.next()) {
                    username = rs.getString("username");
                } else {
                    return null;
                }
            }
        }

        String updateSql = "UPDATE users SET status = ? WHERE user_id = ?";
        try (Connection con = DBContext.getConnection(); PreparedStatement psUpdate = con.prepareStatement(updateSql)) {

            psUpdate.setString(1, newStatus);
            psUpdate.setInt(2, userId);

            int rowsAffected = psUpdate.executeUpdate();

            if (rowsAffected > 0) {
                return username;
            } else {
                return null;
            }
        }
    }

    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    /**
     * Get email of first active Admin for notifications
     */
    public String getAdminEmail() {
        String sql = "SELECT email FROM users WHERE role_id = 1 AND status = 'active' LIMIT 1";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("email");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Update password_changed_at timestamp when password changes Used to
     * invalidate all active sessions
     */
    public boolean updatePasswordChangedAt(int userId) {
        String sql = "UPDATE users SET password_changed_at = CURRENT_TIMESTAMP WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get password_changed_at timestamp for session validation
     */
    public java.sql.Timestamp getPasswordChangedAt(int userId) {
        String sql = "SELECT password_changed_at FROM users WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getTimestamp("password_changed_at");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Test method
    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();

        System.out.println("=== Testing ===");
        List<Users> allUsers = userDAO.getListUsers();
        System.out.println("Found " + allUsers.size() + " Users:");
        for (Users user : allUsers) {
            System.out.println(user);
        }
    }
}
