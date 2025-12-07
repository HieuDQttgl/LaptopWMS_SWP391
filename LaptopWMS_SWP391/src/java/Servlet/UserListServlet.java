/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.UserDAO;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "UserListServlet", urlPatterns = {"/user-list"})
public class UserListServlet extends HttpServlet {

    private static final int ADMIN_ROLE_ID = 1;
    private UserDAO userDAO = new UserDAO();

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

        List<Users> users = userDAO.getListUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/user-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Users currentUser = (Users) session.getAttribute("currentUser");
        final int ADMIN_ROLE_ID = 1;

        if (currentUser.getRoleId() != ADMIN_ROLE_ID) {
            session.setAttribute("error", "Access denied: You do not have permission to add users.");
            response.sendRedirect(request.getContextPath() + "/user-list");
            return;
        }

        if ("add".equals(action)) {
 
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String gender = request.getParameter("gender");

            int roleId;
            try {
                roleId = Integer.parseInt(request.getParameter("roleId"));
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid Role ID format during user addition.");
                response.sendRedirect(request.getContextPath() + "/user-list");
                return;
            }

            String validationError = null;

            if (username == null || username.trim().isEmpty()
                    || password == null || password.trim().isEmpty()
                    || email == null || email.trim().isEmpty()) {
                validationError = "Username, Password, and Email are required fields.";
            }
            else if (username.length() < 3 || username.length() > 50) {
                validationError = "Username must be between 3 and 50 characters.";
            } else if (password.length() < 6) {
                validationError = "Password must be at least 6 characters long.";
            } else if (phoneNumber != null && !phoneNumber.trim().isEmpty() && !phoneNumber.matches("^[0-9]{8,15}$")) {
                validationError = "Phone number must contain only digits and be between 8-15 digits.";
            } else if (!email.matches("^[\\w.-]+@[\\w.-]+\\.[A-Za-z]{2,6}$")) {
                validationError = "Invalid email format.";
            }

            if (validationError == null) {
                if (userDAO.isUsernameExists(username)) {
                    validationError = "Username is already taken. Please choose another one.";
                } else if (userDAO.isEmailExists(email)) {
                    validationError = "Email is already registered by another user.";
                }
            }

            if (validationError != null) {
                session.setAttribute("error", " " + validationError);
                response.sendRedirect(request.getContextPath() + "/user-list");
                return;
            }

            Users newUser = new Users(
                    0, username, password, fullName, email, phoneNumber, gender, roleId,
                    "active", null, null, null, null 
            );

            boolean success = userDAO.addNew(newUser);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/user-list?message= User added successfully!");
            } else {
                session.setAttribute("error", "Database operation failed during user creation.");
                response.sendRedirect(request.getContextPath() + "/user-list");
            }
        }
    }
}
