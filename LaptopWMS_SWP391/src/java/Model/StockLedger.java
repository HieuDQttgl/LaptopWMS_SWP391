package Model;

import java.sql.Timestamp;

/**
 * Model class for StockLedger entity
 * Records all stock changes for import/export history tracking
 */
public class StockLedger {

    private int ledgerId;
    private int productDetailId;
    private int ticketId;
    private int quantityChange;
    private int balanceAfter;
    private String type; // IMPORT or EXPORT
    private Timestamp createdAt;

    // For display purposes
    private String productName;
    private String productConfig;
    private String ticketCode;

    public StockLedger() {
    }

    // Getters and Setters
    public int getLedgerId() {
        return ledgerId;
    }

    public void setLedgerId(int ledgerId) {
        this.ledgerId = ledgerId;
    }

    public int getProductDetailId() {
        return productDetailId;
    }

    public void setProductDetailId(int productDetailId) {
        this.productDetailId = productDetailId;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public int getQuantityChange() {
        return quantityChange;
    }

    public void setQuantityChange(int quantityChange) {
        this.quantityChange = quantityChange;
    }

    public int getBalanceAfter() {
        return balanceAfter;
    }

    public void setBalanceAfter(int balanceAfter) {
        this.balanceAfter = balanceAfter;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductConfig() {
        return productConfig;
    }

    public void setProductConfig(String productConfig) {
        this.productConfig = productConfig;
    }

    public String getTicketCode() {
        return ticketCode;
    }

    public void setTicketCode(String ticketCode) {
        this.ticketCode = ticketCode;
    }
}
