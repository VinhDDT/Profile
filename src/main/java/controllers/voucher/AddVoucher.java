/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.voucher;

import dao.VoucherDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import models.Vouchers;

/**
 *
 * @author CE180441_Dương Đinh Thế Vinh
 */
@WebServlet(name = "AddVoucher", urlPatterns = {"/AddVoucher"})
public class AddVoucher extends HttpServlet {

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
            out.println("<title>Servlet AddVoucher</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddVoucher at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("vouchersAdmin/addVoucher.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");

        Vouchers voucher = new Vouchers();
        VoucherDao voucherDao = new VoucherDao();

        String code = request.getParameter("code");
        String description = request.getParameter("description");
        boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));

        BigDecimal discount;
        try {
            discount = new BigDecimal(request.getParameter("discountPercent"));
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid discount format.");
            request.getRequestDispatcher("vouchersAdmin/addVoucher.jsp").forward(request, response);
            return;
        }

        if (discount.scale() > 2 || discount.compareTo(BigDecimal.valueOf(0.01)) < 0 || discount.compareTo(BigDecimal.valueOf(100)) > 0) {
            request.setAttribute("error", "Discount must be between 0.01 and 100.00 with up to 2 decimal places.");
            request.getRequestDispatcher("vouchersAdmin/addVoucher.jsp").forward(request, response);
            return;
        }

        // ❗ Chỉ kiểm tra code trùng nếu đang bật active
        if (isActive && voucherDao.isVoucherCodeExists(code)) {
            request.setAttribute("error", "Voucher code '" + code + "' is already active.");
            request.getRequestDispatcher("vouchersAdmin/addVoucher.jsp").forward(request, response);
            return;
        }

        voucher.setCode(code);
        voucher.setDescription(description);
        voucher.setDiscountPercent(discount);
        voucher.setMinOrderAmount(Long.parseLong(request.getParameter("minOrderAmount")));
        voucher.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        voucher.setIsActive(isActive);

        try {
            LocalDateTime startDate = LocalDateTime.parse(request.getParameter("startDate"));
            LocalDateTime endDate = LocalDateTime.parse(request.getParameter("endDate"));
            if (!startDate.isBefore(endDate)) {
                request.setAttribute("error", "Start date must be before end date.");
                request.getRequestDispatcher("vouchersAdmin/addVoucher.jsp").forward(request, response);
                return;
            }
            voucher.setStartDate(startDate);
            voucher.setEndDate(endDate);
        } catch (Exception e) {
            request.setAttribute("error", "Invalid date format.");
            request.getRequestDispatcher("vouchersAdmin/addVoucher.jsp").forward(request, response);
            return;
        }

        // Chèn vào database
        int inserted = voucherDao.insertVoucher(voucher);
        if (inserted > 0) {
            response.sendRedirect("VouchersDashBoard");
        } else {
            request.setAttribute("error", "Failed to insert voucher.");
            request.getRequestDispatcher("vouchersAdmin/addVoucher.jsp").forward(request, response);
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
