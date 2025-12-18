<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.Supplier" %>
<%@ page import="Model.Users" %>
<!DOCTYPE html>
<html>
    <jsp:include page="header.jsp" />

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Laptop Warehouse Management System</title>

        <style>
            :root {
                --primary-color: #2563eb;
                --primary-hover: #1d4ed8;
                --bg-color: #f3f4f6;
                --card-bg: #ffffff;
                --border-color: #e5e7eb;
                --text-main: #111827;
                --text-muted: #6b7280;
                --radius-lg: 12px;
                --shadow-soft: 0 10px 25px rgba(15, 23, 42, 0.12);
            }

            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
                background: radial-gradient(circle at top left, #dbeafe 0, #eff6ff 25%, #f9fafb 60%);
                min-height: 100vh;
                color: var(--text-main);
            }

            .detail-wrapper {
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 40px 16px;
            }

            .card {
                width: 100%;
                max-width: 600px;
                background: var(--card-bg);
                border-radius: var(--radius-lg);
                box-shadow: var(--shadow-soft);
                padding: 28px 26px 26px;
                border: 1px solid var(--border-color);
            }

            .card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 18px;
            }

            .card-header-left h1 {
                margin: 0 0 4px;
                font-size: 22px;
                font-weight: 600;
            }

            .card-header-left p {
                margin: 0;
                font-size: 13px;
                color: var(--text-muted);
            }

            .badge {
                padding: 4px 10px;
                font-size: 12px;
                border-radius: 999px;
                border: 1px solid;
            }

            .badge.active {
                background-color: #d1fae5;
                color: #065f46;
                border-color: #6ee7b7;
            }

            .badge.inactive {
                background-color: #fee2e2;
                color: #991b1b;
                border-color: #fca5a5;
            }

            .detail-body {
                margin-top: 6px;
            }

            .field-group {
                display: flex;
                justify-content: space-between;
                padding: 12px 0;
                border-bottom: 1px solid #f3f4f6;
                font-size: 14px;
            }

            .field-label {
                color: var(--text-muted);
            }

            .field-value {
                font-weight: 500;
                text-align: right;
                max-width: 60%;
                word-break: break-word;
            }

            .field-value.muted {
                color: var(--text-muted);
                font-weight: 400;
            }

            .actions {
                margin-top: 24px;
                display: flex;
                justify-content: flex-end;
                gap: 8px;
            }

            .btn-secondary {
                padding: 7px 14px;
                border-radius: 999px;
                border: 1px solid var(--border-color);
                background: white;
                color: var(--text-main);
                font-weight: 500;
                font-size: 13px;
                cursor: pointer;
                transition: background 0.15s ease;
                text-decoration: none;
                display: inline-block;
            }

            .btn-secondary:hover {
                background: var(--bg-color);
            }

            .btn-primary {
                padding: 7px 14px;
                border-radius: 999px;
                border: none;
                background: linear-gradient(135deg, var(--primary-color), #3b82f6);
                color: #ffffff;
                font-weight: 500;
                font-size: 13px;
                cursor: pointer;
                transition: background 0.15s ease, transform 0.05s ease, box-shadow 0.05s ease;
                box-shadow: 0 8px 18px rgba(37, 99, 235, 0.3);
                text-decoration: none;
                display: inline-block;
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, var(--primary-hover), #2563eb);
                transform: translateY(-1px);
            }

            .btn-primary:active {
                transform: translateY(0);
                box-shadow: 0 6px 14px rgba(37, 99, 235, 0.25);
            }

            @media (max-width: 540px) {
                .card {
                    padding: 22px 18px 20px;
                }
            }
        </style>
    </head>

    <body>
        <div class="detail-wrapper">
            <div class="card">
                <div class="card-header">
                    <div class="card-header-left">
                        <h1>Supplier Details</h1>
                        <p>Detailed information about this supplier</p>
                    </div>
                    <% Supplier supplier = (Supplier) request.getAttribute("supplier");
                        Users currentUser = (Users) request.getAttribute("currentUser");
                        boolean isAdmin = currentUser != null
                                && currentUser.getRoleId() == 1;
                                if (supplier != null && "active"
                                        .equalsIgnoreCase(supplier.getStatus())) { %>
                    <span class="badge active">Active</span>
                    <% } else if (supplier != null) { %>
                    <span class="badge inactive">Inactive</span>
                    <% } %>
                </div>

                <% if (supplier != null) {%>

                <div class="detail-body">
                    <div class="field-group">
                        <span class="field-label">Supplier ID</span>
                        <span class="field-value">
                            <%= supplier.getSupplierId()%>
                        </span>
                    </div>

                    <div class="field-group">
                        <span class="field-label">Supplier Name</span>
                        <span class="field-value">
                            <%= supplier.getSupplierName() != null ? supplier.getSupplierName() : "—"%>
                        </span>
                    </div>

                    <div class="field-group">
                        <span class="field-label">Email</span>
                        <span class="field-value">
                            <%= supplier.getSupplierEmail() != null ? supplier.getSupplierEmail() : "—"%>
                        </span>
                    </div>

                    <div class="field-group">
                        <span class="field-label">Phone Number</span>
                        <span class="field-value">
                            <%= supplier.getSupplierPhone() != null ? supplier.getSupplierPhone() : "—"%>
                        </span>
                    </div>

                    <div class="field-group">
                        <span class="field-label">Status</span>
                        <span class="field-value">
                            <%= supplier.getStatus() != null ? supplier.getStatus() : "—"%>
                        </span>
                    </div>
                </div>

                <div class="actions">
                    <a href="<%= request.getContextPath()%>/supplier-list" class="btn-secondary">Back to
                        Supplier List</a>
                        <% if (isAdmin) {%>
                    <a href="<%= request.getContextPath()%>/edit-supplier?id=<%= supplier.getSupplierId()%>"
                       class="btn-primary">Edit Supplier</a>
                    <% } %>
                </div>

                <% } else {%>

                <div class="detail-body">
                    <p>Supplier not found.</p>
                </div>

                <div class="actions">
                    <a href="<%= request.getContextPath()%>/supplier-list" class="btn-secondary">Back
                        to Supplier List</a>
                </div>

                <% }%>

            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </body>

</html>