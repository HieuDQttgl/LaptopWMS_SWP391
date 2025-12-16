package DAO;

import Model.Supplier;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class SupplierDAO extends DBContext {

    public List<Supplier> getListSuppliers() {
        return getListSuppliers(null, null, "supplier_id", "ASC");
    }

    public List<Supplier> getListSuppliers(
            String keyword,
            String statusFilter,
            String sortField,
            String sortOrder) {

        List<Supplier> suppliers = new ArrayList<>();

        // Validate sort parameters
        String safeSortField = (sortField == null || sortField.isEmpty()) ? "supplier_id" : sortField;
        String safeSortOrder = (sortOrder == null || sortOrder.isEmpty()
                || !sortOrder.toUpperCase().matches("ASC|DESC"))
                        ? "ASC"
                        : sortOrder.toUpperCase();

        // Whitelist allowed sort fields to prevent SQL injection
        String[] allowedFields = { "supplier_id", "supplier_name", "supplier_email", "supplier_phone", "status" };
        boolean isValidField = false;
        for (String field : allowedFields) {
            if (field.equals(safeSortField)) {
                isValidField = true;
                break;
            }
        }
        if (!isValidField) {
            safeSortField = "supplier_id";
        }

        String sql = "SELECT * FROM suppliers WHERE 1=1 ";

        List<Object> params = new ArrayList<>();

        // Add keyword search
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += "AND (supplier_name LIKE ? OR supplier_email LIKE ? OR supplier_phone LIKE ?) ";
            String wildcardKeyword = "%" + keyword.trim() + "%";
            params.add(wildcardKeyword);
            params.add(wildcardKeyword);
            params.add(wildcardKeyword);
        }

        // Add status filter
        if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equalsIgnoreCase("all")) {
            sql += "AND status = ? ";
            params.add(statusFilter);
        }

        sql += String.format(" ORDER BY %s %s", safeSortField, safeSortOrder);

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Supplier supplier = mapResultSetToSupplier(rs);
                    suppliers.add(supplier);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return suppliers;
    }


    public List<Supplier> getListSuppliers(
            String keyword,
            String statusFilter,
            String sortField,
            String sortOrder,
            int offset,
            int limit) {

        List<Supplier> suppliers = new ArrayList<>();

        // Validate sort parameters
        String safeSortField = (sortField == null || sortField.isEmpty()) ? "supplier_id" : sortField;
        String safeSortOrder = (sortOrder == null || sortOrder.isEmpty()
                || !sortOrder.toUpperCase().matches("ASC|DESC"))
                        ? "ASC"
                        : sortOrder.toUpperCase();

        // Whitelist allowed sort fields to prevent SQL injection
        String[] allowedFields = { "supplier_id", "supplier_name", "supplier_email", "supplier_phone", "status" };
        boolean isValidField = false;
        for (String field : allowedFields) {
            if (field.equals(safeSortField)) {
                isValidField = true;
                break;
            }
        }
        if (!isValidField) {
            safeSortField = "supplier_id";
        }

        String sql = "SELECT * FROM suppliers WHERE 1=1 ";

        List<Object> params = new ArrayList<>();

        // Add keyword search
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += "AND (supplier_name LIKE ? OR supplier_email LIKE ? OR supplier_phone LIKE ?) ";
            String wildcardKeyword = "%" + keyword.trim() + "%";
            params.add(wildcardKeyword);
            params.add(wildcardKeyword);
            params.add(wildcardKeyword);
        }

        // Add status filter
        if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equalsIgnoreCase("all")) {
            sql += "AND status = ? ";
            params.add(statusFilter);
        }

        sql += String.format(" ORDER BY %s %s LIMIT ? OFFSET ?", safeSortField, safeSortOrder);
        params.add(limit);
        params.add(offset);

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Supplier supplier = mapResultSetToSupplier(rs);
                    suppliers.add(supplier);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return suppliers;
    }


    public int getTotalSuppliers(String keyword, String statusFilter) {
        String sql = "SELECT COUNT(*) FROM suppliers WHERE 1=1 ";
        List<Object> params = new ArrayList<>();

        // Add keyword search
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += "AND (supplier_name LIKE ? OR supplier_email LIKE ? OR supplier_phone LIKE ?) ";
            String wildcardKeyword = "%" + keyword.trim() + "%";
            params.add(wildcardKeyword);
            params.add(wildcardKeyword);
            params.add(wildcardKeyword);
        }

        // Add status filter
        if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equalsIgnoreCase("all")) {
            sql += "AND status = ? ";
            params.add(statusFilter);
        }

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }


    public Supplier getSupplierById(int supplierId) {
        String sql = "SELECT * FROM suppliers WHERE supplier_id = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, supplierId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToSupplier(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public boolean addSupplier(Supplier supplier) {
        String sql = "INSERT INTO suppliers (supplier_name, supplier_email, supplier_phone, status) "
                + "VALUES (?, ?, ?, ?)";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, supplier.getSupplierName());
            ps.setString(2, supplier.getSupplierEmail());
            ps.setString(3, supplier.getSupplierPhone());
            ps.setString(4, supplier.getStatus() != null ? supplier.getStatus() : "active");

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        supplier.setSupplierId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    public boolean updateSupplier(Supplier supplier) {
        String sql = "UPDATE suppliers SET supplier_name = ?, supplier_email = ?, supplier_phone = ? "
                + "WHERE supplier_id = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, supplier.getSupplierName());
            ps.setString(2, supplier.getSupplierEmail());
            ps.setString(3, supplier.getSupplierPhone());
            ps.setInt(4, supplier.getSupplierId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    public String updateStatus(int supplierId, String newStatus) {
        String supplierName = null;

        // First get the supplier name
        String selectSql = "SELECT supplier_name FROM suppliers WHERE supplier_id = ?";
        try (Connection conn = getConnection();
                PreparedStatement psSelect = conn.prepareStatement(selectSql)) {

            psSelect.setInt(1, supplierId);
            try (ResultSet rs = psSelect.executeQuery()) {
                if (rs.next()) {
                    supplierName = rs.getString("supplier_name");
                } else {
                    return null;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        // Then update the status
        String updateSql = "UPDATE suppliers SET status = ? WHERE supplier_id = ?";
        try (Connection conn = getConnection();
                PreparedStatement psUpdate = conn.prepareStatement(updateSql)) {

            psUpdate.setString(1, newStatus);
            psUpdate.setInt(2, supplierId);

            if (psUpdate.executeUpdate() > 0) {
                return supplierName;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public boolean isSupplierNameExists(String supplierName) {
        String sql = "SELECT COUNT(*) FROM suppliers WHERE supplier_name = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, supplierName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return true; // Assume exists on error to prevent duplicates
        }
        return false;
    }


    public boolean isSupplierNameExists(String supplierName, int excludeSupplierId) {
        String sql = "SELECT COUNT(*) FROM suppliers WHERE supplier_name = ? AND supplier_id != ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, supplierName);
            ps.setInt(2, excludeSupplierId);
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


    public int getSupplierCount(String status) {
        String sql = "SELECT COUNT(*) FROM suppliers";
        if (status != null && !status.isEmpty()) {
            sql += " WHERE status = ?";
        }

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            if (status != null && !status.isEmpty()) {
                ps.setString(1, status);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }


    private Supplier mapResultSetToSupplier(ResultSet rs) throws Exception {
        Supplier supplier = new Supplier();
        supplier.setSupplierId(rs.getInt("supplier_id"));
        supplier.setSupplierName(rs.getString("supplier_name"));
        supplier.setSupplierEmail(rs.getString("supplier_email"));
        supplier.setSupplierPhone(rs.getString("supplier_phone"));
        supplier.setStatus(rs.getString("status"));
        return supplier;
    }


    public static void main(String[] args) {
        SupplierDAO supplierDAO = new SupplierDAO();

        System.out.println("=== Testing SupplierDAO ===\n");

        // Test: Get all suppliers
        System.out.println("1. Getting all suppliers:");
        List<Supplier> allSuppliers = supplierDAO.getListSuppliers();
        System.out.println("   Found " + allSuppliers.size() + " suppliers:");
        for (Supplier s : allSuppliers) {
            System.out.println("   - " + s.getSupplierName() + " (" + s.getStatus() + ")");
        }

        // Test: Get suppliers with filter
        System.out.println("\n2. Getting active suppliers only:");
        List<Supplier> activeSuppliers = supplierDAO.getListSuppliers(null, "active", "supplier_name", "ASC");
        System.out.println("   Found " + activeSuppliers.size() + " active suppliers");

        // Test: Search by keyword
        System.out.println("\n3. Searching for 'Dell':");
        List<Supplier> searchResults = supplierDAO.getListSuppliers("Dell", null, "supplier_id", "ASC");
        System.out.println("   Found " + searchResults.size() + " results");

        // Test: Get by ID
        if (!allSuppliers.isEmpty()) {
            int testId = allSuppliers.get(0).getSupplierId();
            System.out.println("\n4. Getting supplier by ID (" + testId + "):");
            Supplier singleSupplier = supplierDAO.getSupplierById(testId);
            if (singleSupplier != null) {
                System.out.println("   " + singleSupplier);
            }
        }

        // Test: Count
        System.out.println("\n5. Supplier counts:");
        System.out.println("   Total: " + supplierDAO.getSupplierCount(null));
        System.out.println("   Active: " + supplierDAO.getSupplierCount("active"));
        System.out.println("   Inactive: " + supplierDAO.getSupplierCount("inactive"));

        System.out.println("\n=== Tests completed ===");
    }
}
