package Servlet;

import DAO.PartnerDAO;
import Model.Partners;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "EditSupplierServlet", urlPatterns = { "/edit-supplier" })
public class EditSupplierServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idRaw = request.getParameter("id");
            if (idRaw == null || idRaw.isEmpty()) {
                response.sendRedirect("supplier-list");
                return;
            }

            int id = Integer.parseInt(idRaw);
            PartnerDAO dao = new PartnerDAO();
            Partners supplier = dao.getPartnerById(id);

            if (supplier != null && supplier.getType() == 1) {
                request.setAttribute("supplier", supplier);
                request.getRequestDispatcher("edit-supplier.jsp").forward(request, response);
            } else {
                response.sendRedirect("supplier-list");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("supplier-list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            String idRaw = request.getParameter("id");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");

            // Validation
            if (idRaw == null || idRaw.isEmpty()) {
                response.sendRedirect("supplier-list");
                return;
            }

            int id = Integer.parseInt(idRaw);

            if (name == null || name.trim().isEmpty()) {
                PartnerDAO dao = new PartnerDAO();
                Partners supplier = dao.getPartnerById(id);
                request.setAttribute("supplier", supplier);
                request.setAttribute("error", "Supplier name is required");
                request.getRequestDispatcher("edit-supplier.jsp").forward(request, response);
                return;
            }

            // Update supplier
            Partners p = new Partners();
            p.setPartnerId(id);
            p.setPartnerName(name.trim());
            p.setPartnerEmail(email != null ? email.trim() : "");
            p.setPartnerPhone(phone != null ? phone.trim() : "");

            PartnerDAO dao = new PartnerDAO();
            dao.updatePartner(p);

            // Redirect with success
            response.sendRedirect("supplier-detail?id=" + id);

        } catch (NumberFormatException e) {
            response.sendRedirect("supplier-list");
        }
    }

    @Override
    public String getServletInfo() {
        return "Edit Supplier Servlet";
    }
}
