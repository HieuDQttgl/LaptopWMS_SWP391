<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

    <head>
        <title>Supplier Management - WMS</title>

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
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.07);
            }

            h1 {
                text-align: center;
                color: #2c3e50;
                font-weight: 700;
                margin-bottom: 25px;
            }

            .btn-add {
                background-color: #2ecc71;
                color: white;
                padding: 10px 18px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 700;
                margin-bottom: 20px;
                text-decoration: none;
                display: inline-block;
                transition: background-color 0.2s;
            }

            .btn-add:hover {
                background-color: #27ae60;
            }

            .filter-container {
                margin-bottom: 20px;
                padding: 15px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            }

            .filter-container form {
                display: flex;
                gap: 15px;
                align-items: center;
                flex-wrap: wrap;
            }

            .filter-container input[type="text"] {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 6px;
                width: 250px;
                font-size: 14px;
            }

            .filter-container select {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 14px;
            }

            .btn-search {
                padding: 8px 16px;
                background: #3498db;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
            }

            .btn-search:hover {
                background: #2980b9;
            }

            .btn-clear {
                padding: 8px 16px;
                background: #e74c3c;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                font-size: 13px;
                font-weight: 600;
            }

            .btn-clear:hover {
                background: #c0392b;
            }

            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                margin-top: 10px;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 0 0 1px #e0e0e0;
            }

            th {
                background-color: #2c3e50;
                color: white;
                padding: 15px 12px;
                text-align: left;
                font-size: 14px;
                text-transform: uppercase;
                font-weight: 600;
            }

            td {
                padding: 15px 12px;
                border-bottom: 1px solid #f0f0f0;
                font-size: 14px;
                vertical-align: middle;
                background-color: white;
            }

            tr:hover td {
                background-color: #f8f9fa;
            }

            .status-badge {
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: bold;
                text-transform: uppercase;
            }

            .status-active {
                background: #e6f7ed;
                color: #27ae60;
                border: 1px solid #27ae60;
            }

            .status-inactive {
                background: #fbebeb;
                color: #e74c3c;
                border: 1px solid #e74c3c;
            }

            .btn-view {
                background-color: #3498db;
                color: white;
                padding: 6px 12px;
                border-radius: 4px;
                text-decoration: none;
                font-size: 12px;
                font-weight: 600;
                margin-right: 8px;
            }

            .btn-view:hover {
                background-color: #2980b9;
            }

            .btn-block {
                background-color: #e74c3c;
                color: white;
                padding: 6px 12px;
                border-radius: 4px;
                text-decoration: none;
                font-size: 12px;
                font-weight: 600;
            }

            .btn-block:hover {
                background-color: #c0392b;
            }

            .btn-unblock {
                background-color: #2ecc71;
                color: white;
                padding: 6px 12px;
                border-radius: 4px;
                text-decoration: none;
                font-size: 12px;
                font-weight: 600;
            }

            .btn-unblock:hover {
                background-color: #27ae60;
            }

            .empty-state {
                text-align: center;
                padding: 50px;
                color: #95a5a6;
            }

            .empty-state i {
                font-size: 48px;
                margin-bottom: 15px;
            }

            .back-link {
                color: #bab0b0;
                font-style: italic;
                text-decoration: none;
                display: inline-block;
                margin-top: 20px;
            }

            .back-link:hover {
                color: #3498db;
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="container">
            <h1>Supplier Management</h1>

            <div style="display: flex; justify-content: space-between; align-items: center;">
                <a href="add-supplier" class="btn-add">+ Add New Supplier</a>
            </div>

            <div class="filter-container">
                <form action="supplier-list" method="get">
                    <input type="text" name="keyword" placeholder="Search supplier name..."
                           value="${param.keyword}">
                    <select name="status" onchange="this.form.submit()">
                        <option value="all" ${param.status=='all' ? 'selected' : '' }>All Status</option>
                        <option value="active" ${param.status=='active' ? 'selected' : '' }>Active</option>
                        <option value="inactive" ${param.status=='inactive' ? 'selected' : '' }>Inactive</option>
                    </select>
                    <button type="submit" class="btn-search">Search</button>
                    <a href="supplier-list" class="btn-clear">Clear</a>
                </form>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Supplier Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty supplierList}">
                            <c:forEach items="${supplierList}" var="s">
                                <tr>
                                    <td>${s.partnerId}</td>
                                    <td><strong>${s.partnerName}</strong></td>
                                    <td>${s.partnerEmail}</td>
                                    <td>${s.partnerPhone}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${s.status == 'active'}">
                                                <span class="status-badge status-active">Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-inactive">Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="supplier-detail?id=${s.partnerId}" class="btn-view">View</a>
                                        <c:choose>
                                            <c:when test="${s.status == 'active'}">
                                                <a href="supplier-status?id=${s.partnerId}&status=active"
                                                   class="btn-block"
                                                   onclick="return confirm('Are you sure you want to block this supplier?')">Block</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="supplier-status?id=${s.partnerId}&status=inactive"
                                                   class="btn-unblock"
                                                   onclick="return confirm('Are you sure you want to unblock this supplier?')">Unblock</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="empty-state">
                                    <div>📦</div>
                                    <p>No suppliers found.</p>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <a href="<%= request.getContextPath()%>/dashboard" class="back-link">← Back to Dashboard</a>
        </div>

        <jsp:include page="footer.jsp" />
    </body>

</html>