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

    public List<Product> getProducts(String keyword, String status, String category, String brand, String sortOrder) {
        List<Product> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT p.product_id, p.product_name, p.brand, p.category, p.unit, p.status, " // Added p.brand
                + "p.supplier_id, s.supplier_name "
                + "FROM products p "
                + "LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id "
                + "WHERE 1=1 ");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND p.product_name LIKE ? ");
            params.add("%" + keyword.trim() + "%");
        }

        if (status != null && !status.equals("all")) {
            sql.append("AND p.status = ? ");
            params.add(status);
        }

        if (category != null && !category.equals("all")) {
            sql.append("AND p.category = ? ");
            params.add(category);
        }

        if (brand != null && !brand.equals("all")) {
            sql.append("AND s.supplier_name LIKE ? ");
            params.add("%" + brand.trim() + "%");
        }

        String order = (sortOrder != null && sortOrder.equalsIgnoreCase("DESC")) ? "DESC" : "ASC";
        sql.append("ORDER BY p.product_id ").append(order);

        try (PreparedStatement ps = getConnection().prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();

                    p.setProductId(rs.getInt("product_id"));
                    p.setProductName(rs.getString("product_name"));
                    p.setCategory(rs.getString("category"));
                    p.setUnit(rs.getString("unit"));
                    p.setStatus(rs.getBoolean("status"));

                    p.setSupplierName(rs.getString("supplier_name"));
                    p.setBrand(rs.getString("brand"));

                    List<ProductDetail> details = getDetailsByProductId(p.getProductId());
                    p.setDetailsList(details);

                    list.add(p);
                }
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

    public void toggleProductStatus(int productId) {
        String flipParent = "UPDATE products SET status = NOT status WHERE product_id = ?";

        String syncChildren = "UPDATE product_details SET status = "
                + "(SELECT status FROM products WHERE product_id = ?) "
                + "WHERE product_id = ?";

        try {
            try (PreparedStatement ps = getConnection().prepareStatement(flipParent)) {
                ps.setInt(1, productId);
                ps.executeUpdate();
            }

            try (PreparedStatement ps = getConnection().prepareStatement(syncChildren)) {
                ps.setInt(1, productId);
                ps.setInt(2, productId);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void toggleDetailStatus(int detailId) {
        String sql = "UPDATE product_details SET status = NOT status WHERE product_detail_id = ?";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, detailId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
