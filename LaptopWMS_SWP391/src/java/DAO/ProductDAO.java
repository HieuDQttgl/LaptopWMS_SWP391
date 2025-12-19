package DAO;

import static DAO.DBContext.getConnection;
import Model.Product;
import Model.ProductDetail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * ProductDAO - updated for laptop_wms_lite database
 * DB Schema for products: product_id, product_name, brand, category, status
 * DB Schema for product_details: product_detail_id, product_id, cpu, ram,
 * storage, gpu, unit, quantity
 */
public class ProductDAO extends DBContext {

    public List<Product> getProducts(String keyword, String status, String category, String brand, String sortOrder) {
        List<Product> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT p.product_id, p.product_name, p.brand, p.category, p.status "
                        + "FROM products p "
                        + "WHERE 1=1 ");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND p.product_name LIKE ? ");
            params.add("%" + keyword.trim() + "%");
        }

        if (status != null && !status.equals("all")) {
            sql.append("AND p.status = ? ");
            params.add(status.equals("active") ? 1 : 0);
        }

        if (category != null && !category.equals("all")) {
            sql.append("AND p.category = ? ");
            params.add(category);
        }

        if (brand != null && !brand.equals("all")) {
            sql.append("AND p.brand LIKE ? ");
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
                    p.setBrand(rs.getString("brand"));
                    p.setCategory(rs.getString("category"));
                    p.setStatus(rs.getBoolean("status"));

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

        String sql = "SELECT pd.*, p.product_name "
                + "FROM product_details pd "
                + "JOIN products p ON pd.product_id = p.product_id "
                + "WHERE pd.product_id = ?";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductDetail d = new ProductDetail();

                    d.setProductDetailId(rs.getInt("product_detail_id"));
                    d.setProductId(rs.getInt("product_id"));
                    d.setCpu(rs.getString("cpu"));
                    d.setRam(rs.getString("ram"));
                    d.setStorage(rs.getString("storage"));
                    d.setGpu(rs.getString("gpu"));
                    d.setUnit(rs.getString("unit"));
                    d.setQuantity(rs.getInt("quantity"));
                    d.setProductName(rs.getString("product_name"));

                    details.add(d);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return details;
    }

    public void toggleProductStatus(int productId) {
        String sql = "UPDATE products SET status = NOT status WHERE product_id = ?";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addProduct(Product p) {
        String sql = "INSERT INTO products (product_name, brand, category, status) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getBrand());
            ps.setString(3, p.getCategory());
            ps.setBoolean(4, true);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addProductDetail(ProductDetail d) throws SQLException {
        String sql = "INSERT INTO product_details (product_id, cpu, ram, storage, gpu, unit, quantity) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, d.getProductId());
            ps.setString(2, d.getCpu());
            ps.setString(3, d.getRam());
            ps.setString(4, d.getStorage());
            ps.setString(5, d.getGpu());
            ps.setString(6, d.getUnit() != null ? d.getUnit() : "piece");
            ps.setInt(7, d.getQuantity());

            ps.executeUpdate();
        }
    }

    public String getProductNameById(int id) {
        String sql = "SELECT product_name FROM products WHERE product_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("product_name");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "Unknown Product";
    }

    public Product getProductById(int id) {
        Product p = null;

        String sql = "SELECT * FROM products WHERE product_id = ?";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Product();

                    p.setProductId(rs.getInt("product_id"));
                    p.setProductName(rs.getString("product_name"));
                    p.setBrand(rs.getString("brand"));
                    p.setCategory(rs.getString("category"));
                    p.setStatus(rs.getBoolean("status"));

                    return p;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Object getListProducts() {
        return getProducts(null, null, null, null, null);
    }

    public void updateProduct(Product p) {
        String sql = "UPDATE products SET product_name=?, brand=?, category=? WHERE product_id=?";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getBrand());
            ps.setString(3, p.getCategory());
            ps.setInt(4, p.getProductId());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ProductDetail getProductDetailById(int productDetailId) {
        ProductDetail d = null;

        String sql = "SELECT pd.*, p.product_name "
                + "FROM product_details pd "
                + "JOIN products p ON pd.product_id = p.product_id "
                + "WHERE pd.product_detail_id = ?";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, productDetailId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    d = new ProductDetail();

                    d.setProductDetailId(rs.getInt("product_detail_id"));
                    d.setProductId(rs.getInt("product_id"));
                    d.setCpu(rs.getString("cpu"));
                    d.setRam(rs.getString("ram"));
                    d.setStorage(rs.getString("storage"));
                    d.setGpu(rs.getString("gpu"));
                    d.setUnit(rs.getString("unit"));
                    d.setQuantity(rs.getInt("quantity"));
                    d.setProductName(rs.getString("product_name"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return d;
    }

    public void updateProductDetail(ProductDetail d) {
        String sql = "UPDATE product_details SET cpu=?, ram=?, storage=?, gpu=?, unit=?, quantity=? WHERE product_detail_id=?";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setString(1, d.getCpu());
            ps.setString(2, d.getRam());
            ps.setString(3, d.getStorage());
            ps.setString(4, d.getGpu());
            ps.setString(5, d.getUnit() != null ? d.getUnit() : "piece");
            ps.setInt(6, d.getQuantity());
            ps.setInt(7, d.getProductDetailId());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<ProductDetail> getAllProductDetails() {
        List<ProductDetail> list = new ArrayList<>();
        String sql = "SELECT pd.*, p.product_name "
                + "FROM product_details pd "
                + "JOIN products p ON pd.product_id = p.product_id "
                + "WHERE p.status = 1";

        try (PreparedStatement ps = getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductDetail d = new ProductDetail();
                d.setProductDetailId(rs.getInt("product_detail_id"));
                d.setProductId(rs.getInt("product_id"));
                d.setCpu(rs.getString("cpu"));
                d.setRam(rs.getString("ram"));
                d.setStorage(rs.getString("storage"));
                d.setGpu(rs.getString("gpu"));
                d.setUnit(rs.getString("unit"));
                d.setQuantity(rs.getInt("quantity"));
                d.setProductName(rs.getString("product_name"));

                list.add(d);
            }
        } catch (Exception e) {
            System.err.println("Error in getAllProductDetails: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public void updateQuantity(int productDetailId, int quantityChange) {
        String sql = "UPDATE product_details SET quantity = quantity + ? WHERE product_detail_id = ?";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
            ps.setInt(1, quantityChange);
            ps.setInt(2, productDetailId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
