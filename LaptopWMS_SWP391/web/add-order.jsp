<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Create New Order</title>
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                background: #f5f6fa;
                padding: 40px;
            }
            .form-container {
                max-width: 900px;
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
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: 600;
                color: #333;
            }
            input[type="text"], input[type="number"], textarea, select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }
            .btn-save, .btn-add-detail {
                width: 100%;
                padding: 12px;
                background: #2ecc71;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                font-weight: bold;
                margin-top: 10px;
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
            .error-message {
                color: #dc3545;
                font-size: 0.9em;
                margin-top: 5px;
                font-weight: 600;
            }
            .error-box {
                color: #721c24;
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
                padding: 10px;
                margin-bottom: 15px;
                border-radius: 4px;
                opacity: 1;
                transition: opacity 1s ease-out;
            }

            .type-switcher {
                display: flex;
                border-radius: 4px;
                overflow: hidden;
                margin-bottom: 20px;
            }
            .type-btn {
                flex: 1;
                padding: 10px;
                text-align: center;
                cursor: pointer;
                background: #ecf0f1;
                border: 1px solid #ddd;
                font-weight: 600;
                transition: background 0.3s;
            }
            .type-btn.active {
                background: #3498db;
                color: white;
                border-color: #2980b9;
            }
            .type-btn:not(.active):hover {
                background: #e0e6e8;
            }

            #detail-table-body td {
                vertical-align: middle;
                padding: 8px 5px;
            }
            .detail-table input, .detail-table select, .detail-table button {
                padding: 8px;
                font-size: 14px;
            }
            .btn-remove {
                background: #e74c3c;
                width: 40px;
                height: 40px;
                border-radius: 4px;
                color: white;
                border: none;
                cursor: pointer;
                font-size: 16px;
            }
            .detail-header {
                margin-top: 25px;
                margin-bottom: 10px;
                font-size: 1.1em;
                font-weight: bold;
                color: #34495e;
            }
            .table-responsive {
                overflow-x: auto;
            }
            .detail-table th {
                padding: 10px;
                background-color: #ecf0f1;
                text-align: left;
            }

            .partner-field {
                display: none;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <div class="form-container">
            <h2>Create New Order</h2>

            <c:if test="${not empty errors.general}">
                <div class="error-box auto-hide">
                    <strong>Error:</strong> ${errors.general}
                </div>
            </c:if>

            <form action="add-order" method="post" id="orderForm" onsubmit="return prepareFormSubmission();">

                <div class="form-group">
                    <label>Loại Đơn hàng</label>
                    <div class="type-switcher">
                        <div id="export-btn" class="type-btn active" data-type="export">
                            Xuất Hàng (Sale)
                        </div>
                        <div id="import-btn" class="type-btn" data-type="import">
                            Nhập Hàng (Purchase)
                        </div>
                    </div>
                    <c:if test="${not empty errors.party}">
                        <div class="error-message">${errors.party}</div>
                    </c:if>
                </div>

                <h3>Thông tin chung</h3>
                <div style="display: flex; gap: 20px;">

                    <div class="form-group partner-field" id="customer-group" style="flex: 1; display: block;">
                        <label>Khách hàng (Export)</label>
                        <select name="customerId" id="customerIdSelect">
                            <option value="0">-- Chọn Khách hàng --</option>
                            <c:forEach items="${allCustomers}" var="c">
                                <option value="${c.customerId}"
                                        ${tempOrder.customerId == c.customerId ? 'selected' : ''}>
                                    ${c.customerName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group partner-field" id="supplier-group" style="flex: 1;">
                        <label>Nhà cung cấp (Import)</label>
                        <select name="supplierId" id="supplierIdSelect">
                            <option value="0">-- Chọn Nhà cung cấp --</option>
                            <c:forEach items="${allSuppliers}" var="s">
                                <option value="${s.supplierId}"
                                        ${tempOrder.supplierId == s.supplierId ? 'selected' : ''}>
                                    ${s.supplierName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label>Mô tả / Ghi chú</label>
                    <textarea name="description" rows="3" placeholder="Nhập ghi chú cho đơn hàng...">${tempOrder.description}</textarea>
                </div>

                <div class="detail-header">Chi tiết Đơn hàng</div>

                <c:if test="${not empty errors.details}">
                    <div class="error-box auto-hide" style="margin-top: 5px; margin-bottom: 15px;">
                        <strong>Error:</strong> ${errors.details}
                    </div>
                </c:if>

                <div class="table-responsive">
                    <table class="detail-table" style="width: 100%; border-collapse: collapse;">
                        <thead>
                            <tr>
                                <th style="width: 40%;">Sản phẩm</th>
                                <th style="width: 20%;">Số lượng</th>
                                <th style="width: 25%;">Đơn giá</th>
                                <th style="width: 10%;"></th>
                            </tr>
                        </thead>
                        <tbody id="detail-table-body">
                            <%-- Thiết lập biến cho logic hiển thị chi tiết --%>
                            <c:set var="detailsToRender" value="${not empty tempDetails ? tempDetails : null}" />
                            <c:if test="${empty detailsToRender}"><c:set var="detailsToRender" value="${[]}" /></c:if>

                            <%-- Chuẩn bị Map cho việc tra cứu tên sản phẩm (Product ID -> Name) --%>
                            <jsp:useBean id="productMap" class="java.util.HashMap" scope="page" />
                            <c:forEach items="${allProducts}" var="p">
                                <c:set target="${productMap}" property="${p.productId}" value="${p.productName}" />
                            </c:forEach>

                            <%-- Lấy tên sản phẩm bị lỗi để hiển thị lại --%>
                            <c:set var="errorNames" value="${not empty errorProductNames ? errorProductNames : null}" />

                            <c:choose>
                                <c:when test="${fn:length(detailsToRender) > 0}">
                                    <c:forEach items="${detailsToRender}" var="detail" varStatus="loop">
                                    
                                    <%-- Xác định tên sản phẩm (Tên lỗi > Tên hợp lệ) --%>
                                    <c:choose><c:when test="${not empty errorNames[loop.index]}">
                                        <c:set var="currentProductName" value="${errorNames[loop.index]}" />
                                        <c:set var="currentProductId" value="" />
                                    </c:when><c:otherwise>
                                        <c:set var="currentProductName" value="${productMap[detail.productId]}" />
                                        <c:set var="currentProductId" value="${detail.productId}" />
                                    </c:otherwise></c:choose>
                                    
                                    <tr class="order-detail-row" data-index="${loop.index}">
                                        <td>
                                            <input type="text" list="products" name="productName_TEMP_${loop.index}"
                                                    value="${currentProductName}"
                                                    placeholder="Gõ tên sản phẩm..." class="product-name-input" required>
                                            
                                            <input type="hidden" name="productId_TEMP_${loop.index}"
                                                    value="${currentProductId}"
                                                    class="product-id-input">
                                            </td>
                                            <td>
                                                <input type="number" name="quantity_TEMP" min="1" required value=${not empty detail.quantity ? detail.quantity : 1}"">
                                            </td>
                                            <td>
                                                <input type="text" name="unitPrice_TEMP" required value="${detail.unitPrice}"
                                                        placeholder="Ví dụ: 15000000.00">
                                            </td>
                                            <td>
                                                <button type="button" class="btn-remove" onclick="removeDetailRow(this)">X</button>
                                            </td>
                                        </tr>
                                </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="order-detail-row" data-index="0">
                                        <td>
                                            <input type="text" list="products" name="productName_TEMP_0" placeholder="Gõ tên sản phẩm..." class="product-name-input" required>

                                            <input type="hidden" name="productId_TEMP_0" value="" class="product-id-input">
                                        </td>
                                        <td>
                                            <input type="number" name="quantity_TEMP" min="1" required value="1">
                                        </td>
                                        <td>
                                            <input type="text" name="unitPrice_TEMP" required placeholder="Ví dụ: 15000000.00">
                                        </td>
                                        <td>
                                            <button type="button" class="btn-remove" onclick="removeDetailRow(this)">X</button>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <datalist id="products">
                    <c:forEach items="${allProducts}" var="p">
                        <option data-product-id="${p.productId}" value="${p.productName}"></option>
                    </c:forEach>
                </datalist>

                <button type="button" class="btn-add-detail" onclick="addDetailRow()">+ Thêm Sản phẩm</button>
                <button type="submit" class="btn-save">Create Order</button>
                <a href="order-list" class="link-back">Cancel</a>
            </form>
        </div>


        <jsp:include page="footer.jsp" />

        <script>
            let detailIndex = ${fn:length(detailsToRender) > 0 ? fn:length(detailsToRender) : 1};

            document.addEventListener('input', function (e) {
                if (e.target.classList.contains('product-name-input')) {
                    const inputElement = e.target;
                    const dataList = document.getElementById(inputElement.getAttribute('list'));
                    const hiddenIdInput = inputElement.closest('td').querySelector('.product-id-input');

                    const selectedOption = Array.from(dataList.options).find(
                            option => option.value === inputElement.value
                    );

                    if (selectedOption) {
                        // Cập nhật ID khi người dùng chọn từ datalist
                        hiddenIdInput.value = selectedOption.getAttribute('data-product-id');
                    } else {
                        // Xóa ID nếu văn bản nhập vào không khớp với bất kỳ tùy chọn nào
                        hiddenIdInput.value = '';
                    }
                }
            });

            function getDetailRowTemplate() {
                const template = `
                    <tr class="order-detail-row" data-index="${detailIndex}">
                        <td>
                            <input type="text" list="products" name="productName_TEMP_${detailIndex}" placeholder="Gõ tên sản phẩm..." class="product-name-input" required>
                            <input type="hidden" name="productId_TEMP_${detailIndex}" value="" class="product-id-input">
                        </td>
                        <td>
                            <input type="number" name="quantity_TEMP" min="1" required value="1">
                        </td>
                        <td>
                            <input type="text" name="unitPrice_TEMP" required placeholder="Ví dụ: 15000000.00">
                        </td>
                        <td>
                            <button type="button" class="btn-remove" onclick="removeDetailRow(this)">X</button>
                        </td>
                    </tr>
                `;
                detailIndex++;
                return template;
            }

            function addDetailRow() {
                const tableBody = document.getElementById('detail-table-body');
                tableBody.insertAdjacentHTML('beforeend', getDetailRowTemplate());
            }

            function removeDetailRow(buttonElement) {
                const row = buttonElement.closest('.order-detail-row');
                const tableBody = document.getElementById('detail-table-body');

                if (tableBody.querySelectorAll('.order-detail-row').length > 1) {
                    row.remove();
                } else {
                    alert('Đơn hàng phải có ít nhất một sản phẩm.');
                }
            }

            function switchOrderType(type) {
                const customerGroup = document.getElementById('customer-group');
                const supplierGroup = document.getElementById('supplier-group');
                const customerSelect = document.getElementById('customerIdSelect');
                const supplierSelect = document.getElementById('supplierIdSelect');
                const exportBtn = document.getElementById('export-btn');
                const importBtn = document.getElementById('import-btn');

                if (type === 'export') {
                    customerGroup.style.display = 'block';
                    supplierGroup.style.display = 'none';
                    supplierSelect.value = '0';
                    exportBtn.classList.add('active');
                    importBtn.classList.remove('active');
                } else {
                    customerGroup.style.display = 'none';
                    supplierGroup.style.display = 'block';
                    customerSelect.value = '0';
                    exportBtn.classList.remove('active');
                    importBtn.classList.add('active');
                }
            }

            document.addEventListener('DOMContentLoaded', function () {
                document.querySelectorAll('.error-box.auto-hide').forEach(errorBox => {
                    setTimeout(() => {
                        errorBox.style.opacity = '0';
                        setTimeout(() => {
                            errorBox.style.display = 'none';
                        }, 1000);
                    }, 10000);
                });


                const initialCustomerId = document.getElementById('customerIdSelect').value;
                const initialSupplierId = document.getElementById('supplierIdSelect').value;

                let initialType = 'export';

                if (initialSupplierId !== '0' && initialSupplierId !== '') {
                    initialType = 'import';
                }

                switchOrderType(initialType);

                document.querySelectorAll('.type-btn').forEach(button => {
                    button.addEventListener('click', function () {
                        switchOrderType(this.dataset.type); // Sử dụng .dataset.type
                    });
                });
            });

            function prepareFormSubmission() {
                const customerSelect = document.getElementById('customerIdSelect');
                const supplierSelect = document.getElementById('supplierIdSelect');

                if (customerSelect.value === '0' && supplierSelect.value === '0') {
                    alert('Vui lòng chọn Khách hàng (Export) hoặc Nhà cung cấp (Import).');
                    return false;
                }

                const detailRows = document.querySelectorAll('#detail-table-body .order-detail-row');
                let validProductFound = false;
                let validDetailCount = 0;

                detailRows.forEach((row, index) => {

                    const productIdInput = row.querySelector('.product-id-input');
                    const quantityInput = row.querySelector('input[name^="quantity_TEMP"]'); // Bắt đầu bằng quantity_TEMP
                    const unitPriceInput = row.querySelector('input[name^="unitPrice_TEMP"]'); // Bắt đầu bằng unitPrice_TEMP
                    const productNameInput = row.querySelector('.product-name-input');

                    // Chỉ đổi tên những trường hợp hợp lệ để Server side Binding
                    if (productIdInput.value !== '' && productIdInput.value !== '0') {
                        // Đổi tên để binding thành công
                        productIdInput.name = `details[${validDetailCount}].productId`;
                        quantityInput.name = `details[${validDetailCount}].quantity`;
                        unitPriceInput.name = `details[${validDetailCount}].unitPrice`;

                        validProductFound = true;
                        validDetailCount++;
                    } else {
                        // Nếu không hợp lệ, giữ nguyên tên TEMP cho mục đích hiển thị lỗi,
                        // nhưng đổi index về index gốc (vì chúng ta đã xóa index trong vòng lặp)
                        productNameInput.name = `productName_TEMP_${row.dataset.index}`;

                        // Loại bỏ các trường còn lại để chúng không được gửi lên Server
                        // hoặc giữ nguyên tên TEMP cũ để Server biết đây là dòng lỗi.
                        // (Ở đây tôi giữ lại productName cho việc hiển thị lại lỗi)
                        productIdInput.name = `productId_TEMP_${row.dataset.index}`;
                        quantityInput.name = `quantity_TEMP_FOR_ERROR_${row.dataset.index}`;
                        unitPriceInput.name = `unitPrice_TEMP_FOR_ERROR_${row.dataset.index}`;

                        // Cảnh báo nếu có một dòng chi tiết không hợp lệ
                        alert('Vui lòng chọn sản phẩm hợp lệ cho tất cả các chi tiết.');
                        validProductFound = false;
                        return false; // Thoát vòng lặp
                    }

                    // Xóa các trường tên sản phẩm TEMP đã được xử lý thành công (tùy chọn)
                    // Hoặc giữ lại như bạn đang làm để phục vụ việc hiển thị lại khi có lỗi khác.
                    // productNameInput.name = ''; // Không làm gì, Server có thể bỏ qua nếu không có binding
                });

                // Kiểm tra lần cuối
                if (!validProductFound && detailRows.length > 0) {
                    return false;
                }

                return validProductCount > 0; // Đảm bảo có ít nhất 1 chi tiết hợp lệ
            }
        </script>
    </body>
</html>