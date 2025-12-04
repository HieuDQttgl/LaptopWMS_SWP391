/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import Model.Role;
import java.util.ArrayList;
import java.util.List;

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
                    rs.getString("status")
            );
            list.add(r);
        }
        return list;
    }

    public boolean updateStatus(int roleId, String newStatus) throws Exception {
        String sql = "UPDATE roles SET status=? WHERE role_id=?";
        PreparedStatement ps = getConnection().prepareStatement(sql);
        ps.setString(1, newStatus);
        ps.setInt(2, roleId);
        return ps.executeUpdate() > 0;
    }

    public Role getRoleById(int roleId) throws Exception {
        String sql = "SELECT * FROM roles WHERE role_id = ?";
        PreparedStatement ps = getConnection().prepareStatement(sql);
        ps.setInt(1, roleId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new Role(
                    rs.getInt("role_id"),
                    rs.getString("role_name"),
                    rs.getString("status")
            );
        }

        return null; 
    }

}
