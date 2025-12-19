package Model;

/**
 * RolePermission model for laptop_wms_lite database
 * DB Schema: role_permission_id, role_id, permission_id
 */
public class RolePermission {
    private int rolePermissionId;
    private int roleId;
    private int permissionId;

    public RolePermission() {
    }

    public RolePermission(int rolePermissionId, int roleId, int permissionId) {
        this.rolePermissionId = rolePermissionId;
        this.roleId = roleId;
        this.permissionId = permissionId;
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
}
