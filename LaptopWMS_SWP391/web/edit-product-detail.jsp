<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

    <head>
        <title>Laptop Warehouse Management System</title>
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                background: #f5f6fa;
                margin: 0;
                padding: 0;
            }

            .form-container {
                max-width: 500px;
                margin: 40px auto;
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                color: #2c3e50;
                margin-top: 0;
            }

            .form-group {
                margin-bottom: 15px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: 600;
                color: #333;
            }

            input,
            select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }

            .btn-save {
                width: 100%;
                padding: 12px;
                background: #2ecc71;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 700;
            }

            .btn-save:hover {
                background: #27ae60;
            }

            .link-back {
                display: block;
                text-align: center;
                margin-top: 15px;
                color: #7f8c8d;
                text-decoration: none;
            }
        </style>
    </head>

    <body>

        <jsp:include page="header.jsp" />

        <div class="form-container">
            <h2>Edit Configuration</h2>
            <p style="text-align: center; color: #7f8c8d; font-size: 14px;">
                Editing Detail ID: <strong>${detail.productDetailId}</strong>
                <c:if test="${not empty detail.productName}">
                    for <strong>${detail.productName}</strong>
                </c:if>
            </p>

            <form action="edit-product-detail" method="post">
                <input type="hidden" name="id" value="${detail.productDetailId}">
                <input type="hidden" name="productId" value="${detail.productId}">

                <div class="form-group">
                    <label>CPU</label>
                    <input type="text" name="cpu" value="${detail.cpu}" required>
                </div>

                <div class="form-group">
                    <label>GPU</label>
                    <input type="text" name="gpu" value="${detail.gpu}">
                </div>

                <div class="form-group">
                    <label>RAM</label>
                    <input type="text" name="ram" value="${detail.ram}" required>
                </div>

                <div class="form-group">
                    <label>Storage</label>
                    <input type="text" name="storage" value="${detail.storage}" required>
                </div>

                <div class="form-group">
                    <label>Unit</label>
                    <select name="unit">
                        <option value="piece" ${detail.unit=='piece' ? 'selected' : '' }>Piece</option>
                        <option value="set" ${detail.unit=='set' ? 'selected' : '' }>Set</option>
                        <option value="box" ${detail.unit=='box' ? 'selected' : '' }>Box</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Quantity</label>
                    <input type="number" name="quantity" min="0" value="${detail.quantity}">
                </div>

                <button type="submit" class="btn-save">Update Configuration</button>

                <a href="product-list" class="link-back">Cancel</a>
            </form>
        </div>

        <jsp:include page="footer.jsp" />
    </body>

</html>