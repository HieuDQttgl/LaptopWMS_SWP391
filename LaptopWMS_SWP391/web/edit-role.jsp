<%@ page import="Model.Users" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <jsp:include page="header.jsp" />
            <meta charset="UTF-8">
            <title>Edit User Role | Laptop WMS</title>
            <style>
                body {
                    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                    background: linear-gradient(135deg, #f0f4ff 0%, #f8fafc 50%, #f0fdf4 100%);
                    margin: 0;
                    padding: 0;
                    min-height: 100vh;
                }

                .page-container {
                    max-width: 480px;
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
                    background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
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
                .form-group select {
                    width: 100%;
                    padding: 0.875rem 1rem;
                    border: 2px solid #e2e8f0;
                    border-radius: 0.5rem;
                    font-size: 0.9375rem;
                    transition: all 0.2s ease;
                    box-sizing: border-box;
                    outline: none;
                }

                .form-group input:focus,
                .form-group select:focus {
                    border-color: #8b5cf6;
                    box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.15);
                }

                .form-group input[disabled] {
                    background: #f8fafc;
                    color: #64748b;
                    cursor: not-allowed;
                }

                .form-actions {
                    margin-top: 2rem;
                    padding-top: 1.5rem;
                    border-top: 1px solid #f1f5f9;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .btn-back {
                    color: #64748b;
                    text-decoration: none;
                    font-size: 0.875rem;
                    font-weight: 500;
                }

                .btn-back:hover {
                    color: #8b5cf6;
                }

                .btn-save {
                    padding: 0.875rem 2rem;
                    background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
                    color: white;
                    border: none;
                    border-radius: 0.5rem;
                    font-weight: 600;
                    font-size: 0.9375rem;
                    cursor: pointer;
                    transition: all 0.2s ease;
                    box-shadow: 0 4px 14px rgba(139, 92, 246, 0.4);
                }

                .btn-save:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 6px 20px rgba(139, 92, 246, 0.5);
                }

                @media (max-width: 540px) {
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
                        <h2>🛡️ Edit User Role</h2>
                    </div>

                    <div class="card-body">
                        <% Users user=(Users) request.getAttribute("user"); %>

                            <form action="edit-role" method="post">
                                <input type="hidden" name="id" value="<%= user.getUserId() %>">

                                <div class="form-group">
                                    <label>Username</label>
                                    <input type="text" value="<%= user.getUsername() %>" disabled>
                                </div>

                                <div class="form-group">
                                    <label>Role</label>
                                    <select name="roleId">
                                        <option value="1" <%=user.getRoleId()==1 ? "selected" : "" %>>Administrator
                                        </option>
                                        <option value="2" <%=user.getRoleId()==2 ? "selected" : "" %>>Warehouse Keeper
                                        </option>
                                        <option value="3" <%=user.getRoleId()==3 ? "selected" : "" %>>Sale</option>
                                    </select>
                                </div>

                                <div class="form-actions">
                                    <a href="javascript:history.back()" class="btn-back">← Back</a>
                                    <button type="submit" class="btn-save">Save Role</button>
                                </div>
                            </form>
                    </div>
                </div>
            </div>
            <jsp:include page="footer.jsp" />
        </body>

        </html>