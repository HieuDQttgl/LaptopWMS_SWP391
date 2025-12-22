<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign In | Laptop WMS</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
                background-size: 400% 400%;
                animation: gradientBG 15s ease infinite;
                position: relative;
                overflow: hidden;
            }

            @keyframes gradientBG {
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

            /* Animated Background Shapes */
            .bg-shape {
                position: absolute;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.1);
                animation: float 6s ease-in-out infinite;
            }

            .bg-shape:nth-child(1) {
                width: 400px;
                height: 400px;
                top: -10%;
                left: -10%;
                animation-delay: 0s;
            }

            .bg-shape:nth-child(2) {
                width: 300px;
                height: 300px;
                bottom: -5%;
                right: -5%;
                animation-delay: 2s;
            }

            .bg-shape:nth-child(3) {
                width: 200px;
                height: 200px;
                bottom: 30%;
                left: 10%;
                animation-delay: 4s;
            }

            @keyframes float {

                0%,
                100% {
                    transform: translateY(0) rotate(0deg);
                }

                50% {
                    transform: translateY(-20px) rotate(5deg);
                }
            }

            /* Login Card */
            .login-wrapper {
                width: 100%;
                max-width: 440px;
                padding: 1.5rem;
                position: relative;
                z-index: 10;
            }

            .login-card {
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(20px);
                -webkit-backdrop-filter: blur(20px);
                border-radius: 1.5rem;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
                border: 1px solid rgba(255, 255, 255, 0.3);
                padding: 2.5rem;
                animation: slideUp 0.5s ease-out;
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Brand */
            .brand {
                text-align: center;
                margin-bottom: 2rem;
            }

            .brand-icon {
                font-size: 3rem;
                margin-bottom: 0.75rem;
                display: block;
            }

            .brand-name {
                font-size: 1.75rem;
                font-weight: 800;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .brand-tagline {
                font-size: 0.875rem;
                color: #64748b;
                margin-top: 0.25rem;
            }

            /* Header */
            .login-header {
                text-align: center;
                margin-bottom: 1.5rem;
            }

            .login-header h1 {
                font-size: 1.5rem;
                font-weight: 700;
                color: #1e293b;
                margin-bottom: 0.25rem;
            }

            .login-header p {
                font-size: 0.875rem;
                color: #64748b;
            }

            /* Messages */
            .message {
                padding: 0.875rem 1rem;
                border-radius: 0.75rem;
                margin-bottom: 1.25rem;
                font-size: 0.875rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                animation: fadeIn 0.3s ease-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }

                to {
                    opacity: 1;
                }
            }

            .message-error {
                background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                border: 1px solid #fca5a5;
                color: #dc2626;
            }

            .message-success {
                background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                border: 1px solid #86efac;
                color: #16a34a;
            }

            /* Form */
            .form-group {
                margin-bottom: 1.25rem;
            }

            .form-label {
                display: block;
                font-size: 0.8125rem;
                font-weight: 600;
                color: #475569;
                margin-bottom: 0.5rem;
            }

            .form-input {
                width: 100%;
                padding: 0.875rem 1rem;
                font-size: 0.9375rem;
                font-family: inherit;
                color: #1e293b;
                background: #f8fafc;
                border: 2px solid #e2e8f0;
                border-radius: 0.75rem;
                outline: none;
                transition: all 0.2s ease;
            }

            .form-input:focus {
                border-color: #667eea;
                background: white;
                box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.15);
            }

            .form-input::placeholder {
                color: #94a3b8;
            }

            /* Submit Button */
            .btn-submit {
                width: 100%;
                padding: 0.9375rem 1.5rem;
                font-size: 0.9375rem;
                font-weight: 600;
                font-family: inherit;
                color: white;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                border-radius: 0.75rem;
                cursor: pointer;
                transition: all 0.2s ease;
                box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
                margin-top: 0.5rem;
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 15px 35px rgba(102, 126, 234, 0.5);
            }

            .btn-submit:active {
                transform: translateY(0);
            }

            /* Footer Links */
            .login-footer {
                text-align: center;
                margin-top: 1.5rem;
                padding-top: 1.5rem;
                border-top: 1px solid #e2e8f0;
            }

            .login-footer a {
                font-size: 0.875rem;
                color: #667eea;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.2s ease;
            }

            .login-footer a:hover {
                color: #764ba2;
            }

            /* Copyright */
            .copyright {
                text-align: center;
                margin-top: 1.5rem;
                font-size: 0.75rem;
                color: rgba(255, 255, 255, 0.7);
            }

            /* Responsive */
            @media (max-width: 480px) {
                .login-card {
                    padding: 1.75rem 1.5rem;
                }

                .brand-name {
                    font-size: 1.5rem;
                }
            }
        </style>
    </head>

    <body>
        <!-- Background Shapes -->
        <div class="bg-shape"></div>
        <div class="bg-shape"></div>
        <div class="bg-shape"></div>

        <div class="login-wrapper">
            <div class="login-card">
                <!-- Brand -->
                <div class="brand">
                    <span class="brand-icon">📦</span>
                    <div class="brand-name">Laptop WMS</div>
                    <div class="brand-tagline">Warehouse Management System</div>
                </div>

                <!-- Header -->
                <div class="login-header">
                    <h1>Welcome back</h1>
                    <p>Please sign in to your account</p>
                </div>

                <% String error=(String) request.getAttribute("error"); String usernameVal=(String)
                    request.getAttribute("username"); String successMsg=(String) session.getAttribute("message"); String
                    urlMsg=request.getParameter("msg"); if (successMsg !=null) { session.removeAttribute("message"); }
                    %>

                    <% if (successMsg !=null) {%>
                        <div class="message message-success">
                            ✓ <%= successMsg%>
                        </div>
                        <% } %>

                            <% if (urlMsg !=null && !urlMsg.isEmpty()) {%>
                                <div class="message message-success">
                                    ✓ <%= urlMsg%>
                                </div>
                                <% } %>

                                    <% if (error !=null) {%>
                                        <div class="message message-error">
                                            ⚠ <%= error%>
                                        </div>
                                        <% }%>

                                            <form method="post" action="<%= request.getContextPath()%>/login">
                                                <div class="form-group">
                                                    <label class="form-label" for="username">Username</label>
                                                    <input type="text" id="username" name="username" class="form-input"
                                                        value="<%= usernameVal != null ? usernameVal : ""%>"
                                                        placeholder="Enter your username" required>
                                                </div>

                                                <div class="form-group">
                                                    <label class="form-label" for="password">Password</label>
                                                    <input type="password" id="password" name="password"
                                                        class="form-input" placeholder="Enter your password" required>
                                                </div>

                                                <button type="submit" class="btn-submit">
                                                    Sign In →
                                                </button>
                                            </form>

                                            <div class="login-footer">
                                                <a href="<%= request.getContextPath()%>/forgot">Forgot your
                                                    password?</a>
                                            </div>
            </div>

            <div class="copyright">
                © 2025 Laptop WMS — All rights reserved
            </div>
        </div>
    </body>

    </html>