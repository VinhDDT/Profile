/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.voucher;

import dao.CustomerDao;
import dao.VoucherDao;
import db.ConnectData;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import models.Customers;
import models.Vouchers;

/**
 *
 * @author CE180441_Dương Đinh Thế Vinh
 */
@WebServlet(name = "ViewVouchers", urlPatterns = {"/ViewVouchers"})
public class ViewVouchers extends HttpServlet {

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
            out.println("<title>Servlet Vouchers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Vouchers at " + request.getContextPath() + "</h1>");
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
        Object id = session.getAttribute("customerId");

        try {
            VoucherDao voucherDao = new VoucherDao();
            voucherDao.updateExpiredVouchers();
            List<Vouchers> allVouchers = voucherDao.getAllAvailableVouchers();

            // Định dạng thời gian
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
            for (Vouchers v : allVouchers) {
                if (v.getEndDate() != null) {
                    v.setFormattedEndDate(v.getEndDate().format(formatter));
                }
            }
            request.setAttribute("vouchers", allVouchers);

            // Nếu đã login thì lấy thêm danh sách voucher đã lưu
            List<Vouchers> savedVouchers = new ArrayList<>();
            if (id != null) {
                int customerId = Integer.parseInt(id.toString());
                savedVouchers = voucherDao.checkVoucherById(customerId);
            }
            request.setAttribute("savedIds", savedVouchers);

            request.getRequestDispatcher("voucher/viewVouchers.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("ViewVouchers");  // quay về nếu lỗi
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

        int voucherId = Integer.parseInt(request.getParameter("voucherId"));
        HttpSession session = request.getSession();
        String customerStr = (String) session.getAttribute("customerId");

        if (customerStr == null) {
            response.sendRedirect("Login");
            return;
        }

        int customerId = Integer.parseInt(customerStr);
        VoucherDao dao = new VoucherDao();

        try ( Connection conn = ConnectData.getConnection()) {
            conn.setAutoCommit(false);

            if (!dao.hasSavedVoucher(customerId, voucherId)) {
                boolean inserted = dao.saveCustomerVoucher(customerId, voucherId, conn);
                boolean updated = dao.decreaseVoucherQuantity(voucherId, conn);

                if (inserted && updated) {
                    conn.commit();
                } else {
                    conn.rollback();
                }
            } else {
                conn.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("ViewVouchers");
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
