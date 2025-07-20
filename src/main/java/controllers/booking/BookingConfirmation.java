/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.booking;

import dao.BookingDao;
import dao.RoomDao;
import jakarta.mail.MessagingException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Bookings;
import models.Rooms;
import sendMail.EmailSender;

/**
 *
 * @author CE180441_Dương Đinh Thế Vinh
 */
@WebServlet("/BookingConfirmation")
public class BookingConfirmation extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VouchersDashBoard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VouchersDashBoard at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Lấy dữ liệu từ session
        String roomType = (String) session.getAttribute("search_room");
        String fullName = (String) session.getAttribute("search_name");
        String startDate = (String) session.getAttribute("search_start");
        String endDate = (String) session.getAttribute("search_end");
        String status = (String) session.getAttribute("search_status");

        // Xóa session sau khi sử dụng để tránh lưu lại sau khi load
        session.removeAttribute("search_room");
        session.removeAttribute("search_name");
        session.removeAttribute("search_start");
        session.removeAttribute("search_end");
        session.removeAttribute("search_status");

        try {
            BookingDao dao = new BookingDao();
            List<Bookings> list;

            boolean isSearch
                    = (roomType != null && !roomType.trim().isEmpty())
                    || (fullName != null && !fullName.trim().isEmpty())
                    || (startDate != null && !startDate.trim().isEmpty())
                    || (endDate != null && !endDate.trim().isEmpty())
                    || (status != null && !status.trim().isEmpty());

            if (isSearch) {
                request.setAttribute("searched", true); // Gắn cờ tìm kiếm
                list = dao.searchBookings(roomType, fullName, startDate, endDate, status);
            } else {
                list = dao.getAllBookings();
            }

            // Định dạng ngày không có giờ
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            // Cập nhật ngày cho mỗi booking
            for (Bookings b : list) {
                if (b.getStartDate() != null) {
                    b.setFormattedStartDate(b.getStartDate().format(formatter));
                }
                if (b.getEndDate() != null) {
                    b.setFormattedEndDate(b.getEndDate().format(formatter));
                }
            }

            // Truyền lại thông tin tìm kiếm vào form
            request.setAttribute("roomType", roomType);
            request.setAttribute("fullName", fullName);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            request.setAttribute("status", status);
            request.setAttribute("booking", list);

            if (isSearch && list.isEmpty()) {
                request.setAttribute("noResult", true); // Thông báo không có kết quả
            }

            request.getRequestDispatcher("booking/bookingConfirmation.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Internal Server Error");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String actionType = request.getParameter("actionType");
        HttpSession session = request.getSession();

        try {
            if ("goToSelectRoom".equals(actionType) || "confirmBooking".equals(actionType)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));

                RoomDao roomDao = new RoomDao();
                List<Rooms> availableRooms = roomDao.getAvailableRoomSameType(bookingId);

                // Nếu không còn phòng cùng loại
                if (availableRooms.isEmpty()) {
                    request.setAttribute("noRoomTypeAlert", true);

                    // Gửi lại danh sách booking để load lại trang
                    BookingDao dao = new BookingDao();
                    List<Bookings> list = dao.getAllBookings();

                    // Format ngày lại nếu cần
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    for (Bookings b : list) {
                        if (b.getStartDate() != null) {
                            b.setFormattedStartDate(b.getStartDate().format(formatter));
                        }
                        if (b.getEndDate() != null) {
                            b.setFormattedEndDate(b.getEndDate().format(formatter));
                        }
                    }

                    request.setAttribute("booking", list);
                    request.getRequestDispatcher("booking/bookingConfirmation.jsp").forward(request, response);
                    return;
                }

                // Nếu còn phòng
                if ("goToSelectRoom".equals(actionType)) {
                    // Chuyển sang SelectRoom servlet (sử dụng forward để giữ bookingId)
                    request.setAttribute("bookingId", bookingId);
                    request.getRequestDispatcher("SelectRoom").forward(request, response);
                    return;
                }

                if ("confirmBooking".equals(actionType)) {
                    String staffIdStr = (String) session.getAttribute("staffId");
                    if (staffIdStr == null) {
                        response.sendRedirect("Login");
                        return;
                    }

                    int confirmedBy = Integer.parseInt(staffIdStr);
                    BookingDao dao = new BookingDao();
                    String currentStatus = dao.getBookingStatus(bookingId);

                    if ("Waiting for processing".equalsIgnoreCase(currentStatus)) {
                        String roomIdStr = request.getParameter("roomId"); // có thể có hoặc không

                        if (roomIdStr != null && !roomIdStr.isEmpty()) {
                            int roomId = Integer.parseInt(roomIdStr);
                            dao.confirmBookingWithRoom(bookingId, roomId, confirmedBy);
                        } else {
                            dao.confirmBooking(bookingId, confirmedBy); // không có roomId
                        }

                        // Gửi mail
                        Bookings info = dao.getBookingInfoForConfirmation(bookingId);
                        if (info != null) {
                            EmailSender sender = new EmailSender();
                            sender.sendHTMLEmail(
                                    info.getCustomers().getEmail(),
                                    "Confirm booking #" + info.getBookingId(),
                                    info.getCustomers().getFullName(),
                                    info.getBookingId(),
                                    info.getStartDate(),
                                    info.getEndDate(),
                                    info.getRooms() != null ? info.getRooms().getRoomType() : "Not assigned",
                                    info.getConfirmationTime()
                            );
                        }

                        session.setAttribute("bookingConfirmed", true);
                    }

                    response.sendRedirect("BookingConfirmation");
                    return;
                }
            }

            // Xử lý tìm kiếm
            String roomType = request.getParameter("roomType");
            String fullName = request.getParameter("fullName");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String status = request.getParameter("status");

            session.setAttribute("search_room", roomType);
            session.setAttribute("search_name", fullName);
            session.setAttribute("search_start", startDate);
            session.setAttribute("search_end", endDate);
            session.setAttribute("search_status", status);

            response.sendRedirect("BookingConfirmation");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("BookingConfirmation");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
