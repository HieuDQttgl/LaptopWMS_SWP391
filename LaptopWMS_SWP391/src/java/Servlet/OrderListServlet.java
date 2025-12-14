package Servlet;

import DAO.OrderDAO;
import DAO.UserDAO;
import Model.Order;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "OrderListServlet", urlPatterns = {"/order-list"})
public class OrderListServlet extends HttpServlet {
    
    private final OrderDAO orderDAO = new OrderDAO();
    private final UserDAO userDAO = new UserDAO(); 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        String statusFilter = request.getParameter("statusFilter");
        String createdByParam = request.getParameter("createdByFilter");
        String startDateFilter = request.getParameter("startDateFilter");
        String endDateFilter = request.getParameter("endDateFilter");
        
        Integer createdByFilter = null;
        if (createdByParam != null && !createdByParam.isEmpty()) {
            try {
                createdByFilter = Integer.parseInt(createdByParam);
            } catch (NumberFormatException e) {
                System.err.println("Invalid createdBy parameter: " + createdByParam);
            }
        }
        
        List<Order> orders = orderDAO.getListOrders(
                keyword, 
                statusFilter, 
                createdByFilter, 
                startDateFilter, 
                endDateFilter
        );
        

        //List<String> allStatuses = orderDAO.getDistinctStatuses(); 
        //request.setAttribute("allStatuses", allStatuses);
        
        List<Users> orderCreators = userDAO.getListUsers(); 
        request.setAttribute("allCreators", orderCreators);
        
        request.setAttribute("orders", orders);
        request.setAttribute("keyword", keyword);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("createdByFilter", createdByParam);
        request.setAttribute("startDateFilter", startDateFilter);
        request.setAttribute("endDateFilter", endDateFilter);
        
        request.getRequestDispatcher("order-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}