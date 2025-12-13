<%-- Document : header Created on : Dec 11, 2025, 9:43:13 AM Author : Admin --%>

<%@page import="Model.Users" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<% Users currentUser = (Users) session.getAttribute("currentUser");
    int roleId = -1;
    if (currentUser != null) {
                    roleId = currentUser.getRoleId();
                }%>
<style>
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 20px 60px;
        border-bottom: 1px solid #eee;
    }

    .header-left a {
        font-size: 26px;
        font-weight: bold;
        text-decoration: none;
        color: #333;
    }

    .header-right a {
        margin: 0 20px;
        color: black;
        text-decoration: none;
        font-size: 16px;
    }
</style>
<div class="header">
    <div class="header-left"><a href="<%= request.getContextPath()%>/landing">@ WMS</a></div>

    <div class="header-right">
        <a href="#features">Features</a>
        <a href="#hero">About</a>
        <% if (currentUser != null) {%>
        <a href="<%= request.getContextPath()%>/profile">Profile</a>
        <a href="<%= request.getContextPath()%>/products">Products</a>
        <% if (roleId == 1) {%>
        <a href="<%= request.getContextPath()%>/user-list">User</a>
        <a href="<%= request.getContextPath()%>/role">Role</a>
        <% } %>
        <% if (roleId == 1 || roleId == 2) {%>
        <a href="<%= request.getContextPath()%>/supplier-list">Supplier</a>
        <% }%>
        <a href="<%= request.getContextPath()%>/logout">Logout</a>
        <% } else {%>
        <a href="<%= request.getContextPath()%>/login">Login</a>
        <a href="<%= request.getContextPath()%>/register">Register</a>
        <% }%>
    </div>
</div>