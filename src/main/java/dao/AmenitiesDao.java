/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package dao;

import db.ConnectData;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import models.Amenities;

/**
 *
 * @author KHANH
 */
public class AmenitiesDao {

    private Connection conn;

    public AmenitiesDao() {
        conn = ConnectData.getConnection();
    }

    // Thêm tiện ích từ giao diện Dashboard (dữ liệu truyền trực tiếp)
    public boolean addAmenitiesDashboard(String name, String description) throws SQLException {
        String sql = "INSERT INTO Amenities (Name, Description) VALUES (?, ?)";
        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setString(2, description);
            return stmt.executeUpdate() > 0;
        }
    }

    // Cập nhật tiện ích
    public int updateAmenities(Amenities amenities) {
        String sql = "UPDATE Amenities SET Name = ?, Description = ? WHERE AmenityId = ?";
        int check = 0;

        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, amenities.getName());
            stmt.setString(2, amenities.getDescription());
            stmt.setInt(3, amenities.getAmenityId());
            check = stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(); // Có thể ghi log tại đây thay vì in ra console
        }

        return check;
    }

    // Xóa tiện ích
    public boolean deleteAmenities(int amenityId) throws SQLException {
        String sql = "DELETE FROM Amenities WHERE AmenityId = ?";
        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, amenityId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Lấy tất cả tiện ích
    public List<Amenities> getAllAmenities() throws SQLException {
        List<Amenities> list = new ArrayList<>();
        String sql = "SELECT AmenityId, Name, Description FROM Amenities";
        try ( Statement stmt = conn.createStatement();  ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Amenities a = new Amenities();
                a.setAmenityId(rs.getInt("AmenityId"));
                a.setName(rs.getString("Name"));
                a.setDescription(rs.getString("Description"));
                list.add(a);
            }
        }
        return list;
    }

    // Lấy tiện ích theo ID
    public Amenities getAmenitiesById(int amenityId) throws SQLException {
        String sql = "SELECT * FROM Amenities WHERE AmenityId = ?";
        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, amenityId);
            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Amenities a = new Amenities();
                    a.setAmenityId(rs.getInt("AmenityId"));
                    a.setName(rs.getString("Name"));
                    a.setDescription(rs.getString("Description"));
                    return a;
                }
            }
        }
        return null;
    }

    // Lấy tiện ích liên quan đến một Maintenance cụ thể
    public List<Amenities> getAmenities(int maintenanceId) {
        List<Amenities> list = new ArrayList<>();
        String sql = "SELECT a.AmenityId, a.Name, a.Description "
                + "FROM MaintenanceScheduleAmenities msa "
                + "JOIN Amenities a ON msa.AmenityId = a.AmenityId "
                + "WHERE msa.MaintenanceId = ?";
        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, maintenanceId);
            try ( ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Amenities a = new Amenities();
                    a.setAmenityId(rs.getInt("AmenityId"));
                    a.setName(rs.getString("Name"));
                    a.setDescription(rs.getString("Description"));
                    list.add(a);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
