/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.InventoryDAO;
import Model.ProductItem;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Admin
 */
@WebServlet(name = "InventoryAuditServlet", urlPatterns = {"/audit-inventory"})
public class InventoryAuditServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        try {

            String locParam = request.getParameter("locationId");
            int locationId = (locParam != null && !locParam.isEmpty()) ? Integer.parseInt(locParam) : 0;

            InventoryDAO dao = new InventoryDAO();

            List<ProductItem> items = dao.getItemsForAudit(productId);
            List<Model.ProductDetail> details = dao.getDetailsByProductId(productId);

            request.setAttribute("items", items);
            request.setAttribute("productDetails", details);
            request.setAttribute("productId", productId);
            request.setAttribute("locationId", locationId);

            request.getRequestDispatcher("inventory-audit.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("inventory?error=system");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String[] itemIds = request.getParameterValues("itemId");

        Map<Integer, String[]> auditData = new HashMap<>();
        if (itemIds != null) {
            for (String id : itemIds) {
                String status = request.getParameter("status_" + id);
                String note = request.getParameter("note_" + id);
                auditData.put(Integer.parseInt(id), new String[]{status, note});
            }
        }

        new InventoryDAO().updateAuditAndSync(productId, auditData);
        response.sendRedirect("inventory?success=true");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
