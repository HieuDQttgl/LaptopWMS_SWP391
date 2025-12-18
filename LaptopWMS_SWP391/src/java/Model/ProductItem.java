package Model;

public class ProductItem {
    private int itemId;
    private int productDetailId;
    private String serialNumber; 
    private String status;      
    private String itemNote;
    private String specSummary; 

    public ProductItem() {
    }

    public ProductItem(int itemId, int productDetailId, String serialNumber, String status, String itemNote) {
        this.itemId = itemId;
        this.productDetailId = productDetailId;
        this.serialNumber = serialNumber;
        this.status = status;
        this.itemNote = itemNote;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getProductDetailId() {
        return productDetailId;
    }

    public void setProductDetailId(int productDetailId) {
        this.productDetailId = productDetailId;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getItemNote() {
        return itemNote;
    }

    public void setItemNote(String itemNote) {
        this.itemNote = itemNote;
    }

    public String getSpecSummary() {
        return specSummary;
    }

    public void setSpecSummary(String specSummary) {
        this.specSummary = specSummary;
    }

}