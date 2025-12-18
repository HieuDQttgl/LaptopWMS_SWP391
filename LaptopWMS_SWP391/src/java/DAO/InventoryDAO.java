package DAO;

import DTO.ProductDTO;
import DTO.InventoryDTO;
import DTO.InventoryReportDTO;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import Model.Location;
import Model.ProductItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class InventoryDAO {

    public List<Location> getAllLocations() {
        List<Location> list = new ArrayList<>();
        String sql = "SELECT * FROM locations";
        try (Connection conn = DBContext.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
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

    public List<InventoryDTO> getInventoryList(String search, int locationId, int page, int pageSize, String sortBy, String sortOrder) {
        List<InventoryDTO> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT i.inventory_id, i.product_id, i.location_id, p.product_name, l.location_name, i.stock_quantity, i.last_updated "
                + "FROM inventory i "
                + "JOIN products p ON i.product_id = p.product_id "
                + "JOIN locations l ON i.location_id = l.location_id "
                + "WHERE p.product_name LIKE ? "
        );

        if (locationId > 0) {
            sql.append("AND i.location_id = ? ");
        }
        String orderColumn = "i.inventory_id";
        if ("quantity".equals(sortBy)) {
            orderColumn = "i.stock_quantity";
        } else if ("product".equals(sortBy)) {
            orderColumn = "p.product_name";
        } else if ("location".equals(sortBy)) {
            orderColumn = "l.location_name";
        }

        String order = "DESC".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC";
        sql.append("ORDER BY ").append(orderColumn).append(" ").append(order).append(" LIMIT ? OFFSET ?");

        try (Connection conn = DBContext.getConnection(); PreparedStatement st = conn.prepareStatement(sql.toString())) {

            st.setString(1, "%" + search + "%");
            int paramIndex = 2;

            if (locationId > 0) {
                st.setInt(paramIndex++, locationId);
            }

            st.setInt(paramIndex++, pageSize);
            st.setInt(paramIndex, (page - 1) * pageSize);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                InventoryDTO dto = new InventoryDTO(
                        rs.getInt("inventory_id"),
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getString("location_name"),
                        rs.getInt("stock_quantity"),
                        rs.getTimestamp("last_updated")
                );
                // Thêm locationId vào DTO
                dto.setLocationId(rs.getInt("location_id"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalInventoryCount(String search, int locationId) {
        int count = 0;
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM inventory i "
                + "JOIN products p ON i.product_id = p.product_id "
                + "WHERE p.product_name LIKE ? "
        );

        if (locationId > 0) {
            sql.append("AND i.location_id = ?");
        }

        try (Connection conn = DBContext.getConnection(); PreparedStatement st = conn.prepareStatement(sql.toString())) {

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

    public List<ProductItem> getItemsForAudit(int productId) {
        List<ProductItem> list = new ArrayList<>();
        String sql = "SELECT pi.items_id, pi.product_detail_id, pi.serial_number, pi.status, pi.items_note, "
                + "pd.ram, pd.storage, pd.cpu, pd.gpu, pd.screen "
                + "FROM product_items pi "
                + "JOIN product_details pd ON pi.product_detail_id = pd.product_detail_id "
                + "WHERE pd.product_id = ? "
                + "ORDER BY pi.items_id ASC";

        try (Connection conn = DBContext.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {

            st.setInt(1, productId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                ProductItem item = new ProductItem();
                item.setItemId(rs.getInt("items_id"));
                item.setProductDetailId(rs.getInt("product_detail_id"));
                item.setSerialNumber(rs.getString("serial_number"));
                item.setStatus(rs.getString("status"));
                item.setItemNote(rs.getString("items_note"));
                StringBuilder specSummary = new StringBuilder();

                String ram = rs.getString("ram");
                String storage = rs.getString("storage");
                String cpu = rs.getString("cpu");
                String gpu = rs.getString("gpu");
                double screen = rs.getDouble("screen");

                if (ram != null && !ram.isEmpty()) {
                    specSummary.append("RAM: ").append(ram);
                }
                if (storage != null && !storage.isEmpty()) {
                    if (specSummary.length() > 0) {
                        specSummary.append(" | ");
                    }
                    specSummary.append("Storage: ").append(storage);
                }
                if (cpu != null && !cpu.isEmpty()) {
                    if (specSummary.length() > 0) {
                        specSummary.append(" | ");
                    }
                    specSummary.append("CPU: ").append(cpu);
                }
                if (gpu != null && !gpu.isEmpty()) {
                    if (specSummary.length() > 0) {
                        specSummary.append(" | ");
                    }
                    specSummary.append("GPU: ").append(gpu);
                }
                if (screen > 0) {
                    if (specSummary.length() > 0) {
                        specSummary.append(" | ");
                    }
                    specSummary.append("Screen: ").append(screen).append('"');
                }

                item.setSpecSummary(specSummary.toString());
                list.add(item);
            }
        } catch (Exception e) {
            System.err.println("Error in getItemsForAudit: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public void updateAuditAndSync(int productId, Map<Integer, String[]> auditData) {
        String updateItemSql = "UPDATE product_items SET status = ?, items_note = ? WHERE items_id = ?";
        String syncInventorySql = "UPDATE inventory i "
                + "SET i.stock_quantity = (SELECT COUNT(*) FROM product_items pi "
                + "JOIN product_details pd ON pi.product_detail_id = pd.product_detail_id "
                + "WHERE pd.product_id = ? AND pi.status = 'Available') "
                + "WHERE i.product_id = ?";
        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);
            try {
                PreparedStatement psItem = conn.prepareStatement(updateItemSql);
                for (Integer id : auditData.keySet()) {
                    psItem.setString(1, auditData.get(id)[0]);
                    psItem.setString(2, auditData.get(id)[1]);
                    psItem.setInt(3, id);
                    psItem.addBatch();
                }
                psItem.executeBatch();

                PreparedStatement psSync = conn.prepareStatement(syncInventorySql);
                psSync.setInt(1, productId);
                psSync.setInt(2, productId);
                psSync.executeUpdate();

                conn.commit();
            } catch (Exception e) {
                conn.rollback();
                throw e;
            }
        } catch (Exception e) {
            System.err.println("Error in updateAuditAndSync: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public String getLocationNameById(int locationId) {
        String sql = "SELECT location_name FROM locations WHERE location_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, locationId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getString("location_name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "Unknown Location";
    }

    public List<ProductDTO> getProductsAvailableToAdd() {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT p.product_id, p.product_name, p.status "
                + "FROM products p "
                + "LEFT JOIN inventory i ON p.product_id = i.product_id "
                + "WHERE i.product_id IS NULL AND p.status = 1";

        try (Connection conn = DBContext.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new ProductDTO(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getInt("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductDTO> getProductsNotInInventory() {
        List<ProductDTO> list = new ArrayList<>();

        String sql = "SELECT p.product_id, p.product_name, p.status "
                + "FROM products p "
                + "WHERE p.status = 1 "
                + "ORDER BY p.product_name";
        try (Connection conn = DBContext.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new ProductDTO(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getInt("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addProductToInventory(int productID, int locationId) throws Exception {

        String checkSQL = "SELECT COUNT(*) FROM inventory WHERE product_id = ? AND location_id = ?";
        String insertSQL = "INSERT INTO inventory (product_id, location_id, stock_quantity, last_updated) VALUES (?, ?, 0, ?)";

        try (Connection conn = DBContext.getConnection()) {

            try (PreparedStatement check = conn.prepareStatement(checkSQL)) {
                check.setInt(1, productID);
                check.setInt(2, locationId);
                ResultSet rs = check.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    return false;
                }
            }

            try (PreparedStatement insert = conn.prepareStatement(insertSQL)) {
                insert.setInt(1, productID);
                insert.setInt(2, locationId);
                insert.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
                return insert.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public List<Model.ProductDetail> getDetailsByProductId(int productId) {
        List<Model.ProductDetail> list = new ArrayList<>();
        String sql = "SELECT * FROM product_details WHERE product_id = ? AND status = 1";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Model.ProductDetail d = new Model.ProductDetail();
                d.setProductDetailId(rs.getInt("product_detail_id"));
                d.setCpu(rs.getString("cpu"));
                d.setRam(rs.getString("ram"));
                d.setStorage(rs.getString("storage"));
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addProductItem(int detailId, String serial, String status) {
        String sql = "INSERT INTO product_items (product_detail_id, serial_number, status) VALUES (?, ?, ?)";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, detailId);
            ps.setString(2, serial);
            ps.setString(3, status);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void updateInventoryStock(int productId, int locationId) {
        String sql = "UPDATE inventory SET stock_quantity = stock_quantity + 1, last_updated = NOW() "
                + "WHERE product_id = ? AND location_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, locationId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<InventoryReportDTO> getSimpleInventoryReport(Integer locId, String brand, String category) {
        List<InventoryReportDTO> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT p.product_id, p.product_name, l.location_name, p.brand, p.category, i.stock_quantity "
                + "FROM inventory i "
                + "JOIN products p ON i.product_id = p.product_id "
                + "JOIN locations l ON i.location_id = l.location_id WHERE 1=1 "
        );

        if (locId != null && locId > 0) {
            sql.append(" AND l.location_id = ").append(locId);
        }
        if (brand != null && !brand.isEmpty()) {
            sql.append(" AND p.brand = '").append(brand).append("'");
        }
        if (category != null && !category.isEmpty()) {
            sql.append(" AND p.category = '").append(category).append("'");
        }

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString()); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                InventoryReportDTO d = new InventoryReportDTO();
                d.setId(rs.getInt("product_id"));
                d.setProductName(rs.getString("product_name"));
                d.setLocationName(rs.getString("location_name"));
                d.setBrand(rs.getString("brand"));
                d.setCategory(rs.getString("category"));
                d.setStock(rs.getInt("stock_quantity"));


                if (d.getStock() <= 0) {
                    d.setStatus("Out");
                } else if (d.getStock() <= 5) {
                    d.setStatus("Low");
                } else {
                    d.setStatus("Normal");
                }

                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<String> getAllBrands() {
    List<String> list = new ArrayList<>();
    String sql = "SELECT DISTINCT brand FROM products WHERE brand IS NOT NULL AND brand != '' ORDER BY brand";
    try (Connection conn = DBContext.getConnection(); 
         PreparedStatement ps = conn.prepareStatement(sql); 
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            list.add(rs.getString("brand"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}


public List<String> getAllCategories() {
    List<String> list = new ArrayList<>();
    String sql = "SELECT DISTINCT category FROM products WHERE category IS NOT NULL AND category != '' ORDER BY category";
    try (Connection conn = DBContext.getConnection(); 
         PreparedStatement ps = conn.prepareStatement(sql); 
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            list.add(rs.getString("category"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

}
