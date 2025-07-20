/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.checkInOut;

import controllers.admin.*;
import dao.BookingDao;
import dao.RoomDao;
import dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Bookings;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
@WebServlet("/ViewAllCheckInOutDashboard")
public class ViewAllCheckInOutDashboard extends HttpServlet {

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
            out.println("<title>Servlet AdminView</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminView at " + request.getContextPath() + "</h1>");
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
        try {
            BookingDao dao = new BookingDao();
            List<Bookings> list = dao.getAllBookingsKhanh();
            request.setAttribute("checkInList", list);
            request.getRequestDispatcher("checkInOut/viewAllCheckInOutDashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải dữ liệu");
            request.getRequestDispatcher("checkInOut/viewAllCheckInOutDashboard.jsp").forward(request, response);
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
     protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingIdStr = request.getParameter("bookingId");
        String action = request.getParameter("action");

        if (bookingIdStr != null && action != null) {
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                BookingDao dao = new BookingDao();

                if (action.equals("Checked out")) {
                    dao.updateBookingStatus(bookingId, "Checked out");

                    // Nếu có update phòng thì cập nhật lại phòng là Available (nếu muốn)
                    Bookings booking = dao.getBookingById(bookingId);
                    int roomId = booking.getRoomId();
                    RoomDao roomDao = new RoomDao();
                    roomDao.updateRoomStatus(roomId, "Available");
                }

                List<Bookings> list = dao.getAllBookingsKhanh();
                request.setAttribute("checkInList", list);

//                request.getRequestDispatcher("checkInOut/viewAllCheckInOutDashboard.jsp").forward(request, response);
                // Chuyển về lại trang chính để thấy nút Check-Out
                response.sendRedirect("ViewAllCheckInOutDashboard");
            } catch (SQLException ex) {
                Logger.getLogger(ViewAllCheckInOutDashboard.class.getName()).log(Level.SEVERE, null, ex);
                response.sendRedirect("checkInOut/viewAllCheckInOutDashboard.jsp?error=3");
            } catch (Exception ex) {
                ex.printStackTrace();
                response.sendRedirect("checkInOut/viewAllCheckInOutDashboard.jsp?error=2");
            }
        } else {
            response.sendRedirect("checkInOut/viewAllCheckInOutDashboard.jsp?error=1");
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
