package DAO;

import Model.Users;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;

public class UserDAO extends DBContext {

    public List<Users> getListUsers() {
        return getListUsers(null, null, null, null, "user_id", "ASC");
    }

    public List<Users> getListUsers(
            String keyword,
            String genderFilter,
            Integer roleIdFilter,
            String statusFilter,
            String sortField,
            String sortOrder) {

        List<Users> users = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT u.*, r.role_name "
                        + "FROM users u JOIN roles r ON u.role_id = r.role_id "
                        + "WHERE 1=1 ");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (u.full_name LIKE ? OR u.email LIKE ? OR u.phone_number LIKE ?) ");
            String wildcardKeyword = "%" + keyword.trim() + "%";
            params.add(wildcardKeyword);
            params.add(wildcardKeyword);
            params.add(wildcardKeyword);
        }

        if (genderFilter != null && !genderFilter.equalsIgnoreCase("all")) {
            sql.append("AND u.gender = ? ");
            params.add(genderFilter);
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

        sql.append(String.format("ORDER BY %s %s", finalSortField, safeSortOrder));

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Users user = new Users(
                            rs.getInt("user_id"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getString("full_name"),
                            rs.getString("email"),
                            rs.getString("phone_number"),
                            rs.getString("gender"),
                            rs.getInt("role_id"),
                            rs.getString("status"),
                            rs.getTimestamp("last_login_at"),
                            rs.getTimestamp("created_at"),
                            rs.getTimestamp("updated_at"),
                            rs.getObject("created_by", Integer.class));
                    user.setRoleName(rs.getString("role_name"));

                    users.add(user);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    public boolean addNew(Users user) {
        String sql = "INSERT INTO users (username, password, full_name, email, phone_number, gender, role_id, status, created_at, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhoneNumber());
            ps.setString(6, user.getGender());
            ps.setInt(7, user.getRoleId());
            ps.setString(8, user.getStatus() != null ? user.getStatus() : "active");
            ps.setObject(9, user.getCreatedBy());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Users findByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Users u = new Users();
                    u.setUserId(rs.getInt("user_id"));
                    u.setUsername(rs.getString("username"));
                    u.setPassword(rs.getString("password"));
                    u.setFullName(rs.getString("full_name"));
                    u.setEmail(rs.getString("email"));
                    u.setPhoneNumber(rs.getString("phone_number"));
                    u.setGender(rs.getString("gender"));
                    u.setRoleId(rs.getInt("role_id"));
                    u.setStatus(rs.getString("status"));
                    u.setLastLoginAt(rs.getTimestamp("last_login_at"));
                    u.setCreatedAt(rs.getTimestamp("created_at"));
                    u.setUpdatedAt(rs.getTimestamp("updated_at"));
                    Integer createdBy = (Integer) rs.getObject("created_by");
                    u.setCreatedBy(createdBy);
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
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
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
                u.setPhoneNumber(rs.getString("phone_number"));
                u.setGender(rs.getString("gender"));
                u.setRoleId(rs.getInt("role_id"));
                u.setStatus(rs.getString("status"));
                u.setLastLoginAt(rs.getTimestamp("last_login_at"));
                u.setCreatedAt(rs.getTimestamp("created_at"));
                u.setUpdatedAt(rs.getTimestamp("updated_at"));
                Integer createdBy = (Integer) rs.getObject("created_by");
                u.setCreatedBy(createdBy);
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

    public boolean updateProfile(int userId, String fullName, String email, String phoneNumber, String gender) {
        String sql = "UPDATE users SET full_name = ?, email = ?, phone_number = ?, gender = ?, updated_at = CURRENT_TIMESTAMP WHERE user_id = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phoneNumber);
            ps.setString(4, gender);
            ps.setInt(5, userId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateProfilebyAdmin(int userId, String username, String fullName, String email, String phoneNumber,
            String gender) {
        String sql = "UPDATE users SET username = ?, full_name = ?, email = ?, phone_number = ?, gender = ?, updated_at = CURRENT_TIMESTAMP WHERE user_id = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, fullName);
            ps.setString(3, email);
            ps.setString(4, phoneNumber);
            ps.setString(5, gender);
            ps.setInt(6, userId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateLastLogin(int userId) {
        String sql = "UPDATE users SET last_login_at = CURRENT_TIMESTAMP WHERE user_id = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
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
        String sql = "SELECT COUNT(*) FROM Users WHERE username = ?";
        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }
        return false;
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }
        return false;
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
