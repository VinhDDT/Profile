/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.ConnectData;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Services;

/**
 *
 * @author $Do Dang Khoa - CE181988
 */
public class ServicesDao {

    private Connection conn = null;

    public ServicesDao() {
        conn = ConnectData.getConnection();
    }

    public List<Services> getAllServicesDashboard() {
        List<Services> list = new ArrayList<>();
        String sql = "Select * from Services";
        ResultSet rs = null;

        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Services s = new Services();
                s.setServiceId(rs.getInt("ServiceId"));
                s.setServiceName(rs.getString("ServiceName"));
                s.setDescription(rs.getString("Description"));
                s.setPrice(rs.getLong("Price"));
                s.setImageURL(rs.getString("ImageURL"));
                s.setIsActive(rs.getBoolean("IsActive"));  // hoặc rs.getBoolean nếu đổi sang boolean
                s.setUnitType(rs.getString("UnitType"));
                list.add(s);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ServicesDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Services> getAllServices() {
        List<Services> list = new ArrayList<>();
        String sql = "Select * from Services where IsActive = 1";
        ResultSet rs = null;

        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Services s = new Services();
                s.setServiceId(rs.getInt("ServiceId"));
                s.setServiceName(rs.getString("ServiceName"));
                s.setDescription(rs.getString("Description"));
                s.setPrice(rs.getLong("Price"));
                s.setImageURL(rs.getString("ImageURL"));
                s.setIsActive(rs.getBoolean("IsActive"));  // hoặc rs.getBoolean nếu đổi sang boolean
                s.setUnitType(rs.getString("UnitType"));
                list.add(s);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ServicesDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Services getServiceByIdDashboard(int id) {
        String sql = "Select * from Services where ServiceId = ?";
        ResultSet rs = null;
        Services s = null;
        PreparedStatement pst;
        try {
            pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                s = new Services();
                s.setServiceId(rs.getInt("ServiceId"));
                s.setServiceName(rs.getString("ServiceName"));
                s.setDescription(rs.getString("Description"));
                s.setPrice(rs.getLong("Price"));
                s.setImageURL(rs.getString("ImageURL"));
                s.setIsActive(rs.getBoolean("IsActive"));
                s.setUnitType(rs.getString("UnitType"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServicesDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return s;
    }

    //
    public Services getServiceById(int id) {
        String sql = "SELECT * FROM Services WHERE ServiceId = ? AND IsActive = 1";
        ResultSet rs = null;
        Services s = null;
        PreparedStatement pst;
        try {
            pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                s = new Services();
                s.setServiceId(rs.getInt("ServiceId"));
                s.setServiceName(rs.getString("ServiceName"));
                s.setDescription(rs.getString("Description"));
                s.setPrice(rs.getLong("Price"));
                s.setImageURL(rs.getString("ImageURL"));
                s.setIsActive(rs.getBoolean("IsActive"));
                s.setUnitType(rs.getString("UnitType"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServicesDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return s;
    }

    public int addServiceDashboard(Services service) {
        int cmt = 0;
        try {
            String sql = "insert into Services (ServiceName, UnitType, Description, Price, ImageURL, IsActive) Values(?,?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, service.getServiceName());
            pst.setString(2, service.getUnitType());
            pst.setString(3, service.getDescription());
            pst.setLong(4, service.getPrice());
            pst.setString(5, service.getImageURL());
            pst.setBoolean(6, false);
            cmt = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ServicesDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cmt;
    }

    public int editServiceByIdDashboard(Services service, int id) {
        int cmt = 0;
        try {
            String sql = "update Services Set ServiceName=?, UnitType=?, Description=?, Price=?, ImageURL=?, IsActive=? Where ServiceId=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, service.getServiceName());
            pst.setString(2, service.getUnitType());
            pst.setString(3, service.getDescription());
            pst.setLong(4, service.getPrice());
            pst.setString(5, service.getImageURL());
            pst.setBoolean(6, service.getIsActive());
            pst.setInt(7, id);
            cmt = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ServicesDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cmt;
    }

    public int deleteServiceByIdDashboard(int id) {
        int cmt = 0;
        try {
            String sql = "Delete from Services where ServiceId=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            cmt = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ServicesDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cmt;
    }
}
