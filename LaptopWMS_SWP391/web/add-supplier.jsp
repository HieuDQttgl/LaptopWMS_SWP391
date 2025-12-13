<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <jsp:include page="header.jsp" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Supplier</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                margin: 0;
                padding: 20px;
            }

            .container {
                max-width: 600px;
                margin: 50px auto;
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                color: #333;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 3px solid #3498db;
            }

            .message {
                background-color: #d4edda;
                color: #155724;
                padding: 12px;
                border-radius: 4px;
                margin-bottom: 20px;
                border: 1px solid #c3e6cb;
            }

            .error {
                background-color: #f8d7da;
                color: #721c24;
                padding: 12px;
                border-radius: 4px;
                margin-bottom: 20px;
                border: 1px solid #f5c6cb;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #333;
            }

            .required {
                color: #e74c3c;
            }

            input[type="text"],
            input[type="email"] {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 14px;
                transition: border-color 0.3s;
            }

            input[type="text"]:focus,
            input[type="email"]:focus {
                outline: none;
                border-color: #3498db;
                box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
            }

            .help-text {
                font-size: 12px;
                color: #7f8c8d;
                margin-top: 5px;
            }

            .button-group {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 30px;
                padding-top: 20px;
                border-top: 1px solid #eee;
            }

            .btn-submit {
                background-color: #3498db;
                color: white;
                padding: 12px 30px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 15px;
                font-weight: 600;
                transition: background-color 0.3s;
            }

            .btn-submit:hover {
                background-color: #2980b9;
            }

            .btn-back {
                color: #7f8c8d;
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s;
            }

            .btn-back:hover {
                color: #3498db;
                text-decoration: underline;
            }

            .info-box {
                background-color: #e8f4fd;
                border: 1px solid #bee5eb;
                border-radius: 4px;
                padding: 15px;
                margin-bottom: 25px;
                color: #0c5460;
            }

            .info-box h4 {
                margin: 0 0 5px 0;
                font-size: 14px;
            }

            .info-box p {
                margin: 0;
                font-size: 13px;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <h2>Add New Supplier</h2>

            <div class="info-box">
                <h4>ℹ️ Supplier Information</h4>
                <p>Add a new supplier to the warehouse management system. Suppliers are used for product imports.</p>
            </div>

            <% if (request.getAttribute("message") != null) {%>
            <div class="message">
                <%= request.getAttribute("message")%>
            </div>
            <% } %>

            <% if (request.getAttribute("error") != null) {%>
            <div class="error">
                <%= request.getAttribute("error")%>
            </div>
            <% } %>

            <% String supplierNameValue = request.getAttribute("supplierName") != null ? (String) request.getAttribute("supplierName") : "";
                String supplierEmailValue = request.getAttribute("supplierEmail") != null ? (String) request.getAttribute("supplierEmail") : "";
                String supplierPhoneValue = request.getAttribute("supplierPhone") != null ? (String) request.getAttribute("supplierPhone") : "";%>

            <form method="post" action="add-supplier">
                <div class="form-group">
                    <label for="supplierName">Supplier Name <span class="required">*</span></label>
                    <input type="text" id="supplierName" name="supplierName"
                           value="<%= supplierNameValue%>"
                           placeholder="e.g., Dell Vietnam, HP Official Distributor" required>
                    <p class="help-text">Enter the official name of the supplier (2-255 characters)
                    </p>
                </div>

                <div class="form-group">
                    <label for="supplierEmail">Email</label>
                    <input type="email" id="supplierEmail" name="supplierEmail"
                           value="<%= supplierEmailValue%>" placeholder="e.g., contact@supplier.com">
                    <p class="help-text">Business email address for communication</p>
                </div>

                <div class="form-group">
                    <label for="supplierPhone">Phone Number</label>
                    <input type="text" id="supplierPhone" name="supplierPhone"
                           value="<%= supplierPhoneValue%>" placeholder="e.g., 0901234567">
                    <p class="help-text">10-11 digits starting with 0</p>
                </div>

                <div class="button-group">
                    <a href="<%= request.getContextPath()%>/supplier-list" class="btn-back">← Back
                        to Supplier List</a>
                    <button type="submit" class="btn-submit">Add Supplier</button>
                </div>
            </form>
        </div>
        <jsp:include page="footer.jsp" />
    </body>

</html>