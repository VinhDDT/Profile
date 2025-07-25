/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.booking;

import dao.BookingDao;
import jakarta.mail.MessagingException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Bookings;
import sendMail.EmailSender;

/**
 *
 * @author Dương Đinh Thế Vinh
 */
@WebServlet("/BookingCancel")
public class BookingCancel extends HttpServlet {

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
            out.println("<title>Servlet BookingCancel</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingCancel at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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

        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("staffId") == null) {
            response.sendRedirect("Login");
            return;
        }

        int canceledBy = Integer.parseInt(session.getAttribute("staffId").toString());

        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            String notes = request.getParameter("notes");

            BookingDao bookingDAO = new BookingDao();

            // 1. Cập nhật trạng thái hủy
            bookingDAO.cancelBooking(bookingId, notes, canceledBy);

            // 2. Lấy thông tin khách hàng để gửi mail
            Bookings booking = bookingDAO.getBookingInfoForCancellation(bookingId);
            Bookings info = bookingDAO.getBookingInfoForCancellation(bookingId); // Phải chứa RoomType và Notes

            if (info != null) {
                EmailSender sender = new EmailSender();
                try {
                    sender.sendCancellationEmail(
                            info.getCustomers().getEmail(),
                            "Booking Cancelled",
                            info.getCustomers().getFullName(),
                            bookingId,
                            info.getStartDate(),
                            info.getEndDate(),
                            info.getRoomType(),
                            info.getNotes() // lý do hủy
                    );
                } catch (MessagingException ex) {
                    Logger.getLogger(BookingCancel.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            response.sendRedirect("BookingConfirmation");
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request");
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
