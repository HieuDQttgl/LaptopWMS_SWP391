package Model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 *
 * @author super
 */
public class Announcement {

    private int id;
    private int senderId;
    private String senderName;
    private String senderRole;
    private String content;
    private Timestamp createdAt;

    public Announcement(int id, int senderId, String senderName, String senderRole, String content, Timestamp createdAt) {
        this.id = id;
        this.senderId = senderId;
        this.senderName = senderName;
        this.senderRole = senderRole;
        this.content = content;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public int getSenderId() {
        return senderId;
    }

    public String getSenderName() {
        return senderName;
    }

    public String getSenderRole() {
        return senderRole;
    }

    public String getContent() {
        return content;
    }

    public String getFormattedDate() {
        if (createdAt == null) {
            return "";
        }
        return new SimpleDateFormat("MMM d, HH:mm").format(createdAt);
    }
}
