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
        <jsp:include page="header.jsp" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inventory Report - Laptop WMS</title>
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

            * {
                box-sizing: border-box;
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
                color: var(--text);
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

            .filter-group input,
            .filter-group select {
                padding: 10px 14px;
                border: 1px solid var(--border);
                border-radius: 8px;
                font-size: 14px;
                min-width: 160px;
            }

            .filter-group input:focus,
            .filter-group select:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            }

            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                transition: all 0.15s;
                text-decoration: none;
            }

            .btn-primary {
                background: var(--primary);
                color: white;
            }

            .btn-primary:hover {
                background: var(--primary-hover);
            }

            .btn-success {
                background: var(--success);
                color: white;
            }

            .btn-success:hover {
                background: #059669;
            }

            .btn-outline {
                background: white;
                color: var(--text);
                border: 1px solid var(--border);
            }

            .btn-outline:hover {
                background: var(--bg);
            }

            /* Summary Cards */
            .summary-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 24px;
            }

            .summary-card {
                background: var(--card-bg);
                border-radius: 12px;
                padding: 24px;
                border: 1px solid var(--border);
                text-align: center;
            }

            .summary-card .icon {
                font-size: 32px;
                margin-bottom: 8px;
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
            }

            .summary-card.import {
                border-left: 4px solid var(--success);
            }

            .summary-card.export {
                border-left: 4px solid var(--danger);
            }

            .summary-card.stock {
                border-left: 4px solid var(--primary);
            }

            .summary-card.transactions {
                border-left: 4px solid var(--warning);
            }

            /* Tabs */
            .tabs {
                display: flex;
                gap: 4px;
                margin-bottom: 20px;
                background: var(--bg);
                padding: 4px;
                border-radius: 10px;
                width: fit-content;
            }

            .tab {
                padding: 10px 20px;
                border: none;
                background: transparent;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                color: var(--text-muted);
                transition: all 0.15s;
            }

            .tab.active {
                background: white;
                color: var(--text);
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }

            .tab:hover:not(.active) {
                color: var(--text);
            }

            /* Table */
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

            .table-header h3 {
                margin: 0;
                font-size: 16px;
                font-weight: 600;
            }

            .table-container {
                overflow-x: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            thead th {
                background: #f8fafc;
                padding: 14px 16px;
                text-align: left;
                font-size: 12px;
                font-weight: 700;
                text-transform: uppercase;
                color: var(--text-muted);
                border-bottom: 1px solid var(--border);
            }

            tbody td {
                padding: 14px 16px;
                font-size: 14px;
                border-bottom: 1px solid #f1f5f9;
            }

            tbody tr:hover {
                background: #f8fafc;
            }

            tbody tr:last-child td {
                border-bottom: none;
            }

            .badge {
                display: inline-block;
                padding: 4px 10px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
            }

            .badge-import {
                background: #dcfce7;
                color: #166534;
            }

            .badge-export {
                background: #fee2e2;
                color: #991b1b;
            }

            .text-right {
                text-align: right;
            }

            .text-center {
                text-align: center;
            }

            .tab-panel {
                display: none;
            }

            .tab-panel.active {
                display: block;
            }

            .empty-state {
                text-align: center;
                padding: 60px 20px;
                color: var(--text-muted);
            }

            .empty-state .icon {
                font-size: 48px;
                margin-bottom: 16px;
            }

            @media print {

                .filter-card,
                .page-header .btn,
                .table-header .btn {
                    display: none !important;
                }
            }
        </style>
    </head>

    <body>
        <% Users currentUser = (Users) session.getAttribute("currentUser");
            List<ReportItem> inventoryReport = (List<ReportItem>) request.getAttribute("inventoryReport");
            List<LedgerEntry> ledgerEntries = (List<LedgerEntry>) request.getAttribute("ledgerEntries");
            ReportSummary summary = (ReportSummary) request.getAttribute("summary");

            String startDate = (String) request.getAttribute("startDate");
            String endDate = (String) request.getAttribute("endDate");
            String type = (String) request.getAttribute("type");

            if (inventoryReport == null) {
                inventoryReport = new ArrayList<>();
            }
            if (ledgerEntries == null) {
                ledgerEntries = new ArrayList<>();
            }
            if (summary == null) {
                summary = new ReportSummary();
            }

            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        %>

        <div class="container">
            <div class="page-header">
                <h1>📊 Báo Cáo Xuất Nhập Tồn</h1>
                <button class="btn btn-outline"
                        onclick="window.print()">
                    🖨️ In Báo Cáo
                </button>
            </div>

            <!-- Filters -->
            <div class="filter-card">
                <form method="get" action="report-inventory">
                    <div class="filter-row">
                        <div class="filter-group">
                            <label>Từ Ngày</label>
                            <input type="date" name="startDate"
                                   value="<%= startDate != null ? startDate : ""%>">
                        </div>
                        <div class="filter-group">
                            <label>Đến Ngày</label>
                            <input type="date" name="endDate"
                                   value="<%= endDate != null ? endDate : ""%>">
                        </div>
                        <div class="filter-group">
                            <label>Loại</label>
                            <select name="type">
                                <option value="all" <%="all"
                                        .equals(type) || type == null
                                        ? "selected" : ""%>>Tất cả</option>
                                <option value="IMPORT" <%="IMPORT"
                                        .equals(type) ? "selected" : ""%>
                                        >Nhập kho</option>
                                <option value="EXPORT" <%="EXPORT"
                                        .equals(type) ? "selected" : ""%>
                                        >Xuất kho</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">
                            🔍 Lọc Báo Cáo
                        </button>
                        <a href="report-inventory"
                           class="btn btn-outline">
                            ↺ Đặt Lại
                        </a>
                    </div>
                </form>
            </div>

            <!-- Summary Cards -->
            <div class="summary-grid">
                <div class="summary-card import">
                    <div class="icon">📥</div>
                    <div class="value">
                        <%= summary.totalImport%>
                    </div>
                    <div class="label">Tổng Nhập Kho</div>
                </div>
                <div class="summary-card export">
                    <div class="icon">📤</div>
                    <div class="value">
                        <%= summary.totalExport%>
                    </div>
                    <div class="label">Tổng Xuất Kho</div>
                </div>
                <div class="summary-card stock">
                    <div class="icon">📦</div>
                    <div class="value">
                        <%= summary.totalStock%>
                    </div>
                    <div class="label">Tồn Kho Hiện Tại</div>
                </div>
                <div class="summary-card transactions">
                    <div class="icon">📋</div>
                    <div class="value">
                        <%= summary.totalTransactions%>
                    </div>
                    <div class="label">Số Phiếu</div>
                </div>
            </div>

            <!-- Tabs -->
            <div class="tabs">
                <button class="tab active"
                        onclick="showTab('inventory')">📊 Tồn Kho Theo Sản
                    Phẩm</button>
                <button class="tab" onclick="showTab('ledger')">📜 Chi
                    Tiết Giao Dịch</button>
            </div>

            <!-- Inventory Tab -->
            <div id="tab-inventory" class="tab-panel active">
                <div class="table-card">
                    <div class="table-header">
                        <h3>Báo Cáo Tồn Kho</h3>
                        <a href="report-inventory?action=export&startDate=<%= startDate != null ? startDate : ""%>&endDate=<%= endDate != null ? endDate : ""%>&type=<%= type != null ? type : "all"%>"
                           class="btn btn-success">
                            📥 Tải CSV
                        </a>
                    </div>
                    <div class="table-container">
                        <% if (inventoryReport.isEmpty()) { %>
                        <div class="empty-state">
                            <div class="icon">📭</div>
                            <p>Không có dữ liệu trong khoảng thời
                                gian này</p>
                        </div>
                        <% } else { %>
                        <table>
                            <thead>
                                <tr>
                                    <th>Sản Phẩm</th>
                                    <th>Cấu Hình</th>
                                    <th>Đơn Vị</th>
                                    <th class="text-right">Nhập
                                    </th>
                                    <th class="text-right">Xuất
                                    </th>
                                    <th class="text-right">Tồn
                                        Kho</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (ReportItem item
                                            : inventoryReport) {%>
                                <tr>
                                    <td><strong>
                                            <%= item.productName%>
                                        </strong></td>
                                    <td>
                                        <%= item.config%>
                                    </td>
                                    <td>
                                        <%= item.unit != null
                                                ? item.unit
                                                : "unit"%>
                                    </td>
                                    <td class="text-right"
                                        style="color: var(--success); font-weight: 600;">
                                        +<%= item.totalImport%>
                                    </td>
                                    <td class="text-right"
                                        style="color: var(--danger); font-weight: 600;">
                                        -<%= item.totalExport%>
                                    </td>
                                    <td class="text-right"
                                        style="font-weight: 700;">
                                        <%= item.currentStock%>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                        <% }%>
                    </div>
                </div>
            </div>

            <!-- Ledger Tab -->
            <div id="tab-ledger" class="tab-panel">
                <div class="table-card">
                    <div class="table-header">
                        <h3>Chi Tiết Giao Dịch Kho</h3>
                        <a href="report-inventory?action=exportLedger&startDate=<%= startDate != null ? startDate : ""%>&endDate=<%= endDate != null ? endDate : ""%>&type=<%= type != null ? type : "all"%>"
                           class="btn btn-success">
                            📥 Tải CSV
                        </a>
                    </div>
                    <div class="table-container">
                        <% if (ledgerEntries.isEmpty()) { %>
                        <div class="empty-state">
                            <div class="icon">📭</div>
                            <p>Không có giao dịch trong khoảng thời
                                gian này</p>
                        </div>
                        <% } else { %>
                        <table>
                            <thead>
                                <tr>
                                    <th>Thời Gian</th>
                                    <th>Loại</th>
                                    <th>Mã Phiếu</th>
                                    <th>Sản Phẩm</th>
                                    <th>Cấu Hình</th>
                                    <th class="text-right">Số
                                        Lượng</th>
                                    <th class="text-right">Tồn
                                        Sau</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (LedgerEntry entry
                                            : ledgerEntries) {%>
                                <tr>
                                    <td>
                                        <%= entry.createdAt
                                                != null
                                                        ? dateFormat.format(entry.createdAt)
                                                        : ""%>
                                    </td>
                                    <td>
                                        <span
                                            class="badge badge-<%= entry.type.toLowerCase()%>">
                                            <%= "IMPORT"
                                                    .equals(entry.type)
                                                    ? "Nhập"
                                                    : "Xuất"%>
                                        </span>
                                    </td>
                                    <td>
                                        <%= entry.ticketCode%>
                                    </td>
                                    <td><strong>
                                            <%= entry.productName%>
                                        </strong></td>
                                    <td>
                                        <%= entry.config%>
                                    </td>
                                    <td class="text-right"
                                        style="font-weight: 600; color: <%= "IMPORT".equals(entry.type)
                                                ? "var(--success)"
                                                : "var(--danger)"%>
                                        ;">
                                        <%= "IMPORT"
                                                .equals(entry.type)
                                                ? "+" : "-"%>
                                        <%= entry.quantityChange%>
                                    </td>
                                    <td class="text-right"
                                        style="font-weight: 700;">
                                        <%= entry.balanceAfter%>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                        <% }%>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />

        <script>
            function showTab(tabName) {
                // Hide all tabs
                document.querySelectorAll('.tab-panel').forEach(panel => {
                    panel.classList.remove('active');
                });
                document.querySelectorAll('.tab').forEach(tab => {
                    tab.classList.remove('active');
                });

                // Show selected tab
                document.getElementById('tab-' + tabName).classList.add('active');
                event.target.classList.add('active');
            }
        </script>
    </body>

</html>