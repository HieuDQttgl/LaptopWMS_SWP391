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

@WebServlet(name = "UserDetailServlet", urlPatterns = {"/user-detail"})
public class UserDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

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
                response.sendRedirect(request.getContextPath() + "/user");
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

}

