/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.checkInOut;

import dao.BookingDao;
import dao.RoomDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import models.Bookings;
import models.Rooms;

/**
 *
 * @author KHANH
 */
@WebServlet(name = "SelectAvailableRoom", urlPatterns = {"/SelectAvailableRoom"})
public class SelectAvailableRoom extends HttpServlet {

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
            out.println("<title>Servlet SelectAvailableRoom</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SelectAvailableRoom at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String bookingIdRaw = request.getParameter("bookingId");
        String actualGuestsRaw = request.getParameter("actualGuests");

        if (bookingIdRaw == null || bookingIdRaw.isEmpty()
                || actualGuestsRaw == null || actualGuestsRaw.isEmpty()) {
            response.sendRedirect("viewAllCheckInOutDashboard.jsp?error=missing_data");
            return;
        }

        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            int actualGuests = Integer.parseInt(request.getParameter("actualGuests"));

            BookingDao bookingDao = new BookingDao();
            Bookings booking = bookingDao.getBookingCheckInInfo(bookingId);
            String roomType = booking.getRoomType();
         
LocalDate startDate = booking.getStartDate();
LocalDate endDate = booking.getEndDate();
            RoomDao roomDao = new RoomDao();
            List<Rooms> availableRooms = roomDao.getlistCheckIn(startDate, endDate, actualGuests, roomType);

            request.setAttribute("availableRooms", availableRooms);
            request.setAttribute("bookingId", bookingId);
            request.setAttribute("actualGuests", actualGuests);
            request.getRequestDispatcher("checkInOut/selectAvailableRoom.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SelectAvailableRoom.class.getName()).log(Level.SEVERE, null, ex);
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
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        try {
//            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
//            int actualGuests = Integer.parseInt(request.getParameter("actualGuests"));
//            int roomId = Integer.parseInt(request.getParameter("roomId"));
//
//            BookingDao dao = new BookingDao();
//            dao.updateRoomForBooking(bookingId, roomId, actualGuests); // bạn viết method update riêng
//
//            response.sendRedirect("SelectAvailableRoom");
//        } catch (SQLException ex) {
//            Logger.getLogger(SelectAvailableRoom.class.getName()).log(Level.SEVERE, null, ex);
//     

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        int roomId = Integer.parseInt(request.getParameter("roomId"));

        LocalDateTime currentDateTime = LocalDateTime.now();

        BookingDao dao = new BookingDao();
        dao.insertRoomIdForBookingK(bookingId, roomId, currentDateTime);

        response.sendRedirect("ViewAllCheckInOutDashboard");

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
