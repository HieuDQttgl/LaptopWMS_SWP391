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

@WebServlet(name = "ChangePasswordServlet", urlPatterns = { "/change-password" })
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Users currentUser = (Users) request.getSession().getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect("login");
            return;
        }

        String currentPass = request.getParameter("currentPassword");
        String newPass = request.getParameter("newPassword");
        String confirm = request.getParameter("confirmPassword");

        // Validation 1: Check current password is correct
        if (!Utils.PasswordUtils.checkPassword(currentPass, currentUser.getPassword())) {
            request.setAttribute("error", "Current password is incorrect.");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        // Validation 2: Check new passwords match
        if (!newPass.equals(confirm)) {
            request.setAttribute("error", "New passwords do not match.");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        // NEW Validation 3: New password must be different from current
        if (newPass.equals(currentPass)) {
            request.setAttribute("error", "New password must be different from current password.");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        // Update password in database
        UserDAO dao = new UserDAO();
        String hashedPass = Utils.PasswordUtils.hashPassword(newPass);
        boolean success = dao.updatePassword(currentUser.getUserId(), hashedPass);

        if (success) {
            // NEW: Update password_changed_at timestamp to invalidate all old sessions
            dao.updatePasswordChangedAt(currentUser.getUserId());

            // NEW: Logout - Invalidate current session
            request.getSession().invalidate();

            // NEW: Redirect to login with success message
            response.sendRedirect(request.getContextPath() +
                    "/login?msg=Password changed successfully. Please login with your new password.");
        } else {
            request.setAttribute("error", "Failed to update password. Please try again.");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
        }
    }
}
