<%-- Document : landing Created on : Dec 4, 2025, 8:52:14 PM Author : Admin --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <title>Laptop Warehouse Management System</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
            }

            .hero {
                text-align: center;
                padding: 80px 20px;
            }

            .hero h1 {
                font-size: 28px;
                margin-bottom: 10px;
            }

            .hero p {
                width: 460px;
                max-width: 90%;
                margin: 10px auto 30px;
                color: #555;
            }

            .hero button {
                padding: 12px 24px;
                margin: 10px;
                border-radius: 20px;
                border: 1px solid black;
                background: white;
                cursor: pointer;
            }

            .hero button.primary {
                background: black;
                color: white;
            }


            .features {
                display: flex;
                justify-content: center;
                gap: 80px;
                padding: 40px 0 80px;
                text-align: center;
            }

            .feature-item {
                width: 250px;
            }

            .feature-item p {
                font-size: 14px;
                color: #666;
            }
        </style>
    </head>

    <body>
        
        <jsp:include page="header.jsp" />

        <!-- Hero Section -->
        <div class="hero" id="hero">
            <h1>Unique solution to your<br>warehouse management need</h1>

            <p>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quam velit, vulputate eu pharetra
                nec, mattis ac neque.
            </p>

            <button class="primary">GET STARTED</button>
            <button>LEARN MORE</button>
        </div>

        <!-- Features -->
        <div class="features" id="features">
            <div class="feature-item">
                <h3>✔ Feature One</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam quis felis convallis, rhoncus leo
                    id, scelerisque purus.</p>
            </div>

            <div class="feature-item">
                <h3>📄 Feature Two</h3>
                <p>Aliquam vel nibh iaculis, ornare purus sit amet, euismod dui. Cras sed tristique neque.</p>
            </div>

            <div class="feature-item">
                <h3>⭐ Feature Three</h3>
                <p>Vestibulum ultricies erat vitae faucibus volutpat. Sed finibus ipsum eu nibh volutpat.</p>
            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="footer.jsp" />
    </body>

</html>