<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>Import Report</title>
        <style>
            :root {
                --primary: #2c3e50;
                --success: #27ae60;
                --warning: #f39c12;
                --danger: #e74c3c;
                --bg: #f4f7f6;
            }
            body {
                font-family: 'Segoe UI', sans-serif;
                background: var(--bg);
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 1100px;
                margin: 40px auto;
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
            }
            .filter-bar {
                display: flex;
                gap: 10px;
                justify-content: center;
                flex-wrap: wrap;
                margin-top: 20px;
            }
            .stats-row {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 15px;
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

            .stat-orders {
                border-bottom-color: var(--primary) !important;
            }
            .stat-items  {
                border-bottom-color: #3498db !important;
            }
            .stat-value  {
                border-bottom-color: var(--success) !important;
            }
            .stat-pending {
                border-bottom-color: var(--danger) !important;
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
            .badge-comp {
                background: #e6fffa;
                color: #234e52;
            }
            .badge-pend {
                background: #fff5f5;
                color: #822727;
            }
        </style>
    </head>
    <body>
        
        <jsp:include page="header.jsp" />
        
        <div class="container">
            <div class="report-card">
                <h2>Import Report</h2>
                <form class="filter-bar" method="GET" action="report-import" id="filterForm">
                    <input type="date" name="fromDate" value="${param.fromDate}" onchange="this.form.submit()">
                    <input type="date" name="toDate" value="${param.toDate}" onchange="this.form.submit()">

                    <select name="supplierId" onchange="this.form.submit()">
                        <option value="">Supplier: All</option>
                        <c:forEach items="${suppliers}" var="s">
                            <option value="${s.supplierId}" ${param.supplierId == s.supplierId ? 'selected' : ''}>
                                ${s.supplierName}
                            </option>
                        </c:forEach>
                    </select>

                    <select name="status" onchange="this.form.submit()">
                        <option value="">Status: All</option>
                        <option value="Completed" ${param.status == 'Completed' ? 'selected' : ''}>Completed</option>
                        <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending</option>
                    </select>

                    <button type="button" onclick="exportToExcel()" style="background:#1d6f42; color:white; border:none; padding:10px 20px; border-radius:6px; cursor:pointer;">Excel</button>
                </form>
            </div>

            <div class="stats-row">
                <div class="stat-item stat-orders">
                    <h3>Orders</h3>
                    <span class="num">${importData.size()}</span>
                </div>

                <div class="stat-item stat-items">
                    <h3>Items</h3>
                    <span class="num">${totalItems}</span>
                </div>

                <div class="stat-item stat-value">
                    <h3>Value</h3>
                    <span class="num" style="color:var(--success)">
                        <fmt:formatNumber value="${totalValue}" type="currency" currencySymbol="$"/>
                    </span>
                </div>

                <div class="stat-item stat-pending">
                    <h3>Pending</h3>
                    <span class="num" style="color:var(--danger)">${pendingCount}</span>
                </div>
            </div>

            <div class="report-card" style="padding: 0;">
                <table>
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Date</th>
                            <th>Supplier</th>
                            <th>Items</th>
                            <th>Value</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${importData}" var="item">
                            <tr>
                                <td><strong>${item.orderCode}</strong></td>
                                <td><fmt:formatDate value="${item.createdAt}" pattern="dd/MM/yyyy"/></td>
                                <td>${item.supplierName}</td>
                                <td>${item.items}</td>
                                <td><strong><fmt:formatNumber value="${item.value}" type="currency" currencySymbol="$"/></strong></td>
                                <td>
                                    <span class="badge ${item.status == 'Completed' ? 'badge-comp' : 'badge-pend'}">
                                        ${item.status == 'Completed' ? 'Completed' : 'Pending'}
                                    </span>
                                </td>
                                <td><a href="detail?code=${item.orderCode}" style="text-decoration:none; color:#3498db;"> View </a> </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <script>
            document.getElementById('filterForm').onsubmit = function () {
                document.querySelector('table').style.opacity = '0.5';
            };

            function exportToExcel() {
                const form = document.getElementById('filterForm');
                const params = new URLSearchParams(new FormData(form)).toString();
                window.location.href = 'report-import-export?' + params;
            }
        </script>
        
        <jsp:include page="footer.jsp" />
        
    </body>
</html>