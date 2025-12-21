<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="header.jsp" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Export Report - WMS</title>
        <style>
            :root {
                --primary: #2563eb;
                --primary-hover: #1d4ed8;
                --success: #10b981;
                --danger: #ef4444;
                --warning: #f59e0b;
                --bg: #f1f5f9;
                --card-bg: #ffffff;
                --border: #e2e8f0;
                --text: #1e293b;
                --text-muted: #64748b;
            }

            body {
                font-family: 'Segoe UI', system-ui, sans-serif;
                background: var(--bg);
                margin: 0;
                color: var(--text);
            }

            .container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 30px 20px;
            }

            .page-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 24px;
            }

            .page-header h1 {
                margin: 0;
                font-size: 28px;
                font-weight: 700;
            }

            /* Filter Section */
            .filter-card {
                background: var(--card-bg);
                border-radius: 12px;
                padding: 20px;
                margin-bottom: 24px;
                border: 1px solid var(--border);
            }

            .filter-row {
                display: flex;
                gap: 16px;
                flex-wrap: wrap;
                align-items: flex-end;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
                gap: 6px;
            }

            .filter-group label {
                font-size: 13px;
                font-weight: 600;
                color: var(--text-muted);
            }

            .filter-group input, .filter-group select {
                padding: 10px 14px;
                border: 1px solid var(--border);
                border-radius: 8px;
                font-size: 14px;
                min-width: 180px;
            }

            /* Summary Cards */
            .summary-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
                gap: 20px;
                margin-bottom: 24px;
            }

            .summary-card {
                background: var(--card-bg);
                border-radius: 12px;
                padding: 24px;
                border: 1px solid var(--border);
                text-align: center;
                border-left: 4px solid var(--primary);
            }

            .summary-card.pending {
                border-left-color: var(--warning);
            }

            .summary-card .value {
                font-size: 32px;
                font-weight: 700;
                color: var(--text);
            }

            .summary-card .label {
                font-size: 13px;
                color: var(--text-muted);
                margin-top: 4px;
                font-weight: 600;
                text-transform: uppercase;
            }

            /* Table Style */
            .table-card {
                background: var(--card-bg);
                border-radius: 12px;
                border: 1px solid var(--border);
                overflow: hidden;
            }

            .table-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 16px 20px;
                border-bottom: 1px solid var(--border);
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            thead th {
                background: #f8fafc;
                padding: 14px 16px;
                text-align: left;
                font-size: 11px;
                font-weight: 700;
                text-transform: uppercase;
                color: var(--text-muted);
                border-bottom: 1px solid var(--border);
                letter-spacing: 0.05em;
            }

            tbody td {
                padding: 14px 16px;
                font-size: 14px;
                border-bottom: 1px solid #f1f5f9;
            }

            .badge {
                display: inline-block;
                padding: 4px 10px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: 700;
                text-transform: uppercase;
            }

            .badge-completed {
                background: #dcfce7;
                color: #166534;
            }
            .badge-pending {
                background: #fef3c7;
                color: #92400e;
            }
            .badge-cancelled {
                background: #fee2e2;
                color: #991b1b;
            }

            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-primary {
                background: var(--primary);
                color: white;
            }
            .btn-success {
                background: var(--success);
                color: white;
            }
            .btn-outline {
                border: 1px solid var(--border);
                color: var(--text);
                background: white;
            }

            @media print {
                .filter-card, .btn, .page-header .btn {
                    display: none !important;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="page-header">
                <h1>Export Report</h1>
                <button class="btn btn-outline" onclick="window.print()">Print Report</button>
            </div>

            <div class="filter-card">
                <form method="GET" action="report-export">
                    <div class="filter-row">
                        <div class="filter-group">
                            <label>Start Date</label>
                            <input type="date" name="fromDate" value="${selectedFrom}" onchange="this.form.submit()">
                        </div>
                        <div class="filter-group">
                            <label>End Date</label>
                            <input type="date" name="toDate" value="${selectedTo}" onchange="this.form.submit()">
                        </div>
                        <div class="filter-group">
                            <label>Customer</label>
                            <select name="partnerId" onchange="this.form.submit()">
                                <option value="">All Customers</option>
                                <c:forEach items="${partners}" var="p">
                                    <option value="${p.partnerId}" ${selectedSupplier == p.partnerId ? 'selected' : ''}>
                                        ${p.partnerName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label>Status</label>
                            <select name="status" onchange="this.form.submit()">
                                <option value="">All Statuses</option>
                                <option value="COMPLETED" ${selectedStatus == 'COMPLETED' ? 'selected' : ''}>COMPLETED</option>
                                <option value="PENDING" ${selectedStatus == 'PENDING' ? 'selected' : ''}>PENDING</option>
                                <option value="CANCELLED" ${selectedStatus == 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
                            </select>
                        </div>
                        <a href="report-export" class="btn btn-outline">Reset Filters</a>
                    </div>
                </form>
            </div>

            <div class="summary-grid">
                <div class="summary-card">
                    <div class="value">${totalTickets}</div>
                    <div class="label">Total Export Tickets</div>
                </div>
                <div class="summary-card pending">
                    <div class="value" style="color: var(--warning)">${pendingCount}</div>
                    <div class="label">Pending Tickets</div>
                </div>
            </div>

            <div class="table-card">
                <div class="table-header">
                    <h3>Transaction Details</h3>
                    <button type="button" onclick="exportCSV()" style="background:#1d6f42; color:white; border:none; padding:8px 15px; border-radius:4px; cursor:pointer;">
                        Export CSV
                    </button>
                </div>
                <div style="overflow-x: auto;">
                    <table>
                        <thead>
                            <tr>
                                <th>Ticket Code</th>
                                <th>Processed Date</th>
                                <th>Created By</th>
                                <th>Assigned By</th>
                                <th>Customer</th>
                                <th>Status</th>
                                <th style="text-align: center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${exportData}" var="item">
                                <tr>
                                    <td><strong>${item.ticketCode}</strong></td>
                                    <td><fmt:formatDate value="${item.processedAt}" pattern="dd/MM/yyyy"/></td>
                                    <td>${item.creatorName}</td>
                                    <td>${item.confirmedBy}</td>
                                    <td>${item.partnerName}</td>
                                    <td>
                                        <span class="badge badge-${item.status.toLowerCase()}">
                                            ${item.status}
                                        </span>
                                    </td>
                                    <td style="text-align: center">
                                        <a href="ticket-detail?code=${item.ticketCode}" style="color: var(--primary); font-weight: 600; text-decoration: none;">View Detail</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty exportData}">
                                <tr>
                                    <td colspan="7" style="text-align: center; padding: 40px; color: var(--text-muted);">
                                        No transaction data found for the selected period.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp" />

        <script>
            function exportCSV() {
                const fromDate = document.querySelector('input[name="fromDate"]').value;
                const toDate = document.querySelector('input[name="toDate"]').value;
                const partnerId = document.querySelector('select[name="partnerId"]').value;
                const status = document.querySelector('select[name="status"]').value;

                const url = `report-export?action=export&fromDate=${fromDate}&toDate=${toDate}&partnerId=${partnerId}&status=${status}`;

                window.location.href = url;
            }
        </script>
    </body>
</html>