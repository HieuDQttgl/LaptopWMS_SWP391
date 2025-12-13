/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import static DAO.DBContext.getConnection;
import Model.Product;
import Model.ProductDetail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class ProductDAO extends DBContext {

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();

        String sql = "SELECT p.product_id, p.product_name, p.category, p.unit, p.status, "
                + "p.supplier_id, s.supplier_name "
                + "FROM products p "
                + "LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id "
                + "ORDER BY p.product_id DESC";

        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product p = new Product();

                p.setProductId(rs.getInt("product_id"));
                p.setProductName(rs.getString("product_name"));
                p.setCategory(rs.getString("category"));
                p.setUnit(rs.getString("unit"));
                p.setStatus(rs.getString("status"));

                p.setSupplierId(rs.getInt("supplier_id"));
                p.setBrand(rs.getString("supplier_name"));

                List<ProductDetail> details = getDetailsByProductId(p.getProductId());
                p.setDetailsList(details);

                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private List<ProductDetail> getDetailsByProductId(int productId) {
        List<ProductDetail> details = new ArrayList<>();

        String sql = "SELECT product_detail_id, product_id, ram, storage, cpu, gpu, screen, status "
                + "FROM product_details WHERE product_id = ?";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductDetail d = new ProductDetail();

                    d.setProductDetailId(rs.getInt("product_detail_id"));
                    d.setProductId(rs.getInt("product_id"));
                    d.setRam(rs.getString("ram"));
                    d.setStorage(rs.getString("storage"));
                    d.setCpu(rs.getString("cpu"));
                    d.setGpu(rs.getString("gpu"));
                    d.setScreen(rs.getDouble("screen"));
                    d.setStatus(rs.getBoolean("status"));

                    details.add(d);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return details;
    }
}
