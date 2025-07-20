/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.ConnectData;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class RoomReviewDao {

    private Connection conn = null;

    public RoomReviewDao() {
        conn = ConnectData.getConnection();
    }

    public int addReview(int roomId, int customerId, int rating, String comment) {
        int count = 0;
        try {
            String sql = "INSERT INTO RoomReviews (RoomId, CustomerId,  Rating, Comment, CreatedAt)\n"
                    + "VALUES (?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, roomId);
            pst.setInt(2, customerId);
            pst.setInt(3, rating);
            pst.setString(4, comment);
            LocalDateTime createAt = LocalDateTime.now();
            pst.setTimestamp(5, Timestamp.valueOf(createAt));
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(RoomReviewDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

}
