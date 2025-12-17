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
        <a href="<%= request.getContextPath()%>/logout">Logout</a>
        <% } else {%>
        <a href="<%= request.getContextPath()%>/login">Login</a>
        <% }%>
    </div>
</div>