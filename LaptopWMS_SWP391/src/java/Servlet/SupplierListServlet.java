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
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet(name = "SupplierListServlet", urlPatterns = { "/supplier-list" })
public class SupplierListServlet extends HttpServlet {

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

        // Only Admin and Warehouse Keeper can view suppliers
        if (currentUser.getRoleId() != SALE_ROLE_ID) {
            request.setAttribute("error", "Access denied: You do not have permission to view this page.");
            request.getRequestDispatcher("/landing").forward(request, response);
            return;
        }

        // Get filter parameters
        String keyword = request.getParameter("keyword");
        String statusFilter = request.getParameter("status_filter");
        String sortField = request.getParameter("sort_field");
        String sortOrder = request.getParameter("sort_order");

        // Set defaults
        if (sortField == null || sortField.isEmpty()) {
            sortField = "supplier_id";
        }
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "ASC";
        }

        // Pagination parameters
        int pageSize = 5; // Items per page
        int currentPage = 1;

        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) {
                    currentPage = 1;
                }
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        // Get total count for pagination
        int totalCount = supplierDAO.getTotalSuppliers(keyword, statusFilter);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        // Ensure current page is within valid range
        if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages;
        }

        int offset = (currentPage - 1) * pageSize;

        // Get suppliers list with pagination
        List<Supplier> suppliers = supplierDAO.getListSuppliers(
                keyword,
                statusFilter,
                sortField,
                sortOrder,
                offset,
                pageSize);

        // Set attributes for JSP
        request.setAttribute("suppliers", suppliers);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status_filter", statusFilter);
        request.setAttribute("sort_field", sortField);
        request.setAttribute("sort_order", sortOrder);
        request.setAttribute("currentUser", currentUser);

        // Pagination attributes
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("pageSize", pageSize);

        request.getRequestDispatcher("/supplier-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Users currentUser = (Users) session.getAttribute("currentUser");
        int roleId = currentUser.getRoleId();

        // Check access for specific actions
        if ("add".equals(action)) {
            // Only Admin can add suppliers
            if (roleId != SALE_ROLE_ID) {
                session.setAttribute("error", "Access denied: Only Sale can add suppliers.");
                response.sendRedirect(request.getContextPath() + "/supplier-list");
                return;
            }
            handleAddSupplier(request, response, session, currentUser);
            return;
        }

        if ("changeStatus".equals(action)) {
            // Admin and Warehouse Keeper can change status
            if (roleId != SALE_ROLE_ID) {
                session.setAttribute("error", "Access denied: You do not have permission to change supplier status.");
                response.sendRedirect(request.getContextPath() + "/supplier-list");
                return;
            }
            handleChangeStatus(request, response, session);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/supplier-list");
    }

    private void handleAddSupplier(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, Users currentUser)
            throws ServletException, IOException {

        String supplierName = request.getParameter("supplierName");
        String supplierEmail = request.getParameter("supplierEmail");
        String supplierPhone = request.getParameter("supplierPhone");

        Map<String, String> errors = new HashMap<>();
        Supplier tempSupplier = new Supplier();

        // Validation
        if (supplierName == null || supplierName.trim().isEmpty()) {
            errors.put("supplierName", "Supplier name is required.");
        } else if (supplierName.length() < 2 || supplierName.length() > 255) {
            errors.put("supplierName", "Supplier name must be between 2 and 255 characters.");
        } else if (supplierDAO.isSupplierNameExists(supplierName.trim())) {
            errors.put("supplierName", "This supplier name already exists. Please choose another one.");
        }
        tempSupplier.setSupplierName(supplierName);

        if (supplierEmail != null && !supplierEmail.trim().isEmpty()
                && !supplierEmail.matches("^[\\w.-]+@[\\w.-]+\\.[A-Za-z]{2,6}$")) {
            errors.put("supplierEmail", "Invalid email format.");
        }
        tempSupplier.setSupplierEmail(supplierEmail);

        if (supplierPhone != null && !supplierPhone.trim().isEmpty()
                && !supplierPhone.matches("^0[0-9]{9,10}$")) {
            errors.put("supplierPhone", "Invalid phone number format (10-11 digits starting with 0).");
        }
        tempSupplier.setSupplierPhone(supplierPhone);

        // If there are validation errors, return to form
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("tempSupplier", tempSupplier);

            // Reload supplier list
            String keyword = request.getParameter("keyword");
            String statusFilter = request.getParameter("status_filter");
            String sortField = request.getParameter("sort_field");
            String sortOrder = request.getParameter("sort_order");

            List<Supplier> suppliers = supplierDAO.getListSuppliers(keyword, statusFilter, sortField, sortOrder);
            request.setAttribute("suppliers", suppliers);
            request.setAttribute("keyword", keyword);
            request.setAttribute("status_filter", statusFilter);
            request.setAttribute("sort_field", sortField);
            request.setAttribute("sort_order", sortOrder);

            request.getRequestDispatcher("/supplier-list.jsp").forward(request, response);
            return;
        }

        // Create and save new supplier
        try {
            Supplier newSupplier = new Supplier();
            newSupplier.setSupplierName(supplierName.trim());
            newSupplier.setSupplierEmail(supplierEmail != null ? supplierEmail.trim() : null);
            newSupplier.setSupplierPhone(supplierPhone != null ? supplierPhone.trim() : null);
            newSupplier.setStatus("active");

            if (supplierDAO.addSupplier(newSupplier)) {
                session.setAttribute("message", "Supplier '" + supplierName + "' added successfully!");
            } else {
                session.setAttribute("error", "Failed to add supplier. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "An unexpected error occurred during supplier creation.");
        }

        response.sendRedirect(request.getContextPath() + "/supplier-list");
    }

    private void handleChangeStatus(HttpServletRequest request, HttpServletResponse response,
            HttpSession session)
            throws IOException {

        String supplierIdStr = request.getParameter("id");

        try {
            int supplierId = Integer.parseInt(supplierIdStr);
            Supplier supplier = supplierDAO.getSupplierById(supplierId);

            if (supplier == null) {
                session.setAttribute("error", "Supplier not found.");
            } else {
                String currentStatus = supplier.getStatus();
                String newStatus = "active".equalsIgnoreCase(currentStatus) ? "inactive" : "active";

                String supplierName = supplierDAO.updateStatus(supplierId, newStatus);

                if (supplierName != null) {
                    session.setAttribute("message", "Status for supplier '" + supplierName
                            + "' successfully changed to '" + newStatus + "'.");
                } else {
                    session.setAttribute("error", "Failed to update supplier status.");
                }
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid Supplier ID format.");
        } catch (Exception ex) {
            session.setAttribute("error", "An unexpected error occurred during status update.");
        }

        response.sendRedirect(request.getContextPath() + "/supplier-list");
    }
}
