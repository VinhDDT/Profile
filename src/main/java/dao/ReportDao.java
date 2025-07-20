/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import db.ConnectData;
import static db.ConnectData.conn;
import java.sql.Connection;
import models.Report;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author KHANH
 */

public class ReportDao {

    public List<Report> getAllReports() throws Exception {
        List<Report> list = new ArrayList<>();

        String sql = "SELECT * FROM RoomReports";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Report r = new Report();
                r.setReportId(rs.getInt("ReportId"));
                r.setRoomId(rs.getInt("RoomId"));
                r.setReportedByCustomerId(rs.getInt("ReportedByCustomerId"));
                r.setReportedByUserId(rs.getInt("ReportedByUserId"));
                r.setReportTime(rs.getTimestamp("ReportTime"));
                r.setDescription(rs.getString("Description"));
                r.setStatus(rs.getString("Status"));
                r.setHandledBy(rs.getInt("HandledBy"));
                r.setHandledTime(rs.getTimestamp("HandledTime"));
                r.setNotes(rs.getString("Notes"));

                list.add(r);
            }
        }

        return list;
    }
    public int updateReport(Report report) {
    int cnt = 0;
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        conn = ConnectData.getConnection();

        String sql = "UPDATE RoomReports SET " +
                     "RoomId = ?, " +
                     "ReportedByCustomerId = ?, " +
                     "ReportedByUserId = ?, " +
                     "ReportTime = ?, " +
                     "Description = ?, " +
                     "Status = ?, " +
                     "HandledBy = ?, " +
                     "HandledTime = ?, " +
                     "Notes = ? " +
                     "WHERE ReportId = ?";

        ps = conn.prepareStatement(sql);

        ps.setInt(1, report.getRoomId());
        ps.setObject(2, report.getReportedByCustomerId(), java.sql.Types.INTEGER);
        ps.setObject(3, report.getReportedByUserId(), java.sql.Types.INTEGER);
        ps.setTimestamp(4, report.getReportTime());
        ps.setString(5, report.getDescription());
        ps.setString(6, report.getStatus());
        ps.setObject(7, report.getHandledBy(), java.sql.Types.INTEGER);
        ps.setTimestamp(8, report.getHandledTime());
        ps.setString(9, report.getNotes());
        ps.setInt(10, report.getReportId());

        cnt = ps.executeUpdate();

    } catch (SQLException ex) {
        Logger.getLogger(ReportDao.class.getName()).log(Level.SEVERE, null, ex);
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(ReportDao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    return cnt;
}

     public boolean insertReport(Report report) {
        String sql = "INSERT INTO Reports (RoomId, ReportedByCustomerId, ReportedByUserId, ReportTime, Description, Status) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConnectData.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, report.getRoomId());
            ps.setInt(2, report.getReportedByCustomerId());
            ps.setInt(3, report.getReportedByUserId());
            ps.setTimestamp(4, report.getReportTime());
            ps.setString(5, report.getDescription());
            ps.setString(6, report.getStatus());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}


   


