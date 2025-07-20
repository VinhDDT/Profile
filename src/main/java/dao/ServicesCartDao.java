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
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Customers;
import models.Rooms;
import models.Services;
import models.ServicesCart;

/**
 *
 * @author $Do Dang Khoa - CE181988
 */
public class ServicesCartDao {

    private Connection conn = null;

    public ServicesCartDao() {
        conn = ConnectData.getConnection();
    }

    public List<ServicesCart> getAllServicesCartForCustomer(int id) {
        List<ServicesCart> list = new ArrayList<>();
        String sql = "SELECT sc.CartId, c.CustomerId, s.ServiceName, sc.OrderDate, sc.Status, sc.Notes, r.RoomNumber "
                + "FROM ServiceCart sc "
                + "INNER JOIN Customers c ON c.CustomerId = sc.CustomerId "
                + "INNER JOIN Services s ON s.ServiceId = sc.ServiceId "
                + "INNER JOIN Rooms r ON r.RoomId = sc.RoomId "
                + "WHERE sc.CustomerId = ?";
        ResultSet rs = null;

        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, id);
            rs = pst.executeQuery();

            while (rs.next()) {
                ServicesCart sc = new ServicesCart();
                sc.setCartId(rs.getInt("CartId"));
                sc.setCustomerId(rs.getInt("CustomerId"));
                sc.setOrderDate(rs.getTimestamp("OrderDate").toLocalDateTime());
                sc.setStatus(rs.getString("Status"));
                sc.setNotes(rs.getString("Notes"));

                Services s = new Services();
                s.setServiceName(rs.getString("ServiceName"));
                sc.setService(s);

                Rooms r = new Rooms();
                r.setRoomNumber(rs.getString("RoomNumber"));
                sc.setRoom(r);

                list.add(sc);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServicesCartDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public int addServiceOrder(int customerId, int ServiceId, String status, String notes, int RoomId) {
        int cmt = 0;
        try {
            String sql = "insert into ServicesCart (CustomerId, ServiceId, OrderDate, Status, Notes) Value(?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, customerId);
            pst.setInt(2, ServiceId);
            pst.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
            pst.setString(4, status);
            pst.setString(5, notes);
            cmt = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ServicesCartDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cmt;
    }
}
