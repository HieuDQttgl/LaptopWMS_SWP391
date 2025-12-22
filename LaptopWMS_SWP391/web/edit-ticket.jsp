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
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Edit Ticket | Laptop WMS</title>
                            <link
                                href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                                rel="stylesheet">
                            <style>
                                body {
                                    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                                    background: linear-gradient(135deg, #f0f4ff 0%, #f8fafc 50%, #f0fdf4 100%);
                                    margin: 0;
                                    padding: 0;
                                    min-height: 100vh;
                                }

                                .page-container {
                                    max-width: 900px;
                                    margin: 0 auto;
                                    padding: 2rem;
                                }

                                .back-link {
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 0.5rem;
                                    margin-bottom: 1.5rem;
                                    font-size: 0.875rem;
                                    color: #667eea;
                                    text-decoration: none;
                                    font-weight: 500;
                                }

                                .back-link:hover {
                                    color: #764ba2;
                                }

                                .card {
                                    background: white;
                                    border-radius: 1rem;
                                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                                    padding: 2.5rem;
                                    border: 1px solid #f1f5f9;
                                    animation: fadeIn 0.3s ease-out;
                                }

                                @keyframes fadeIn {
                                    from {
                                        opacity: 0;
                                        transform: translateY(-10px);
                                    }

                                    to {
                                        opacity: 1;
                                        transform: translateY(0);
                                    }
                                }

                                h1 {
                                    color: #1e293b;
                                    margin: 0 0 2rem 0;
                                    font-size: 1.75rem;
                                    font-weight: 700;
                                    display: flex;
                                    align-items: center;
                                    gap: 0.75rem;
                                }

                                .form-group {
                                    margin-bottom: 1.5rem;
                                }

                                label {
                                    display: block;
                                    margin-bottom: 0.5rem;
                                    font-weight: 600;
                                    color: #475569;
                                    font-size: 0.875rem;
                                }

                                input[type="text"],
                                textarea,
                                select {
                                    width: 100%;
                                    padding: 0.875rem 1rem;
                                    border: 2px solid #e2e8f0;
                                    border-radius: 0.5rem;
                                    font-size: 0.9375rem;
                                    transition: all 0.2s ease;
                                    box-sizing: border-box;
                                    outline: none;
                                    font-family: inherit;
                                }

                                input:focus,
                                textarea:focus,
                                select:focus {
                                    border-color: #667eea;
                                    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                                }

                                textarea {
                                    resize: vertical;
                                    min-height: 100px;
                                }

                                .type-selector {
                                    display: flex;
                                    gap: 1rem;
                                    margin-bottom: 1.5rem;
                                }

                                .type-option {
                                    flex: 1;
                                    padding: 1.5rem;
                                    border: 3px solid #e2e8f0;
                                    border-radius: 0.75rem;
                                    text-align: center;
                                    transition: all 0.2s ease;
                                }

                                .type-option.selected {
                                    border-color: #667eea;
                                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                    color: white;
                                }

                                .type-option.disabled {
                                    opacity: 0.5;
                                    cursor: not-allowed;
                                }

                                .type-icon {
                                    font-size: 2rem;
                                    margin-bottom: 0.5rem;
                                }

                                .type-label {
                                    font-weight: 700;
                                    font-size: 1rem;
                                }

                                .products-section {
                                    background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
                                    border-radius: 0.75rem;
                                    padding: 1.5rem;
                                    margin-bottom: 1.5rem;
                                }

                                .products-section h3 {
                                    margin: 0 0 1rem 0;
                                    color: #475569;
                                    font-size: 1rem;
                                    font-weight: 600;
                                }

                                .product-row {
                                    display: flex;
                                    gap: 0.75rem;
                                    margin-bottom: 0.75rem;
                                    align-items: center;
                                }

                                .product-row select {
                                    flex: 2;
                                }

                                .product-row input[type="number"] {
                                    flex: 1;
                                    padding: 0.875rem 1rem;
                                    border: 2px solid #e2e8f0;
                                    border-radius: 0.5rem;
                                    font-size: 0.9375rem;
                                    outline: none;
                                }

                                .btn-remove {
                                    background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                                    color: white;
                                    border: none;
                                    width: 44px;
                                    height: 44px;
                                    border-radius: 0.5rem;
                                    cursor: pointer;
                                    font-size: 1.25rem;
                                    transition: all 0.2s ease;
                                    flex-shrink: 0;
                                }

                                .btn-remove:hover {
                                    transform: scale(1.05);
                                }

                                .btn-add {
                                    background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                                    color: white;
                                    border: none;
                                    padding: 0.75rem 1.5rem;
                                    border-radius: 0.5rem;
                                    cursor: pointer;
                                    font-weight: 600;
                                    font-size: 0.875rem;
                                    transition: all 0.2s ease;
                                }

                                .btn-add:hover {
                                    transform: translateY(-1px);
                                    box-shadow: 0 4px 12px rgba(16, 185, 129, 0.4);
                                }

                                .btn-submit {
                                    width: 100%;
                                    padding: 1rem;
                                    background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
                                    color: white;
                                    border: none;
                                    border-radius: 0.5rem;
                                    font-size: 1rem;
                                    font-weight: 600;
                                    cursor: pointer;
                                    transition: all 0.2s ease;
                                    box-shadow: 0 4px 14px rgba(245, 158, 11, 0.4);
                                }

                                .btn-submit:hover {
                                    transform: translateY(-2px);
                                    box-shadow: 0 6px 20px rgba(245, 158, 11, 0.5);
                                }

                                .error-message {
                                    display: flex;
                                    align-items: center;
                                    gap: 0.5rem;
                                    padding: 1rem 1.25rem;
                                    background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                                    border: 1px solid #fca5a5;
                                    color: #dc2626;
                                    border-radius: 0.75rem;
                                    margin-bottom: 1.5rem;
                                    font-weight: 500;
                                }

                                @media (max-width: 768px) {
                                    .page-container {
                                        padding: 1rem;
                                    }

                                    .card {
                                        padding: 1.5rem;
                                    }

                                    .type-selector {
                                        flex-direction: column;
                                    }

                                    .product-row {
                                        flex-wrap: wrap;
                                    }

                                    .product-row select {
                                        flex: 1 1 100%;
                                    }
                                }
                            </style>
                        </head>

                        <body>
                            <%@include file="header.jsp" %>
                                <% Ticket ticket=(Ticket) request.getAttribute("ticket"); List<Users> keepers = (List
                                    <Users>) request.getAttribute("keepers");
                                        List<TicketItem> allProducts = (List<TicketItem>)
                                                request.getAttribute("availableProducts");
                                                List<Partners> partners = (List<Partners>)
                                                        request.getAttribute("partners");
                                                        %>

                                                        <div class="page-container">
                                                            <a href="<%= request.getContextPath()%>/ticket-list"
                                                                class="back-link">← Back to Tickets</a>

                                                            <div class="card">
                                                                <h1>✏️ Edit Ticket #<%= ticket.getTicketId()%>
                                                                </h1>

                                                                <% String error=(String) request.getAttribute("error");
                                                                    %>
                                                                    <% if (error !=null) {%>
                                                                        <div class="error-message">⚠ <%= error%>
                                                                        </div>
                                                                        <% }%>

                                                                            <form action="edit-ticket" method="post"
                                                                                id="ticketForm">
                                                                                <input type="hidden" name="ticketId"
                                                                                    value="<%= ticket.getTicketId()%>">

                                                                                <div class="form-group">
                                                                                    <label>Ticket Type (Cannot
                                                                                        change)</label>
                                                                                    <div class="type-selector">
                                                                                        <div class="type-option <%= "IMPORT".equals(ticket.getType())
                                                                                            ? "selected" : "disabled" %>
                                                                                            ">
                                                                                            <div class="type-icon">📥
                                                                                            </div>
                                                                                            <div class="type-label">
                                                                                                IMPORT</div>
                                                                                        </div>
                                                                                        <div class="type-option <%= "EXPORT".equals(ticket.getType())
                                                                                            ? "selected" : "disabled" %>
                                                                                            ">
                                                                                            <div class="type-icon">📤
                                                                                            </div>
                                                                                            <div class="type-label">
                                                                                                EXPORT</div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <input type="hidden" name="type"
                                                                                        value="<%= ticket.getType()%>">
                                                                                </div>

                                                                                <div class="form-group">
                                                                                    <label for="title">Title *</label>
                                                                                    <input type="text" id="title"
                                                                                        name="title"
                                                                                        value="<%= ticket.getTitle()%>"
                                                                                        required>
                                                                                </div>

                                                                                <div class="form-group">
                                                                                    <label
                                                                                        for="description">Description</label>
                                                                                    <textarea id="description"
                                                                                        name="description"><%= ticket.getDescription() != null ? ticket.getDescription() : ""%></textarea>
                                                                                </div>

                                                                                <div class="form-group">
                                                                                    <label for="keeperId">Assign to
                                                                                        Keeper *</label>
                                                                                    <select id="keeperId"
                                                                                        name="keeperId" required>
                                                                                        <% if (keepers !=null) { for
                                                                                            (Users k : keepers) { %>
                                                                                            <option
                                                                                                value="<%= k.getUserId()%>"
                                                                                                <%=k.getUserId()==ticket.getAssignedKeeper()
                                                                                                ? "selected" : "" %>>
                                                                                                <%= k.getFullName()%> (
                                                                                                    <%=
                                                                                                        k.getUsername()%>
                                                                                                        )
                                                                                            </option>
                                                                                            <% } } %>
                                                                                    </select>
                                                                                </div>

                                                                                <div class="form-group">
                                                                                    <label for="partnerId">
                                                                                        <%= "IMPORT"
                                                                                            .equals(ticket.getType())
                                                                                            ? "Supplier" : "Customer" %>
                                                                                    </label>
                                                                                    <select id="partnerId"
                                                                                        name="partnerId">
                                                                                        <% if (partners !=null) { for
                                                                                            (Partners p : partners) { %>
                                                                                            <option
                                                                                                value="<%= p.getPartnerId()%>"
                                                                                                <%=p.getPartnerId()==ticket.getPartnerId()
                                                                                                ? "selected" : "" %>>
                                                                                                <%= p.getPartnerName()%>
                                                                                            </option>
                                                                                            <% } } %>
                                                                                    </select>
                                                                                </div>

                                                                                <div class="products-section">
                                                                                    <h3>📦 Products</h3>
                                                                                    <div id="productRows">
                                                                                        <% List<TicketItem> currentItems
                                                                                            = ticket.getItems();
                                                                                            if (currentItems != null &&
                                                                                            !currentItems.isEmpty()) {
                                                                                            for (TicketItem item :
                                                                                            currentItems) {
                                                                                            %>
                                                                                            <div class="product-row">
                                                                                                <select
                                                                                                    name="productDetailId"
                                                                                                    required
                                                                                                    onchange="updateProductOptions()">
                                                                                                    <% for (TicketItem p
                                                                                                        : allProducts)
                                                                                                        {%>
                                                                                                        <option
                                                                                                            value="<%= p.getProductDetailId()%>"
                                                                                                            data-stock="<%= p.getCurrentStock()%>"
                                                                                                            <%=p.getProductDetailId()==item.getProductDetailId()
                                                                                                            ? "selected"
                                                                                                            : "" %>>
                                                                                                            <%=
                                                                                                                p.getProductName()%>
                                                                                                                - <%=
                                                                                                                    p.getProductConfig()%>
                                                                                                                    (Stock:
                                                                                                                    <%=
                                                                                                                        p.getCurrentStock()%>
                                                                                                                        )
                                                                                                        </option>
                                                                                                        <% }%>
                                                                                                </select>
                                                                                                <input type="number"
                                                                                                    name="quantity"
                                                                                                    min="1"
                                                                                                    value="<%= item.getQuantity()%>"
                                                                                                    required>
                                                                                                <button type="button"
                                                                                                    class="btn-remove"
                                                                                                    onclick="removeRow(this)">×</button>
                                                                                            </div>
                                                                                            <% } } else { %>
                                                                                                <div
                                                                                                    class="product-row">
                                                                                                    <select
                                                                                                        name="productDetailId"
                                                                                                        required
                                                                                                        onchange="updateProductOptions()">
                                                                                                        <option
                                                                                                            value="">--
                                                                                                            Select
                                                                                                            Product --
                                                                                                        </option>
                                                                                                        <% for
                                                                                                            (TicketItem
                                                                                                            p :
                                                                                                            allProducts)
                                                                                                            {%>
                                                                                                            <option
                                                                                                                value="<%= p.getProductDetailId()%>"
                                                                                                                data-stock="<%= p.getCurrentStock()%>">
                                                                                                                <%=
                                                                                                                    p.getProductName()%>
                                                                                                                    -
                                                                                                                    <%=
                                                                                                                        p.getProductConfig()%>
                                                                                                            </option>
                                                                                                            <% } %>
                                                                                                    </select>
                                                                                                    <input type="number"
                                                                                                        name="quantity"
                                                                                                        min="1"
                                                                                                        value="1"
                                                                                                        required>
                                                                                                    <button
                                                                                                        type="button"
                                                                                                        class="btn-remove"
                                                                                                        onclick="removeRow(this)"
                                                                                                        style="visibility: hidden;">×</button>
                                                                                                </div>
                                                                                                <% }%>
                                                                                    </div>
                                                                                    <button type="button"
                                                                                        class="btn-add"
                                                                                        onclick="addProductRow()">+ Add
                                                                                        Product</button>
                                                                                </div>

                                                                                <button type="submit"
                                                                                    class="btn-submit">Save
                                                                                    Changes</button>
                                                                            </form>
                                                            </div>
                                                        </div>

                                                        <script>
                                                            function addProductRow() {
                                                                const container = document.getElementById('productRows');
                                                                const rows = container.querySelectorAll('.product-row');
                                                                const newRow = rows[0].cloneNode(true);
                                                                newRow.querySelector('select').value = '';
                                                                newRow.querySelector('input').value = '1';
                                                                newRow.querySelector('.btn-remove').style.visibility = 'visible';
                                                                container.appendChild(newRow);
                                                                updateRemoveButtons();
                                                                updateProductOptions();
                                                            }

                                                            function removeRow(btn) {
                                                                btn.closest('.product-row').remove();
                                                                updateRemoveButtons();
                                                                updateProductOptions();
                                                            }

                                                            function updateRemoveButtons() {
                                                                const rows = document.querySelectorAll('.product-row');
                                                                rows.forEach(row => {
                                                                    row.querySelector('.btn-remove').style.visibility = rows.length > 1 ? 'visible' : 'hidden';
                                                                });
                                                            }

                                                            function updateProductOptions() {
                                                                const selects = document.querySelectorAll('select[name="productDetailId"]');
                                                                const selected = Array.from(selects).map(s => s.value).filter(v => v !== "");
                                                                selects.forEach(select => {
                                                                    Array.from(select.options).forEach(opt => {
                                                                        opt.disabled = opt.value !== "" && opt.value !== select.value && selected.includes(opt.value);
                                                                    });
                                                                });
                                                            }

                                                            document.addEventListener('DOMContentLoaded', updateProductOptions);
                                                        </script>
                        </body>

                        </html>