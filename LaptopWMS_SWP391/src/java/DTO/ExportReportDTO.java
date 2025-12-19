/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import java.sql.Date;

/**
 *
 * @author ASUS
 */
public class ExportReportDTO {
    private String orderCode;
    private java.sql.Date createdAt;
    private String customerName;
    private String saleName;
    private double revenue;
    private String status;


    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getSaleName() {
        return saleName;
    }

    public void setSaleName(String saleName) {
        this.saleName = saleName;
    }

    public double getRevenue() {
        return revenue;
    }

    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public static class TopProduct {
        private String productName;
        private int totalQuantity;

        public TopProduct(String productName, int totalQuantity) {
            this.productName = productName;
            this.totalQuantity = totalQuantity;
        }
        public String getProductName() { return productName; }
        public int getTotalQuantity() { return totalQuantity; }
    }

    public static class StaffRevenue {
        private String staffName;
        private double totalRevenue;

        public StaffRevenue(String staffName, double totalRevenue) {
            this.staffName = staffName;
            this.totalRevenue = totalRevenue;
        }
        public String getStaffName() { return staffName; }
        public double getTotalRevenue() { return totalRevenue; }
    }
    
}
