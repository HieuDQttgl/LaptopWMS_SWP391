<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <jsp:include page="header.jsp" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Role | Laptop WMS</title>
        <style>
            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                background: linear-gradient(135deg, #f0f4ff 0%, #f8fafc 50%, #f0fdf4 100%);
                margin: 0;
                padding: 0;
                min-height: 100vh;
            }

            .page-container {
                max-width: 550px;
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

            .message {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                padding: 1rem 1.25rem;
                border-radius: 0.75rem;
                margin-bottom: 1.5rem;
                font-weight: 500;
                background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                color: #16a34a;
                border: 1px solid #86efac;
            }

            .error {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                padding: 1rem 1.25rem;
                border-radius: 0.75rem;
                margin-bottom: 1.5rem;
                font-weight: 500;
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

            .form-group input[type="text"],
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
            .form-group textarea:focus {
                border-color: #10b981;
                box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.15);
            }

            .form-group textarea {
                resize: vertical;
                min-height: 100px;
            }

            .button-group {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 2rem;
                padding-top: 1.5rem;
                border-top: 1px solid #f1f5f9;
            }

            .btn-submit {
                padding: 0.875rem 1.75rem;
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                color: white;
                border: none;
                border-radius: 0.5rem;
                font-weight: 600;
                font-size: 0.9375rem;
                cursor: pointer;
                transition: all 0.2s ease;
                box-shadow: 0 4px 14px rgba(16, 185, 129, 0.4);
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(16, 185, 129, 0.5);
            }

            .btn-back {
                color: #64748b;
                text-decoration: none;
                font-size: 0.875rem;
                font-weight: 500;
            }

            .btn-back:hover {
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
            }
        </style>
    </head>

    <body>
        <div class="page-container">
            <div class="form-card">
                <div class="card-header">
                    <h2>🛡️ Add New Role</h2>
                </div>

                <div class="card-body">
                    <% if (request.getAttribute("message") !=null) { %>
                        <div class="message">✓ <%= request.getAttribute("message") %>
                        </div>
                        <% } %>

                            <% if (request.getAttribute("error") !=null) { %>
                                <div class="error">⚠ <%= request.getAttribute("error") %>
                                </div>
                                <% } %>

                                    <form method="post" action="add-role">
                                        <div class="form-group">
                                            <label for="roleName">Role Name *</label>
                                            <input type="text" id="roleName" name="roleName" required
                                                placeholder="Enter role name">
                                        </div>

                                        <div class="form-group">
                                            <label for="roleDescription">Description</label>
                                            <textarea id="roleDescription" name="roleDescription"
                                                placeholder="Enter role description (optional)"></textarea>
                                        </div>

                                        <div class="button-group">
                                            <a href="javascript:history.back()" class="btn-back">← Back</a>
                                            <button type="submit" class="btn-submit">Add Role</button>
                                        </div>
                                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </body>

    </html>