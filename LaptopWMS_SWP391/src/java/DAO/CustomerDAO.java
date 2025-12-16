/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class CustomerDAO extends DBContext {

    public List<Customer> getCustomers(
            String keyword,
            String status,
            String sortField,
            String sortOrder,
            int page,
            int pageSize) {

        List<Customer> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        String sql = """
        SELECT *
        FROM customers
        WHERE 1=1
    """;

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isBlank()) {
            sql += " AND (customer_name LIKE ? OR email LIKE ? OR phone LIKE ?)";
            String k = "%" + keyword + "%";
            params.add(k);
            params.add(k);
            params.add(k);
        }

        if (status != null && !status.equals("all")) {
            sql += " AND status = ?";
            params.add(status);
        }

        Set<String> allowed = Set.of(
                "customer_id", "customer_name", "email", "phone", "status"
        );
        if (!allowed.contains(sortField)) {
            sortField = "customer_id";
        }
        if (!"ASC".equalsIgnoreCase(sortOrder)
                && !"DESC".equalsIgnoreCase(sortOrder)) {
            sortOrder = "ASC";
        }

        sql += " ORDER BY " + sortField + " " + sortOrder;
        sql += " LIMIT ? OFFSET ?";

        params.add(pageSize);
        params.add(offset);

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customer ctm = new Customer();
                ctm.setCustomerId(rs.getInt("customer_id"));
                ctm.setCustomerName(rs.getString("customer_name"));
                ctm.setEmail(rs.getString("email"));
                ctm.setPhone(rs.getString("phone"));
                ctm.setAddress(rs.getString("address"));
                list.add(ctm);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Customer getCustomerById(int customerId) {

        String sql = """
        SELECT
            customer_id,
            customer_name,
            email,
            phone,
            address
        FROM customers
        WHERE customer_id = ?
    """;

        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Customer ctm = new Customer();
                ctm.setCustomerId(rs.getInt("customer_id"));
                ctm.setCustomerName(rs.getString("customer_name"));
                ctm.setEmail(rs.getString("email"));
                ctm.setPhone(rs.getString("phone"));
                ctm.setAddress(rs.getString("address"));

                return ctm;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public int countCustomers(String keyword, String status) {
        String sql = "SELECT COUNT(*) FROM customers WHERE 1=1";
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isBlank()) {
            sql += " AND (customer_name LIKE ? OR email LIKE ? OR phone LIKE ?)";
            String k = "%" + keyword + "%";
            params.add(k);
            params.add(k);
            params.add(k);
        }

        if (status != null && !status.equals("all")) {
            sql += " AND status = ?";
            params.add(status);
        }

        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Customer> getListCustomers() {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT customer_id, customer_name FROM customers";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customer ctm = new Customer();
                ctm.setCustomerId(rs.getInt("customer_id"));
                ctm.setCustomerName(rs.getString("customer_name"));
                list.add(ctm);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public static void main(String[] args) {
        CustomerDAO customerDAO = new CustomerDAO();

        System.out.println("=== Testing ===");
        List<Customer> allUsers = customerDAO.getListCustomers();
        System.out.println("Found " + allUsers.size() + " Customers:");
        for (Customer user : allUsers) {
            System.out.println(user);
        }
    }

}
