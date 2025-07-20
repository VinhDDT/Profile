/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.room;

import dao.RoomDao;
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
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
@MultipartConfig
@WebServlet("/CreateRoomForDashboard")
public class CreateRoomForDashboard extends HttpServlet {

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
            out.println("<title>Servlet CreateRoomForDashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateRoomForDashboard at " + request.getContextPath() + "</h1>");
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

        request.getRequestDispatcher("room/createRoomForDashboard.jsp").forward(request, response);

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
        String bedType = "";
        String uploadedUrl = "";
        int maxOccupancy = 0;
        String roomNumber = request.getParameter("roomNumber");
        int floorNumber = Integer.parseInt(request.getParameter("floorNumber"));
        String roomType = request.getParameter("roomType");
        String price = request.getParameter("price");
        String clean = price.replace(".", "");
        Long price2 = Long.parseLong(clean);
        String bedTypeAndOcupation = request.getParameter("bedType");

        if (bedTypeAndOcupation != null && bedTypeAndOcupation.contains("|")) {
            String[] bed = bedTypeAndOcupation.split("\\|");
            bedType = bed[0];
            maxOccupancy = Integer.parseInt(bed[1]);

        }
        String description = request.getParameter("description");
        Part filePart = request.getPart("imageFile");

        String uploadPath = "D:\\fouderPrj\\BuildingWeb\\src\\main\\webapp\\images";
        FileUploader uploadImage = new FileUploader();
        uploadedUrl = uploadImage.uploadImage(filePart, uploadPath);
        String status = request.getParameter("status");
        int location = Integer.parseInt(request.getParameter("location"));
        float area = Float.parseFloat(request.getParameter("area"));

        RoomDao roomDao = new RoomDao();
        int checkRoom = roomDao.checkRoomOfFoor(roomNumber, floorNumber);
        if (checkRoom == 1) {
            request.setAttribute("check", 1);
            request.getRequestDispatcher("room/createRoomForDashboard.jsp").forward(request, response);
        } else {
            int checkCreate = roomDao.createRoom(roomNumber, floorNumber, roomType, bedType, price2, maxOccupancy,
                    description, "images/" + uploadedUrl, status, location, area);
            if (checkCreate > 0) {
                response.sendRedirect("ViewAllRoomsForDashboard");
            } else {
                response.sendRedirect("Error");

            }
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
