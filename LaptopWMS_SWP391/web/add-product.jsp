<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Add Product | Laptop WMS</title>
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
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    padding: 1.5rem 2rem;
                }

                .card-header h2 {
                    margin: 0;
                    font-size: 1.375rem;
                    font-weight: 700;
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                }

                .card-body {
                    padding: 2rem;
                }

                .alert {
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                    padding: 1rem 1.25rem;
                    border-radius: 0.75rem;
                    margin-bottom: 1.5rem;
                    font-weight: 500;
                }

                .alert-error {
                    background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                    color: #dc2626;
                    border: 1px solid #fca5a5;
                }

                .form-group {
                    margin-bottom: 1.5rem;
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
                    border-color: #667eea;
                    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                }

                .form-group input::placeholder {
                    color: #94a3b8;
                }

                .form-actions {
                    margin-top: 2rem;
                    padding-top: 1.5rem;
                    border-top: 1px solid #f1f5f9;
                }

                .btn-save {
                    width: 100%;
                    padding: 1rem;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    border: none;
                    border-radius: 0.5rem;
                    font-weight: 600;
                    font-size: 1rem;
                    cursor: pointer;
                    transition: all 0.2s ease;
                    box-shadow: 0 4px 14px rgba(102, 126, 234, 0.4);
                }

                .btn-save:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
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
                    color: #667eea;
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
                    color: #667eea;
                }

                @media (max-width: 640px) {
                    .page-container {
                        padding: 1rem;
                        margin: 1rem;
                    }

                    .card-body {
                        padding: 1.5rem;
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
                        <h2>💻 Create New Product</h2>
                    </div>

                    <div class="card-body">
                        <c:if test="${not empty error}">
                            <div class="alert alert-error">⚠ ${error}</div>
                        </c:if>

                        <form action="add-product" method="post">
                            <div class="form-group">
                                <label>Model Name *</label>
                                <input type="text" name="name" required placeholder="e.g. Dell XPS 15 9530">
                            </div>

                            <div class="form-group">
                                <label>Brand *</label>
                                <select name="brand" required>
                                    <option value="">-- Select Brand --</option>
                                    <option value="Dell">Dell</option>
                                    <option value="HP">HP</option>
                                    <option value="ASUS">ASUS</option>
                                    <option value="Apple">Apple</option>
                                    <option value="Lenovo">Lenovo</option>
                                    <option value="Acer">Acer</option>
                                    <option value="MSI">MSI</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Category</label>
                                <select name="category">
                                    <option value="Office">Office</option>
                                    <option value="Gaming">Gaming</option>
                                    <option value="Workstation">Workstation</option>
                                </select>
                            </div>

                            <div class="form-actions">
                                <button type="submit" class="btn-save">Create Product</button>
                                <a href="product-list" class="link-back">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <jsp:include page="footer.jsp" />
        </body>

        </html>