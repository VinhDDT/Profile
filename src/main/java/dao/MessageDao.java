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
import models.Customers;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class MessageDao {

    private Connection conn = null;

    public MessageDao() {
        conn = ConnectData.getConnection();

    }

    public int saveMessageStaffOn(int customerId, int staffId, String senderType, String messageContent) {
        LocalDateTime now = LocalDateTime.now();

        try {
            String sql = "INSERT INTO Messages \n"
                    + "(CustomerId, StaffId, SenderType, MessageContent, SentAt) \n"
                    + "VALUES (?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, customerId);
            pst.setInt(2, staffId);
            pst.setString(3, senderType);
            pst.setString(4, messageContent);
            pst.setTimestamp(5, Timestamp.valueOf(now));
            return pst.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return 0;
    }

    public int saveMessageStaffOff(int customerId, String senderType, String messageContent) {
        LocalDateTime now = LocalDateTime.now();

        try {
            String sql = "INSERT INTO Messages \n"
                    + "(CustomerId, SenderType, MessageContent, SentAt) \n"
                    + "VALUES (?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, customerId);
            pst.setString(2, senderType);
            pst.setString(3, messageContent);
            pst.setTimestamp(4, Timestamp.valueOf(now));
            return pst.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return 0;
    }

    public boolean updateNullStaff(int staffId) {
        String sql = "UPDATE Messages SET StaffId = ? WHERE StaffId IS NULL";

        try (
                 PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, staffId);
            int rows = ps.executeUpdate();
            System.out.println("Đã cập nhật " + rows + " dòng.");
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Customers> getRecentSenders() {
                    List<Customers> list = new ArrayList<>();

        try {
            String sql = "SELECT c.customerId, c.UserName, MAX(m.SentAt) AS lastTime\n"
                    + "        FROM Messages m\n"
                    + "        JOIN Customers c ON m.customerId = c.customerId\n"
                    + "        GROUP BY c.customerId, c.UserName\n"
                    + "        ORDER BY lastTime DESC";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Customers c = new Customers();
                c.setCustomerId(rs.getInt("customerId"));
                c.setUserName(rs.getString("UserName"));
                list.add(c);
                
                
            }   } catch (SQLException ex) {
            Logger.getLogger(MessageDao.class.getName()).log(Level.SEVERE, null, ex);
        } return list;
}               


}