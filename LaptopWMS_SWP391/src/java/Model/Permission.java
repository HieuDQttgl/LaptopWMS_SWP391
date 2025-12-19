package Model;

/**
 * Permission model for laptop_wms_lite database
 * DB Schema: permission_id, permission_url, permission_description
 */
public class Permission {

    private int permissionId;
    private String permissionURL;
    private String permissionDescription;

    public Permission() {
    }

    public Permission(int permissionId, String permissionURL, String permissionDescription) {
        this.permissionId = permissionId;
        this.permissionURL = permissionURL;
        this.permissionDescription = permissionDescription;
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
}
