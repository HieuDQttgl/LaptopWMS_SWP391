/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import Model.*;
import DAO.ProductDAO;
import DAO.SupplierDAO;
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
 * @author PC
 */
@WebServlet(name = "EditProductServlet", urlPatterns = {"/edit-product"})
public class EditProductServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProductServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

            // Get Suppliers for the dropdown
            SupplierDAO supDao = new SupplierDAO();
            List<Supplier> suppliers = supDao.getListSuppliers();

            request.setAttribute("product", p);
            request.setAttribute("supplierList", suppliers);

            request.getRequestDispatcher("edit-product.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("product-list");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("productId"));

            String name = request.getParameter("name");
            String brand = request.getParameter("brand");
            String category = request.getParameter("category");

            String unit = request.getParameter("unit");

            int supplierId = Integer.parseInt(request.getParameter("supplierId"));

            Product p = new Product();
            p.setProductId(id);
            p.setProductName(name);
            p.setBrand(brand);
            p.setCategory(category);
            p.setUnit(unit);
            p.setSupplierId(supplierId);

            ProductDAO dao = new ProductDAO();
            dao.updateProduct(p);

            response.sendRedirect("product-list");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("product-list?error=EditFailed");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Mama mia";
    }// </editor-fold>

}
