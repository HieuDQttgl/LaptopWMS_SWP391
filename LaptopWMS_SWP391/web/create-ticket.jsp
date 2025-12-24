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
                        <title>Create Ticket | Laptop WMS</title>
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
                                cursor: pointer;
                                transition: all 0.2s ease;
                            }

                            .type-option:hover {
                                border-color: #667eea;
                                background: #f8fafc;
                            }

                            .type-option.selected {
                                border-color: #667eea;
                                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                color: white;
                            }

                            .type-option.selected .type-icon,
                            .type-option.selected .type-desc {
                                color: white;
                            }

                            .type-icon {
                                font-size: 2rem;
                                margin-bottom: 0.5rem;
                            }

                            .type-label {
                                font-weight: 700;
                                font-size: 1rem;
                            }

                            .type-desc {
                                font-size: 0.75rem;
                                color: #64748b;
                                margin-top: 0.25rem;
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

                            .product-row input[type="number"]:focus {
                                border-color: #667eea;
                                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
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
                                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                color: white;
                                border: none;
                                border-radius: 0.5rem;
                                font-size: 1rem;
                                font-weight: 600;
                                cursor: pointer;
                                transition: all 0.2s ease;
                                box-shadow: 0 4px 14px rgba(102, 126, 234, 0.4);
                            }

                            .btn-submit:hover {
                                transform: translateY(-2px);
                                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
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

                                .product-row input[type="number"] {
                                    flex: 1 1 calc(50% - 2rem);
                                }
                            }
                        </style>
                    </head>

                    <body>
                        <%@include file="header.jsp" %>

                            <div class="page-container">
                                <a href="<%= request.getContextPath()%>/ticket-list" class="back-link">← Back to
                                    Tickets</a>

                                <div class="card">
                                    <h1>&#128221; Create New Ticket</h1>

                                    <% String error=(String) request.getAttribute("error"); %>
                                        <% if (error !=null) {%>
                                            <div class="error-message">&#9888; <%= error%>
                                            </div>
                                            <% } %>

                                                <form method="post" id="ticketForm">
                                                    <div class="form-group">
                                                        <label>Ticket Type *</label>
                                                        <div class="type-selector">
                                                            <div class="type-option" onclick="selectType('IMPORT')"
                                                                id="type-import">
                                                                <div class="type-icon">&#128229;</div>
                                                                <div class="type-label">IMPORT</div>
                                                                <div class="type-desc">Nhập hàng vào kho</div>
                                                            </div>
                                                            <div class="type-option" onclick="selectType('EXPORT')"
                                                                id="type-export">
                                                                <div class="type-icon">&#128228;</div>
                                                                <div class="type-label">EXPORT</div>
                                                                <div class="type-desc">Xuất hàng ra kho</div>
                                                            </div>
                                                        </div>
                                                        <input type="hidden" name="type" id="ticketType">
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="title">Title *</label>
                                                        <input type="text" id="title" name="title"
                                                            placeholder="Enter ticket title" required>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="description">Description</label>
                                                        <textarea id="description" name="description"
                                                            placeholder="Enter description (optional)"></textarea>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="keeperId">Assign to Keeper *</label>
                                                        <select id="keeperId" name="keeperId" required>
                                                            <option value="">-- Select Keeper --</option>
                                                            <% List<Users> keepers = (List<Users>)
                                                                    request.getAttribute("keepers");
                                                                    if (keepers != null) {
                                                                    for (Users keeper : keepers) {%>
                                                                    <option value="<%= keeper.getUserId()%>">
                                                                        <%= keeper.getFullName()%> (
                                                                            <%=keeper.getUsername()%>)
                                                                    </option>
                                                                    <% } } %>
                                                        </select>
                                                    </div>

                                                    <div class="form-group" id="partnerSection" style="display: none;">
                                                        <label for="partnerId" id="partnerLabel">Partner</label>
                                                        <select id="partnerId" name="partnerId">
                                                            <option value="">-- Select Partner --</option>
                                                        </select>
                                                        <div id="supplierOptions" style="display: none;">
                                                            <% List<Partners> suppliers = (List<Partners>)
                                                                    request.getAttribute("suppliers");
                                                                    if (suppliers != null) {
                                                                    for (Partners supplier : suppliers) {%>
                                                                    <option value="<%= supplier.getPartnerId()%>"
                                                                        data-type="supplier">
                                                                        <%= supplier.getPartnerName()%>
                                                                    </option>
                                                                    <% } } %>
                                                        </div>
                                                        <div id="customerOptions" style="display: none;">
                                                            <% List<Partners> customers = (List<Partners>)
                                                                    request.getAttribute("customers");
                                                                    if (customers != null) {
                                                                    for (Partners customer : customers) {%>
                                                                    <option value="<%= customer.getPartnerId()%>"
                                                                        data-type="customer">
                                                                        <%= customer.getPartnerName()%>
                                                                    </option>
                                                                    <% } } %>
                                                        </div>
                                                    </div>

                                                    <div class="products-section">
                                                        <h3>&#128230; Products</h3>
                                                        <div id="productRows">
                                                            <div class="product-row">
                                                                <select name="productDetailId" required
                                                                    onchange="updateProductOptions()">
                                                                    <option value="">-- Select Product --</option>
                                                                    <% List<TicketItem> products = (List<TicketItem>)
                                                                            request.getAttribute("products");
                                                                            if (products != null) {
                                                                            for (TicketItem p : products) {%>
                                                                            <option value="<%= p.getProductDetailId()%>"
                                                                                data-stock="<%= p.getCurrentStock()%>">
                                                                                <%= p.getProductName()%> -
                                                                                    <%=p.getProductConfig()%> (Stock:
                                                                                        <%= p.getCurrentStock()%>)
                                                                            </option>
                                                                            <% } }%>
                                                                </select>
                                                                <input type="number" name="quantity" placeholder="Qty"
                                                                    min="1" value="1" required>
                                                                <button type="button" class="btn-remove"
                                                                    onclick="removeRow(this)"
                                                                    style="visibility: hidden;">×</button>
                                                            </div>
                                                        </div>
                                                        <button type="button" class="btn-add"
                                                            onclick="addProductRow()">+ Add Product</button>
                                                    </div>

                                                    <button type="submit" class="btn-submit">Create Ticket</button>
                                                </form>
                                </div>
                            </div>

                            <script>
                                function selectType(type) {
                                    document.getElementById('ticketType').value = type;
                                    document.querySelectorAll('.type-option').forEach(el => el.classList.remove('selected'));
                                    document.getElementById('type-' + type.toLowerCase()).classList.add('selected');
                                    updatePartnerOptions(type);
                                }

                                function updatePartnerOptions(type) {
                                    const partnerSection = document.getElementById('partnerSection');
                                    const partnerLabel = document.getElementById('partnerLabel');
                                    const partnerSelect = document.getElementById('partnerId');

                                    if (!type) {
                                        partnerSection.style.display = 'none';
                                        return;
                                    }

                                    partnerSection.style.display = 'block';
                                    partnerSelect.innerHTML = '<option value="">-- Select Partner --</option>';

                                    if (type === 'IMPORT') {
                                        partnerLabel.textContent = 'Supplier';
                                        document.querySelectorAll('#supplierOptions option').forEach(opt => {
                                            partnerSelect.appendChild(opt.cloneNode(true));
                                        });
                                    } else {
                                        partnerLabel.textContent = 'Customer';
                                        document.querySelectorAll('#customerOptions option').forEach(opt => {
                                            partnerSelect.appendChild(opt.cloneNode(true));
                                        });
                                    }
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
                                    updateProductOptions();
                                }

                                function removeRow(btn) {
                                    btn.closest('.product-row').remove();
                                    updateRemoveButtons();
                                    updateProductOptions();
                                }

                                function updateRemoveButtons() {
                                    const rows = document.querySelectorAll('.product-row');
                                    rows.forEach((row, i) => {
                                        row.querySelector('.btn-remove').style.visibility = rows.length > 1 ? 'visible' : 'hidden';
                                    });
                                }

                                function updateProductOptions() {
                                    const selects = document.querySelectorAll('select[name="productDetailId"]');
                                    const selected = [];
                                    selects.forEach(s => {
                                        if (s.value)
                                            selected.push(s.value);
                                    });

                                    selects.forEach(select => {
                                        const current = select.value;
                                        select.querySelectorAll('option').forEach(opt => {
                                            opt.disabled = opt.value && opt.value !== current && selected.includes(opt.value);
                                        });
                                    });
                                }

                                function hasDuplicateProducts() {
                                    const selects = document.querySelectorAll('select[name="productDetailId"]');
                                    const values = [];
                                    for (let s of selects) {
                                        if (s.value) {
                                            if (values.includes(s.value))
                                                return true;
                                            values.push(s.value);
                                        }
                                    }
                                    return false;
                                }

                                document.getElementById('ticketForm').addEventListener('submit', function (e) {
                                    if (!document.getElementById('ticketType').value) {
                                        e.preventDefault();
                                        showToast('warning', 'Type Required', 'Please select a ticket type');
                                        return;
                                    }
                                    if (!document.getElementById('keeperId').value) {
                                        e.preventDefault();
                                        showToast('warning', 'Missing Field', 'Please select a Keeper');
                                        return;
                                    }
                                    if (hasDuplicateProducts()) {
                                        e.preventDefault();
                                        showToast('error', 'Duplicate Products', 'Each product can only be selected once');
                                        return;
                                    }
                                });

                                document.addEventListener('DOMContentLoaded', updateProductOptions);
                            </script>
                            <%@include file="common-dialogs.jsp" %>
                    </body>

                    </html>