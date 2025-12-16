package Servlet;

import DAO.RoleDAO;
import DAO.UserDAO;
import Model.Role;
import Model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserDetailServlet", urlPatterns = { "/user-detail" })
public class UserDetailServlet extends HttpServlet {

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
        request.setAttribute("currentUser", currentUser);

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user-list");
            return;
        }

        try {
            int userId = Integer.parseInt(idParam);
            UserDAO userDAO = new UserDAO();
            Users user = userDAO.getUserById(userId);

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/user-list");
                return;
            }

            RoleDAO roleDAO = new RoleDAO();
            Role role = roleDAO.getRoleById(user.getRoleId());

            Users creator = null;
            if (user.getCreatedBy() != null) {
                creator = userDAO.getUserById(user.getCreatedBy());
            }

            request.setAttribute("user", user);
            request.setAttribute("role", role);
            request.setAttribute("creator", creator);
            request.getRequestDispatcher("/user-detail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/user-list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Users currentUser = (Users) session.getAttribute("currentUser");

        // Only admin can edit user details
        if (currentUser.getRoleId() != ADMIN_ROLE_ID) {
            session.setAttribute("error", "You don't have permission to edit users.");
            response.sendRedirect(request.getContextPath() + "/user-list");
            return;
        }

        String idParam = request.getParameter("userId");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user-list");
            return;
        }

        try {
            int userId = Integer.parseInt(idParam);
            String username = request.getParameter("username");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String gender = request.getParameter("gender");

            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.updateProfilebyAdmin(userId, username, fullName, email, phoneNumber, gender);

            if (success) {
                request.setAttribute("success", "User profile updated successfully.");
            } else {
                request.setAttribute("error", "Failed to update user profile.");
            }

            // Reload user data
            Users user = userDAO.getUserById(userId);
            RoleDAO roleDAO = new RoleDAO();
            Role role = roleDAO.getRoleById(user.getRoleId());

            Users creator = null;
            if (user.getCreatedBy() != null) {
                creator = userDAO.getUserById(user.getCreatedBy());
            }

            request.setAttribute("currentUser", currentUser);
            request.setAttribute("user", user);
            request.setAttribute("role", role);
            request.setAttribute("creator", creator);
            request.getRequestDispatcher("/user-detail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/user-list");
        }
    }
}
