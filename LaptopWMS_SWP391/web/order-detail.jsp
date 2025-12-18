<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Laptop Warehouse Management System</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
            h2 {
                color: #2c3e50;
                font-weight: 700;
                border-bottom: 2px solid #e5e5e5;
                padding-bottom: 10px;
                margin-bottom: 25px;
            }
            h3 {
                color: #34495e;
                font-weight: 600;
                margin-top: 25px;
                margin-bottom: 15px;
            }
            .detail-card {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                margin-bottom: 20px;
            }
            .info-block {
                flex: 1 1 300px;
                background-color: #f9f9f9;
                padding: 15px;
                border-radius: 8px;
                border-left: 5px solid #3498db;
            }
            .info-block.status {
                 border-left-color: #2ecc71;
            }
            .info-block p {
                margin: 5px 0;
                line-height: 1.4;
            }
            .info-block strong {
                display: inline-block;
                width: 120px;
                color: #7f8c8d;
                font-weight: 500;
            }
            .badge-status {
                display: inline-block;
                padding: 5px 10px;
                border-radius: 20px;
                font-weight: 600;
                font-size: 12px;
                text-transform: capitalize;
            }
            .badge-status-pending { background-color: #ecf0f1; color: #7f8c8d; }
            .badge-status-approved { background-color: #fcf8e3; color: #8a6d3b; }
            .badge-status-shipping { background-color: #d9edf7; color: #31708f; }
            .badge-status-completed { background-color: #dff0d8; color: #3c763d; }
            .badge-status-cancelled { background-color: #f2dede; color: #a94442; }

            .product-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
            }
            .product-table th, .product-table td {
                padding: 12px;
                border: 1px solid #e0e0e0;
                text-align: left;
            }
            .product-table th {
                background-color: #f0f0f0;
                color: #34495e;
                font-size: 14px;
                text-transform: uppercase;
            }
            .product-table tfoot td {
                background-color: #eaf2f8;
                font-weight: 700;
                border-top: 3px solid #ccc;
            }
            .text-right {
                text-align: right;
            }
            .back-button {
                display: inline-block;
                margin-bottom: 20px;
                text-decoration: none;
                background-color: #95a5a6;
                color: white;
                padding: 8px 15px;
                border-radius: 4px;
                transition: background-color 0.3s;
            }
            .back-button:hover {
                 background-color: #7f8c8d;
            }
            .spec-label {
                font-size: 13px;
                color: #3498db;
                margin-top: 4px;
                display: block;
            }
            .spec-label i {
                width: 16px;
                margin-right: 4px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        
        <div class="container">
            <a href="order-list" class="back-button"><i class="fas fa-arrow-left"></i> Back </a>
            
            <h2><i class="fas fa-receipt"></i> Order Detail: ${order.orderCode}</h2>
            
            <h3><i class="fas fa-info-circle"></i> Common Information</h3>
            <div class="detail-card">
                <div class="info-block status">
                    <p><strong>Status:</strong> 
                        <span class="badge-status badge-status-${order.orderStatus.toLowerCase()}">
                            ${order.orderStatus}
                        </span>
                    </p>
                    <p><strong>Order Type:</strong> 
                        <c:choose>
                            <c:when test="${not empty order.customerName}">
                                <span class="badge-status" style="background-color: #ffe7e6; color: #f5222d;">Export</span>
                            </c:when>
                            <c:when test="${not empty order.supplierName}">
                                <span class="badge-status" style="background-color: #e6f7ff; color: #1890ff;">Import</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge-status" style="background-color: #f0f0f0; color: #7f8c8d;">N/A</span>
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
                
                <div class="info-block">
                    <p><strong>Order Code:</strong> ${order.orderCode}</p>
                    <p><strong>Description:</strong> ${not empty order.description ? order.description : "Không có"}</p>
                </div>
                
                <div class="info-block">
                    <p><strong>Created At:</strong> <fmt:formatDate value="${order.createdAt}" pattern="dd-MM-yyyy HH:mm"/></p>
                    <p><strong>Created By:</strong> ${order.createdByName}</p>
                    <p><strong>Updated At:</strong> <fmt:formatDate value="${order.updatedAt}" pattern="dd-MM-yyyy HH:mm"/></p>
                </div>
            </div>

            <h3><i class="fas fa-handshake"></i> Partner Information</h3>
            <div class="detail-card">
                <c:choose>
                    <c:when test="${not empty order.customerName}">
                        <div class="info-block" style="border-left-color: #38c172; flex: 1 1 450px;">
                            <p><strong>Partner Type:</strong> Customer </p>
                            <p><strong>Name:</strong> ${order.customerName}</p>
                        </div>
                    </c:when>
                    <c:when test="${not empty order.supplierName}">
                        <div class="info-block" style="border-left-color: #f6993f; flex: 1 1 450px;">
                            <p><strong>Partner Type:</strong> Supplier </p>
                            <p><strong>Name:</strong> ${order.supplierName}</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="info-block" style="border-left-color: #e74c3c;">
                            <p>No partner information available.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <h3><i class="fas fa-boxes"></i> Product List</h3>
            <c:choose>
                <c:when test="${not empty orderProducts}">
                    <table class="product-table">
                        <thead>
                            <tr>
                                <th style="width: 50px;">#</th>
                                <th>Product & Configuration</th>
                                <th class="text-right" style="width: 100px;">Qty</th>
                                <th class="text-right" style="width: 150px;">Unit Price</th>
                                <th class="text-right" style="width: 180px;">Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="grandTotal" value="0" />
                            <c:forEach var="item" items="${orderProducts}" varStatus="loop">
                                <c:set var="lineTotal" value="${item.quantity * item.unitPrice}" />
                                <c:set var="grandTotal" value="${grandTotal + lineTotal}" />
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>
                                        <div style="font-weight: 600;">${item.productName}</div>
                                        <div class="spec-label">
                                            <i class="fas fa-microchip"></i>${item.cpu} | 
                                            <i class="fas fa-memory"></i>${item.ram} | 
                                            <i class="fas fa-hdd"></i>${item.storage} |
                                            <i class="fas fa-desktop"></i>${item.screen}"
                                        </div>
                                    </td>
                                    <td class="text-right">${item.quantity}</td>
                                    <td class="text-right"><fmt:formatNumber value="${item.unitPrice}" pattern="#,##0₫" /></td>
                                    <td class="text-right" style="font-weight: 600;">
                                        <fmt:formatNumber value="${lineTotal}" pattern="#,##0₫" />
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="4" class="text-right">GRAND TOTAL</td>
                                <td class="text-right" style="font-size: 1.2em; color: #e74c3c;">
                                    <fmt:formatNumber value="${grandTotal}" pattern="#,##0₫" />
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </c:when>
                <c:otherwise>
                    <div style="padding: 15px; background-color: #fef0f0; border: 1px solid #eccdcd; color: #a94442; border-radius: 6px;">
                        <i class="fas fa-exclamation-triangle"></i> This order has no product.
                    </div>
                </c:otherwise>
            </c:choose>
        </div> 
        <jsp:include page="footer.jsp"/>
    </body>
</html>