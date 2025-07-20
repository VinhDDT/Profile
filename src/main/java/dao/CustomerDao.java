/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static dao.UserDao.md5;
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
public class CustomerDao {

    private Connection conn = null;

    public CustomerDao() {

        conn = ConnectData.getConnection();
    }

    public int loginCussForId(Customers acc) {
        try {
            String sql = "Select * from Customers where UserName=? and Password=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, acc.getUserName());
            pst.setString(2, md5(acc.getPassword()));
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getInt("CustomerId");
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, "Lỗi truy vấn đăng nhập", ex);
        }

        return 0;

    }

    public Customers getCustomerById(int id) {
        Customers customer = null;
        String sql = "SELECT UserName, FullName, Email, Phone, Status, AvatarUrl, Address, Gender, DateOfBirth, LastLogin\n"
                + "FROM Customers\n"
                + "WHERE CustomerID = ?";

        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, id);
            try ( ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    customer = new Customers();
                    customer.setUserName(rs.getString("UserName"));
                    customer.setFullName(rs.getString("FullName"));
                    customer.setEmail(rs.getString("Email"));
                    customer.setPhone(rs.getString("Phone"));
                    customer.setStatus(rs.getString("Status"));
                    customer.setAvatarUrl(rs.getString("AvatarUrl"));
                    customer.setAddress(rs.getString("Address")); // có thể là null
                    customer.setGender(rs.getString("Gender")); // có thể là null
                    customer.setDateOfBirth(rs.getDate("DateOfBirth")); // có thể là null (java.sql.Date)
                    Timestamp ts = rs.getTimestamp("LastLogin");
                    if (ts != null) {
                        customer.setLastLogin(ts.toLocalDateTime());
                    } else {
                        customer.setLastLogin(null);
                    }
                    return customer;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    //author: KhoaDDCE181988 - Use in: ViewCustomerProfile,..
    public int updateCustomerProfileById(int id, Customers customer) {
        int cmt = 0;
        try {
            String sql = "Update Customers set Address = ?, FullName = ?, DateOfBirth = ?, Gender = ?, AvatarUrl = ? where CustomerId = ? ";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, customer.getAddress());
            pst.setString(2, customer.getFullName());
            pst.setDate(3, customer.getDateOfBirth());
            pst.setString(4, customer.getGender());
            pst.setString(5, customer.getAvatarUrl());
            pst.setInt(6, id);
            cmt = pst.executeUpdate();
            return cmt;
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cmt;
    }

    //author: KhoaDDCE181988 - Use in: EditCustomerProfile,..
    public Customers getCustomerByIdForCustomer(int id) {
        Customers customer = null;
        String sql = "SELECT UserName, FullName, Email, Phone, Status, AvatarUrl, Address, Gender, DateOfBirth, LastLogin\n"
                + "FROM Customers\n"
                + "WHERE CustomerID = ?";

        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, id);
            try ( ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    customer = new Customers();
                    customer.setUserName(rs.getString("UserName"));
                    customer.setFullName(rs.getString("FullName"));
                    customer.setEmail(rs.getString("Email"));
                    customer.setPhone(rs.getString("Phone"));
                    customer.setStatus(rs.getString("Status"));
                    customer.setAvatarUrl(rs.getString("AvatarUrl"));
                    customer.setAddress(rs.getString("Address")); // có thể là null
                    customer.setGender(rs.getString("Gender")); // có thể là null
                    customer.setDateOfBirth(rs.getDate("DateOfBirth")); // có thể là null (java.sql.Date)
                    Timestamp ts = rs.getTimestamp("LastLogin");
                    if (ts != null) {
                        customer.setLastLogin(ts.toLocalDateTime());
                    } else {
                        customer.setLastLogin(null);
                    }
                    return customer;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    //author: KhoaDDCE181988 - Use in: Login, ViewCustomerProfile,..
    public void updateLoginTimestamps(int customerId) {
        String sql = "UPDATE Customers SET LastLogin = CurrentLastLogin, CurrentLastLogin = ? WHERE CustomerId = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            System.out.println(Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(2, customerId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Customers> getCustomers() {
        List<Customers> customersList = new ArrayList<>();
        String sql = "SELECT * FROM Customers";

        try ( PreparedStatement pst = conn.prepareStatement(sql);  ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                Customers customer = new Customers();
                customer.setCustomerId(rs.getInt("CustomerId"));
                customer.setUserName(rs.getString("UserName"));
                customer.setPassword(rs.getString("Password"));
                customer.setFullName(rs.getString("FullName"));
                customer.setPhone(rs.getString("Phone"));
                customer.setEmail(rs.getString("Email"));
                customer.setAddress(rs.getString("Address"));
                customer.setGender(rs.getString("Gender")); // Có thể dùng boolean nếu cột là bit
                customer.setDateOfBirth(rs.getDate("DateOfBirth"));
                customer.setStatus(rs.getString("Status"));
                customer.setAvatarUrl(rs.getString("AvatarUrl"));
                customer.setCreationDate(rs.getTimestamp("CreationDate").toLocalDateTime());
                customer.setLastLogin(rs.getTimestamp("LastLogin").toLocalDateTime());
                customer.setIdentityNumber(rs.getString("IdentityNumber"));
                customer.setJoinDate(rs.getDate("JoinDate"));

                customersList.add(customer);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customersList;
    }

    public List<Customers> getAllCustomers() throws SQLException {
        List<Customers> list = new ArrayList<>();
        String sql = "SELECT * FROM Customers";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement pst = conn.prepareStatement(sql);  ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                Customers c = new Customers();
                c.setCustomerId(rs.getInt("CustomerId"));
                c.setUserName(rs.getString("UserName"));
                c.setFullName(rs.getString("FullName"));
                c.setPhone(rs.getString("Phone"));
                c.setEmail(rs.getString("Email"));
                c.setGender(rs.getString("Gender"));
                c.setStatus(rs.getString("Status"));
                c.setAvatarUrl(rs.getString("AvatarUrl"));

                // ✅ Bọc kiểm tra null cho Timestamp
                Timestamp creation = rs.getTimestamp("CreationDate");
                if (creation != null) {
                    c.setCreationDate(creation.toLocalDateTime());
                }

                Timestamp lastLogin = rs.getTimestamp("LastLogin");
                if (lastLogin != null) {
                    c.setLastLogin(lastLogin.toLocalDateTime());
                }

                c.setIdentityNumber(rs.getString("IdentityNumber"));
                c.setJoinDate(rs.getDate("JoinDate"));

                list.add(c);
            }

        }
        return list;
    }

    public Customers getCustomerByIdDashboard(int id) throws SQLException {
        Customers c = null;
        String sql = "SELECT * FROM Customers WHERE CustomerId = ?";
        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, id);
            try ( ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    c = new Customers();
                    c.setCustomerId(rs.getInt("CustomerId"));
                    c.setUserName(rs.getString("UserName"));
                    c.setPassword(rs.getString("Password"));
                    c.setFullName(rs.getString("FullName"));
                    c.setPhone(rs.getString("Phone"));
                    c.setEmail(rs.getString("Email"));
                    c.setAddress(rs.getString("Address"));
                    c.setGender(rs.getString("Gender"));
                    c.setDateOfBirth(rs.getDate("DateOfBirth"));
                    c.setStatus(rs.getString("Status"));
                    c.setAvatarUrl(rs.getString("AvatarUrl"));
                    c.setCreationDate(rs.getTimestamp("CreationDate").toLocalDateTime());
                    c.setLastLogin(rs.getTimestamp("LastLogin").toLocalDateTime());
                    c.setIdentityNumber(rs.getString("IdentityNumber"));
                    c.setJoinDate(rs.getDate("JoinDate"));
                }
            }
        }
        return c;
    }

    // Cập nhật thông tin khách hàng
    public int updateCustomer(Customers customer) throws SQLException {
        String sql = "UPDATE Customers SET UserName=?, FullName=?, Email=?, Phone=?, Address=?, Gender=?, Status=?, IdentityNumber=? WHERE CustomerId=?";
        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, customer.getUserName());
            stmt.setString(2, customer.getFullName());
            stmt.setString(3, customer.getEmail());
            stmt.setString(4, customer.getPhone());
            stmt.setString(5, customer.getAddress());
            stmt.setString(6, customer.getGender());
            stmt.setString(7, customer.getStatus());
            stmt.setString(8, customer.getIdentityNumber());
            stmt.setInt(9, customer.getCustomerId());

            return stmt.executeUpdate();  // trả về số dòng cập nhật thành công
        }
    }
// khang

    public int UpdateCustomerOnl(int UserId, int Customer) {
        int cnt = 0;

        try {
            String sql = "Update Customers set IsOnl = ? where UserId=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, Customer);
            pst.setInt(2, UserId);
            cnt = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cnt;
    }

    //
    //vinh xác nhận tài khoảng
    public void insertNewCustomer(String fullName, String phone) throws SQLException {
        String sql = "INSERT INTO Customers (FullName, Phone) VALUES (?, ?)";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.executeUpdate();
        }
    }
//vinh

    public boolean exists(String fullName, String phone) throws SQLException {
        String sql = "SELECT 1 FROM Customers WHERE FullName = ? AND Phone = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }
//vinh
// lấy tên với sdt để check có tài khoảng chưa

    public Customers getCustomerByFullNameAndPhone(String fullName, String phone) throws SQLException {
        String sql = "SELECT * FROM Customers WHERE FullName = ? AND Phone = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Customers c = new Customers();
                c.setCustomerId(rs.getInt("CustomerId"));
                c.setFullName(rs.getString("FullName"));
                c.setPhone(rs.getString("Phone"));
                c.setUserName(rs.getString("Username"));
                c.setEmail(rs.getString("Email"));
                c.setIdentityNumber(rs.getString("IdentityNumber")); //  Thêm CCCD
                c.setRegistered(rs.getBoolean("isRegistered"));       //  Thêm trạng thái tài khoản
                return c;
            }
        }
        return null;
    }

//vinh
    public void insertNewGuest(String fullName, String phone, String email, String identityNumber) throws SQLException {
        String guestUsername = "guest_" + phone;

        String sql = "INSERT INTO Customers (FullName, Phone, Email, UserName, IdentityNumber, isRegistered) VALUES (?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setString(3, (email != null && !email.isEmpty()) ? email : null);
            ps.setString(4, guestUsername);
            ps.setString(5, identityNumber); // ✅ Thêm CCCD
            ps.setBoolean(6, false);
            ps.executeUpdate();
        }
    }

    public boolean insertCustomerIfCccdNotEmpty(String fullName, String cccd, String email, String phone) {
        if (cccd == null || cccd.trim().isEmpty()) {
            return false;
        }

        String sql = "INSERT INTO Customers (FullName, CCCD, Email, Phone) VALUES (?, ?, ?, ?)";

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, cccd);
            ps.setString(3, email);
            ps.setString(4, phone);

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
//khanh

    public void insertCustomerIfNotExist(String fullName, String cccd) throws SQLException {
        String checkSql = "SELECT 1 FROM Customers WHERE CCCD = ?";
        String insertSql = "INSERT INTO Customers (FullName, CCCD) VALUES (?, ?)";

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, cccd);
            ResultSet rs = checkStmt.executeQuery();
            if (!rs.next()) {
                try ( PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setString(1, fullName);
                    insertStmt.setString(2, cccd);
                    insertStmt.executeUpdate();
                }
            }
        }
    }

    public boolean checkExistCCCD(String cccd) {
        String sql = "SELECT COUNT(*) FROM Customers WHERE IdentityNumber = ?";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cccd);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean saveGuestInfoIfNotExist(int bookingId, String fullName, String cccd) {
        if (checkExistCCCD(cccd)) {
            return false; // Bị trùng -> Không lưu
        }

        String sql = "INSERT INTO GuestInfo (BookingId, FullName, CCCD) VALUES (?, ?, ?)";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setString(2, fullName);
            ps.setString(3, cccd);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int insertCustomerByCCCD(String userName, String fullName, String cccd) {
        int check = 0;
        String sql = "INSERT INTO Customers (UserName, FullName, IdentityNumber, isRegistered) VALUES (?, ?, ?, 0)";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userName);
            ps.setString(2, fullName);
            ps.setString(3, cccd);
            check = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    // Truy vấn lấy username số lớn nhất
    public int getMaxUsernameNumber() {
        int max = 0;
        try {
            String sql = "SELECT MAX(CAST(username AS INT)) AS MaxUsername FROM Customers WHERE ISNUMERIC(username) = 1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                max = rs.getInt("MaxUsername");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (max == 0) ? 1 : max + 1;
    }
}
