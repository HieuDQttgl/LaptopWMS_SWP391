<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Import Report | Laptop WMS</title>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <style>
                    body {
                        font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                        background: linear-gradient(135deg, #f0f4ff 0%, #f8fafc 50%, #f0fdf4 100%);
                        margin: 0;
                        padding: 0;
                        min-height: 100vh;
                    }

                    .page-container {
                        max-width: 1400px;
                        margin: 0 auto;
                        padding: 2rem;
                    }

                    .page-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 1.5rem;
                    }

                    .page-title {
                        font-size: 1.75rem;
                        font-weight: 700;
                        color: #1e293b;
                        display: flex;
                        align-items: center;
                        gap: 0.75rem;
                    }

                    .btn {
                        padding: 0.625rem 1.25rem;
                        border-radius: 0.5rem;
                        font-weight: 600;
                        font-size: 0.875rem;
                        cursor: pointer;
                        transition: all 0.2s ease;
                        text-decoration: none;
                        display: inline-flex;
                        align-items: center;
                        gap: 0.5rem;
                        border: none;
                    }

                    .btn-outline {
                        background: white;
                        color: #475569;
                        border: 1px solid #e2e8f0;
                    }

                    .btn-outline:hover {
                        background: #f1f5f9;
                    }

                    .btn-success {
                        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                        color: white;
                        box-shadow: 0 4px 14px rgba(16, 185, 129, 0.3);
                    }

                    .btn-success:hover {
                        transform: translateY(-1px);
                        box-shadow: 0 6px 18px rgba(16, 185, 129, 0.4);
                    }

                    .filter-card {
                        background: white;
                        border-radius: 1rem;
                        padding: 1.5rem;
                        margin-bottom: 1.5rem;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                        border: 1px solid #f1f5f9;
                    }

                    .filter-row {
                        display: flex;
                        gap: 1rem;
                        flex-wrap: wrap;
                        align-items: flex-end;
                    }

                    .filter-group {
                        display: flex;
                        flex-direction: column;
                        gap: 0.375rem;
                    }

                    .filter-group label {
                        font-size: 0.75rem;
                        font-weight: 600;
                        color: #64748b;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    .filter-group input,
                    .filter-group select {
                        padding: 0.625rem 0.875rem;
                        border: 2px solid #e2e8f0;
                        border-radius: 0.5rem;
                        font-size: 0.875rem;
                        min-width: 160px;
                        outline: none;
                        transition: all 0.2s ease;
                    }

                    .filter-group input:focus,
                    .filter-group select:focus {
                        border-color: #10b981;
                        box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.15);
                    }

                    .summary-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                        gap: 1.5rem;
                        margin-bottom: 1.5rem;
                    }

                    .summary-card {
                        background: white;
                        border-radius: 1rem;
                        padding: 1.5rem;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                        border: 1px solid #f1f5f9;
                        text-align: center;
                        border-left: 4px solid #10b981;
                    }

                    .summary-card.pending {
                        border-left-color: #f59e0b;
                    }

                    .summary-card .stat-value {
                        font-size: 2.5rem;
                        font-weight: 800;
                        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                    }

                    .summary-card.pending .stat-value {
                        background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                    }

                    .summary-card .stat-label {
                        font-size: 0.75rem;
                        color: #64748b;
                        margin-top: 0.25rem;
                        font-weight: 600;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    .table-card {
                        background: white;
                        border-radius: 1rem;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                        border: 1px solid #f1f5f9;
                        overflow: hidden;
                    }

                    .table-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 1rem 1.5rem;
                        border-bottom: 1px solid #f1f5f9;
                    }

                    .table-header h3 {
                        margin: 0;
                        font-size: 1rem;
                        font-weight: 600;
                        color: #1e293b;
                    }

                    table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    thead th {
                        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                        color: white;
                        padding: 1rem;
                        text-align: left;
                        font-size: 0.75rem;
                        font-weight: 700;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    tbody td {
                        padding: 1rem;
                        font-size: 0.875rem;
                        border-bottom: 1px solid #f1f5f9;
                        color: #475569;
                    }

                    tbody tr:hover td {
                        background: #f8fafc;
                    }

                    .badge {
                        display: inline-flex;
                        align-items: center;
                        padding: 0.375rem 0.75rem;
                        border-radius: 2rem;
                        font-size: 0.6875rem;
                        font-weight: 700;
                        text-transform: uppercase;
                    }

                    .badge-completed {
                        background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                        color: #16a34a;
                    }

                    .badge-pending {
                        background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
                        color: #d97706;
                    }

                    .badge-cancelled {
                        background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                        color: #dc2626;
                    }

                    .empty-state {
                        text-align: center;
                        padding: 3rem;
                        color: #94a3b8;
                    }

                    @media print {

                        .filter-card,
                        .btn,
                        .page-header .btn {
                            display: none !important;
                        }
                    }

                    @media (max-width: 768px) {
                        .page-container {
                            padding: 1rem;
                        }

                        .filter-row {
                            flex-direction: column;
                        }

                        .filter-group input,
                        .filter-group select {
                            min-width: 100%;
                        }
                    }
                </style>
            </head>

            <body>
                <jsp:include page="header.jsp" />

                <div class="page-container">
                    <div class="page-header">
                        <h1 class="page-title">📥 Import Report</h1>
                        <button class="btn btn-outline" onclick="window.print()">🖨️ Print Report</button>
                    </div>

                    <div class="filter-card">
                        <form method="GET" action="report-import">
                            <div class="filter-row">
                                <div class="filter-group">
                                    <label>Start Date</label>
                                    <input type="date" name="fromDate" value="${selectedFrom}"
                                        onchange="this.form.submit()">
                                </div>
                                <div class="filter-group">
                                    <label>End Date</label>
                                    <input type="date" name="toDate" value="${selectedTo}"
                                        onchange="this.form.submit()">
                                </div>
                                <div class="filter-group">
                                    <label>Supplier</label>
                                    <select name="partnerId" onchange="this.form.submit()">
                                        <option value="">All Suppliers</option>
                                        <c:forEach items="${partners}" var="p">
                                            <option value="${p.partnerId}" ${selectedSupplier==p.partnerId ? 'selected'
                                                : '' }>${p.partnerName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="filter-group">
                                    <label>Status</label>
                                    <select name="status" onchange="this.form.submit()">
                                        <option value="">All Statuses</option>
                                        <option value="COMPLETED" ${selectedStatus=='COMPLETED' ? 'selected' : '' }>
                                            Completed</option>
                                        <option value="PENDING" ${selectedStatus=='PENDING' ? 'selected' : '' }>Pending
                                        </option>
                                        <option value="CANCELLED" ${selectedStatus=='CANCELLED' ? 'selected' : '' }>
                                            Cancelled</option>
                                    </select>
                                </div>
                                <a href="report-import" class="btn btn-outline">↺ Reset</a>
                            </div>
                        </form>
                    </div>

                    <div class="summary-grid">
                        <div class="summary-card">
                            <div class="stat-value">${totalTickets}</div>
                            <div class="stat-label">Total Import Tickets</div>
                        </div>
                        <div class="summary-card pending">
                            <div class="stat-value">${pendingCount}</div>
                            <div class="stat-label">Pending Tickets</div>
                        </div>
                    </div>

                    <div class="table-card">
                        <div class="table-header">
                            <h3>Transaction Details</h3>
                            <button type="button" onclick="exportCSV()" class="btn btn-success">📥 Export CSV</button>
                        </div>
                        <div style="overflow-x: auto;">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Ticket Code</th>
                                        <th>Processed Date</th>
                                        <th>Created By</th>
                                        <th>Assigned By</th>
                                        <th>Supplier</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${importData}" var="item">
                                        <tr>
                                            <td><strong>${item.ticketCode}</strong></td>
                                            <td>
                                                <fmt:formatDate value="${item.processedAt}" pattern="dd/MM/yyyy" />
                                            </td>
                                            <td>${item.creatorName}</td>
                                            <td>${item.confirmedBy}</td>
                                            <td>${item.partnerName}</td>
                                            <td><span
                                                    class="badge badge-${item.status.toLowerCase()}">${item.status}</span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty importData}">
                                        <tr>
                                            <td colspan="6" class="empty-state">No transaction data found for the
                                                selected period.</td>
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
                        window.location.href = `report-import?action=export&fromDate=${fromDate}&toDate=${toDate}&partnerId=${partnerId}&status=${status}`;
                    }
                </script>
            </body>

            </html>