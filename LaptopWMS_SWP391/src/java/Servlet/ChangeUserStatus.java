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

@WebServlet(name = "ChangeUserStatusServlet", urlPatterns = {"/user-status"})
public class ChangeUserStatus extends HttpServlet {
    
    private static final int ADMIN_ROLE_ID = 1;
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Users currentUser = (Users) session.getAttribute("currentUser");
        if (session == null || currentUser == null || currentUser.getRoleId() != ADMIN_ROLE_ID) {
            session.setAttribute("error", "🚫 Access denied: Administrator privileges required.");
            response.sendRedirect(request.getContextPath() + "/landing");
            return;
        }
        
        String userIdStr = request.getParameter("id");
        if (userIdStr == null || userIdStr.isEmpty()) {
            session.setAttribute("error", "User ID not provided.");
            response.sendRedirect(request.getContextPath() + "/user-list");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);
            Users userToChange = userDAO.getUserById(userId);
            
            if (userToChange == null) {
                session.setAttribute("error", "User not found.");
                response.sendRedirect(request.getContextPath() + "/user-list");
                return;
            }
            
            request.setAttribute("user", userToChange);
            request.getRequestDispatcher("/user-status.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid User ID format.");
            response.sendRedirect(request.getContextPath() + "/user-list");
        } catch (Exception ex) { 
             session.setAttribute("error", "An unexpected error occurred: " + ex.getMessage());
             response.sendRedirect(request.getContextPath() + "/user-list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Users currentUser = (Users) session.getAttribute("currentUser");
        if (session == null || currentUser == null || currentUser.getRoleId() != ADMIN_ROLE_ID) {
            session.setAttribute("error", "Access denied for status change.");
            response.sendRedirect(request.getContextPath() + "/user-list");
            return;
        }

        String userIdStr = request.getParameter("id");
        String newStatus = request.getParameter("newStatus");

        if (userIdStr == null || userIdStr.isEmpty() || newStatus == null || newStatus.isEmpty()) {
            session.setAttribute("error", "Missing parameters for status change.");
            response.sendRedirect(request.getContextPath() + "/user-list");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);
            String username = userDAO.updateStatus(userId, newStatus);
            
            if (username != null) {
                response.sendRedirect(request.getContextPath() + "/user-list?message=Status for user " + username + " changed to '" + newStatus + "' successfully.");
            } else {
                session.setAttribute("error", "Failed to update user status in the database.");
                response.sendRedirect(request.getContextPath() + "/user-list");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid User ID format.");
            response.sendRedirect(request.getContextPath() + "/user-list");
        } catch (Exception ex) {
            System.getLogger(ChangeUserStatus.class.getName()).log(System.Logger.Level.ERROR, "Unhandled exception during status update", ex);
            session.setAttribute("error", "An unexpected error occurred: " + ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/user-list");
        }
    }
}
