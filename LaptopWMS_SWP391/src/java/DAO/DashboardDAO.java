package DAO;

import Model.Role;
import Model.ProductDetail;
import Model.Users;
import Model.Ticket;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * DashboardDAO - updated for laptop_wms_lite database
 *
 * @author super
 */
public class DashboardDAO extends DBContext {

    public List<ProductDetail> getTopAvailableProducts() {
        List<ProductDetail> list = new ArrayList<>();
        String sql = """
                    SELECT pd.product_detail_id, p.product_name, pd.cpu, pd.ram, pd.quantity
                    FROM product_details pd
                    JOIN products p ON pd.product_id = p.product_id
                    ORDER BY pd.quantity DESC
                    LIMIT 5
                """;
        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProductDetail d = new ProductDetail();
                d.setProductDetailId(rs.getInt("product_detail_id"));
                d.setCpu(rs.getString("product_name") + " (" + rs.getString("cpu") + ")");
                d.setRam(rs.getString("ram"));
                d.setQuantity(rs.getInt("quantity"));
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Ticket> getMyRecentTickets(int userId) {
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT * FROM tickets WHERE created_by = ? ORDER BY created_at DESC LIMIT 5";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ticket t = new Ticket();
                    t.setTicketId(rs.getInt("ticket_id"));
                    t.setTicketCode(rs.getString("ticket_code"));
                    t.setType(rs.getString("type"));
                    t.setTitle(rs.getString("title"));
                    t.setStatus(rs.getString("status"));
                    list.add(t);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Ticket> getPendingTickets() {
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT * FROM tickets WHERE status = 'PENDING' ORDER BY created_at ASC LIMIT 5";
        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Ticket t = new Ticket();
                t.setTicketId(rs.getInt("ticket_id"));
                t.setTicketCode(rs.getString("ticket_code"));
                t.setType(rs.getString("type"));
                t.setTitle(rs.getString("title"));
                t.setStatus(rs.getString("status"));
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    
    public List<Ticket> getPendingTicketsByKeeper(int keeperId) {
    List<Ticket> list = new ArrayList<>();
    // Thêm điều kiện assign_to_keeper_id = ? vào câu lệnh SQL
    String sql = "SELECT * FROM tickets WHERE status = 'PENDING' AND assigned_keeper = ? ORDER BY created_at ASC LIMIT 5";
    
    try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
        ps.setInt(1, keeperId);
        
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Ticket t = new Ticket();
                t.setTicketId(rs.getInt("ticket_id"));
                t.setTicketCode(rs.getString("ticket_code"));
                t.setType(rs.getString("type"));
                t.setTitle(rs.getString("title"));
                t.setStatus(rs.getString("status"));
                list.add(t);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
    public List<ProductDetail> getLowStockAlerts(int threshold) {
        List<ProductDetail> list = new ArrayList<>();
        String sql = """
                    SELECT pd.product_detail_id, p.product_name, pd.quantity
                    FROM product_details pd
                    JOIN products p ON pd.product_id = p.product_id
                    WHERE pd.quantity < ?
                    ORDER BY pd.quantity ASC LIMIT 5
                """;
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, threshold);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductDetail d = new ProductDetail();
                    d.setProductDetailId(rs.getInt("product_detail_id"));
                    d.setCpu(rs.getString("product_name"));
                    d.setQuantity(rs.getInt("quantity"));
                    list.add(d);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Users> getRecentUsers() {
        List<Users> list = new ArrayList<>();
        String sql = """
                    SELECT u.user_id, u.username, u.email, u.status, r.role_name
                    FROM users u
                    JOIN roles r ON u.role_id = r.role_id
                    ORDER BY u.user_id DESC
                    LIMIT 5
                """;
        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Users u = new Users();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setStatus(rs.getString("status"));
                u.setRoleName(rs.getString("role_name"));
                list.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Role> getRolesList() {
        List<Role> list = new ArrayList<>();
        String sql = "SELECT * FROM roles ORDER BY role_id ASC LIMIT 5";
        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Role r = new Role();
                r.setRoleId(rs.getInt("role_id"));
                r.setRoleName(rs.getString("role_name"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM products";
        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM users";
        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getPendingTicketCount() {
        String sql = "SELECT COUNT(*) FROM tickets WHERE status = 'PENDING'";
        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Ticket> getKeeperHistory(int keeperId) {
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT * FROM tickets "
                + "WHERE assigned_keeper = ? AND status != 'PENDING' "
                + "ORDER BY processed_at DESC LIMIT 5";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, keeperId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ticket t = new Ticket();
                    t.setTicketId(rs.getInt("ticket_id"));
                    t.setTicketCode(rs.getString("ticket_code"));
                    t.setType(rs.getString("type"));
                    t.setTitle(rs.getString("title"));
                    t.setStatus(rs.getString("status"));
                    list.add(t);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
