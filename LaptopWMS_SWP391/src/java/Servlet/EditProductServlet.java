package Servlet;

import Model.*;
import DAO.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * EditProductServlet - updated for laptop_wms_lite database
 */
@WebServlet(name = "EditProductServlet", urlPatterns = { "/edit-product" })
public class EditProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String idRaw = request.getParameter("id");
            if (idRaw == null) {
                response.sendRedirect("product-list");
                return;
            }

            int id = Integer.parseInt(idRaw);
            ProductDAO dao = new ProductDAO();
            Product p = dao.getProductById(id);

            if (p == null) {
                response.sendRedirect("product-list?error=NotFound");
                return;
            }

            request.setAttribute("product", p);

            request.getRequestDispatcher("edit-product.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("product-list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("productId"));

            String name = request.getParameter("name");
            String brand = request.getParameter("brand");
            String category = request.getParameter("category");

            Product p = new Product();
            p.setProductId(id);
            p.setProductName(name);
            p.setBrand(brand);
            p.setCategory(category);

            ProductDAO dao = new ProductDAO();
            dao.updateProduct(p);

            response.sendRedirect("product-list");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("product-list?error=EditFailed");
        }
    }

    @Override
    public String getServletInfo() {
        return "Edit Product Servlet for laptop_wms_lite";
    }
}
