/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.customer;

import controllers.admin.*;
import dao.CustomerDao;
import dao.PaginationDao;
import dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.util.List;
import models.Customers;
import models.Users;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
@WebServlet(name = "EditCustomerDashboard", urlPatterns = {"/EditCustomerDashboard"})
public class EditCustomerDashboard extends HttpServlet {

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
            out.println("<title>Servlet Admin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Admin at " + request.getContextPath() + "</h1>");
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
            int id = Integer.parseInt(request.getParameter("id"));
            CustomerDao dao = new CustomerDao();
            Customers customer = dao.getCustomerByIdDashboard(id);

            if (customer != null) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("customer/editCustomerDashboard.jsp").forward(request, response);
            } else {
                response.sendRedirect("Error1"); // Nếu không tìm thấy khách hàng
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Error2"); // Lỗi xử lý
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
        request.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(request.getParameter("customerId"));
        String username = request.getParameter("userName");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String status = request.getParameter("status");
        String identityNumber = request.getParameter("identityNumber");
        String avartarUrl = request.getParameter("avartarUrl");

        // Nếu sau này thêm ngày sinh, xử lý như sau (hiện tại chưa có trường này trong form):
        /*
        String dobStr = request.getParameter("dateOfBirth"); // yyyy-MM-dd
        java.sql.Date dob = (dobStr != null && !dobStr.isEmpty()) ? java.sql.Date.valueOf(dobStr) : null;
        */

        Customers customer = new Customers();
        customer.setCustomerId(id);
        customer.setUserName(username);
        customer.setFullName(fullName);
        customer.setPhone(phone);
        customer.setEmail(email);
        customer.setAddress(address);
        customer.setGender(gender);
        customer.setStatus(status);
        customer.setIdentityNumber(identityNumber);
        customer.setAvatarUrl(avartarUrl);
        // customer.setDateOfBirth(dob); // nếu dùng

        CustomerDao dao = new CustomerDao();
        int check = dao.updateCustomer(customer);  // trả về số dòng cập nhật thành công

        if (check > 0) {
            response.sendRedirect("ViewAllCustomersDashboard");  // chuyển hướng về danh sách
        } else {
            response.sendRedirect("editCustomerDashboard?id=" + id + "&error=update_failed");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("editCustomerDashboard?id=" + request.getParameter("customerId") + "&error=exception");
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
