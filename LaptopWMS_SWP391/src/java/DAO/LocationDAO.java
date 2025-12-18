package DAO;

import Model.Location;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class LocationDAO {

    /**
     * Get paginated list of locations with filters and sorting
     */
    public List<Location> getLocations(String keyword, String zone, String aisle,
            String status, String sortBy, String sortOrder,
            int page, int pageSize) {
        List<Location> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT l.*, COALESCE(SUM(i.stock_quantity), 0) as current_usage " +
                        "FROM locations l " +
                        "LEFT JOIN inventory i ON l.location_id = i.location_id " +
                        "WHERE 1=1 ");

        List<Object> params = new ArrayList<>();

        // Search by keyword (name or ID)
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (l.location_name LIKE ? OR CAST(l.location_id AS CHAR) LIKE ?) ");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }

        // Filter by zone
        if (zone != null && !zone.equals("all") && !zone.trim().isEmpty()) {
            sql.append("AND l.zone = ? ");
            params.add(zone);
        }

        // Filter by aisle
        if (aisle != null && !aisle.equals("all") && !aisle.trim().isEmpty()) {
            sql.append("AND l.aisle = ? ");
            params.add(aisle);
        }

        // Filter by status
        if (status != null && !status.equals("all")) {
            if (status.equals("active")) {
                sql.append("AND l.status = 1 ");
            } else if (status.equals("inactive")) {
                sql.append("AND l.status = 0 ");
            }
        }

        sql.append("GROUP BY l.location_id ");

        // Filter by availability (after GROUP BY since it uses aggregate)
        if (status != null) {
            if (status.equals("available")) {
                sql.append("HAVING current_usage < l.capacity AND l.status = 1 ");
            } else if (status.equals("full")) {
                sql.append("HAVING current_usage >= l.capacity AND l.status = 1 ");
            }
        }

        // Sorting
        String validSortBy = getValidSortColumn(sortBy);
        String validSortOrder = "DESC".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC";
        sql.append("ORDER BY ").append(validSortBy).append(" ").append(validSortOrder).append(" ");

        // Pagination
        sql.append("LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            for (Object param : params) {
                if (param instanceof String) {
                    ps.setString(paramIndex++, (String) param);
                } else if (param instanceof Integer) {
                    ps.setInt(paramIndex++, (Integer) param);
                }
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToLocation(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * Get total count for pagination
     */
    public int getTotalCount(String keyword, String zone, String aisle, String status) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM (" +
                        "SELECT l.location_id, COALESCE(SUM(i.stock_quantity), 0) as current_usage " +
                        "FROM locations l " +
                        "LEFT JOIN inventory i ON l.location_id = i.location_id " +
                        "WHERE 1=1 ");

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (l.location_name LIKE ? OR CAST(l.location_id AS CHAR) LIKE ?) ");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }

        if (zone != null && !zone.equals("all") && !zone.trim().isEmpty()) {
            sql.append("AND l.zone = ? ");
            params.add(zone);
        }

        if (aisle != null && !aisle.equals("all") && !aisle.trim().isEmpty()) {
            sql.append("AND l.aisle = ? ");
            params.add(aisle);
        }

        if (status != null && !status.equals("all")) {
            if (status.equals("active")) {
                sql.append("AND l.status = 1 ");
            } else if (status.equals("inactive")) {
                sql.append("AND l.status = 0 ");
            }
        }

        sql.append("GROUP BY l.location_id ");

        if (status != null) {
            if (status.equals("available")) {
                sql.append("HAVING current_usage < l.capacity AND l.status = 1 ");
            } else if (status.equals("full")) {
                sql.append("HAVING current_usage >= l.capacity AND l.status = 1 ");
            }
        }

        sql.append(") AS subquery");

        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            for (Object param : params) {
                if (param instanceof String) {
                    ps.setString(paramIndex++, (String) param);
                }
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

    /**
     * Get distinct zones for filter dropdown
     */
    public List<String> getDistinctZones() {
        List<String> zones = new ArrayList<>();
        String sql = "SELECT DISTINCT zone FROM locations WHERE zone IS NOT NULL AND zone != '' ORDER BY zone";

        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                zones.add(rs.getString("zone"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return zones;
    }

    /**
     * Get distinct aisles for filter dropdown
     */
    public List<String> getDistinctAisles() {
        List<String> aisles = new ArrayList<>();
        String sql = "SELECT DISTINCT aisle FROM locations WHERE aisle IS NOT NULL AND aisle != '' ORDER BY aisle";

        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                aisles.add(rs.getString("aisle"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return aisles;
    }

    /**
     * Get location by ID
     */
    public Location getLocationById(int locationId) {
        String sql = "SELECT l.*, COALESCE(SUM(i.stock_quantity), 0) as current_usage " +
                "FROM locations l " +
                "LEFT JOIN inventory i ON l.location_id = i.location_id " +
                "WHERE l.location_id = ? " +
                "GROUP BY l.location_id";

        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, locationId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToLocation(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Helper method to map ResultSet to Location object
     */
    private Location mapResultSetToLocation(ResultSet rs) throws Exception {
        Location location = new Location();
        location.setLocationId(rs.getInt("location_id"));
        location.setLocationName(rs.getString("location_name"));
        location.setDescription(rs.getString("description"));
        location.setZone(rs.getString("zone"));
        location.setAisle(rs.getString("aisle"));
        location.setRack(rs.getString("rack"));
        location.setBin(rs.getString("bin"));
        location.setCapacity(rs.getInt("capacity"));
        location.setCurrentUsage(rs.getInt("current_usage"));
        location.setStatus(rs.getBoolean("status"));
        return location;
    }

    /**
     * Validate sort column to prevent SQL injection
     */
    private String getValidSortColumn(String sortBy) {
        if (sortBy == null)
            return "l.location_id";

        switch (sortBy.toLowerCase()) {
            case "name":
                return "l.location_name";
            case "zone":
                return "l.zone";
            case "aisle":
                return "l.aisle";
            case "rack":
                return "l.rack";
            case "bin":
                return "l.bin";
            case "capacity":
                return "l.capacity";
            case "usage":
                return "current_usage";
            case "status":
                return "l.status";
            default:
                return "l.location_id";
        }
    }
}
