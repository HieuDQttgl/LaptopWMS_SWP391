package DAO;

import Model.Order;
import Model.Role;
import Model.ProductDetail;
import Model.ProductItem;
import Model.Users;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author super
 */
public class DashboardDAO extends DBContext {

    public List<ProductDetail> getTopAvailableProducts() {
        List<ProductDetail> list = new ArrayList<>();
        String sql = """
            SELECT pd.product_detail_id, p.product_name, pd.cpu, pd.ram, COUNT(pi.items_id) as real_stock
            FROM product_details pd
            JOIN products p ON pd.product_id = p.product_id
            JOIN product_items pi ON pd.product_detail_id = pi.product_detail_id
            WHERE pi.status = 'Available'
            GROUP BY pd.product_detail_id, p.product_name, pd.cpu, pd.ram
            ORDER BY real_stock DESC
            LIMIT 5
        """;
        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProductDetail d = new ProductDetail();
                d.setProductDetailId(rs.getInt("product_detail_id"));
                d.setCpu(rs.getString("product_name") + " (" + rs.getString("cpu") + ")");
                d.setRam(rs.getString("ram"));
                d.setQuantity(rs.getInt("real_stock"));
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getMyRecentOrders(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE created_by = ? ORDER BY created_at DESC LIMIT 5";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getInt("order_id"));
                    o.setOrderCode(rs.getString("order_code"));
                    o.setOrderStatus(rs.getString("order_status"));
                    o.setCustomerId(rs.getInt("customer_id"));
                    o.setSupplierId(rs.getInt("supplier_id"));
                    list.add(o);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductItem> getNewArrivals() {
        List<ProductItem> list = new ArrayList<>();
        String sql = """
            SELECT pi.items_id, pi.serial_number, pi.status, p.product_name 
            FROM product_items pi
            JOIN product_details pd ON pi.product_detail_id = pd.product_detail_id
            JOIN products p ON pd.product_id = p.product_id
            ORDER BY pi.items_id DESC LIMIT 5
        """;
        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProductItem item = new ProductItem();
                item.setItemId(rs.getInt("items_id"));
                item.setSerialNumber(rs.getString("serial_number"));
                item.setStatus(rs.getString("status"));
                item.setItemNote(rs.getString("product_name"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getPendingOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE order_status IN ('pending', 'approved') ORDER BY created_at ASC LIMIT 5";
        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("order_id"));
                o.setOrderCode(rs.getString("order_code"));
                o.setOrderStatus(rs.getString("order_status"));
                o.setCustomerId(rs.getInt("customer_id"));
                o.setSupplierId(rs.getInt("supplier_id"));
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductDetail> getLowStockAlerts(int threshold) {
        List<ProductDetail> list = new ArrayList<>();
        String sql = """
            SELECT pd.product_detail_id, p.product_name, COUNT(pi.items_id) as real_stock
            FROM product_details pd
            JOIN products p ON pd.product_id = p.product_id
            JOIN product_items pi ON pd.product_detail_id = pi.product_detail_id
            WHERE pi.status = 'Available'
            GROUP BY pd.product_detail_id, p.product_name
            HAVING COUNT(pi.items_id) < ?
            ORDER BY real_stock ASC LIMIT 5
        """;
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, threshold);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductDetail d = new ProductDetail();
                    d.setProductDetailId(rs.getInt("product_detail_id"));
                    d.setCpu(rs.getString("product_name"));
                    d.setQuantity(rs.getInt("real_stock"));
                    list.add(d);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductItem> getProblemItems() {
        List<ProductItem> list = new ArrayList<>();
        String sql = """
            SELECT pi.items_id, pi.serial_number, pi.status, pi.items_note, p.product_name 
            FROM product_items pi
            JOIN product_details pd ON pi.product_detail_id = pd.product_detail_id
            JOIN products p ON pd.product_id = p.product_id
            WHERE pi.status IN ('Damaged', 'Lost')
            LIMIT 5
        """;
        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProductItem item = new ProductItem();
                item.setItemId(rs.getInt("items_id"));
                item.setSerialNumber(rs.getString("serial_number"));
                item.setStatus(rs.getString("status"));
                item.setItemNote(rs.getString("items_note"));
                list.add(item);
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
        ORDER BY u.created_at DESC 
        LIMIT 5
    """;
        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Users u = new Users();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setStatus(rs.getString("status"));

                // This works because you added setRoleName() to your Users model
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
                r.setStatus(rs.getString("status"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
