/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import java.sql.Timestamp;


public class OrderSummary {
    private int totalOrders;
    private double totalValue;
    private Timestamp lastOrderDate;

    public OrderSummary() {
    }

    public OrderSummary(int totalOrders, double totalValue, Timestamp lastOrderDate) {
        this.totalOrders = totalOrders;
        this.totalValue = totalValue;
        this.lastOrderDate = lastOrderDate;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public double getTotalValue() {
        return totalValue;
    }

    public void setTotalValue(double totalValue) {
        this.totalValue = totalValue;
    }

    public Timestamp getLastOrderDate() {
        return lastOrderDate;
    }

    public void setLastOrderDate(Timestamp lastOrderDate) {
        this.lastOrderDate = lastOrderDate;
    }
    
    
    
}
