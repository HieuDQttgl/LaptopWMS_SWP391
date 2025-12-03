package Servlet;

import DAO.DBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.html");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean valid = false;
        String fullName = null;

        try (Connection conn = DBContext.getConnection()) {
            String sql = "SELECT full_name FROM users WHERE username = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                valid = true;
                fullName = rs.getString("full_name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (valid) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("fullName", fullName);
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<meta charset=\"UTF-8\">");
                out.println("<title>Login</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<h2>Login</h2>");
                out.println("<p style='color:red'>Invalid username or password</p>");
                out.println("<form method='post' action='" + request.getContextPath() + "/login'>");
                out.println("Username: <input type='text' name='username' value='" + (username != null ? username : "") + "'/><br/>");
                out.println("Password: <input type='password' name='password'/><br/>");
                out.println("<input type='submit' value='Login'/>");
                out.println("</form>");
                out.println("</body>");
                out.println("</html>");
            }
        }
    }
}


