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

        String keyword = request.getParameter("keyword");
        String genderFilter = request.getParameter("gender_filter");
        String statusFilter = request.getParameter("status_filter");

        String roleIdFilterStr = request.getParameter("role_filter");
        Integer roleIdFilter = null;
        try {
            if (roleIdFilterStr != null && !roleIdFilterStr.isEmpty() && !roleIdFilterStr.equals("0")) {
                roleIdFilter = Integer.valueOf(roleIdFilterStr);
            }
        } catch (NumberFormatException e) {
        }

        String sortField = request.getParameter("sort_field");
        String sortOrder = request.getParameter("sort_order");

        if (sortField == null || sortField.isEmpty()) {
            sortField = "user_id";
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "ASC";
        }

        List<Users> users = userDAO.getListUsers(
                keyword,
                genderFilter,
                roleIdFilter,
                statusFilter,
                sortField,
                sortOrder
        );

        request.setAttribute("users", users);

        request.setAttribute("keyword", keyword);
        request.setAttribute("gender_filter", genderFilter);
        request.setAttribute("role_filter", roleIdFilterStr);
        request.setAttribute("status_filter", statusFilter);
        request.setAttribute("sort_field", sortField);
        request.setAttribute("sort_order", sortOrder);

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
            response.sendRedirect(request.getContextPath() + "/landing");
            return;
        }

        if ("add".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String gender = request.getParameter("gender");
            String roleIdStr = request.getParameter("roleId");

            int roleId = -1;

            java.util.Map<String, String> errors = new java.util.HashMap<>();
            Users tempUser = new Users();

            // 1. Validation Logic
            if (username == null || username.trim().isEmpty()) {
                errors.put("username", "Username is required.");
            } else if (username.length() < 3 || username.length() > 50) {
                errors.put("username", "Username must be between 3 and 50 characters.");
            }
            tempUser.setUsername(username);

            if (password == null || password.trim().isEmpty()) {
                errors.put("password", "Password is required.");
            } else if (password.length() < 6) {
                errors.put("password", "Password must be at least 6 characters long.");
            }
            tempUser.setPassword(password);

            if (email == null || email.trim().isEmpty()) {
                errors.put("email", "Email is required.");
            } else if (!email.matches("^[\\w.-]+@[\\w.-]+\\.[A-Za-z]{2,6}$")) {
                errors.put("email", "Invalid email format.");
            }
            tempUser.setEmail(email);

            if (phoneNumber != null && !phoneNumber.trim().isEmpty() && !phoneNumber.matches("^0[0-9]{9,10}$")) {
                errors.put("phoneNumber", "Invalid phone number format (10-11 digits starting with 0).");
            }
            tempUser.setPhoneNumber(phoneNumber);

            if (fullName == null || fullName.trim().isEmpty()) {
            }
            tempUser.setFullName(fullName);
            tempUser.setGender(gender);

            try {
                roleId = Integer.parseInt(roleIdStr);
                if (roleId < 1 || roleId > 3) {
                    errors.put("roleId", "Invalid Role ID.");
                }
            } catch (NumberFormatException e) {
                errors.put("roleId", "Role ID is required.");
            }
            tempUser.setRoleId(roleId);

            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.setAttribute("tempUser", tempUser);

                String keyword = request.getParameter("keyword");
                String genderFilter = request.getParameter("gender_filter");
                String statusFilter = request.getParameter("status_filter");
                String roleIdFilterStr = request.getParameter("role_filter");
                Integer roleIdFilter = null;
                try {
                    if (roleIdFilterStr != null && !roleIdFilterStr.isEmpty() && !roleIdFilterStr.equals("0")) {
                        roleIdFilter = Integer.valueOf(roleIdFilterStr);
                    }
                } catch (NumberFormatException e) {
                }
                String sortField = request.getParameter("sort_field");
                String sortOrder = request.getParameter("sort_order");

                List<Users> users = userDAO.getListUsers(keyword, genderFilter, roleIdFilter, statusFilter, sortField, sortOrder);
                request.setAttribute("users", users);

                request.setAttribute("keyword", keyword);
                request.setAttribute("gender_filter", genderFilter);
                request.setAttribute("role_filter", roleIdFilterStr);
                request.setAttribute("status_filter", statusFilter);
                request.setAttribute("sort_field", sortField);
                request.setAttribute("sort_order", sortOrder);

                request.getRequestDispatcher("/user-list.jsp").forward(request, response);
                return;
            }

            try {
                Users newUser = new Users(
                        0,
                        username,
                        password,
                        fullName,
                        email,
                        phoneNumber,
                        gender,
                        roleId,
                        "active",
                        null,
                        null,
                        null,
                        currentUser.getUserId()
                );

                if (userDAO.addNew(newUser)) {
                    session.setAttribute("message", "User " + username + " added successfully!");
                } else {
                    session.setAttribute("error", "Failed to add user. Check for duplicate username/email.");
                }

            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "An unexpected error occurred during user creation.");
            }

            response.sendRedirect(request.getContextPath() + "/user-list");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/user-list");
    }
}
