package Servlet;

import DAO.AnnouncementDAO;
import DAO.DashboardDAO;
import Model.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * DashboardServlet - updated for laptop_wms_lite database
 * 
 * @author super
 */
@WebServlet(name = "DashboardServlet", urlPatterns = { "/dashboard" })
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        DashboardDAO dao = new DashboardDAO();
        AnnouncementDAO aDao = new AnnouncementDAO();
        
        request.setAttribute("announcementList", aDao.getAnnouncements(4));
        
        int roleId = currentUser.getRoleId();

        request.setAttribute("totalProducts", dao.getTotalProducts());
        request.setAttribute("totalUsers", dao.getTotalUsers());
        request.setAttribute("pendingTicketCount", dao.getPendingTicketCount());

        switch (roleId) {
            case 1: // Admin
                request.setAttribute("userList", dao.getRecentUsers());
                request.setAttribute("roleList", dao.getRolesList());
                request.setAttribute("topProducts", dao.getTopAvailableProducts());
                request.setAttribute("pendingTickets", dao.getPendingTickets());
                break;
            case 2: // Sale
                request.setAttribute("topProducts", dao.getTopAvailableProducts());
                request.setAttribute("myTickets", dao.getMyRecentTickets(currentUser.getUserId()));
                request.setAttribute("lowStock", dao.getLowStockAlerts(10));
                break;
            case 3: // Keeper
                request.setAttribute("pendingTickets", dao.getPendingTicketsByKeeper(currentUser.getUserId()));
                request.setAttribute("lowStock", dao.getLowStockAlerts(5));
                request.setAttribute("keeperHistory", dao.getKeeperHistory(currentUser.getUserId()));
                break;
            default:
                break;
        }

        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Dashboard Servlet for laptop_wms_lite";
    }
}
