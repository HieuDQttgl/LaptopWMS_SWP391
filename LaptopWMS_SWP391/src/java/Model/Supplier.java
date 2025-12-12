/*
 * Supplier Model for Laptop WMS
 */
package Model;

/**
 * Represents a supplier in the Laptop Warehouse Management System.
 * Suppliers provide laptops and other products to the warehouse.
 */
public class Supplier {

    private int supplierId;
    private String supplierName;
    private String supplierEmail;
    private String supplierPhone;
    private String status;

    /**
     * Default constructor
     */
    public Supplier() {
    }

    /**
     * Constructor with all fields
     */
    public Supplier(int supplierId, String supplierName, String supplierEmail,
            String supplierPhone, String status) {
        this.supplierId = supplierId;
        this.supplierName = supplierName;
        this.supplierEmail = supplierEmail;
        this.supplierPhone = supplierPhone;
        this.status = status;
    }

    // Getters and Setters

    public int getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getSupplierEmail() {
        return supplierEmail;
    }

    public void setSupplierEmail(String supplierEmail) {
        this.supplierEmail = supplierEmail;
    }

    public String getSupplierPhone() {
        return supplierPhone;
    }

    public void setSupplierPhone(String supplierPhone) {
        this.supplierPhone = supplierPhone;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Supplier{" +
                "supplierId=" + supplierId +
                ", supplierName='" + supplierName + '\'' +
                ", supplierEmail='" + supplierEmail + '\'' +
                ", supplierPhone='" + supplierPhone + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
