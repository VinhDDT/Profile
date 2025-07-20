/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.voucher;

import dao.VoucherDao;
import models.Vouchers;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author CE180441_Dương Đinh Thế Vinh
 */
@WebServlet(name = "EditVoucher", urlPatterns = {"/EditVoucher"})
public class EditVoucher extends HttpServlet {

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
            out.println("<title>Servlet EditVoucher</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditVoucher at " + request.getContextPath() + "</h1>");
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
        int voucherId = Integer.parseInt(request.getParameter("voucherId"));
        Vouchers vouchers = new Vouchers();

        VoucherDao dao = new VoucherDao();
        vouchers = dao.getVoucherById(voucherId);
        request.setAttribute("voucher", vouchers);
        request.getRequestDispatcher("vouchersAdmin/editVoucher.jsp").forward(request, response);

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

        int id = Integer.parseInt(request.getParameter("voucherId"));
        boolean isActiveNew = Boolean.parseBoolean(request.getParameter("isActive"));

        VoucherDao dao = new VoucherDao();
        Vouchers current = dao.getVoucherById(id); // Lấy voucher hiện tại từ DB

        if (current.getIsActive()) {
            current.setIsActive(isActiveNew);
            dao.updateVoucherStatusOnly(current);
        } else {
            Vouchers v = new Vouchers();
            v.setVoucherId(id);
            v.setCode(request.getParameter("code"));
            v.setDiscountPercent(new BigDecimal(request.getParameter("discountPercent")));

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime startDateTime = LocalDateTime.parse(request.getParameter("startDate"), formatter);
            LocalDateTime endDateTime = LocalDateTime.parse(request.getParameter("endDate"), formatter);

            v.setStartDate(startDateTime);
            v.setEndDate(endDateTime);
            v.setMinOrderAmount(Long.parseLong(request.getParameter("minOrderAmount")));
            v.setDescription(request.getParameter("description"));
            v.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            v.setIsActive(isActiveNew);

            // ✅ Nếu người dùng bật Active thì kiểm tra xem có trùng code không
            if (isActiveNew) {
                boolean conflict = dao.isCodeConflictWhenActivating(v.getCode(), v.getStartDate(), v.getEndDate(), v.getVoucherId());
                if (conflict) {
                    request.setAttribute("error", "Another active voucher with the same code and overlapping time already exists.");
                    request.setAttribute("voucher", v); // gửi lại dữ liệu để giữ form
                    request.getRequestDispatcher("vouchersAdmin/editVoucher.jsp").forward(request, response);
                    return;
                }
            }

            dao.updateVoucher(v);
        }

        response.sendRedirect("VouchersDashBoard");
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
