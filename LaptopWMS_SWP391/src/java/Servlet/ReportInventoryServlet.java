package Servlet;

import DAO.InventoryDAO;
import DTO.InventoryReportDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "ReportInventoryServlet", urlPatterns = {"/report-inventory"})
public class ReportInventoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InventoryDAO dao = new InventoryDAO();
        String locParam = request.getParameter("location");
        String brand = request.getParameter("brand");      
        String category = request.getParameter("category"); 

 
        int locId = 0;
        if (locParam != null && !locParam.isEmpty()) {
            try {
                locId = Integer.parseInt(locParam);
            } catch (NumberFormatException e) {
                locId = 0;
            }
        }

        List<String> listBrands = dao.getAllBrands();         
        List<String> listCategories = dao.getAllCategories(); 

        request.setAttribute("listBrands", listBrands);
        request.setAttribute("listCategories", listCategories);

        List<InventoryReportDTO> data = dao.getSimpleInventoryReport(locId, brand, category);


        int lowCount = 0;
        int outCount = 0;
        int totalCount = 0;

        if (data != null) {
            totalCount = data.size();
            for (InventoryReportDTO item : data) {
                if ("Low".equals(item.getStatus())) {
                    lowCount++;
                }
                if ("Out".equals(item.getStatus())) {
                    outCount++;
                }
            }
        }


        request.setAttribute("reportData", data);
        request.setAttribute("locations", dao.getAllLocations());


        request.setAttribute("totalCount", totalCount);
        request.setAttribute("lowCount", lowCount);
        request.setAttribute("outCount", outCount);

        request.setAttribute("currentLoc", locId);
        request.setAttribute("currentBrand", brand);       
        request.setAttribute("currentCat", category);    
        request.getRequestDispatcher("report-inventory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
