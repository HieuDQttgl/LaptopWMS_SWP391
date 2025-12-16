package Servlet;

import DAO.OrderDAO;
import DAO.OrderProductDAO;
import Model.Order;
import DTO.OrderProductDetailDTO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException; // Import thêm cho debug

@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/order-detail"})
public class OrderDetailServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private OrderProductDAO opDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        orderDAO = new OrderDAO();
        opDAO = new OrderProductDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        int orderId = -1;
        
        // 1. Kiểm tra tham số ID
        if (idParam == null || idParam.isEmpty()) {
             response.sendRedirect("order-list");
             return;
        }
        
        // 2. Chuyển đổi ID và xử lý NumberFormatException
        try {
            orderId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID đơn hàng không hợp lệ.");
            return;
        }

        try {
            // Lấy dữ liệu từ DAO
            Order order = orderDAO.getOrderById(orderId); 
            
            // 3. Xử lý Order không tồn tại
            if (order == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy Đơn hàng ID: " + orderId);
                return;
            }

            List<OrderProductDetailDTO> orderProducts = opDAO.getProductsDetailByOrderId(orderId);

            // Set Attributes và Forward
            request.setAttribute("order", order); 
            request.setAttribute("orderProducts", orderProducts); 
            
            request.getRequestDispatcher("order-detail.jsp").forward(request, response);

        }catch (Exception e) {
            System.err.println("❌ LỖI HỆ THỐNG xử lý đơn hàng ID " + orderId);
            System.err.println(">> Chi tiết lỗi: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi hệ thống xảy ra.");
        }
        
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}