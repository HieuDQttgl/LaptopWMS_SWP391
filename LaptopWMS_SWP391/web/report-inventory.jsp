<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ page import="java.util.*" %>
        <%@ page import="java.text.SimpleDateFormat" %>
            <%@ page import="DAO.ReportDAO.ReportItem" %>
                <%@ page import="DAO.ReportDAO.LedgerEntry" %>
                    <%@ page import="DAO.ReportDAO.ReportSummary" %>
                        <%@ page import="Model.Users" %>
                            <!DOCTYPE html>
                            <html>

                            <head>
                                <meta charset="UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>Inventory Report | Laptop WMS</title>
                                <link
                                    href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
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

                                    .btn-primary {
                                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                        color: white;
                                        box-shadow: 0 4px 14px rgba(102, 126, 234, 0.3);
                                    }

                                    .btn-primary:hover {
                                        transform: translateY(-1px);
                                        box-shadow: 0 6px 18px rgba(102, 126, 234, 0.4);
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
                                        min-width: 140px;
                                        outline: none;
                                        transition: all 0.2s ease;
                                    }

                                    .filter-group input:focus,
                                    .filter-group select:focus {
                                        border-color: #667eea;
                                        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                                    }

                                    .summary-grid {
                                        display: grid;
                                        grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                                        gap: 1.25rem;
                                        margin-bottom: 1.5rem;
                                    }

                                    .summary-card {
                                        background: white;
                                        border-radius: 1rem;
                                        padding: 1.5rem;
                                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                                        border: 1px solid #f1f5f9;
                                        text-align: center;
                                    }

                                    .summary-card .icon {
                                        font-size: 2rem;
                                        margin-bottom: 0.5rem;
                                    }

                                    .summary-card .stat-value {
                                        font-size: 2rem;
                                        font-weight: 800;
                                    }

                                    .summary-card .stat-label {
                                        font-size: 0.6875rem;
                                        color: #64748b;
                                        margin-top: 0.25rem;
                                        font-weight: 600;
                                        text-transform: uppercase;
                                        letter-spacing: 0.5px;
                                    }

                                    .summary-card.import {
                                        border-left: 4px solid #10b981;
                                    }

                                    .summary-card.import .stat-value {
                                        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                                        -webkit-background-clip: text;
                                        -webkit-text-fill-color: transparent;
                                        background-clip: text;
                                    }

                                    .summary-card.export {
                                        border-left: 4px solid #ef4444;
                                    }

                                    .summary-card.export .stat-value {
                                        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                                        -webkit-background-clip: text;
                                        -webkit-text-fill-color: transparent;
                                        background-clip: text;
                                    }

                                    .summary-card.stock {
                                        border-left: 4px solid #667eea;
                                    }

                                    .summary-card.stock .stat-value {
                                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                        -webkit-background-clip: text;
                                        -webkit-text-fill-color: transparent;
                                        background-clip: text;
                                    }

                                    .summary-card.transactions {
                                        border-left: 4px solid #f59e0b;
                                    }

                                    .summary-card.transactions .stat-value {
                                        background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
                                        -webkit-background-clip: text;
                                        -webkit-text-fill-color: transparent;
                                        background-clip: text;
                                    }

                                    .tabs {
                                        display: flex;
                                        gap: 0.25rem;
                                        margin-bottom: 1.5rem;
                                        background: white;
                                        padding: 0.375rem;
                                        border-radius: 0.75rem;
                                        width: fit-content;
                                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                                    }

                                    .tab {
                                        padding: 0.75rem 1.5rem;
                                        border: none;
                                        background: transparent;
                                        border-radius: 0.5rem;
                                        font-size: 0.875rem;
                                        font-weight: 600;
                                        cursor: pointer;
                                        color: #64748b;
                                        transition: all 0.2s ease;
                                    }

                                    .tab.active {
                                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                        color: white;
                                    }

                                    .tab:hover:not(.active) {
                                        color: #1e293b;
                                        background: #f8fafc;
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
                                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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

                                    .text-right {
                                        text-align: right;
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

                                    .badge-import {
                                        background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                                        color: #16a34a;
                                    }

                                    .badge-export {
                                        background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                                        color: #dc2626;
                                    }

                                    .tab-panel {
                                        display: none;
                                    }

                                    .tab-panel.active {
                                        display: block;
                                    }

                                    .empty-state {
                                        text-align: center;
                                        padding: 3rem;
                                        color: #94a3b8;
                                    }

                                    .empty-state .icon {
                                        font-size: 3rem;
                                        margin-bottom: 1rem;
                                    }

                                    @media print {

                                        .filter-card,
                                        .btn,
                                        .page-header .btn,
                                        .tabs {
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

                                        .tabs {
                                            width: 100%;
                                        }

                                        .tab {
                                            flex: 1;
                                            text-align: center;
                                        }
                                    }
                                </style>
                            </head>

                            <body>
                                <jsp:include page="header.jsp" />

                                <% Users currentUser=(Users) session.getAttribute("currentUser"); List<ReportItem>
                                    inventoryReport = (List<ReportItem>) request.getAttribute("inventoryReport");
                                        List<LedgerEntry> ledgerEntries = (List<LedgerEntry>)
                                                request.getAttribute("ledgerEntries");
                                                ReportSummary summary = (ReportSummary) request.getAttribute("summary");
                                                String startDate = (String) request.getAttribute("startDate");
                                                String endDate = (String) request.getAttribute("endDate");
                                                String type = (String) request.getAttribute("type");
                                                if (inventoryReport == null) inventoryReport = new ArrayList<>();
                                                    if (ledgerEntries == null) ledgerEntries = new ArrayList<>();
                                                        if (summary == null) summary = new ReportSummary();
                                                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                                                        %>

                                                        <div class="page-container">
                                                            <div class="page-header">
                                                                <h1 class="page-title">📊 Inventory Report</h1>
                                                                <button class="btn btn-outline"
                                                                    onclick="window.print()">🖨️ Print Report</button>
                                                            </div>

                                                            <div class="filter-card">
                                                                <form method="get" action="report-inventory">
                                                                    <div class="filter-row">
                                                                        <div class="filter-group">
                                                                            <label>From Date</label>
                                                                            <input type="date" name="startDate"
                                                                                value="<%= startDate != null ? startDate : "" %>">
                                                                        </div>
                                                                        <div class="filter-group">
                                                                            <label>To Date</label>
                                                                            <input type="date" name="endDate"
                                                                                value="<%= endDate != null ? endDate : "" %>">
                                                                        </div>
                                                                        <div class="filter-group">
                                                                            <label>Type</label>
                                                                            <select name="type">
                                                                                <option value="all" <%="all"
                                                                                    .equals(type) || type==null
                                                                                    ? "selected" : "" %>>All</option>
                                                                                <option value="IMPORT" <%="IMPORT"
                                                                                    .equals(type) ? "selected" : "" %>
                                                                                    >Import</option>
                                                                                <option value="EXPORT" <%="EXPORT"
                                                                                    .equals(type) ? "selected" : "" %>
                                                                                    >Export</option>
                                                                            </select>
                                                                        </div>
                                                                        <button type="submit" class="btn btn-primary">🔍
                                                                            Filter</button>
                                                                        <a href="report-inventory"
                                                                            class="btn btn-outline">↺ Reset</a>
                                                                    </div>
                                                                </form>
                                                            </div>

                                                            <div class="summary-grid">
                                                                <div class="summary-card import">
                                                                    <div class="icon">📥</div>
                                                                    <div class="stat-value">
                                                                        <%= summary.totalImport %>
                                                                    </div>
                                                                    <div class="stat-label">Total Import</div>
                                                                </div>
                                                                <div class="summary-card export">
                                                                    <div class="icon">📤</div>
                                                                    <div class="stat-value">
                                                                        <%= summary.totalExport %>
                                                                    </div>
                                                                    <div class="stat-label">Total Export</div>
                                                                </div>
                                                                <div class="summary-card stock">
                                                                    <div class="icon">📦</div>
                                                                    <div class="stat-value">
                                                                        <%= summary.totalStock %>
                                                                    </div>
                                                                    <div class="stat-label">Current Stock</div>
                                                                </div>
                                                                <div class="summary-card transactions">
                                                                    <div class="icon">📋</div>
                                                                    <div class="stat-value">
                                                                        <%= summary.totalTransactions %>
                                                                    </div>
                                                                    <div class="stat-label">Transactions</div>
                                                                </div>
                                                            </div>

                                                            <div class="tabs">
                                                                <button class="tab active"
                                                                    onclick="showTab('inventory')">📊 Stock by
                                                                    Product</button>
                                                                <button class="tab" onclick="showTab('ledger')">📜
                                                                    Transaction Details</button>
                                                            </div>

                                                            <div id="tab-inventory" class="tab-panel active">
                                                                <div class="table-card">
                                                                    <div class="table-header">
                                                                        <h3>Inventory Report</h3>
                                                                        <a href="report-inventory?action=export&startDate=<%= startDate != null ? startDate : "" %>&endDate=<%= endDate != null ? endDate : "" %>&type=<%= type != null ? type : "all" %>" class="btn btn-success">📥 Download
                                                                            CSV</a>
                                                                    </div>
                                                                    <div style="overflow-x: auto;">
                                                                        <% if (inventoryReport.isEmpty()) { %>
                                                                            <div class="empty-state">
                                                                                <div class="icon">📭</div>
                                                                                <p>No data found for the selected period
                                                                                </p>
                                                                            </div>
                                                                            <% } else { %>
                                                                                <table>
                                                                                    <thead>
                                                                                        <tr>
                                                                                            <th>Product</th>
                                                                                            <th>Configuration</th>
                                                                                            <th>Unit</th>
                                                                                            <th class="text-right">
                                                                                                Import</th>
                                                                                            <th class="text-right">
                                                                                                Export</th>
                                                                                            <th class="text-right">Stock
                                                                                            </th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <% for (ReportItem item : inventoryReport) { %>
                                                                                            <tr>
                                                                                                <td><strong>
                                                                                                        <%= item.productName
                                                                                                            %>
                                                                                                    </strong></td>
                                                                                                <td>
                                                                                                    <%= item.config %>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <%= item.unit !=null
                                                                                                        ? item.unit
                                                                                                        : "unit" %>
                                                                                                </td>
                                                                                                <td class="text-right"
                                                                                                    style="color: #16a34a; font-weight: 600;">
                                                                                                    +<%= item.totalImport
                                                                                                        %>
                                                                                                </td>
                                                                                                <td class="text-right"
                                                                                                    style="color: #dc2626; font-weight: 600;">
                                                                                                    -<%= item.totalExport
                                                                                                        %>
                                                                                                </td>
                                                                                                <td class="text-right"
                                                                                                    style="font-weight: 700;">
                                                                                                    <%= item.currentStock
                                                                                                        %>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <% } %>
                                                                                    </tbody>
                                                                                </table>
                                                                                <% } %>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div id="tab-ledger" class="tab-panel">
                                                                <div class="table-card">
                                                                    <div class="table-header">
                                                                        <h3>Transaction Ledger</h3>
                                                                        <a href="report-inventory?action=exportLedger&startDate=<%= startDate != null ? startDate : "" %>&endDate=<%= endDate != null ? endDate : "" %>&type=<%= type != null ? type : "all" %>" class="btn btn-success">📥 Download
                                                                            CSV</a>
                                                                    </div>
                                                                    <div style="overflow-x: auto;">
                                                                        <% if (ledgerEntries.isEmpty()) { %>
                                                                            <div class="empty-state">
                                                                                <div class="icon">📭</div>
                                                                                <p>No transactions found for the
                                                                                    selected period</p>
                                                                            </div>
                                                                            <% } else { %>
                                                                                <table>
                                                                                    <thead>
                                                                                        <tr>
                                                                                            <th>Timestamp</th>
                                                                                            <th>Type</th>
                                                                                            <th>Ticket Code</th>
                                                                                            <th>Product</th>
                                                                                            <th>Configuration</th>
                                                                                            <th class="text-right">
                                                                                                Quantity</th>
                                                                                            <th class="text-right">
                                                                                                Balance After</th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <% for (LedgerEntry entry :
                                                                                            ledgerEntries) { %>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <%= entry.createdAt
                                                                                                        !=null ?
                                                                                                        dateFormat.format(entry.createdAt)
                                                                                                        : "" %>
                                                                                                </td>
                                                                                                <td><span
                                                                                                        class="badge badge-<%= entry.type.toLowerCase() %>">
                                                                                                        <%= "IMPORT"
                                                                                                            .equals(entry.type)
                                                                                                            ? "Import"
                                                                                                            : "Export"
                                                                                                            %>
                                                                                                    </span></td>
                                                                                                <td>
                                                                                                    <%= entry.ticketCode
                                                                                                        %>
                                                                                                </td>
                                                                                                <td><strong>
                                                                                                        <%= entry.productName
                                                                                                            %>
                                                                                                    </strong></td>
                                                                                                <td>
                                                                                                    <%= entry.config %>
                                                                                                </td>
                                                                                                <td class="text-right"
                                                                                                    style="font-weight: 600; color: <%= "IMPORT".equals(entry.type)
                                                                                                    ? "#16a34a"
                                                                                                    : "#dc2626" %>;">
                                                                                                    <%= "IMPORT"
                                                                                                        .equals(entry.type)
                                                                                                        ? "+" : "-" %>
                                                                                                        <%= entry.quantityChange
                                                                                                            %>
                                                                                                </td>
                                                                                                <td class="text-right"
                                                                                                    style="font-weight: 700;">
                                                                                                    <%= entry.balanceAfter
                                                                                                        %>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <% } %>
                                                                                    </tbody>
                                                                                </table>
                                                                                <% } %>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <jsp:include page="footer.jsp" />

                                                        <script>
                                                            function showTab(tabName) {
                                                                document.querySelectorAll('.tab-panel').forEach(panel => panel.classList.remove('active'));
                                                                document.querySelectorAll('.tab').forEach(tab => tab.classList.remove('active'));
                                                                document.getElementById('tab-' + tabName).classList.add('active');
                                                                event.target.classList.add('active');
                                                            }
                                                        </script>
                            </body>

                            </html>