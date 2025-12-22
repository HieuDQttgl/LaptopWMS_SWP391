<%-- Document : header Created on : Dec 11, 2025, 9:43:13 AM Author : Admin --%>

    <%@page import="Model.Users" %>
        <%@page import="DAO.NotificationDAO" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <% Users currentUser=(Users) session.getAttribute("currentUser"); int roleId=-1; int
                    notificationCount=0; if (currentUser !=null) { roleId=currentUser.getRoleId(); NotificationDAO
                    notificationDAO=new NotificationDAO();
                    notificationCount=notificationDAO.getUnreadCount(currentUser.getUserId()); }%>

                    <!-- Global CSS -->
                    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/styles.css">
                    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/animations.css">

                    <style>
                        /* Header Styles - Gradient Navigation */
                        .main-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            padding: 1rem 2rem;
                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                            position: sticky;
                            top: 0;
                            z-index: 100;
                            box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
                        }

                        .header-brand a {
                            font-size: 1.5rem;
                            font-weight: 800;
                            color: white;
                            text-decoration: none;
                            display: flex;
                            align-items: center;
                            gap: 0.5rem;
                            transition: transform 0.2s ease;
                            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                        }

                        .header-brand a:hover {
                            transform: scale(1.02);
                        }

                        .header-brand .brand-icon {
                            font-size: 1.75rem;
                        }

                        .header-nav {
                            display: flex;
                            align-items: center;
                            gap: 0.5rem;
                        }

                        .nav-link {
                            padding: 0.5rem 1rem;
                            font-size: 0.875rem;
                            font-weight: 500;
                            color: rgba(255, 255, 255, 0.9);
                            border-radius: 0.5rem;
                            text-decoration: none;
                            transition: all 0.2s ease;
                            display: flex;
                            align-items: center;
                            gap: 0.375rem;
                        }

                        .nav-link:hover {
                            background: rgba(255, 255, 255, 0.15);
                            color: white;
                        }

                        .nav-dropdown {
                            position: relative;
                        }

                        .nav-dropdown-trigger {
                            cursor: pointer;
                            padding-bottom: 1rem;
                            margin-bottom: -0.5rem;
                        }

                        .nav-dropdown-content {
                            display: none;
                            position: absolute;
                            top: 100%;
                            left: 0;
                            min-width: 220px;
                            padding: 0.5rem;
                            padding-top: 0.75rem;
                            background: white;
                            border-radius: 0.75rem;
                            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
                            border: 1px solid #f1f5f9;
                            z-index: 1000;
                            animation: slideDown 0.2s ease-out;
                        }

                        .nav-dropdown-content::before {
                            content: '';
                            position: absolute;
                            top: -10px;
                            left: 0;
                            right: 0;
                            height: 10px;
                            background: transparent;
                        }

                        .nav-dropdown:hover .nav-dropdown-content {
                            display: block;
                        }

                        .nav-dropdown-item {
                            display: flex;
                            align-items: center;
                            gap: 0.75rem;
                            padding: 0.75rem 1rem;
                            font-size: 0.875rem;
                            color: #475569;
                            border-radius: 0.5rem;
                            text-decoration: none;
                            transition: all 0.15s ease;
                        }

                        .nav-dropdown-item:hover {
                            background: linear-gradient(135deg, #eff6ff 0%, #f0fdf4 100%);
                            color: #1e40af;
                        }

                        .nav-dropdown-item .item-icon {
                            font-size: 1rem;
                            opacity: 0.8;
                        }

                        .nav-dropdown-divider {
                            height: 1px;
                            background: #f1f5f9;
                            margin: 0.5rem 0;
                        }

                        /* User Menu */
                        .user-menu {
                            display: flex;
                            align-items: center;
                            gap: 0.75rem;
                            padding: 0.5rem 1rem;
                            background: rgba(255, 255, 255, 0.15);
                            border-radius: 2rem;
                            cursor: pointer;
                            transition: all 0.2s ease;
                        }

                        .user-menu:hover {
                            background: rgba(255, 255, 255, 0.25);
                            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
                        }

                        .user-avatar {
                            width: 32px;
                            height: 32px;
                            background: rgba(255, 255, 255, 0.95);
                            border-radius: 50%;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            color: #667eea;
                            font-size: 0.75rem;
                            font-weight: 700;
                        }

                        .user-name {
                            font-size: 0.875rem;
                            font-weight: 500;
                            color: white;
                        }

                        .user-dropdown {
                            right: 0;
                            left: auto;
                        }

                        /* Notification Bell */
                        .notification-wrapper {
                            position: relative;
                        }

                        .notification-bell {
                            cursor: pointer;
                            padding: 0.5rem 0.75rem;
                            font-size: 1.25rem;
                            color: rgba(255, 255, 255, 0.9);
                            border-radius: 0.5rem;
                            transition: all 0.2s ease;
                            position: relative;
                        }

                        .notification-bell:hover {
                            background: rgba(255, 255, 255, 0.15);
                            color: white;
                        }

                        .notification-badge {
                            position: absolute;
                            top: 0.25rem;
                            right: 0.25rem;
                            min-width: 18px;
                            height: 18px;
                            padding: 0 0.25rem;
                            font-size: 0.625rem;
                            font-weight: 700;
                            color: white;
                            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                            border-radius: 50%;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            animation: pulse 2s infinite;
                            box-shadow: 0 2px 8px rgba(239, 68, 68, 0.4);
                        }

                        .notification-dropdown {
                            display: none;
                            position: absolute;
                            top: calc(100% + 0.75rem);
                            right: 0;
                            width: 380px;
                            max-height: 480px;
                            background: white;
                            border-radius: 1rem;
                            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
                            border: 1px solid #f1f5f9;
                            z-index: 1000;
                            overflow: hidden;
                            animation: slideDown 0.2s ease-out;
                        }

                        .notification-dropdown.show {
                            display: block;
                        }

                        .notif-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            padding: 1rem 1.25rem;
                            background: linear-gradient(135deg, #f8fafc 0%, white 100%);
                            border-bottom: 1px solid #f1f5f9;
                        }

                        .notif-header h4 {
                            margin: 0;
                            font-size: 1rem;
                            font-weight: 600;
                            color: #1e293b;
                        }

                        .mark-all-btn {
                            font-size: 0.75rem;
                            color: #3b82f6;
                            cursor: pointer;
                            text-decoration: none;
                            font-weight: 500;
                            transition: color 0.15s ease;
                        }

                        .mark-all-btn:hover {
                            color: #1d4ed8;
                            text-decoration: underline;
                        }

                        .notif-list {
                            max-height: 360px;
                            overflow-y: auto;
                        }

                        .notif-item {
                            display: flex;
                            padding: 1rem 1.25rem;
                            border-bottom: 1px solid #f8fafc;
                            cursor: pointer;
                            transition: all 0.15s ease;
                        }

                        .notif-item:hover {
                            background: #f8fafc;
                        }

                        .notif-item.unread {
                            background: linear-gradient(135deg, #eff6ff 0%, #f0fdf4 100%);
                            border-left: 3px solid #3b82f6;
                        }

                        .notif-item.unread:hover {
                            background: linear-gradient(135deg, #dbeafe 0%, #dcfce7 100%);
                        }

                        .notif-icon {
                            width: 40px;
                            height: 40px;
                            border-radius: 50%;
                            background: linear-gradient(135deg, #e0e7ff 0%, #dbeafe 100%);
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            margin-right: 0.75rem;
                            flex-shrink: 0;
                            font-size: 1rem;
                        }

                        .notif-icon.password-reset {
                            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
                        }

                        .notif-content {
                            flex: 1;
                            min-width: 0;
                        }

                        .notif-title {
                            font-size: 0.8125rem;
                            font-weight: 600;
                            color: #1e293b;
                            margin-bottom: 0.25rem;
                            white-space: nowrap;
                            overflow: hidden;
                            text-overflow: ellipsis;
                        }

                        .notif-message {
                            font-size: 0.75rem;
                            color: #64748b;
                            line-height: 1.4;
                            display: -webkit-box;
                            -webkit-line-clamp: 2;
                            -webkit-box-orient: vertical;
                            overflow: hidden;
                        }

                        .notif-time {
                            font-size: 0.6875rem;
                            color: #94a3b8;
                            margin-top: 0.25rem;
                        }

                        .notif-empty {
                            padding: 3rem 1.5rem;
                            text-align: center;
                            color: #94a3b8;
                        }

                        .notif-empty-icon {
                            font-size: 2.5rem;
                            margin-bottom: 0.75rem;
                            opacity: 0.5;
                        }

                        .notif-footer {
                            padding: 0.875rem 1.25rem;
                            text-align: center;
                            border-top: 1px solid #f1f5f9;
                            background: #f8fafc;
                        }

                        .notif-footer a {
                            font-size: 0.8125rem;
                            color: #3b82f6;
                            text-decoration: none;
                            font-weight: 600;
                            transition: color 0.15s ease;
                        }

                        .notif-footer a:hover {
                            color: #1d4ed8;
                        }

                        /* Responsive */
                        @media (max-width: 768px) {
                            .main-header {
                                padding: 0.75rem 1rem;
                                flex-wrap: wrap;
                                gap: 0.75rem;
                            }

                            .header-nav {
                                width: 100%;
                                justify-content: center;
                                flex-wrap: wrap;
                            }

                            .notification-dropdown {
                                width: 320px;
                                right: -1rem;
                            }

                            .user-name {
                                display: none;
                            }
                        }

                        @keyframes slideDown {
                            from {
                                opacity: 0;
                                transform: translateY(-10px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }

                        @keyframes pulse {

                            0%,
                            100% {
                                transform: scale(1);
                            }

                            50% {
                                transform: scale(1.1);
                            }
                        }
                    </style>

                    <div class="main-header">
                        <div class="header-brand">
                            <% if (roleId==-1) {%>
                                <a href="<%= request.getContextPath()%>/landing">
                                    <span class="brand-icon">📦</span> Laptop WMS
                                </a>
                                <% } else {%>
                                    <a href="<%= request.getContextPath()%>/dashboard">
                                        <span class="brand-icon">📦</span> Laptop WMS
                                    </a>
                                    <% } %>
                        </div>

                        <div class="header-nav">
                            <% if (currentUser !=null) {%>

                                <% if (roleId==1 || roleId==2) { %>
                                    <!-- Partners Dropdown -->
                                    <div class="nav-dropdown">
                                        <a class="nav-link nav-dropdown-trigger">
                                            <span>👥</span> Partners <span style="font-size: 0.625rem;">▼</span>
                                        </a>
                                        <div class="nav-dropdown-content">
                                            <a href="<%= request.getContextPath()%>/customer-list"
                                                class="nav-dropdown-item">
                                                <span class="item-icon">🛒</span> Customers
                                            </a>
                                            <a href="<%= request.getContextPath()%>/supplier-list"
                                                class="nav-dropdown-item">
                                                <span class="item-icon">🏭</span> Suppliers
                                            </a>
                                        </div>
                                    </div>

                                    <!-- Reports Dropdown -->
                                    <div class="nav-dropdown">
                                        <a class="nav-link nav-dropdown-trigger">
                                            <span>📊</span> Reports <span style="font-size: 0.625rem;">▼</span>
                                        </a>
                                        <div class="nav-dropdown-content">
                                            <a href="<%= request.getContextPath()%>/report-import"
                                                class="nav-dropdown-item">
                                                <span class="item-icon">📥</span> Import Report
                                            </a>
                                            <a href="<%= request.getContextPath()%>/report-export"
                                                class="nav-dropdown-item">
                                                <span class="item-icon">📤</span> Export Report
                                            </a>
                                            <a href="<%= request.getContextPath()%>/report-inventory"
                                                class="nav-dropdown-item">
                                                <span class="item-icon">📋</span> Inventory Report
                                            </a>
                                        </div>
                                    </div>
                                    <% } %>

                                        <% if (roleId==1) {%>
                                            <!-- Admin Dropdown -->
                                            <div class="nav-dropdown">
                                                <a class="nav-link nav-dropdown-trigger">
                                                    <span>⚙️</span> Admin <span style="font-size: 0.625rem;">▼</span>
                                                </a>
                                                <div class="nav-dropdown-content">
                                                    <a href="<%= request.getContextPath()%>/dashboard"
                                                        class="nav-dropdown-item">
                                                        <span class="item-icon">📈</span> Dashboard
                                                    </a>
                                                    <a href="<%= request.getContextPath()%>/user-list"
                                                        class="nav-dropdown-item">
                                                        <span class="item-icon">👤</span> Users
                                                    </a>
                                                    <a href="<%= request.getContextPath()%>/role"
                                                        class="nav-dropdown-item">
                                                        <span class="item-icon">🔐</span> Roles
                                                    </a>
                                                </div>
                                            </div>
                                            <% } %>

                                                <!-- Products Link -->
                                                <a href="<%= request.getContextPath()%>/product-list" class="nav-link">
                                                    <span>💻</span> Products
                                                </a>

                                                <% if (roleId==3) {%>
                                                    <a href="<%= request.getContextPath()%>/report-inventory"
                                                        class="nav-link">
                                                        <span>📋</span> Inventory
                                                    </a>
                                                    <a href="<%= request.getContextPath()%>/ticket-list"
                                                        class="nav-link">
                                                        <span>🎫</span> My Tickets
                                                    </a>
                                                    <% } else { %>
                                                        <a href="<%= request.getContextPath()%>/ticket-list"
                                                            class="nav-link">
                                                            <span>🎫</span> Tickets
                                                        </a>
                                                        <% } %>

                                                            <!-- Notification Bell -->
                                                            <div class="notification-wrapper">
                                                                <div class="notification-bell" id="notificationBell"
                                                                    onclick="toggleNotificationDropdown()">
                                                                    🔔
                                                                    <% if (notificationCount> 0) {%>
                                                                        <span class="notification-badge"
                                                                            id="notificationBadge">
                                                                            <%= notificationCount%>
                                                                        </span>
                                                                        <% }%>
                                                                </div>
                                                                <div class="notification-dropdown"
                                                                    id="notificationDropdown">
                                                                    <div class="notif-header">
                                                                        <h4>Notifications</h4>
                                                                        <a class="mark-all-btn"
                                                                            onclick="markAllAsRead()">Mark all read</a>
                                                                    </div>
                                                                    <div class="notif-list" id="notificationList">
                                                                        <div class="notif-empty">
                                                                            <div class="notif-empty-icon">🔔</div>
                                                                            <div>Loading...</div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="notif-footer">
                                                                        <a
                                                                            href="<%= request.getContextPath()%>/notifications">View
                                                                            All Notifications →</a>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!-- User Menu -->
                                                            <div class="nav-dropdown">
                                                                <div class="user-menu nav-dropdown-trigger">
                                                                    <div class="user-avatar">
                                                                        <%= currentUser.getFullName().substring(0,
                                                                            1).toUpperCase() %>
                                                                    </div>
                                                                    <span
                                                                        class="user-name">${currentUser.fullName}</span>
                                                                    <span
                                                                        style="font-size: 0.625rem; color: #94a3b8;">▼</span>
                                                                </div>
                                                                <div class="nav-dropdown-content user-dropdown">
                                                                    <a href="<%= request.getContextPath()%>/team-board"
                                                                        class="nav-dropdown-item">
                                                                        <span class="item-icon">📌</span> Team Board
                                                                    </a>
                                                                    <a href="<%= request.getContextPath()%>/profile"
                                                                        class="nav-dropdown-item">
                                                                        <span class="item-icon">👤</span> Profile
                                                                    </a>
                                                                    <div class="nav-dropdown-divider"></div>
                                                                    <a href="<%= request.getContextPath()%>/logout"
                                                                        class="nav-dropdown-item"
                                                                        style="color: #dc2626;">
                                                                        <span class="item-icon">🚪</span> Logout
                                                                    </a>
                                                                </div>
                                                            </div>

                                                            <% } else {%>
                                                                <a href="<%= request.getContextPath()%>/login"
                                                                    class="nav-link"
                                                                    style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 0.5rem 1.25rem;">
                                                                    Sign In
                                                                </a>
                                                                <% }%>
                        </div>
                    </div>

                    <% if (currentUser !=null) {%>
                        <script>
                            const contextPath = '<%= request.getContextPath()%>';

                            function toggleNotificationDropdown() {
                                const dropdown = document.getElementById('notificationDropdown');
                                dropdown.classList.toggle('show');
                                if (dropdown.classList.contains('show')) {
                                    loadNotifications();
                                }
                            }

                            // Close dropdown when clicking outside
                            document.addEventListener('click', function (event) {
                                const wrapper = document.querySelector('.notification-wrapper');
                                const dropdown = document.getElementById('notificationDropdown');
                                if (wrapper && dropdown && !wrapper.contains(event.target)) {
                                    dropdown.classList.remove('show');
                                }
                            });

                            function loadNotifications() {
                                fetch(contextPath + '/notifications?action=recent')
                                    .then(response => response.json())
                                    .then(notifications => {
                                        const list = document.getElementById('notificationList');
                                        if (notifications.length === 0) {
                                            list.innerHTML = '<div class="notif-empty"><div class="notif-empty-icon">📭</div><div>No notifications</div></div>';
                                            return;
                                        }

                                        list.innerHTML = notifications.map(n => {
                                            const iconClass = n.type === 'password_reset' ? 'password-reset' : '';
                                            const icon = n.type === 'password_reset' ? '🔑' : '📢';
                                            const unreadClass = !n.read ? 'unread' : '';
                                            const timeAgo = getTimeAgo(new Date(n.createdAt));
                                            const title = escapeHtml(n.title);
                                            const message = escapeHtml(n.message.substring(0, 100));
                                            const link = n.link || '';

                                            return '<div class="notif-item ' + unreadClass + '" onclick="handleNotificationClick(' + n.notificationId + ', \'' + escapeHtml(link) + '\')">' +
                                                '<div class="notif-icon ' + iconClass + '">' + icon + '</div>' +
                                                '<div class="notif-content">' +
                                                '<div class="notif-title">' + title + '</div>' +
                                                '<div class="notif-message">' + message + '...</div>' +
                                                '<div class="notif-time">' + timeAgo + '</div>' +
                                                '</div>' +
                                                '</div>';
                                        }).join('');
                                    })
                                    .catch(err => {
                                        console.error('Failed to load notifications:', err);
                                        document.getElementById('notificationList').innerHTML =
                                            '<div class="notif-empty"><div class="notif-empty-icon">⚠️</div><div>Failed to load</div></div>';
                                    });
                            }

                            function handleNotificationClick(notificationId, link) {
                                fetch(contextPath + '/notifications?action=markRead&id=' + notificationId, {
                                    method: 'POST'
                                })
                                    .then(response => response.json())
                                    .then(result => {
                                        if (link && link.length > 0) {
                                            window.location.href = contextPath + link;
                                        } else {
                                            loadNotifications();
                                            updateBadgeCount();
                                        }
                                    })
                                    .catch(err => {
                                        console.error('Failed to mark as read:', err);
                                        if (link && link.length > 0) {
                                            window.location.href = contextPath + link;
                                        }
                                    });
                            }

                            function markAsRead(notificationId) {
                                fetch(contextPath + '/notifications?action=markRead&id=' + notificationId, {
                                    method: 'POST'
                                })
                                    .then(response => response.json())
                                    .then(result => {
                                        if (result.success) {
                                            loadNotifications();
                                            updateBadgeCount();
                                        }
                                    })
                                    .catch(err => console.error('Failed to mark as read:', err));
                            }

                            function markAllAsRead() {
                                fetch(contextPath + '/notifications?action=markAllRead', {
                                    method: 'POST'
                                })
                                    .then(response => response.json())
                                    .then(result => {
                                        if (result.success) {
                                            loadNotifications();
                                            updateBadgeCount();
                                        }
                                    })
                                    .catch(err => console.error('Failed to mark all as read:', err));
                            }

                            function updateBadgeCount() {
                                fetch(contextPath + '/notifications?action=count')
                                    .then(response => response.json())
                                    .then(data => {
                                        const badge = document.getElementById('notificationBadge');
                                        const bell = document.getElementById('notificationBell');

                                        if (data.count > 0) {
                                            if (badge) {
                                                badge.textContent = data.count;
                                            } else {
                                                const newBadge = document.createElement('span');
                                                newBadge.className = 'notification-badge';
                                                newBadge.id = 'notificationBadge';
                                                newBadge.textContent = data.count;
                                                bell.appendChild(newBadge);
                                            }
                                        } else {
                                            if (badge) {
                                                badge.remove();
                                            }
                                        }
                                    })
                                    .catch(err => console.error('Failed to update badge:', err));
                            }

                            function getTimeAgo(date) {
                                const now = new Date();
                                const diff = Math.floor((now - date) / 1000);

                                if (diff < 60) return 'Just now';
                                if (diff < 3600) return Math.floor(diff / 60) + ' min ago';
                                if (diff < 86400) return Math.floor(diff / 3600) + ' hours ago';
                                if (diff < 604800) return Math.floor(diff / 86400) + ' days ago';
                                return date.toLocaleDateString();
                            }

                            function escapeHtml(text) {
                                const div = document.createElement('div');
                                div.textContent = text;
                                return div.innerHTML;
                            }

                            setInterval(updateBadgeCount, 30000);
                        </script>
                        <% }%>