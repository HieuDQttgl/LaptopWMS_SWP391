<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create new Order</title>
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                background: #f5f6fa;
                padding: 40px;
            }
            .form-container {
                max-width: 1000px;
                margin: 0 auto;
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }
            h2 {
                text-align: center;
                color: #2c3e50;
                margin-top: 0;
            }
            .form-group {
                margin-bottom: 15px;
                position: relative;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: 600;
                color: #333;
            }
            input, select, textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }

            .error-text {
                color: #e74c3c;
                font-size: 11px;
                margin-top: 4px;
                display: block;
                min-height: 15px;
            }
            .input-error {
                border-color: #e74c3c !important;
                background-color: #fffafa;
            }

            .type-switcher {
                display: flex;
                border-radius: 4px;
                overflow: hidden;
                margin-bottom: 20px;
            }
            .type-btn {
                flex: 1;
                padding: 12px;
                text-align: center;
                cursor: pointer;
                background: #ecf0f1;
                font-weight: 600;
                transition: 0.3s;
                border: 1px solid #ddd;
            }
            .type-btn.active {
                background: #3498db;
                color: white;
                border-color: #2980b9;
            }

            .detail-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }
            .detail-table th {
                background: #f8f9fa;
                padding: 12px;
                text-align: left;
                border-bottom: 2px solid #dee2e6;
            }
            .detail-table td {
                padding: 10px;
                vertical-align: top;
                border-bottom: 1px solid #eee;
            }

            .detail-selection-wrapper {
                display: none;
            }
            .row-active .detail-selection-wrapper {
                display: block;
            }
            .price-qty-fields {
                display: none;
                gap: 10px;
                margin-top: 10px;
            }
            .detail-selected .price-qty-fields {
                display: flex;
            }

            .btn-save {
                width: 100%;
                padding: 15px;
                background: #2ecc71;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                font-weight: bold;
                margin-top: 20px;
            }
            .btn-add-detail {
                background: #3498db;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin-top: 10px;
            }
            .btn-remove {
                background: #e74c3c;
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 4px;
                cursor: pointer;
            }
            .small-label {
                font-size: 12px;
                color: #7f8c8d;
                margin-bottom: 2px;
                display: block;
            }
            .partner-field {
                display: none;
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
            <h2>Create New Order</h2>

            <form action="add-order" method="post" id="orderForm" onsubmit="return validateForm();">
                <div class="form-group">
                    <label>Order Type</label>
                    <div class="type-switcher">
                        <div id="export-btn" class="type-btn active" onclick="switchOrderType('export')">EXPORT (Bán lẻ)</div>
                        <div id="import-btn" class="type-btn" onclick="switchOrderType('import')">IMPORT (Nhập kho)</div>
                    </div>
                </div>

                <div style="display: flex; gap: 20px;">
                    <div class="form-group partner-field" id="customer-group" style="flex: 1;">
                        <label>Customer</label>
                        <input type="text" list="customerList" id="customerSearch" placeholder="Search customer name..." autocomplete="off">
                        <span id="err-customer" class="error-text"></span>
                        <input type="hidden" name="customerId" id="customerIdHidden" value="0">
                    </div>
                    <div class="form-group partner-field" id="supplier-group" style="flex: 1;">
                        <label>Supplier</label>
                        <input type="text" list="supplierList" id="supplierSearch" placeholder="Search supplier name..." autocomplete="off">
                        <span id="err-supplier" class="error-text"></span>
                        <input type="hidden" name="supplierId" id="supplierIdHidden" value="0">
                    </div>
                </div>

                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" rows="2" placeholder="Enter order notes..."></textarea>
                </div>

                <h3 style="margin-top: 25px; border-bottom: 2px solid #3498db; padding-bottom: 5px;">Product List</h3>

                <table class="detail-table">
                    <thead>
                        <tr>
                            <th style="width: 35%;">Product Name</th>
                            <th style="width: 55%;">Configuration Details</th>
                            <th style="width: 10%;">Action</th>
                        </tr>
                    </thead>
                    <tbody id="detail-table-body">
                        <tr class="order-detail-row">
                            <td>
                                <span class="small-label">Product Name</span>
                                <input type="text" list="productList" class="product-search" placeholder="Search laptop..." autocomplete="off">
                                <span class="error-msg error-text"></span>
                                <input type="hidden" class="product-id-hidden">
                            </td>
                            <td>
                                <div class="detail-selection-wrapper">
                                    <span class="small-label">Select RAM / SSD / CPU</span>
                                    <select name="productDetailId" class="detail-select">
                                        <option value="">-- Select configuration --</option>
                                    </select>
                                    <span class="error-msg-detail error-text"></span>

                                    <div class="price-qty-fields">
                                        <div style="flex: 1;">
                                            <span class="small-label">Quantity</span>
                                            <input type="number" name="quantity" value="1" min="1" class="qty-input">
                                        </div>
                                        <div style="flex: 2;">
                                            <span class="small-label">Unit Price ($)</span>
                                            <div style="position: relative; display: flex; align-items: center;">
                                                <span style="position: absolute; left: 10px; color: #7f8c8d; font-weight: bold;">$</span>
                                                <input type="number" name="unitPrice" step="0.01" min="0" placeholder="0.00" style="padding-left: 25px;" class="price-input">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="small-label">&nbsp;</span>
                                <button type="button" class="btn-remove" onclick="removeRow(this)">X</button>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <button type="button" class="btn-add-detail" onclick="addRow()">+ Add More Product</button>
                <div id="global-error" class="error-text" style="text-align: center; font-size: 14px; margin-bottom: 10px; font-weight: bold;"></div>
                <button type="submit" class="btn-save">SUBMIT ORDER</button>
                <a href="order-list" class="link-back">Cancel</a>
            </form>
        </div>

        <datalist id="customerList">
            <c:forEach items="${allCustomers}" var="c"><option data-id="${c.customerId}" value="${c.customerName}"></option></c:forEach>
            </datalist>
            <datalist id="supplierList">
            <c:forEach items="${allSuppliers}" var="s"><option data-id="${s.supplierId}" value="${s.supplierName}"></option></c:forEach>
            </datalist>
            <datalist id="productList">
            <c:forEach items="${allProducts}" var="p"><option data-id="${p.productId}" value="${p.productName}"></option></c:forEach>
            </datalist>

            <div id="raw-details" style="display: none;">
            <c:forEach items="${allProductDetails}" var="pd">
                <span class="pd-data" data-pid="${pd.productId}" data-id="${pd.productDetailId}" data-info="CPU: ${pd.cpu} | RAM: ${pd.ram} | SSD: ${pd.storage}"></span>
            </c:forEach>
        </div>


        <jsp:include page="footer.jsp" />
        
        <script>
            function switchOrderType(type) {
                const isExp = (type === 'export');
                document.getElementById('customer-group').style.display = isExp ? 'block' : 'none';
                document.getElementById('supplier-group').style.display = isExp ? 'none' : 'block';
                document.getElementById('export-btn').classList.toggle('active', isExp);
                document.getElementById('import-btn').classList.toggle('active', !isExp);

                document.getElementById('customerIdHidden').value = '0';
                document.getElementById('supplierIdHidden').value = '0';
                document.getElementById('err-customer').innerText = "";
                document.getElementById('err-supplier').innerText = "";
            }

            function initPartnerSearch(inputId, hiddenId, listId, errorId) {
                const inputEl = document.getElementById(inputId);
                inputEl.addEventListener('input', function () {
                    const options = document.getElementById(listId).options;
                    let foundId = '0';
                    for (let opt of options) {
                        if (opt.value === this.value) {
                            foundId = opt.getAttribute('data-id');
                            break;
                        }
                    }
                    document.getElementById(hiddenId).value = foundId;

                    if (foundId !== '0') {
                        this.classList.remove('input-error');
                        document.getElementById(errorId).innerText = "";
                    }
                });
            }

            function loadDetailsToSelect(productId, selectEl) {
                const rawData = document.querySelectorAll('.pd-data');
                selectEl.innerHTML = '<option value="">-- Select Configuration Details --</option>';
                rawData.forEach(item => {
                    if (String(item.getAttribute('data-pid')) === String(productId)) {
                        const opt = document.createElement('option');
                        opt.value = item.getAttribute('data-id');
                        opt.textContent = item.getAttribute('data-info');
                        selectEl.appendChild(opt);
                    }
                });
            }

            const tableBody = document.getElementById('detail-table-body');

            tableBody.addEventListener('input', function (e) {
                const row = e.target.closest('tr');

                if (e.target.classList.contains('product-search')) {
                    const hiddenInput = row.querySelector('.product-id-hidden');
                    const detailSelect = row.querySelector('.detail-select');
                    const options = document.getElementById('productList').options;
                    let foundId = null;

                    for (let opt of options) {
                        if (opt.value === e.target.value) {
                            foundId = opt.getAttribute('data-id');
                            break;
                        }
                    }

                    if (foundId) {
                        hiddenInput.value = foundId;
                        row.classList.add('row-active');
                        loadDetailsToSelect(foundId, detailSelect);
                        e.target.classList.remove('input-error');
                        row.querySelector('.error-msg').innerText = ""; // Xóa lỗi tên sp
                    } else {
                        hiddenInput.value = '';
                        row.classList.remove('row-active', 'detail-selected');
                    }
                }
            });

            tableBody.addEventListener('change', function (e) {
                if (e.target.classList.contains('detail-select')) {
                    const currentSelect = e.target;
                    const row = currentSelect.closest('tr');
                    const errorSpan = row.querySelector('.error-msg-detail');
                    const allSelects = document.querySelectorAll('.detail-select');

                    let isDuplicate = false;
                    allSelects.forEach(s => {
                        if (s !== currentSelect && s.value === currentSelect.value && s.value !== "") {
                            isDuplicate = true;
                        }
                    });

                    if (isDuplicate) {
                        errorSpan.innerText = "⚠️ Cấu hình này đã được chọn!";
                        currentSelect.value = "";
                        currentSelect.classList.add('input-error');
                        row.classList.remove('detail-selected');
                    } else {
                        errorSpan.innerText = "";
                        currentSelect.classList.remove('input-error');
                        if (currentSelect.value !== "")
                            row.classList.add('detail-selected');
                        else
                            row.classList.remove('detail-selected');
                    }
                    document.getElementById('global-error').innerText = "";
                }
            });

            function addRow() {
                const tbody = document.getElementById('detail-table-body');
                const template = tbody.querySelector('.order-detail-row');
                const newRow = template.cloneNode(true);

                newRow.classList.remove('row-active', 'detail-selected');
                newRow.querySelectorAll('input').forEach(i => {
                    i.classList.remove('input-error');
                    i.value = (i.name === 'quantity') ? "1" : "";
                });
                newRow.querySelector('.detail-select').innerHTML = '<option value="">-- Select configuration --</option>';
                newRow.querySelectorAll('.error-text, .error-msg, .error-msg-detail').forEach(span => span.innerText = "");

                tbody.appendChild(newRow);
            }

            function removeRow(btn) {
                const rows = document.querySelectorAll('.order-detail-row');
                if (rows.length > 1) {
                    btn.closest('tr').remove();
                } else {
                    const row = btn.closest('tr');
                    row.classList.remove('row-active', 'detail-selected');
                    row.querySelector('.product-search').value = "";
                    row.querySelector('.product-id-hidden').value = "";
                    row.querySelector('.detail-select').innerHTML = '<option value="">-- Select configuration --</option>';
                    row.querySelector('.qty-input').value = "1";
                    row.querySelector('.price-input').value = "";
                    row.querySelectorAll('.error-text, .error-msg, .error-msg-detail').forEach(s => s.innerText = "");
                }
            }

            function validateForm() {
                let isValid = true;
                const globalError = document.getElementById('global-error');
                globalError.innerText = "";

                const isExp = document.getElementById('export-btn').classList.contains('active');
                if (isExp) {
                    const cId = document.getElementById('customerIdHidden').value;
                    if (cId === '0' || document.getElementById('customerSearch').value === "") {
                        document.getElementById('err-customer').innerText = "Customer not found.";
                        document.getElementById('customerSearch').classList.add('input-error');
                        isValid = false;
                    }
                } else {
                    const sId = document.getElementById('supplierIdHidden').value;
                    if (sId === '0' || document.getElementById('supplierSearch').value === "") {
                        document.getElementById('err-supplier').innerText = "Supplier not found.";
                        document.getElementById('supplierSearch').classList.add('input-error');
                        isValid = false;
                    }
                }

                const rows = document.querySelectorAll('.order-detail-row');
                let hasValidRow = false;

                rows.forEach(row => {
                    const pSearch = row.querySelector('.product-search');
                    const dSelect = row.querySelector('.detail-select');
                    const qty = row.querySelector('.qty-input');
                    const price = row.querySelector('.price-input');

                    if (pSearch.value.trim() !== "") {
                        if (dSelect.value === "") {
                            row.querySelector('.error-msg-detail').innerText = "No configuration selected!";
                            dSelect.classList.add('input-error');
                            isValid = false;
                        } else {
                            hasValidRow = true;
                            if (qty.value <= 0) {
                                qty.classList.add('input-error');
                                isValid = false;
                            }
                            if (price.value === "" || price.value < 0) {
                                price.classList.add('input-error');
                                isValid = false;
                            }
                        }
                    }
                });

                if (!hasValidRow) {
                    globalError.innerText = "❌ Lỗi: Order must have at least 1 product.";
                    isValid = false;
                }

                if (!isValid) {
                    const firstErr = document.querySelector('.input-error');
                    if (firstErr)
                        firstErr.scrollIntoView({behavior: 'smooth', block: 'center'});
                }

                return isValid;
            }

            document.addEventListener('DOMContentLoaded', () => {
                initPartnerSearch('customerSearch', 'customerIdHidden', 'customerList', 'err-customer');
                initPartnerSearch('supplierSearch', 'supplierIdHidden', 'supplierList', 'err-supplier');
                switchOrderType('export');
            });
        </script>
    </body>
</html>