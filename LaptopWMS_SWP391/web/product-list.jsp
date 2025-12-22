<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html>

            <head>
                <title>Products | Laptop WMS</title>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <style>
                    body {
                        font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                        background: linear-gradient(135deg, #f0f4ff 0%, #f8fafc 50%, #f0fdf4 100%);
                        margin: 0;
                        padding: 0;
                        min-height: 100vh;
                        color: #1e293b;
                    }

                    .page-container {
                        max-width: 1400px;
                        margin: 2rem auto;
                        padding: 2rem;
                    }

                    /* Page Header */
                    .page-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 2rem;
                    }

                    .page-title {
                        display: flex;
                        align-items: center;
                        gap: 0.75rem;
                        font-size: 1.75rem;
                        font-weight: 700;
                        color: #1e293b;
                    }

                    .page-title-icon {
                        font-size: 2rem;
                    }

                    .btn-add {
                        display: inline-flex;
                        align-items: center;
                        gap: 0.5rem;
                        padding: 0.75rem 1.5rem;
                        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                        color: white;
                        text-decoration: none;
                        border-radius: 0.75rem;
                        font-weight: 600;
                        font-size: 0.875rem;
                        transition: all 0.2s ease;
                        box-shadow: 0 4px 14px rgba(16, 185, 129, 0.4);
                    }

                    .btn-add:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 6px 20px rgba(16, 185, 129, 0.5);
                        color: white;
                    }

                    /* Filter Bar */
                    .filter-bar {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 1rem;
                        align-items: flex-end;
                        padding: 1.5rem;
                        background: white;
                        border-radius: 1rem;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                        margin-bottom: 1.5rem;
                        border: 1px solid #f1f5f9;
                    }

                    .filter-group {
                        display: flex;
                        flex-direction: column;
                        gap: 0.375rem;
                    }

                    .filter-group label {
                        font-size: 0.6875rem;
                        font-weight: 600;
                        color: #64748b;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    .filter-group input,
                    .filter-group select {
                        padding: 0.625rem 1rem;
                        font-size: 0.875rem;
                        border: 2px solid #e2e8f0;
                        border-radius: 0.5rem;
                        background: white;
                        color: #334155;
                        outline: none;
                        transition: all 0.2s ease;
                        min-width: 150px;
                    }

                    .filter-group input:focus,
                    .filter-group select:focus {
                        border-color: #667eea;
                        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                    }

                    .btn-search {
                        padding: 0.625rem 1.25rem;
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        border: none;
                        border-radius: 0.5rem;
                        font-weight: 600;
                        font-size: 0.875rem;
                        cursor: pointer;
                        transition: all 0.2s ease;
                    }

                    .btn-search:hover {
                        transform: translateY(-1px);
                        box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
                    }

                    .btn-clear {
                        padding: 0.625rem 1.25rem;
                        background: #ef4444;
                        color: white;
                        text-decoration: none;
                        border-radius: 0.5rem;
                        font-weight: 600;
                        font-size: 0.875rem;
                        transition: all 0.2s ease;
                    }

                    .btn-clear:hover {
                        background: #dc2626;
                        color: white;
                    }

                    /* Table Container */
                    .table-container {
                        background: white;
                        border-radius: 1rem;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                        overflow: hidden;
                        border: 1px solid #f1f5f9;
                    }

                    table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    th {
                        padding: 1rem 1.25rem;
                        text-align: left;
                        font-size: 0.6875rem;
                        font-weight: 600;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                        color: #64748b;
                        background: linear-gradient(135deg, #f8fafc 0%, white 100%);
                        border-bottom: 2px solid #e2e8f0;
                    }

                    td {
                        padding: 1rem 1.25rem;
                        font-size: 0.875rem;
                        color: #475569;
                        border-bottom: 1px solid #f1f5f9;
                        vertical-align: middle;
                    }

                    tbody tr {
                        transition: all 0.2s ease;
                    }

                    tbody tr:hover {
                        background: linear-gradient(135deg, #f8fafc 0%, #f0fdf4 100%);
                    }

                    /* Product Row */
                    .parent-row {
                        cursor: pointer;
                    }

                    .parent-row:hover {
                        background: #f8fafc !important;
                    }

                    .parent-row td:first-child {
                        width: 40px;
                    }

                    .toggle-icon {
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        width: 24px;
                        height: 24px;
                        border-radius: 0.375rem;
                        background: #f1f5f9;
                        color: #64748b;
                        font-size: 0.75rem;
                        transition: all 0.2s ease;
                    }

                    .parent-row:hover .toggle-icon {
                        background: #667eea;
                        color: white;
                    }

                    .parent-row.active .toggle-icon {
                        background: #667eea;
                        color: white;
                        transform: rotate(90deg);
                    }

                    .product-name {
                        font-weight: 600;
                        color: #1e293b;
                    }

                    .product-brand {
                        display: inline-flex;
                        align-items: center;
                        gap: 0.375rem;
                        padding: 0.25rem 0.75rem;
                        background: #f1f5f9;
                        border-radius: 1rem;
                        font-size: 0.75rem;
                        font-weight: 500;
                        color: #475569;
                    }

                    /* Status Badge */
                    .status-badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 0.25rem;
                        padding: 0.375rem 0.75rem;
                        border-radius: 2rem;
                        font-size: 0.6875rem;
                        font-weight: 600;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    .status-active {
                        background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                        color: #16a34a;
                    }

                    .status-inactive {
                        background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                        color: #dc2626;
                    }

                    /* Quantity Badge */
                    .quantity-badge {
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        min-width: 40px;
                        padding: 0.25rem 0.625rem;
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        border-radius: 1rem;
                        font-size: 0.75rem;
                        font-weight: 600;
                    }

                    /* Action Links */
                    .action-link {
                        font-size: 0.8125rem;
                        font-weight: 500;
                        text-decoration: none;
                        margin-right: 0.75rem;
                        transition: all 0.2s ease;
                    }

                    .action-link.edit {
                        color: #3b82f6;
                    }

                    .action-link.edit:hover {
                        color: #1d4ed8;
                    }

                    .action-link.toggle-active {
                        color: #ef4444;
                    }

                    .action-link.toggle-inactive {
                        color: #10b981;
                    }

                    /* Details Row */
                    .details-row {
                        display: none;
                    }

                    .details-row.open {
                        display: table-row;
                    }

                    .details-container {
                        padding: 1.5rem;
                        background: linear-gradient(135deg, #f8fafc 0%, #f0f4ff 100%);
                        border-bottom: 1px solid #e2e8f0;
                    }

                    .details-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 1rem;
                    }

                    .details-title {
                        font-size: 0.9375rem;
                        font-weight: 600;
                        color: #334155;
                    }

                    .btn-add-detail {
                        display: inline-flex;
                        align-items: center;
                        gap: 0.375rem;
                        padding: 0.5rem 1rem;
                        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                        color: white;
                        text-decoration: none;
                        border-radius: 0.5rem;
                        font-size: 0.75rem;
                        font-weight: 600;
                        transition: all 0.2s ease;
                    }

                    .btn-add-detail:hover {
                        transform: translateY(-1px);
                        box-shadow: 0 4px 12px rgba(16, 185, 129, 0.4);
                        color: white;
                    }

                    /* Inner Table */
                    .inner-table {
                        width: 100%;
                        background: white;
                        border-radius: 0.75rem;
                        overflow: hidden;
                        border: 1px solid #e2e8f0;
                    }

                    .inner-table th {
                        background: #f1f5f9;
                        color: #475569;
                        font-size: 0.625rem;
                        padding: 0.75rem 1rem;
                        border-bottom: 1px solid #e2e8f0;
                    }

                    .inner-table td {
                        padding: 0.75rem 1rem;
                        font-size: 0.8125rem;
                        border-bottom: 1px solid #f1f5f9;
                    }

                    .inner-table tr:last-child td {
                        border-bottom: none;
                    }

                    .spec-badge {
                        display: inline-block;
                        padding: 0.25rem 0.5rem;
                        background: #f1f5f9;
                        border-radius: 0.375rem;
                        font-size: 0.75rem;
                        font-weight: 500;
                        color: #475569;
                    }

                    /* Pagination */
                    .pagination {
                        display: flex;
                        justify-content: center;
                        gap: 0.5rem;
                        margin-top: 2rem;
                        padding: 1rem;
                    }

                    .pagination a {
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        min-width: 40px;
                        height: 40px;
                        padding: 0 0.75rem;
                        font-size: 0.875rem;
                        font-weight: 600;
                        color: #475569;
                        background: white;
                        border: 1px solid #e2e8f0;
                        border-radius: 0.5rem;
                        text-decoration: none;
                        transition: all 0.2s ease;
                    }

                    .pagination a:hover {
                        background: #f1f5f9;
                        border-color: #cbd5e1;
                    }

                    .pagination a.active {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        border-color: transparent;
                        box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
                    }

                    /* Back Link */
                    .back-link {
                        display: inline-flex;
                        align-items: center;
                        gap: 0.5rem;
                        margin-top: 1.5rem;
                        font-size: 0.875rem;
                        color: #94a3b8;
                        text-decoration: none;
                        transition: color 0.2s ease;
                    }

                    .back-link:hover {
                        color: #64748b;
                    }

                    /* Empty State */
                    .empty-state {
                        text-align: center;
                        padding: 3rem 1.5rem;
                        color: #94a3b8;
                    }

                    .empty-state-icon {
                        font-size: 3rem;
                        margin-bottom: 1rem;
                        opacity: 0.5;
                    }

                    /* Animations */
                    @keyframes fadeIn {
                        from {
                            opacity: 0;
                            transform: translateY(10px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    tbody tr {
                        animation: fadeIn 0.3s ease-out backwards;
                    }

                    tbody tr:nth-child(1) {
                        animation-delay: 0.02s;
                    }

                    tbody tr:nth-child(2) {
                        animation-delay: 0.04s;
                    }

                    tbody tr:nth-child(3) {
                        animation-delay: 0.06s;
                    }

                    tbody tr:nth-child(4) {
                        animation-delay: 0.08s;
                    }

                    tbody tr:nth-child(5) {
                        animation-delay: 0.10s;
                    }

                    /* Responsive */
                    @media (max-width: 768px) {
                        .page-container {
                            padding: 1rem;
                            margin: 1rem;
                        }

                        .page-header {
                            flex-direction: column;
                            gap: 1rem;
                            align-items: flex-start;
                        }

                        .filter-bar {
                            flex-direction: column;
                        }

                        .filter-group {
                            width: 100%;
                        }

                        .filter-group input,
                        .filter-group select {
                            width: 100%;
                        }

                        .table-container {
                            overflow-x: auto;
                        }
                    }
                </style>
            </head>

            <body>
                <jsp:include page="header.jsp" />

                <div class="page-container">
                    <!-- Page Header -->
                    <div class="page-header">
                        <h1 class="page-title">
                            <span class="page-title-icon">💻</span>
                            Product Management
                        </h1>
                        <c:if
                            test="${sessionScope.currentUser.getRoleId() == 1 or sessionScope.currentUser.getRoleId() == 2}">
                            <a href="add-product" class="btn-add">+ Add New Product</a>
                        </c:if>
                    </div>

                    <!-- Filter Bar -->
                    <div class="filter-bar">
                        <form action="product-list" method="get" style="display: contents;">
                            <div class="filter-group">
                                <label>Search</label>
                                <input type="text" name="keyword" placeholder="Model name..." value="${currentKeyword}">
                            </div>

                            <div class="filter-group">
                                <label>Status</label>
                                <select name="status" onchange="this.form.submit()">
                                    <option value="all" ${currentStatus=='all' ? 'selected' : '' }>All Status</option>
                                    <option value="active" ${currentStatus=='active' ? 'selected' : '' }>Active</option>
                                    <option value="inactive" ${currentStatus=='inactive' ? 'selected' : '' }>Inactive
                                    </option>
                                </select>
                            </div>

                            <div class="filter-group">
                                <label>Category</label>
                                <select name="category" onchange="this.form.submit()">
                                    <option value="all" ${currentCategory=='all' ? 'selected' : '' }>All Categories
                                    </option>
                                    <option value="Office" ${currentCategory=='Office' ? 'selected' : '' }>Office
                                    </option>
                                    <option value="Gaming" ${currentCategory=='Gaming' ? 'selected' : '' }>Gaming
                                    </option>
                                    <option value="Workstation" ${currentCategory=='Workstation' ? 'selected' : '' }>
                                        Workstation</option>
                                </select>
                            </div>

                            <div class="filter-group">
                                <label>Brand</label>
                                <select name="brand" onchange="this.form.submit()">
                                    <option value="all" ${currentBrand=='all' ? 'selected' : '' }>All Brands</option>
                                    <option value="Dell" ${currentBrand=='Dell' ? 'selected' : '' }>Dell</option>
                                    <option value="HP" ${currentBrand=='HP' ? 'selected' : '' }>HP</option>
                                    <option value="ASUS" ${currentBrand=='ASUS' ? 'selected' : '' }>ASUS</option>
                                    <option value="Lenovo" ${currentBrand=='Lenovo' ? 'selected' : '' }>Lenovo</option>
                                    <option value="Apple" ${currentBrand=='Apple' ? 'selected' : '' }>Apple</option>
                                    <option value="MSI" ${currentBrand=='MSI' ? 'selected' : '' }>MSI</option>
                                    <option value="Acer" ${currentBrand=='Acer' ? 'selected' : '' }>Acer</option>
                                </select>
                            </div>

                            <div class="filter-group">
                                <label>Sort</label>
                                <select name="sort_order" onchange="this.form.submit()">
                                    <option value="ASC" ${currentSortOrder=='ASC' ? 'selected' : '' }>Oldest</option>
                                    <option value="DESC" ${currentSortOrder=='DESC' ? 'selected' : '' }>Newest</option>
                                </select>
                            </div>

                            <button type="submit" class="btn-search">🔍 Search</button>
                            <a href="product-list" class="btn-clear">✕ Clear</a>
                        </form>
                    </div>

                    <!-- Products Table -->
                    <div class="table-container">
                        <table id="productTable">
                            <thead>
                                <tr>
                                    <th style="width: 50px;"></th>
                                    <th>ID</th>
                                    <th>Model Name</th>
                                    <th>Brand</th>
                                    <th>Category</th>
                                    <th>Quantity</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty productList}">
                                        <c:forEach var="p" items="${productList}">
                                            <tr class="parent-row" onclick="toggleDetails('row-${p.productId}', this)">
                                                <td>
                                                    <span class="toggle-icon">▶</span>
                                                </td>
                                                <td><strong>#${p.productId}</strong></td>
                                                <td><span class="product-name">${p.productName}</span></td>
                                                <td><span class="product-brand">${p.brand}</span></td>
                                                <td>${p.category}</td>
                                                <td><span class="quantity-badge">${p.totalQuantity}</span></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${p.status}">
                                                            <span class="status-badge status-active">● Active</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status-badge status-inactive">● Inactive</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td onclick="event.stopPropagation();">
                                                    <a href="edit-product?id=${p.productId}"
                                                        class="action-link edit">Edit</a>
                                                    <a href="javascript:void(0)"
                                                        onclick="confirmStatusChange('toggleProduct?id=${p.productId}', 'this product', <c:choose><c:when test="
                                                        ${p.status}">true
                                    </c:when>
                                    <c:otherwise>false</c:otherwise>
                                </c:choose>)"
                                class="action-link ${p.status ? 'toggle-active' : 'toggle-inactive'}">
                                ${p.status ? 'Deactivate' : 'Activate'}
                                </a>
                                </td>
                                </tr>

                                <tr id="row-${p.productId}" class="details-row">
                                    <td colspan="8" style="padding: 0;">
                                        <div class="details-container">
                                            <div class="details-header">
                                                <span class="details-title">📦 Configurations for
                                                    ${p.productName}</span>
                                                <c:if
                                                    test="${sessionScope.currentUser.getRoleId() == 1 or sessionScope.currentUser.getRoleId() == 2}">
                                                    <a href="add-product-detail?id=${p.productId}"
                                                        class="btn-add-detail">
                                                        + Add Config
                                                    </a>
                                                </c:if>
                                            </div>

                                            <table class="inner-table">
                                                <thead>
                                                    <tr>
                                                        <th>CPU</th>
                                                        <th>GPU</th>
                                                        <th>RAM</th>
                                                        <th>Storage</th>
                                                        <th>Unit</th>
                                                        <th>Qty</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:choose>
                                                        <c:when test="${not empty p.detailsList}">
                                                            <c:forEach var="d" items="${p.detailsList}">
                                                                <tr>
                                                                    <td><span class="spec-badge">${d.cpu}</span>
                                                                    </td>
                                                                    <td><span class="spec-badge">${d.gpu}</span>
                                                                    </td>
                                                                    <td><span class="spec-badge">${d.ram}</span>
                                                                    </td>
                                                                    <td><span class="spec-badge">${d.storage}</span>
                                                                    </td>
                                                                    <td>${d.unit}</td>
                                                                    <td><span
                                                                            class="quantity-badge">${d.quantity}</span>
                                                                    </td>
                                                                    <td>
                                                                        <a href="edit-product-detail?id=${d.productDetailId}"
                                                                            class="action-link edit">Edit</a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <tr>
                                                                <td colspan="7" class="empty-state">
                                                                    No configurations found.
                                                                </td>
                                                            </tr>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </tbody>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8">
                                            <div class="empty-state">
                                                <div class="empty-state-icon">📭</div>
                                                <div>No products found.</div>
                                            </div>
                                        </td>
                                    </tr>
                                </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <a href="product-list?page=${i}&keyword=${currentKeyword}&brand=${currentBrand}&category=${currentCategory}&status=${currentStatus}&sort_order=${currentSortOrder}"
                                    class="${currentPage == i ? 'active' : ''}">
                                    ${i}
                                </a>
                            </c:forEach>
                        </div>
                    </c:if>

                    <a href="<%= request.getContextPath()%>/landing" class="back-link">← Back to homepage</a>
                </div>

                <script>
                    function toggleDetails(rowId, parentRow) {
                        var detailRow = document.getElementById(rowId);

                        if (detailRow.classList.contains('open')) {
                            detailRow.classList.remove('open');
                            parentRow.classList.remove('active');
                        } else {
                            detailRow.classList.add('open');
                            parentRow.classList.add('active');
                        }
                    }
                </script>

                <%@include file="common-dialogs.jsp" %>
                    <jsp:include page="footer.jsp" />
            </body>

            </html>