/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.CustomerDAO;
import DAO.OrderDAO;
import DTO.ExportReportDTO;
import java.io.IOException;
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderDAO dao = new OrderDAO();
        CustomerDAO cusdao = new CustomerDAO();
        
        String from = request.getParameter("fromDate");
        String to = request.getParameter("toDate");
        String customerId = request.getParameter("customerId");
        String status = request.getParameter("status");
        
        List<ExportReportDTO> mainData = dao.getExportReport(from, to, customerId, status);
        List<ExportReportDTO.TopProduct> topProducts = dao.getTop5Products(from, to);
        List<ExportReportDTO.StaffRevenue> staffRevenues = dao.getRevenueByStaff();

        double totalRevenue = 0;
        int completedCount = 0;
        for (ExportReportDTO d : mainData) {
            totalRevenue += d.getRevenue();
            if ("Completed".equalsIgnoreCase(d.getStatus())) {
                completedCount++;
            }
        }
        double avgValue = mainData.isEmpty() ? 0 : totalRevenue / mainData.size();

        request.setAttribute("exportData", mainData);
        request.setAttribute("topProducts", topProducts);
        request.setAttribute("staffRevenues", staffRevenues);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("completedCount", completedCount);
        request.setAttribute("avgValue", avgValue);
        request.setAttribute("customers", cusdao.getListCustomers()); 

        request.getRequestDispatcher("report-export.jsp").forward(request, response);
    }

}
