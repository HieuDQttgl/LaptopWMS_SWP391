package DTO;

import java.sql.Timestamp;

public class InventoryDTO {
    private int inventoryId;
    private int productId;
     private int locationId; 
    private String productName;
    private String locationName;
    private int stockQuantity;
    private Timestamp lastUpdated;

    public InventoryDTO(int inventoryId, int productId, String productName, String locationName, int stockQuantity, Timestamp lastUpdated) {
        this.inventoryId = inventoryId;
        this.productId = productId;
        this.productName = productName;
        this.locationName = locationName;
        this.stockQuantity = stockQuantity;
        this.lastUpdated = lastUpdated;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
    

    public int getInventoryId() {
        return inventoryId;
    }

    public void setInventoryId(int inventoryId) {
        this.inventoryId = inventoryId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public Timestamp getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Timestamp lastUpdated) {
        this.lastUpdated = lastUpdated;
    }
}
