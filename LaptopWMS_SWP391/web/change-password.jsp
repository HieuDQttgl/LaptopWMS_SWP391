<%@ page contentType="text/html;charset=UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Change Password | Laptop WMS</title>
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

            .page-wrapper {
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
                min-height: calc(100vh - 200px);
            }

            .form-card {
                width: 100%;
                max-width: 420px;
                background: white;
                border-radius: 1rem;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                border: 1px solid #f1f5f9;
                overflow: hidden;
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
                text-align: center;
            }

            .card-header h2 {
                margin: 0;
                font-size: 1.375rem;
                font-weight: 700;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }

            .card-body {
                padding: 2rem;
            }

            .form-group {
                margin-bottom: 1.25rem;
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

            .btn-submit {
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

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
            }

            .back-link {
                display: block;
                text-align: center;
                margin-top: 1rem;
                color: #64748b;
                text-decoration: none;
                font-size: 0.875rem;
                font-weight: 500;
            }

            .back-link:hover {
                color: #667eea;
            }

            .message {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                padding: 1rem 1.25rem;
                border-radius: 0.75rem;
                margin-bottom: 1.5rem;
                font-weight: 500;
            }

            .msg-success {
                background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                color: #16a34a;
                border: 1px solid #86efac;
            }

            .msg-error {
                background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                color: #dc2626;
                border: 1px solid #fca5a5;
            }

            @media (max-width: 480px) {
                .page-wrapper {
                    padding: 1rem;
                }

                .card-body {
                    padding: 1.5rem;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="page-wrapper">
            <div class="form-card">
                <div class="card-header">
                    <h2>🔐 Change Password</h2>
                </div>

                <div class="card-body">
                    <% if (request.getAttribute("msg") !=null) { %>
                        <div class="message msg-success">✓ <%= request.getAttribute("msg") %>
                        </div>
                        <% } %>

                            <% if (request.getAttribute("error") !=null) { %>
                                <div class="message msg-error">⚠ <%= request.getAttribute("error") %>
                                </div>
                                <% } %>

                                    <form method="post" action="<%= request.getContextPath() %>/change-password">
                                        <div class="form-group">
                                            <label>Current Password</label>
                                            <input type="password" name="currentPassword"
                                                placeholder="Enter current password" required>
                                        </div>

                                        <div class="form-group">
                                            <label>New Password</label>
                                            <input type="password" name="newPassword" placeholder="Enter new password"
                                                required>
                                        </div>

                                        <div class="form-group">
                                            <label>Confirm New Password</label>
                                            <input type="password" name="confirmPassword"
                                                placeholder="Re-enter new password" required>
                                        </div>

                                        <button type="submit" class="btn-submit">Update Password</button>
                                    </form>

                                    <a href="<%= request.getContextPath() %>/profile" class="back-link">← Back to
                                        Profile</a>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
    </body>

    </html>