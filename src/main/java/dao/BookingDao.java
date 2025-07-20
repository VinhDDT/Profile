package dao;

import db.ConnectData;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import models.Bookings;
import models.Customers;
import models.Rooms;

public class BookingDao {

    private Connection conn = null;

    public BookingDao() {
        conn = ConnectData.getConnection();
    }
//
//    public List<Bookings> getAllBookingsKhanh() throws SQLException {
//        List<Bookings> list = new ArrayList<>();
//        Connection conn = ConnectData.getConnection();
//
//        String sql = "SELECT \n"
//                + "    b.BookingId, \n"
//                + "    b.RoomId, \n"
//                + "    b.CustomerId, \n"
//                + "    b.StartDate, \n"
//                + "    b.EndDate, \n"
//                + "    b.Status, \n"
//                + "    b.RoomType, \n"
//                + "    c.FullName\n"
//                + "FROM \n"
//                + "    Bookings b\n"
//                + "Full JOIN \n"
//                + "    Customers c ON b.CustomerId = c.CustomerId\n"
//                + "WHERE \n"
//                + "    b.Status IN ('Checked in', 'Confirmed', 'Checked out')";
//
//        PreparedStatement ps = conn.prepareStatement(sql);
//        ResultSet rs = ps.executeQuery();
//
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
//
//        while (rs.next()) {
//            Bookings booking = new Bookings();
//            booking.setBookingId(rs.getInt("BookingId"));
//
//
//Date startSqlDate = rs.getDate("StartDate");
//if (startSqlDate != null) {
//    LocalDate startDate = startSqlDate.toLocalDate();
//    booking.setStartDate(startDate);
//    booking.setFormattedStartDate(startDate.format(formatter));
//}
//
//Date endSqlDate = rs.getDate("EndDate");
//if (endSqlDate != null) {
//    LocalDate endDate = endSqlDate.toLocalDate();
//    booking.setEndDate(endDate);
//    booking.setFormattedEndDate(endDate.format(formatter));
//}
//
//
//            booking.setStatus(rs.getString("Status"));
//
//            int roomId = rs.getInt("RoomId");
//            if (rs.wasNull()) {
//                booking.setRooms(null);
//            } else {
//                Rooms room = new Rooms();
//                room.setRoomId(roomId);
////                room.setRoomNumber(rs.getString("RoomNumber"));
//                booking.setRooms(room);
//
//            }
//                                booking.setRoomType(rs.getString("RoomType")); 
//
//            Customers customer = new Customers();
//            customer.setFullName(rs.getString("FullName"));
//            booking.setCustomers(customer);
//
//            list.add(booking);
//        }
//        rs.close();
//        ps.close();
//        conn.close();
//        return list;
//    }

    //vinh bookingconfirmation
    public List<Bookings> getAllBookings() throws SQLException {
        List<Bookings> list = new ArrayList<>();
        Connection conn = ConnectData.getConnection();

        String sql = "SELECT b.BookingId, b.RoomId, b.CustomerId, b.StartDate, b.EndDate, b.Status, "
                + "COALESCE(r.RoomType, b.RoomType) AS RoomType, " // Ưu tiên lấy từ bảng Rooms nếu có, ngược lại lấy từ Booking
                + "c.FullName "
                + "FROM Bookings b "
                + "LEFT JOIN Rooms r ON b.RoomId = r.RoomId "
                + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE b.Status IN ('Waiting for processing', 'Confirmed')";

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        while (rs.next()) {
            Bookings booking = new Bookings();
            booking.setBookingId(rs.getInt("BookingId"));

            java.sql.Date startDateSql = rs.getDate("StartDate");
            if (startDateSql != null) {
                LocalDate startDate = startDateSql.toLocalDate();
                booking.setStartDate(startDate);
                booking.setFormattedStartDate(startDate.format(formatter));
            }

            java.sql.Date endDateSql = rs.getDate("EndDate");
            if (endDateSql != null) {
                LocalDate endDate = endDateSql.toLocalDate();
                booking.setEndDate(endDate);
                booking.setFormattedEndDate(endDate.format(formatter));
            }

            booking.setStatus(rs.getString("Status"));

            // Gán RoomType (kể cả khi null)
            String roomType = rs.getString("RoomType");
            if (roomType == null) {
                roomType = "Chưa gán phòng";
            }
            booking.setRoomType(roomType); // nếu bạn có thêm field roomType trong Booking

            // Gán tên khách
            Customers customer = new Customers();
            customer.setFullName(rs.getString("FullName"));
            booking.setCustomers(customer);

            list.add(booking);
        }

        return list;
    }

//<<<<<<< HEAD
//    public int confirmBooking(int bookingId, int confirmedBy) throws SQLException {
//        int check = 0;
//=======
    public List<Bookings> getAllBookingsKhanh() throws SQLException {
        List<Bookings> list = new ArrayList<>();
        Connection conn = ConnectData.getConnection();

        String sql = "SELECT \n"
                + "    b.BookingId, \n"
                + "    b.RoomId, \n"
                + "    b.CustomerId, \n"
                + "    b.StartDate, \n"
                + "    b.EndDate, \n"
                + "    b.Status, \n"
                + "    b.RoomType, \n"
                + "    c.FullName\n"
                + "FROM \n"
                + "    Bookings b\n"
                + "FULL JOIN \n"
                + "    Customers c ON b.CustomerId = c.CustomerId\n"
                + "WHERE \n"
                + "    b.Status IN ('Checked in', 'Confirmed', 'Checked out')";

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        // Format chỉ ngày
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        while (rs.next()) {
            Bookings booking = new Bookings();
            booking.setBookingId(rs.getInt("BookingId"));

            Timestamp startTs = rs.getTimestamp("StartDate");
            if (startTs != null) {
                LocalDate startDate = startTs.toLocalDateTime().toLocalDate();
                booking.setStartDate(startDate); // đổi kiểu startDate sang LocalDate nếu cần
                booking.setFormattedStartDate(startDate.format(formatter));
            }

            Timestamp endTs = rs.getTimestamp("EndDate");
            if (endTs != null) {
                LocalDate endDate = endTs.toLocalDateTime().toLocalDate();
                booking.setEndDate(endDate); // đổi kiểu endDate sang LocalDate nếu cần
                booking.setFormattedEndDate(endDate.format(formatter));
            }

            booking.setStatus(rs.getString("Status"));

            int roomId = rs.getInt("RoomId");
            if (rs.wasNull()) {
                booking.setRooms(null);
            } else {
                Rooms room = new Rooms();
                room.setRoomId(roomId);
                booking.setRooms(room);
            }

            booking.setRoomType(rs.getString("RoomType"));

            Customers customer = new Customers();
            customer.setFullName(rs.getString("FullName"));
            booking.setCustomers(customer);

            list.add(booking);
        }
        rs.close();
        ps.close();
        conn.close();
        return list;
    }

    //vinh
    public void confirmBooking(int bookingId, int confirmedBy) throws SQLException {
        String sql = "UPDATE Bookings SET Status = 'Confirmed', ConfirmationTime = ?, ConfirmedBy = ? WHERE BookingId = ?";

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now())); // thời gian xác nhận
            ps.setInt(2, confirmedBy); // ID của nhân viên xác nhận
            ps.setInt(3, bookingId);   // ID đơn đặt phòng

            ps.executeUpdate();
        }
    }

//vinh
    public void confirmBookingWithRoom(int bookingId, int roomId, int confirmedBy) throws SQLException {
        String sql = "UPDATE Bookings SET RoomId = ?, Status = 'Confirmed', ConfirmationTime = ?, ConfirmedBy = ? WHERE BookingId = ?";
        try (
                 Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(3, confirmedBy);
            ps.setInt(4, bookingId);
            ps.executeUpdate();
        }
    }

//vinh
    public void cancelBooking(int bookingId, String notes, int canceledBy) throws SQLException {
        String sql = "UPDATE Bookings SET Status = ?, CancelTime = ?, CanceledBy = ?, Notes = ? WHERE BookingId = ?";
        try (
                 PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "Canceled");
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(3, canceledBy);
            ps.setString(4, notes);
            ps.setInt(5, bookingId);
            ps.executeUpdate();

        }
    }

    public int updateBookingStatus(int bookingId, String status) {
        int cnt = 0;
        try {
            String sql = "UPDATE Bookings SET Status = ? WHERE BookingId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            cnt = ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cnt;
    }

    public void deleteBooking(int bookingId) throws SQLException {
        String sql = "DELETE FROM Bookings WHERE BookingId = ?";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookingId);
            stmt.executeUpdate();
        }
    }

//     Thêm dữ liệu mới vào Bookings
    public void insertBooking(Bookings booking) throws SQLException {
        String sql = "INSERT INTO Bookings (RoomId, CustomerID, UserId, StartDate, EndDate, Status, Notes) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, booking.getRoomId());
            ps.setInt(2, booking.getCustomerId());
            ps.setInt(3, booking.getUserId());
            ps.setDate(4, java.sql.Date.valueOf(booking.getStartDate()));
            ps.setDate(5, java.sql.Date.valueOf(booking.getEndDate()));

            ps.setString(6, booking.getStatus());
            ps.setString(7, booking.getNotes());

            ps.executeUpdate();
        }
    }

    //vinh
    public List<Bookings> searchBookings(String roomTypeFilter, String fullNameFilter,
            String startDateFilter, String endDateFilter,
            String statusFilter) throws SQLException {
        List<Bookings> list = new ArrayList<>();
        Connection conn = ConnectData.getConnection();

        StringBuilder sql = new StringBuilder(
                "SELECT b.BookingId, b.RoomId, b.CustomerId, b.StartDate, b.EndDate, b.Status, "
                + "b.RoomType, c.FullName "
                + "FROM Bookings b "
                + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (roomTypeFilter != null && !roomTypeFilter.trim().isEmpty()) {
            sql.append(" AND b.RoomType LIKE ? ");
            params.add("%" + roomTypeFilter.trim() + "%");
        }

        if (fullNameFilter != null && !fullNameFilter.trim().isEmpty()) {
            sql.append(" AND c.FullName LIKE ? ");
            params.add("%" + fullNameFilter.trim() + "%");
        }

        if (startDateFilter != null && !startDateFilter.isEmpty()) {
            sql.append(" AND b.StartDate >= ? ");
            params.add(Date.valueOf(startDateFilter));
        }

        if (endDateFilter != null && !endDateFilter.isEmpty()) {
            sql.append(" AND b.EndDate <= ? ");
            params.add(Date.valueOf(endDateFilter));
        }

        if (statusFilter != null && !statusFilter.equals("-- All --")) {
            sql.append(" AND b.Status = ? ");
            params.add(statusFilter);
        }

        PreparedStatement ps = conn.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        ResultSet rs = ps.executeQuery();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        while (rs.next()) {
            Bookings booking = new Bookings();
            booking.setBookingId(rs.getInt("BookingId"));

            java.sql.Date startDateSql = rs.getDate("StartDate");
            if (startDateSql != null) {
                LocalDate startDate = startDateSql.toLocalDate();
                booking.setStartDate(startDate);
                booking.setFormattedStartDate(startDate.format(formatter));
            }

            java.sql.Date endDateSql = rs.getDate("EndDate");
            if (endDateSql != null) {
                LocalDate endDate = endDateSql.toLocalDate();
                booking.setEndDate(endDate);
                booking.setFormattedEndDate(endDate.format(formatter));
            }

            booking.setStatus(rs.getString("Status"));

            String roomType = rs.getString("RoomType");
            if (roomType == null || roomType.trim().isEmpty()) {
                roomType = "Chưa gán phòng";
            }
            booking.setRoomType(roomType);

            Customers customer = new Customers();
            customer.setFullName(rs.getString("FullName"));
            booking.setCustomers(customer);

            list.add(booking);
        }

        rs.close();
        ps.close();
        conn.close();
        return list;
    }

    public int updateBookingStatusAndcheckInt(int bookingId, String status) {
        int cnt = 0;
        try {
            Connection conn = ConnectData.getConnection();
            String sql = "UPDATE Bookings SET Status = ? WHERE BookingId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            cnt = ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return cnt;
    }

    public Bookings getCheckInCheckOutDetails(int id) {
        Bookings booked = new Bookings();

        try {
            Connection conn = ConnectData.getConnection();

            String sql = "SELECT b.BookingId, b.RoomId, b.CustomerId, b.UserId, b.StartDate, b.EndDate, "
                    + "b.Status, b.CheckInTime, b.CheckOutTime, b.ConfirmationTime, "
                    + "c.FullName, c.Email, c.Phone, r.RoomNumber "
                    + "FROM Bookings b "
                    + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                    + "JOIN Rooms r ON b.RoomId = r.RoomId "
                    + "WHERE b.BookingId =? ";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Bookings booking = new Bookings();
                booking.setBookingId(rs.getInt("BookingId"));
                booking.setRoomId(rs.getInt("RoomId"));
                booking.setCustomerId(rs.getInt("CustomerId"));
                booking.setUserId(rs.getInt("UserId"));
                booking.setStartDate(rs.getDate("StartDate").toLocalDate());
                booking.setEndDate(rs.getDate("EndDate").toLocalDate());

                booking.setStatus(rs.getString("Status"));
                booking.setCheckInTime(rs.getTimestamp("CheckInTime").toLocalDateTime());
                booking.setCheckOutTime(rs.getTimestamp("CheckOutTime").toLocalDateTime());
                booking.setConfirmationTime(rs.getTimestamp("ConfirmationTime").toLocalDateTime());

                Customers customer = new Customers();
                customer.setFullName(rs.getString("FullName"));
                customer.setEmail(rs.getString("Email"));
                customer.setPhone(rs.getString("Phone"));
                booking.setCustomers(customer);

                Rooms room = new Rooms();
                room.setRoomNumber(rs.getString("RoomNumber"));
                booking.setRooms(room);

            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return booked;

    }

    public Bookings getBookingById(int id) {
        Bookings b = null;
        String sql = "SELECT b.BookingID, b.Status, b.StartDate, b.EndDate, b.CheckInTime, b.CheckOutTime, "
                + "r.RoomNumber, c.FullName, c.Email, c.Phone "
                + "FROM Bookings b "
                + "JOIN Rooms r ON b.RoomID = r.RoomID "
                + "JOIN Customers c ON b.CustomerID = c.CustomerID "
                + "WHERE b.BookingID = ?";

        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                b = new Bookings();
                b.setBookingId(rs.getInt("BookingID"));
                b.setStatus(rs.getString("Status"));
                b.setStartDate(rs.getDate("StartDate").toLocalDate());
                b.setEndDate(rs.getDate("EndDate").toLocalDate());

                b.setCheckInTime(rs.getTimestamp("CheckInTime").toLocalDateTime());
                b.setCheckOutTime(rs.getTimestamp("CheckOutTime").toLocalDateTime());

                // Room
                Rooms r = new Rooms();
                r.setRoomNumber(rs.getString("RoomNumber"));
                b.setRooms(r);

                // Customer
                Customers c = new Customers();
                c.setFullName(rs.getString("FullName"));
                c.setEmail(rs.getString("Email"));
                c.setPhone(rs.getString("Phone"));
                b.setCustomers(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return b;
    }

    //vinh   
    public Bookings getBookingInfoForConfirmation(int bookingId) throws SQLException {
        String sql = "SELECT b.BookingId, b.StartDate, b.EndDate, b.RoomId, b.ConfirmationTime, "
                + "       b.RoomType, " // Lấy RoomType từ bảng Bookings
                + "       c.FullName, c.Email "
                + "FROM Bookings b "
                + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE b.BookingId = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Bookings info = new Bookings();
                info.setBookingId(rs.getInt("BookingId"));

                if (rs.getDate("StartDate") != null) {
                    info.setStartDate(rs.getDate("StartDate").toLocalDate());
                }
                if (rs.getDate("EndDate") != null) {
                    info.setEndDate(rs.getDate("EndDate").toLocalDate());
                }

                if (rs.getTimestamp("ConfirmationTime") != null) {
                    info.setConfirmationTime(rs.getTimestamp("ConfirmationTime").toLocalDateTime());
                }

                // Gán khách
                Customers customer = new Customers();
                customer.setFullName(rs.getString("FullName"));
                customer.setEmail(rs.getString("Email"));
                info.setCustomers(customer);

                // Gán loại phòng
                Rooms room = new Rooms();
                room.setRoomType(rs.getString("RoomType")); // luôn có vì lấy từ bảng Bookings
                info.setRooms(room);

                return info;
            }
        }

        return null;
    }

    //vinh
    public Bookings getBookingInfoForCancellation(int bookingId) throws SQLException {
        String sql = "SELECT b.BookingId, b.StartDate, b.EndDate, b.Notes, "
                + "       r.RoomType, "
                + "       c.FullName, c.Email "
                + "FROM Bookings b "
                + "LEFT JOIN Rooms r ON b.RoomId = r.RoomId "
                + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE b.BookingId = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Bookings info = new Bookings();
                info.setBookingId(rs.getInt("BookingId"));

                if (rs.getDate("StartDate") != null) {
                    info.setStartDate(rs.getDate("StartDate").toLocalDate());
                }

                if (rs.getDate("EndDate") != null) {
                    info.setEndDate(rs.getDate("EndDate").toLocalDate());
                }

                String notes = rs.getString("Notes");
                info.setNotes(notes != null ? notes : "Do not have");

                String roomType = rs.getString("RoomType");
                if (roomType == null) {
                    roomType = "Room not assigned yet";
                }
                info.setRoomType(roomType);

                Customers customer = new Customers();
                customer.setFullName(rs.getString("FullName"));
                customer.setEmail(rs.getString("Email"));
                info.setCustomers(customer);

                return info;
            }
        }

        return null;
    }

//vinh
    public String getBookingStatus(int bookingId) throws SQLException {
        String sql
                = "SELECT Status FROM Bookings WHERE BookingId = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString("Status");
            }
        }

        return null; // Không tìm thấy booking
    }
//Khang 

//    public int insertBookingBeforePayment(int customerId, LocalDate startDate, LocalDate endDate, String roomType) {
//        try {
//            String sql = "INSERT INTO Bookings(CustomerId, StartDate, EndDate, roomType, Status) "
//                    + "VALUES (?, ?, ?, ?, 'pending payment')";
//
//            PreparedStatement pst = conn.prepareStatement(sql);
//            pst.setInt(1, customerId);
//            pst.setDate(2, java.sql.Date.valueOf(startDate));
//            pst.setDate(3, java.sql.Date.valueOf(endDate));
//            pst.setString(4, roomType);
//
//            return pst.executeUpdate();
//
//        } catch (SQLException ex) {
//            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return 0;
//    }
    public Bookings getBookingCheckInInfo(int bookingId) {
        Bookings booking = null;

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(
                "SELECT "
                + "    b.BookingId, "
                + "    b.CustomerId, "
                + "    b.StartDate, "
                + "    b.EndDate, "
                + "    b.RoomType, "
                + "    c.FullName "
                + "FROM Bookings b "
                + "INNER JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE b.BookingId = ?")) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                booking = new Bookings();
                booking.setBookingId(rs.getInt("BookingId"));
                booking.setCustomerId(rs.getInt("CustomerId"));

                // Nếu model Bookings của bạn đang xài String cho ngày thì dùng getString
                LocalDate startDate = rs.getDate("StartDate").toLocalDate();
                booking.setStartDate(startDate);

                LocalDate endDate = rs.getDate("EndDate").toLocalDate();
                booking.setEndDate(endDate);
                booking.setRoomType(rs.getString("RoomType"));

                Customers customer = new Customers();
                customer.setFullName(rs.getString("FullName"));
                booking.setCustomers(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return booking;
    }

    public boolean updateCheckInStatus(int bookingId, String status, int actualGuests, String cccd, int assignedRoomId, LocalDateTime checkInTime) {
        String sql = "UPDATE Bookings SET Status = ?, NumberOfGuests = ?, CCCD = ?, RoomId = ?, CheckInTime = ? WHERE BookingId = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, actualGuests);
            ps.setString(3, cccd);
            ps.setInt(4, assignedRoomId);
            ps.setTimestamp(5, Timestamp.valueOf(checkInTime));
            ps.setInt(6, bookingId);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public Bookings getBookingBasicInfoById(int bookingId) {
        Bookings booking = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = ConnectData.getConnection();
            String sql = "SELECT "
                    + "    b.BookingId, "
                    + "    c.FullName AS CustomerName, "
                    + "    r.RoomType, "
                    + "    b.StartDate, "
                    + "    b.EndDate "
                    + "FROM Bookings b "
                    + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                    + "JOIN Rooms r ON b.RoomId = r.RoomId "
                    + "WHERE b.BookingId = ?";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, bookingId);
            rs = ps.executeQuery();

            if (rs.next()) {
                booking = new Bookings();
                booking.setBookingId(rs.getInt("BookingId"));

                Customers customer = new Customers();
                customer.setFullName(rs.getString("CustomerName"));
                booking.setCustomers(customer);

                Rooms room = new Rooms();
                room.setRoomType(rs.getString("RoomType"));
                booking.setRooms(room);
                booking.setStartDate(rs.getDate("StartDate").toLocalDate());
                booking.setEndDate(rs.getDate("EndDate").toLocalDate());
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return booking;
    }

    public int checkRoomIdExists(Integer roomId) {
        int result = 0;
        String sql = "SELECT RoomId FROM Bookings WHERE BookingId = ?";

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();

            if (rs.next() && rs.getObject("RoomId") != null) {
                result = 1;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    //khanh
    public void updateRoomForBooking(int bookingId, int roomId, int actualGuests) throws SQLException {
        String sql = "UPDATE Bookings SET RoomId = ?, ActualGuests = ? WHERE BookingId = ?";

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomId);
            ps.setInt(2, actualGuests);
            ps.setInt(3, bookingId);

            ps.executeUpdate();
        }
    }

    public void insertRoomIdForBookingK(int bookingId, int roomId, LocalDateTime checkInTime) {
        Connection conn = ConnectData.getConnection();
        try {
            String sql = "UPDATE Bookings SET RoomId = ?, CheckInTime = ?, Status = 'Checked in' WHERE BookingId = ?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, roomId);
            ps.setTimestamp(2, Timestamp.valueOf(checkInTime));
            ps.setInt(3, bookingId);

            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
//code của khanh

    public int confirmBookingNotByRoomId(int bookingId, int confirmedBy) {
        int check = 0;
        try {
            String sql = "UPDATE Bookings SET Status = 'Checked in', CheckInTime = ?, CheckInBy = ? WHERE BookingId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDate(1, java.sql.Date.valueOf(LocalDate.now()));  // LocalDate -> Date
            ps.setInt(2, confirmedBy);
            ps.setInt(3, bookingId);
            check = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return check;
    }

    //vinh deskbooking
    public int insertBookingAndReturnId(Bookings booking) throws SQLException {
        String sql = "INSERT INTO Bookings (RoomId, CustomerID, StartDate, EndDate, Status, RequestTime, ConfirmationTime, ConfirmedBy, RoomType) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try ( PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, booking.getRoomId());
            ps.setInt(2, booking.getCustomerId());
            ps.setDate(3, Date.valueOf(booking.getStartDate()));
            ps.setDate(4, Date.valueOf(booking.getEndDate()));
            ps.setString(5, booking.getStatus());
            ps.setTimestamp(6, Timestamp.valueOf(booking.getRequestTime()));
            ps.setTimestamp(7, Timestamp.valueOf(booking.getConfirmationTime()));
            ps.setInt(8, booking.getConfirmedBy());
            ps.setString(9, booking.getRoomType());

            int affected = ps.executeUpdate();
            if (affected == 0) {
                throw new SQLException("Không thể tạo booking.");
            }

            try ( ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Trả lại bookingId
                } else {
                    throw new SQLException("Không lấy được bookingId.");
                }
            }
        }
    }

    public int insertBookingBeforePayment(int customerId, LocalDate startDate, LocalDate endDate, String roomType, String note) {
        int bookingId = -1;

        try {
            String sql = "INSERT INTO Bookings(CustomerId, StartDate, EndDate, roomType, Status, Notes) "
                    + "VALUES (?, ?, ?, ?, 'pending payment', ?)";

            PreparedStatement pst = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pst.setInt(1, customerId);
            pst.setDate(2, java.sql.Date.valueOf(startDate));
            pst.setDate(3, java.sql.Date.valueOf(endDate));
            pst.setString(4, roomType);
            pst.setString(5, note);  // Thêm note ở đây

            int affectedRows = pst.executeUpdate();

            if (affectedRows > 0) {
                ResultSet rs = pst.getGeneratedKeys();
                if (rs.next()) {
                    bookingId = rs.getInt(1); // Lấy BookingId vừa tạo
                }
                rs.close();
            }

            pst.close();

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return bookingId;
    }

    public int getBookingId(int customerId, LocalDate startDate, LocalDate endDate, String roomType) {
        String sql = "SELECT TOP 1 BookingId FROM Bookings "
                + "WHERE CustomerId = ? AND StartDate = ? AND EndDate = ? AND RoomType = ?";

        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, customerId);
            pst.setTimestamp(2, Timestamp.valueOf(startDate.atStartOfDay()));
            pst.setTimestamp(3, Timestamp.valueOf(endDate.atStartOfDay()));
            pst.setString(4, roomType);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getInt("BookingId");
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return 0;
    }

//    public int insertInvoiceBeforePayment(int bookingId, long roomPriceTotal,
//            long discount, long totalAmount, long paidAmount, String status) {
//        try {
//            String sql = "INSERT INTO Invoices (BookingId, InvoiceDate, RoomPriceTotal, Discount, TotalAmount, PaidAmount,Status) "
//                    + "VALUES (?, ?, ?, ?, ?, ?,  'pending')";
//
//            PreparedStatement pst = conn.prepareStatement(sql);
//
//            // Set giá trị cho từng cột
//            pst.setInt(1, bookingId);
//            pst.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
//            pst.setLong(3, roomPriceTotal);
//            pst.setLong(4, discount);
//            pst.setLong(5, totalAmount);
//            pst.setLong(6, paidAmount);
//
//            return pst.executeUpdate();
//
//        } catch (SQLException ex) {
//            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return 0;
//    }
    public int insertInvoiceBeforePayment(int bookingId, long roomPriceTotal,
            long discount, long totalAmount, long paidAmount, String status) {
        int invoiceId = -1;

        try {
            String sql = "INSERT INTO Invoices (BookingId, InvoiceDate, RoomPriceTotal, Discount, TotalAmount, PaidAmount, Status) "
                    + "VALUES (?, ?, ?, ?, ?, ?, 'pending')";

            PreparedStatement pst = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // Set giá trị cho từng cột
            pst.setInt(1, bookingId);
            Timestamp now = Timestamp.valueOf(LocalDateTime.now());
            pst.setTimestamp(2, now);
            pst.setLong(3, roomPriceTotal);
            pst.setLong(4, discount);
            pst.setLong(5, totalAmount);
            pst.setLong(6, paidAmount);

            int rows = pst.executeUpdate();

            if (rows > 0) {
                ResultSet rs = pst.getGeneratedKeys();
                if (rs.next()) {
                    invoiceId = rs.getInt(1); // hoặc rs.getInt("InvoiceId") nếu tên cột được trả về
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return invoiceId;
    }

    public int updateInvoiceStatus(int invoiceId, String status) {
        try {
            String sql = "UPDATE Invoices SET Status = ? WHERE InvoiceId = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, status);
            pst.setInt(2, invoiceId);

            return pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int saveGuestInfos(int bookingId, List<String> fullNames, List<String> cccds) {
        int totalInserted = 0;
        String sql = "INSERT INTO GuestInfo (BookingId, FullName, CCCD) VALUES (?, ?, ?)";

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < fullNames.size(); i++) {
                ps.setInt(1, bookingId);
                ps.setString(2, fullNames.get(i));
                ps.setString(3, cccds.get(i));
                totalInserted += ps.executeUpdate();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return totalInserted;
    }

    // đóng code của khanh
    public int insertPayment(int invoiceId, long amount, String method, String status, String type) {
        try {
            String sql = "INSERT INTO Payments (InvoiceId, Amount, PaymentMethod, PaymentStatus, PaymentDate, PaymentType) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement pst = conn.prepareStatement(sql);

            pst.setInt(1, invoiceId);
            pst.setLong(2, amount);
            pst.setString(3, method);
            pst.setString(4, status);
            pst.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
            pst.setString(6, type);

            return pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    //Đóng code của khang
    
    
    
//    //Khoa
//    public List<Bookings> getAllBookingsActive() {
//        String sql = "SELECT * FROM Bookings b \n"
//                + "inner join Rooms r on r.RoomId = b.RoomId\n"
//                + "WHERE b.Status = 'Checked in' AND CheckInTime IS NOT NULL";
//        List<Bookings> list = new ArrayList<>();
//        try {
//            Connection conn = ConnectData.getConnection();
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Bookings b = new Bookings();
//                b.setBookingId(rs.getInt("BookingId"));
//                Rooms r = new Rooms();
//                r.setRoomNumber(rs.getString("RoomNumber"));
//                b.setRooms(r);
//                b.setCustomerId(rs.getInt("CustomerID"));
//                b.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
//                b.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
//                list.add(b);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        if (list.isEmpty()) {
//            System.out.println("list dang rong");
//            return null;
//        } else {
//            System.out.println("list dang khong rong");
//            System.out.println(list);
//        }
//        return list;
//    }
}
