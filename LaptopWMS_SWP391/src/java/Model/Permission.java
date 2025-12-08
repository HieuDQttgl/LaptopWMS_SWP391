/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Timestamp;

/**
 *
 * @author Admin
 */
public class Permission {
    private int permissionId;
    private String permissionURL;
    private String permissionDescription;
    private String module;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Permission() {
    }

    public Permission(int permissionId, String permissionName, String permissionDescription, String module, Timestamp createdAt, Timestamp updatedAt) {
        this.permissionId = permissionId;
        this.permissionURL = permissionName;
        this.permissionDescription = permissionDescription;
        this.module = module;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getPermissionId() {
        return permissionId;
    }

    public void setPermissionId(int permissionId) {
        this.permissionId = permissionId;
    }

    public String getPermissionURL() {
        return permissionURL;
    }

    public void setPermissionURL(String permissionURL) {
        this.permissionURL = permissionURL;
    }

    public String getPermissionDescription() {
        return permissionDescription;
    }

    public void setPermissionDescription(String permissionDescription) {
        this.permissionDescription = permissionDescription;
    }

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    

}
