package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for generating inventory reports
 * Queries stock_ledger and product_details for report data
 */
public class ReportDAO extends DBContext {

    /**
     * Get inventory report data with optional date filters
     */
    public List<ReportItem> getInventoryReport(String startDate, String endDate, String type) {
        List<ReportItem> report = new ArrayList<>();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT ");
        sql.append("    p.product_name, ");
        sql.append("    CONCAT(pd.cpu, ' / ', pd.ram, ' / ', pd.storage) as config, ");
        sql.append("    pd.unit, ");
        sql.append("    pd.quantity as current_stock, ");
        sql.append(
                "    COALESCE(SUM(CASE WHEN sl.type = 'IMPORT' THEN sl.quantity_change ELSE 0 END), 0) as total_import, ");
        sql.append(
                "    COALESCE(SUM(CASE WHEN sl.type = 'EXPORT' THEN sl.quantity_change ELSE 0 END), 0) as total_export ");
        sql.append("FROM product_details pd ");
        sql.append("JOIN products p ON pd.product_id = p.product_id ");
        sql.append("LEFT JOIN stock_ledger sl ON pd.product_detail_id = sl.product_detail_id ");

        List<Object> params = new ArrayList<>();
        boolean hasDateFilter = false;

        // Add date filters
        if (startDate != null && !startDate.isEmpty()) {
            sql.append("AND sl.created_at >= ? ");
            params.add(startDate + " 00:00:00");
            hasDateFilter = true;
        }
        if (endDate != null && !endDate.isEmpty()) {
            sql.append("AND sl.created_at <= ? ");
            params.add(endDate + " 23:59:59");
            hasDateFilter = true;
        }
        if (type != null && !type.isEmpty() && !"all".equals(type)) {
            sql.append("AND sl.type = ? ");
            params.add(type);
        }

        sql.append("GROUP BY pd.product_detail_id, p.product_name, pd.cpu, pd.ram, pd.storage, pd.unit, pd.quantity ");
        sql.append("ORDER BY p.product_name, pd.product_detail_id");

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReportItem item = new ReportItem();
                    item.productName = rs.getString("product_name");
                    item.config = rs.getString("config");
                    item.unit = rs.getString("unit");
                    item.currentStock = rs.getInt("current_stock");
                    item.totalImport = rs.getInt("total_import");
                    item.totalExport = rs.getInt("total_export");
                    report.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return report;
    }

    /**
     * Get detailed stock ledger entries
     */
    public List<LedgerEntry> getStockLedger(String startDate, String endDate, String type) {
        List<LedgerEntry> entries = new ArrayList<>();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT ");
        sql.append("    sl.ledger_id, ");
        sql.append("    sl.created_at, ");
        sql.append("    sl.type, ");
        sql.append("    sl.quantity_change, ");
        sql.append("    sl.balance_after, ");
        sql.append("    p.product_name, ");
        sql.append("    CONCAT(pd.cpu, ' / ', pd.ram, ' / ', pd.storage) as config, ");
        sql.append("    t.ticket_code, ");
        sql.append("    t.title as ticket_title ");
        sql.append("FROM stock_ledger sl ");
        sql.append("JOIN product_details pd ON sl.product_detail_id = pd.product_detail_id ");
        sql.append("JOIN products p ON pd.product_id = p.product_id ");
        sql.append("JOIN tickets t ON sl.ticket_id = t.ticket_id ");
        sql.append("WHERE 1=1 ");

        List<Object> params = new ArrayList<>();

        if (startDate != null && !startDate.isEmpty()) {
            sql.append("AND sl.created_at >= ? ");
            params.add(startDate + " 00:00:00");
        }
        if (endDate != null && !endDate.isEmpty()) {
            sql.append("AND sl.created_at <= ? ");
            params.add(endDate + " 23:59:59");
        }
        if (type != null && !type.isEmpty() && !"all".equals(type)) {
            sql.append("AND sl.type = ? ");
            params.add(type);
        }

        sql.append("ORDER BY sl.created_at DESC");

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LedgerEntry entry = new LedgerEntry();
                    entry.ledgerId = rs.getInt("ledger_id");
                    entry.createdAt = rs.getTimestamp("created_at");
                    entry.type = rs.getString("type");
                    entry.quantityChange = rs.getInt("quantity_change");
                    entry.balanceAfter = rs.getInt("balance_after");
                    entry.productName = rs.getString("product_name");
                    entry.config = rs.getString("config");
                    entry.ticketCode = rs.getString("ticket_code");
                    entry.ticketTitle = rs.getString("ticket_title");
                    entries.add(entry);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return entries;
    }

    /**
     * Get summary statistics
     */
    public ReportSummary getSummary(String startDate, String endDate) {
        ReportSummary summary = new ReportSummary();

        String sql = "SELECT " +
                "COALESCE(SUM(CASE WHEN type = 'IMPORT' THEN quantity_change ELSE 0 END), 0) as total_import, " +
                "COALESCE(SUM(CASE WHEN type = 'EXPORT' THEN quantity_change ELSE 0 END), 0) as total_export, " +
                "COUNT(DISTINCT ticket_id) as total_transactions " +
                "FROM stock_ledger WHERE 1=1 " +
                (startDate != null && !startDate.isEmpty() ? "AND created_at >= ? " : "") +
                (endDate != null && !endDate.isEmpty() ? "AND created_at <= ? " : "");

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            int idx = 1;
            if (startDate != null && !startDate.isEmpty()) {
                ps.setString(idx++, startDate + " 00:00:00");
            }
            if (endDate != null && !endDate.isEmpty()) {
                ps.setString(idx++, endDate + " 23:59:59");
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    summary.totalImport = rs.getInt("total_import");
                    summary.totalExport = rs.getInt("total_export");
                    summary.totalTransactions = rs.getInt("total_transactions");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Get current total stock
        String stockSql = "SELECT COALESCE(SUM(quantity), 0) as total_stock FROM product_details";
        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(stockSql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                summary.totalStock = rs.getInt("total_stock");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return summary;
    }

    public static class ReportItem {
        public String productName;
        public String config;
        public String unit;
        public int currentStock;
        public int totalImport;
        public int totalExport;
    }

    public static class LedgerEntry {
        public int ledgerId;
        public java.sql.Timestamp createdAt;
        public String type;
        public int quantityChange;
        public int balanceAfter;
        public String productName;
        public String config;
        public String ticketCode;
        public String ticketTitle;
    }

    public static class ReportSummary {
        public int totalImport;
        public int totalExport;
        public int totalStock;
        public int totalTransactions;
    }
}
