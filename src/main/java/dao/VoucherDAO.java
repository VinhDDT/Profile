/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.ConnectData;
import java.math.BigDecimal;
import models.Vouchers;
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
import models.CustomerVouchers;

/**
 *
 * @author CE180441_Dương Đinh Thế Vinh
 */
public class VoucherDao {

    private Connection conn = null;

    public VoucherDao() {

        conn = ConnectData.getConnection();
    }

    public List<Vouchers> selectAllVouchers() {
        ResultSet rs = null;
        List<Vouchers> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM Vouchers";
            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);

            while (rs.next()) {
                Vouchers voucher = new Vouchers();
                voucher.setVoucherId(rs.getInt("VoucherId"));
                voucher.setCode(rs.getString("Code"));
                voucher.setDiscountPercent(rs.getBigDecimal("discountPercent"));
                voucher.setMinOrderAmount(rs.getLong("MinOrderAmount"));
                voucher.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
                voucher.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
                voucher.setDescription(rs.getString("Description"));
                voucher.setQuantity(rs.getInt("Quantity"));
                voucher.setIsActive(rs.getBoolean("isActive"));
                voucher.setUserId(rs.getString("userId"));
                list.add(voucher);
            }
        } catch (SQLException ex) {
            Logger.getLogger(VoucherDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int insertVoucher(Vouchers voucher) {
        int dem = 0;
        String sql = "INSERT INTO Vouchers (Code, DiscountPercent, MinOrderAmount, StartDate, EndDate, Description, Quantity, IsActive) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, voucher.getCode());
            ps.setBigDecimal(2, voucher.getDiscountPercent());
            ps.setLong(3, voucher.getMinOrderAmount());
            ps.setTimestamp(4, Timestamp.valueOf(voucher.getStartDate()));
            ps.setTimestamp(5, Timestamp.valueOf(voucher.getEndDate()));
            ps.setString(6, voucher.getDescription());
            ps.setInt(7, voucher.getQuantity());
            ps.setBoolean(8, voucher.getIsActive());
            dem = ps.executeUpdate();
            return dem;
        } catch (SQLException ex) {
            System.err.println("Error when inserting voucher: " + ex.getMessage());
            ex.printStackTrace();
        }

        return dem;

    }

    public int deleteVoucher(int voucherId) {
        int dem = 0;
        String sql = "DELETE FROM Vouchers WHERE VoucherId = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            dem = ps.executeUpdate();
            return dem;
        } catch (SQLException ex) {
            Logger.getLogger(VoucherDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return dem;
    }

    public Vouchers getVoucherById(int id) {
        Vouchers v = new Vouchers();
        try {
            String sql = "SELECT * FROM Vouchers WHERE VoucherId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                v.setVoucherId(rs.getInt("voucherId"));
                v.setCode(rs.getString("Code"));
                v.setDiscountPercent(rs.getBigDecimal("discountPercent"));
                v.setMinOrderAmount(rs.getLong("MinOrderAmount"));
                v.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
                v.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
                v.setDescription(rs.getString("Description"));
                v.setQuantity(rs.getInt("Quantity"));
                v.setIsActive(rs.getBoolean("IsActive"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return v;
    }

    public int updateVoucher(Vouchers v) {
        int dem = 0;
        try {
            String sql = "UPDATE Vouchers SET Code=?, DiscountPercent=?, MinOrderAmount=?, StartDate=?, EndDate=?, Quantity=?, Description=?, IsActive=? WHERE VoucherId=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, v.getCode());
            ps.setBigDecimal(2, v.getDiscountPercent());
            ps.setLong(3, v.getMinOrderAmount());
            ps.setTimestamp(4, Timestamp.valueOf(v.getStartDate()));
            ps.setTimestamp(5, Timestamp.valueOf(v.getEndDate()));
            ps.setInt(6, v.getQuantity());
            ps.setString(7, v.getDescription());
            ps.setBoolean(8, v.getIsActive());
            ps.setInt(9, v.getVoucherId());

            dem = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dem;
    }

    public List checkVoucherById(int customerId) {
        List list = new ArrayList<>();
        ResultSet rs = null;

        try {
            String sql = "SELECT VoucherId FROM CustomerVouchers WHERE CustomerId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, customerId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Vouchers voucher = new Vouchers();
                voucher.setVoucherId(rs.getInt("VoucherId"));
                list.add(voucher);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean hasSavedVoucher(int customerId, int voucherId) {
        String sql = "SELECT 1 FROM CustomerVouchers WHERE CustomerId = ? AND VoucherId = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            ps.setInt(2, voucherId);
            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean decreaseVoucherQuantity(int voucherId, Connection conn) throws SQLException {
        String sql = "UPDATE Vouchers SET Quantity = Quantity - 1 WHERE VoucherId = ? AND Quantity > 0";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            return ps.executeUpdate() > 0;
        }
    }

    public List getAllAvailableVouchers() {
        List list = new ArrayList<>();
        String sql = "SELECT * FROM Vouchers "
                + "WHERE EndDate >= GETDATE() AND Quantity > 0 AND IsActive = 1";

        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Vouchers v = new Vouchers();
                v.setVoucherId(rs.getInt("VoucherId"));
                v.setCode(rs.getString("Code"));
                v.setDescription(rs.getString("Description"));
                v.setMinOrderAmount(rs.getLong("MinOrderAmount"));
                v.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
                v.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
                v.setDiscountPercent(rs.getBigDecimal("DiscountPercent"));
                v.setQuantity(rs.getInt("Quantity"));
                list.add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Vouchers> getVouchersByCustomer(int customerId) {
        List<Vouchers>  list = new ArrayList<>();
        String sql = "SELECT * FROM Vouchers v "
                + "JOIN CustomerVouchers cv ON v.VoucherId = cv.VoucherId "
                + "WHERE cv.CustomerId = ? ";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Vouchers v = new Vouchers();
                CustomerVouchers cvs = new CustomerVouchers();
                cvs.setIsUsed(rs.getBoolean("IsUsed"));
                v.setCustomerVouchers(cvs);
                v.setVoucherId(rs.getInt("VoucherId"));
                v.setCode(rs.getString("Code"));
                v.setDescription(rs.getString("Description"));
                v.setDiscountPercent(rs.getBigDecimal("DiscountPercent"));
                v.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
                v.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
                v.setMinOrderAmount(rs.getLong("MinOrderAmount"));
                v.setQuantity(rs.getInt("Quantity"));

                v.setIsActive(rs.getBoolean("IsActive"));

                list.add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean saveCustomerVoucher(int customerId, int voucherId, Connection conn) throws SQLException {

        String sql = "INSERT INTO CustomerVouchers (CustomerId, VoucherId, IsUsed, AssignedDate) VALUES (?, ?, 0, GETDATE())";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, voucherId);
            return ps.executeUpdate() > 0;
        }
    }

    public void updateExpiredVouchers() {
        String sql = "UPDATE Vouchers SET IsActive = 0 WHERE EndDate < GETDATE() AND IsActive = 1";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int updateVoucherStatusOnly(Vouchers v) {
        int result = 0;
        try ( Connection conn = ConnectData.getConnection()) {
            String sql = "UPDATE Vouchers SET IsActive = ? WHERE VoucherId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setBoolean(1, v.getIsActive());
            ps.setInt(2, v.getVoucherId());
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // khang
   public int updateStatusVoucher(int customerId, int voucherId) {
    String sql = "UPDATE CustomerVouchers SET IsUsed = 1, UsedDate = ? WHERE CustomerId = ? AND VoucherId = ?";

    try (Connection conn = ConnectData.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        LocalDateTime now = LocalDateTime.now();
        ps.setTimestamp(1, Timestamp.valueOf(now));
        ps.setInt(2, customerId);
        ps.setInt(3, voucherId);

        return ps.executeUpdate(); 

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return 0; 
}


    // đóng code của KHang 
    public boolean isVoucherCodeExists(String code) {
        String sql = "SELECT 1 FROM Vouchers WHERE Code = ? AND IsActive = 1 AND EndDate >= GETDATE()";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // tồn tại là true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isCodeConflictWhenActivating(String code, LocalDateTime start, LocalDateTime end, int currentVoucherId) {
        String sql = "SELECT 1 FROM Vouchers "
                + "WHERE Code = ? AND IsActive = 1 AND VoucherId != ? "
                + "AND StartDate <= ? AND EndDate >= ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ps.setInt(2, currentVoucherId);
            ps.setTimestamp(3, Timestamp.valueOf(end));   // StartDate <= current.end
            ps.setTimestamp(4, Timestamp.valueOf(start)); // EndDate >= current.start
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isVoucherUsedByCustomer(int voucherId) {
        String sql = "SELECT 1 FROM CustomerVouchers WHERE VoucherId = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Có bản ghi là có người lưu
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void deleteExpiredSavedVouchers() {
        String sql = "DELETE FROM CustomerVouchers "
                + "WHERE VoucherId IN ( "
                + "   SELECT v.VoucherId FROM Vouchers v "
                + "   WHERE v.EndDate < DATEADD(DAY, -5, GETDATE()) "
                + ")";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            int rowsDeleted = ps.executeUpdate();
            System.out.println("Deleted " + rowsDeleted + " expired saved vouchers (older than 5 days).");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
