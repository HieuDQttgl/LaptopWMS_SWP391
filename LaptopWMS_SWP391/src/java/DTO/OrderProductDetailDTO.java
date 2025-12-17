package DTO;

import java.math.BigDecimal;

public class OrderProductDetailDTO {

    private Integer orderProductId;
    private Integer productDetailId;
    private Integer quantity;
    private BigDecimal unitPrice;
    
    private String productName;
    
    private String ram;
    private String storage;
    private String cpu;
    private String gpu;
    private Double screen;

    public OrderProductDetailDTO() {
    }

    public OrderProductDetailDTO(Integer orderProductId, Integer productDetailId, String productName, 
                                 String ram, String storage, String cpu, String gpu, Double screen,
                                 Integer quantity, BigDecimal unitPrice) {
        this.orderProductId = orderProductId;
        this.productDetailId = productDetailId;
        this.productName = productName;
        this.ram = ram;
        this.storage = storage;
        this.cpu = cpu;
        this.gpu = gpu;
        this.screen = screen;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public Integer getOrderProductId() {
        return orderProductId;
    }

    public void setOrderProductId(Integer orderProductId) {
        this.orderProductId = orderProductId;
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

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public String getStorage() {
        return storage;
    }

    public void setStorage(String storage) {
        this.storage = storage;
    }

    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    public String getGpu() {
        return gpu;
    }

    public void setGpu(String gpu) {
        this.gpu = gpu;
    }

    public Double getScreen() {
        return screen;
    }

    public void setScreen(Double screen) {
        this.screen = screen;
    }
    
    public String getFullSpecs() {
        return String.format("%s, %s, %s, %s, %.1f\"", cpu, ram, storage, gpu, screen);
    }
    
    public BigDecimal getSubTotal() {
        return unitPrice != null && quantity != null ? 
               unitPrice.multiply(new BigDecimal(quantity)) : BigDecimal.ZERO;
    }
}