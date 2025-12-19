<%-- 
    Document   : report-inventory-balance
    Created on : Dec 19, 2025, 1:01:19 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
    <head>
        <title>Laptop Warehouse Management System</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                background: #f5f6fa;
                margin: 0;
                padding: 0;
            }
            .report-box {
                background: white;
                padding: 20px;
                margin: 40px auto;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            }

            .filter-bar {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
                align-items: flex-end;
            }
            .form-control {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .btn-filter {
                padding: 9px 20px;
                background: #3498db;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .btn-excel {
                padding: 9px 20px;
                background: #009933;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 14px;
                margin-top: 10px;
            }
            th {
                background: #dff0d8;
                color: #2c3e50;
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
                color: #333;
            }
            td.left-align {
                text-align: left;
            }

            .title-header {
                text-align: center;
                color: #000080;
                margin-bottom: 5px;
            }
            .date-header {
                text-align: center;
                color: #666;
                font-style: italic;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp" />

        <div class="report-box">
            <h2 class="title-header">INVENTORY BALANCE REPORT</h2>
            <div style="text-align:center; margin-bottom: 20px; color: #666;">
                From: ${startDate} &nbsp; To: ${endDate}
            </div>

            <form action="report-balance" method="get" class="filter-bar">
                <div>
                    <label>From Date:</label><br>
                    <input type="date" name="startDate" value="${startDate}" class="form-control" required>
                </div>
                <div>
                    <label>To Date:</label><br>
                    <input type="date" name="endDate" value="${endDate}" class="form-control" required>
                </div>
                <button type="submit" class="btn-filter">View Report</button>

                <button type="button" onclick="exportToExcel()" class="btn-filter btn-excel">Download Excel</button>
            </form>

            <table id="reportTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Configuration</th>
                        <th>Unit</th>
                        <th>Opening Stock</th>
                        <th>Import</th>
                        <th>Export</th>
                        <th>Closing Stock</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${reportList}">
                        <tr>
                            <td>${item.productDetailId}</td>
                            <td class="left-align">
                                <span style="font-weight: bold; color: #2c3e50;">${item.productName}</span>
                            </td>

                            <td style="font-size: 13px; color: #555;">
                                ${item.cpu} / ${item.ram}
                            </td>

                            <td>${item.unit}</td>

                            <td style="background-color: #f9f9f9;">${item.openingStock}</td>

                            <td style="color: ${item.importQuantity > 0 ? 'blue' : 'inherit'}">
                                ${item.importQuantity > 0 ? item.importQuantity : '-'}
                            </td>

                            <td style="color: ${item.exportQuantity > 0 ? 'red' : 'inherit'}">
                                ${item.exportQuantity > 0 ? item.exportQuantity : '-'}
                            </td>

                            <td style="font-weight: bold; background-color: #f0fdf4;">
                                ${item.closingStock}
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty reportList}">
                        <tr><td colspan="8">No data found for this period.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <jsp:include page="footer.jsp" />

        <script>
            function exportToExcel() {
                var table = document.getElementById("reportTable");

                var wb = XLSX.utils.table_to_book(table, {sheet: "Inventory Report"});

                var today = new Date().toISOString().slice(0, 10);
                XLSX.writeFile(wb, 'Inventory_Report_' + today + '.xlsx');
            }
        </script>
    </body>
</html>
