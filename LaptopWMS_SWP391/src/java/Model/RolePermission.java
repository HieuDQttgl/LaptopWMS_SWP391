/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.security.Timestamp;

/**
 *
 * @author Admin
 */
public class RolePermission {
    private int rolePermissionId;
    private int roleId;
    private int permissionId;
    private Timestamp grantedAt;
    private int grantedBy;

    public RolePermission() {
    }

    public RolePermission(int rolePermissionId, int roleId, int permissionId, Timestamp grantedAt, Integer grantedBy) {
        this.rolePermissionId = rolePermissionId;
        this.roleId = roleId;
        this.permissionId = permissionId;
        this.grantedAt = grantedAt;
        this.grantedBy = grantedBy;
    }

    public int getRolePermissionId() {
        return rolePermissionId;
    }

    public void setRolePermissionId(int rolePermissionId) {
        this.rolePermissionId = rolePermissionId;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getPermissionId() {
        return permissionId;
    }

    public void setPermissionId(int permissionId) {
        this.permissionId = permissionId;
    }

    public Timestamp getGrantedAt() {
        return grantedAt;
    }

    public void setGrantedAt(Timestamp grantedAt) {
        this.grantedAt = grantedAt;
    }

    public int getGrantedBy() {
        return grantedBy;
    }

    public void setGrantedBy(int grantedBy) {
        this.grantedBy = grantedBy;
    }
    
}
