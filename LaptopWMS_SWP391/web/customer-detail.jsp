<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <jsp:include page="header.jsp" />
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Laptop Warehouse Management System</title>
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 1200px;
                margin: 40px auto;
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
            .actions a {
                margin-right: 6px;
                text-decoration: none;
                padding: 4px 8px;
                border-radius: 4px;
            }

            .btn-view {
                background: #3498db;
                color: white;
            }
            .btn-edit {
                background: #f39c12;
                color: white;
            }
            .btn-order {
                background: #2ecc71;
                color: white;
            }

        </style>
    </head>

    <body>
        <div class="container">
            <h1>Customer Detail</h1>

            <!-- CUSTOMER INFO -->
            <div class="detail-box">
                <h2>Customer Information</h2>
                <table class="detail-table">
                    <tr>
                        <th>ID</th>
                        <td>${customer.customerId}</td>
                    </tr>
                    <tr>
                        <th>Name</th>
                        <td>${customer.customerName}</td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td>${customer.email}</td>
                    </tr>
                    <tr>
                        <th>Phone</th>
                        <td>${customer.phone}</td>
                    </tr>
                    <tr>
                        <th>Address</th>
                        <td>${customer.address}</td>
                    </tr>
                </table>
            </div>

            <!-- ORDER SUMMARY -->
            <div class="detail-box">
                <h2>Order History Summary</h2>
                <table class="detail-table">
                    <tr>
                        <th>Total Orders</th>
                        <td>${summary.totalOrders}</td>
                    </tr>
                    <tr>
                        <th>Total Value</th>
                        <td>$${summary.totalValue}</td>
                    </tr>
                    <tr>
                        <th>Last Order Date</th>
                        <td>
                    <c:choose>
                        <c:when test="${not empty summary.lastOrderDate}">
                            ${summary.lastOrderDate}
                        </c:when>
                        <c:otherwise>—</c:otherwise>
                    </c:choose>
                    </td>
                    </tr>
                </table>
            </div>

            <!-- RECENT ORDERS -->
            <div class="detail-box">
                <h2>Recent Orders</h2>

                <table class="list-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Order Code</th>
                            <th>Status</th>
                            <th>Created Date</th>
                            <th>Total Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${not empty recentOrders}">
                            <c:forEach var="o" items="${recentOrders}">
                                <tr>
                                    <td>${o.orderId}</td>
                                    <td>${o.orderCode}</td>
                                    <td>${o.orderStatus}</td>
                                    <td>${o.createdAt}</td>
                                    <td>$${o.totalAmount}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" style="text-align:center;">
                                    No orders found.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- NOTES / COMMENTS -->
            <div class="detail-box">
                <h2>Customer Notes / Comments</h2>
                <p style="color:#7f8c8d;">
                    (Feature prepared – can be extended with customer_notes table)
                </p>
            </div>

            <a href="${pageContext.request.contextPath}/customer-list"
               class="btn-secondary">
                Back to Customer List
            </a>
        </div>

        <jsp:include page="footer.jsp" />
    </body>

</html>
