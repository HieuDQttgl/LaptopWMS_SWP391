<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>Laptop Warehouse Management System</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
        <style>
            :root {
                --primary: #2c3e50;
                --success: #27ae60;
                --warning: #f39c12;
                --danger: #e74c3c;
                --info: #3498db;
                --bg: #f4f7f6;
            }
            body {
                font-family: 'Segoe UI', sans-serif;
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
            }

            .filter-bar {
                display: flex;
                gap: 10px;
                justify-content: center;
                flex-wrap: wrap;
                margin-top: 20px;
            }
            .filter-bar input, .filter-bar select {
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
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
            .stat-revenue {
                border-bottom-color: var(--success) !important;
            }
            .stat-completed {
                border-bottom-color: var(--info) !important;
            }
            .stat-avg {
                border-bottom-color: var(--warning) !important;
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
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: bold;
                text-transform: uppercase;
                display: inline-block;
            }

            .badge-completed {
                background: #e6fffa;
                color: #234e52;
            }

            .badge-pending {
                background: #ebf8ff;
                color: #2c5282;
            }

            .badge-approved {
                background: #faf5ff;
                color: #553c9a;
            }

            .badge-shipping {
                background: #fffaf0;
                color: #9c4221;
            }

            .badge-cancelled {
                background: #fff5f5;
                color: #c53030;
            }

            .badge-other {
                background: #f7fafc;
                color: #4a5568;
            }

            .btn-action {
                text-decoration: none;
                color: var(--info);
                font-weight: bold;
                font-size: 13px;
            }

            .summary-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                margin-top: 25px;
            }
            .summary-box {
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            }
            .summary-box h3 {
                border-bottom: 2px solid #eee;
                padding-bottom: 10px;
                margin-bottom: 15px;
                font-size: 16px;
                color: var(--primary);
            }
            .summary-item {
                display: flex;
                justify-content: space-between;
                padding: 10px 0;
                border-bottom: 1px dashed #eee;
                font-size: 14px;
            }
            .summary-item:last-child {
                border-bottom: none;
            }
            .summary-val {
                font-weight: bold;
                color: var(--primary);
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp" />

        <div class="container">
            <div class="report-card">
                <h2>Export Report</h2>
                <form class="filter-bar" method="GET" action="report-export" id="filterForm">
                    <input type="date" name="fromDate" value="${param.fromDate}" onchange="this.form.submit()">
                    <input type="date" name="toDate" value="${param.toDate}" onchange="this.form.submit()">

                    <select name="customerId" onchange="this.form.submit()">
                        <option value="">Customer: All</option>
                        <c:forEach items="${customers}" var="c">
                            <option value="${c.customerId}" ${param.customerId == c.customerId ? 'selected' : ''}>${c.customerName}</option>
                        </c:forEach>
                    </select>

                    <select name="status" onchange="this.form.submit()">
                        <option value="">Status: All</option>
                        <option value="Completed" ${param.status == 'Completed' ? 'selected' : ''}>Completed</option>
                        <option value="Pending" ${param.status == 'Approved' ? 'selected' : ''}>Pending</option>
                        <option value="Pending" ${param.status == 'Cancelled' ? 'selected' : ''}>Pending</option>
                        <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending</option>
                        <option value="Shipping" ${param.status == 'Shipping' ? 'selected' : ''}>Shipping</option>
                    </select>

                    <button type="button" style="background:#1d6f42; color:white; border:none; padding:8px 15px; border-radius:4px; cursor:pointer;">Excel</button>
                </form>
            </div>

            <div class="stats-row">
                <div class="stat-item stat-orders">
                    <h3>Orders</h3>
                    <span class="num">${exportData.size()}</span>
                </div>
                <div class="stat-item stat-revenue">
                    <h3>Revenue</h3>
                    <span class="num" style="color:var(--success)">
                        <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="$"/>
                    </span>
                </div>
                <div class="stat-item stat-completed">
                    <h3>Completed</h3>
                    <span class="num" style="color:var(--info)">${completedCount}</span>
                </div>
                <div class="stat-item stat-avg">
                    <h3>Avg Value</h3>
                    <span class="num">
                        <fmt:formatNumber value="${avgValue}" type="currency" currencySymbol="$"/>
                    </span>
                </div>
            </div>

            <div class="report-card" style="padding: 0;">
                <table>
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Date</th>
                            <th>Customer</th>
                            <th>Sale</th>
                            <th>Revenue</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${exportData}" var="item">
                            <tr>
                                <td><strong>${item.orderCode}</strong></td>
                                <td><fmt:formatDate value="${item.createdAt}" pattern="dd/MM/yyyy"/></td>
                                <td>${item.customerName}</td>
                                <td>${item.saleName}</td>
                                <td><strong><fmt:formatNumber value="${item.revenue}" type="currency" currencySymbol="$"/></strong></td>
                                <td>
                                    <c:set var="status" value="${item.status.toLowerCase()}" />
                                    <c:choose>
                                        <c:when test="${status == 'completed'}">
                                            <c:set var="cls" value="badge-completed" />
                                        </c:when>
                                        <c:when test="${status == 'pending'}">
                                            <c:set var="cls" value="badge-pending" />
                                        </c:when>
                                        <c:when test="${status == 'approved'}">
                                            <c:set var="cls" value="badge-approved" />
                                        </c:when>
                                        <c:when test="${status == 'shipping'}">
                                            <c:set var="cls" value="badge-shipping" />
                                        </c:when>
                                        <c:when test="${status == 'cancelled'}">
                                            <c:set var="cls" value="badge-cancelled" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="cls" value="badge-other" />
                                        </c:otherwise>
                                    </c:choose>

                                    <span class="badge ${cls}">
                                        ${item.status}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="summary-grid">
                <div class="summary-box">
                    <h3>TOP 5 PRODUCT</h3>
                    <c:forEach items="${topProducts}" var="p">
                        <div class="summary-item">
                            <span>${p.productName}</span>
                            <span class="summary-val">${p.totalQuantity} order(s)</span>
                        </div>
                    </c:forEach>
                </div>

                <div class="summary-box">
                    <h3>SALE STAFF REVENUE</h3>
                    <c:forEach items="${staffRevenues}" var="s">
                        <div class="summary-item">
                            <span>${s.staffName}</span>
                            <span class="summary-val">
                                <fmt:formatNumber value="${s.totalRevenue}" type="currency" currencySymbol="$"/>
                            </span>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />

        <script>
            function exportToExcel() {
                var table = document.getElementById("reportTable");

                var wb = XLSX.utils.table_to_book(table, {sheet: "Export Report"});

                var today = new Date().toISOString().slice(0, 10);
                XLSX.writeFile(wb, 'Export_Report_' + today + '.xlsx');
            }
        </script>
    </body>
</html>