<%@page import="Model.TicketItem" %>
<%@page import="Model.Users" %>
<%@page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Ticket - WMS</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
            }

            .container {
                max-width: 900px;
                margin: 0 auto;
                padding: 30px 20px;
            }

            .card {
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
                padding: 40px;
            }

            h1 {
                color: #1e293b;
                margin-bottom: 30px;
                font-size: 28px;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .form-group {
                margin-bottom: 24px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #374151;
            }

            input[type="text"],
            textarea,
            select {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid #e5e7eb;
                border-radius: 10px;
                font-size: 15px;
                transition: all 0.3s;
            }

            input:focus,
            textarea:focus,
            select:focus {
                outline: none;
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            textarea {
                resize: vertical;
                min-height: 100px;
            }

            .type-selector {
                display: flex;
                gap: 20px;
                margin-bottom: 24px;
            }

            .type-option {
                flex: 1;
                padding: 20px;
                border: 3px solid #e5e7eb;
                border-radius: 12px;
                text-align: center;
                cursor: pointer;
                transition: all 0.3s;
            }

            .type-option:hover {
                border-color: #667eea;
            }

            .type-option.selected {
                border-color: #667eea;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .type-option.selected .type-icon {
                color: white;
            }

            .type-icon {
                font-size: 32px;
                margin-bottom: 8px;
            }

            .type-label {
                font-weight: 600;
                font-size: 16px;
            }

            .products-section {
                background: #f8fafc;
                border-radius: 12px;
                padding: 24px;
                margin-bottom: 24px;
            }

            .products-section h3 {
                margin-bottom: 16px;
                color: #374151;
            }

            .product-row {
                display: flex;
                gap: 12px;
                margin-bottom: 12px;
                align-items: center;
            }

            .product-row select {
                flex: 2;
            }

            .product-row input[type="number"] {
                flex: 1;
                padding: 12px;
                border: 2px solid #e5e7eb;
                border-radius: 10px;
            }

            .btn-remove {
                background: #ef4444;
                color: white;
                border: none;
                width: 40px;
                height: 40px;
                border-radius: 10px;
                cursor: pointer;
                font-size: 18px;
                transition: all 0.3s;
            }

            .btn-remove:hover {
                background: #dc2626;
            }

            .btn-add {
                background: #10b981;
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 10px;
                cursor: pointer;
                font-weight: 600;
                transition: all 0.3s;
            }

            .btn-add:hover {
                background: #059669;
            }

            .btn-submit {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                padding: 16px 40px;
                border-radius: 12px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                width: 100%;
                transition: all 0.3s;
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            }

            .btn-back {
                display: inline-block;
                color: #667eea;
                text-decoration: none;
                margin-bottom: 20px;
                font-weight: 500;
            }

            .btn-back:hover {
                text-decoration: underline;
            }

            .error-message {
                background: #fef2f2;
                border: 1px solid #fecaca;
                color: #dc2626;
                padding: 12px 16px;
                border-radius: 10px;
                margin-bottom: 20px;
            }

            .stock-info {
                font-size: 12px;
                color: #6b7280;
                margin-top: 4px;
            }
        </style>
    </head>

    <body>
        <%@include file="header.jsp" %>

        <div class="container">
            <a href="<%= request.getContextPath()%>/ticket-list" class="btn-back">← Back to Tickets</a>

            <div class="card">
                <h1>📝 Create New Ticket</h1>

                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) {%>
                <div class="error-message">
                    <%= error%>
                </div>
                <% } %>

                <form method="post" id="ticketForm">
                    <!-- Ticket Type -->
                    <div class="form-group">
                        <label>Ticket Type *</label>
                        <div class="type-selector">
                            <div class="type-option" onclick="selectType('IMPORT')"
                                 id="type-import">
                                <div class="type-icon">📥</div>
                                <div class="type-label">IMPORT</div>
                                <div style="font-size: 13px; color: #6b7280;">Nhập hàng vào
                                    kho</div>
                            </div>
                            <div class="type-option" onclick="selectType('EXPORT')"
                                 id="type-export">
                                <div class="type-icon">📤</div>
                                <div class="type-label">EXPORT</div>
                                <div style="font-size: 13px; color: #6b7280;">Xuất hàng ra
                                    kho</div>
                            </div>
                        </div>
                        <input type="hidden" name="type" id="ticketType" required>
                    </div>

                    <!-- Title -->
                    <div class="form-group">
                        <label for="title">Title *</label>
                        <input type="text" id="title" name="title"
                               placeholder="Enter ticket title" required>
                    </div>

                    <!-- Description -->
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea id="description" name="description"
                                  placeholder="Enter description (optional)"></textarea>
                    </div>

                    <!-- Assign Keeper -->
                    <div class="form-group">
                        <label for="keeperId">Assign to Keeper</label>
                        <select id="keeperId" name="keeperId">
                            <option value="">-- Select Keeper --</option>
                            <% List<Users> keepers = (List<Users>) request.getAttribute("keepers");
                                if (keepers != null) {
                                    for (Users keeper : keepers) {
                            %>
                            <option value="<%= keeper.getUserId()%>">
                                <%= keeper.getFullName()%> (<%=keeper.getUsername()%>)
                            </option>
                            <% }
                                                                    } %>
                        </select>
                    </div>

                    <!-- Products -->
                    <div class="products-section">
                        <h3>📦 Products</h3>
                        <div id="productRows">
                            <div class="product-row">
                                <select name="productDetailId" required>
                                    <option value="">-- Select Product --</option>
                                    <% List<TicketItem> products = (List<TicketItem>) request.getAttribute("products");
                                        if (products != null) {
                                            for (TicketItem p : products) {
                                    %>
                                    <option value="<%= p.getProductDetailId()%>"
                                            data-stock="<%= p.getCurrentStock()%>">
                                        <%= p.getProductName()%> - <%=p.getProductConfig()%> (Stock: <%=p.getCurrentStock()%>)
                                    </option>
                                    <% }
                                                                            }%>
                                </select>
                                <input type="number" name="quantity" placeholder="Qty"
                                       min="1" value="1" required>
                                <button type="button" class="btn-remove"
                                        onclick="removeRow(this)"
                                        style="visibility: hidden;">×</button>
                            </div>
                        </div>
                        <button type="button" class="btn-add" onclick="addProductRow()">+
                            Add Product</button>
                    </div>

                    <!-- Submit -->
                    <button type="submit" class="btn-submit">Create Ticket</button>
                </form>
            </div>
        </div>

        <script>
            function selectType(type) {
                document.getElementById('ticketType').value = type;
                document.querySelectorAll('.type-option').forEach(el => el.classList.remove('selected'));
                document.getElementById('type-' + type.toLowerCase()).classList.add('selected');
            }

            function addProductRow() {
                const container = document.getElementById('productRows');
                const firstRow = container.querySelector('.product-row');
                const newRow = firstRow.cloneNode(true);

                newRow.querySelector('select').value = '';
                newRow.querySelector('input').value = '1';
                newRow.querySelector('.btn-remove').style.visibility = 'visible';

                container.appendChild(newRow);
                updateRemoveButtons();
            }

            function removeRow(btn) {
                const row = btn.closest('.product-row');
                row.remove();
                updateRemoveButtons();
            }

            function updateRemoveButtons() {
                const rows = document.querySelectorAll('.product-row');
                rows.forEach((row, index) => {
                    const btn = row.querySelector('.btn-remove');
                    btn.style.visibility = rows.length > 1 ? 'visible' : 'hidden';
                });
            }

            document.getElementById('ticketForm').addEventListener('submit', function (e) {
                if (!document.getElementById('ticketType').value) {
                    e.preventDefault();
                    alert('Please select a ticket type');
                }
            });
        </script>
    </body>

</html>