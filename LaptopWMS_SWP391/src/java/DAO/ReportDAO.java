/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author PC
 */
import Model.StockReportItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO extends DBContext {

    public List<StockReportItem> getInventoryReport(String startDate, String endDate) {
        List<StockReportItem> list = new ArrayList<>();

        String sql = """
            SELECT 
                p.product_id,
                p.product_name,
                p.unit,
                (COALESCE(SUM(CASE 
                        WHEN o.updated_at < ? AND o.supplier_id IS NOT NULL AND o.order_status = 'completed' THEN op.quantity 
                        ELSE 0 END), 0) 
                    - 
                    COALESCE(SUM(CASE 
                        WHEN o.updated_at < ? AND o.customer_id IS NOT NULL AND o.order_status IN ('shipping', 'completed') THEN op.quantity 
                        ELSE 0 END), 0)
                ) AS opening_stock,

                COALESCE(SUM(CASE 
                    WHEN o.updated_at >= ? AND o.updated_at <= ? 
                    AND o.supplier_id IS NOT NULL AND o.order_status = 'completed' THEN op.quantity 
                    ELSE 0 END), 0) 
                AS import_period,

                COALESCE(SUM(CASE 
                    WHEN o.updated_at >= ? AND o.updated_at <= ? 
                    AND o.customer_id IS NOT NULL AND o.order_status IN ('shipping', 'completed') THEN op.quantity 
                    ELSE 0 END), 0) 
                AS export_period

            FROM products p
            LEFT JOIN order_products op ON p.product_id = op.product_id
            LEFT JOIN orders o ON op.order_id = o.order_id
            GROUP BY p.product_id, p.product_name, p.unit
            ORDER BY p.product_id ASC
        """;

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {

            String startParams = startDate + " 00:00:00";
            String endParams = endDate + " 23:59:59";

            ps.setString(1, startParams);
            ps.setString(2, startParams);

            ps.setString(3, startParams);
            ps.setString(4, endParams);

            ps.setString(5, startParams);
            ps.setString(6, endParams);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StockReportItem item = new StockReportItem();
                    item.setProductId(rs.getInt("product_id"));
                    item.setProductName(rs.getString("product_name"));
                    item.setUnit(rs.getString("unit"));

                    int opening = rs.getInt("opening_stock");
                    int imp = rs.getInt("import_period");
                    int exp = rs.getInt("export_period");

                    item.setOpeningStock(opening);
                    item.setImportQuantity(imp);
                    item.setExportQuantity(exp);

                    item.setClosingStock(opening + imp - exp);

                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
