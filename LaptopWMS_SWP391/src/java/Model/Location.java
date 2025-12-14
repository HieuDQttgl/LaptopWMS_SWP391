package Model;

import java.sql.Timestamp;

public class Location {
    private int locationId;
    private String locationName;
    private String address;
    private String description;
    private Timestamp createdAt;

    public Location() {
    }

    public Location(int locationId, String locationName, String address, String description, Timestamp createdAt) {
        this.locationId = locationId;
        this.locationName = locationName;
        this.address = address;
        this.description = description;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Location{" + "locationId=" + locationId + ", locationName=" + locationName + ", address=" + address + ", description=" + description + ", createdAt=" + createdAt + '}';
    }
}