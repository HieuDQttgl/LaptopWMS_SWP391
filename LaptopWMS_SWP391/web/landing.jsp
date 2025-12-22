<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Laptop Warehouse Management System</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">
        <style>
            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                margin: 0;
                min-height: 100vh;
                background: linear-gradient(135deg, #f0f4ff 0%, #f8fafc 50%, #f0fdf4 100%);
            }

            .hero {
                text-align: center;
                padding: 5rem 2rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                position: relative;
                overflow: hidden;
            }

            .hero::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.05'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
                opacity: 0.5;
            }

            .hero-content {
                position: relative;
                z-index: 1;
                max-width: 700px;
                margin: 0 auto;
            }

            .hero h1 {
                font-size: 2.75rem;
                font-weight: 800;
                margin: 0 0 1rem;
                line-height: 1.2;
            }

            .hero p {
                font-size: 1.125rem;
                opacity: 0.9;
                max-width: 500px;
                margin: 0 auto 2rem;
                line-height: 1.6;
            }

            .hero-buttons {
                display: flex;
                justify-content: center;
                gap: 1rem;
                flex-wrap: wrap;
            }

            .btn {
                padding: 0.875rem 2rem;
                border-radius: 2rem;
                font-weight: 600;
                font-size: 0.9375rem;
                cursor: pointer;
                transition: all 0.2s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }

            .btn-primary {
                background: white;
                color: #667eea;
                border: none;
                box-shadow: 0 4px 14px rgba(0, 0, 0, 0.15);
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
            }

            .btn-secondary {
                background: transparent;
                color: white;
                border: 2px solid rgba(255, 255, 255, 0.4);
            }

            .btn-secondary:hover {
                background: rgba(255, 255, 255, 0.1);
                border-color: white;
            }

            .features {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 2rem;
                padding: 4rem 2rem;
                max-width: 1200px;
                margin: 0 auto;
            }

            .feature-card {
                background: white;
                padding: 2rem;
                border-radius: 1rem;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                text-align: center;
                transition: all 0.3s ease;
                border: 1px solid #f1f5f9;
            }

            .feature-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
            }

            .feature-icon {
                font-size: 2.5rem;
                margin-bottom: 1rem;
            }

            .feature-card h3 {
                margin: 0 0 0.75rem;
                font-size: 1.25rem;
                font-weight: 700;
                color: #1e293b;
            }

            .feature-card p {
                margin: 0;
                font-size: 0.9375rem;
                color: #64748b;
                line-height: 1.6;
            }

            @media (max-width: 768px) {
                .hero {
                    padding: 3rem 1.5rem;
                }

                .hero h1 {
                    font-size: 2rem;
                }

                .features {
                    padding: 2rem 1rem;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="hero" id="hero">
            <div class="hero-content">
                <h1>Streamline Your<br>Warehouse Operations</h1>
                <p>A comprehensive solution for managing your laptop inventory with ease. Track products, manage
                    tickets, and boost efficiency.</p>
                <div class="hero-buttons">
                    <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-primary">🚀 Get Started</a>
                    <a href="#features" class="btn btn-secondary">Learn More</a>
                </div>
            </div>
        </div>

        <div class="features" id="features">
            <div class="feature-card">
                <div class="feature-icon">📦</div>
                <h3>Inventory Tracking</h3>
                <p>Keep track of all your laptop inventory in real-time with detailed product information and stock
                    levels.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">📋</div>
                <h3>Ticket Management</h3>
                <p>Easily create and manage import/export tickets to track all warehouse operations efficiently.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">📊</div>
                <h3>Reports & Analytics</h3>
                <p>Generate comprehensive reports to gain insights into your warehouse performance and trends.</p>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
    </body>

    </html>