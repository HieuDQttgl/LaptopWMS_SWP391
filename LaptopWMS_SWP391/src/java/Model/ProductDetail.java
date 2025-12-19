package Model;

/**
 * ProductDetail model for laptop_wms_lite database
 * DB Schema: product_detail_id, product_id, cpu, ram, storage, gpu, unit,
 * quantity
 */
public class ProductDetail {

    private int productDetailId;
    private int productId;
    private String cpu;
    private String ram;
    private String storage;
    private String gpu;
    private String unit;
    private int quantity;

    // For display purposes
    private String productName;

    public ProductDetail() {
    }

    public int getProductDetailId() {
        return productDetailId;
    }

    public void setProductDetailId(int productDetailId) {
        this.productDetailId = productDetailId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
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

    public String getGpu() {
        return gpu;
    }

    public void setGpu(String gpu) {
        this.gpu = gpu;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
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

    // Helper method to get config string
    public String getConfig() {
        StringBuilder config = new StringBuilder();
        if (cpu != null && !cpu.isEmpty())
            config.append(cpu);
        if (ram != null && !ram.isEmpty()) {
            if (config.length() > 0)
                config.append(" / ");
            config.append(ram);
        }
        if (storage != null && !storage.isEmpty()) {
            if (config.length() > 0)
                config.append(" / ");
            config.append(storage);
        }
        return config.toString();
    }
}
