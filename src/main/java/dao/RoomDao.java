/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.ConnectData;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Amenities;
import models.Buildings;
import models.Customers;
import models.RoomReviews;
import models.Rooms;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class RoomDao {

    private Connection conn = null;

    public RoomDao() {
        conn = ConnectData.getConnection();
    }

    // Kiều Hoàng Mạnh Khang
    public int getCountRooms() {
        int totalRoom = 0;
        String sql = "select count(*) as TotalRooms from Rooms";
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                totalRoom = rs.getInt("TotalRooms");
            }

        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return totalRoom;
    }

    public int getCountRoomsSearch(String location, LocalDate checkIn, LocalDate checkOut, int people) {
        ResultSet rs = null;
        int totalRoom = 0;
        try {

            String sql = "SELECT \n"
                    + "    count(*) as TotalRooms\n"
                    + "FROM Rooms R\n"
                    + "JOIN Buildings B ON R.BuildingId = B.BuildingId\n"
                    + "WHERE R.MaxOccupancy = ?\n"
                    + "AND R.Status  =N'Active'\n"
                    + "AND B.Location = ?\n"
                    + "AND NOT EXISTS (\n"
                    + "    SELECT 1\n"
                    + "    FROM Bookings B\n"
                    + "    WHERE B.RoomId = R.RoomId\n"
                    + "    AND B.StartDate < ? AND B.EndDate >? \n"
                    + "   AND B.Status IN (N'Checked in', N'Confirmed', N'Waiting for processing')\n"
                    + ")";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, people);
            st.setString(2, location);
            st.setDate(3, Date.valueOf(checkOut));
            st.setDate(4, Date.valueOf(checkIn));
            rs = st.executeQuery();
            if (rs.next()) {
                totalRoom = rs.getInt("TotalRooms");
            }

        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return totalRoom;
    }

    public List<Rooms> getFullRooms(int page) {
        ResultSet rs = null;
        List<Rooms> list = new ArrayList();

        try {
            String sql = "select  RoomId,RoomType,Price,Description, ImageUrl from Rooms order by RoomId offset ? Rows Fetch NEXT 6 Rows Only";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, page);
            rs = st.executeQuery();
            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setImageUrl(rs.getString("ImageUrl"));
                room.setDescription(rs.getString("Description"));
                list.add(room);

            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return list;

    }
//mượn sài tạm

    public List<Rooms> getSearchRooms(String location, LocalDate checkIn, LocalDate checkOut, int people, int page) {
        ResultSet rs = null;
        List<Rooms> list = new ArrayList();
        try {
            String sql = "SELECT \n"
                    + "    R.RoomId,\n"
                    + "    R.RoomType,\n"
                    + "    R.Price,\n"
                    + "    R.Description,\n"
                    + "    R.ImageUrl\n"
                    + "FROM Rooms R\n"
                    + "JOIN Buildings B ON R.BuildingId = B.BuildingId\n"
                    + "WHERE R.MaxOccupancy = ?\n"
                    + "AND R.Status  =N'Active'\n"
                    + "AND B.Location = ?\n"
                    + "AND NOT EXISTS (\n"
                    + "    SELECT 1\n"
                    + "    FROM Bookings B\n"
                    + "    WHERE B.RoomId = R.RoomId\n"
                    + "    AND B.StartDate < ? AND B.EndDate >? \n"
                    + "   AND B.Status IN (N'Checked in', N'Confirmed', N'Waiting for processing')\n"
                    + ")   order by RoomId offset ? Rows Fetch NEXT 6 Rows Only";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, people);
            st.setString(2, location);
            st.setDate(3, Date.valueOf(checkOut));
            st.setDate(4, Date.valueOf(checkIn));
            st.setInt(5, page);
            rs = st.executeQuery();
            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setImageUrl(rs.getString("ImageUrl"));
                room.setDescription(rs.getString("Description"));
                list.add(room);

            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return list;

    }

    public Rooms getRoomDetail(int id) {
        ResultSet rs = null;
        Rooms room = new Rooms();
        try {
            String sql = "SELECT \n"
                    + "    R.RoomId,\n"
                    + "    R.RoomType,\n"
                    + "    R.Price,\n"
                    + "    R.Description,\n"
                    + "    R.ImageUrl,\n"
                    + "     R.Area\n"
                    + "FROM Rooms R\n"
                    + "where R.RoomId = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            while (rs.next()) {
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setImageUrl(rs.getString("ImageUrl"));
                room.setDescription(rs.getString("Description"));
                room.setArea(rs.getFloat("Area"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return room;
    }

    public int getNumberOfReview(int id) {
        ResultSet rs = null;
        int numberOfReview = 0;
        try {
            String sql = "SELECT \n"
                    + " Count(	RR.Comment) as Total  \n"
                    + "FROM Rooms R\n"
                    + "Inner JOIN RoomReviews RR on RR.RoomId = R.RoomId\n"
                    + "Inner JOIN Customers C on  C.CustomerId =RR.CustomerId \n"
                    + "where R.RoomId = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            if (rs.next()) {
                numberOfReview = rs.getInt("Total");

            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return numberOfReview;

    }

    public float getTotalRating(int id, int numberOfReview) {
        ResultSet rs = null;
        float totalRating = 0;
        try {
            String sql = "SELECT \n"
                    + "	Sum(RR.Rating) as Total \n"
                    + "FROM Rooms R\n"
                    + "Inner JOIN RoomReviews RR on RR.RoomId = R.RoomId\n"
                    + "Inner JOIN Customers C on  C.CustomerId =RR.CustomerId \n"
                    + "where R.RoomId = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            if (rs.next()) {
                totalRating = rs.getInt("Total");

            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return (float) totalRating / numberOfReview;

    }

    public List<Amenities> getAmenities(int id) {
        ResultSet rs = null;
        List<Amenities> list = new ArrayList();
        try {
            String sql = "SELECT \n"
                    + "	A.Name\n"
                    + "FROM Rooms R\n"
                    + "Inner JOIN RoomAmenities RA on RA.RoomId = R.RoomId\n"
                    + "Inner JOIN Amenities A on A.AmenityId = RA.AmenityId\n"
                    + "where R.RoomId = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            while (rs.next()) {
                Amenities amenities = new Amenities();
                amenities.setName(rs.getString("Name"));
                list.add(amenities);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return list;

    }

    public List<RoomReviews> getCustomerReviews(int id) {
        ResultSet rs = null;
        List<RoomReviews> list = new ArrayList();
        try {
            String sql = "SELECT \n"
                    + "	C.AvatarUrl,\n"
                    + "	C.UserName,\n"
                    + "	RR.Comment,\n"
                    + "	RR.Rating,\n"
                    + "	RR.CreatedAt\n"
                    + "FROM Rooms R\n"
                    + "Inner JOIN RoomReviews RR on RR.RoomId = R.RoomId\n"
                    + "Inner JOIN Customers C on  C.CustomerId =RR.CustomerId \n"
                    + "where R.RoomId = ?\n"
                    + "Order by ReviewId desc";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            while (rs.next()) {
                RoomReviews roomreview = new RoomReviews();
                roomreview.setComment(rs.getString("Comment"));
                roomreview.setRating(rs.getInt("Rating"));
                roomreview.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                Customers customer = new Customers();
                customer.setAvatarUrl(rs.getString("AvatarUrl"));
                customer.setUserName(rs.getString("UserName"));
                roomreview.setCustomer(customer);
                list.add(roomreview);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void clearRoomCustomerInfo(int roomId) throws SQLException {
        String sql = "UPDATE Rooms SET Status = 0 WHERE RoomId = ?";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, roomId);
            stmt.executeUpdate();
        }

    }

    public Rooms getInformationRoomBooking(int id) {
        ResultSet rs = null;
        Rooms room = new Rooms();
        try {
            String sql = "select RoomId,RoomNumber,RoomType,Price,ImageUrl,BedType from Rooms where RoomId=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            if (rs.next()) {
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setImageUrl(rs.getString("ImageUrl"));
                room.setBedType(rs.getString("BedType"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return room;
    }

    public List<Rooms> getFullRoomsForDashboard(int page) {
        ResultSet rs = null;
        List<Rooms> list = new ArrayList();

        try {
            String sql = "select RoomId, FloorNumber,RoomNumber,RoomType, Price , status from Rooms order by RoomNumber offset (?-1) *10 Rows Fetch NEXT 10 row only";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, page);
            rs = st.executeQuery();
            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("RoomId"));
                room.setFloorNumber(rs.getInt("FloorNumber"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setStatus(rs.getString("Status"));
                list.add(room);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Rooms> getSearchOfDashBoard(int page, int roomNumber) {
        List<Rooms> list = new ArrayList<>();

        ResultSet rs = null;
        try {
            String sql = "select RoomId,FloorNumber,RoomNumber,RoomType, Price , status from Rooms\n"
                    + "where RoomNumber like ?\n"
                    + "order by RoomNumber offset (?-1) *10 Rows Fetch NEXT 10 row only";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, "%" + roomNumber + "%");
            st.setInt(2, page);
            rs = st.executeQuery();
            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("RoomId"));
                room.setFloorNumber(rs.getInt("FloorNumber"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setStatus(rs.getString("Status"));
                list.add(room);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;

    }

    public int checkRoomOfFoor(String roomNumber, int floorNumber) {
        ResultSet rs = null;
        try {
            String sql = "select RoomId from Rooms where RoomNumber = ? and FloorNumber =?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, roomNumber);
            pst.setInt(2, floorNumber);
            rs = pst.executeQuery();
            if (rs.next()) {
                return 1;
            }

        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int createRoom(String roomNumber, int floorNumber, String roomType, String bedType, Long price, int maxOccupancy,
            String description, String imageUrl, String status, int buildingId, float area) {
        int cnt = 0;
        try {
            String sql = "INSERT INTO Rooms \n"
                    + "(RoomNumber, FloorNumber,\n"
                    + "RoomType, BedType,\n"
                    + "Price, MaxOccupancy,\n"
                    + "Description, ImageUrl,\n"
                    + "Status, BuildingId,Area)\n"
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, roomNumber);
            pst.setInt(2, floorNumber);
            pst.setString(3, roomType);
            pst.setString(4, bedType);
            pst.setLong(5, price);
            pst.setInt(6, maxOccupancy);
            pst.setString(7, description);
            pst.setString(8, imageUrl);
            pst.setString(9, status);
            pst.setInt(10, buildingId);
            pst.setFloat(11, area);

            cnt = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cnt;
    }

    // vinh
    public List<Rooms> getAllRooms() {
        List<Rooms> list = new ArrayList<>();
        String sql = "SELECT * FROM rooms ORDER BY floor_number, room_number";

        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Rooms r = new Rooms();
                r.setRoomId(rs.getInt("room_id"));
                r.setRoomNumber(rs.getString("room_number"));
                r.setRoomType(rs.getString("room_type"));
                r.setFloorNumber(rs.getInt("floor_number"));
                r.setStatus(rs.getString("status")); // nếu có
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

//vinh select room    
    public List<Rooms> getAvailableRoomSameType(int bookingId) {
        List<Rooms> list = new ArrayList<>();

        try {
            // 1. Lấy ngày và loại phòng từ đơn đặt
            String bookingSQL = "SELECT StartDate, EndDate, RoomType FROM Bookings WHERE BookingId = ?";
            PreparedStatement ps1 = conn.prepareStatement(bookingSQL);
            ps1.setInt(1, bookingId);
            ResultSet rs1 = ps1.executeQuery();

            if (rs1.next()) {
                LocalDate startDate = rs1.getDate("StartDate").toLocalDate();
                LocalDate endDate = rs1.getDate("EndDate").toLocalDate();
                String roomType = rs1.getString("RoomType");

                // 2. Lấy các phòng đang trống và cùng loại phòng
                String sql = "SELECT * FROM Rooms R "
                        + "WHERE R.RoomType = ? AND R.Status = 'Active' "
                        + "AND NOT EXISTS ("
                        + "    SELECT 1 FROM Bookings B "
                        + "    WHERE B.RoomId = R.RoomId "
                        + "    AND B.StartDate < ? AND B.EndDate > ? "
                        + "    AND B.Status IN ('Waiting for processing', 'Confirmed', 'Checked in', 'Canceled')"
                        + ") "
                        + "ORDER BY R.FloorNumber, R.RoomNumber";

                PreparedStatement ps2 = conn.prepareStatement(sql);
                ps2.setString(1, roomType);
                ps2.setDate(2, Date.valueOf(endDate));
                ps2.setDate(3, Date.valueOf(startDate));
                ResultSet rs2 = ps2.executeQuery();

                while (rs2.next()) {
                    Rooms room = new Rooms();
                    room.setRoomId(rs2.getInt("RoomId"));
                    room.setRoomType(rs2.getString("RoomType"));
                    room.setPrice(rs2.getInt("Price"));
                    room.setDescription(rs2.getString("Description"));
                    room.setImageUrl(rs2.getString("ImageUrl"));
                    room.setFloorNumber(rs2.getInt("FloorNumber"));
                    room.setRoomNumber(rs2.getString("RoomNumber"));
                    list.add(room);
                }
                rs2.close();
                ps2.close();
            }
            rs1.close();
            ps1.close();
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    //vinh dùng cho select room
    public List<Rooms> getAvailableRoomByDateAndType(LocalDate startDate, LocalDate endDate, String roomType) {
        List<Rooms> list = new ArrayList<>();

        try {

            System.out.println(startDate);
            System.out.println(endDate);
            String sql = "SELECT * FROM Rooms R "
                    + "WHERE R.RoomType = ? AND R.Status = 'Active' "
                    + "AND NOT EXISTS ("
                    + "    SELECT 1 FROM Bookings B "
                    + "    WHERE B.RoomId = R.RoomId "
                    + "    AND (B.EndDate > ? AND B.StartDate < ?) "
                    + "    AND B.Status IN ('Waiting for processing', 'Confirmed', 'Checked in', 'Canceled')"
                    + ") "
                    + "ORDER BY R.FloorNumber, R.RoomNumber";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, roomType);
            ps.setDate(2, Date.valueOf(endDate));   // B.EndDate > start
            ps.setDate(3, Date.valueOf(startDate)); // B.StartDate < end

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setDescription(rs.getString("Description"));
                room.setImageUrl(rs.getString("ImageUrl"));
                room.setFloorNumber(rs.getInt("FloorNumber"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                list.add(room);
            }

        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;

    }

    //vinh
    public List<Rooms> getAvailableRoomByDateRange(LocalDate startDate, LocalDate endDate) {
        List<Rooms> list = new ArrayList<>();
        System.out.println(startDate);
        System.out.println(endDate);
        try {
            String sql = "SELECT R.RoomId, R.RoomType, R.Price, R.Description, R.ImageUrl, R.FloorNumber, R.RoomNumber "
                    + "FROM Rooms R "
                    + "WHERE R.Status = N'Active' "
                    + "AND NOT EXISTS ( "
                    + "    SELECT 1 FROM Bookings B "
                    + "    WHERE B.RoomId = R.RoomId "
                    + "    AND B.StartDate < ? "
                    + "    AND B.EndDate > ? "
                    + "    AND B.Status IN (N'Confirmed', N'Checked in', N'Checked out', N'Canceled') "
                    + ") "
                    + "ORDER BY R.FloorNumber, R.RoomNumber";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDate(1, Date.valueOf(endDate));
            ps.setDate(2, Date.valueOf(startDate));

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setDescription(rs.getString("Description"));
                room.setImageUrl(rs.getString("ImageUrl"));
                room.setFloorNumber(rs.getInt("FloorNumber"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                list.add(room);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //vinh
    public List<Rooms> getAllActiveRooms() throws SQLException {
        List<Rooms> rooms = new ArrayList<>();

        String sql = "SELECT RoomId, RoomType, Price, MaxOccupancy, RoomNumber, FloorNumber "
                + "FROM Rooms "
                + "WHERE Status = 'Active' "
                + "ORDER BY RoomId ASC";

        try ( PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getLong("Price"));
                room.setMaxOccupancy(rs.getInt("MaxOccupancy"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setFloorNumber(rs.getInt("FloorNumber"));
                // Nếu bạn có thêm trường nào khác muốn hiển thị thì set thêm ở đây
                rooms.add(room);
            }
        }

        return rooms;
    }
//vinh

    public List<Rooms> getAvailableRoomTypes(LocalDate startDate, LocalDate endDate, int guestCount) throws SQLException {
        List<Rooms> availableRooms = new ArrayList<>();

        String sql = "SELECT RoomId, RoomType, Price, MaxOccupancy, RoomNumber, FloorNumber "
                + "FROM Rooms R "
                + "WHERE R.Status = 'Active' "
                + "AND R.MaxOccupancy >= ? "
                + "AND NOT EXISTS ( "
                + "    SELECT 1 FROM Bookings B "
                + "    WHERE B.RoomId = R.RoomId "
                + "    AND B.StartDate < ? AND B.EndDate > ? "
                + "    AND B.Status IN ('Confirmed', 'Checked in', 'Waiting for processing', 'Canceled') "
                + ") "
                + "ORDER BY RoomId ASC";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, guestCount);
            ps.setDate(2, Date.valueOf(endDate));  // check-out
            ps.setDate(3, Date.valueOf(startDate)); // check-in

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getLong("Price"));
                room.setMaxOccupancy(rs.getInt("MaxOccupancy"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setFloorNumber(rs.getInt("FloorNumber"));
                availableRooms.add(room);
            }
        }

        return availableRooms;
    }

    //vinh
    public String getRoomTypeById(int roomId) throws SQLException {
        String roomType = "Không xác định";
        String sql = "SELECT RoomType FROM Rooms WHERE RoomId = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                roomType = rs.getString("RoomType");
            }
        }
        return roomType;
        
    }

    public Rooms getRoomDetailForEdit(int id) {
        ResultSet rs = null;
        Rooms room = new Rooms();
        try {
            String sql = "SELECT \n"
                    + "    R.RoomId,\n"
                    + "R.RoomNumber,\n"
                    + "R.FloorNumber,\n"
                    + "    R.RoomType,\n"
                    + "    R.Price,\n"
                    + "R.BedType,\n"
                    + "    R.Description,\n"
                    + "    R.ImageUrl,\n"
                    + "R.Status,\n"
                    + "R.BuildingId,\n"
                    + "     R.Area\n"
                    + "FROM Rooms R\n"
                    + "where R.RoomId = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            if (rs.next()) {
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setFloorNumber(rs.getInt("FloorNumber"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getInt("Price"));
                room.setBedType(rs.getString("BedType"));
                room.setImageUrl(rs.getString("ImageUrl"));
                room.setDescription(rs.getString("Description"));
                room.setStatus(rs.getString("Status"));
                room.setBuildingId(rs.getInt("BuildingId"));
                room.setArea(rs.getFloat("Area"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return room;
    }

    public int UpdateRoomDetailForEdit(Rooms r) {
        int check = 0;
        try {
            String sql = "UPDATE Rooms\n"
                    + "SET\n"
                    + "    FloorNumber = ?,         \n"
                    + "    RoomType = ?,           \n"
                    + "    BedType = ?,            \n"
                    + "    Price = ?,              \n"
                    + "    MaxOccupancy = ?,       \n"
                    + "    Description = ?,        \n"
                    + "    ImageUrl = ?,          \n"
                    + "    Status = ?,           \n"
                    + "    BuildingId = ?,        \n"
                    + "    Area = ?         \n"
                    + "WHERE\n"
                    + "    RoomId = ?;            ";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, r.getFloorNumber());
            pst.setString(2, r.getRoomType());
            pst.setString(3, r.getBedType());
            pst.setLong(4, r.getPrice());
            pst.setInt(5, r.getMaxOccupancy());
            pst.setString(6, r.getDescription());
            pst.setString(7, r.getImageUrl());
            pst.setString(8, r.getStatus());
            pst.setInt(9, r.getBuildingId());
            pst.setFloat(10, r.getArea());
            pst.setInt(11, r.getRoomId());
            check = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return check;
    }

    public boolean updateRoomStatus(int roomId, String status) { //khanh
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = ConnectData.getConnection();
            String sql = "UPDATE Rooms SET Status = ? WHERE RoomId = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);        // Ví dụ: "Occupied"
            ps.setInt(2, roomId);           // ID của phòng cần cập nhật

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
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
    }

    public Map<Integer, List<Rooms>> getAvailableRoomsGroupedByFloor(LocalDate checkIn, LocalDate checkOut, String location, int numberOfGuests) {
        Map<Integer, List<Rooms>> roomsByFloor = new HashMap<>();
        ResultSet rs = null;

        try {
            String sql = "SELECT "
                    + "R.RoomId, "
                    + "R.RoomNumber, "
                    + "R.RoomType, "
                    + "R.FloorNumber, "
                    + "R.MaxOccupancy, "
                    + "R.Status, "
                    + "B.Location "
                    + "FROM Rooms R "
                    + "JOIN Buildings B ON R.BuildingId = B.BuildingId "
                    + "WHERE R.Status = 'Available' "
                    + "AND B.Location LIKE ? "
                    + "AND R.MaxOccupancy >= ? "
                    + "AND R.RoomId NOT IN ( "
                    + "   SELECT RoomId FROM Bookings "
                    + "   WHERE (? < EndDate AND ? > StartDate) "
                    + "   AND Status IN ('Confirmed', 'Checked in') "
                    + ") "
                    + "ORDER BY R.FloorNumber, R.RoomNumber";

            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, "%" + location + "%");
            st.setInt(2, numberOfGuests);
            st.setDate(3, java.sql.Date.valueOf(checkOut));
            st.setDate(4, java.sql.Date.valueOf(checkIn));

            rs = st.executeQuery();

            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomType(rs.getString("RoomType"));
                room.setFloorNumber(rs.getInt("FloorNumber"));
                room.setMaxOccupancy(rs.getInt("MaxOccupancy"));
                room.setStatus(rs.getString("Status"));
                int floorNumber = rs.getInt("FloorNumber");

                if (!roomsByFloor.containsKey(floorNumber)) {
                    roomsByFloor.put(floorNumber, new ArrayList<Rooms>());
                }
                roomsByFloor.get(floorNumber).add(room);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return roomsByFloor;
    }

    public List<String> getRoomTypesByBookingRoomType(String roomType) {
        List<String> roomList = new ArrayList<>();
        String sql = "SELECT DISTINCT RoomNumber FROM Rooms WHERE RoomType = ? AND Status = 'Available'";

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, roomType);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                roomList.add(rs.getString("RoomNumber"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roomList;
    }

    //khanh
    public List<Rooms> getlistCheckIn(LocalDate startDate, LocalDate endDate, int guestCount,String roomType) throws SQLException {
        List<Rooms> availableRooms = new ArrayList<>();

        String sql = "SELECT RoomId, RoomType, Price, MaxOccupancy, RoomNumber, FloorNumber "
                + "FROM Rooms R "
                + "WHERE R.Status = 'Active' "
                + "AND R.MaxOccupancy >= ? "
                + "AND R.RoomType = ? "
                + "AND NOT EXISTS ( "
                + "    SELECT 1 FROM Bookings B "
                + "    WHERE B.RoomId = R.RoomId "
                + "    AND B.StartDate < ? AND B.EndDate > ? "
                + "    AND B.Status IN ('Confirmed', 'Checked in', 'Waiting for processing', 'Canceled') "
                + ") "
                + "ORDER BY RoomId ASC";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, guestCount);
            ps.setString(2, roomType);
            ps.setDate(3, Date.valueOf(endDate));  // check-out
            ps.setDate(4, Date.valueOf(startDate)); // check-in

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Rooms room = new Rooms();
                room.setRoomId(rs.getInt("RoomId"));
                room.setRoomType(rs.getString("RoomType"));
                room.setPrice(rs.getLong("Price"));
                room.setMaxOccupancy(rs.getInt("MaxOccupancy"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setFloorNumber(rs.getInt("FloorNumber"));
                availableRooms.add(room);
            }
        }

        return availableRooms;
    }

    //khanh
    public Rooms getRoomByIdkhanh(int roomId) throws SQLException {
        Rooms room = null;

        String sql = "SELECT RoomId, RoomNumber, FloorNumber, RoomType, MaxOccupancy, Price "
                + "FROM Rooms WHERE RoomId = ?";

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomId);

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    room = new Rooms();
                    room.setRoomId(rs.getInt("RoomId"));
                    room.setRoomNumber(rs.getString("RoomNumber"));
                    room.setFloorNumber(rs.getInt("FloorNumber"));
                    room.setRoomType(rs.getString("RoomType"));
                    room.setMaxOccupancy(rs.getInt("MaxOccupancy"));
                    room.setPrice(rs.getLong("Price"));
                }
            }
        }

        return room;
    }
    public int deleteRoom(int roomId, String status) {
        int count = 0;
        try {
            String sql = " UPDATE Rooms\n"
                    + "SET Status = ?\n"
                    + "WHERE RoomId = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, status);
            pst.setInt(2, roomId);

            count = pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(RoomDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return count;

    }

}
