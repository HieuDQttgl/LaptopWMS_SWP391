<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                font-weight: bold;
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
            <h2>Create New Product</h2>

            <c:if test="${not empty error}">
                <div
                    style="color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 10px; margin-bottom: 15px; border-radius: 4px;">
                    <strong>Error:</strong> ${error}
                </div>
            </c:if>

            <form action="add-product" method="post">
                <div class="form-group">
                    <label>Model Name</label>
                    <input type="text" name="name" required placeholder="e.g. Dell XPS 15 9530">
                </div>

                <div class="form-group">
                    <label>Brand</label>
                    <select name="brand" required>
                        <option value="">-- Select Brand --</option>
                        <option value="Dell">Dell</option>
                        <option value="HP">HP</option>
                        <option value="ASUS">ASUS</option>
                        <option value="Apple">Apple</option>
                        <option value="Lenovo">Lenovo</option>
                        <option value="Acer">Acer</option>
                        <option value="MSI">MSI</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Category</label>
                    <select name="category">
                        <option value="Laptop" selected>Laptop</option>
                        <option value="Office">Office</option>
                        <option value="Gaming">Gaming</option>
                        <option value="Workstation">Workstation</option>
                    </select>
                </div>

                <button type="submit" class="btn-save">Create Product</button>
                <a href="product-list" class="link-back">Cancel</a>
            </form>
        </div>

        <jsp:include page="footer.jsp" />
    </body>

</html>