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
@WebServlet(name = "AddServiceDashboard", urlPatterns = {"/AddServiceDashboard"})
public class AddServiceDashboard extends HttpServlet {

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
            out.println("<title>Servlet AddServiceDashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddServiceDashboard at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("services/addServiceDashboard.jsp").forward(request, response);
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
            String serviceName = request.getParameter("name");
            String unitType = request.getParameter("unitType");
            String description = request.getParameter("description");
            Long price = Long.parseLong(request.getParameter("price"));

            // Xử lý upload ảnh
            String avatarURL = "images/default-service.png"; // Ảnh mặc định
            Part filePart = request.getPart("imageFile");

            if (filePart != null && filePart.getSize() > 0) {
                     String uploadPath = "D:\\fouderPrj\\BuildingWeb\\src\\main\\webapp\\images";
//                String uploadPath = "F:\\SWP\\moi\\BuildingWeb\\src\\main\\webapp\\images";
                String fileName = FileUploader.uploadImage(filePart, uploadPath);
                avatarURL = "images/" + fileName;
            }

            Services s = new Services();
            s.setServiceName(serviceName);
            s.setUnitType(unitType);
            s.setDescription(description);
            s.setPrice(price);
            s.setImageURL(avatarURL);

            ServicesDao dao = new ServicesDao();
            int check = dao.addServiceDashboard(s);

            if (check != 0) {
                response.sendRedirect("ViewServicesDashboard");
            } else {
                response.sendRedirect("Error");
            }

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
