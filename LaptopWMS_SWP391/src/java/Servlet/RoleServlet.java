/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.RoleDAO;
import DAO.UserDAO;
import Model.Role;
import Model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "RoleServlet", urlPatterns = {"/role"})
public class RoleServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();
    private RoleDAO roleDAO = new RoleDAO();

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
            
            List<Users> userList = userDAO.getListUsers();
            List<Role> roleList = roleDAO.getAllRoles();
            request.setAttribute("userList", userList);
            request.setAttribute("roleList", roleList);
            request.getRequestDispatcher("role.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error loading user and role data", e);
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
            
            String action = request.getParameter("action");
            
            if ("changeRole".equals(action)) {      
                int userId = Integer.parseInt(request.getParameter("userId"));
                int newRoleId = Integer.parseInt(request.getParameter("roleId"));
                userDAO.updateUserRole(userId, newRoleId);
                response.sendRedirect("role-list");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error updating user role", e);
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
