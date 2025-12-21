<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

    <head>
        <title>Supplier Details - WMS</title>

        <style>
            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background-color: #f5f6fa;
                margin: 0;
                padding: 0;
                color: #2c3e50;
            }

            .container {
                max-width: 800px;
                margin: 40px auto;
                background-color: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.07);
            }

            .card-header {
                background-color: #2c3e50;
                color: white;
                padding: 20px 25px;
                border-radius: 10px 10px 0 0;
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin: -30px -30px 25px -30px;
            }

            .card-header h2 {
                margin: 0;
                font-weight: 600;
            }

            .id-badge {
                background: rgba(255, 255, 255, 0.2);
                padding: 6px 14px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 600;
            }

            .detail-row {
                display: flex;
                padding: 15px 0;
                border-bottom: 1px solid #f0f0f0;
            }

            .detail-row:last-child {
                border-bottom: none;
            }

            .detail-label {
                width: 150px;
                font-weight: 600;
                color: #7f8c8d;
                font-size: 14px;
            }

            .detail-value {
                flex: 1;
                font-size: 15px;
                color: #2c3e50;
            }

            .status-badge {
                padding: 5px 14px;
                border-radius: 20px;
                font-size: 12px;
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

            .type-badge {
                background: #e8f4fd;
                color: #3498db;
                padding: 5px 14px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
            }

            .actions {
                margin-top: 30px;
                padding-top: 20px;
                border-top: 1px solid #eee;
                display: flex;
                justify-content: flex-end;
                gap: 10px;
            }

            .btn-back {
                background-color: #95a5a6;
                color: white;
                padding: 10px 20px;
                border-radius: 6px;
                text-decoration: none;
                font-weight: 600;
                transition: background-color 0.2s;
            }

            .btn-back:hover {
                background-color: #7f8c8d;
            }

            .btn-edit {
                background-color: #3498db;
                color: white;
                padding: 10px 20px;
                border-radius: 6px;
                text-decoration: none;
                font-weight: 600;
                transition: background-color 0.2s;
            }

            .btn-edit:hover {
                background-color: #2980b9;
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="container">
            <div class="card-header">
                <h2>Supplier Details</h2>
                <span class="id-badge">ID: ${supplier.partnerId}</span>
            </div>

            <div class="detail-row">
                <div class="detail-label">Full Name</div>
                <div class="detail-value"><strong>${supplier.partnerName}</strong></div>
            </div>

            <div class="detail-row">
                <div class="detail-label">Email</div>
                <div class="detail-value">${supplier.partnerEmail}</div>
            </div>

            <div class="detail-row">
                <div class="detail-label">Phone</div>
                <div class="detail-value">${supplier.partnerPhone}</div>
            </div>

            <div class="detail-row">
                <div class="detail-label">Type</div>
                <div class="detail-value">
                    <span class="type-badge">
                        <c:choose>
                            <c:when test="${supplier.type == 1}">Supplier</c:when>
                            <c:when test="${supplier.type == 2}">Customer</c:when>
                        </c:choose>
                    </span>
                </div>
            </div>

            <div class="detail-row">
                <div class="detail-label">Status</div>
                <div class="detail-value">
                    <c:choose>
                        <c:when test="${supplier.status == 'active'}">
                            <span class="status-badge status-active">Active</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge status-inactive">Inactive</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="actions">
                <a href="supplier-list" class="btn-back">← Back to List</a>
                <a href="edit-supplier?id=${supplier.partnerId}" class="btn-edit">Edit Supplier</a>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
    </body>

</html>