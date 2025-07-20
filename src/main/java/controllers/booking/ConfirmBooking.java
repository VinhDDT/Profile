/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.booking;

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
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import models.Rooms;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
@WebServlet("/ConfirmBooking")
public class ConfirmBooking extends HttpServlet {

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
            out.println("<title>Servlet ConfirmBooking</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConfirmBooking at " + request.getContextPath() + "</h1>");
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

        int roomId = 0;
        if (request.getParameter("check") != null) {
            session.removeAttribute("voucherId");
            session.removeAttribute("voucherCode");
            session.removeAttribute("voucherdiscountPercent1");

        } else if (request.getParameter("voucherId") != null) {
            int voucherId = Integer.parseInt(request.getParameter("voucherId"));
            String voucherCode = request.getParameter("voucherCode");
            String voucherdiscountPercent = request.getParameter("voucherdiscountPercent");
            BigDecimal voucherdis = new BigDecimal(voucherdiscountPercent);
            double voucherdiscountPercent1 = voucherdis.doubleValue();
            session.setAttribute("voucherId", voucherId);
            session.setAttribute("voucherCode", voucherCode);
            session.setAttribute("voucherdiscountPercent1", voucherdiscountPercent1);

        }

        if (request.getParameter("roomId") != null) {
            roomId = Integer.parseInt(request.getParameter("roomId"));

        } else {
            roomId = Integer.parseInt(session.getAttribute("roomId").toString());

        }
        String location = session.getAttribute("location").toString();
        LocalDate checkIn = LocalDate.parse(session.getAttribute("checkIn").toString());
        LocalDate checkOut = LocalDate.parse(session.getAttribute("checkOut").toString());
        DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        String checkInFormat = checkIn.format(dateFormat);
        String checkOutFormat = checkOut.format(dateFormat);
        long numberNight = ChronoUnit.DAYS.between(checkIn, checkOut);
        int adults = Integer.parseInt(session.getAttribute("adults").toString());
        int children = Integer.parseInt(session.getAttribute("children").toString());
        RoomDao roomDao = new RoomDao();
        Rooms room = roomDao.getInformationRoomBooking(roomId);

        session.setAttribute("room", room);
        session.setAttribute("roomId", roomId);
        session.setAttribute("location", location);
        session.setAttribute("checkInFormat", checkInFormat);
        session.setAttribute("checkOutFormat", checkOutFormat);
        session.setAttribute("numberNight", numberNight);
        session.setAttribute("adults", adults);
        session.setAttribute("children", children);
        String voucherId = request.getParameter("voucherId");
        if (voucherId != null && !voucherId.isEmpty()) {
            request.setAttribute("voucherId", voucherId);
        }
        request.getRequestDispatcher("booking/confirmBooking.jsp").forward(request, response);
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
        int customerId = Integer.parseInt(session.getAttribute("customerId").toString());
        String startDateStr = request.getParameter("startDate");
        LocalDate startDate = LocalDate.parse(startDateStr);
        String endDateStr = request.getParameter("endDate");
        LocalDate endDate = LocalDate.parse(endDateStr);
        String roomType = request.getParameter("roomType");
        String paymentMethod = request.getParameter("payment");
        String roomPriceTotalSTR = request.getParameter("roomPriceTotal");
        String notes = "";
        if (request.getParameter("note") != null) {
            notes = request.getParameter("note");
        }
        long roomPriceTotal = Long.parseLong(request.getParameter("roomPriceTotal"));
        String voucherStr = request.getParameter("voucherdiscountPercent1");

        long discount = 0;
        long totalAmount = 0;
        if (voucherStr != null && !voucherStr.trim().isEmpty()) {
            double voucherdiscountPercent1 = Double.parseDouble(voucherStr.trim());
            discount = (long) (roomPriceTotal * (voucherdiscountPercent1 / 100));
            totalAmount = (long) (roomPriceTotal - discount);
        } else {
            discount = 0;
            totalAmount = roomPriceTotal;
        }
        // nếu discount = null thì totalAmount sẽ bằng roomPriceTotal
//        totalAmount = Long.parseLong(request.getParameter("totalAmount"));
        String payment = request.getParameter("payment");
        String limit = request.getParameter("limit");
        double paidAmount = 0;
        if (limit.equals("full")) {
            paidAmount = totalAmount;
        } else if (limit.equals("50")) {
            paidAmount = (totalAmount * 0.5);
        } else {
            paidAmount = (totalAmount * 0.3);
        }

        if (payment.equals("cod")) {

        } else {

            BookingDao bookingDao = new BookingDao();
            int bookingId = bookingDao.insertBookingBeforePayment(customerId, startDate, endDate, roomType, notes);
            int invoiceId = bookingDao.insertInvoiceBeforePayment(bookingId, roomPriceTotal, (long) discount, totalAmount, (long) paidAmount, limit);

            HttpSession session1 = request.getSession();
            session.setAttribute("bookingId", bookingId);
            session.setAttribute("invoiceId", invoiceId);
            session.setAttribute("amount", (long) paidAmount);
            session.setAttribute("paymentMethod", paymentMethod);
            request.getRequestDispatcher("ajaxServlet").forward(request, response);
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
