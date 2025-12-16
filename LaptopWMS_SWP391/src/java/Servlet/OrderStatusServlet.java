package Servlet;

import DAO.OrderDAO;
import Model.Order;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "OrderStatusServlet", urlPatterns = {"/order-status"})
public class OrderStatusServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    
    private static final int ROLE_WAREHOUSE_KEEPER = 2;
    private static final int ROLE_SALE = 3;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String orderIdStr = request.getParameter("orderId");
        Users currentUser = (Users) request.getSession().getAttribute("currentUser");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (orderIdStr == null || orderIdStr.isEmpty()) {
            response.sendRedirect("order-list?error=missing_id");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);
            Order order = orderDAO.getOrderById(orderId); 
            
            if (order == null) {
                response.sendRedirect("order-list?error=order_not_found");
                return;
            }

            request.setAttribute("order", order); 
            request.setAttribute("ROLE_WAREHOUSE_KEEPER", ROLE_WAREHOUSE_KEEPER);
            request.setAttribute("ROLE_SALE_STAFF", ROLE_SALE);
            
            request.getRequestDispatcher("/order-status.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("order-list?error=invalid_id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("order-list?error=server_error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String orderIdStr = request.getParameter("orderId");
        String newStatus = request.getParameter("newStatus");
        
        Users currentUser = (Users) request.getSession().getAttribute("currentUser");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (orderIdStr == null || orderIdStr.trim().isEmpty() || newStatus == null || newStatus.trim().isEmpty()) {
            response.sendRedirect("order-list?error=missing_params");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr.trim());
            Order currentOrder = orderDAO.getOrderById(orderId);
            
            int userRoleId = currentUser.getRoleId();

            if (currentOrder == null) {
                response.sendRedirect("order-list?error=order_not_found");
                return;
            }
            
            String currentStatus = currentOrder.getOrderStatus();
            
            boolean isImport = currentOrder.getSupplierId() != null;
            String currentStatusUpper = currentStatus.toUpperCase();
            String newStatusUpper = newStatus.toUpperCase(); 

            boolean isAllowed = checkTransition(isImport, currentStatusUpper, newStatusUpper, userRoleId);

            if (isAllowed) {
                String orderCode = orderDAO.updateOrderStatus(orderId, newStatus); 

                if (orderCode != null) {
                    response.sendRedirect("order-list?success=status_updated&code=" + orderCode + "&newStatus=" + newStatus);
                } else {
                    response.sendRedirect("order-list?error=update_failed");
                }
            } else {
                response.sendRedirect("order-status?orderId=" + orderId + "&error=transition_denied");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("order-list?error=invalid_id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("order-list?error=db_error");
        }
    }
    
    private boolean checkTransition(boolean isImport, String currentStatusUpper, String newStatusUpper, int userRoleId) {
        
        if (currentStatusUpper.equals("COMPLETED") || currentStatusUpper.equals("CANCELLED")) {
             return false;
        }
        
        switch (newStatusUpper) {
            case "CANCELLED":
                if (currentStatusUpper.equals("PENDING") || currentStatusUpper.equals("APPROVED")) {
                    if (isImport && userRoleId == ROLE_SALE) return true;
                    if (!isImport && userRoleId == ROLE_WAREHOUSE_KEEPER) return true;
                }
                break;
                
            case "APPROVED":
                if (currentStatusUpper.equals("PENDING")) {
                    if (isImport && userRoleId == ROLE_SALE) return true;
                    if (!isImport && userRoleId == ROLE_WAREHOUSE_KEEPER) return true;
                }
                break;
                
            case "SHIPPING":
                if (currentStatusUpper.equals("APPROVED")) {
                    if (isImport && userRoleId == ROLE_SALE) return true;
                    if (!isImport && userRoleId == ROLE_WAREHOUSE_KEEPER) return true;
                }
                break;
                
            case "COMPLETED":
                if (currentStatusUpper.equals("SHIPPING")) {
                    if (isImport && userRoleId == ROLE_WAREHOUSE_KEEPER) return true;
                    if (!isImport && userRoleId == ROLE_SALE) return true;    
                }
                break;
        }
        
        return false;
    }
}