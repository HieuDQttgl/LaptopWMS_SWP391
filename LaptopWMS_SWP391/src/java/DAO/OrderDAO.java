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
        return getListOrders(null, null, null, null, null, null, "order_id", "ASC", 0, Integer.MAX_VALUE);
    }

    public List<Order> getListOrders(
            String keyword,
            String statusFilter,
            Integer createdByFilter,
            String startDateFilter,
            String endDateFilter,
            String orderTypeFilter) {
        return getListOrders(keyword, statusFilter, createdByFilter, startDateFilter, endDateFilter, orderTypeFilter, "order_id", "ASC", 0, Integer.MAX_VALUE);
    }

// Main method with filters, sorting, and pagination
    public List<Order> getListOrders(
            String keyword,
            String statusFilter,
            Integer createdByFilter,
            String startDateFilter,
            String endDateFilter,
            String orderTypeFilter,
            String sortField,
            String sortOrder,
            int offset,
            int limit) {

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

        // Add sorting
        String safeSortField = (sortField != null && !sortField.isEmpty()) ? sortField : "order_id";
        String safeSortOrder = (sortOrder != null && sortOrder.equalsIgnoreCase("DESC")) ? "DESC" : "ASC";

        // Map sort fields to actual database columns
        String finalSortField;
        switch (safeSortField) {
            case "customer_name":
                finalSortField = "c.customer_name";
                break;
            case "supplier_name":
                finalSortField = "s.supplier_name";
                break;
            case "created_by_name":
                finalSortField = "u.full_name";
                break;
            default:
                finalSortField = "o." + safeSortField;
                break;
        }

        sql.append(String.format(" ORDER BY %s %s", finalSortField, safeSortOrder));

        // Add pagination
        sql.append(" LIMIT ? OFFSET ?");

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ps.setInt(params.size() + 1, limit);
            ps.setInt(params.size() + 2, offset);

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
    
        public int getTotalOrders(
            String keyword,
            String statusFilter,
            Integer createdByFilter,
            String startDateFilter,
            String endDateFilter,
            String orderTypeFilter) {

        int total = 0;
        List<Object> params = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) "
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
        boolean success = false;

        String sqlOrder = "INSERT INTO orders (order_code, customer_id, supplier_id, description, order_status, created_by, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        String sqlDetail = "INSERT INTO order_products (order_id, product_detail_id, quantity, unit_price) "
                + "VALUES (?, ?, ?, ?)";

        try {
            conn = getConnection();
            String newOrderCode = generateNewOrderCode(conn, order);
            order.setOrderCode(newOrderCode);

            conn.setAutoCommit(false);

            try (PreparedStatement psOrder = conn.prepareStatement(sqlOrder, PreparedStatement.RETURN_GENERATED_KEYS)) {
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
                psOrder.setTimestamp(7, new java.sql.Timestamp(System.currentTimeMillis()));

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
                    try (PreparedStatement psDetail = conn.prepareStatement(sqlDetail)) {
                        for (OrderProduct detail : details) {
                            psDetail.setInt(1, newOrderId);
                            psDetail.setInt(2, detail.getProductDetailId());
                            psDetail.setInt(3, detail.getQuantity());
                            psDetail.setBigDecimal(4, detail.getUnitPrice());
                            psDetail.addBatch();
                        }
                        psDetail.executeBatch();
                    }
                }

                conn.commit();
                success = true;
                System.out.println("✅ Order created successfully: " + order.getOrderCode());

            } catch (SQLException e) {
                if (conn != null) {
                    System.err.println("⚠️ Error detected! Rolling back transaction...");
                    conn.rollback();
                }
                throw e;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
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

    public String updateOrderStatus(int orderId, String newStatus) throws java.sql.SQLException {
        String orderCode = null;

        String selectSql = "SELECT order_code FROM orders WHERE order_id = ?";
        try (Connection con = DBContext.getConnection(); PreparedStatement psSelect = con.prepareStatement(selectSql)) {

            psSelect.setInt(1, orderId);
            try (java.sql.ResultSet rs = psSelect.executeQuery()) {
                if (rs.next()) {
                    orderCode = rs.getString("order_code");
                } else {
                    return null;
                }
            }
        }

        String updateSql = "UPDATE orders SET order_status = ? WHERE order_id = ?";
        try (Connection con = DBContext.getConnection(); PreparedStatement psUpdate = con.prepareStatement(updateSql)) {

            psUpdate.setString(1, newStatus);
            psUpdate.setInt(2, orderId);

            int rowsAffected = psUpdate.executeUpdate();

            if (rowsAffected > 0) {
                return orderCode;
            } else {
                return null;
            }
        }
    }
}
