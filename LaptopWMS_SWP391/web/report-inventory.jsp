<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
        <title>Inventory Report</title>
        <style>
            :root {
                --primary: #2c3e50;
                --success: #27ae60;
                --warning: #f39c12;
                --danger: #e74c3c;
                --bg: #f4f7f6;
            }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: var(--bg);
                margin: 0;
                padding: 20px;
            }
            .container {
                max-width: 1100px;
                margin: auto;
            }

            .report-card {
                background: white;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.05);
                margin-bottom: 25px;
            }
            h2 {
                color: var(--primary);
                text-align: center;
                margin-top: 0;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            .filter-bar {
                display: flex;
                gap: 10px;
                justify-content: center;
                margin-top: 20px;
                flex-wrap: wrap;
            }
            select, button {
                padding: 10px 15px;
                border-radius: 6px;
                border: 1px solid #ddd;
                outline: none;
            }
            .btn-filter {
                background: var(--primary);
                color: white;
                border: none;
                cursor: pointer;
                font-weight: 600;
            }
            .btn-excel {
                background: #1d6f42;
                color: white;
                border: none;
            }


            .stats-row {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 20px;
                margin-bottom: 25px;
            }
            .stat-item {
                background: white;
                padding: 20px;
                border-radius: 10px;
                text-align: center;
                border-bottom: 4px solid #ccc;
            }
            .stat-item h3 {
                margin: 0;
                font-size: 14px;
                color: #7f8c8d;
            }
            .stat-item .num {
                font-size: 28px;
                font-weight: bold;
                margin-top: 5px;
                display: block;
            }
            .stat-total {
                border-color: var(--primary);
            }
            .stat-low {
                border-color: var(--warning);
                color: var(--warning);
            }
            .stat-out {
                border-color: var(--danger);
                color: var(--danger);
            }


            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border-radius: 10px;
                overflow: hidden;
            }
            th {
                background: #f8f9fa;
                padding: 15px;
                text-align: left;
                color: var(--primary);
                font-weight: 600;
                border-bottom: 2px solid #edf2f7;
            }
            td {
                padding: 15px;
                border-bottom: 1px solid #edf2f7;
            }
            .badge {
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: bold;
            }
            .badge-normal {
                background: #e6fffa;
                color: #234e52;
            }
            .badge-low {
                background: #fffaf0;
                color: #7b341e;
            }
            .badge-out {
                background: #fff5f5;
                color: #822727;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <div class="report-card">
                <h2>INVENTORY REPORT</h2>
                <form class="filter-bar" method="GET" action="report-inventory">
                    <select name="location">
                        <option value="0">Location</option>
                        <c:forEach items="${locations}" var="l">
                            <option value="${l.locationId}" ${param.location == l.locationId ? 'selected' : ''}>${l.locationName}</option>
                        </c:forEach>
                    </select>
                    <select name="brand">
                        <option value="">Brand: All</option>
                        <c:forEach items="${listBrands}" var="b">
                            <option value="${b}" ${currentBrand == b ? 'selected' : ''}>
                                ${b}
                            </option>
                        </c:forEach>
                    </select>
                    <select name="category">
                        <option value="">Category: All</option>
                        <c:forEach items="${listCategories}" var="c">
                            <option value="${c}" ${currentCat == c ? 'selected' : ''}>
                                ${c}
                            </option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="btn-filter">Filter</button>
                    <button type="submit" onclick="exportToExcel()" class="btn">Export to Excel</button>
                </form>
            </div>

            <div class="stats-row">
                <div class="stat-item stat-total">
                    <h3>Total Number of Products</h3>
                    <span class="num">${reportData.size()}</span>
                </div>
                <div class="stat-item stat-low">
                    <h3>Low Stock (≤ 5)</h3>
                    <span class="num">${lowCount}</span>
                </div>
                <div class="stat-item stat-out">
                    <h3>Out Of Stock</h3>
                    <span class="num">${outCount}</span>
                </div>
            </div>

            <div class="report-card" style="padding: 0;">
                <table id ="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Product Name</th>
                            <th>Location</th>
                            <th>Brand</th>
                            <th>Quantity</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${reportData}" var="item">
                            <tr>
                                <td>${item.id}</td>
                                <td><strong>${item.productName}</strong><br><small style="color:#999">${item.category}</small></td>
                                <td>${item.locationName}</td>
                                <td>${item.brand}</td>
                                <td>${item.stock}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.status == 'Out'}">
                                            <span class="badge badge-out">Out Of Stock</span>
                                        </c:when>
                                        <c:when test="${item.status == 'Low'}">
                                            <span class="badge badge-low">Low On Stock</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-normal">Normal</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
<script>
            function exportToExcel() {
                var table = document.getElementById("table");

                var wb = XLSX.utils.table_to_book(table, {sheet: "Inventory Report"});

                var today = new Date().toISOString().slice(0, 10);
                XLSX.writeFile(wb, 'Inventory_Report_' + today + '.xlsx');
            }
        </script>
    </body>
</html>