package Servlet;

import DAO.ProductDAO;
import Model.Product;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * AddProductServlet - updated for laptop_wms_lite database
 */
@WebServlet(name = "AddProductServlet", urlPatterns = { "/add-product" })
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String name = request.getParameter("name");
            String brand = request.getParameter("brand");
            String category = request.getParameter("category");

            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("error", "Product Name cannot be empty");
                request.getRequestDispatcher("add-product.jsp").forward(request, response);
                return;
            }

            Product p = new Product();
            p.setProductName(name);
            p.setBrand(brand);
            p.setCategory(category != null ? category : "Laptop");
            p.setStatus(true);

            ProductDAO dao = new ProductDAO();
            dao.addProduct(p);

            response.sendRedirect("product-list");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add-product.jsp?error=ServerFail");
        }
    }

    @Override
    public String getServletInfo() {
        return "Add Product Servlet for laptop_wms_lite";
    }
}
