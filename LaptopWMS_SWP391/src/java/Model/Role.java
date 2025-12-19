package Model;

/**
 * Role model for laptop_wms_lite database
 * DB Schema: role_id, role_name, role_description
 * Note: No status, created_at, updated_at columns in this database
 */
public class Role {
    private int roleId;
    private String roleName;
    private String roleDescription;

    // For backward compatibility with existing code
    private String status = "active";

    public Role() {
    }

    public Role(int roleId, String roleName, String roleDescription) {
        this.roleId = roleId;
        this.roleName = roleName;
        this.roleDescription = roleDescription;
    }

    public Role(int roleId, String roleName, String roleDescription, String status) {
        this.roleId = roleId;
        this.roleName = roleName;
        this.roleDescription = roleDescription;
        this.status = status;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleDescription() {
        return roleDescription;
    }

    public void setRoleDescription(String roleDescription) {
        this.roleDescription = roleDescription;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
