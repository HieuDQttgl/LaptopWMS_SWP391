package Model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Model class for Ticket entity
 * Represents import/export tickets in the warehouse management system
 */
public class Ticket {

    private int ticketId;
    private String ticketCode;
    private String type; // IMPORT or EXPORT
    private String title;
    private String description;
    private String status; // PENDING, COMPLETED, CANCELLED
    private int createdBy;
    private Integer assignedKeeper;
    private Timestamp createdAt;
    private Timestamp processedAt;
    private String keeperNote;
    private Integer partnerId;

    // For display purposes
    private String creatorName;
    private String keeperName;
    private String partnerName;
    private List<TicketItem> items = new ArrayList<>();

    public Ticket() {
    }

    // Getters and Setters
    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public String getTicketCode() {
        return ticketCode;
    }

    public void setTicketCode(String ticketCode) {
        this.ticketCode = ticketCode;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public Integer getAssignedKeeper() {
        return assignedKeeper;
    }

    public void setAssignedKeeper(Integer assignedKeeper) {
        this.assignedKeeper = assignedKeeper;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getProcessedAt() {
        return processedAt;
    }

    public void setProcessedAt(Timestamp processedAt) {
        this.processedAt = processedAt;
    }

    public String getKeeperNote() {
        return keeperNote;
    }

    public void setKeeperNote(String keeperNote) {
        this.keeperNote = keeperNote;
    }

    public String getCreatorName() {
        return creatorName;
    }

    public void setCreatorName(String creatorName) {
        this.creatorName = creatorName;
    }

    public String getKeeperName() {
        return keeperName;
    }

    public void setKeeperName(String keeperName) {
        this.keeperName = keeperName;
    }

    public Integer getPartnerId() {
        return partnerId;
    }

    public void setPartnerId(Integer partnerId) {
        this.partnerId = partnerId;
    }

    public String getPartnerName() {
        return partnerName;
    }

    public void setPartnerName(String partnerName) {
        this.partnerName = partnerName;
    }

    public List<TicketItem> getItems() {
        return items;
    }

    public void setItems(List<TicketItem> items) {
        this.items = items;
    }

    public void addItem(TicketItem item) {
        this.items.add(item);
    }
}
