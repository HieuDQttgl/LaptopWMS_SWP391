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
        request.setCharacterEncoding("UTF-8");
        
        String keyword = request.getParameter("keyword");
        String statusFilter = request.getParameter("statusFilter");
        String createdByParam = request.getParameter("createdByFilter");
        String startDateFilter = request.getParameter("startDateFilter");
        String endDateFilter = request.getParameter("endDateFilter");
        String orderTypeFilter = request.getParameter("orderTypeFilter");
        
        Integer createdByFilter = null;
        if (createdByParam != null && !createdByParam.isEmpty()) {
            try {
                createdByFilter = Integer.parseInt(createdByParam);
            } catch (NumberFormatException e) {
                System.err.println("Invalid createdBy parameter: " + createdByParam);
            }
        }
        
        String sortField = request.getParameter("sort_field");
        String sortOrder = request.getParameter("sort_order");
        
        if (sortField == null || sortField.isEmpty()) {
            sortField = "order_id";
        }
        if (sortOrder == null || sortOrder.isEmpty() || 
            (!"ASC".equalsIgnoreCase(sortOrder) && !"DESC".equalsIgnoreCase(sortOrder))) {
            sortOrder = "DESC";
        }
        
        int page = 1;
        int recordsPerPage = 3;
        
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        int offset = (page - 1) * recordsPerPage;
        
        int totalRecords = orderDAO.getTotalOrders(
                keyword, 
                statusFilter, 
                createdByFilter, 
                startDateFilter, 
                endDateFilter,
                orderTypeFilter
        );
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
        
        List<Order> orders = orderDAO.getListOrders(
                keyword, 
                statusFilter, 
                createdByFilter, 
                startDateFilter, 
                endDateFilter,
                orderTypeFilter,
                sortField,
                sortOrder,
                offset,
                recordsPerPage
        );
        
        List<Users> orderCreators = userDAO.getListUsers(); 
        request.setAttribute("allCreators", orderCreators);
        
        request.setAttribute("orders", orders);
        request.setAttribute("keyword", keyword);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("createdByFilter", createdByParam);
        request.setAttribute("startDateFilter", startDateFilter);
        request.setAttribute("endDateFilter", endDateFilter);
        request.setAttribute("orderTypeFilter", orderTypeFilter);
        request.setAttribute("sort_field", sortField);
        request.setAttribute("sort_order", sortOrder);
        
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("recordsPerPage", recordsPerPage);
        
        request.getRequestDispatcher("order-list.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}