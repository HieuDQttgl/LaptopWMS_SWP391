package DAO;

import DTO.OrderDTO;
import DTO.OrderSummary;
import Model.Order;
import Model.OrderProduct;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;

public class OrderDAO extends DBContext {

    public List<Order> getListOrders() {
        return getListOrders(null, null, null, null, null, null);
    }

    public List<Order> getListOrders(
            String keyword,
            String statusFilter,
            Integer createdByFilter,
            String startDateFilter,
            String endDateFilter,
            String orderTypeFilter) {

        List<Order> orders = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT o.*, c.customer_name, s.supplier_name, u.full_name AS created_by_name "
                + "FROM orders o "
                + "LEFT JOIN customers c ON o.customer_id = c.customer_id "
                + "LEFT JOIN suppliers s ON o.supplier_id = s.supplier_id "
                + "JOIN users u ON o.created_by = u.user_id "
                + "WHERE 1=1 "
        );

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (o.order_code LIKE ? OR c.customer_name LIKE ? OR s.supplier_name LIKE ?) ");
            String wildcardKeyword = "%" + keyword.trim() + "%";
            params.add(wildcardKeyword);
            params.add(wildcardKeyword);
            params.add(wildcardKeyword);
        }

        if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equalsIgnoreCase("all")) {
            sql.append("AND o.order_status = ? ");
            params.add(statusFilter);
        }

        if (createdByFilter != null && createdByFilter > 0) {
            sql.append("AND o.created_by = ? ");
            params.add(createdByFilter);
        }

        if (startDateFilter != null && !startDateFilter.isEmpty()) {
            sql.append("AND DATE(o.created_at) >= ? ");
            params.add(startDateFilter);
        }

        if (endDateFilter != null && !endDateFilter.isEmpty()) {
            sql.append("AND DATE(o.created_at) <= ? ");
            params.add(endDateFilter);
        }

        if (orderTypeFilter != null && !orderTypeFilter.isEmpty() && !orderTypeFilter.equalsIgnoreCase("all")) {
            if (orderTypeFilter.equalsIgnoreCase("EXPORT")) {
                sql.append("AND o.customer_id IS NOT NULL ");
            } else if (orderTypeFilter.equalsIgnoreCase("IMPORT")) {
                sql.append("AND o.supplier_id IS NOT NULL ");
            }
        }

        sql.append(" ORDER BY o.order_id ASC");

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setOrderCode(rs.getString("order_code"));
                    order.setDescription(rs.getString("description"));
                    order.setOrderStatus(rs.getString("order_status"));
                    order.setCreatedAt(rs.getTimestamp("created_at"));
                    order.setUpdatedAt(rs.getTimestamp("updated_at"));
                    order.setCreatedBy(rs.getInt("created_by"));
                    int customerId = rs.getInt("customer_id");
                    if (!rs.wasNull()) {
                        order.setCustomerId(customerId);
                    }
                    int supplierId = rs.getInt("supplier_id");
                    if (!rs.wasNull()) {
                        order.setSupplierId(supplierId);
                    }
                    order.setCustomerName(rs.getString("customer_name"));
                    order.setSupplierName(rs.getString("supplier_name"));
                    order.setCreatedByName(rs.getString("created_by_name"));

                    orders.add(order);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    public Order getOrderById(int orderId) {
        Order order = null;

        String SQL = "SELECT "
                + "o.*, "
                + "c.customer_name, "
                + "s.supplier_name, "
                + "u.full_name AS created_by_name "
                + "FROM orders o "
                + "LEFT JOIN customers c ON o.customer_id = c.customer_id "
                + "LEFT JOIN suppliers s ON o.supplier_id = s.supplier_id "
                + "LEFT JOIN users u ON o.created_by = u.user_id "
                + "WHERE o.order_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(SQL)) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setOrderCode(rs.getString("order_code"));
                    order.setDescription(rs.getString("description"));
                    order.setOrderStatus(rs.getString("order_status"));
                    order.setCreatedAt(rs.getTimestamp("created_at"));
                    order.setUpdatedAt(rs.getTimestamp("updated_at"));
                    order.setCreatedBy(rs.getInt("created_by"));

                    int customerId = rs.getInt("customer_id");
                    if (!rs.wasNull()) {
                        order.setCustomerId(customerId);
                    }

                    int supplierId = rs.getInt("supplier_id");
                    if (!rs.wasNull()) {
                        order.setSupplierId(supplierId);
                    }

                    order.setCustomerName(rs.getString("customer_name"));
                    order.setSupplierName(rs.getString("supplier_name"));
                    order.setCreatedByName(rs.getString("created_by_name"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

    public OrderSummary getOrderSummary(int customerId) {
        String sql = """
        SELECT COUNT(DISTINCT o.order_id) AS total_orders,
               COALESCE(SUM(op.quantity * op.unit_price), 0) AS total_value,
               MAX(o.created_at) AS last_order_date
        FROM orders o
        LEFT JOIN order_products op ON o.order_id = op.order_id
        WHERE o.customer_id = ?
    """;

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                OrderSummary s = new OrderSummary();
                s.setTotalOrders(rs.getInt("total_orders"));
                s.setTotalValue(rs.getDouble("total_value"));
                s.setLastOrderDate(rs.getTimestamp("last_order_date"));
                return s;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<OrderDTO> getRecentOrders(int customerId, int limit) {
        List<OrderDTO> list = new ArrayList<>();

        String sql = """
        SELECT o.order_id,
               o.order_code,
               o.order_status,
               o.created_at,
               COALESCE(SUM(op.quantity * op.unit_price), 0) AS total_amount
        FROM orders o
        LEFT JOIN order_products op ON o.order_id = op.order_id
        WHERE o.customer_id = ?
        GROUP BY o.order_id, o.order_code, o.order_status, o.created_at
        ORDER BY o.created_at DESC
        LIMIT ?
    """;

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderDTO o = new OrderDTO();
                o.setOrderId(rs.getInt("order_id"));
                o.setOrderCode(rs.getString("order_code"));
                o.setOrderStatus(rs.getString("order_status"));
                o.setCreatedAt(rs.getTimestamp("created_at"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addOrder(Order order, List<OrderProduct> details) {
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psDetail = null;
        boolean success = false;

        String sqlOrder = "INSERT INTO orders (order_code, customer_id, supplier_id, description, order_status, created_by, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        String sqlDetail = "INSERT INTO order_products (order_id, product_id, quantity, unit_price) "
                + "VALUES (?, ?, ?, ?)";

        try {
            conn = getConnection();

            String newOrderCode = generateNewOrderCode(conn, order);
            order.setOrderCode(newOrderCode);

            conn.setAutoCommit(false);

            psOrder = conn.prepareStatement(sqlOrder, PreparedStatement.RETURN_GENERATED_KEYS);

            psOrder.setString(1, order.getOrderCode());

            if (order.getCustomerId() != null && order.getCustomerId() > 0) {
                psOrder.setInt(2, order.getCustomerId());
                psOrder.setNull(3, java.sql.Types.INTEGER);
            } else if (order.getSupplierId() != null && order.getSupplierId() > 0) {
                psOrder.setNull(2, java.sql.Types.INTEGER);
                psOrder.setInt(3, order.getSupplierId());
            } else {
                psOrder.setNull(2, java.sql.Types.INTEGER);
                psOrder.setNull(3, java.sql.Types.INTEGER);
            }

            psOrder.setString(4, order.getDescription());
            psOrder.setString(5, order.getOrderStatus());
            psOrder.setInt(6, order.getCreatedBy());
            psOrder.setTimestamp(7, new java.sql.Timestamp(System.currentTimeMillis())); // created_at

            int affectedRows = psOrder.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }

            int newOrderId = -1;
            try (ResultSet generatedKeys = psOrder.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    newOrderId = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
            }

            if (newOrderId != -1 && details != null && !details.isEmpty()) {
                psDetail = conn.prepareStatement(sqlDetail);

                for (OrderProduct detail : details) {
                    psDetail.setInt(1, newOrderId);
                    psDetail.setInt(2, detail.getProductId());
                    psDetail.setInt(3, detail.getQuantity());
                    psDetail.setBigDecimal(4, detail.getUnitPrice());

                    psDetail.addBatch();
                }

                int[] results = psDetail.executeBatch();

                for (int result : results) {
                    if (result <= 0) {
                        throw new SQLException("Creating order details failed.");
                    }
                }
            }
            conn.commit();
            success = true;

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    System.err.print("Transaction is being rolled back");
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();

        } finally {
            try {
                if (psDetail != null) {
                    psDetail.close();
                }
                if (psOrder != null) {
                    psOrder.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return success;
    }

    private String generateNewOrderCode(Connection conn, Order order) throws SQLException {

        String prefix;
        String year = String.valueOf(java.time.Year.now());

        if (order.getCustomerId() != null && order.getCustomerId() > 0) {
            prefix = "EXP";
        } else {
            prefix = "IMP";
        }

        String searchPrefix = prefix + "-" + year;

        String sqlMax = "SELECT MAX(SUBSTR(o.order_code, LENGTH(?) + 1)) "
                + "FROM orders o WHERE o.order_code LIKE ? AND YEAR(o.created_at) = ?";

        int lastNumber = 0;

        try (PreparedStatement psMax = conn.prepareStatement(sqlMax)) {
            psMax.setString(1, searchPrefix);
            psMax.setString(2, searchPrefix + "%");
            psMax.setString(3, year);

            try (ResultSet rs = psMax.executeQuery()) {
                if (rs.next()) {
                    String maxCodeSuffix = rs.getString(1);
                    if (maxCodeSuffix != null && !maxCodeSuffix.trim().isEmpty()) {
                        try {
                            lastNumber = Integer.parseInt(maxCodeSuffix.trim());
                        } catch (NumberFormatException e) {
                            System.err.println("Error parsing order code suffix: " + maxCodeSuffix);
                        }
                    }
                }
            }
        }

        int newNumber = lastNumber + 1;
        String formattedNumber = String.format("%03d", newNumber);

        return searchPrefix + formattedNumber;
    }
    
    public static void main(String[] args) {
        OrderDAO orderDAO = new OrderDAO();
        System.out.println("--- Bắt đầu Test OrderDAO.addOrder ---");
        
        try {
            // 1. Tạo đối tượng Order (Đơn hàng Export/Xuất Hàng)
            Order newOrder = createTestOrder();
            
            // 2. Tạo danh sách Chi tiết Đơn hàng
            List<OrderProduct> details = createTestOrderDetails();
            
            // 3. Thực hiện thêm đơn hàng
            boolean success = orderDAO.addOrder(newOrder, details);
            
            if (success) {
                System.out.println("\n✅ TEST THÀNH CÔNG!");
                System.out.println("Đơn hàng đã được thêm thành công vào DB.");
                System.out.println("Mã Đơn hàng: " + newOrder.getOrderCode());
            } else {
                System.out.println("\n❌ TEST THẤT BẠI.");
                System.out.println("Kiểm tra lại Console/Log để xem chi tiết SQLException.");
            }
            
        } catch (Exception e) {
            System.out.println("\n🚨 ĐÃ XẢY RA NGOẠI LỆ KHI THỰC HIỆN TEST:");
            e.printStackTrace();
        }
    }
    
    private static Order createTestOrder() {
        Order order = new Order();
        
        order.setCustomerId(1);
        order.setSupplierId(0);
        
        order.setDescription("Đơn hàng test tự động từ Main.");
        order.setOrderStatus("Pending"); 
        order.setCreatedBy(1);   
        
        return order;
    }

    private static List<OrderProduct> createTestOrderDetails() {
        List<OrderProduct> details = new ArrayList<>();
        
        OrderProduct detail1 = new OrderProduct();
        detail1.setProductId(1);
        detail1.setQuantity(2);
        detail1.setUnitPrice(new BigDecimal("5000.50"));
        details.add(detail1);

        OrderProduct detail2 = new OrderProduct();
        detail2.setProductId(5);
        detail2.setQuantity(1);
        detail2.setUnitPrice(new BigDecimal("1250.00")); 
        details.add(detail2);
        
        return details;
    }
}
