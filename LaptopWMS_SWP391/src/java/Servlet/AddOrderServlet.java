package Servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.math.BigDecimal;

import Model.Order;
import Model.OrderProduct;
import DAO.OrderDAO;
import DAO.CustomerDAO;
import DAO.SupplierDAO;
import DAO.ProductDAO;
import Model.Users;

@WebServlet(name = "AddOrderServlet", urlPatterns = {"/add-order"})
public class AddOrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();
    private final SupplierDAO supplierDAO = new SupplierDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            request.setAttribute("allCustomers", customerDAO.getListCustomers());
            request.setAttribute("allSuppliers", supplierDAO.getListSuppliers());
            request.setAttribute("allProducts", productDAO.getListProducts());
            
            request.removeAttribute("tempOrder");
            request.removeAttribute("tempDetails");
            
            request.getRequestDispatcher("add-order.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading data for form: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        Map<String, String> errors = new HashMap<>();

        String customerIdStr = request.getParameter("customerId");
        String supplierIdStr = request.getParameter("supplierId");
        String description = request.getParameter("description");

        Integer customerId = 0;
        Integer supplierId = 0;
        
        Users currentUser = (Users) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Integer createdBy = currentUser.getUserId();

        try {
            if (customerIdStr != null && !customerIdStr.trim().isEmpty() && !customerIdStr.trim().equals("0")) {
                customerId = Integer.valueOf(customerIdStr.trim());
            }
            if (supplierIdStr != null && !supplierIdStr.trim().isEmpty() && !supplierIdStr.trim().equals("0")) {
                supplierId = Integer.valueOf(supplierIdStr.trim());
            }
        } catch (NumberFormatException e) {
            errors.put("party", "ID đối tác không hợp lệ.");
        }

        Order newOrder = new Order();
        if (customerId > 0) {
            newOrder.setCustomerId(customerId);
            newOrder.setSupplierId(null); 
        } else if (supplierId > 0) {
            newOrder.setSupplierId(supplierId);
            newOrder.setCustomerId(null);
        } else {
            errors.put("party", "Vui lòng chọn Khách hàng hoặc Nhà cung cấp.");
            newOrder.setCustomerId(null);
            newOrder.setSupplierId(null);
        }
        
        newOrder.setDescription(description);
        newOrder.setOrderStatus("Pending");
        newOrder.setCreatedBy(createdBy);

        List<OrderProduct> details = new ArrayList<>();
        Map<Integer, String> errorProductNames = new HashMap<>();
        boolean hasDetailError = false;
        
        String[] productIds = request.getParameterValues("productId");
        String[] quantities = request.getParameterValues("quantity");
        String[] unitPrices = request.getParameterValues("unitPrice");
        String[] productNames = request.getParameterValues("productName");
        
        
        if (productIds != null && productIds.length > 0) {
            for (int i = 0; i < productIds.length; i++) {
                
                String productIdStr = (i < productIds.length) ? productIds[i] : null;
                String quantityStr = (i < quantities.length) ? quantities[i] : null;
                String unitPriceStr = (i < unitPrices.length) ? unitPrices[i] : null;
                String productName = (i < productNames.length) ? productNames[i] : null;

                if (productIdStr == null || productIdStr.trim().isEmpty() || productIdStr.trim().equals("0")) {
                     if (productName != null && !productName.trim().isEmpty()) {
                         errors.put("details_line_" + i, "Dòng " + (i + 1) + ": Sản phẩm chưa được chọn hợp lệ từ danh sách.");
                         errorProductNames.put(i, productName.trim());
                         hasDetailError = true;
                         
                         OrderProduct tempDetail = new OrderProduct();
                         try {
                             if (quantityStr != null && !quantityStr.trim().isEmpty()) tempDetail.setQuantity(Integer.parseInt(quantityStr.trim()));
                             if (unitPriceStr != null && !unitPriceStr.trim().isEmpty()) tempDetail.setUnitPrice(new BigDecimal(unitPriceStr.trim()));
                         } catch (Exception ex) { }
                         details.add(tempDetail);
                     }
                     continue;
                }
                
                try {
                    int productId = Integer.parseInt(productIdStr.trim());
                    int quantity = Integer.parseInt(quantityStr.trim());
                    BigDecimal unitPrice = new BigDecimal(unitPriceStr.trim());

                    if (productId <= 0) {
                        continue; 
                    }
                    
                    if (quantity <= 0) {
                        errors.put("details_line_" + i, "Dòng " + (i + 1) + ": Số lượng phải > 0.");
                        hasDetailError = true;
                    }
                    if (unitPrice.compareTo(BigDecimal.ZERO) < 0) {
                        errors.put("details_line_" + i, "Dòng " + (i + 1) + ": Đơn giá không hợp lệ.");
                        hasDetailError = true;
                    }
                    
                    OrderProduct detail = new OrderProduct();
                    detail.setProductId(productId);
                    detail.setQuantity(quantity);
                    detail.setUnitPrice(unitPrice);
                    
                    details.add(detail);
                    
                } catch (NumberFormatException e) {
                    errors.put("details_line_" + i, "Dòng " + (i + 1) + ": Số lượng hoặc Đơn giá không phải là số hợp lệ.");
                    hasDetailError = true;
                    
                    OrderProduct tempDetail = new OrderProduct();
                    try {
                        if (productIdStr != null && !productIdStr.trim().isEmpty() && !productIdStr.trim().equals("0")) tempDetail.setProductId(Integer.parseInt(productIdStr.trim()));
                        errorProductNames.put(i, productName != null ? productName.trim() : "");
                    } catch (Exception ex) { }
                    details.add(tempDetail);
                    
                } catch (Exception e) {
                    e.printStackTrace();
                    errors.put("details_line_" + i, "Dòng " + (i + 1) + ": Lỗi không xác định.");
                    hasDetailError = true;
                    
                    OrderProduct tempDetail = new OrderProduct();
                    try {
                         if (productIdStr != null && !productIdStr.trim().isEmpty() && !productIdStr.trim().equals("0")) tempDetail.setProductId(Integer.parseInt(productIdStr.trim()));
                    } catch (Exception ex) {}
                    details.add(tempDetail);
                }
            }
        }
        
        if (details.isEmpty() && !hasDetailError) {
             errors.put("details", "Đơn hàng phải có ít nhất 1 sản phẩm.");
        }
        
        List<OrderProduct> validDetails = new ArrayList<>();
        if (errors.isEmpty() && !hasDetailError) {
             for (OrderProduct detail : details) {
                 if (detail.getProductId() != null && detail.getProductId() > 0 && 
                     detail.getQuantity() != null && detail.getQuantity() > 0 && 
                     detail.getUnitPrice() != null && detail.getUnitPrice().compareTo(BigDecimal.ZERO) >= 0) {
                     validDetails.add(detail);
                 }
             }
        }
        
        if (!errors.isEmpty() || hasDetailError || validDetails.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("tempOrder", newOrder);
            
            request.setAttribute("tempDetails", details); 
            request.setAttribute("errorProductNames", errorProductNames);
            
            try {
                request.setAttribute("allCustomers", customerDAO.getListCustomers());
                request.setAttribute("allSuppliers", supplierDAO.getListSuppliers());
                request.setAttribute("allProducts", productDAO.getListProducts());
            } catch (Exception e) { 
                errors.put("general", "Lỗi tải lại dữ liệu danh mục.");
            }
            
            request.getRequestDispatcher("add-order.jsp").forward(request, response);
            
        } else {
            System.out.println("------------------------------------------");
            System.out.println("DEBUG: Valid Details Count before DAO: " + validDetails.size()); 
            System.out.println("------------------------------------------");
            try {
                boolean success = orderDAO.addOrder(newOrder, validDetails); 

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/order-list?success=true");
                } else {
                    errors.put("general", "System error: Cannot save order, please try again.");
                    request.setAttribute("errors", errors);
                    request.setAttribute("tempOrder", newOrder);
                    request.setAttribute("tempDetails", validDetails);
                    
                    request.setAttribute("allCustomers", customerDAO.getListCustomers());
                    request.setAttribute("allSuppliers", supplierDAO.getListSuppliers());
                    request.setAttribute("allProducts", productDAO.getListProducts());
                    
                    request.getRequestDispatcher("add-order.jsp").forward(request, response);
                }
            } catch (Exception e) {
                 e.printStackTrace();
                 errors.put("general", "Lỗi DB/Server nghiêm trọng: " + e.getMessage());
                 
                 request.setAttribute("errors", errors);
                 request.setAttribute("tempOrder", newOrder);
                 request.setAttribute("tempDetails", validDetails);

                 try {
                     request.setAttribute("allCustomers", customerDAO.getListCustomers());
                     request.setAttribute("allSuppliers", supplierDAO.getListSuppliers());
                     request.setAttribute("allProducts", productDAO.getListProducts());
                 } catch (Exception ex) { }
                 request.getRequestDispatcher("add-order.jsp").forward(request, response);
            }
        }
    }
}