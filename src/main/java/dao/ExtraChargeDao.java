/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.ConnectData;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.ExtraCharge;

/**
 *
 * @author $Do Dang Khoa - CE181988
 */
public class ExtraChargeDao {

    private Connection conn = null;

    public ExtraChargeDao() {
        conn = ConnectData.getConnection();
    }

    public List<ExtraCharge> getAllExtraCharge() {
        List<ExtraCharge> list = new ArrayList<>();
        try {
            String sql = "Select * from ExtraCharge";
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                ExtraCharge e = new ExtraCharge();
                e.setExtraChargeId(rs.getInt("ExtraChargeId"));
                e.setBookingId(rs.getInt("BookingId"));
                e.setChargeType(rs.getString("ChargeType"));
                e.setQuantity(rs.getInt("Quantity"));
                e.setUnitPrice(rs.getLong("UnitPrice"));
                e.setStartTime(rs.getTimestamp("StartTime").toLocalDateTime());
                e.setEndTime(rs.getTimestamp("EndTime").toLocalDateTime());
                list.add(e);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ExtraChargeDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public boolean insertExtraCharge(ExtraCharge ec) {
        String sql = "INSERT INTO ExtraCharge (BookingId, ChargeType, Quantity, UnitPrice, StartTime, EndTime) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            Connection conn = ConnectData.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, ec.getBookingId());
            ps.setString(2, ec.getChargeType());
            ps.setInt(3, ec.getQuantity());
            ps.setLong(4, ec.getUnitPrice()); // BIGINT trong SQL → long trong Java
            ps.setTimestamp(5, Timestamp.valueOf(ec.getStartTime()));
            ps.setTimestamp(6, Timestamp.valueOf(ec.getEndTime()));

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public LocalDateTime getLatestExtraChargeEndTime(int bookingId) {
        String sql = "SELECT TOP 1 EndTime FROM ExtraCharge WHERE BookingId = ? ORDER BY EndTime DESC";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getTimestamp("EndTime").toLocalDateTime();
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ExtraChargeDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null; // Không có ExtraCharge nào
    }

}
