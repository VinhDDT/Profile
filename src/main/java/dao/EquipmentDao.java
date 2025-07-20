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
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Equipment;
import models.MaintenanceSchedule;
import models.MaintenanceStatuses;
import models.Rooms;
import models.Users;

/**
 *
 * @author KHANH
 */
public class EquipmentDao {

    private Connection conn = null;

    public EquipmentDao() {
        conn = ConnectData.getConnection();

    }

    public List<MaintenanceSchedule> getAllmMaintenance() {
        List<MaintenanceSchedule> list = new ArrayList<>();
        ResultSet rs = null;

        String sql = "		SELECT  \n"
                + " u.UserName, \n"
                + "    r.RoomNumber, \n"
                + "    e.EquipmentName, \n"
                + "    msch.Date, \n"
                + "    ms.StatusName\n"
                + "FROM MaintenanceSchedule msch\n"
                + "JOIN Users u ON msch.UserID = u.UserID\n"
                + "JOIN Equipment e ON msch.EquipmentID = e.EquipmentID\n"
                + "JOIN RoomEquipment re ON re.EquipmentID = e.EquipmentID\n"
                + "JOIN Rooms r  ON msch.MaintenanceID = r.RoomID -- JOIN trực tiếp phòng từ msch\n"
                + "JOIN MaintenanceStatuses ms ON msch.StatusID = ms.StatusID";

        try ( Statement st = conn.createStatement()) {
            rs = st.executeQuery(sql);

            while (rs.next()) {
                MaintenanceSchedule mash = new MaintenanceSchedule();

                Users user = new Users();
                user.setUserName(rs.getString("UserName"));
                mash.setUsers(user);

                Rooms room = new Rooms();
                room.setRoomNumber(rs.getString("RoomNumber"));
                mash.setRooms(room);

                Equipment eq = new Equipment();
                eq.setEquipmentName(rs.getString("EquipmentName"));
                mash.setEquipment(eq);
                Timestamp timestamp = rs.getTimestamp("Date");
                mash.setDate(timestamp.toLocalDateTime());
                LocalDateTime date = rs.getTimestamp("Date").toLocalDateTime();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
String formatted = date.format(formatter); // ✅ đúng
mash.setFormattedDate(formatted);          // Nếu bạn có setter


                MaintenanceStatuses maintenanceStatuses = new MaintenanceStatuses();
                maintenanceStatuses.setStatusName(rs.getString("StatusName"));
                mash.setMaintenanceStatuses(maintenanceStatuses);
                EquipmentDao dao = new EquipmentDao();
                

                list.add(mash);
            }
        } catch (SQLException ex) {
            Logger.getLogger(EquipmentDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

}
