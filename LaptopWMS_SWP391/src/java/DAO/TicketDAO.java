package DAO;

import static DAO.DBContext.getConnection;
import DTO.ImportReportDTO;
import Model.Ticket;
import Model.TicketItem;
import Model.Users;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class for Ticket operations Handles CRUD operations and business logic
 * for tickets
 */
public class TicketDAO extends DBContext {

    /**
     * Generate ticket code based on type and current date Format: IMP-DEC-001
     * or EXP-DEC-001
     */
    private String generateTicketCode(String type) {
        String prefix = type.equals("IMPORT") ? "IMP" : "EXP";
        String month = LocalDateTime.now().format(DateTimeFormatter.ofPattern("MMM")).toUpperCase();

        String sql = "SELECT COUNT(*) + 1 as next_num FROM tickets WHERE type = ? AND MONTH(created_at) = MONTH(CURRENT_DATE())";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setString(1, type);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int nextNum = rs.getInt("next_num");
                    return String.format("%s-%s-%03d", prefix, month, nextNum);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return prefix + "-" + month + "-001";
    }

    /**
     * Create a new ticket with items
     */
    public int createTicket(Ticket ticket) throws SQLException {
        Connection conn = null;
        PreparedStatement psTicket = null;
        PreparedStatement psItem = null;
        int ticketId = -1;

        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            // Generate ticket code
            String ticketCode = generateTicketCode(ticket.getType());

            // Insert ticket
            String sqlTicket = "INSERT INTO tickets (ticket_code, type, title, description, status, created_by, assigned_keeper, partner_id) "
                    + "VALUES (?, ?, ?, ?, 'PENDING', ?, ?, ?)";

            psTicket = conn.prepareStatement(sqlTicket, Statement.RETURN_GENERATED_KEYS);
            psTicket.setString(1, ticketCode);
            psTicket.setString(2, ticket.getType());
            psTicket.setString(3, ticket.getTitle());
            psTicket.setString(4, ticket.getDescription());
            psTicket.setInt(5, ticket.getCreatedBy());
            if (ticket.getAssignedKeeper() != null) {
                psTicket.setInt(6, ticket.getAssignedKeeper());
            } else {
                psTicket.setNull(6, java.sql.Types.INTEGER);
            }
            if (ticket.getPartnerId() != null) {
                psTicket.setInt(7, ticket.getPartnerId());
            } else {
                psTicket.setNull(7, java.sql.Types.INTEGER);
            }

            psTicket.executeUpdate();

            try (ResultSet rs = psTicket.getGeneratedKeys()) {
                if (rs.next()) {
                    ticketId = rs.getInt(1);
                }
            }

            // Insert ticket items
            if (ticketId > 0 && ticket.getItems() != null && !ticket.getItems().isEmpty()) {
                String sqlItem = "INSERT INTO ticket_items (ticket_id, product_detail_id, quantity) VALUES (?, ?, ?)";
                psItem = conn.prepareStatement(sqlItem);

                for (TicketItem item : ticket.getItems()) {
                    psItem.setInt(1, ticketId);
                    psItem.setInt(2, item.getProductDetailId());
                    psItem.setInt(3, item.getQuantity());
                    psItem.addBatch();
                }
                psItem.executeBatch();
            }

            conn.commit();
            return ticketId;

        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (psItem != null) {
                psItem.close();
            }
            if (psTicket != null) {
                psTicket.close();
            }
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    /**
     * Get all tickets with optional filters
     */
    public List<Ticket> getAllTickets(String status, String type, String partnerSearch) {
        List<Ticket> tickets = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT t.*, "
                + "u1.full_name as creator_name, "
                + "u2.full_name as keeper_name, "
                + "p.partner_name "
                + "FROM tickets t "
                + "LEFT JOIN users u1 ON t.created_by = u1.user_id "
                + "LEFT JOIN users u2 ON t.assigned_keeper = u2.user_id "
                + "LEFT JOIN partners p ON t.partner_id = p.partner_id "
                + "WHERE 1=1 ");

        List<Object> params = new ArrayList<>();

        if (status != null && !status.isEmpty() && !status.equals("all")) {
            sql.append("AND t.status = ? ");
            params.add(status);
        }

        if (type != null && !type.isEmpty() && !type.equals("all")) {
            sql.append("AND t.type = ? ");
            params.add(type);
        }

        if (partnerSearch != null && !partnerSearch.trim().isEmpty()) {
            sql.append("AND p.partner_name LIKE ? ");
            params.add("%" + partnerSearch.trim() + "%");
        }

        sql.append("ORDER BY t.created_at DESC");

        try (PreparedStatement ps = getConnection().prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    tickets.add(mapTicketFromResultSet(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tickets;
    }

    /**
     * Get tickets for a specific keeper
     */
    public List<Ticket> getTicketsForKeeper(int keeperId, String status, String type, String partnerSearch) {
        List<Ticket> tickets = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT t.*, u1.full_name as creator_name, u2.full_name as keeper_name, p.partner_name "
                + "FROM tickets t "
                + "LEFT JOIN users u1 ON t.created_by = u1.user_id "
                + "LEFT JOIN users u2 ON t.assigned_keeper = u2.user_id "
                + "LEFT JOIN partners p ON t.partner_id = p.partner_id "
                + "WHERE t.assigned_keeper = ? ");

        List<Object> params = new ArrayList<>();
        params.add(keeperId);

        if (status != null && !status.isEmpty() && !status.equals("all")) {
            sql.append("AND t.status = ? ");
            params.add(status);
        }
        if (type != null && !type.isEmpty() && !type.equals("all")) {
            sql.append("AND t.type = ? ");
            params.add(type);
        }

        if (partnerSearch != null && !partnerSearch.trim().isEmpty()) {
            sql.append("AND p.partner_name LIKE ? ");
            params.add("%" + partnerSearch.trim() + "%");
        }

        sql.append("ORDER BY t.created_at DESC");
        try (PreparedStatement ps = getConnection().prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    tickets.add(mapTicketFromResultSet(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tickets;
    }

    /**
     * Get ticket by ID with items
     */
    public Ticket getTicketById(int ticketId) {
        Ticket ticket = null;
        String sql = "SELECT t.*, "
                + "u1.full_name as creator_name, "
                + "u2.full_name as keeper_name, "
                + "p.partner_name "
                + "FROM tickets t "
                + "LEFT JOIN users u1 ON t.created_by = u1.user_id "
                + "LEFT JOIN users u2 ON t.assigned_keeper = u2.user_id "
                + "LEFT JOIN partners p ON t.partner_id = p.partner_id "
                + "WHERE t.ticket_id = ?";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, ticketId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ticket = mapTicketFromResultSet(rs);
                    ticket.setItems(getTicketItems(ticketId));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ticket;
    }

    /**
     * Get items for a ticket
     */
    private List<TicketItem> getTicketItems(int ticketId) {
        List<TicketItem> items = new ArrayList<>();
        String sql = "SELECT ti.*, p.product_name, "
                + "CONCAT(pd.cpu, ' / ', pd.ram, ' / ', pd.storage) as product_config, "
                + "pd.quantity as current_stock "
                + "FROM ticket_items ti "
                + "JOIN product_details pd ON ti.product_detail_id = pd.product_detail_id "
                + "JOIN products p ON pd.product_id = p.product_id "
                + "WHERE ti.ticket_id = ?";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, ticketId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TicketItem item = new TicketItem();
                    item.setTicketItemId(rs.getInt("ticket_item_id"));
                    item.setTicketId(rs.getInt("ticket_id"));
                    item.setProductDetailId(rs.getInt("product_detail_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setProductName(rs.getString("product_name"));
                    item.setProductConfig(rs.getString("product_config"));
                    item.setCurrentStock(rs.getInt("current_stock"));
                    items.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }

    /**
     * Complete a ticket - update stock quantities and log to stock_ledger For
     * EXPORT tickets, validates sufficient stock before approving
     */
    public boolean completeTicket(int ticketId, String keeperNote) throws SQLException {
        Connection conn = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            // Get ticket details
            Ticket ticket = getTicketById(ticketId);
            if (ticket == null || !ticket.getStatus().equals("PENDING")) {
                return false;
            }

            // For EXPORT tickets, validate stock availability BEFORE approving
            if (ticket.getType().equals("EXPORT")) {
                for (TicketItem item : ticket.getItems()) {
                    int currentStock = getCurrentStock(conn, item.getProductDetailId());
                    if (currentStock < item.getQuantity()) {
                        conn.rollback();
                        throw new SQLException("Insufficient stock for product: " + item.getProductName()
                                + " (Config: " + item.getProductConfig() + "). "
                                + "Available: " + currentStock + ", Requested: " + item.getQuantity());
                    }
                }
            }

            // Update ticket status
            String sqlUpdateTicket = "UPDATE tickets SET status = 'COMPLETED', processed_at = NOW(), keeper_note = ? WHERE ticket_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sqlUpdateTicket)) {
                ps.setString(1, keeperNote);
                ps.setInt(2, ticketId);
                ps.executeUpdate();
            }

            // Process each item
            for (TicketItem item : ticket.getItems()) {
                int quantityChange = item.getQuantity();
                if (ticket.getType().equals("EXPORT")) {
                    quantityChange = -quantityChange; // Negative for export
                }

                // Update product_details quantity
                String sqlUpdateQty = "UPDATE product_details SET quantity = quantity + ? WHERE product_detail_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(sqlUpdateQty)) {
                    ps.setInt(1, quantityChange);
                    ps.setInt(2, item.getProductDetailId());
                    ps.executeUpdate();
                }

                // Get new balance
                int newBalance = 0;
                String sqlGetBalance = "SELECT quantity FROM product_details WHERE product_detail_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(sqlGetBalance)) {
                    ps.setInt(1, item.getProductDetailId());
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            newBalance = rs.getInt("quantity");
                        }
                    }
                }

                // Insert into stock_ledger
                String sqlLedger = "INSERT INTO stock_ledger (product_detail_id, ticket_id, quantity_change, balance_after, type) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(sqlLedger)) {
                    ps.setInt(1, item.getProductDetailId());
                    ps.setInt(2, ticketId);
                    ps.setInt(3, Math.abs(item.getQuantity()));
                    ps.setInt(4, newBalance);
                    ps.setString(5, ticket.getType());
                    ps.executeUpdate();
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    /**
     * Get current stock for a product detail
     */
    private int getCurrentStock(Connection conn, int productDetailId) throws SQLException {
        String sql = "SELECT quantity FROM product_details WHERE product_detail_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productDetailId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("quantity");
                }
            }
        }
        return 0;
    }

    /**
     * Validate stock availability for EXPORT ticket (used during ticket
     * creation) Returns error message if insufficient stock, null if OK
     */
    public String validateExportStock(List<TicketItem> items) {
        StringBuilder errors = new StringBuilder();

        for (TicketItem item : items) {
            String sql = "SELECT pd.quantity, p.product_name, "
                    + "CONCAT(pd.cpu, ' / ', pd.ram, ' / ', pd.storage) as config "
                    + "FROM product_details pd "
                    + "JOIN products p ON pd.product_id = p.product_id "
                    + "WHERE pd.product_detail_id = ?";

            try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
                ps.setInt(1, item.getProductDetailId());
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        int currentStock = rs.getInt("quantity");
                        String productName = rs.getString("product_name");
                        String config = rs.getString("config");

                        if (currentStock < item.getQuantity()) {
                            if (errors.length() > 0) {
                                errors.append("; ");
                            }
                            errors.append(productName).append(" (").append(config).append("): ")
                                    .append("Available ").append(currentStock)
                                    .append(", Requested ").append(item.getQuantity());
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return errors.length() > 0 ? errors.toString() : null;
    }

    /**
     * Cancel a ticket
     */
    public boolean cancelTicket(int ticketId, String keeperNote) {
        String sql = "UPDATE tickets SET status = 'REJECTED', processed_at = NOW(), keeper_note = ? WHERE ticket_id = ? AND status = 'PENDING'";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setString(1, keeperNote);
            ps.setInt(2, ticketId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get list of keepers (users with role_id = 3)
     */
    public List<Users> getKeeperList() {
        List<Users> keepers = new ArrayList<>();
        String sql = "SELECT user_id, username, full_name, email FROM users WHERE role_id = 3 AND status = 'active'";

        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Users user = new Users();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                keepers.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return keepers;
    }

    /**
     * Get product details for ticket creation form
     */
    public List<TicketItem> getAvailableProducts() {
        List<TicketItem> products = new ArrayList<>();
        String sql = "SELECT pd.product_detail_id, p.product_name, "
                + "CONCAT(pd.cpu, ' / ', pd.ram, ' / ', pd.storage) as product_config, "
                + "pd.quantity as current_stock "
                + "FROM product_details pd "
                + "JOIN products p ON pd.product_id = p.product_id "
                + "WHERE p.status = 1";

        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                TicketItem item = new TicketItem();
                item.setProductDetailId(rs.getInt("product_detail_id"));
                item.setProductName(rs.getString("product_name"));
                item.setProductConfig(rs.getString("product_config"));
                item.setCurrentStock(rs.getInt("current_stock"));
                products.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    /**
     * Map ResultSet to Ticket object
     */
    private Ticket mapTicketFromResultSet(ResultSet rs) throws SQLException {
        Ticket ticket = new Ticket();
        ticket.setTicketId(rs.getInt("ticket_id"));
        ticket.setTicketCode(rs.getString("ticket_code"));
        ticket.setType(rs.getString("type"));
        ticket.setTitle(rs.getString("title"));
        ticket.setDescription(rs.getString("description"));
        ticket.setStatus(rs.getString("status"));
        ticket.setCreatedBy(rs.getInt("created_by"));

        int assignedKeeper = rs.getInt("assigned_keeper");
        if (!rs.wasNull()) {
            ticket.setAssignedKeeper(assignedKeeper);
        }

        ticket.setCreatedAt(rs.getTimestamp("created_at"));
        ticket.setProcessedAt(rs.getTimestamp("processed_at"));
        ticket.setKeeperNote(rs.getString("keeper_note"));
        ticket.setCreatorName(rs.getString("creator_name"));
        ticket.setKeeperName(rs.getString("keeper_name"));

        int partnerId = rs.getInt("partner_id");
        if (!rs.wasNull()) {
            ticket.setPartnerId(partnerId);
        }
        ticket.setPartnerName(rs.getString("partner_name"));

        return ticket;
    }

    public List<ImportReportDTO> getImportReport(String from, String to, String partnerId, String status) {
        List<ImportReportDTO> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT t.ticket_code, t.processed_at, t.status, "
                + "u1.full_name AS creator_name, "
                + "u2.full_name AS confirmed_by, "
                + "p.partner_name "
                + "FROM Tickets t "
                + "LEFT JOIN Users u1 ON t.created_by = u1.user_id "
                + "LEFT JOIN Users u2 ON t.assigned_keeper = u2.user_id "
                + "LEFT JOIN Partners p ON t.partner_id = p.partner_id "
                + "WHERE t.type = 'IMPORT' ");

        if (from != null && !from.isEmpty()) {
            sql.append(" AND t.processed_at >= '").append(from).append(" 00:00:00'");
        }
        if (to != null && !to.isEmpty()) {
            sql.append(" AND t.processed_at <= '").append(to).append(" 23:59:59'");
        }

        if (partnerId != null && !partnerId.isEmpty()) {
            sql.append(" AND t.partner_id = ").append(partnerId);
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND t.status = '").append(status).append("'");
        }

        sql.append(" ORDER BY t.processed_at DESC");

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString()); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ImportReportDTO dto = new ImportReportDTO();
                dto.setTicketCode(rs.getString("ticket_code"));
                dto.setProcessedAt(rs.getTimestamp("processed_at"));
                dto.setCreatorName(rs.getString("creator_name"));
                dto.setConfirmedBy(rs.getString("confirmed_by") != null ? rs.getString("confirmed_by") : "N/A");
                dto.setPartnerName(rs.getString("partner_name") != null ? rs.getString("partner_name") : "N/A");
                dto.setStatus(rs.getString("status"));

                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ImportReportDTO> getExportReport(String from, String to, String partnerId, String status) {
        List<ImportReportDTO> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT t.ticket_code, t.processed_at, t.status, "
                + "u1.full_name AS creator_name, "
                + "u2.full_name AS confirmed_by, "
                + "p.partner_name "
                + "FROM Tickets t "
                + "LEFT JOIN Users u1 ON t.created_by = u1.user_id "
                + "LEFT JOIN Users u2 ON t.assigned_keeper = u2.user_id "
                + "LEFT JOIN Partners p ON t.partner_id = p.partner_id "
                + "WHERE t.type = 'EXPORT' ");

        if (from != null && !from.isEmpty()) {
            sql.append(" AND t.processed_at >= '").append(from).append(" 00:00:00'");
        }
        if (to != null && !to.isEmpty()) {
            sql.append(" AND t.processed_at <= '").append(to).append(" 23:59:59'");
        }

        if (partnerId != null && !partnerId.isEmpty()) {
            sql.append(" AND t.partner_id = ").append(partnerId);
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND t.status = '").append(status).append("'");
        }

        sql.append(" ORDER BY t.processed_at DESC");

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString()); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ImportReportDTO dto = new ImportReportDTO();
                dto.setTicketCode(rs.getString("ticket_code"));
                dto.setProcessedAt(rs.getTimestamp("processed_at"));
                dto.setCreatorName(rs.getString("creator_name"));
                dto.setConfirmedBy(rs.getString("confirmed_by") != null ? rs.getString("confirmed_by") : "N/A");
                dto.setPartnerName(rs.getString("partner_name") != null ? rs.getString("partner_name") : "N/A");
                dto.setStatus(rs.getString("status"));

                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateTicketWithItems(Ticket ticket) throws SQLException {
        Connection conn = null;
        PreparedStatement psTicket = null;
        PreparedStatement psDelItems = null;
        PreparedStatement psInsItem = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            String sqlTicket = "UPDATE tickets SET title = ?, description = ?, type = ?, "
                    + "assigned_keeper = ?, partner_id = ? "
                    + "WHERE ticket_id = ? AND status = 'PENDING'";

            psTicket = conn.prepareStatement(sqlTicket);
            psTicket.setString(1, ticket.getTitle());
            psTicket.setString(2, ticket.getDescription());
            psTicket.setString(3, ticket.getType());

            if (ticket.getAssignedKeeper() != null) {
                psTicket.setInt(4, ticket.getAssignedKeeper());
            } else {
                psTicket.setNull(4, java.sql.Types.INTEGER);
            }

            if (ticket.getPartnerId() != null) {
                psTicket.setInt(5, ticket.getPartnerId());
            } else {
                psTicket.setNull(5, java.sql.Types.INTEGER);
            }

            psTicket.setInt(6, ticket.getTicketId());

            int rowsUpdated = psTicket.executeUpdate();

            if (rowsUpdated == 0) {
                conn.rollback();
                return false;
            }

            String sqlDeleteItems = "DELETE FROM ticket_items WHERE ticket_id = ?";
            psDelItems = conn.prepareStatement(sqlDeleteItems);
            psDelItems.setInt(1, ticket.getTicketId());
            psDelItems.executeUpdate();

            if (ticket.getItems() != null && !ticket.getItems().isEmpty()) {
                String sqlInsertItem = "INSERT INTO ticket_items (ticket_id, product_detail_id, quantity) VALUES (?, ?, ?)";
                psInsItem = conn.prepareStatement(sqlInsertItem);
                for (TicketItem item : ticket.getItems()) {
                    psInsItem.setInt(1, ticket.getTicketId());
                    psInsItem.setInt(2, item.getProductDetailId());
                    psInsItem.setInt(3, item.getQuantity());
                    psInsItem.addBatch();
                }
                psInsItem.executeBatch();
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (psTicket != null) {
                psTicket.close();
            }
            if (psDelItems != null) {
                psDelItems.close();
            }
            if (psInsItem != null) {
                psInsItem.close();
            }
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    public static void main(String[] args) {
        TicketDAO userDAO = new TicketDAO();

        System.out.println("=== Testing ===");
        List<ImportReportDTO> allUsers = userDAO.getImportReport(null, null, null, null);
        System.out.println("Found " + allUsers.size() + " Users:");
        for (ImportReportDTO user : allUsers) {
            System.out.println(user);
        }
    }
}
