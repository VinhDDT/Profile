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
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import models.Buildings;
import models.News;

/**
 *
 * @author dodan
 */
@MultipartConfig
@WebServlet(name = "EditNewsDashboard", urlPatterns = {"/EditNewsDashboard"})
public class EditNewsDashboard extends HttpServlet {

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
            out.println("<title>Servlet EditNewsDashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditNewsDashboard at " + request.getContextPath() + "</h1>");
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
        NewsDao dao = new NewsDao();
        News news = dao.getNewsById(id);
        request.setAttribute("news", news);

        List<Buildings> list = null;
        BuildingDao daos = new BuildingDao();
        list = daos.getAllBuiding();
        request.setAttribute("listBuilding", list);
        request.getRequestDispatcher("news/editNewsDashboard.jsp").forward(request, response);
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
            int newsID = Integer.parseInt(request.getParameter("newsID"));
            String title = request.getParameter("title");
            String summary = request.getParameter("summary");
            boolean isPublished = request.getParameter("isPublished") != null;
            HttpSession session = request.getSession();
            int userId = Integer.parseInt(session.getAttribute("adminId").toString());
            int buildingID = Integer.parseInt(request.getParameter("buildingID"));
            String content = request.getParameter("content");
            String existingImageURL = request.getParameter("existingImageURL"); // lấy ảnh cũ nếu có

            Part filePart = request.getPart("image");

            // Nếu có upload ảnh mới thì xử lý, ngược lại dùng ảnh cũ
            if (filePart != null && filePart.getSize() > 0) {
     String uploadPath = "D:\\fouderPrj\\BuildingWeb\\src\\main\\webapp\\images";               
//                String uploadPath = "F:\\SWP\\moi\\BuildingWeb\\src\\main\\webapp\\images";
                uploadedUrl = FileUploader.uploadImage(filePart, uploadPath);
            } else {
                uploadedUrl = existingImageURL;
            }

            News updatedNews = new News();
            updatedNews.setTitle(title);
            updatedNews.setSummary(summary);
            updatedNews.setImageURL("images/" + uploadedUrl.replace("images/", "")); // chuẩn hoá
            updatedNews.setIsPublished(isPublished);
            updatedNews.setUserId(userId);
            updatedNews.setBuildingID(buildingID);
            updatedNews.setContent(content);

            NewsDao dao = new NewsDao();
            int result = dao.editNewsDashboard(newsID, updatedNews);

            if (result > 0) {
                response.sendRedirect("ViewNewsDashboard");
            } else {
                response.getWriter().println("Không thể cập nhật tin tức.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi: " + e.getMessage());
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
