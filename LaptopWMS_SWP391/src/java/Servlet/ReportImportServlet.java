/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.OrderDAO;
import DAO.SupplierDAO;
import DTO.ImportReportDTO;
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
@WebServlet(name = "ReportImportServlet", urlPatterns = {"/report-import"})
public class ReportImportServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String from = request.getParameter("fromDate");
        String to = request.getParameter("toDate");
        String supplierId = request.getParameter("supplierId");
        String status = request.getParameter("status");

        OrderDAO dao = new OrderDAO();
        SupplierDAO supdao = new SupplierDAO();
        List<ImportReportDTO> reportData = dao.getImportReport(from, to, supplierId, status);

        int totalItems = 0;
        double totalValue = 0;
        int pendingCount = 0;
        for (ImportReportDTO d : reportData) {
            totalItems += d.getItems();
            totalValue += d.getValue();
            if ("Pending".equalsIgnoreCase(d.getStatus())) pendingCount++;
        }

        request.setAttribute("importData", reportData);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("totalValue", totalValue);
        request.setAttribute("pendingCount", pendingCount);
        
        request.setAttribute("suppliers", supdao.getListSuppliers()); 

        request.getRequestDispatcher("report-import.jsp").forward(request, response);
    }
}
