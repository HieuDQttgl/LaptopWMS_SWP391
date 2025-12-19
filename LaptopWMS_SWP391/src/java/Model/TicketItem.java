package Model;

/**
 * Model class for TicketItem entity
 * Represents individual product items within a ticket
 */
public class TicketItem {

    private int ticketItemId;
    private int ticketId;
    private int productDetailId;
    private int quantity;

    // For display purposes
    private String productName;
    private String productConfig; // e.g., "Core i7 / 16GB / 512GB"
    private int currentStock; // Current quantity in stock

    public TicketItem() {
    }

    // Getters and Setters
    public int getTicketItemId() {
        return ticketItemId;
    }

    public void setTicketItemId(int ticketItemId) {
        this.ticketItemId = ticketItemId;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public int getProductDetailId() {
        return productDetailId;
    }

    public void setProductDetailId(int productDetailId) {
        this.productDetailId = productDetailId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
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

    public int getCurrentStock() {
        return currentStock;
    }

    public void setCurrentStock(int currentStock) {
        this.currentStock = currentStock;
    }
}
