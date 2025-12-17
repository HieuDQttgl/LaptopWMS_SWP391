package Model;

import java.math.BigDecimal;

public class OrderProduct {

    private Integer orderProductId;
    private Integer orderId;
    private Integer productDetailId;
    private Integer quantity;
    private BigDecimal unitPrice;

    public OrderProduct() {
    }

    public OrderProduct(Integer orderProductId, Integer orderId, Integer productDetailId, Integer quantity, BigDecimal unitPrice) {
        this.orderProductId = orderProductId;
        this.orderId = orderId;
        this.productDetailId = productDetailId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    // --- Getters và Setters ---
    
    public Integer getOrderProductId() {
        return orderProductId;
    }

    public void setOrderProductId(Integer orderProductId) {
        this.orderProductId = orderProductId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getProductDetailId() {
        return productDetailId;
    }

    public void setProductDetailId(Integer productDetailId) {
        this.productDetailId = productDetailId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
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
        return "OrderProduct{" + "orderProductId=" + orderProductId + ", productDetailId=" + productDetailId + ", quantity=" + quantity + ", unitPrice=" + unitPrice + '}';
    }
}