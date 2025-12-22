<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Add Configuration | Laptop WMS</title>
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
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
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
                border-color: #10b981;
                box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.15);
            }

            .form-actions {
                margin-top: 2rem;
                padding-top: 1.5rem;
                border-top: 1px solid #f1f5f9;
            }

            .btn-save {
                width: 100%;
                padding: 1rem;
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                color: white;
                border: none;
                border-radius: 0.5rem;
                font-weight: 600;
                font-size: 1rem;
                cursor: pointer;
                transition: all 0.2s ease;
                box-shadow: 0 4px 14px rgba(16, 185, 129, 0.4);
            }

            .btn-save:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(16, 185, 129, 0.5);
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
                color: #10b981;
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
                color: #10b981;
            }

            .specs-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
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
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="page-container">
            <a href="product-list" class="back-link">← Back to Products</a>

            <div class="form-card">
                <div class="card-header">
                    <h2>⚙️ Add Configuration</h2>
                    <p>Adding specs for: <strong>${targetName}</strong></p>
                </div>

                <div class="card-body">
                    <form action="add-product-detail" method="post">
                        <input type="hidden" name="productId" value="${targetId}">

                        <div class="specs-grid">
                            <div class="form-group">
                                <label>CPU *</label>
                                <input type="text" name="cpu" placeholder="e.g. Intel Core i7-13700H" required>
                            </div>

                            <div class="form-group">
                                <label>GPU</label>
                                <input type="text" name="gpu" placeholder="e.g. NVIDIA RTX 4060 8GB">
                            </div>

                            <div class="form-group">
                                <label>RAM *</label>
                                <input type="text" name="ram" placeholder="e.g. 16GB" required>
                            </div>

                            <div class="form-group">
                                <label>Storage *</label>
                                <input type="text" name="storage" placeholder="e.g. 512GB SSD" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Unit</label>
                            <select name="unit">
                                <option value="piece" selected>Piece</option>
                                <option value="set">Set</option>
                                <option value="box">Box</option>
                            </select>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn-save">Save Configuration</button>
                            <a href="product-list" class="link-back">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
    </body>

    </html>