/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.ConnectData;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Buildings;

/**
 *
 * @author $Do Dang Khoa - CE181988
 */
public class BuildingDao {

    private Connection conn = null;

    public BuildingDao() {
        conn = ConnectData.getConnection();
    }

    public List<Buildings> getAllBuiding() {
        List<Buildings> list = new ArrayList<>();
        String sql = "Select * from Buildings";
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);
            while(rs.next()) {
                Buildings b = new Buildings();
                b.setBuildingId(rs.getInt("BuildingId"));
                b.setBuildingName(rs.getString("BuildingName"));
                b.setAddress(rs.getString("Address"));
                b.setLocation(rs.getString("Location"));
                b.setDescription(rs.getString("Description"));
                list.add(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BuildingDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
