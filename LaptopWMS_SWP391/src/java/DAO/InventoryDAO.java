package DAO;

import Model.InventoryDTO;
import Model.Location;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class InventoryDAO {

    public List<Location> getAllLocations() {
        List<Location> list = new ArrayList<>();
        String sql = "SELECT * FROM locations";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Location location = new Location();
                location.setLocationId(rs.getInt("location_id"));
                location.setLocationName(rs.getString("location_name"));
                list.add(location);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<InventoryDTO> getInventoryList(String search, int locationId, int page, int pageSize) {
        List<InventoryDTO> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT i.inventory_id, p.product_name, l.location_name, i.stock_quantity, i.last_updated " +
            "FROM inventory i " +
            "JOIN products p ON i.product_id = p.product_id " +
            "JOIN locations l ON i.location_id = l.location_id " +
            "WHERE p.product_name LIKE ? "
        );

        if (locationId > 0) {
            sql.append("AND i.location_id = ? ");
        }

        sql.append("ORDER BY i.inventory_id ASC LIMIT ? OFFSET ?");

        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql.toString())) {
            
            st.setString(1, "%" + search + "%");
            int paramIndex = 2;
            
            if (locationId > 0) {
                st.setInt(paramIndex++, locationId);
            }
            
            st.setInt(paramIndex++, pageSize);
            st.setInt(paramIndex, (page - 1) * pageSize);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new InventoryDTO(
                    rs.getInt("inventory_id"),
                    rs.getString("product_name"),
                    rs.getString("location_name"),
                    rs.getInt("stock_quantity"),
                    rs.getTimestamp("last_updated")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalInventoryCount(String search, int locationId) {
        int count = 0;
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM inventory i " +
            "JOIN products p ON i.product_id = p.product_id " +
            "WHERE p.product_name LIKE ? "
        );

        if (locationId > 0) {
            sql.append("AND i.location_id = ?");
        }

        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql.toString())) {
            
            st.setString(1, "%" + search + "%");
            if (locationId > 0) {
                st.setInt(2, locationId);
            }
            
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}