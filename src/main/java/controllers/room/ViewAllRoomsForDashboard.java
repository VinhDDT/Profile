/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.room;

import dao.PaginationDao;
import dao.RoomDao;
import dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
@WebServlet("/ViewAllRoomsForDashboard")
public class ViewAllRoomsForDashboard extends HttpServlet {

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
            out.println("<title>Servlet ViewAllRoomsForDashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewAllRoomsForDashboard at " + request.getContextPath() + "</h1>");
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
        int Page = 0, finalPage = 0, totalPage = 0;
        RoomDao roomDao = new RoomDao();
        PaginationDao paginationDao = new PaginationDao();
        if (request.getParameter("search") == null || request.getParameter("search").equals("")) {
            if (request.getParameter("Page") == null) {
                Page = 1;
            } else {
                Page = Integer.parseInt(request.getParameter("Page"));
            }
            request.setAttribute("list", roomDao.getFullRoomsForDashboard(Page));
            request.setAttribute("thisPage", Page);
            totalPage = paginationDao.PageFullRoomsOfDashBoard();
            finalPage = totalPage / 10;
            if (totalPage % 10 != 0) {
                finalPage++;
            }

        } else {

            if (request.getParameter("Page") == null) {
                Page = 1;
            } else {
                Page = Integer.parseInt(request.getParameter("Page"));
            }

            request.setAttribute("list", roomDao.getSearchOfDashBoard(Page, Integer.parseInt(request.getParameter("search"))));
            request.setAttribute("thisPage", Page);
            totalPage = paginationDao.PageFullOfDashBoard();
            finalPage = totalPage / 10;
            if (totalPage % 10 != 0) {
                finalPage++;
            }
        }
        request.setAttribute("finalPage", finalPage);

        request.getRequestDispatcher("room/viewAllRoomsForDashboard.jsp").forward(request, response);

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
        processRequest(request, response);
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
