package DAO;

import Model.Users;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;

public class UserDAO extends DBContext {
    
    public List<Users> getListUsers(){
        List<Users> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()){
                while (rs.next()) {
                    int userId = rs.getInt("user_id");
                    String username = rs.getString("username");
                    String password = rs.getString("password");
                    String fullname = rs.getString("full_name");
                    String email = rs.getString("email");
                    String phonenumber = rs.getString("phone_number");
                    String gender = rs.getString("gender");
                    int roleId = rs.getInt("role_id");
                    String status = rs.getString("status");
                    Timestamp lastloginat = rs.getTimestamp("last_login_at");
                    Timestamp createdat = rs.getTimestamp("created_at");
                    Timestamp updatedat = rs.getTimestamp("updated_at");
                    Integer createdby =rs.getObject("created_by", Integer.class);
                    
                    Users user = new Users(
                    userId, username, password, fullname, email, phonenumber, 
                    gender, roleId, status, lastloginat, 
                    createdat, updatedat, createdby
                );
                
                users.add(user);
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    public Users findByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
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
    
    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();

        System.out.println("=== Testing listAllRooms ===");
        List<Users> allUsers = userDAO.getListUsers();
        System.out.println("Tìm thấy " + allUsers.size() + " Users:");
        for (Users user : allUsers) {
            System.out.println(user);
        }
    }
}


