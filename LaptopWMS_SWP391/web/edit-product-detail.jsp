<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <title>Edit Configuration | Laptop WMS</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
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
                max-width: 550px;
                margin: 2rem auto;
                padding: 2rem;
            }

            .form-card {
                background: white;
                border-radius: 1rem;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                overflow: hidden;
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

            .card-header {
                background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
                color: white;
                padding: 1.5rem 2rem;
            }

            .card-header h2 {
                margin: 0;
                font-size: 1.375rem;
                font-weight: 700;
            }

            .card-header p {
                margin: 0.5rem 0 0;
                font-size: 0.875rem;
                opacity: 0.9;
            }

            .card-body {
                padding: 2rem;
            }

            .form-group {
                margin-bottom: 1.25rem;
            }

            .form-group label {
                display: block;
                font-weight: 600;
                color: #475569;
                margin-bottom: 0.5rem;
                font-size: 0.875rem;
            }

            .form-group input,
            .form-group select {
                width: 100%;
                padding: 0.875rem 1rem;
                border: 2px solid #e2e8f0;
                border-radius: 0.5rem;
                font-size: 0.9375rem;
                transition: all 0.2s ease;
                box-sizing: border-box;
                outline: none;
            }

            .form-group input:focus,
            .form-group select:focus {
                border-color: #f59e0b;
                box-shadow: 0 0 0 3px rgba(245, 158, 11, 0.15);
            }

            .specs-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
            }

            .input-with-unit {
                display: flex;
                gap: 0.5rem;
            }

            .input-with-unit input {
                flex: 1;
            }

            .input-with-unit select {
                width: 85px;
                flex-shrink: 0;
            }

            .input-suffix {
                position: relative;
            }

            .input-suffix input {
                padding-right: 3rem;
            }

            .input-suffix::after {
                content: 'GB';
                position: absolute;
                right: 1rem;
                top: 50%;
                transform: translateY(-50%);
                color: #94a3b8;
                font-weight: 500;
                pointer-events: none;
            }

            .form-actions {
                margin-top: 2rem;
                padding-top: 1.5rem;
                border-top: 1px solid #f1f5f9;
            }

            .btn-save {
                width: 100%;
                padding: 1rem;
                background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
                color: white;
                border: none;
                border-radius: 0.5rem;
                font-weight: 600;
                font-size: 1rem;
                cursor: pointer;
                transition: all 0.2s ease;
                box-shadow: 0 4px 14px rgba(245, 158, 11, 0.4);
            }

            .btn-save:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(245, 158, 11, 0.5);
            }

            .link-back {
                display: block;
                text-align: center;
                margin-top: 1rem;
                color: #64748b;
                text-decoration: none;
                font-size: 0.875rem;
                font-weight: 500;
            }

            .link-back:hover {
                color: #f59e0b;
            }

            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                margin-bottom: 1.5rem;
                font-size: 0.875rem;
                color: #64748b;
                text-decoration: none;
                font-weight: 500;
            }

            .back-link:hover {
                color: #f59e0b;
            }

            @media (max-width: 640px) {
                .page-container {
                    padding: 1rem;
                    margin: 1rem;
                }

                .card-body {
                    padding: 1.5rem;
                }

                .specs-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
        <script>
            window.onload = function () {
                const ramValue = '${detail.ram}';
                const storageValue = '${detail.storage}';

                const ramMatch = ramValue.match(/\d+(\.\d+)?/);
                if (ramMatch) {
                    document.getElementById('ramValue').value = ramMatch[0];
                }

                const storageMatch = storageValue.match(/^(\d+(?:\.\d+)?)\s*(.*)$/);
                if (storageMatch) {
                    document.getElementById('storageValue').value = storageMatch[1];
                    const storageUnit = storageMatch[2].toUpperCase().replace(/\s+/g, '');
                    if (storageUnit.includes('TB')) {
                        document.getElementById('storageUnit').value = 'TB';
                    } else {
                        document.getElementById('storageUnit').value = 'GB';
                    }
                }
            };
        </script>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="page-container">
            <a href="product-list" class="back-link">← Back to Products</a>

            <div class="form-card">
                <div class="card-header">
                    <h2>✏️ Edit Configuration</h2>
                    <p>Detail ID: <strong>${detail.productDetailId}</strong>
                        <c:if test="${not empty detail.productName}">
                            for <strong>${detail.productName}</strong>
                        </c:if>
                    </p>
                </div>

                <div class="card-body">
                    <form action="edit-product-detail" method="post">
                        <input type="hidden" name="id" value="${detail.productDetailId}">
                        <input type="hidden" name="productId" value="${detail.productId}">

                        <div class="specs-grid">
                            <div class="form-group">
                                <label>CPU *</label>
                                <input type="text" name="cpu" value="${detail.cpu}" required>
                            </div>

                            <div class="form-group">
                                <label>GPU</label>
                                <input type="text" name="gpu" value="${detail.gpu}">
                            </div>

                            <div class="form-group">
                                <label>RAM (GB) *</label>
                                <div class="input-suffix">
                                    <input type="number" id="ramValue" name="ram" min="1" step="any" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label>Storage *</label>
                                <div class="input-with-unit">
                                    <input type="number" id="storageValue" name="storageValue" min="1" step="any" required>
                                    <select id="storageUnit" name="storageUnit">
                                        <option value="GB">GB</option>
                                        <option value="TB">TB</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Unit</label>
                            <select name="unit">
                                <option value="piece" ${detail.unit=='piece' ? 'selected' : '' }>Piece</option>
                                <option value="set" ${detail.unit=='set' ? 'selected' : '' }>Set</option>
                                <option value="box" ${detail.unit=='box' ? 'selected' : '' }>Box</option>
                            </select>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn-save">Update Configuration</button>
                            <a href="product-list" class="link-back">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
    </body>

</html>