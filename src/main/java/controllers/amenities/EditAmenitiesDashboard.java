/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.amenities;

import controllers.room.*;
import dao.AmenitiesDao;
import dao.RoomDao;
import dao.RoomReviewDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Amenities;
import models.RoomReviews;
import models.Rooms;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
@WebServlet(name = "EditAmenitiesDashboard", urlPatterns = {"/EditAmenitiesDashboard"})
public class EditAmenitiesDashboard extends HttpServlet {

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
            out.println("<title>Servlet ViewRoomDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewRoomDetail at " + request.getContextPath() + "</h1>");
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
            AmenitiesDao dao = new AmenitiesDao();
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("a", dao.getAmenitiesById(id));
            request.getRequestDispatcher("amenities/editAmenitiesDashboard.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(EditAmenitiesDashboard.class.getName()).log(Level.SEVERE, null, ex);
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

        int id = Integer.parseInt(request.getParameter("id"));
        String name = (String) request.getParameter("name");
        String description = (String) request.getParameter("description");
        Amenities amenities = new Amenities();
        amenities.setAmenityId(id);
        amenities.setName(name);
        amenities.setDescription(description);
        AmenitiesDao dao = new AmenitiesDao();
        dao.updateAmenities(amenities);
        int check = 0;
        check = dao.updateAmenities(amenities);
        if (check != 0) {
            response.sendRedirect("ViewAmenitiesDashboard");
        } else {
            response.sendRedirect("hybuttb+" + check);
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
