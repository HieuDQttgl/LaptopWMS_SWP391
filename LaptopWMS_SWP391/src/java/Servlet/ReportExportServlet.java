/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.PartnerDAO;
import DAO.TicketDAO;
import DTO.ImportReportDTO;
import Model.Partners;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "ReportExportServlet", urlPatterns = {"/report-export"})
public class ReportExportServlet extends HttpServlet {

        @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String partnerId = request.getParameter("partnerId");
        String status = request.getParameter("status");

        TicketDAO ticketDAO = new TicketDAO();
        List<ImportReportDTO> exportData = ticketDAO.getExportReport(fromDate, toDate, partnerId, status);
        
        PartnerDAO partnerDAO = new PartnerDAO();
        List<Partners> partners = partnerDAO.getCustomers(); 
        request.setAttribute("partners", partners);

        int totalTickets = exportData.size();
        int pendingCount = 0;
        for (ImportReportDTO item : exportData) {
            if ("PENDING".equalsIgnoreCase(item.getStatus())) {
                pendingCount++;
            }
        }

        request.setAttribute("exportData", exportData);
        request.setAttribute("totalTickets", totalTickets);
        request.setAttribute("pendingCount", pendingCount);
        
        request.setAttribute("selectedFrom", fromDate);
        request.setAttribute("selectedTo", toDate);
        request.setAttribute("selectedSupplier", partnerId);
        request.setAttribute("selectedStatus", status);

        request.getRequestDispatcher("report-export.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
