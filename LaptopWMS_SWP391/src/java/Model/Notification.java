/*
 * Notification Model for Laptop WMS
 */
package Model;

import java.sql.Timestamp;

/**
 * Represents a notification in the system.
 * Used for sending in-app notifications to admins instead of emails.
 */
public class Notification {
    private int notificationId;
    private int userId; // Admin user who will receive the notification
    private String type; // Type: password_reset, etc.
    private String title;
    private String message;
    private Integer relatedUserId; // User related to this notification
    private boolean isRead;
    private Timestamp createdAt;
    private Timestamp readAt;

    // Additional fields for display purposes
    private String relatedUserFullName;
    private String relatedUserEmail;
    private String relatedUserUsername;

    public Notification() {
    }

    public Notification(int userId, String type, String title, String message, Integer relatedUserId) {
        this.userId = userId;
        this.type = type;
        this.title = title;
        this.message = message;
        this.relatedUserId = relatedUserId;
        this.isRead = false;
    }

    // Getters and Setters
    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Integer getRelatedUserId() {
        return relatedUserId;
    }

    public void setRelatedUserId(Integer relatedUserId) {
        this.relatedUserId = relatedUserId;
    }

    public boolean isRead() {
        return isRead;
    }

    public void setRead(boolean isRead) {
        this.isRead = isRead;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getReadAt() {
        return readAt;
    }

    public void setReadAt(Timestamp readAt) {
        this.readAt = readAt;
    }

    public String getRelatedUserFullName() {
        return relatedUserFullName;
    }

    public void setRelatedUserFullName(String relatedUserFullName) {
        this.relatedUserFullName = relatedUserFullName;
    }

    public String getRelatedUserEmail() {
        return relatedUserEmail;
    }

    public void setRelatedUserEmail(String relatedUserEmail) {
        this.relatedUserEmail = relatedUserEmail;
    }

    public String getRelatedUserUsername() {
        return relatedUserUsername;
    }

    public void setRelatedUserUsername(String relatedUserUsername) {
        this.relatedUserUsername = relatedUserUsername;
    }

    @Override
    public String toString() {
        return "Notification{" +
                "notificationId=" + notificationId +
                ", userId=" + userId +
                ", type='" + type + '\'' +
                ", title='" + title + '\'' +
                ", isRead=" + isRead +
                ", createdAt=" + createdAt +
                '}';
    }
}
