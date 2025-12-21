/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.PartnerDAO;
import Model.Partners;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddSupplierServlet", urlPatterns = { "/add-supplier" })
public class AddSupplierServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddSupplierServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddSupplierServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add-supplier.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        // Server-side validation
        StringBuilder errorMsg = new StringBuilder();

        // Validate name (required)
        if (name == null || name.trim().isEmpty()) {
            errorMsg.append("Supplier name is required. ");
        }

        // Validate email format (if provided)
        if (email != null && !email.trim().isEmpty()) {
            if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
                errorMsg.append("Invalid email format. ");
            }
        }

        // Validate phone format (if provided)
        if (phone != null && !phone.trim().isEmpty()) {
            String cleanPhone = phone.replaceAll("[\\s\\-]", "");
            if (!cleanPhone.matches("^[0-9]{10,15}$")) {
                errorMsg.append("Phone number must be 10-15 digits. ");
            }
        }

        // If validation fails, return to form with error
        if (errorMsg.length() > 0) {
            request.setAttribute("error", errorMsg.toString());
            request.getRequestDispatcher("add-supplier.jsp").forward(request, response);
            return;
        }

        Partners p = new Partners();
        p.setPartnerName(name.trim());
        p.setPartnerEmail(email != null ? email.trim() : "");
        p.setPartnerPhone(phone != null ? phone.trim() : "");

        p.setType(1); // 1 = supplier
        p.setStatus("active");

        PartnerDAO dao = new PartnerDAO();
        dao.addPartner(p);

        response.sendRedirect("supplier-list");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
