/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.UserDAO;
import Model.Users;
import Utils.SendMail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.UUID;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot"})
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forgot.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
 
        UserDAO dao = new UserDAO();
        Users user = dao.getUserByEmail(email);

        if (user == null) {
            request.setAttribute("error", "Email does not exist.");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
            return;
        }

        String newPass = generateRandomPassword();
        dao.updatePassword(user.getUserId(), newPass);

        String loginUrl = request.getScheme() + "://"
                + request.getServerName() + ":"
                + request.getServerPort()
                + request.getContextPath() + "/login";

        String content = ""
                + "Your new password"
                + ". Your new password is: " + newPass + ""
                + ". You can login here:" + loginUrl
                + " Regards, Support Team";

        SendMail.send(email, "Your new password", content);

        request.setAttribute("msg", "New password has been sent to your email!");
        request.getRequestDispatcher("forgot.jsp").forward(request, response);
    }

    private String generateRandomPassword() {
        return UUID.randomUUID().toString().substring(0, 8);
    }
}
