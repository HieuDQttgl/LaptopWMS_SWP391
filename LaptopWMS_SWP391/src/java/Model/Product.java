package Model;

import java.util.ArrayList;
import java.util.List;

/**
 * Product model for laptop_wms_lite database
 * DB Schema: product_id, product_name, brand, category, status
 */
public class Product {

    private int productId;
    private String productName;
    private String brand;
    private String category;
    private boolean status;
    private int totalQuantity;

    private List<ProductDetail> detailsList = new ArrayList<>();

    public Product() {
    }

    public void addDetail(ProductDetail detail) {
        this.detailsList.add(detail);
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public List<ProductDetail> getDetailsList() {
        return detailsList;
    }

    public void setDetailsList(List<ProductDetail> detailsList) {
        this.detailsList = detailsList;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }
}
