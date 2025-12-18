<%-- Document : header Created on : Dec 11, 2025, 9:43:13 AM Author : Admin --%>

<%@page import="Model.Users" %>
<%@page import="DAO.NotificationDAO" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<% Users currentUser = (Users) session.getAttribute("currentUser");
    int roleId = -1;
    int notificationCount = 0;
    if (currentUser != null) {
        roleId = currentUser.getRoleId();
        NotificationDAO notificationDAO = new NotificationDAO();
                        notificationCount = notificationDAO.getUnreadCount(currentUser.getUserId());
                    }%>
<style>
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 20px 60px;
        border-bottom: 1px solid #eee;
        background: #fff;
    }

    .header-left a {
        font-size: 26px;
        font-weight: bold;
        text-decoration: none;
        color: #333;
    }

    .header-right {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .header-right a {
        margin: 0 12px;
        color: black;
        text-decoration: none;
        font-size: 16px;
    }

    .header-right a:hover {
        color: #2563eb;
    }

    /* Notification Bell Styles */
    .notification-wrapper {
        position: relative;
        display: inline-block;
    }

    .notification-bell {
        cursor: pointer;
        padding: 8px 12px;
        font-size: 18px;
        color: #555;
        transition: color 0.2s;
        position: relative;
    }

    .notification-bell:hover {
        color: #2563eb;
    }

    .notification-badge {
        position: absolute;
        top: 2px;
        right: 4px;
        background: #dc2626;
        color: white;
        font-size: 11px;
        font-weight: 600;
        padding: 2px 6px;
        border-radius: 10px;
        min-width: 18px;
        text-align: center;
        line-height: 1.2;
    }

    .notification-dropdown {
        display: none;
        position: absolute;
        top: 100%;
        right: 0;
        width: 360px;
        max-height: 420px;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
        z-index: 1000;
        overflow: hidden;
    }

    .notification-dropdown.show {
        display: block;
    }

    .notification-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 14px 16px;
        border-bottom: 1px solid #eee;
        background: #f8fafc;
    }

    .notification-header h4 {
        margin: 0;
        font-size: 15px;
        font-weight: 600;
        color: #1e293b;
    }

    .mark-all-read {
        font-size: 12px;
        color: #2563eb;
        cursor: pointer;
        text-decoration: none;
    }

    .mark-all-read:hover {
        text-decoration: underline;
    }

    .notification-list {
        max-height: 320px;
        overflow-y: auto;
    }

    .notification-item {
        display: flex;
        padding: 12px 16px;
        border-bottom: 1px solid #f1f5f9;
        cursor: pointer;
        transition: background 0.15s;
    }

    .notification-item:hover {
        background: #f8fafc;
    }

    .notification-item.unread {
        background: #eff6ff;
    }

    .notification-item.unread:hover {
        background: #dbeafe;
    }

    .notification-icon {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: #e0e7ff;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 12px;
        flex-shrink: 0;
        font-size: 16px;
    }

    .notification-icon.password-reset {
        background: #fef3c7;
        color: #d97706;
    }

    .notification-content {
        flex: 1;
        min-width: 0;
    }

    .notification-title {
        font-size: 13px;
        font-weight: 600;
        color: #1e293b;
        margin-bottom: 4px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .notification-message {
        font-size: 12px;
        color: #64748b;
        line-height: 1.4;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .notification-time {
        font-size: 11px;
        color: #94a3b8;
        margin-top: 4px;
    }

    .notification-empty {
        padding: 40px 20px;
        text-align: center;
        color: #94a3b8;
        font-size: 14px;
    }

    .notification-footer {
        padding: 12px 16px;
        text-align: center;
        border-top: 1px solid #eee;
        background: #f8fafc;
    }

    .notification-footer a {
        font-size: 13px;
        color: #2563eb;
        text-decoration: none;
        font-weight: 500;
    }

    .notification-footer a:hover {
        text-decoration: underline;
    }
</style>
<div class="header">
    <div class="header-left">
        <% if(roleId == -1) {%>
        <a href="<%= request.getContextPath()%>/landing">@ WMS</a>
        <% } else { %>
        <a href="<%= request.getContextPath()%>/dashboard">@ WMS</a>
        <% } %>
    </div>

    <div class="header-right">
        <a href="#features">Features</a>
        <a href="#hero">About</a>
        <% if (currentUser != null) {%>
        <a href="<%= request.getContextPath()%>/profile">Profile</a>
        <% if (roleId == 1) {%>
        <a href="<%= request.getContextPath()%>/user-list">Users</a>
        <a href="<%= request.getContextPath()%>/role">Roles</a>
        <% } %>
        <% if (roleId == 2) {%>
        <a href="<%= request.getContextPath()%>/product-list">Products</a>
        <a href="<%= request.getContextPath()%>/order-list">Orders</a>
        <a href="<%= request.getContextPath()%>/inventory">Inventory</a>
        <% }%>
        <% if (roleId == 3) {%>
        <a href="<%= request.getContextPath()%>/order-list">Orders</a>
        <a href="<%= request.getContextPath()%>/customer-list">Customers</a>
        <a href="<%= request.getContextPath()%>/supplier-list">Suppliers</a>
        <% }%>

        <!-- Notification Bell -->
        <div class="notification-wrapper">
            <div class="notification-bell" id="notificationBell"
                 onclick="toggleNotificationDropdown()">
                🔔
                <% if (notificationCount > 0) {%>
                <span class="notification-badge"
                      id="notificationBadge">
                    <%= notificationCount%>
                </span>
                <% }%>
            </div>
            <div class="notification-dropdown"
                 id="notificationDropdown">
                <div class="notification-header">
                    <h4>Notifications</h4>
                    <a class="mark-all-read"
                       onclick="markAllAsRead()">Mark all read</a>
                </div>
                <div class="notification-list" id="notificationList">
                    <div class="notification-empty">Loading...</div>
                </div>
                <div class="notification-footer">
                    <a
                        href="<%= request.getContextPath()%>/notifications">View
                        All Notifications</a>
                </div>
            </div>
        </div>

        <a href="<%= request.getContextPath()%>/logout">Logout</a>
        <% } else {%>
        <a href="<%= request.getContextPath()%>/login">Login</a>
        <% }%>
    </div>
</div>

<% if (currentUser != null) {%>
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
                                                list.innerHTML = '<div class="notification-empty">No notifications</div>';
                                                return;
                                            }

                                            list.innerHTML = notifications.map(n => {
                                                const iconClass = n.type === 'password_reset' ? 'password-reset' : '';
                                                const icon = n.type === 'password_reset' ? '🔑' : '📢';
                                                const unreadClass = !n.read ? 'unread' : '';
                                                const timeAgo = getTimeAgo(new Date(n.createdAt));
                                                const title = escapeHtml(n.title);
                                                const message = escapeHtml(n.message.substring(0, 100));

                                                return '<div class="notification-item ' + unreadClass + '" onclick="markAsRead(' + n.notificationId + ')">' +
                                                        '<div class="notification-icon ' + iconClass + '">' + icon + '</div>' +
                                                        '<div class="notification-content">' +
                                                        '<div class="notification-title">' + title + '</div>' +
                                                        '<div class="notification-message">' + message + '...</div>' +
                                                        '<div class="notification-time">' + timeAgo + '</div>' +
                                                        '</div>' +
                                                        '</div>';
                                            }).join('');
                                        })
                                        .catch(err => {
                                            console.error('Failed to load notifications:', err);
                                            document.getElementById('notificationList').innerHTML =
                                                    '<div class="notification-empty">Failed to load notifications</div>';
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

                                if (diff < 60)
                                    return 'Just now';
                                if (diff < 3600)
                                    return Math.floor(diff / 60) + ' min ago';
                                if (diff < 86400)
                                    return Math.floor(diff / 3600) + ' hours ago';
                                if (diff < 604800)
                                    return Math.floor(diff / 86400) + ' days ago';
                                return date.toLocaleDateString();
                            }

                            function escapeHtml(text) {
                                const div = document.createElement('div');
                                div.textContent = text;
                                return div.innerHTML;
                            }

                            // Refresh notification count every 30 seconds
                            setInterval(updateBadgeCount, 30000);
</script>
<% }%>
