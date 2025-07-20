/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.news;

import dao.BuildingDao;
import dao.NewsDao;
import db.FileUploader;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import models.Buildings;
import models.News;

/**
 *
 * @author dodan
 */
@MultipartConfig
@WebServlet(name = "AddNewsDashboard", urlPatterns = {"/AddNewsDashboard"})
public class AddNewsDashboard extends HttpServlet {

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
            out.println("<title>Servlet AddNewsDashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddNewsDashboard at " + request.getContextPath() + "</h1>");
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
        List<Buildings> list = null;
        BuildingDao dao = new BuildingDao();
        list = dao.getAllBuiding();
        if (list.isEmpty()) {
            request.setAttribute("message", "An error occurred in the system. Please wait a few minutes and log in again.");
            request.getRequestDispatcher("news/addNewsDashboard.jsp").forward(request, response);
        } else {
            request.setAttribute("listBuilding", list);
            request.getRequestDispatcher("news/addNewsDashboard.jsp").forward(request, response);
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

            String uploadedUrl = "";
            // Lấy dữ liệu từ form
            String title = request.getParameter("title");
            String summary = request.getParameter("summary");

            String content = request.getParameter("content");
            boolean isPublished = Boolean.parseBoolean(request.getParameter("isPublished"));
            HttpSession session = request.getSession();
            int userId = Integer.parseInt(session.getAttribute("adminId").toString());
            int buildingID = Integer.parseInt(request.getParameter("buildingID"));

            Part filePart = request.getPart("imageFile");
            String uploadPath = "D:\\fouderPrj\\BuildingWeb\\src\\main\\webapp\\images";
//            String uploadPath = "F:\\SWP\\moi\\BuildingWeb\\src\\main\\webapp\\images";
            uploadedUrl = FileUploader.uploadImage(filePart, uploadPath);
            // Tạo đối tượng News mới
            News news = new News();
            news.setTitle(title);
            news.setSummary(summary);
            news.setImageURL("images/" + uploadedUrl);
            news.setContent(content);
            news.setIsPublished(isPublished);
            news.setUserId(userId);
            news.setBuildingID(buildingID);

            // Set ngày giờ hiện tại
            Timestamp currentTimestamp = Timestamp.valueOf(LocalDateTime.now());
            news.setDatePosted(currentTimestamp);

            // Thêm tin tức vào database
            NewsDao dao = new NewsDao();
            int check = dao.addNewsDashboard(news); // Bạn cần đảm bảo phương thức này tồn tại và đúng cấu trúc

            if (check != 0) {
                response.sendRedirect("ViewNewsDashboard");
            } else {
                request.getRequestDispatcher("news/addNewsDashboard.jsp").forward(request, response);
            }
            // Sau khi thêm thành công, chuyển hướng về danh sách tin tức hoặc trang xác nhận
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi tạo tin tức: " + e.getMessage());
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
