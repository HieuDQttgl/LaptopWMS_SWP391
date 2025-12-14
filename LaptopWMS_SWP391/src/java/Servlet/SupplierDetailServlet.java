package Servlet;

import DAO.SupplierDAO;
import Model.Supplier;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "SupplierDetailServlet", urlPatterns = { "/supplier-detail" })
public class SupplierDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        // Check if user is logged in
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Check if user has permission (Admin or Warehouse Keeper)
        int roleId = currentUser.getRoleId();
        if (roleId != 1 && roleId != 2) {
            response.sendRedirect(request.getContextPath() + "/landing");
            return;
        }

        // Get supplier ID from request
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            session.setAttribute("error", "Supplier ID is required");
            response.sendRedirect(request.getContextPath() + "/supplier-list");
            return;
        }

        try {
            int supplierId = Integer.parseInt(idParam);

            SupplierDAO supplierDAO = new SupplierDAO();
            Supplier supplier = supplierDAO.getSupplierById(supplierId);

            if (supplier == null) {
                session.setAttribute("error", "Supplier not found");
                response.sendRedirect(request.getContextPath() + "/supplier-list");
                return;
            }

            request.setAttribute("supplier", supplier);
            request.setAttribute("currentUser", currentUser);
            request.getRequestDispatcher("/supplier-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid Supplier ID");
            response.sendRedirect(request.getContextPath() + "/supplier-list");
        }
    }
}
