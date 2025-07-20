/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.customer;

import dao.CustomerDao;
import dao.UserDao;
import db.FileUploader;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.sql.Date;
import java.time.LocalDate;
import models.Customers;
import models.Users;

/**
 *
 * @author dodan
 */
@MultipartConfig
@WebServlet(name = "EditCustomerProfile", urlPatterns = {"/EditCustomerProfile"})
public class EditCustomerProfile extends HttpServlet {

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
            out.println("<title>Servlet EditCustomerProfile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditCustomerProfile at " + request.getContextPath() + "</h1>");
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
            Customers customer = new Customers();
            customer = dao.getCustomerById(id);

            if (customer != null) {
                request.setAttribute("userInfomation", customer);
                request.setAttribute("customerId", id);
            } else {
                request.setAttribute("message", "An error occurred in the system. Please wait a few minutes and log in again.");
            }
            request.getRequestDispatcher("customer/editCustomerProfile.jsp").forward(request, response);
        } catch (Exception e) {
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
            int id = Integer.parseInt(request.getParameter("id"));
            String fullName = request.getParameter("fullName");
            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            Date dateOfBirth = Date.valueOf(request.getParameter("dateOfBirth"));
            Part filePart = request.getPart("imageFile");
            String oldAvatar = request.getParameter("oldAvatar");

            String uploadedUrl = null;
            if (filePart != null && filePart.getSize() > 0) {
                     String uploadPath = "D:\\fouderPrj\\BuildingWeb\\src\\main\\webapp\\images";
//                String uploadPath = "F:\\SWP\\moi\\BuildingWeb\\src\\main\\webapp\\images";
//                String uploadPath = "D:\\SWP_Project\\BuildingManager1\\src\\main\\webapp\\images";
                String fileName = FileUploader.uploadImage(filePart, uploadPath);
                uploadedUrl = "images/" + fileName;
            } else {
                // Nếu người dùng không chọn ảnh mới, giữ ảnh cũ
                uploadedUrl = oldAvatar;
            }

            Customers customer = new Customers();
            customer.setFullName(fullName);
            customer.setAddress(address);
            customer.setGender(gender);
            customer.setDateOfBirth(dateOfBirth);
            customer.setAvatarUrl(uploadedUrl);

            CustomerDao dao = new CustomerDao();

            int check = dao.updateCustomerProfileById(id, customer);
            if (check != 0) {
                response.sendRedirect("ViewCustomerProfile?id=" + id);
            } else {
                request.setAttribute("message", "Cập nhật thất bại. Vui lòng thử lại.");
                response.sendRedirect("EditCustomerProfile?id=" + id);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Đã xảy ra lỗi. Vui lòng thử lại...");
            request.getRequestDispatcher("customer/viewCustomerProfile.jsp").forward(request, response);
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
