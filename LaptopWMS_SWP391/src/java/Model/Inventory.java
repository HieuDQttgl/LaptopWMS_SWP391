/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Timestamp;

/**
 *
 * @author ASUS
 */
public class Inventory {
    private int inventoryId;
    private int productId;
    private int locationId;
    private int stockQuantity;
    private Integer actualStockQuantity;
    private Timestamp lastUpdated;

    public Inventory() {
    }

    public Inventory(int inventoryId, int productId, int locationId, int stockQuantity, Integer actualStockQuantity, Timestamp lastUpdated) {
        this.inventoryId = inventoryId;
        this.productId = productId;
        this.locationId = locationId;
        this.stockQuantity = stockQuantity;
        this.actualStockQuantity = actualStockQuantity;
        this.lastUpdated = lastUpdated;
    }

    public int getInventoryId() {
        return inventoryId;
    }

    public void setInventoryId(int inventoryId) {
        this.inventoryId = inventoryId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public Integer getActualStockQuantity() {
        return actualStockQuantity;
    }

    public void setActualStockQuantity(Integer actualStockQuantity) {
        this.actualStockQuantity = actualStockQuantity;
    }

    public Timestamp getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Timestamp lastUpdated) {
        this.lastUpdated = lastUpdated;
    }
    
}
