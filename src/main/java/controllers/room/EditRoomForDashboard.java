/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.room;

import com.nimbusds.jose.crypto.impl.AAD;
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
import models.Rooms;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
@MultipartConfig
@WebServlet(name = "EditRoomForDashboard", urlPatterns = {"/EditRoomForDashboard"})
public class EditRoomForDashboard extends HttpServlet {

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
            out.println("<title>Servlet EditRoomForDashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditRoomForDashboard at " + request.getContextPath() + "</h1>");
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
        RoomDao roomDao = new RoomDao();
        int id = Integer.parseInt(request.getParameter("id"));
        if (request.getParameter("check") != null && request.getParameter("check") != "") {
            request.setAttribute("check", 1);
        }
        Rooms room = roomDao.getRoomDetailForEdit(id);
        request.setAttribute("roomDetail", room);
        request.getRequestDispatcher("room/editRoomForDashboard.jsp").forward(request, response);
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
        Rooms room = new Rooms();
        String bedType = "";
        String uploadedUrl = "";
        int maxOccupancy = 0;
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        room.setRoomId(roomId);

        String roomNumber = request.getParameter("roomNumber");
        room.setRoomNumber(roomNumber);
        int floorNumber = Integer.parseInt(request.getParameter("floorNumber"));
        room.setFloorNumber(floorNumber);
        String roomType = request.getParameter("roomType");
        room.setRoomType(roomType);

        String price = request.getParameter("price");

        String clean = price.replace(".", "");
        Long price2 = Long.parseLong(clean);
        room.setPrice(price2);
        String bedTypeAndOcupation = request.getParameter("bedType");
        if (bedTypeAndOcupation != null && bedTypeAndOcupation.contains("|")) {
            String[] bed = bedTypeAndOcupation.split("\\|");
            bedType = bed[0];
            maxOccupancy = Integer.parseInt(bed[1]);

        }
        room.setBedType(bedType);
        room.setMaxOccupancy(maxOccupancy);
        String description = request.getParameter("description");
        room.setDescription(description);
        Part filePart = request.getPart("imageFile");
        String uploadPath = "D:\\fouderPrj\\BuildingWeb\\src\\main\\webapp\\images";
        if (filePart != null && filePart.getSize() > 0) {
            uploadedUrl = FileUploader.uploadImage(filePart, uploadPath);
        } else {
            uploadedUrl = request.getParameter("imageFileHidden");
        }
        room.setImageUrl("images/"+uploadedUrl);
        String status = request.getParameter("status");
        room.setStatus(status);
        int location = Integer.parseInt(request.getParameter("location"));
        room.setBuildingId(location);
        float area = Float.parseFloat(request.getParameter("area"));
        room.setArea(area);
        RoomDao roomDao = new RoomDao();
            int checkCreate = roomDao.UpdateRoomDetailForEdit(room);
            if (checkCreate > 0) {
                response.sendRedirect("ViewAllRoomsForDashboard");
            } else {
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
