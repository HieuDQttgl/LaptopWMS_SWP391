/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.UserDAO;
import Model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "EditRoleServlet", urlPatterns = {"/edit-role"})
public class EditRoleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("id"));

        UserDAO dao = new UserDAO();
        Users user = dao.getUserById(userId);

        if (user == null) {
            response.sendRedirect("user-list");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("edit-role.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("id"));
        int roleId = Integer.parseInt(request.getParameter("roleId"));

        UserDAO dao = new UserDAO();
        dao.updateUserRole(userId, roleId);

        response.sendRedirect("user");
    }
}

