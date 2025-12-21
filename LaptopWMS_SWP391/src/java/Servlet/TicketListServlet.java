package Servlet;

import DAO.TicketDAO;
import Model.Ticket;
import Model.Users;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet for listing all tickets
 */
@WebServlet(name = "TicketListServlet", urlPatterns = { "/ticket-list" })
public class TicketListServlet extends HttpServlet {

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

        // Get filter parameters
        String status = request.getParameter("status");
        String type = request.getParameter("type");

        List<Ticket> tickets;

        // If keeper, show only assigned tickets
        if (currentUser.getRoleId() == 3) {
            tickets = ticketDAO.getTicketsForKeeper(currentUser.getUserId(), status, type);
        } else {
            tickets = ticketDAO.getAllTickets(status, type);
        }

        request.setAttribute("tickets", tickets);
        request.setAttribute("currentStatus", status);
        request.setAttribute("currentType", type);

        // Check for success message
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }

        request.getRequestDispatcher("/ticket-list.jsp").forward(request, response);
    }
}
