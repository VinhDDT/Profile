/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.services;

import dao.ServicesDao;
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
import java.math.BigDecimal;
import models.Services;

/**
 *
 * @author dodan
 */
@MultipartConfig
@WebServlet(name = "EditServiceDashboard", urlPatterns = {"/EditServiceDashboard"})
public class EditServiceDashboard extends HttpServlet {

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
            out.println("<title>Servlet EditServiceDashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditServiceDashboard at " + request.getContextPath() + "</h1>");
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
        int id = Integer.parseInt(request.getParameter("id"));
        Services s = new Services();
        ServicesDao dao = new ServicesDao();
        s = dao.getServiceByIdDashboard(id);

        if (dao.getServiceByIdDashboard(id) != null) {
            request.setAttribute("s", s);
            request.getRequestDispatcher("services/editServiceDashboard.jsp").forward(request, response);
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
            int id = Integer.parseInt(request.getParameter("serviceId"));
            String name = request.getParameter("name");
            String type = request.getParameter("unitType"); // đã chỉnh lại name trong form
            String desc = request.getParameter("description");
            Long price = Long.parseLong(request.getParameter("price"));
            boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));

            // Lấy ảnh đã chọn
            Part filePart = request.getPart("imageFile");
                 String uploadPath = "D:\\fouderPrj\\BuildingWeb\\src\\main\\webapp\\images";
//            String uploadPath = "F:\\SWP\\moi\\BuildingWeb\\src\\main\\webapp\\images";
            String imageUrl = request.getParameter("oldImage"); // ảnh cũ từ input ẩn

            if (filePart != null && filePart.getSize() > 0) {
                // Nếu có chọn file mới
                String uploadedFileName = FileUploader.uploadImage(filePart, uploadPath);
                imageUrl = "images/" + uploadedFileName;
            }

            Services s = new Services();
            s.setServiceId(id);
            s.setServiceName(name);
            s.setUnitType(type);
            s.setDescription(desc);
            s.setPrice(price);
            s.setImageURL(imageUrl);
            s.setIsActive(isActive);

            ServicesDao dao = new ServicesDao();
            dao.editServiceByIdDashboard(s, id);

            response.sendRedirect("ViewServicesDashboard");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Error");
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
