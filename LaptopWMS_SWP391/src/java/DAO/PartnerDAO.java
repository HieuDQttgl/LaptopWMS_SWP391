/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import static DAO.DBContext.getConnection;
import Model.Partners;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;

/**
 *
 * @author Admin
 */
public class PartnerDAO {

    public List<Partners> getCustomers() {
        List<Partners> list = new ArrayList<>();
        String sql = "SELECT * FROM partners WHERE type = 2 AND status = 'active'";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Partners p = new Partners();
                p.setPartnerId(rs.getInt("partner_id"));
                p.setType(rs.getInt("type"));
                p.setPartnerName(rs.getString("partner_name"));
                p.setPartnerEmail(rs.getString("partner_email"));
                p.setPartnerPhone(rs.getString("partner_phone"));
                p.setStatus(rs.getString("status"));

                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Partners> getSuppliers() {
        List<Partners> list = new ArrayList<>();
        String sql = "SELECT * FROM partners WHERE type = 1 AND status = 'active'";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Partners p = new Partners();
                p.setPartnerId(rs.getInt("partner_id"));
                p.setType(rs.getInt("type"));
                p.setPartnerName(rs.getString("partner_name"));
                p.setPartnerEmail(rs.getString("partner_email"));
                p.setPartnerPhone(rs.getString("partner_phone"));
                p.setStatus(rs.getString("status"));

                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Partners getPartnerById(int id) {
        String sql = "SELECT * FROM partners WHERE partner_id = ?";
        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Partners p = new Partners();
                p.setPartnerId(rs.getInt("partner_id"));
                p.setType(rs.getInt("type"));
                p.setPartnerName(rs.getString("partner_name"));
                p.setPartnerEmail(rs.getString("partner_email"));
                p.setPartnerPhone(rs.getString("partner_phone"));
                p.setStatus(rs.getString("status"));
                return p;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addPartner(Partners p) {
        String sql = "INSERT INTO partners (type, partner_name, partner_email, partner_phone, status) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {

            ps.setInt(1, p.getType());
            ps.setString(2, p.getPartnerName());
            ps.setString(3, p.getPartnerEmail());
            ps.setString(4, p.getPartnerPhone());
            ps.setString(5, p.getStatus());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void switchStatus(int id, String currentStatus) {
        String sql = "UPDATE partners SET status = ? WHERE partner_id = ?";

        String newStatus = "active".equals(currentStatus) ? "inactive" : "active";

        try (PreparedStatement ps = getConnection().prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, id);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
