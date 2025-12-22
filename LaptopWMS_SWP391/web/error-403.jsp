<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Access Denied | Laptop WMS</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">
        <style>
            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                margin: 0;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 50%, #fecaca 100%);
            }

            .error-container {
                text-align: center;
                background: white;
                padding: 3rem;
                border-radius: 1.5rem;
                box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
                max-width: 480px;
                margin: 1rem;
                animation: fadeIn 0.4s ease-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .error-icon {
                font-size: 4rem;
                margin-bottom: 1rem;
            }

            .error-code {
                font-size: 5rem;
                font-weight: 800;
                background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin: 0;
                line-height: 1;
            }

            .error-title {
                font-size: 1.5rem;
                font-weight: 700;
                color: #1e293b;
                margin: 1rem 0;
            }

            .error-message {
                color: #64748b;
                margin: 0 0 2rem;
                line-height: 1.6;
                font-size: 0.9375rem;
            }

            .btn-group {
                display: flex;
                justify-content: center;
                gap: 0.75rem;
                flex-wrap: wrap;
            }

            .btn {
                padding: 0.75rem 1.5rem;
                border-radius: 2rem;
                font-weight: 600;
                font-size: 0.875rem;
                text-decoration: none;
                cursor: pointer;
                transition: all 0.2s ease;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                border: none;
            }

            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                box-shadow: 0 4px 14px rgba(102, 126, 234, 0.4);
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
            }

            .btn-secondary {
                background: #f1f5f9;
                color: #475569;
            }

            .btn-secondary:hover {
                background: #e2e8f0;
            }
        </style>
    </head>

    <body>
        <div class="error-container">
            <div class="error-icon">🚫</div>
            <h1 class="error-code">403</h1>
            <h2 class="error-title">Access Denied</h2>
            <p class="error-message">
                You don't have permission to access this page.<br>
                Please contact your administrator if you believe this is an error.
            </p>
            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/landing" class="btn btn-primary">🏠 Go to Home</a>
                <a href="javascript:history.back()" class="btn btn-secondary">← Go Back</a>
            </div>
        </div>
    </body>

    </html>