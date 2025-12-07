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
import java.util.List;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "UserListServlet", urlPatterns = {"/user-list"})
public class UserListServlet extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        List<Users> users = userDAO.getListUsers();

        request.setAttribute("users", users);
        request.getRequestDispatcher("/user-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        UserDAO userDAO = new UserDAO();


        String action = request.getParameter("action");

        if ("add".equals(action)) { 
            // Lấy các tham số cần thiết cho việc thêm mới
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String fullname = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phonenumber = request.getParameter("phoneNumber");
            String gender = request.getParameter("gender");
            int roleId = Integer.parseInt(request.getParameter("roleId")); // Cần try-catch

            Users newUser = new Users(
                0, username, password, fullname, email, phonenumber, gender, roleId, 
                "active", null, null, null, null 
            );

            boolean success = userDAO.addNew(newUser);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/user-list?message=Success");
            } else {
                request.getSession().setAttribute("error", "Error.");

                response.sendRedirect(request.getContextPath() + "/user-list");
            }
        }
    }

}
