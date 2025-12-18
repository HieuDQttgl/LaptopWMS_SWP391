package Model;

import java.sql.Timestamp;

public class Location {
    private int locationId;
    private String locationName;
    private String description;
    private String zone;
    private String aisle;
    private String rack;
    private String bin;
    private int capacity;
    private int currentUsage; // Calculated from inventory
    private boolean status;
    private Timestamp createdAt;

    public Location() {
    }

    public Location(int locationId, String locationName, String description, String zone,
            String aisle, String rack, String bin, int capacity, int currentUsage,
            boolean status, Timestamp createdAt) {
        this.locationId = locationId;
        this.locationName = locationName;
        this.description = description;
        this.zone = zone;
        this.aisle = aisle;
        this.rack = rack;
        this.bin = bin;
        this.capacity = capacity;
        this.currentUsage = currentUsage;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getZone() {
        return zone;
    }

    public void setZone(String zone) {
        this.zone = zone;
    }

    public String getAisle() {
        return aisle;
    }

    public void setAisle(String aisle) {
        this.aisle = aisle;
    }

    public String getRack() {
        return rack;
    }

    public void setRack(String rack) {
        this.rack = rack;
    }

    public String getBin() {
        return bin;
    }

    public void setBin(String bin) {
        this.bin = bin;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public int getCurrentUsage() {
        return currentUsage;
    }

    public void setCurrentUsage(int currentUsage) {
        this.currentUsage = currentUsage;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // Utility method to determine availability status
    public String getAvailabilityStatus() {
        if (!status) {
            return "Inactive";
        }
        if (currentUsage >= capacity) {
            return "Full";
        }
        return "Available";
    }

    @Override
    public String toString() {
        return "Location{" + "locationId=" + locationId + ", locationName=" + locationName +
                ", zone=" + zone + ", aisle=" + aisle + ", rack=" + rack + ", bin=" + bin +
                ", capacity=" + capacity + ", currentUsage=" + currentUsage + ", status=" + status + '}';
    }
}