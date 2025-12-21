/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.PartnerDAO;
import DAO.TicketDAO;
import DTO.ExportReportDTO;
import Model.Partners;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
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
        String action = request.getParameter("action");

        TicketDAO ticketDAO = new TicketDAO();
        List<ExportReportDTO> exportData = ticketDAO.getExportReport(fromDate, toDate, partnerId, status);
        
        if ("export".equals(action)) {
            exportExportCSV(response, exportData);
            return;
        }
        
        PartnerDAO partnerDAO = new PartnerDAO();
        List<Partners> partners = partnerDAO.getCustomers(); 
        request.setAttribute("partners", partners);

        int totalTickets = exportData.size();
        int pendingCount = 0;
        for (ExportReportDTO item : exportData) {
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
    
    private void exportExportCSV(HttpServletResponse response, List<ExportReportDTO> data) throws IOException {
        response.setContentType("text/csv; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String filename = "export_report_" + timeStamp + ".csv";
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        try (PrintWriter writer = response.getWriter()) {
            writer.write('\ufeff');

            writer.println("Ticket Code,Processed At,Creator,Confirmed By,Supplier,Status");

            for (ExportReportDTO item : data) {
                writer.println(String.format("\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"",
                        escapeCSV(item.getTicketCode()),
                        item.getProcessedAt() != null ? dateFormat.format(item.getProcessedAt()) : "",
                        escapeCSV(item.getCreatorName()),
                        escapeCSV(item.getConfirmedBy()),
                        escapeCSV(item.getPartnerName()),
                        escapeCSV(item.getStatus())
                ));
            }
        }
    }

    private String escapeCSV(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\"", "\"\"");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
