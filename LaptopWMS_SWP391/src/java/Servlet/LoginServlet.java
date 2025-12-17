package Servlet;

import DAO.PermissionDAO;
import DAO.RoleDAO;
import DAO.UserDAO;
import Model.Role;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "LoginServlet", urlPatterns = { "/login" })
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO userDao = new UserDAO();
        Model.Users user = userDao.findByUsernameAndPassword(username, password);
        RoleDAO dao = new RoleDAO();
        if (user != null) {
            try {
                Role role = dao.getRoleById(user.getRoleId());
                if (role.getStatus().toLowerCase().equals("inactive")) {
                    request.setAttribute("error", "Your role is disabled. Contact admin.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }
                if (user.getStatus().toLowerCase().equals("inactive")) {
                    request.setAttribute("error", "Your account is disabled. Contact admin.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }
                userDao.updateLastLogin(user.getUserId());
                PermissionDAO permissionDAO = new PermissionDAO();
                List<String> userPermissions = permissionDAO.getPermissionUrlsByRoleId(user.getRoleId());

                HttpSession session = request.getSession();
                session.setAttribute("username", user.getUsername());
                session.setAttribute("fullName", user.getFullName());
                session.setAttribute("currentUser", user);
                session.setAttribute("sessionCreatedAt", System.currentTimeMillis()); // NEW: Track session creation
                                                                                      // time
                session.setAttribute("userPermissions", userPermissions);
                response.sendRedirect(request.getContextPath() + "/landing");
            } catch (Exception ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
