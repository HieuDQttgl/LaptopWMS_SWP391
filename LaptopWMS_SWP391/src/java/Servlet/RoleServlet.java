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
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "RoleServlet", urlPatterns = {"/role"})
public class RoleServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();
    private RoleDAO roleDAO = new RoleDAO();
    private static final int ADMIN_ROLE_ID = 1;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser.getRoleId() != ADMIN_ROLE_ID) {
            request.setAttribute("error", "Access denied: You must be an Administrator to view this page.");
            request.getRequestDispatcher("/landing").forward(request, response);
            return;
        }
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

  
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
