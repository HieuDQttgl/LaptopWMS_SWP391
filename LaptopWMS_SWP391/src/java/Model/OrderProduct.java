package Model;

import java.math.BigDecimal;

public class OrderProduct {

    private int orderProductId;
    private int orderId;
    private int productId;
    private int quantity;
    private BigDecimal unitPrice;

    public OrderProduct() {
    }

    // Constructor đầy đủ
    public OrderProduct(Integer orderProductId, Integer orderId, Integer productId, Integer quantity, BigDecimal unitPrice) {
        this.orderProductId = orderProductId;
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    // --- Getters và Setters ---
    
    public int getOrderProductId() {
        return orderProductId;
    }

    public void setOrderProductId(int orderProductId) {
        this.orderProductId = orderProductId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }
    
    @Override
    public String toString() {
        return "OrderProduct{" + "orderProductId=" + orderProductId + ", productId=" + productId + ", quantity=" + quantity + ", unitPrice=" + unitPrice + '}';
    }
}