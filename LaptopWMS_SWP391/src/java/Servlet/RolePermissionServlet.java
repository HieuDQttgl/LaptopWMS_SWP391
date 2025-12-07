/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.RoleDAO;
import Model.Permission;
import Model.Role;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 *
 * @author Admin
 */
@WebServlet(name = "RolePermissionServlet", urlPatterns = {"/role-permission"})
public class RolePermissionServlet extends HttpServlet {

   
    

    private RoleDAO roleDAO = new RoleDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Role> roles = roleDAO.getAllRoles();
            List<Permission> permissions = roleDAO.getAllPermissions();

            Map<Integer, Set<Integer>> rolePermMap = new HashMap<>();

            for (Role r : roles) {
                Set<Integer> permSet = roleDAO.getPermissionIdsByRole(r.getRoleId());
                rolePermMap.put(r.getRoleId(), permSet);
            }

            request.setAttribute("roles", roles);
            request.setAttribute("permissions", permissions);
            request.setAttribute("rolePermMap", rolePermMap);

            request.getRequestDispatcher("role-permission.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        try {
            List<Role> roles = roleDAO.getAllRoles();
            for (Role r : roles) {
                String[] selectedPermissions = request.getParameterValues("perm_" + r.getRoleId());

                List<Integer> permIds = new ArrayList<>();
                if (selectedPermissions != null) {
                    for (String pid : selectedPermissions) {
                        permIds.add(Integer.parseInt(pid));
                    }
                }
                roleDAO.updateRolePermissions(r.getRoleId(), permIds);
            }

            response.sendRedirect("role-permission");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
