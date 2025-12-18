package Servlet;

import DAO.LocationDAO;
import Model.Location;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "LocationListServlet", urlPatterns = { "/location-list" })
public class LocationListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get filter parameters
        String keyword = request.getParameter("keyword");
        String zone = request.getParameter("zone");
        String aisle = request.getParameter("aisle");
        String status = request.getParameter("status");
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");

        // Set defaults
        if (status == null)
            status = "all";
        if (sortOrder == null)
            sortOrder = "ASC";

        // Pagination
        int page = 1;
        int pageSize = 10;

        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
                if (page < 1)
                    page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        // Get data from DAO
        LocationDAO dao = new LocationDAO();
        List<Location> locationList = dao.getLocations(keyword, zone, aisle, status, sortBy, sortOrder, page, pageSize);
        int totalItems = dao.getTotalCount(keyword, zone, aisle, status);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        // Get filter options
        List<String> zones = dao.getDistinctZones();
        List<String> aisles = dao.getDistinctAisles();

        // Set attributes for JSP
        request.setAttribute("locationList", locationList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalItems", totalItems);

        // Preserve filter values
        request.setAttribute("currentKeyword", keyword);
        request.setAttribute("currentZone", zone);
        request.setAttribute("currentAisle", aisle);
        request.setAttribute("currentStatus", status);
        request.setAttribute("currentSortBy", sortBy);
        request.setAttribute("currentSortOrder", sortOrder);

        // Filter options
        request.setAttribute("zones", zones);
        request.setAttribute("aisles", aisles);

        request.getRequestDispatcher("location-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
