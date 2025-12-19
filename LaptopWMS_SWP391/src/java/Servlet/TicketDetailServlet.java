package Servlet;

import DAO.TicketDAO;
import Model.Ticket;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet for viewing ticket details
 */
@WebServlet(name = "TicketDetailServlet", urlPatterns = { "/ticket-detail" })
public class TicketDetailServlet extends HttpServlet {

    private TicketDAO ticketDAO = new TicketDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/ticket-list");
            return;
        }

        try {
            int ticketId = Integer.parseInt(idStr);
            Ticket ticket = ticketDAO.getTicketById(ticketId);

            if (ticket == null) {
                request.setAttribute("error", "Ticket not found");
                response.sendRedirect(request.getContextPath() + "/ticket-list");
                return;
            }

            request.setAttribute("ticket", ticket);

            // Check for success/error messages
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) {
                request.setAttribute("successMessage", successMessage);
                session.removeAttribute("successMessage");
            }

            request.getRequestDispatcher("/ticket-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/ticket-list");
        }
    }
}
