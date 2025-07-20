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
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import models.Bookings;
import models.Customers;
import models.Rooms;
import sendMail.EmailSender;

/**
 *
 * @author Dương Đinh Thế Vinh
 */
@WebServlet(name = "CreateBooking", urlPatterns = {"/CreateBooking"})
public class CreateBooking extends HttpServlet {

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
            out.println("<title>Servlet CreateBooking</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateBooking at " + request.getContextPath() + "</h1>");
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
            String action = request.getParameter("action");

            if ("searchRoom".equals(action)) {
                String start = request.getParameter("startDate");
                String end = request.getParameter("endDate");
                String adultsStr = request.getParameter("adults");
                String childrenStr = request.getParameter("children");

                //  Check null trước khi parse
                if (start == null || end == null || adultsStr == null || childrenStr == null) {
                    throw new IllegalArgumentException("Missing room search information.");
                }

                LocalDate startDate = LocalDate.parse(start);
                LocalDate endDate = LocalDate.parse(end);
                int adults = Integer.parseInt(adultsStr);
                int children = Integer.parseInt(childrenStr);
                int guestCount = adults + children;

                RoomDao roomDao = new RoomDao();
                List<Rooms> availableRooms = roomDao.getAvailableRoomTypes(startDate, endDate, guestCount);

                request.setAttribute("rooms", availableRooms);
                request.setAttribute("startDate", startDate.toString());
                request.setAttribute("endDate", endDate.toString());
                request.setAttribute("adults", adults);
                request.setAttribute("children", children);

                request.getRequestDispatcher("booking/createBooking.jsp").forward(request, response);
                return;
            }

            // Nếu không phải tìm phòng thì load phòng mặc định
            RoomDao roomDao = new RoomDao();
            List<Rooms> rooms = roomDao.getAllActiveRooms();
            request.setAttribute("rooms", rooms);

            request.getRequestDispatcher("booking/createBooking.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading rooms.");
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
            String action = request.getParameter("action");

            if ("bookRoom".equals(action)) {
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                LocalDate startDate = LocalDate.parse(request.getParameter("startDate"));
                LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));
                int adults = Integer.parseInt(request.getParameter("adults"));
                int children = Integer.parseInt(request.getParameter("children"));
                int guestCount = adults + children;

                HttpSession session = request.getSession();
                Customers customer = (Customers) session.getAttribute("customer");
                String staffIdStr = (String) session.getAttribute("staffId");

                if (customer == null || staffIdStr == null) {
                    response.sendRedirect("Login");
                    return;
                }
                //check gọi mail
                if (customer != null) {
                    System.out.println("Tên khách: " + customer.getFullName());
                    System.out.println("Email khách: " + customer.getEmail());
                    System.out.println("Customer ID: " + customer.getCustomerId());
                } else {
                    System.out.println("Không tìm thấy customer trong session!");
                }

                int customerId = customer.getCustomerId();
                int confirmedBy = Integer.parseInt(staffIdStr);
                LocalDateTime now = LocalDateTime.now();

                String roomType = new RoomDao().getRoomTypeById(roomId);
                Bookings booking = new Bookings();
                booking.setRoomId(roomId);
                booking.setCustomerId(customerId);
                booking.setStartDate(startDate);
                booking.setEndDate(endDate);
                booking.setStatus("Confirmed");
                booking.setRequestTime(now);
                booking.setConfirmationTime(now);
                booking.setConfirmedBy(confirmedBy);
                booking.setRoomType(roomType);

                BookingDao dao = new BookingDao();
                int bookingId = dao.insertBookingAndReturnId(booking);

                // Gửi mail nếu có email
                if (customer.getEmail() != null && !customer.getEmail().isEmpty()) {
                    try {

                        EmailSender sender = new EmailSender();
                        sender.sendDeskBookingEmail(
                                customer.getEmail(),
                                "Confirm booking at the counter - Big Resort",
                                customer.getFullName(),
                                bookingId,
                                booking.getStartDate(),
                                booking.getEndDate(),
                                booking.getRoomType(),
                                booking.getConfirmationTime()
                        );
                        System.out.println("Đã gửi Mail tới: " + customer.getEmail());
                    } catch (Exception e) {
                        e.printStackTrace();
                        System.out.println("Gửi mail thất bại: " + e.getMessage());
                        request.setAttribute("emailError", true); // Có thể thông báo cho JSP nếu muốn
                    }

                }

                // Load lại danh sách phòng trống mới (không dùng sendRedirect)
                RoomDao roomDao = new RoomDao();
                List<Rooms> availableRooms = roomDao.getAvailableRoomTypes(startDate, endDate, guestCount);

                request.setAttribute("rooms", availableRooms);
                request.setAttribute("startDate", startDate.toString());
                request.setAttribute("endDate", endDate.toString());
                request.setAttribute("adults", adults);
                request.setAttribute("children", children);
                request.setAttribute("bookingSuccess", true);

                request.getRequestDispatcher("booking/createBooking.jsp").forward(request, response);
                return;

            } else if ("searchRoom".equals(action)) {
                // Giữ nguyên logic cũ
                LocalDate startDate = LocalDate.parse(request.getParameter("startDate"));
                LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));
                int adults = Integer.parseInt(request.getParameter("adults"));
                int children = Integer.parseInt(request.getParameter("children"));
                int guestCount = adults + children;

                RoomDao roomDao = new RoomDao();
                List<Rooms> availableRooms = roomDao.getAvailableRoomTypes(startDate, endDate, guestCount);

                request.setAttribute("rooms", availableRooms);
                request.setAttribute("startDate", startDate.toString());
                request.setAttribute("endDate", endDate.toString());
                request.setAttribute("adults", adults);
                request.setAttribute("children", children);

                request.getRequestDispatcher("booking/createBooking.jsp").forward(request, response);
            } else {
                response.sendRedirect("CreateBooking?error=unknown_action");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("bookingError", true);
            request.getRequestDispatcher("booking/createBooking.jsp").forward(request, response);
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
