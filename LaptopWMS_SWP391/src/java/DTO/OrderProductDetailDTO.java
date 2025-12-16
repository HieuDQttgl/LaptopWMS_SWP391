package DTO;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class OrderProductDetailDTO {
    
    private Integer orderProductId;
    private Integer productId;
    private Integer quantity;
    private BigDecimal unitPrice;
    private String productName;
    
    private BigDecimal subTotal; 

    public OrderProductDetailDTO() {
    }

    public OrderProductDetailDTO(Integer orderProductId, Integer productId, String productName, Integer quantity, BigDecimal unitPrice) {
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


    public Integer getOrderProductId() {
        return orderProductId;
    }

    public void setOrderProductId(Integer orderProductId) {
        this.orderProductId = orderProductId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
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

    public BigDecimal getSubTotal() {
        return subTotal;
    }
    
}