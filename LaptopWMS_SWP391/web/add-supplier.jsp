<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <title>Add New Supplier - WMS</title>

            <style>
                body {
                    font-family: "Segoe UI", Arial, sans-serif;
                    background-color: #f5f6fa;
                    margin: 0;
                    padding: 0;
                    color: #2c3e50;
                }

                .container {
                    max-width: 600px;
                    margin: 40px auto;
                    background-color: white;
                    padding: 30px;
                    border-radius: 12px;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.07);
                }

                .card-header {
                    background-color: #2ecc71;
                    color: white;
                    padding: 20px 25px;
                    border-radius: 10px 10px 0 0;
                    margin: -30px -30px 25px -30px;
                }

                .card-header h2 {
                    margin: 0;
                    font-weight: 600;
                }

                .form-group {
                    margin-bottom: 20px;
                }

                .form-group label {
                    display: block;
                    font-weight: 600;
                    color: #2c3e50;
                    margin-bottom: 8px;
                    font-size: 14px;
                }

                .form-group input {
                    width: 100%;
                    padding: 12px 15px;
                    border: 1px solid #ddd;
                    border-radius: 6px;
                    font-size: 14px;
                    transition: border-color 0.2s;
                    box-sizing: border-box;
                }

                .form-group input:focus {
                    outline: none;
                    border-color: #3498db;
                    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
                }

                .form-group input::placeholder {
                    color: #bdc3c7;
                }

                .form-group input.error {
                    border-color: #e74c3c;
                }

                .error-message {
                    color: #e74c3c;
                    font-size: 12px;
                    margin-top: 5px;
                    display: none;
                }

                .actions {
                    margin-top: 30px;
                    padding-top: 20px;
                    border-top: 1px solid #eee;
                    display: flex;
                    justify-content: flex-end;
                    gap: 10px;
                }

                .btn-cancel {
                    background-color: #95a5a6;
                    color: white;
                    padding: 12px 24px;
                    border-radius: 6px;
                    text-decoration: none;
                    font-weight: 600;
                    transition: background-color 0.2s;
                    border: none;
                    cursor: pointer;
                }

                .btn-cancel:hover {
                    background-color: #7f8c8d;
                }

                .btn-save {
                    background-color: #2ecc71;
                    color: white;
                    padding: 12px 24px;
                    border-radius: 6px;
                    font-weight: 600;
                    transition: background-color 0.2s;
                    border: none;
                    cursor: pointer;
                }

                .btn-save:hover {
                    background-color: #27ae60;
                }

                .required::after {
                    content: " *";
                    color: #e74c3c;
                }

                .alert {
                    padding: 12px 15px;
                    border-radius: 6px;
                    margin-bottom: 20px;
                    font-size: 14px;
                }

                .alert-error {
                    background-color: #fbebeb;
                    color: #e74c3c;
                    border: 1px solid #e74c3c;
                }
            </style>
        </head>

        <body>
            <jsp:include page="header.jsp" />

            <div class="container">
                <div class="card-header">
                    <h2>Add New Supplier</h2>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-error">${error}</div>
                </c:if>

                <form action="add-supplier" method="POST" onsubmit="return validateForm()">
                    <div class="form-group">
                        <label class="required">Full Name</label>
                        <input type="text" id="name" name="name" placeholder="Enter supplier name" value="${param.name}"
                            required>
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
                        <div id="phoneError" class="error-message">Please enter a valid phone number (10-15 digits)
                        </div>
                    </div>

                    <div class="actions">
                        <a href="supplier-list" class="btn-cancel">Cancel</a>
                        <button type="submit" class="btn-save">Save Supplier</button>
                    </div>
                </form>
            </div>

            <script>
                function validateForm() {
                    let isValid = true;

                    // Reset errors
                    document.querySelectorAll('.error-message').forEach(el => el.style.display = 'none');
                    document.querySelectorAll('.form-group input').forEach(el => el.classList.remove('error'));

                    // Validate name (required)
                    const name = document.getElementById('name').value.trim();
                    if (name === '') {
                        document.getElementById('nameError').style.display = 'block';
                        document.getElementById('name').classList.add('error');
                        isValid = false;
                    }

                    // Validate email (if provided)
                    const email = document.getElementById('email').value.trim();
                    if (email !== '' && !isValidEmail(email)) {
                        document.getElementById('emailError').style.display = 'block';
                        document.getElementById('email').classList.add('error');
                        isValid = false;
                    }

                    // Validate phone (if provided)
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