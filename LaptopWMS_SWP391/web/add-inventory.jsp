<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Laptop Warehouse Management System</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background-color: #f5f6fa;
                margin: 0;
                padding: 0px;
                color: #2c3e50;
            }

            .container {
                max-width: 1000px;
                margin: 40px auto;
                background-color: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.07);
            }

            h2, h1 {
                text-align: center;
                color: #2c3e50;
                font-weight: 700;
                margin-bottom: 25px;
                border-bottom: 2px solid #e5e5e5;
                padding-bottom: 15px;
            }
            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #333;
            }

            input[type="text"], input[type="number"], select, textarea {
                width: 100%;
                padding: 12px;
                border: 1px solid #dcdde1;
                border-radius: 6px;
                font-size: 14px;
                box-sizing: border-box;
            }

            /* Button Style */
            .btn-primary {
                background-color: #3498db;
                color: white;
                padding: 12px 25px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
                transition: background 0.3s;
            }

            .btn-primary:hover {
                background-color: #2980b9;
            }

            .btn-secondary {
                background-color: #95a5a6;
                color: white;
                text-decoration: none;
                padding: 12px 25px;
                border-radius: 6px;
                display: inline-block;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

            <div class="container">
                <h2>Add Products to Inventory</h2>

            <c:if test="${param.error == 'duplicate'}">
                <div style="color: #721c24; background-color: #f8d7da; padding: 15px; border-radius: 6px; margin-bottom: 20px;">
                    This product is already in inventory.
                </div>
            </c:if>

            <form action="add-inventory" method="post">
                <div class="form-group">
                    <label>Choose Product:</label>
                    <select name="productId" required class="form-select">
                        <option value="" disabled selected>Products Name</option>
                        <c:forEach items="${products}" var="p">
                            <option value="${p.productId}">${p.productName} (ID: ${p.productId})</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Choose Location:</label>
                    <select name="locationId" required>
                        <c:forEach items="${locations}" var="l">
                            <option value="${l.locationId}">${l.locationName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Quantity:</label>
                    <input type="text" value="0" readonly disabled style="background-color: #f1f2f6;">
                    <p style="font-size: 12px; color: #7f8c8d; margin-top: 5px;">Initial quantity is set to 0.</p>
                </div>

                <div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 30px;">
                    <a href="inventory" class="btn-secondary">Back</a>
                    <button type="submit" class="btn-primary">Submit</button>
                </div>
            </form>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>

    </body>
</html>