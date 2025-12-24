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
 * AddProductDetailServlet - updated for laptop_wms_lite database
 */
@WebServlet(name = "AddProductDetailServlet", urlPatterns = {"/add-product-detail"})
public class AddProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String idRaw = request.getParameter("id");
            if (idRaw == null || idRaw.isEmpty()) {
                response.sendRedirect("product-list");
                return;
            }

            int id = Integer.parseInt(idRaw);

            ProductDAO dao = new ProductDAO();
            String name = dao.getProductNameById(id);

            request.setAttribute("targetName", name);
            request.setAttribute("targetId", id);

            request.getRequestDispatcher("add-product-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("product-list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
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
            d.setProductId(productId);
            d.setCpu(cpu);
            d.setGpu(gpu);
            d.setRam(ram);
            d.setStorage(storage);
            d.setUnit(unit != null ? unit : "piece");
            d.setQuantity(0);

            ProductDAO dao = new ProductDAO();
            dao.addProductDetail(d);
            response.sendRedirect("product-list");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("product-list?error=AddDetailFailed");
        }
    }

    @Override
    public String getServletInfo() {
        return "Add Product Detail Servlet for laptop_wms_lite";
    }
}
