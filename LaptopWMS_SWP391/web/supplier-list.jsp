<%@ page import="Model.Supplier" %>
<%@ page import="Model.Users" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
    <jsp:include page="header.jsp" />

    <head>
        <meta charset="UTF-8">
        <title>Supplier Management</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 20px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            h1 {
                color: #333;
                margin-bottom: 10px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th {
                background-color: #f9f9f9;
                padding: 15px 12px;
                text-align: left;
                border-bottom: 3px solid #e5e5e5;
                color: #666;
                font-size: 13px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            td {
                padding: 15px 12px;
                border-bottom: 1px solid #f0f0f0;
                font-size: 14px;
            }

            tr:hover {
                background-color: #f7f9fb;
            }

            .status-badge {
                display: inline-block;
                padding: 5px 10px;
                border-radius: 20px;
                font-weight: 600;
                font-size: 12px;
                text-transform: capitalize;
            }

            .status-active {
                background-color: #e6f7ed;
                color: #27ae60;
                border: 1px solid #27ae60;
            }

            .status-inactive {
                background-color: #fbebeb;
                color: #e74c3c;
                border: 1px solid #e74c3c;
            }

            .action-links a {
                margin-right: 10px;
                text-decoration: none;
                color: #2980b9;
                font-weight: 600;
                transition: color 0.3s;
            }

            .action-links a:hover {
                color: #3498db;
                text-decoration: underline;
            }

            .btn-add {
                background-color: #2ecc71;
                color: white;
                padding: 10px 18px;
                border: none;
                border-radius: 6px;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                margin-bottom: 25px;
                cursor: pointer;
                font-size: 15px;
                font-weight: 600;
                transition: background-color 0.3s;
            }

            .btn-add:hover {
                background-color: #27ae60;
            }

            .notification {
                padding: 12px;
                border-radius: 6px;
                margin-bottom: 20px;
                font-weight: 600;
                border-left: 5px solid;
            }

            .message-success {
                color: #1a7d3f;
                background-color: #d4edda;
                border-left-color: #2ecc71;
            }

            .message-error {
                color: #8c2a35;
                background-color: #f8d7da;
                border-left-color: #e74c3c;
            }

            .filter-container {
                display: flex;
                flex-direction: column;
                gap: 15px;
                margin-bottom: 25px;
                padding: 15px;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                background-color: #fcfcfc;
            }

            .filter-controls {
                display: flex;
                gap: 15px;
                flex-wrap: wrap;
                align-items: center;
            }

            .filter-actions {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
                width: 100%;
                padding-top: 10px;
                border-top: 1px dashed #eee;
            }

            .filter-group {
                display: flex;
                flex-wrap: nowrap;
                gap: 10px;
                align-items: center;
            }

            .filter-container label {
                font-weight: 600;
                color: #34495e;
                white-space: nowrap;
            }

            .filter-container input[type="text"],
            .filter-container select {
                padding: 8px 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
            }

            .btn-filter {
                background-color: #3498db;
                color: white;
                padding: 8px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
                font-weight: 600;
            }

            .btn-filter:hover {
                background-color: #2980b9;
            }

            .btn-clear {
                background-color: #e74c3c;
                color: white;
                padding: 8px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
                font-weight: 600;
            }

            .btn-clear:hover {
                background-color: #c0392b;
            }

            .btn-secondary {
                display: inline-block;
                padding: 10px 18px;
                background-color: #95a5a6;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                font-weight: 600;
                margin-top: 20px;
                transition: background-color 0.3s;
            }

            .btn-secondary:hover {
                background-color: #7f8c8d;
            }

            /* Pagination Styles */
            .pagination-container {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                margin: 20px 0;
                flex-wrap: wrap;
            }

            .pagination-container a,
            .pagination-container span {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                min-width: 36px;
                height: 36px;
                padding: 0 10px;
                border-radius: 6px;
                text-decoration: none;
                font-size: 14px;
                font-weight: 500;
                transition: all 0.2s ease;
            }

            .pagination-container a {
                background-color: #ffffff;
                color: #374151;
                border: 1px solid #d1d5db;
            }

            .pagination-container a:hover {
                background-color: #f3f4f6;
                border-color: #9ca3af;
            }

            .pagination-container .page-current {
                background: linear-gradient(135deg, #2563eb, #3b82f6);
                color: #ffffff;
                border: none;
                box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
            }

            .pagination-container .page-disabled {
                background-color: #f3f4f6;
                color: #9ca3af;
                border: 1px solid #e5e7eb;
                cursor: not-allowed;
            }

            .pagination-info {
                color: #6b7280;
                font-size: 14px;
                margin-left: 16px;
            }
        </style>
    </head>

    <body>

        <div class="container">
            <h1>Supplier Management List</h1>

            <% String successMessage = (String) request.getSession().getAttribute("message");
                String errorMessage = (String) request.getSession().getAttribute("error");
                Users currentUser = (Users) request.getAttribute("currentUser");
                boolean isSale = currentUser
                        != null && currentUser.getRoleId() == 3;
                boolean canChangeStatus = currentUser != null
                        && (currentUser.getRoleId() == 3);
                String currentKeyword = (String) request.getAttribute("keyword");
                String currentStatus = (String) request.getAttribute("status_filter");
                String currentSortField = (String) request.getAttribute("sort_field");
                String currentSortOrder = (String) request.getAttribute("sort_order");
                if (currentKeyword == null) {
                    currentKeyword = "";
                }
                if (currentStatus == null) {
                    currentStatus = "all";
                }
                if (currentSortField == null) {
                    currentSortField = "supplier_id";
                }
                if (currentSortOrder == null) {
                                    currentSortOrder = "ASC";
                                }
                                if (errorMessage != null) {%>
            <p id="notification" class="message-error notification">
                <%= errorMessage%>
            </p>
            <% request.getSession().removeAttribute("error");
                                } else if (successMessage != null) {%>
            <p id="notification" class="message-success notification">
                <%= successMessage%>
            </p>
            <% request.getSession().removeAttribute("message");
                                        } %>

            <% if (isSale) {%>
            <a href="<%= request.getContextPath()%>/add-supplier" class="btn-add">Add
                New Supplier</a>
                <% }%>

            <div class="filter-container" id="filterContainer">
                <form id="filterForm" action="supplier-list" method="get"
                      style="width: 100%;">
                    <div class="filter-controls">
                        <div class="filter-group">
                            <input type="text" name="keyword" id="keywordFilter"
                                   placeholder="Search by name/email/phone..."
                                   value="<%= currentKeyword%>">
                        </div>

                        <div class="filter-group">
                            <label for="statusFilter">Status:</label>
                            <select name="status_filter" id="statusFilter">
                                    <option value="all" <%="all".equals(currentStatus)
                                                                            ? "selected" : ""%>>All</option>
                                <option value="active" <%="active"
                                                                            .equals(currentStatus) ? "selected" : ""%>
                                        >Active</option>
                                <option value="inactive" <%="inactive"
                                                                            .equals(currentStatus) ? "selected" : ""%>
                                        >Inactive</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label for="sortField">Sort By:</label>
                            <select name="sort_field" id="sortField">
                                <option value="supplier_id" <%="supplier_id"
                                                                            .equals(currentSortField) ? "selected" : ""%>
                                        >ID</option>
                                <option value="supplier_name" <%="supplier_name"
                                                                            .equals(currentSortField) ? "selected" : ""%>
                                        >Supplier Name</option>
                                <option value="supplier_email" <%="supplier_email"
                                                                            .equals(currentSortField) ? "selected" : ""%>
                                        >Email</option>
                                <option value="supplier_phone" <%="supplier_phone"
                                                                            .equals(currentSortField) ? "selected" : ""%>
                                        >Phone</option>
                                <option value="status" <%="status"
                                                                            .equals(currentSortField) ? "selected" : ""%>
                                        >Status</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label for="sortOrder">Order:</label>
                            <select name="sort_order" id="sortOrder">
                                <option value="ASC" <%="ASC"
                                                                            .equals(currentSortOrder) ? "selected" : ""%>
                                        >Ascending</option>
                                <option value="DESC" <%="DESC"
                                                                            .equals(currentSortOrder) ? "selected" : ""%>
                                        >Descending</option>
                            </select>
                        </div>
                    </div>

                    <div class="filter-actions">
                        <button type="submit" class="btn-filter">Apply Filter &
                            Sort</button>
                        <button type="button" class="btn-clear"
                                onclick="clearFilters()">Clear Filter</button>
                    </div>
                </form>
            </div>

            <table id="supplierTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Supplier Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");
                        if (suppliers != null && !suppliers.isEmpty()) {
                            for (Supplier supplier : suppliers) {
                    %>
                    <tr>
                        <td>
                            <%= supplier.getSupplierId()%>
                        </td>
                        <td>
                            <%= supplier.getSupplierName()%>
                        </td>
                        <td>
                            <%= supplier.getSupplierEmail() != null
                                                                                ? supplier.getSupplierEmail() : "—"%>
                        </td>
                        <td>
                            <%= supplier.getSupplierPhone() != null
                                                                                ? supplier.getSupplierPhone() : "—"%>
                        </td>
                        <td>
                            <% if ("active".equalsIgnoreCase(supplier.getStatus())) { %>
                            <span
                                class="status-badge status-active">Active</span>
                            <% } else { %>
                            <span
                                class="status-badge status-inactive">Inactive</span>
                            <% }%>
                        </td>
                        <td class="action-links">
                            <a
                                href="<%= request.getContextPath()%>/supplier-detail?id=<%= supplier.getSupplierId()%>">View
                                Detail</a>
                                <% if (canChangeStatus) {%>
                            <form action="supplier-list" method="post"
                                  style="display: inline;">
                                <input type="hidden" name="action"
                                       value="changeStatus">
                                <input type="hidden" name="id"
                                       value="<%= supplier.getSupplierId()%>">
                                <a href="#"
                                   onclick="this.closest('form').submit(); return false;">
                                    <% if ("active".equalsIgnoreCase(supplier.getStatus())) {
                                            out.print("Deactivate");
                                        } else {
                                            out.print("Activate");
                                        }
                                    %>
                                </a>
                            </form>
                            <% } %>
                        </td>
                    </tr>
                    <% }
                                                                } else {%>
                    <tr>
                        <td colspan="6"
                            style="text-align: center; color: #7f8c8d;">
                            No suppliers found.</td>
                    </tr>
                    <% }%>
            </table>

            <!-- Pagination -->
            <% Integer currentPage = (Integer) request.getAttribute("currentPage");
                Integer totalPages = (Integer) request.getAttribute("totalPages");
                Integer totalCount = (Integer) request.getAttribute("totalCount");
                Integer pageSize = (Integer) request.getAttribute("pageSize");
                if (currentPage == null) {
                    currentPage = 1;
                }
                if (totalPages == null) {
                    totalPages = 1;
                }
                if (totalCount == null) {
                    totalCount = 0;
                }
                if (pageSize == null) {
                    pageSize = 5;
                }
                String baseUrl = request.getContextPath()
                        + "/supplier-list?";
                if (currentKeyword != null
                        && !currentKeyword.isEmpty()) {
                    baseUrl += "keyword="
                            + java.net.URLEncoder.encode(currentKeyword, "UTF-8") + "&";
                }
                if (currentStatus != null && !currentStatus.isEmpty()) {
                    baseUrl
                            += "status_filter=" + currentStatus + "&";
                }
                if (currentSortField
                        != null && !currentSortField.isEmpty()) {
                    baseUrl += "sort_field="
                            + currentSortField + "&";
                }
                if (currentSortOrder != null
                        && !currentSortOrder.isEmpty()) {
                                                        baseUrl += "sort_order="
                                                                + currentSortOrder + "&";
                                                    } %>

            <% if (totalPages > 1) { %>
            <div class="pagination-container">
                <!-- Previous Button -->
                <% if (currentPage > 1) {%>
                <a href="<%= baseUrl%>page=<%= currentPage - 1%>">&laquo;
                    Prev</a>
                    <% } else { %>
                <span class="page-disabled">&laquo; Prev</span>
                <% } %>

                <!-- Page Numbers -->
                <% int startPage = Math.max(1, currentPage - 2);
                    int endPage = Math.min(totalPages, currentPage
                            + 2);
                    if (startPage > 1) {
                %>
                <a href="<%= baseUrl%>page=1">1</a>
                <% if (startPage > 2) { %>
                <span class="page-disabled">...</span>
                <% } %>
                <% } %>

                <% for (int i = startPage; i
                                                                                                    <= endPage; i++) { %>
                <% if (i == currentPage) {%>
                <span
                    class="page-current">
                    <%= i%>
                </span>
                <% } else {%>
                <a
                    href="<%= baseUrl%>page=<%= i%>">
                    <%= i%>
                </a>
                <% } %>
                <% } %>

                <% if (endPage
                                                                                                                        < totalPages) { %>
                <% if (endPage
                                                                                                                            < totalPages
                                                                                                                            - 1) { %>
                <span
                    class="page-disabled">...</span>
                <% }
                %>
                <a
                    href="<%= baseUrl%>page=<%= totalPages%>">
                    <%= totalPages%>
                </a>
                <% }
                %>

                <!-- Next Button -->
                <% if (currentPage
                            < totalPages) {
                %>
                <a
                    href="<%= baseUrl%>page=<%= currentPage + 1%>">Next
                    &raquo;</a>
                    <% } else {
                    %>
                <span
                    class="page-disabled">Next
                    &raquo;</span>
                    <% }
                    %>

                <span
                    class="pagination-info">
                    Showing
                    <%= Math.min((currentPage
                                                                                                                                                    - 1)
                                                                                                                                                    * pageSize
                                                                                                                                                    + 1,
                                                                                                                                                    totalCount)%>
                    -
                    <%= Math.min(currentPage
                                                                                                                                                        * pageSize,
                                                                                                                                                        totalCount)%>
                    of
                    <%= totalCount%>
                    suppliers
                </span>
            </div>
            <% } else {%>
            <p
                style="margin-top: 20px; color: #7f8c8d; text-align: center;">
                Total Suppliers: <%= totalCount%>
            </p>
            <% }%>

            <a id="backLanding"
               href="<%= request.getContextPath()%>/landing"
               class="btn-secondary">Back to Landing Page</a>
        </div>

        <script>
            var notificationElement = document.getElementById('notification');

            function clearFilters() {
                document.getElementById('keywordFilter').value = '';
                document.getElementById('statusFilter').value = 'all';
                document.getElementById('sortField').value = 'supplier_id';
                document.getElementById('sortOrder').value = 'ASC';
                document.getElementById('filterForm').submit();
            }

            if (notificationElement) {
                setTimeout(function () {
                    notificationElement.remove();
                }, 5000);
            }
        </script>
        <jsp:include page="footer.jsp" />
    </body>

</html>