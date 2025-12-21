<%@page import="Model.Ticket" %>
<%@page import="Model.TicketItem" %>
<%@page import="Model.Users" %>
<%@page import="Model.Partners" %>
<%@page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Ticket - WMS</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: "Segoe UI", sans-serif;
                background: #f5f6fa;
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
            
            .type-option.disabled {
                opacity: 0.6;
                cursor: not-allowed;
                pointer-events: none;
            }
        </style>
    </head>

    <body>
        <%@include file="header.jsp" %>
        <%
            Ticket ticket = (Ticket) request.getAttribute("ticket");
            List<Users> keepers = (List<Users>) request.getAttribute("keepers");
            List<TicketItem> allProducts = (List<TicketItem>) request.getAttribute("availableProducts");
            List<Partners> partners = (List<Partners>) request.getAttribute("partners");
        %>

        <div class="container">
            <a href="<%= request.getContextPath()%>/ticket-list" class="btn-back">← Back to List</a>

            <div class="card">
                <h1>📝 Edit Ticket #<%= ticket.getTicketId()%></h1>

                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) {%>
                <div class="error-message"><%= error%></div>
                <% }%>

                <form action="edit-ticket" method="post" id="ticketForm">
                    <input type="hidden" name="ticketId" value="<%= ticket.getTicketId()%>">

                    <div class="form-group">
                        <label>Ticket Type (Cannot change)</label>
                        <div class="type-selector">
                            <div class="type-option <%= "IMPORT".equals(ticket.getType()) ? "selected" : "disabled"%>">
                                <div class="type-icon">📥</div>
                                <div class="type-label">IMPORT</div>
                            </div>
                            <div class="type-option <%= "EXPORT".equals(ticket.getType()) ? "selected" : "disabled"%>">
                                <div class="type-icon">📤</div>
                                <div class="type-label">EXPORT</div>
                            </div>
                        </div>
                        <input type="hidden" name="type" value="<%= ticket.getType()%>">
                    </div>

                    <div class="form-group">
                        <label for="title">Title *</label>
                        <input type="text" id="title" name="title" value="<%= ticket.getTitle()%>" required>
                    </div>

                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea id="description" name="description"><%= ticket.getDescription() != null ? ticket.getDescription() : ""%></textarea>
                    </div>

                    <div class="form-group">
                        <label for="keeperId">Assign to Keeper *</label>
                        <select id="keeperId" name="keeperId" required>
                            <% if (keepers != null) {
                                    for (Users k : keepers) {%>
                            <option value="<%= k.getUserId()%>" <%= k.getUserId() == ticket.getAssignedKeeper() ? "selected" : ""%>>
                                <%= k.getFullName()%> (<%= k.getUsername()%>)
                            </option>
                            <% }
                                }%>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="partnerId"><%= "IMPORT".equals(ticket.getType()) ? "Supplier" : "Customer"%></label>
                        <select id="partnerId" name="partnerId">
                            <% if (partners != null) {
                                    for (Partners p : partners) {%>
                            <option value="<%= p.getPartnerId()%>" <%= p.getPartnerId() == ticket.getPartnerId() ? "selected" : ""%>>
                                <%= p.getPartnerName()%>
                            </option>
                            <% }
                                } %>
                        </select>
                    </div>

                    <div class="products-section">
                        <h3>📦 Products</h3>
                        <div id="productRows">
                            <%
                                List<TicketItem> currentItems = ticket.getItems();
                                if (currentItems != null && !currentItems.isEmpty()) {
                                    for (TicketItem item : currentItems) {
                            %>
                            <div class="product-row">
                                <select name="productDetailId" required onchange="updateProductOptions()">
                                    <% for (TicketItem p : allProducts) {%>
                                    <option value="<%= p.getProductDetailId()%>" 
                                            data-stock="<%= p.getCurrentStock()%>"
                                            <%= p.getProductDetailId() == item.getProductDetailId() ? "selected" : ""%>>
                                        <%= p.getProductName()%> - <%= p.getProductConfig()%> (Stock: <%= p.getCurrentStock()%>)
                                    </option>
                                    <% }%>
                                </select>
                                <input type="number" name="quantity" min="1" value="<%= item.getQuantity()%>" required>
                                <button type="button" class="btn-remove" onclick="removeRow(this)">×</button>
                            </div>
                            <% }
                            } else { %>
                            <div class="product-row">
                                <select name="productDetailId" required onchange="updateProductOptions()">
                                    <option value="">-- Select Product --</option>
                                    <% for (TicketItem p : allProducts) {%>
                                    <option value="<%= p.getProductDetailId()%>" data-stock="<%= p.getCurrentStock()%>">
                                        <%= p.getProductName()%> - <%= p.getProductConfig()%>
                                    </option>
                                    <% } %>
                                </select>
                                <input type="number" name="quantity" min="1" value="1" required>
                                <button type="button" class="btn-remove" onclick="removeRow(this)" style="visibility: hidden;">×</button>
                            </div>
                            <% }%>
                        </div>
                        <button type="button" class="btn-add" onclick="addProductRow()">+ Add Product</button>
                    </div>

                    <button type="submit" class="btn-submit">Save Changes</button>
                </form>
            </div>
        </div>

        <script>

            function addProductRow() {
                const container = document.getElementById('productRows');
                const rows = container.querySelectorAll('.product-row');
                const newRow = rows[0].cloneNode(true);

                const newSelect = newRow.querySelector('select');
                newSelect.value = '';
                newRow.querySelector('input').value = '1';
                newRow.querySelector('.btn-remove').style.visibility = 'visible';

                container.appendChild(newRow);
                updateRemoveButtons();
                updateProductOptions();
            }

            function removeRow(btn) {
                const row = btn.closest('.product-row');
                row.remove();
                updateRemoveButtons();
                updateProductOptions();
            }

            function updateRemoveButtons() {
                const rows = document.querySelectorAll('.product-row');
                rows.forEach((row) => {
                    row.querySelector('.btn-remove').style.visibility = rows.length > 1 ? 'visible' : 'hidden';
                });
            }

            function updateProductOptions() {
                const selects = document.querySelectorAll('select[name="productDetailId"]');
                const selectedValues = Array.from(selects).map(s => s.value).filter(v => v !== "");

                selects.forEach(select => {
                    Array.from(select.options).forEach(option => {
                        if (option.value !== "" && option.value !== select.value) {
                            option.disabled = selectedValues.includes(option.value);
                        }
                    });
                });
            }

            document.addEventListener('DOMContentLoaded', updateProductOptions);
        </script>
    </body>
</html>