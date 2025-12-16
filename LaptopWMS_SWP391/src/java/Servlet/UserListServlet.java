package Servlet;

import DAO.RoleDAO;
import DAO.UserDAO;
import Model.Role;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet(name = "UserListServlet", urlPatterns = {"/user-list"})
public class UserListServlet extends HttpServlet {

    private static final int ADMIN_ROLE_ID = 1;
    private UserDAO userDAO = new UserDAO();
    private RoleDAO roleDAO = new RoleDAO();

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
           
        String action = request.getParameter("action");
        String userIdStr = request.getParameter("id");
           
        if ("changeStatus".equals(action) && userIdStr != null && !userIdStr.isEmpty()) {
            handleStatusChangeAndRedirect(request, response, session);
            return;
        }
        
        loadUserListAndForward(request, response);
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

        if (currentUser.getRoleId() != ADMIN_ROLE_ID) {
            session.setAttribute("error", "Access denied: You do not have permission to perform this action.");
            response.sendRedirect(request.getContextPath() + "/user-list");
            return;
        }

        if ("add".equals(action)) {
            handleAddUser(request, response, currentUser, session);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/user-list");
    }
    

    private void loadUserListAndForward(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
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
    if (sortOrder == null || sortOrder.isEmpty() || (!"ASC".equalsIgnoreCase(sortOrder) && !"DESC".equalsIgnoreCase(sortOrder))) {
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

    try {
        List<Role> allRoles = roleDAO.getAllRoles();

        request.setAttribute("allRoles", allRoles);
        
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Failed to load filter options.");
    }
    
    request.setAttribute("users", users);
    request.setAttribute("keyword", keyword);
    request.setAttribute("gender_filter", genderFilter);
    request.setAttribute("role_filter", roleIdFilterStr);
    request.setAttribute("status_filter", statusFilter);
    request.setAttribute("sort_field", sortField);
    request.setAttribute("sort_order", sortOrder);

    request.getRequestDispatcher("/user-list.jsp").forward(request, response);
}
    
    private void handleAddUser(HttpServletRequest request, HttpServletResponse response, Users currentUser, HttpSession session)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String gender = request.getParameter("gender");
        String roleIdStr = request.getParameter("roleId");

        Users tempUser = new Users();
        tempUser.setUsername(username);
        tempUser.setPassword(password);
        tempUser.setFullName(fullName);
        tempUser.setEmail(email);
        tempUser.setPhoneNumber(phoneNumber);
        tempUser.setGender(gender);

        Map<String, String> errors = new HashMap<>();
        int roleId = -1;
        
        if (roleIdStr == null || roleIdStr.trim().isEmpty()) {
            errors.put("roleId", "Role ID is required.");
        } else {
            try {
                roleId = Integer.parseInt(roleIdStr);
                tempUser.setRoleId(roleId);
                if (roleId < 1 || roleId > 3) {
                    errors.put("roleId", "Invalid Role ID value.");
                }
            } catch (NumberFormatException e) {
                errors.put("roleId", "Role ID must be a number.");
            }
        }
        
        if (username != null && !username.trim().isEmpty() && userDAO.isUsernameExists(username)) {
            errors.put("username", "This username is already taken.");
        }
        
        if (email != null && !email.trim().isEmpty() && userDAO.isEmailExists(email)) {
            errors.put("email", "This email is already taken.");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("tempUser", tempUser);
            
            loadUserListAndForward(request, response);
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
                session.setAttribute("error", "Failed to add user. An unexpected error occurred in DB.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "An unexpected error occurred during user creation.");
        }

        response.sendRedirect(request.getContextPath() + "/user-list");
    }

    private void handleStatusChangeAndRedirect(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
           
        String userIdStr = request.getParameter("id");
        int userId = -1;
           
        try {
            userId = Integer.parseInt(userIdStr);
            Users userToChange = userDAO.getUserById(userId);

            if (userToChange == null) {
                session.setAttribute("error", "User not found.");
            } else {
                String currentStatus = userToChange.getStatus();
                String newStatus = "active".equalsIgnoreCase(currentStatus) ? "inactive" : "active";

                String username = userDAO.updateStatus(userId, newStatus); 

                if (username != null) {
                    session.setAttribute("message", "Status for user " + username + " successfully changed to '" + newStatus + "'.");
                } else {
                    session.setAttribute("error", "Failed to update user status in the database.");
                }
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid User ID format.");
        } catch (Exception ex) {
            ex.printStackTrace();
            session.setAttribute("error", "An unexpected error occurred during status update.");
        }
        response.sendRedirect(request.getContextPath() + "/user-list");
    }
}