package Servlet;

import DAO.ProductDAO;
import Model.ProductDetail;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * EditProductDetailServlet - Logic updated to IGNORE Quantity changes
 */
@WebServlet(name = "EditProductDetailServlet", urlPatterns = {"/edit-product-detail"})
public class EditProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);

                ProductDAO dao = new ProductDAO();
                ProductDetail detail = dao.getProductDetailById(id);

                if (detail != null) {
                    request.setAttribute("detail", detail);
                    request.getRequestDispatcher("edit-product-detail.jsp").forward(request, response);
                } else {
                    response.sendRedirect("product-list");
                }

            } catch (NumberFormatException e) {
                response.sendRedirect("product-list");
            }
        } else {
            response.sendRedirect("product-list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int productId = Integer.parseInt(request.getParameter("productId"));
            String cpu = request.getParameter("cpu");
            String gpu = request.getParameter("gpu");

            String ramValue = request.getParameter("ram");
            String ram = ramValue + "GB";

            String storageValue = request.getParameter("storageValue");
            String storageUnit = request.getParameter("storageUnit");
            String storage = storageValue + storageUnit;

            String unit = request.getParameter("unit");

            ProductDetail d = new ProductDetail();
            d.setProductDetailId(id);
            d.setProductId(productId);
            d.setCpu(cpu);
            d.setGpu(gpu);
            d.setRam(ram);
            d.setStorage(storage);
            d.setUnit(unit);

            ProductDAO dao = new ProductDAO();
            dao.updateProductDetail(d);
            response.sendRedirect("product-list");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("product-list?error=EditFailed");
        }
    }

    @Override
    public String getServletInfo() {
        return "Edit Product Detail Servlet (Specs Only, No Stock Edit)";
    }
}
