package Servlet;

import DAO.PartnerDAO;
import DAO.TicketDAO;
import DTO.ImportReportDTO;
import Model.Partners;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
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
        String action = request.getParameter("action");

        TicketDAO ticketDAO = new TicketDAO();
        List<ImportReportDTO> importData = ticketDAO.getImportReport(fromDate, toDate, partnerId, status);

        if ("export".equals(action)) {
            exportImportCSV(response, importData);
            return;
        }

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

    private void exportImportCSV(HttpServletResponse response, List<ImportReportDTO> data) throws IOException {
        response.setContentType("text/csv; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String filename = "import_report_" + timeStamp + ".csv";
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        try (PrintWriter writer = response.getWriter()) {
            writer.write('\ufeff');

            writer.println("Ticket Code,Processed At,Creator,Confirmed By,Supplier,Status");

            for (ImportReportDTO item : data) {
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
