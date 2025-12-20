<%@ page contentType="text/html" pageEncoding="UTF-8" %>
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
            <h2>Add Configuration</h2>
            <p style="text-align: center; color: #7f8c8d; font-size: 14px;">Adding specs for Product:
                <strong>${targetName}</strong></p>

            <form action="add-product-detail" method="post">
                <input type="hidden" name="productId" value="${targetId}">

                <div class="form-group">
                    <label>CPU</label>
                    <input type="text" name="cpu" placeholder="e.g. Intel Core i7-13700H" required>
                </div>

                <div class="form-group">
                    <label>GPU</label>
                    <input type="text" name="gpu" placeholder="e.g. NVIDIA RTX 4060 8GB">
                </div>

                <div class="form-group">
                    <label>RAM</label>
                    <input type="text" name="ram" placeholder="e.g. 16GB" required>
                </div>

                <div class="form-group">
                    <label>Storage</label>
                    <input type="text" name="storage" placeholder="e.g. 512GB SSD" required>
                </div>

                <div class="form-group">
                    <label>Unit</label>
                    <select name="unit">
                        <option value="piece" selected>Piece</option>
                        <option value="set">Set</option>
                        <option value="box">Box</option>
                    </select>
                </div>

                <button type="submit" class="btn-save">Save Configuration</button>
                <a href="product-list" class="link-back">Cancel</a>
            </form>
        </div>

        <jsp:include page="footer.jsp" />
    </body>

</html>