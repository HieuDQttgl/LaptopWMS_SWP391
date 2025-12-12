/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import static DAO.DBContext.getConnection;
import Model.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class ProductDAO extends DBContext {

    public List<Product> getListProduct(String keyword, String brand, String sortField, String sortOrder) {
        List<Product> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT * FROM products WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND name LIKE ?");
            params.add("%" + keyword + "%");
        }

        if (brand != null && !brand.equals("all")) {
            sql.append(" AND brand = ?");
            params.add(brand);
        }

        if (sortField == null || sortField.isEmpty()) {
            sortField = "product_id";
        }
        if (sortOrder == null) {
            sortOrder = "ASC";
        }

        sql.append(" ORDER BY ").append(sortField).append(" ").append(sortOrder);

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setBrand(rs.getString("brand"));
                    p.setPrice(rs.getDouble("price"));
                    p.setQuantity(rs.getInt("quantity"));

                    p.setCpu(rs.getString("cpu"));
                    p.setRam(rs.getString("ram"));
                    p.setStorage(rs.getString("storage"));
                    p.setCard(rs.getString("card"));
                    p.setScreen(rs.getString("screen"));
                    p.setImageUrl(rs.getString("image_url"));
                    p.setStatus(rs.getString("status"));
                    list.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
