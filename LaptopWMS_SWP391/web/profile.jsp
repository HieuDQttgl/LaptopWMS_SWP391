<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Profile | Laptop WMS</title>
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

            .profile-wrapper {
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
                min-height: calc(100vh - 200px);
            }

            .profile-card {
                width: 100%;
                max-width: 500px;
                background: white;
                border-radius: 1rem;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                border: 1px solid #f1f5f9;
                animation: fadeIn 0.3s ease-out;
                overflow: hidden;
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
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .card-header h1 {
                margin: 0;
                font-size: 1.375rem;
                font-weight: 700;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .card-header p {
                margin: 0.25rem 0 0;
                font-size: 0.8125rem;
                opacity: 0.85;
            }

            .badge {
                padding: 0.375rem 0.875rem;
                background: rgba(255, 255, 255, 0.2);
                border-radius: 2rem;
                font-size: 0.75rem;
                font-weight: 600;
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
            }

            .message.success {
                background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                color: #16a34a;
                border: 1px solid #86efac;
            }

            .message.error {
                background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                color: #dc2626;
                border: 1px solid #fca5a5;
            }

            .field-group {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.875rem 0;
                border-bottom: 1px solid #f1f5f9;
            }

            .field-group:last-child {
                border-bottom: none;
            }

            .field-label {
                font-size: 0.875rem;
                color: #64748b;
                font-weight: 500;
            }

            .field-value {
                font-size: 0.9375rem;
                font-weight: 600;
                color: #1e293b;
            }

            .field-value.muted {
                color: #94a3b8;
                font-weight: 400;
            }

            .field-input {
                width: 200px;
                padding: 0.625rem 0.875rem;
                border: 2px solid #e2e8f0;
                border-radius: 0.5rem;
                font-size: 0.875rem;
                font-family: inherit;
                outline: none;
                transition: all 0.2s ease;
            }

            .field-input:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
            }

            .edit-mode {
                display: none;
            }

            .view-mode {
                display: flex;
            }

            .actions {
                margin-top: 1.5rem;
                padding-top: 1rem;
                display: flex;
                justify-content: flex-end;
                gap: 0.75rem;
                flex-wrap: wrap;
            }

            .btn {
                padding: 0.625rem 1.25rem;
                border-radius: 2rem;
                font-weight: 600;
                font-size: 0.8125rem;
                cursor: pointer;
                transition: all 0.2s ease;
                text-decoration: none;
                border: none;
                display: inline-flex;
                align-items: center;
                gap: 0.375rem;
            }

            .btn-secondary {
                background: #e2e8f0;
                color: #475569;
            }

            .btn-secondary:hover {
                background: #cbd5e1;
            }

            .btn-link {
                background: transparent;
                color: #64748b;
                padding: 0.625rem 0.875rem;
            }

            .btn-link:hover {
                color: #1e293b;
            }

            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                box-shadow: 0 4px 14px rgba(102, 126, 234, 0.4);
            }

            .btn-primary:hover {
                transform: translateY(-1px);
                box-shadow: 0 6px 18px rgba(102, 126, 234, 0.5);
            }

            .btn-danger {
                background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                color: white;
                box-shadow: 0 4px 14px rgba(239, 68, 68, 0.4);
            }

            .btn-danger:hover {
                transform: translateY(-1px);
                box-shadow: 0 6px 18px rgba(239, 68, 68, 0.5);
            }

            @media (max-width: 540px) {
                .profile-wrapper {
                    padding: 1rem;
                }

                .card-body {
                    padding: 1.5rem;
                }

                .field-group {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 0.5rem;
                }

                .field-input {
                    width: 100%;
                }

                .actions {
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

        <div class="profile-wrapper">
            <div class="profile-card">
                <div class="card-header">
                    <div>
                        <h1>👤 My Profile</h1>
                        <p>Manage your account information</p>
                    </div>
                    <span class="badge">Signed in</span>
                </div>

                <div class="card-body">
                    <% String successMsg=(String) request.getAttribute("success"); String errorMsg=(String)
                        request.getAttribute("error"); Model.Users currentUser=(Model.Users)
                        request.getSession().getAttribute("currentUser"); String fullName=currentUser !=null ?
                        (currentUser.getFullName() !=null ? currentUser.getFullName() : "" ) : "" ; String
                        email=currentUser !=null ? (currentUser.getEmail() !=null ? currentUser.getEmail() : "" ) : "" ;
                        %>

                        <% if (successMsg !=null) { %>
                            <div class="message success">✓ <%= successMsg %>
                            </div>
                            <% } %>
                                <% if (errorMsg !=null) { %>
                                    <div class="message error">⚠ <%= errorMsg %>
                                    </div>
                                    <% } %>

                                        <form method="post" action="<%= request.getContextPath() %>/profile"
                                            id="profileForm">
                                            <div class="field-group view-mode">
                                                <span class="field-label">Full name</span>
                                                <span class="field-value">
                                                    <%= fullName.isEmpty() ? "—" : fullName %>
                                                </span>
                                            </div>
                                            <div class="field-group edit-mode">
                                                <span class="field-label">Full name</span>
                                                <input type="text" name="fullName" class="field-input"
                                                    value="<%= fullName %>" required>
                                            </div>

                                            <div class="field-group">
                                                <span class="field-label">Username</span>
                                                <span class="field-value">
                                                    <%= request.getSession().getAttribute("username") %>
                                                </span>
                                            </div>

                                            <div class="field-group view-mode">
                                                <span class="field-label">Email</span>
                                                <span class="field-value">
                                                    <%= email.isEmpty() ? "—" : email %>
                                                </span>
                                            </div>
                                            <div class="field-group edit-mode">
                                                <span class="field-label">Email</span>
                                                <input type="email" name="email" class="field-input"
                                                    value="<%= email %>" required>
                                            </div>

                                            <div class="actions edit-mode" style="display: none;">
                                                <button type="button" onclick="cancelEdit()"
                                                    class="btn btn-secondary">Cancel</button>
                                                <button type="submit" class="btn btn-primary">Save Changes</button>
                                            </div>
                                        </form>

                                        <div class="actions view-mode">
                                            <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-link">←
                                                Dashboard</a>
                                            <button type="button" onclick="enableEditMode()"
                                                class="btn btn-primary">Edit Profile</button>
                                            <a href="<%= request.getContextPath() %>/change-password"
                                                class="btn btn-secondary">Change Password</a>
                                            <a href="<%= request.getContextPath() %>/logout" class="btn btn-danger">Sign
                                                Out</a>
                                        </div>
                </div>
            </div>
        </div>

        <script>
            function enableEditMode() {
                document.querySelectorAll('.view-mode').forEach(el => el.style.display = 'none');
                document.querySelectorAll('.edit-mode').forEach(el => {
                    el.style.display = el.classList.contains('field-group') ? 'flex' : 'block';
                });
            }

            function cancelEdit() {
                document.querySelectorAll('.edit-mode').forEach(el => el.style.display = 'none');
                document.querySelectorAll('.view-mode').forEach(el => {
                    el.style.display = el.classList.contains('field-group') ? 'flex' : 'block';
                });
            }

            document.getElementById('profileForm').addEventListener('submit', function (e) {
                const email = document.querySelector('input[name="email"]').value.trim();
                if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                    showToast('error', 'Invalid Email', 'Please enter a valid email address.');
                    e.preventDefault();
                }
            });
        </script>

        <%@include file="common-dialogs.jsp" %>
            <jsp:include page="footer.jsp" />
    </body>

    </html>