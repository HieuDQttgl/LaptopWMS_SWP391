package DAO;

import Model.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO extends DBContext {

    public List<Order> getListOrders() {
        return getListOrders(null, null, null, null, null);
    }

    public List<Order> getListOrders(
            String keyword,
            String statusFilter,
            Integer createdByFilter,
            String startDateFilter,
            String endDateFilter) {

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

        sql.append(" ORDER BY o.order_id ASC");

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            // Thiết lập tất cả các tham số
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
}
