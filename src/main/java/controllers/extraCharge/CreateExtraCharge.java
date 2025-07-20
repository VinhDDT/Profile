///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package controllers.extraCharge;
//
//import extraCharge.*;
//import dao.BookingDao;
//import dao.ExtraChargeDao;
//import dao.RoomDao;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.time.Duration;
//import java.time.LocalDateTime;
//import java.util.List;
//import models.Bookings;
//import models.ExtraCharge;
//import models.Rooms;
//
///**
// *
// * @author dodan
// */
//@WebServlet(name = "CreateExtraCharge", urlPatterns = {"/CreateExtraCharge"})
//public class CreateExtraCharge extends HttpServlet {
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try ( PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet CreateExtraCharge</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet CreateExtraCharge at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        Bookings b = new Bookings();
//        BookingDao dao = new BookingDao();
//        List<Bookings> list;
//        list = dao.getAllBookingsActive();
//        request.setAttribute("activeBookings", list);
//        request.getRequestDispatcher("extraCharge/createExtraCharge.jsp").forward(request, response);
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String action = request.getParameter("action");
//        BookingDao bookingDao = new BookingDao();
//        ExtraChargeDao extraChargeDao = new ExtraChargeDao();
//        RoomDao roomDao = new RoomDao();
//
//        if ("check".equals(action)) {
//            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
//            int roomId = Integer.parseInt(request.getParameter("roomId"));
//
//            // Lưu bookingId vào session
//            request.getSession().setAttribute("bookingId", bookingId);
//
//            Bookings currentBooking = bookingDao.getBookingById(bookingId);
//
//            // Lấy thời gian kết thúc gần nhất từ ExtraCharge
//            LocalDateTime currentEnd = extraChargeDao.getLatestExtraChargeEndTime(bookingId);
//            if (currentEnd == null) {
//                currentEnd = currentBooking.getEndDate();
//            }
//
//            // Tìm booking kế tiếp
//            Bookings nextBooking = bookingDao.getNextBookingByRoom(roomId, currentEnd, bookingId);
//            LocalDateTime maxExtendDate = (nextBooking != null)
//                    ? nextBooking.getStartDate().withHour(12).withMinute(0).withSecond(0)
//                    : currentEnd.plusDays(3).withHour(12).withMinute(0).withSecond(0);
//
//            // Đơn giá
//            long roomPrice = roomDao.getPriceRoomByBookingId(bookingId);
//            long hourlyPrice = Math.round(roomPrice * 0.1);
//
//            request.setAttribute("roomPrice", roomPrice);
//            request.setAttribute("hourlyPrice", hourlyPrice);
//            request.setAttribute("selectedBooking", currentBooking);
//            request.setAttribute("maxExtendDate", maxExtendDate);
//            request.setAttribute("currentExtendStart", currentEnd); // gửi về JSP
//            request.setAttribute("activeBookings", bookingDao.getAllBookingsActive());
//
//            request.getRequestDispatcher("extraCharge/createExtraCharge.jsp").forward(request, response);
//
//        } else if ("extend".equals(action)) {
//            Integer bookingId = (Integer) request.getSession().getAttribute("bookingId");
//            if (bookingId == null) {
//                response.getWriter().println("<script>alert('Session expired. Please recheck booking.');"
//                        + "window.location='CreateExtraCharge';</script>");
//                return;
//            }
//
//            Bookings booking = bookingDao.getBookingById(bookingId);
//            int extendHours = Integer.parseInt(request.getParameter("extendHours"));
//            String chargeType = request.getParameter("chargeType");
//
//            long roomPrice = roomDao.getPriceRoomByBookingId(bookingId);
//            long hourlyPrice = Math.round(roomPrice * 0.1);
//
//            // Tìm thời gian bắt đầu mới nhất
//            LocalDateTime startTime = extraChargeDao.getLatestExtraChargeEndTime(bookingId);
//            if (startTime == null) {
//                startTime = booking.getEndDate();
//            }
//
//            LocalDateTime endTime = startTime.plusHours(extendHours);
//
//            ExtraCharge ec = new ExtraCharge();
//            ec.setBookingId(bookingId);
//            ec.setChargeType(chargeType);
//            ec.setQuantity(extendHours);
//            ec.setUnitPrice(hourlyPrice);
//            ec.setStartTime(startTime);
//            ec.setEndTime(endTime);
//
//            boolean success = extraChargeDao.insertExtraCharge(ec);
//
//            String message = success ? "Extra charge created successfully." : "Failed to create extra charge.";
//            response.setContentType("text/html;charset=UTF-8");
//            PrintWriter out = response.getWriter();
//            out.println("<script type='text/javascript'>");
//            out.println("alert('" + message + "');");
//            out.println("window.location='ViewAllExtraCharge';");
//            out.println("</script>");
//        }
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
