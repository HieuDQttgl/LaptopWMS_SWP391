package DAO;

import static DAO.DBContext.getConnection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author super
 */
public class PermissionDAO extends DBContext {

    public List<String> getPermissionUrlsByRoleId(int roleId) {
        List<String> permissions = new ArrayList<>();
        String sql = "SELECT p.permission_url "
                + "FROM permissions p "
                + "JOIN role_permissions rp ON p.permission_id = rp.permission_id "
                + "WHERE rp.role_id = ?";

        try {
            PreparedStatement ps = getConnection().prepareStatement(sql);
            ps.setInt(1, roleId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                permissions.add(rs.getString("permission_url"));
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return permissions;
    }
}
