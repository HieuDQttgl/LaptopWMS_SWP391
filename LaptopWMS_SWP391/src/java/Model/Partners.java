/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Admin
 */
public class Partners {
   private int partnerId;
    private int type; 
    private String partnerName;
    private String partnerEmail;
    private String partnerPhone;
    private String status;

    public Partners() {
    }

    public Partners(int partnerId, int type, String partnerName, String partnerEmail, String partnerPhone, String status) {
        this.partnerId = partnerId;
        this.type = type;
        this.partnerName = partnerName;
        this.partnerEmail = partnerEmail;
        this.partnerPhone = partnerPhone;
        this.status = status;
    }

    public int getPartnerId() {
        return partnerId;
    }

    public void setPartnerId(int partnerId) {
        this.partnerId = partnerId;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getPartnerName() {
        return partnerName;
    }

    public void setPartnerName(String partnerName) {
        this.partnerName = partnerName;
    }

    public String getPartnerEmail() {
        return partnerEmail;
    }

    public void setPartnerEmail(String partnerEmail) {
        this.partnerEmail = partnerEmail;
    }

    public String getPartnerPhone() {
        return partnerPhone;
    }

    public void setPartnerPhone(String partnerPhone) {
        this.partnerPhone = partnerPhone;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

   

    
}
