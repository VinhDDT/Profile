/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.report;

import dao.ReportDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import models.Report;

/**
 *
 * @author KHANH
 */
@WebServlet(name = "AddNewReport", urlPatterns = {"/AddNewReport"})
public class AddNewReport extends HttpServlet {

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
            out.println("<title>Servlet AddNewReport</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddNewReport at " + request.getContextPath() + "</h1>");
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
        // Chuyển đến form thêm báo cáo
        request.getRequestDispatcher("/report/addNewReport.jsp").forward(request, response);
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
            Report report = new Report();

            // Lấy dữ liệu từ form
            report.setRoomId(Integer.parseInt(request.getParameter("roomId")));
            report.setReportedByCustomerId(Integer.parseInt(request.getParameter("reportedByCustomerId")));
            report.setReportedByUserId(Integer.parseInt(request.getParameter("reportedByUserId")));
            report.setReportTime(new Timestamp(System.currentTimeMillis()));
            report.setDescription(request.getParameter("description"));
            report.setStatus("Pending");
            report.setHandledBy(0); // Chưa xử lý
            report.setHandledTime(null);
            report.setNotes("");

            // Gọi DAO
            ReportDao dao = new ReportDao();
            boolean success = dao.insertReport(report);

            if (success) {
                response.sendRedirect("ViewAllReports"); // Điều hướng về danh sách báo cáo
            } else {
                request.setAttribute("error", "Không thể thêm báo cáo.");
                request.getRequestDispatcher("/report/addNewReport.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("error", "Lỗi xử lý báo cáo: " + e.getMessage());
            request.getRequestDispatcher("/report/addNewReport.jsp").forward(request, response);
        }
    }



    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
