/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.ProductDAO;
import Model.ProductDetail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
@WebServlet(name = "EditProductDetailServlet", urlPatterns = {"/edit-product-detail"})
public class EditProductDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet EditProductDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProductDetailServlet at " + request.getContextPath() + "</h1>");
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
            int id = Integer.parseInt(request.getParameter("id"));
            int productId = Integer.parseInt(request.getParameter("productId"));

            String cpu = request.getParameter("cpu");
            String gpu = request.getParameter("gpu");
            String ram = request.getParameter("ram");
            String storage = request.getParameter("storage");
            double screen = Double.parseDouble(request.getParameter("screen"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));

            ProductDetail d = new ProductDetail();
            d.setProductDetailId(id);
            d.setCpu(cpu);
            d.setGpu(gpu);
            d.setRam(ram);
            d.setStorage(storage);
            d.setScreen(screen);
            d.setStatus(status);

            ProductDAO dao = new ProductDAO();
            dao.updateProductDetail(d);

            response.sendRedirect("product-list?id=" + productId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("product-list");
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
    }

}
