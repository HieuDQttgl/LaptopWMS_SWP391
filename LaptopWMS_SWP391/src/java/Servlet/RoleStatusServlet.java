package Servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * RoleStatusServlet - Disabled for laptop_wms_lite database
 * The roles table no longer has a status column in this schema.
 * This servlet is kept for backward compatibility but does nothing.
 */
@WebServlet("/role-status")
public class RoleStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Role status toggle is not supported in laptop_wms_lite schema
        // The roles table doesn't have a status column
        // Just redirect back to role-list
        response.sendRedirect("role-list");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("role-list");
    }
}
