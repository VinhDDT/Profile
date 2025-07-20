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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class PaginationDao {

    private Connection conn = null;

    public PaginationDao() {
        conn = ConnectData.getConnection();
    }

    public int PageFullOfDashBoard() {
        ResultSet rs = null;
        int allPage = 0, finalPage = 0;
        try {
            String sql = "select count (*) as Total from Users  inner join Roles on Users.RoleId = Roles.RoleId where UserId > 1 ";
            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                allPage = rs.getInt("Total");
            }
         
        } catch (SQLException ex) {
            Logger.getLogger(PaginationDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return allPage;
    }

    public int PageSearchOfDashBoard(String search) {
        ResultSet rs = null;
        int allPage = 0;
        try {
            String sql = "select count (*) as Total from Users  inner join Roles on Users.RoleId = Roles.RoleId where UserId > 1 and UserName like ? ";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, search);
            if (rs.next()) {
                allPage = rs.getInt("Total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(PaginationDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return allPage;
    }

    public int numberPageOfRole() {
        ResultSet rs = null;
        int allPage = 0;
        try {
            String sql = "select count  (*) as Total from Users  inner join Roles on Users.RoleId = Roles.RoleId where UserId > 1";
            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                allPage = rs.getInt("Total");
            }

        } catch (SQLException ex) {
            Logger.getLogger(PaginationDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return allPage;
    }

        public int PageFullRoomsOfDashBoard() {
        ResultSet rs = null;
        int allPage = 0, finalPage = 0;
        try {
            String sql = "select count (*) as Total from Rooms ";
            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                allPage = rs.getInt("Total");
            }
         
        } catch (SQLException ex) {
            Logger.getLogger(PaginationDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return allPage;
    }
}
