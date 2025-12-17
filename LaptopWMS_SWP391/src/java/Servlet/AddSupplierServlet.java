/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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

@WebServlet(name = "AddSupplierServlet", urlPatterns = { "/add-supplier" })
public class AddSupplierServlet extends HttpServlet {

    private static final int SALE_ROLE_ID = 3;
    private SupplierDAO supplierDAO = new SupplierDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Users currentUser = (Users) session.getAttribute("currentUser");

        // Only Admin can add suppliers
        if (currentUser.getRoleId() != SALE_ROLE_ID) {
            session.setAttribute("error", "Access denied: You do not have permission to add suppliers.");
            response.sendRedirect(request.getContextPath() + "/supplier-list");
            return;
        }

        request.getRequestDispatcher("/add-supplier.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Users currentUser = (Users) session.getAttribute("currentUser");

        // Only Admin can add suppliers
        if (currentUser.getRoleId() != SALE_ROLE_ID) {
            session.setAttribute("error", "Access denied: You do not have permission to add suppliers.");
            response.sendRedirect(request.getContextPath() + "/supplier-list");
            return;
        }

        String supplierName = request.getParameter("supplierName");
        String supplierEmail = request.getParameter("supplierEmail");
        String supplierPhone = request.getParameter("supplierPhone");

        // Validation
        if (supplierName == null || supplierName.trim().isEmpty()) {
            request.setAttribute("error", "Supplier name is required.");
            preserveFormData(request, supplierName, supplierEmail, supplierPhone);
            request.getRequestDispatcher("/add-supplier.jsp").forward(request, response);
            return;
        }

        if (supplierName.length() < 2 || supplierName.length() > 255) {
            request.setAttribute("error", "Supplier name must be between 2 and 255 characters.");
            preserveFormData(request, supplierName, supplierEmail, supplierPhone);
            request.getRequestDispatcher("/add-supplier.jsp").forward(request, response);
            return;
        }

        if (supplierDAO.isSupplierNameExists(supplierName.trim())) {
            request.setAttribute("error",
                    "Supplier '" + supplierName + "' already exists. Please choose another name.");
            preserveFormData(request, supplierName, supplierEmail, supplierPhone);
            request.getRequestDispatcher("/add-supplier.jsp").forward(request, response);
            return;
        }

        if (supplierEmail != null && !supplierEmail.trim().isEmpty()
                && !supplierEmail.matches("^[\\w.-]+@[\\w.-]+\\.[A-Za-z]{2,6}$")) {
            request.setAttribute("error", "Invalid email format.");
            preserveFormData(request, supplierName, supplierEmail, supplierPhone);
            request.getRequestDispatcher("/add-supplier.jsp").forward(request, response);
            return;
        }

        if (supplierPhone != null && !supplierPhone.trim().isEmpty()
                && !supplierPhone.matches("^0[0-9]{9,10}$")) {
            request.setAttribute("error", "Invalid phone number format (10-11 digits starting with 0).");
            preserveFormData(request, supplierName, supplierEmail, supplierPhone);
            request.getRequestDispatcher("/add-supplier.jsp").forward(request, response);
            return;
        }

        // Create and save new supplier
        try {
            Supplier newSupplier = new Supplier();
            newSupplier.setSupplierName(supplierName.trim());
            newSupplier.setSupplierEmail(supplierEmail != null && !supplierEmail.trim().isEmpty()
                    ? supplierEmail.trim()
                    : null);
            newSupplier.setSupplierPhone(supplierPhone != null && !supplierPhone.trim().isEmpty()
                    ? supplierPhone.trim()
                    : null);
            newSupplier.setStatus("active");

            if (supplierDAO.addSupplier(newSupplier)) {
                session.setAttribute("message", "Supplier '" + supplierName + "' added successfully!");
                response.sendRedirect(request.getContextPath() + "/supplier-list");
            } else {
                request.setAttribute("error", "Failed to add supplier. Please try again.");
                preserveFormData(request, supplierName, supplierEmail, supplierPhone);
                request.getRequestDispatcher("/add-supplier.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            preserveFormData(request, supplierName, supplierEmail, supplierPhone);
            request.getRequestDispatcher("/add-supplier.jsp").forward(request, response);
        }
    }

    private void preserveFormData(HttpServletRequest request, String name, String email, String phone) {
        request.setAttribute("supplierName", name);
        request.setAttribute("supplierEmail", email);
        request.setAttribute("supplierPhone", phone);
    }
}
