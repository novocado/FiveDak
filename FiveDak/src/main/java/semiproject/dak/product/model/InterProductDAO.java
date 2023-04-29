package semiproject.dak.product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;



public interface InterProductDAO {
	
	// 총 페이지를 알아오는 메소드 
	int getTotalPage(Map<String, String> paraMap)  throws SQLException;

	// 검색을 하였을 때 검색리스트를 가져오는 메소드 
	List<ProductDTO> selectPagingProduct(Map<String, String> paraMap)  throws SQLException;

	// 검색을 하였을 때 검색에 해당하는 총 제품 갯수 알아오기  
	int getTotalProduct(Map<String, String> paraMap)   throws SQLException ;
	
	// Ajax(JSON)를 이용한 더보기 방식(페이징처리)으로 상품정보를 20개씩 잘라서(start ~ end) 조회해오기 
	List<ProductDTO> selectByRank(Map<String, String> paraMap)   throws SQLException ;
	
	// Ajax(JSON)를 사용하여 상품목록을 "더보기" 방식으로 페이징 처리 해주기위해 전체개수 알아오기 
	int totalCount();

	
	List<CartDTO> getCartList(String userid) throws SQLException;

	int updateProductQty(Map<String, String> paraMap) throws SQLException;

	int deleteUserCart(int[] cartIds) throws SQLException;

	CheckoutDTO getCheckOutData(int[] cartIds) throws SQLException;
	


}
