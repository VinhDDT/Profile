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
import models.Report;

/**
 *
 * @author KHANH
 */
@WebServlet(name = "UpdateReport", urlPatterns = {"/UpdateReport"})
public class UpdateReport extends HttpServlet {

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
            out.println("<title>Servlet UpdateReport</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateReport at " + request.getContextPath() + "</h1>");
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
      
        Report report = new Report();


        report.setStatus("Pending");
        report.setReportTime(new Timestamp(System.currentTimeMillis()));

        request.setAttribute("report", report);
        request.getRequestDispatcher("updateReport.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi khi khởi tạo báo cáo mới: " + e.getMessage());
        request.getRequestDispatcher("updateReport.jsp").forward(request, response);
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
        int reportId = Integer.parseInt(request.getParameter("reportId"));
        int roomId = Integer.parseInt(request.getParameter("roomId"));

        String reportedByCustomerIdStr = request.getParameter("reportedByCustomerId");
        String reportedByUserIdStr = request.getParameter("reportedByUserId");
        String handledByStr = request.getParameter("handledBy");

        Integer reportedByCustomerId = (reportedByCustomerIdStr != null && !reportedByCustomerIdStr.isEmpty())
                ? Integer.parseInt(reportedByCustomerIdStr) : null;
        Integer reportedByUserId = (reportedByUserIdStr != null && !reportedByUserIdStr.isEmpty())
                ? Integer.parseInt(reportedByUserIdStr) : null;
        Integer handledBy = (handledByStr != null && !handledByStr.isEmpty())
                ? Integer.parseInt(handledByStr) : null;

        Timestamp reportTime = Timestamp.valueOf(request.getParameter("reportTime"));
        Timestamp handledTime = null;
        String handledTimeStr = request.getParameter("handledTime");
        if (handledTimeStr != null && !handledTimeStr.isEmpty()) {
            handledTime = Timestamp.valueOf(handledTimeStr);
        }

        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String notes = request.getParameter("notes");

        Report report = new Report();
        report.setReportId(reportId);
        report.setRoomId(roomId);
        report.setReportedByCustomerId(reportedByCustomerId);
        report.setReportedByUserId(reportedByUserId);
        report.setReportTime(reportTime);
        report.setDescription(description);
        report.setStatus(status);
        report.setHandledBy(handledBy);
        report.setHandledTime(handledTime);
        report.setNotes(notes);

        ReportDao dao = new ReportDao();
        int result = dao.updateReport(report);

        if (result > 0) {
            response.sendRedirect("ViewAllRoomReportsController");
        } else {
            request.setAttribute("error", "Cập nhật không thành công.");
            request.setAttribute("report", report);
            request.getRequestDispatcher("updateReport.jsp").forward(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi khi cập nhật báo cáo: " + e.getMessage());
        request.getRequestDispatcher("updateReport.jsp").forward(request, response);
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
