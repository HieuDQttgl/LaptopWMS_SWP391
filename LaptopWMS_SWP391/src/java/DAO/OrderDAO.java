package DAO;

import DTO.OrderDTO;
import DTO.OrderSummary;
import Model.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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

}
