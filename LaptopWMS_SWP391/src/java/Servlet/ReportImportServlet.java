package Servlet;

import DAO.PartnerDAO;
import DAO.TicketDAO; 
import DTO.ImportReportDTO;
import Model.Partners;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ReportImportServlet", urlPatterns = {"/report-import"})
public class ReportImportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String partnerId = request.getParameter("partnerId");
        String status = request.getParameter("status");

        TicketDAO ticketDAO = new TicketDAO();
        List<ImportReportDTO> importData = ticketDAO.getImportReport(fromDate, toDate, partnerId, status);
        
        PartnerDAO partnerDAO = new PartnerDAO();
        List<Partners> partners = partnerDAO.getSuppliers(); 
        request.setAttribute("partners", partners);

        int totalTickets = importData.size();
        int pendingCount = 0;
        for (ImportReportDTO item : importData) {
            if ("PENDING".equalsIgnoreCase(item.getStatus())) {
                pendingCount++;
            }
        }

        request.setAttribute("importData", importData);
        request.setAttribute("totalTickets", totalTickets);
        request.setAttribute("pendingCount", pendingCount);
        
        request.setAttribute("selectedFrom", fromDate);
        request.setAttribute("selectedTo", toDate);
        request.setAttribute("selectedSupplier", partnerId);
        request.setAttribute("selectedStatus", status);

        request.getRequestDispatcher("report-import.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}