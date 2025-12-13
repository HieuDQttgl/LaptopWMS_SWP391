package Model;

import java.sql.Timestamp;
import java.util.List;

public class Order {
    
    private int orderId;
    private String orderCode;
    private String description;
    private Integer createdBy;
    private String orderStatus;
    private int customerId;
    private int supplierId;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    private List<OrderProduct> orderProducts;

    public Order() {
    }

    public Order(Integer orderId, String orderCode, String description, Integer createdBy, 
                 String orderStatus, Integer customerId, Integer supplierId, Timestamp createdAt, 
                 Timestamp updatedAt, List<OrderProduct> orderProducts) {
        this.orderId = orderId;
        this.orderCode = orderCode;
        this.description = description;
        this.createdBy = createdBy;
        this.orderStatus = orderStatus;
        this.customerId = customerId;
        this.supplierId = supplierId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.orderProducts = orderProducts;
    }


    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public Integer getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public List<OrderProduct> getOrderProducts() {
        return orderProducts;
    }

    public void setOrderProducts(List<OrderProduct> orderProducts) {
        this.orderProducts = orderProducts;
    }

    @Override
    public String toString() {
        return "Order{" + "orderId=" + orderId + ", orderCode=" + orderCode + ", orderStatus=" + orderStatus + ", customerId=" + customerId + ", supplierId=" + supplierId + '}';
    }
}