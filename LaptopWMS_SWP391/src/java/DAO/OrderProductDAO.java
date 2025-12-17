package DAO;

import DTO.OrderProductDetailDTO;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderProductDAO {

    public List<OrderProductDetailDTO> getProductsDetailByOrderId(int orderId) {
        List<OrderProductDetailDTO> list = new ArrayList<>();

        String SQL = "SELECT "
                + "op.order_product_id, "
                + "op.product_detail_id, "
                + "p.product_name, "
                + "pd.ram, pd.storage, pd.cpu, pd.gpu, pd.screen, "
                + "op.quantity, "
                + "op.unit_price "
                + "FROM order_products op "
                + "JOIN product_details pd ON op.product_detail_id = pd.product_detail_id "
                + "JOIN products p ON pd.product_id = p.product_id "
                + "WHERE op.order_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(SQL)) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderProductDetailDTO dto = new OrderProductDetailDTO();

                    dto.setOrderProductId(rs.getInt("order_product_id"));
                    dto.setProductDetailId(rs.getInt("product_detail_id"));
                    dto.setProductName(rs.getString("product_name"));

                    dto.setRam(rs.getString("ram"));
                    dto.setStorage(rs.getString("storage"));
                    dto.setCpu(rs.getString("cpu"));
                    dto.setGpu(rs.getString("gpu"));
                    dto.setScreen(rs.getDouble("screen"));

                    dto.setQuantity(rs.getInt("quantity"));
                    dto.setUnitPrice(rs.getBigDecimal("unit_price"));

                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi truy vấn chi tiết sản phẩm đơn hàng: " + e.getMessage());
        } catch (Exception ex) {
            System.err.println("Lỗi kết nối DB: " + ex.getMessage());
        }
        return list;
    }
    
}
