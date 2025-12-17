/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.NotificationDAO;
import DAO.UserDAO;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = { "/forgot" })
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forgot.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        UserDAO userDao = new UserDAO();
        Users user = userDao.getUserByEmail(email);

        if (user == null) {
            request.setAttribute("error", "Email does not exist.");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
            return;
        }

        // Check if user is Admin - Admins cannot use this feature
        if (user.getRoleId() == 1) {
            request.setAttribute("error",
                    "Admin accounts cannot use this feature. Please contact system administrator.");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
            return;
        }

        // Get full user details for notification
        Users fullUser = userDao.getUserById(user.getUserId());

        if (fullUser == null) {
            request.setAttribute("error", "System error: Cannot process request. Please try again.");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
            return;
        }

        // Create notification for admin instead of sending email
        NotificationDAO notificationDao = new NotificationDAO();
        boolean notificationCreated = notificationDao.createPasswordResetNotification(fullUser);

        if (!notificationCreated) {
            request.setAttribute("error",
                    "System error: Cannot send notification to administrator. Please contact support.");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
            return;
        }

        request.setAttribute("msg",
                "Your request has been sent to the administrator. You will receive your new password soon.");
        request.getRequestDispatcher("forgot.jsp").forward(request, response);
    }
}
