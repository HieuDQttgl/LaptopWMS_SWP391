/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.ProductDAO;
import DAO.SupplierDAO;
import Model.Supplier;
import Model.Product;
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
@WebServlet(name = "AddProductServlet", urlPatterns = {"/add-product"})
public class AddProductServlet extends HttpServlet {

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
            out.println("<title>Servlet AddProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProductServlet at " + request.getContextPath() + "</h1>");
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
        SupplierDAO supplier = new SupplierDAO();
        List<Supplier> list = supplier.getListSuppliers();

        request.setAttribute("supplierList", list);

        request.getRequestDispatcher("add-product.jsp").forward(request, response);
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
            String name = request.getParameter("name");
            String brand = request.getParameter("brand");
            String category = request.getParameter("category");
            String unit = request.getParameter("unit");
            String supplierIdRaw = request.getParameter("supplierId");

            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("error", "Product Name cannot be empty");
                request.getRequestDispatcher("add-product.jsp").forward(request, response);
                return;
            }

            Product p = new Product();
            p.setProductName(name);
            p.setBrand(brand);
            p.setCategory(category);
            p.setUnit(unit);
            p.setStatus(true);

            if (supplierIdRaw != null && !supplierIdRaw.isEmpty()) {
                p.setSupplierId(Integer.parseInt(supplierIdRaw));
            } else {
                p.setSupplierId(1);
            }

            ProductDAO dao = new ProductDAO();
            dao.addProduct(p);

            response.sendRedirect("product-list");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("add-product.jsp?error=InvalidNumber");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add-product.jsp?error=ServerFail");
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
