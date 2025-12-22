<%-- Document : footer Created on : Dec 11, 2025, 9:43:26 AM Author : Admin --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <style>
            .main-footer {
                margin-top: 4rem;
                padding: 2.5rem 2rem;
                background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
                color: white;
                text-align: center;
                position: relative;
                overflow: hidden;
            }

            .main-footer::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, #667eea 0%, #764ba2 50%, #667eea 100%);
                background-size: 200% 100%;
                animation: gradientMove 3s ease infinite;
            }

            @keyframes gradientMove {
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

            .footer-content {
                max-width: 1200px;
                margin: 0 auto;
            }

            .footer-brand {
                font-size: 1.5rem;
                font-weight: 700;
                background: linear-gradient(135deg, #667eea 0%, #a78bfa 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 0.75rem;
                display: inline-block;
            }

            .footer-links {
                display: flex;
                justify-content: center;
                gap: 2rem;
                margin-bottom: 1.5rem;
                flex-wrap: wrap;
            }

            .footer-links a {
                color: #94a3b8;
                text-decoration: none;
                font-size: 0.875rem;
                font-weight: 500;
                transition: color 0.2s ease;
            }

            .footer-links a:hover {
                color: #a78bfa;
            }

            .footer-divider {
                height: 1px;
                background: linear-gradient(90deg, transparent, #475569, transparent);
                margin: 1.5rem auto;
                max-width: 400px;
            }

            .footer-copyright {
                font-size: 0.875rem;
                color: #64748b;
            }

            .footer-copyright span {
                color: #94a3b8;
            }

            .footer-social {
                display: flex;
                justify-content: center;
                gap: 1rem;
                margin-bottom: 1rem;
            }

            .footer-social a {
                width: 36px;
                height: 36px;
                display: flex;
                align-items: center;
                justify-content: center;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 50%;
                color: #94a3b8;
                font-size: 1rem;
                transition: all 0.2s ease;
            }

            .footer-social a:hover {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                transform: translateY(-2px);
            }
        </style>

        <div class="main-footer">
            <div class="footer-content">
                <div class="footer-brand">📦 Laptop WMS</div>

                <div class="footer-links">
                    <a href="#">About</a>
                    <a href="#">Documentation</a>
                    <a href="#">Support</a>
                    <a href="#">Privacy Policy</a>
                </div>

                <div class="footer-social">
                    <a href="#" title="GitHub">💻</a>
                    <a href="#" title="Email">📧</a>
                    <a href="#" title="Support">💬</a>
                </div>

                <div class="footer-divider"></div>

                <div class="footer-copyright">
                    © <span id="currentYear">2025</span> Warehouse Management System — All rights reserved
                </div>
            </div>
        </div>

        <script>
            document.getElementById('currentYear').textContent = new Date().getFullYear();
        </script>