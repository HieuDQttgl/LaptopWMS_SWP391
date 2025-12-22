<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Add Customer | Laptop WMS</title>
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
                    max-width: 600px;
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

                .form-group label.required::after {
                    content: " *";
                    color: #dc2626;
                }

                .form-group input {
                    width: 100%;
                    padding: 0.875rem 1rem;
                    border: 2px solid #e2e8f0;
                    border-radius: 0.5rem;
                    font-size: 0.9375rem;
                    transition: all 0.2s ease;
                    box-sizing: border-box;
                    outline: none;
                }

                .form-group input:focus {
                    border-color: #667eea;
                    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                }

                .form-group input::placeholder {
                    color: #94a3b8;
                }

                .form-actions {
                    display: flex;
                    justify-content: flex-end;
                    gap: 1rem;
                    margin-top: 2rem;
                    padding-top: 1.5rem;
                    border-top: 1px solid #f1f5f9;
                }

                .btn {
                    padding: 0.875rem 1.75rem;
                    border-radius: 0.5rem;
                    font-weight: 600;
                    font-size: 0.9375rem;
                    border: none;
                    cursor: pointer;
                    transition: all 0.2s ease;
                    text-decoration: none;
                    display: inline-flex;
                    align-items: center;
                    gap: 0.5rem;
                }

                .btn-cancel {
                    background: #94a3b8;
                    color: white;
                }

                .btn-cancel:hover {
                    background: #64748b;
                    color: white;
                }

                .btn-save {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    box-shadow: 0 4px 14px rgba(102, 126, 234, 0.4);
                }

                .btn-save:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
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

                    .form-actions {
                        flex-direction: column;
                    }

                    .btn {
                        width: 100%;
                        justify-content: center;
                    }
                }
            </style>
        </head>

        <body>
            <jsp:include page="header.jsp" />

            <div class="page-container">
                <a href="customer-list" class="back-link">← Back to Customers</a>

                <div class="form-card">
                    <div class="card-header">
                        <h2>🛒 Add New Customer</h2>
                    </div>

                    <div class="card-body">
                        <form action="add-customer" method="POST">
                            <div class="form-group">
                                <label class="required">Full Name</label>
                                <input type="text" name="name" placeholder="Enter customer name" required>
                            </div>

                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" name="email" placeholder="Enter email address">
                            </div>

                            <div class="form-group">
                                <label>Phone Number</label>
                                <input type="text" name="phone" placeholder="Enter phone number">
                            </div>

                            <div class="form-actions">
                                <a href="customer-list" class="btn btn-cancel">Cancel</a>
                                <button type="submit" class="btn btn-save">Save Customer</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <jsp:include page="footer.jsp" />
        </body>

        </html>