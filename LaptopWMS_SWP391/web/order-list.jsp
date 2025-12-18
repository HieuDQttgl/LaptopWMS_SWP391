<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Laptop Warehouse Management System</title>

        <style>
            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background-color: #f5f6fa;
                margin: 0;
                padding: 0;
                color: #2c3e50;
            }
            .container {
                max-width: 1200px;
                margin: 40px auto;
                background-color: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.07);
            }
            h1 {
                text-align: center;
                color: #2c3e50;
                font-weight: 700;
                margin-bottom: 25px;
            }
            h2 {
                color: #2c3e50;
                font-weight: 600;
                margin-bottom: 20px;
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

            .badge-status {
                display: inline-block;
                padding: 5px 10px;
                border-radius: 20px;
                font-weight: 600;
                font-size: 12px;
                text-transform: capitalize;
            }
            .badge-status-pending {
                background-color: #ecf0f1;
                color: #7f8c8d;
            }
            .badge-status-approved {
                background-color: #fcf8e3;
                color: #8a6d3b;
            }
            .badge-status-shipping {
                background-color: #d9edf7;
                color: #31708f;
            }
            .badge-status-completed {
                background-color: #dff0d8;
                color: #3c763d;
            }
            .badge-status-cancelled {
                background-color: #f2dede;
                color: #a94442;
            }

            .action-links a {
                margin-right: 15px;
                text-decoration: none;
                color: #2980b9;
                font-weight: 600;
                transition: color 0.3s;
            }
            .action-links a:hover {
                color: #3498db;
                text-decoration: underline;
            }

            .filter-container {
                padding: 15px;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                background-color: #fcfcfc;
                margin-top: 15px;
                margin-bottom: 25px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }
            .form-row {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                margin-bottom: 15px;
                align-items: flex-end;
            }
            .form-group {
                flex: 1 1 200px;
                min-width: 150px;
            }
            .filter-container label {
                display: block;
                margin-bottom: 5px;
                font-weight: 600;
                color: #34495e;
            }
            .filter-container input,
            .filter-container select {
                width: 100%;
                padding: 8px 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
                box-sizing: border-box;
            }

            .btn-action-group {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            .btn-primary {
                background-color: #3498db;
                color: white;
                padding: 8px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
                font-weight: 600;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }
            .btn-primary:hover {
                background-color: #2980b9;
            }
            .btn-outline-secondary {
                background-color: white;
                color: #6c757d;
                border: 1px solid #6c757d;
                padding: 8px 15px;
                border-radius: 4px;
                cursor: pointer;
                transition: all 0.3s;
                font-weight: 600;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }
            .btn-outline-secondary:hover {
                background-color: #6c757d;
                color: white;
            }
            .btn-success {
                background-color: #2ecc71;
                color: white;
                padding: 10px 18px;
                border: none;
                border-radius: 6px;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 5px;
                font-size: 15px;
                font-weight: 600;
                transition: background-color 0.3s;
            }
            .btn-success:hover {
                background-color: #27ae60;
            }
            .date-filter-row {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                margin-bottom: 15px;
                align-items: flex-end;
            }
            .date-filter-row .form-group {
                flex: 1 1 200px;
                min-width: 150px;
            }
            .date-filter-row .form-group:nth-child(3) {
                flex: 2 1 auto;
            }
            .success-box {
                color: #155724;
                background-color: #d4edda;
                border: 1px solid #c3e6cb;
                padding: 10px;
                margin-bottom: 15px;
                border-radius: 4px;
                opacity: 1;
                transition: opacity 1s ease-out;
            }

            .action-links {
                text-align: center !important;
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
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                margin: 25px 0;
                flex-wrap: wrap;
            }
            .pagination a,
            .pagination span {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                text-decoration: none;
                color: #2c3e50;
                font-weight: 600;
                transition: all 0.3s;
            }
            .pagination a:hover {
                background-color: #3498db;
                color: white;
                border-color: #3498db;
            }
            .pagination .current-page {
                background-color: #3498db;
                color: white;
                border-color: #3498db;
            }
            .pagination .disabled {
                color: #bdc3c7;
                cursor: not-allowed;
                pointer-events: none;
            }
            .pagination-info {
                display: inline-block;
                padding: 8px 12px;
                color: #7f8c8d;
                font-weight: 600;
                font-size: 14px;
            }
            th a {
                color: inherit;
                text-decoration: none;
                display: block;
                cursor: pointer;
            }
            th a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp" /> 

        <div class="container">
            <h2>Order List</h2>

            <c:if test="${param.success == 'true'}">
                <div class="success-box auto-hide">
                    <strong>Success:</strong> Add new order successfully!
                </div>
            </c:if>
            <c:if test="${param.success == 'status_updated'}">
                <div class="success-box">
                    Order <strong>${param.code}</strong> successfully changed status to <strong>${param.newStatus}</strong>!
                </div>
            </c:if>
            <c:if test="${param.error == 'transition_denied'}">
                <div style="padding: 10px; background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; border-radius: 4px; margin-bottom: 15px;">
                    **Permission/Business Logic Error:** You are not allowed to perform this status transition (or the transition status is invalid).
                </div>
            </c:if>
            <c:if test="${param.error == 'order_not_found'}">
                <div style="padding: 10px; background-color: #fff3cd; color: #856404; border: 1px solid #ffeeba; border-radius: 4px; margin-bottom: 15px;">
                    Error: Order to be updated not found.
                </div>
            </c:if>
            <div style="margin-bottom: 20px;">
                <a href="add-order" class="btn-success">+ Add new Order</a>
            </div>

            <div class="filter-container">
                <form action="order-list" method="get" class="filter-form" id="filterForm">
                    <!-- Hidden fields for sorting and pagination -->
                    <input type="hidden" name="sort_field" value="${sort_field}">
                    <input type="hidden" name="sort_order" value="${sort_order}">
                    <input type="hidden" name="page" value="1">

                    <div class="form-row">
                        <div class="form-group">
                            <label for="keyword">Search</label>
                            <input type="text" id="keyword" name="keyword" placeholder="Search by OrderCode,Customer,Supplier,.." value="${keyword}">
                        </div>

                        <button type="submit" class="btn-secondary" style="padding: 6px 12px; background: #3498db; color: white; border: none; border-radius: 4px; cursor: pointer;">
                            Search
                        </button>
                        <div class="form-group">
                            <label for="statusFilter">Status</label>
                            <select id="statusFilter" name="statusFilter" onchange="this.form.submit()">
                                <option value="all" ${statusFilter == null || statusFilter == 'all' ? 'selected' : ''}>All Statuses</option>
                                <option value="Pending" ${statusFilter == 'Pending' ? 'selected' : ''}>Pending</option>
                                <option value="Approved" ${statusFilter == 'Approved' ? 'selected' : ''}>Approved</option>
                                <option value="Shipping" ${statusFilter == 'Shipping' ? 'selected' : ''}>Shipping</option>
                                <option value="Completed" ${statusFilter == 'Completed' ? 'selected' : ''}>Completed</option>
                                <option value="Cancelled" ${statusFilter == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="orderTypeFilter">Order Type</label>
                            <select id="orderTypeFilter" name="orderTypeFilter" onchange="this.form.submit()">
                                <option value="all" ${orderTypeFilter == null || orderTypeFilter == 'all' ? 'selected' : ''}>All Types</option>
                                <option value="Export" ${orderTypeFilter == 'Export' ? 'selected' : ''}>Export</option>
                                <option value="Import" ${orderTypeFilter == 'Import' ? 'selected' : ''}>Import</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="createdByFilter">Creator</label>
                            <select id="createdByFilter" name="createdByFilter" onchange="this.form.submit()">
                                <option value="" ${createdByFilter == null || createdByFilter == '' ? 'selected' : ''}>All Creators</option>
                                <c:forEach var="creator" items="${allCreators}">
                                    <option value="${creator.userId}" ${createdByFilter == creator.userId ? 'selected' : ''}>
                                        ${creator.fullName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="date-filter-row">
                        <div class="form-group">
                            <label for="startDateFilter">From (Created Date)</label>
                            <input type="date" id="startDateFilter" name="startDateFilter" value="${startDateFilter}" onchange="this.form.submit()">
                        </div>
                        <div class="form-group">
                            <label for="endDateFilter">To (Created Date)</label>
                            <input type="date" id="endDateFilter" name="endDateFilter" value="${endDateFilter}" onchange="this.form.submit()">
                        </div>
                        <div class="form-group btn-action-group" style="flex: 1 1 200px; align-self: flex-end;">
                            <a href="order-list" class="btn-outline-secondary">Reset</a>
                        </div>
                    </div>
                </form>
            </div>
            <%
                String currentSortField = (String) request.getAttribute("sort_field");
                String currentSortOrder = (String) request.getAttribute("sort_order");

                if (currentSortField == null) {
                    currentSortField = "order_id";
                }
                if (currentSortOrder == null)
                    currentSortOrder = "DESC";
            %>

            <table>
                <thead>
                    <tr>
                        <th>
                            <a href="#" onclick="window.location.href = createSortUrl('order_code'); return false;">
                                Order Code
                                <% if ("order_code".equals(currentSortField)) {%>
                                <%= "ASC".equals(currentSortOrder) ? " ▲" : " ▼"%>
                                <% } %>
                            </a>
                        </th>
                        <th>Description</th>
                        <th>
                            <a href="#" onclick="window.location.href = createSortUrl('customer_name'); return false;">
                                Customer
                                <% if ("customer_name".equals(currentSortField)) {%>
                                <%= "ASC".equals(currentSortOrder) ? " ▲" : " ▼"%>
                                <% } %>
                            </a>
                        </th>
                        <th>
                            <a href="#" onclick="window.location.href = createSortUrl('supplier_name'); return false;">
                                Supplier
                                <% if ("supplier_name".equals(currentSortField)) {%>
                                <%= "ASC".equals(currentSortOrder) ? " ▲" : " ▼"%>
                                <% } %>
                            </a>
                        </th>
                        <th>Order Type</th>
                        <th>
                            <a href="#" onclick="window.location.href = createSortUrl('created_at'); return false;">
                                Created At
                                <% if ("created_at".equals(currentSortField)) {%>
                                <%= "ASC".equals(currentSortOrder) ? " ▲" : " ▼"%>
                                <% } %>
                            </a>
                        </th>
                        <th>
                            <a href="#" onclick="window.location.href = createSortUrl('order_status'); return false;">
                                Status
                                <% if ("order_status".equals(currentSortField)) {%>
                                <%= "ASC".equals(currentSortOrder) ? " ▲" : " ▼"%>
                                <% } %>
                            </a>
                        </th>
                        <th>
                            <a href="#" onclick="window.location.href = createSortUrl('created_by_name'); return false;">
                                Created By
                                <% if ("created_by_name".equals(currentSortField)) {%>
                                <%= "ASC".equals(currentSortOrder) ? " ▲" : " ▼"%>
                                <% }%>
                            </a>
                        </th>
                        <th>Action</th> 
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty orders}">
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>${order.orderCode}</td>
                                    <td>${order.description}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty order.customerName}">
                                                ${order.customerName}
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty order.supplierName}">
                                                ${order.supplierName}
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:set var="isImport" value="${empty order.customerName and not empty order.supplierName}" />
                                        <c:choose>
                                            <c:when test="${!isImport and not empty order.customerName}">
                                                <span class="badge-status" style="background-color: #ffe7e6; color: #f5222d;">Export</span>
                                            </c:when>
                                            <c:when test="${isImport}">
                                                <span class="badge-status" style="background-color: #e6f7ff; color: #1890ff;">Import</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-status" style="background-color: #f0f0f0; color: #7f8c8d;">N/A</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${order.createdAt}" pattern="dd-MM-yyyy HH:mm"/>
                                    </td>
                                    <td>
                                        <span class="badge-status badge-status-${order.orderStatus.toLowerCase()}">
                                            ${order.orderStatus}
                                        </span>
                                    </td>
                                    <td>${order.createdByName}</td>

                                    <td class="action-links">
                                        <a href="order-detail?id=${order.orderId}" title="View">View Detail</a>

                                        <c:choose>
                                            <c:when test="${order.orderStatus == 'completed' || order.orderStatus == 'cancelled'}">
                                                | <span style="color: #a94442; font-weight: 600;">Finalized</span>
                                            </c:when>

                                            <c:otherwise>
                                                | <a href="order-status?orderId=${order.orderId}" title="Change Status">
                                                    Change Status
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="9" style="text-align: center; color: #7f8c8d; padding: 20px;">
                                    No order found.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            <%
                Integer currentPage = (Integer) request.getAttribute("currentPage");
                Integer totalPages = (Integer) request.getAttribute("totalPages");
                Integer totalRecords = (Integer) request.getAttribute("totalRecords");
                Integer recordsPerPage = (Integer) request.getAttribute("recordsPerPage");

                if (currentPage == null) {
                    currentPage = 1;
                }
                if (totalPages == null) {
                    totalPages = 1;
                }
                if (totalRecords == null) {
                    totalRecords = 0;
                }
                if (recordsPerPage == null)
                    recordsPerPage = 10;
            %>

            <% if (totalRecords > 0) {%>
            <div style="text-align: center; margin-top: 20px; color: #7f8c8d;">
                <p style="margin-bottom: 15px; font-weight: 600;">
                    Total Orders: <%= totalRecords%>
                </p>

                <% if (totalPages > 1) { %>
                <div class="pagination">
                    <!-- Previous Button -->
                    <% if (currentPage > 1) {%>
                    <a href="#" onclick="window.location.href = createPaginationUrl(<%= currentPage - 1%>); return false;">« Previous</a>
                    <% } else { %>
                    <span class="disabled">« Previous</span>
                    <% } %>

                    <!-- Page Numbers -->
                    <%
                        int startPage = Math.max(1, currentPage - 2);
                        int endPage = Math.min(totalPages, currentPage + 2);

                        if (startPage > 1) {
                    %>
                    <a href="#" onclick="window.location.href = createPaginationUrl(1); return false;">1</a>
                    <% if (startPage > 2) { %>
                    <span>...</span>
                    <% } %>
                    <% } %>

                    <% for (int i = startPage; i <= endPage; i++) { %>
                    <% if (i == currentPage) {%>
                    <span class="current-page"><%= i%></span>
                    <% } else {%>
                    <a href="#" onclick="window.location.href = createPaginationUrl(<%= i%>); return false;"><%= i%></a>
                    <% } %>
                    <% } %>

                    <% if (endPage < totalPages) { %>
                    <% if (endPage < totalPages - 1) { %>
                    <span>...</span>
                    <% }%>
                    <a href="#" onclick="window.location.href = createPaginationUrl(<%= totalPages%>); return false;"><%= totalPages%></a>
                    <% } %>

                    <!-- Next Button -->
                    <% if (currentPage < totalPages) {%>
                    <a href="#" onclick="window.location.href = createPaginationUrl(<%= currentPage + 1%>); return false;">Next »</a>
                    <% } else { %>
                    <span class="disabled">Next »</span>
                    <% }%>

                    <!-- Pagination Info -->
                    <span class="pagination-info" style="margin-left: 15px;">
                        Showing
                        <%= Math.min((currentPage - 1) * recordsPerPage + 1, totalRecords)%>
                        -
                        <%= Math.min(currentPage * recordsPerPage, totalRecords)%>
                        of
                        <%= totalRecords%>
                        orders
                    </span>
                </div>
                <% } %>
            </div>
            <% }%>

            <a id="backLanding"
               href="<%= request.getContextPath()%>/landing"
               class="btn-secondary">Back to Landing Page</a>
        </div>

        <jsp:include page="footer.jsp" /> 

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                document.querySelectorAll('.success-box.auto-hide').forEach(successBox => {
                    setTimeout(() => {
                        successBox.style.opacity = '0';
                        setTimeout(() => {
                            successBox.style.display = 'none';
                        }, 1000);
                    }, 5000);
                });
            });

            function createPaginationUrl(page) {
                var keyword = document.getElementById('keyword').value;
                var statusFilter = document.getElementById('statusFilter').value;
                var orderTypeFilter = document.getElementById('orderTypeFilter').value;
                var createdByFilter = document.getElementById('createdByFilter').value;
                var startDateFilter = document.getElementById('startDateFilter').value;
                var endDateFilter = document.getElementById('endDateFilter').value;

                var currentSortField = '<%= currentSortField%>';
                var currentSortOrder = '<%= currentSortOrder%>';

                var url = 'order-list?page=' + page;

                if (keyword && keyword.trim() !== '') {
                    url += '&keyword=' + encodeURIComponent(keyword.trim());
                }
                if (statusFilter && statusFilter !== 'all') {
                    url += '&statusFilter=' + statusFilter;
                }
                if (orderTypeFilter && orderTypeFilter !== 'all') {
                    url += '&orderTypeFilter=' + orderTypeFilter;
                }
                if (createdByFilter && createdByFilter !== '') {
                    url += '&createdByFilter=' + createdByFilter;
                }
                if (startDateFilter && startDateFilter !== '') {
                    url += '&startDateFilter=' + startDateFilter;
                }
                if (endDateFilter && endDateFilter !== '') {
                    url += '&endDateFilter=' + endDateFilter;
                }
                if (currentSortField) {
                    url += '&sort_field=' + currentSortField;
                }
                if (currentSortOrder) {
                    url += '&sort_order=' + currentSortOrder;
                }

                return url;
            }

            function createSortUrl(field) {
                var keyword = document.getElementById('keyword').value;
                var statusFilter = document.getElementById('statusFilter').value;
                var orderTypeFilter = document.getElementById('orderTypeFilter').value;
                var createdByFilter = document.getElementById('createdByFilter').value;
                var startDateFilter = document.getElementById('startDateFilter').value;
                var endDateFilter = document.getElementById('endDateFilter').value;

                var currentSortField = '<%= currentSortField%>';
                var currentSortOrder = '<%= currentSortOrder%>';

                var newSortOrder = 'ASC';
                if (field === currentSortField) {
                    newSortOrder = (currentSortOrder === 'ASC') ? 'DESC' : 'ASC';
                } else {
                    newSortOrder = 'ASC';
                }

                var url = 'order-list?sort_field=' + field + '&sort_order=' + newSortOrder;

                if (keyword && keyword.trim() !== '') {
                    url += '&keyword=' + encodeURIComponent(keyword.trim());
                }
                if (statusFilter && statusFilter !== 'all') {
                    url += '&statusFilter=' + statusFilter;
                }
                if (orderTypeFilter && orderTypeFilter !== 'all') {
                    url += '&orderTypeFilter=' + orderTypeFilter;
                }
                if (createdByFilter && createdByFilter !== '') {
                    url += '&createdByFilter=' + createdByFilter;
                }
                if (startDateFilter && startDateFilter !== '') {
                    url += '&startDateFilter=' + startDateFilter;
                }
                if (endDateFilter && endDateFilter !== '') {
                    url += '&endDateFilter=' + endDateFilter;
                }

                return url;
            }
        </script>
    </body>
</html>