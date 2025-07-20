/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.admin;

import dao.PaginationDao;
import dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
@WebServlet(name = "Decentralization", urlPatterns = {"/Decentralization"})
public class Decentralization extends HttpServlet {

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
            out.println("<title>Servlet Decentralization</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Decentralization at " + request.getContextPath() + "</h1>");
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
        UserDao userDao = new UserDao();
        PaginationDao paginationDao = new PaginationDao();
        if (request.getParameter("id") != null && !request.getParameter("id").equals("")) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("user", userDao.getRoleUserById(id));
            request.getRequestDispatcher("admin/decentralization.jsp").forward(request, response);
        } else {
            response.sendRedirect("admin/DashboardUser.jsp");
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
        if (request.getParameter("submit") != null && request.getParameter("idHiden") != null && !request.getParameter("idHiden").equals("")) {
            UserDao userDao = new UserDao();
            int id = Integer.parseInt(request.getParameter("idHiden"));
            int update = userDao.UpdateRole(Integer.parseInt(request.getParameter("roleId")), id);
            if (update != 0) {
                response.sendRedirect("DashboardUser");
            } else {
                response.sendRedirect("Decentralization?id=" + id);
            }
        } else {
            response.sendRedirect("DashboardUser?Eroor");
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
