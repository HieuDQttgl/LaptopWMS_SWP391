<%@ page contentType="text/html;charset=UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password | Laptop WMS</title>
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
                background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
                background-size: 400% 400%;
                animation: gradientShift 15s ease infinite;
            }

            @keyframes gradientShift {
                0% {
                    background-position: 0% 50%;
                }

                50% {
                    background-position: 100% 50%;
                }

                100% {
                    background-position: 0% 50%;
                }
            }

            .auth-wrapper {
                width: 100%;
                max-width: 420px;
                padding: 1rem;
            }

            .card {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(20px);
                border-radius: 1.5rem;
                box-shadow: 0 25px 50px rgba(0, 0, 0, 0.25);
                padding: 2.5rem 2rem;
                text-align: center;
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

            .card-header h1 {
                margin: 0 0 0.5rem;
                font-size: 1.75rem;
                font-weight: 700;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .card-header p {
                margin: 0 0 1.5rem;
                font-size: 0.875rem;
                color: #64748b;
            }

            .message {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                padding: 0.875rem 1rem;
                border-radius: 0.75rem;
                margin-bottom: 1.25rem;
                font-weight: 500;
                font-size: 0.875rem;
            }

            .success-message {
                background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                color: #16a34a;
                border: 1px solid #86efac;
            }

            .error-message {
                background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                color: #dc2626;
                border: 1px solid #fca5a5;
            }

            .form-group {
                margin-bottom: 1.25rem;
                text-align: left;
            }

            .form-group label {
                display: block;
                font-weight: 600;
                color: #475569;
                margin-bottom: 0.5rem;
                font-size: 0.875rem;
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

            .btn-primary {
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

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
            }

            .meta {
                margin-top: 1.25rem;
                font-size: 0.875rem;
            }

            .meta a {
                color: #667eea;
                text-decoration: none;
                font-weight: 500;
            }

            .meta a:hover {
                text-decoration: underline;
            }

            @media (max-width: 480px) {
                .card {
                    padding: 2rem 1.5rem;
                }
            }
        </style>
    </head>

    <body>
        <div class="auth-wrapper">
            <div class="card">
                <div class="card-header">
                    <h1>🔑 Forgot Password</h1>
                    <p>Enter your email to receive a password reset link</p>
                </div>

                <% String msg=(String) request.getAttribute("msg"); String error=(String) request.getAttribute("error");
                    %>

                    <% if (msg !=null) { %>
                        <div class="message success-message">✓ <%= msg %>
                        </div>
                        <% } %>

                            <% if (error !=null) { %>
                                <div class="message error-message">⚠ <%= error %>
                                </div>
                                <% } %>

                                    <form method="post" action="<%= request.getContextPath() %>/forgot">
                                        <div class="form-group">
                                            <label for="email">Email Address</label>
                                            <input type="email" id="email" name="email"
                                                placeholder="Enter your registered email" required>
                                        </div>

                                        <button type="submit" class="btn-primary">Reset Password</button>

                                        <div class="meta">
                                            <a href="<%= request.getContextPath() %>/login">← Back to Login</a>
                                        </div>
                                    </form>
            </div>
        </div>
    </body>

    </html>