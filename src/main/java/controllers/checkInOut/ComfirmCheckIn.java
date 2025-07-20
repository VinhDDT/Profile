/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.checkInOut;

import dao.BookingDao;
import dao.RoomDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Bookings;
import models.Rooms;
import dao.CustomerDao;
import models.Customers;

/**
 *
 * @author KHANH
 */
@WebServlet("/ComfirmCheckIn")
public class ComfirmCheckIn extends HttpServlet {

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
            out.println("<title>Servlet ComfirmCheckIn</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ComfirmCheckIn at " + request.getContextPath() + "</h1>");
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
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            BookingDao bookingDao = new BookingDao();
            Bookings bookingInfo = bookingDao.getBookingCheckInInfo(bookingId);

            // Đưa dữ liệu sang JSP confirmCheckIn.jsp
            request.setAttribute("bookingInfo", bookingInfo);
            int checkRoom = bookingDao.checkRoomIdExists(bookingId);
            request.setAttribute("checkRoom", checkRoom);
            request.getRequestDispatcher("checkInOut/comfirmCheckIn.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewAllCheckInOutDashboard.jsp?error=1");
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
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            int checkRoom = Integer.parseInt(request.getParameter("checkRoom"));

            BookingDao bookingDao = new BookingDao();
            RoomDao roomDao = new RoomDao();
            CustomerDao customerDao = new CustomerDao();

            String[] cccds = request.getParameterValues("cccd[]");
            String[] guestNames = request.getParameterValues("guestName[]");

            if (cccds == null || cccds.length == 0) {
                response.sendRedirect("viewAllCheckInOutDashboard.jsp?error=noCCCD");
                return;
            }

            String mainGuestCccd = cccds[0];
            Bookings bookingInfo = bookingDao.getBookingCheckInInfo(bookingId);
            Customers cus = customerDao.getCustomerByIdDashboard(bookingInfo.getCustomerId());
            String bookingCustomerCCCD = cus.getIdentityNumber();

            boolean isOwnerPresent = bookingCustomerCCCD.equals(mainGuestCccd);
            int actualGuests = Integer.parseInt(request.getParameter("actualGuests"));

            // Trường hợp phòng đã có
            if (checkRoom != 0) {
                HttpSession session = request.getSession();
                Object receptionObj = session.getAttribute("reception");
                if (receptionObj == null) {
                    response.sendRedirect("viewAllCheckInOutDashboard.jsp?error=session");
                    return;
                }

                int receptionId = Integer.parseInt(receptionObj.toString());
                int check = bookingDao.confirmBookingNotByRoomId(bookingId, receptionId);

                if (check == 0) {
                    response.sendRedirect("viewAllCheckInOutDashboard.jsp?error=confirmFail");
                    return;
                }

                saveGuestCompanions(cccds, guestNames, bookingId, customerDao, bookingDao, isOwnerPresent);
                sendConfirmationPopup(response, isOwnerPresent);
                return;
            }

            // Trường hợp phòng chưa gán
            int assignedRoomId = Integer.parseInt(request.getParameter("assignedRoom"));

            boolean updated = bookingDao.updateCheckInStatus(
                    bookingId, "Checked in", actualGuests, mainGuestCccd, assignedRoomId, LocalDateTime.now()
            );

            roomDao.updateRoomStatus(assignedRoomId, "Occupied");

            saveGuestCompanions(cccds, guestNames, bookingId, customerDao, bookingDao, isOwnerPresent);

            if (updated) {
                sendConfirmationPopup(response, isOwnerPresent);
            } else {
                response.sendRedirect("viewAllCheckInOutDashboard.jsp?error=update");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewAllCheckInOutDashboard.jsp?error=server");
        }
    }

    private void saveGuestCompanions(String[] cccds, String[] guestNames,
            int bookingId, CustomerDao customerDao, BookingDao bookingDao, boolean isOwnerPresent) throws SQLException {

        int startIndex = isOwnerPresent ? 1 : 0;

        for (int i = startIndex; i < cccds.length; i++) {
            String guestName = guestNames[i].trim();
            String guestCccd = cccds[i].trim();

            if (!guestName.isEmpty() && !guestCccd.isEmpty()) {
                if (!customerDao.checkExistCCCD(guestCccd)) {
                    int maxNumberCus = customerDao.getMaxUsernameNumber();
                    customerDao.insertCustomerByCCCD(String.valueOf(maxNumberCus), guestName, guestCccd);
                }
            }
        }
    }

    private void sendConfirmationPopup(HttpServletResponse response, boolean isOwnerPresent) throws IOException {
        String message = isOwnerPresent
                ? "Confirmation: The person who made the reservation has arrived to check in."
                : "Confirmed: The person who made the reservation did not show up for check-in.";

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<script type=\"text/javascript\">");
        out.println("alert('" + message + "');");
        out.println("window.location.href = 'ViewAllCheckInOutDashboard';");
        out.println("</script>");
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
