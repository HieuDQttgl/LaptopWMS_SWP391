/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.InventoryDAO;
import DAO.ProductDAO;
import DTO.ProductDTO;
import Model.Location;
import Model.ProductItem;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddInventoryServlet", urlPatterns = {"/add-inventory"})
public class AddInventoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
          
        
       try {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int locationId = Integer.parseInt(request.getParameter("locationId")); 
        
        InventoryDAO dao = new InventoryDAO();
        List<ProductItem> items = dao.getItemsForAudit(productId);
        List<Model.ProductDetail> details = dao.getDetailsByProductId(productId);
        
        request.setAttribute("items", items);
        request.setAttribute("productDetails", details);
        request.setAttribute("productId", productId);
        request.setAttribute("locationId", locationId);
        request.getRequestDispatcher("inventory-audit.jsp").forward(request, response);
    } catch (Exception e) {
           response.sendRedirect("inventory?error=system");
    }
    }
    

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    String productIdStr = request.getParameter("productId");
    String locationIdStr = request.getParameter("locationId"); 
    InventoryDAO dao = new InventoryDAO();

    try {
        int productId = Integer.parseInt(productIdStr);
        int locationId = (locationIdStr != null && !locationIdStr.isEmpty()) 
                         ? Integer.parseInt(locationIdStr) 
                         : 1; 
        
        boolean success = dao.addProductToInventory(productId, locationId);

        if (success) {
            response.sendRedirect("inventory?addSuccess=true");
        } else {
            response.sendRedirect("add-inventory?error=duplicate");
        }
    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.sendRedirect("add-inventory?error=invalid");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("add-inventory?error=system");
    }
}


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
