package DAO;

import Model.Permission;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import Model.Role;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * RoleDAO - updated for laptop_wms_lite database
 * DB has no status column in roles table, so we default status to 'active'
 */
public class RoleDAO extends DBContext {

    public List<Role> getAllRoles() throws Exception {
        List<Role> list = new ArrayList<>();
        String sql = "SELECT * FROM roles";

        PreparedStatement ps = getConnection().prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Role r = new Role(
                    rs.getInt("role_id"),
                    rs.getString("role_name"),
                    rs.getString("role_description"));
            r.setStatus("active"); // Default status since column doesn't exist
            list.add(r);
        }
        return list;
    }

    public Role getRoleById(int roleId) throws Exception {
        String sql = "SELECT * FROM roles WHERE role_id = ?";
        PreparedStatement ps = getConnection().prepareStatement(sql);
        ps.setInt(1, roleId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Role r = new Role(
                    rs.getInt("role_id"),
                    rs.getString("role_name"),
                    rs.getString("role_description"));
            r.setStatus("active");
            return r;
        }

        return null;
    }

    public List<Permission> getAllPermissions() throws Exception {
        List<Permission> list = new ArrayList<>();
        String sql = "SELECT * FROM permissions";

        PreparedStatement ps = getConnection().prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Permission p = new Permission(
                    rs.getInt("permission_id"),
                    rs.getString("permission_url"),
                    rs.getString("permission_description"));
            list.add(p);
        }
        return list;
    }

    public Set<Integer> getPermissionIdsByRole(int roleId) throws Exception {
        Set<Integer> set = new HashSet<>();

        String sql = "SELECT permission_id FROM role_permissions WHERE role_id = ?";
        PreparedStatement ps = getConnection().prepareStatement(sql);
        ps.setInt(1, roleId);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            set.add(rs.getInt("permission_id"));
        }
        return set;
    }

    public void updateRolePermissions(int roleId, List<Integer> permissionIds) throws Exception {
        String deleteSql = "DELETE FROM role_permissions WHERE role_id = ?";
        String insertSql = "INSERT INTO role_permissions (role_id, permission_id) VALUES (?, ?)";

        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement psDel = conn.prepareStatement(deleteSql)) {
                psDel.setInt(1, roleId);
                psDel.executeUpdate();
            }

            try (PreparedStatement psIns = conn.prepareStatement(insertSql)) {
                for (int pid : permissionIds) {
                    psIns.setInt(1, roleId);
                    psIns.setInt(2, pid);
                    psIns.addBatch();
                }
                psIns.executeBatch();
            }

            conn.commit();
        } catch (Exception e) {
            if (conn != null)
                conn.rollback();
            throw e;
        } finally {
            if (conn != null)
                conn.close();
        }
    }

    public Role getRoleByName(String roleName) throws Exception {
        String sql = "SELECT * FROM roles WHERE role_name = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, roleName);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Role r = new Role(
                            rs.getInt("role_id"),
                            rs.getString("role_name"),
                            rs.getString("role_description"));
                    r.setStatus("active");
                    return r;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return null;
    }

    public boolean addRole(String roleName, String roleDescription) throws Exception {
        if (getRoleByName(roleName) != null) {
            return false;
        }

        String sql = "INSERT INTO roles (role_name, role_description) VALUES (?, ?)";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, roleName);
            ps.setString(2, roleDescription);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public int getTotalRolesCount() {
        String sql = "SELECT COUNT(*) FROM roles";
        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Role> getRolesByPage(int page, int pageSize) {
        List<Role> list = new ArrayList<>();
        String sql = "SELECT * FROM roles ORDER BY role_id LIMIT ? OFFSET ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, pageSize);
            ps.setInt(2, (page - 1) * pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Role r = new Role(
                            rs.getInt("role_id"),
                            rs.getString("role_name"),
                            rs.getString("role_description"));
                    r.setStatus("active");
                    list.add(r);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
