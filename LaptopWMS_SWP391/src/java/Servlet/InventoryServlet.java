package Servlet;

import DAO.InventoryDAO;
import DTO.InventoryDTO;
import Model.Location;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "InventoryServlet", urlPatterns = {"/inventory"})
public class InventoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        InventoryDAO dao = new InventoryDAO();
        
        String search = request.getParameter("search");
        if (search == null) {
            search = "";
        }
        
        String locationStr = request.getParameter("location");
        int locationId = 0;
        if (locationStr != null && !locationStr.isEmpty()) {
            try {
                locationId = Integer.parseInt(locationStr);
            } catch (NumberFormatException e) {
                locationId = 0;
            }
        }
         String sortBy = request.getParameter("sortBy");
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "id"; 
        }
        
        String sortOrder = request.getParameter("sortOrder");
        if (sortOrder == null || sortOrder.isEmpty()) {
            sortOrder = "ASC"; 
        }
        int page = 1;
        int pageSize = 10;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<InventoryDTO> inventoryList = dao.getInventoryList(search, locationId, page, pageSize, sortBy, sortOrder);
        List<Location> locations = dao.getAllLocations();
        int totalRecords = dao.getTotalInventoryCount(search, locationId);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        request.setAttribute("inventoryList", inventoryList);
        request.setAttribute("locations", locations);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.setAttribute("selectedLocation", locationId);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);

        request.getRequestDispatcher("inventory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}