/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.RoleDAO;
import Model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/role-status")
public class RoleStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int roleId = Integer.parseInt(request.getParameter("roleId"));
        String currentStatus = request.getParameter("status");

        String newStatus = currentStatus.equals("active") ? "inactive" : "active";

        RoleDAO dao = new RoleDAO();

        try {
            dao.updateStatus(roleId, newStatus);

            if (newStatus.equals("inactive")) {
                HttpSession session = request.getSession(false);
                if (session != null) {
                    Users user = (Users) session.getAttribute("currentUser");
                    if (user != null && user.getRoleId() == roleId) {
                        session.invalidate();
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("role-list");
    }
}

