    /*
package db;
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class ConnectData {

    public static Connection conn = null;

    public static Connection getConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

         String url = "jdbc:sqlserver://MEONGUYENTU:1433;databaseName=building_management301;user=sa;password=1234567890;encrypt=true;trustServerCertificate=true;";




            conn = DriverManager.getConnection(url);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ConnectData.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ConnectData.class.getName()).log(Level.SEVERE, null, ex);
        }
        return conn;

    }

    public static void closeConnection() {
        try {
            if (!conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConnectData.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
