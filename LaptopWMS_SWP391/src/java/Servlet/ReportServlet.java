package Servlet;

import DAO.ReportDAO;
import DAO.ReportDAO.LedgerEntry;
import DAO.ReportDAO.ReportItem;
import DAO.ReportDAO.ReportSummary;
import Model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet for inventory report page
 * Supports viewing and exporting reports in CSV format
 */
@WebServlet(name = "ReportServlet", urlPatterns = { "/report-inventory" })
public class ReportServlet extends HttpServlet {

    private ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String type = request.getParameter("type");

        // If export action, generate CSV
        if ("export".equals(action)) {
            exportCSV(response, startDate, endDate, type);
            return;
        }

        if ("exportLedger".equals(action)) {
            exportLedgerCSV(response, startDate, endDate, type);
            return;
        }

        // Get report data
        List<ReportItem> inventoryReport = reportDAO.getInventoryReport(startDate, endDate, type);
        List<LedgerEntry> ledgerEntries = reportDAO.getStockLedger(startDate, endDate, type);
        ReportSummary summary = reportDAO.getSummary(startDate, endDate);

        request.setAttribute("inventoryReport", inventoryReport);
        request.setAttribute("ledgerEntries", ledgerEntries);
        request.setAttribute("summary", summary);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("type", type);

        request.getRequestDispatcher("/report-inventory.jsp").forward(request, response);
    }

    private void exportCSV(HttpServletResponse response, String startDate, String endDate, String type)
            throws IOException {

        response.setContentType("text/csv; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String filename = "inventory_report_" + new SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date())
                + ".csv";
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

        List<ReportItem> report = reportDAO.getInventoryReport(startDate, endDate, type);

        try (PrintWriter writer = response.getWriter()) {
            // BOM for UTF-8
            writer.write('\ufeff');

            // Header
            writer.println("Product Name,Configuration,Unit,Current Stock,Total Import,Total Export");

            // Data
            for (ReportItem item : report) {
                writer.println(String.format("\"%s\",\"%s\",\"%s\",%d,%d,%d",
                        escapeCSV(item.productName),
                        escapeCSV(item.config),
                        escapeCSV(item.unit != null ? item.unit : "unit"),
                        item.currentStock,
                        item.totalImport,
                        item.totalExport));
            }
        }
    }

    private void exportLedgerCSV(HttpServletResponse response, String startDate, String endDate, String type)
            throws IOException {

        response.setContentType("text/csv; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String filename = "stock_ledger_" + new SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date())
                + ".csv";
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

        List<LedgerEntry> entries = reportDAO.getStockLedger(startDate, endDate, type);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        try (PrintWriter writer = response.getWriter()) {
            // BOM for UTF-8
            writer.write('\ufeff');

            // Header
            writer.println("Date,Type,Ticket Code,Product,Configuration,Quantity,Balance After");

            // Data
            for (LedgerEntry entry : entries) {
                writer.println(String.format("\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",%d,%d",
                        entry.createdAt != null ? dateFormat.format(entry.createdAt) : "",
                        entry.type,
                        escapeCSV(entry.ticketCode),
                        escapeCSV(entry.productName),
                        escapeCSV(entry.config),
                        entry.quantityChange,
                        entry.balanceAfter));
            }
        }
    }

    private String escapeCSV(String value) {
        if (value == null)
            return "";
        return value.replace("\"", "\"\"");
    }
}
