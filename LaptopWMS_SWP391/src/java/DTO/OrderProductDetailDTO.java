package DTO;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class OrderProductDetailDTO {
    
    private int orderProductId;
    private int productId;
    private int quantity;
    private BigDecimal unitPrice;
    private String productName;
    
    private BigDecimal subTotal; 

    public OrderProductDetailDTO() {
    }

    public OrderProductDetailDTO(int orderProductId, int productId, String productName, int quantity, BigDecimal unitPrice) {
        this.orderProductId = orderProductId;
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.unitPrice = unitPrice;

        if (unitPrice != null) {
            this.subTotal = unitPrice
                    .multiply(BigDecimal.valueOf(quantity))
                    .setScale(2, RoundingMode.HALF_UP);
        } else {
            this.subTotal = BigDecimal.ZERO;
        }
    }


    public int getOrderProductId() {
        return orderProductId;
    }

    public void setOrderProductId(int orderProductId) {
        this.orderProductId = orderProductId;
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

    public int getQuantity() {
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

    public BigDecimal getSubTotal() {
        return subTotal;
    }
    
}