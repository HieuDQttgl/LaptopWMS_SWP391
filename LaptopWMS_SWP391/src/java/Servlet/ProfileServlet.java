package Servlet;

import DAO.UserDAO;
import Model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Users currentUser = (Users) session.getAttribute("currentUser");
        int userId = currentUser.getUserId();

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String gender = request.getParameter("gender");

        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.updateProfile(userId, fullName, email, phoneNumber, gender);

        if (success) {
            Users updatedUser = userDAO.getUserById(userId);
            if (updatedUser != null) {
                session.setAttribute("fullName", updatedUser.getFullName());
                session.setAttribute("currentUser", updatedUser);
                request.setAttribute("success", "Profile updated successfully!");
            } else {
                request.setAttribute("error", "Profile updated but failed to refresh data.");
            }
        } else {
            request.setAttribute("error", "Failed to update profile. Please try again.");
        }

        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
}


