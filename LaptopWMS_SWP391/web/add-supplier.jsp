<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Add Supplier | Laptop WMS</title>
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
                    background: linear-gradient(135deg, #10b981 0%, #059669 100%);
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

                .form-group label.required::after {
                    content: " *";
                    color: #dc2626;
                }

                .form-group input,
                .form-group select,
                .form-group textarea {
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

                .form-group input:focus,
                .form-group select:focus,
                .form-group textarea:focus {
                    border-color: #10b981;
                    box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.15);
                }

                .form-group input.error {
                    border-color: #dc2626;
                }

                .form-group input::placeholder {
                    color: #94a3b8;
                }

                .error-message {
                    color: #dc2626;
                    font-size: 0.75rem;
                    margin-top: 0.375rem;
                    display: none;
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
                    background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                    color: white;
                    box-shadow: 0 4px 14px rgba(16, 185, 129, 0.4);
                }

                .btn-save:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 6px 20px rgba(16, 185, 129, 0.5);
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
                <a href="supplier-list" class="back-link">← Back to Suppliers</a>

                <div class="form-card">
                    <div class="card-header">
                        <h2>🏭 Add New Supplier</h2>
                    </div>

                    <div class="card-body">
                        <c:if test="${not empty error}">
                            <div class="alert alert-error">⚠ ${error}</div>
                        </c:if>

                        <form action="add-supplier" method="POST" onsubmit="return validateForm()">
                            <div class="form-group">
                                <label class="required">Full Name</label>
                                <input type="text" id="name" name="name" placeholder="Enter supplier name"
                                    value="${param.name}" required>
                                <div id="nameError" class="error-message">Supplier name is required</div>
                            </div>

                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" id="email" name="email" placeholder="Enter email address"
                                    value="${param.email}">
                                <div id="emailError" class="error-message">Please enter a valid email address</div>
                            </div>

                            <div class="form-group">
                                <label>Phone Number</label>
                                <input type="text" id="phone" name="phone" placeholder="Enter phone number"
                                    value="${param.phone}">
                                <div id="phoneError" class="error-message">Please enter a valid phone number (10-15
                                    digits)</div>
                            </div>

                            <div class="form-actions">
                                <a href="supplier-list" class="btn btn-cancel">Cancel</a>
                                <button type="submit" class="btn btn-save">Save Supplier</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script>
                function validateForm() {
                    let isValid = true;
                    document.querySelectorAll('.error-message').forEach(el => el.style.display = 'none');
                    document.querySelectorAll('.form-group input').forEach(el => el.classList.remove('error'));

                    const name = document.getElementById('name').value.trim();
                    if (name === '') {
                        document.getElementById('nameError').style.display = 'block';
                        document.getElementById('name').classList.add('error');
                        isValid = false;
                    }

                    const email = document.getElementById('email').value.trim();
                    if (email !== '' && !isValidEmail(email)) {
                        document.getElementById('emailError').style.display = 'block';
                        document.getElementById('email').classList.add('error');
                        isValid = false;
                    }

                    const phone = document.getElementById('phone').value.trim();
                    if (phone !== '' && !isValidPhone(phone)) {
                        document.getElementById('phoneError').style.display = 'block';
                        document.getElementById('phone').classList.add('error');
                        isValid = false;
                    }

                    return isValid;
                }

                function isValidEmail(email) {
                    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
                }

                function isValidPhone(phone) {
                    return /^[0-9]{10,11}$/.test(phone.replace(/[\s\-]/g, ''));
                }
            </script>

            <jsp:include page="footer.jsp" />
        </body>

        </html>