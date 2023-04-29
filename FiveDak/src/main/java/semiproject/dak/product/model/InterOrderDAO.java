package semiproject.dak.product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterOrderDAO {
	

	// 한달간 전체 주문 상품 수 알아오기 
	int getSumMonthOrder() throws SQLException ;

	// 한달간 미배송중인 주문 상품수 알아오기 
	int getSumNotShipped()  throws SQLException ;

	// 한달간 현재 누적 판매액 
	int getSumTotalSales()  throws SQLException ;

	// 최근 것부터 주문 내역 하나씩 보여주기 
	List<OrderDTO> showAllOrder(Map<String, String> paraMap) throws SQLException;

	// 
	int getTotalNo(Map<String,String> paraMap) throws SQLException ;

}
