<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:set var="ROLE_WAREHOUSE_KEEPER" value="2" scope="application"/>
<c:set var="ROLE_SALE" value="3" scope="application"/>

<!DOCTYPE html>
<html>
<head>
    <title>Update Order Status</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f7f6; }
        .container { max-width: 600px; margin: 0 auto; padding: 30px; border: 1px solid #ddd; border-radius: 8px; background-color: white; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        h2 { border-bottom: 3px solid #3498db; padding-bottom: 10px; color: #3498db; }
        .order-info p { margin: 10px 0; font-size: 16px; }
        form div { margin-top: 20px; }
        select, button { padding: 10px; border-radius: 4px; border: 1px solid #ccc; font-size: 16px; width: 100%; box-sizing: border-box; }
        button { background-color: #2ecc71; color: white; cursor: pointer; border: none; margin-top: 10px; }
        button:hover { background-color: #27ae60; }
        .back-link { display: inline-block; margin-top: 20px; color: #3498db; text-decoration: none; font-size: 14px; }
        .alert-deny { padding: 15px; border-radius: 4px; margin-top: 20px; }
        .alert-deny ul { margin-top: 5px; margin-bottom: 0; padding-left: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Update Order Status</h2>

        <c:set var="order" value="${requestScope.order}" /> 
        <c:set var="currentUser" value="${sessionScope.currentUser}" /> 
        
        <c:set var="orderStatusUpper" value="${fn:toUpperCase(order.orderStatus)}" /> 
        <c:set var="currentRoleId" value="${currentUser.roleId}" />
        <c:set var="isImport" value="${order.supplierId != null}" />
        
        <c:set var="allowTransition" value="false" />
        <c:set var="responsibleRole" value="N/A" />

        <div class="order-info">
            <p><strong>Order Code:</strong> ${order.orderCode}</p>
            <p><strong>Current Status:</strong> <span style="font-weight: bold; color: #f39c12;">${order.orderStatus}</span></p>
            <p><strong>Order Type:</strong> ${isImport ? 'Import' : 'Export'}</p>
        </div>

        <form action="order-status" method="post">
            <input type="hidden" name="orderId" value="${order.orderId}">
            
            <div>
                <label for="newStatus" style="display: block; font-weight: bold; margin-bottom: 5px;">Select New Status:</label>
                <select name="newStatus" id="newStatus" required>
                    <option value="" selected disabled>-- Select status --</option>
                    
                    <c:if test="${isImport}">
                        <c:if test="${orderStatusUpper == 'PENDING'}">
                            <c:set var="responsibleRole" value="Sale Staff (ID: ${ROLE_SALE})" />
                            <c:if test="${currentRoleId == ROLE_SALE}">
                                <option value="Approved">Approved</option>
                                <option value="Cancelled">Cancelled</option>
                                <c:set var="allowTransition" value="true" />
                            </c:if>
                        </c:if>
                        
                        <c:if test="${orderStatusUpper == 'APPROVED'}">
                            <c:set var="responsibleRole" value="Sale Staff (ID: ${ROLE_SALE})" />
                            <c:if test="${currentRoleId == ROLE_SALE}">
                                <option value="Shipping">Shipping</option>
                                <c:set var="allowTransition" value="true" />
                            </c:if>
                        </c:if>
                        
                        <c:if test="${orderStatusUpper == 'SHIPPING'}">
                            <c:set var="responsibleRole" value="Warehouse Keeper (ID: ${ROLE_WAREHOUSE_KEEPER})" />
                            <c:if test="${currentRoleId == ROLE_WAREHOUSE_KEEPER}">
                                <option value="Completed">Completed</option>
                                <c:set var="allowTransition" value="true" />
                            </c:if>
                        </c:if>
                    </c:if>

                    <c:if test="${!isImport}">
                        <c:if test="${orderStatusUpper == 'PENDING'}">
                            <c:set var="responsibleRole" value="Warehouse Keeper (ID: ${ROLE_WAREHOUSE_KEEPER})" />
                            <c:if test="${currentRoleId == ROLE_WAREHOUSE_KEEPER}">
                                <option value="Approved">Approved</option>
                                <option value="Cancelled">Cancelled</option>
                                <c:set var="allowTransition" value="true" />
                            </c:if>
                        </c:if>
                        
                        <c:if test="${orderStatusUpper == 'APPROVED'}">
                            <c:set var="responsibleRole" value="Warehouse Keeper (ID: ${ROLE_WAREHOUSE_KEEPER})" />
                            <c:if test="${currentRoleId == ROLE_WAREHOUSE_KEEPER}">
                                <option value="Shipping">Shipping</option>
                                <c:set var="allowTransition" value="true" />
                            </c:if>
                        </c:if>
                        
                        <c:if test="${orderStatusUpper == 'SHIPPING'}">
                            <c:set var="responsibleRole" value="Sale (ID: ${ROLE_SALE})" />
                            <c:if test="${currentRoleId == ROLE_SALE}">
                                <option value="Completed">Completed</option>
                                <c:set var="allowTransition" value="true" />
                            </c:if>
                        </c:if>
                    </c:if>
                    
                </select>
            </div>
            
            <c:if test="${allowTransition}">
                <div>
                    <button type="submit">Update Status</button>
                </div>
            </c:if>
        </form>
        
        <c:if test="${!allowTransition}">
            <c:choose>               
                <c:when test="${responsibleRole != 'N/A'}">
                    <div class="alert-deny" style="background-color: #fff3cd; color: #856404; border: 1px solid #ffeeba;">
                        ⚠️ Business Rule Violation:
                        <ul>
                            <li>Order **${order.orderCode}** is currently **${order.orderStatus}**.</li>
                            <li>The responsible role for the next transition is: **${responsibleRole}**.</li>
                            <li>You (**${currentUser.fullName}**) do not have the required role. Please contact the appropriate staff.</li>
                        </ul>
                    </div>
                </c:when>
                
                <c:otherwise>
                    <div class="alert-deny" style="background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;">
                        ❌ Business Error: No valid status transition step could be determined from **${order.orderStatus}** (Upper Status: ${orderStatusUpper}).
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
        
        <a href="order-list" class="back-link">&lt;&lt; Back to Order List</a>

    </div>
</body>
</html>