/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.account;

import dao.CustomerDao;
import dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Customers;
import models.Users;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

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
            out.println("<title>Servlet Login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("account/login.jsp").forward(request, response);
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
        if (request.getParameter("tk") != null) {
            HttpSession session = request.getSession();
            int checkLoginUser = 0;
            int checkLoginCuss = 0;

            String accountType = request.getParameter("accountType").trim();
            String userName = request.getParameter("tk").trim();
            String passWord = request.getParameter("pas").trim();
            session.setAttribute("userName", userName);
            session.setAttribute("accountType", accountType);

            UserDao userDao = new UserDao();
            CustomerDao customerDao = new CustomerDao();
            if (accountType.equalsIgnoreCase("option1")) {
                Users user = new Users();
                user.setUserName(userName);
                user.setPassword(passWord);
                checkLoginUser = userDao.loginForId(user);
                if (checkLoginUser != 0) {
                    String userId = checkLoginUser + "";

                    int checkRole = userDao.getRoleById(checkLoginUser);
                    session.setAttribute("role", checkRole);
                    if (checkRole == 1) {
                        session.setAttribute("adminId", userId);
                        response.sendRedirect("Dashboard");
                    } else if (checkRole == 2) {

                        userDao.UpdateStatusOnl(checkLoginUser, 1);
                        session.setAttribute("reception", userId);
                        response.sendRedirect("Dashboard");
                    } else if (checkRole == 3) {
                        session.setAttribute("staffId", userId);
                        response.sendRedirect("Dashboard");

                    }

                } else {
                    response.sendRedirect("Login");

                }

            } else {
                Customers customer = new Customers();
                customer.setUserName(userName);
                customer.setPassword(passWord);
                checkLoginCuss = customerDao.loginCussForId(customer);
                customerDao.UpdateCustomerOnl(checkLoginCuss, 1);

                if (checkLoginCuss != 0) {
                    CustomerDao dao = new CustomerDao();
                    dao.updateLoginTimestamps(checkLoginCuss);
                    String customerId = checkLoginCuss + "";

                    session.setAttribute("customerId", customerId);
                    response.sendRedirect("Index");
                } else {
                    response.sendRedirect("Login");
                }
            }

        } else {
            response.sendRedirect("Login");
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
