<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

    <head>
        <title>Add New Customer - WMS</title>

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
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="container">
            <div class="card-header">
                <h2>Add New Customer</h2>
            </div>

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

                <div class="actions">
                    <a href="customer-list" class="btn-cancel">Cancel</a>
                    <button type="submit" class="btn-save">Save Customer</button>
                </div>
            </form>
        </div>

        <jsp:include page="footer.jsp" />
    </body>

</html>