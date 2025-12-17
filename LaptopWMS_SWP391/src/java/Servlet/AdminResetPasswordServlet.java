package Servlet;

import DAO.UserDAO;
import Model.Users;
import Utils.SendMail;
import java.io.IOException;
import java.security.SecureRandom;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminResetPasswordServlet", urlPatterns = { "/admin-reset-password" })
public class AdminResetPasswordServlet extends HttpServlet {

    private static final int ADMIN_ROLE_ID = 1;
    private static final String PASSWORD_CHARS = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz23456789";
    private static final int PASSWORD_LENGTH = 10;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Users currentUser = (Users) session.getAttribute("currentUser");

        // Only admin can reset passwords
        if (currentUser.getRoleId() != ADMIN_ROLE_ID) {
            session.setAttribute("error", "You don't have permission to reset passwords.");
            response.sendRedirect(request.getContextPath() + "/user-list");
            return;
        }

        String userIdParam = request.getParameter("userId");
        if (userIdParam == null || userIdParam.isEmpty()) {
            session.setAttribute("error", "User ID is required.");
            response.sendRedirect(request.getContextPath() + "/user-list");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdParam);
            UserDAO userDAO = new UserDAO();
            Users targetUser = userDAO.getUserById(userId);

            if (targetUser == null) {
                session.setAttribute("error", "User not found.");
                response.sendRedirect(request.getContextPath() + "/user-list");
                return;
            }

            // Cannot reset admin password
            if (targetUser.getRoleId() == ADMIN_ROLE_ID) {
                request.setAttribute("error", "Cannot reset password for admin users.");
                forwardToUserDetail(request, response, userId);
                return;
            }

            // Check if user has email
            if (targetUser.getEmail() == null || targetUser.getEmail().isEmpty()) {
                request.setAttribute("error", "User does not have an email address configured.");
                forwardToUserDetail(request, response, userId);
                return;
            }

            // Generate random password
            String newPassword = generateRandomPassword();

            // Update password in database
            boolean passwordUpdated = userDAO.updatePassword(userId, newPassword);

            if (!passwordUpdated) {
                request.setAttribute("error", "Failed to update password in database.");
                forwardToUserDetail(request, response, userId);
                return;
            }

            // Update password_changed_at to invalidate existing sessions
            userDAO.updatePasswordChangedAt(userId);

            // Send email with new password
            boolean emailSent = SendMail.sendPasswordResetEmail(
                    targetUser.getEmail(),
                    targetUser.getUsername(),
                    newPassword);

            if (emailSent) {
                request.setAttribute("success",
                        "Password reset successfully! New password has been sent to " + targetUser.getEmail());
            } else {
                // Password was changed but email failed - warn admin
                request.setAttribute("success",
                        "Password reset successfully, but email could not be sent. " +
                                "Please manually inform the user. New password: " + newPassword);
            }

            forwardToUserDetail(request, response, userId);

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid user ID.");
            response.sendRedirect(request.getContextPath() + "/user-list");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/user-list");
        }
    }

    /**
     * Generate a random password using secure random
     */
    private String generateRandomPassword() {
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder(PASSWORD_LENGTH);

        for (int i = 0; i < PASSWORD_LENGTH; i++) {
            int index = random.nextInt(PASSWORD_CHARS.length());
            password.append(PASSWORD_CHARS.charAt(index));
        }

        return password.toString();
    }

    /**
     * Forward back to user detail page with loaded data
     */
    private void forwardToUserDetail(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {

        try {
            UserDAO userDAO = new UserDAO();
            Users user = userDAO.getUserById(userId);

            DAO.RoleDAO roleDAO = new DAO.RoleDAO();
            Model.Role role = roleDAO.getRoleById(user.getRoleId());
            java.util.List<Model.Role> roles = roleDAO.getAllRoles();

            Users creator = null;
            if (user.getCreatedBy() != null) {
                creator = userDAO.getUserById(user.getCreatedBy());
            }

            Users currentUser = (Users) request.getSession().getAttribute("currentUser");

            request.setAttribute("currentUser", currentUser);
            request.setAttribute("user", user);
            request.setAttribute("role", role);
            request.setAttribute("roles", roles);
            request.setAttribute("creator", creator);

            request.getRequestDispatcher("/user-detail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/user-list");
        }
    }
}
