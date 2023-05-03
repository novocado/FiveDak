package semiproject.dak.product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


public interface InterProductDAO {
	
	// 검색했을 경우에 총 페이지를 알아오는 메소드 
	int getTotalPage(Map<String, String> paraMap)  throws SQLException;
	
	// 검색을 하였을 때 검색리스트를 가져오는 메소드 
	List<ProductDTO> selectPagingProduct(Map<String, String> paraMap)  throws SQLException;

	// 검색을 하였을 때 검색에 해당하는 총 제품 갯수 알아오기  
	int getTotalProduct(Map<String, String> paraMap)   throws SQLException ;
	
	// Ajax(JSON)를 이용한 더보기 방식(페이징처리)으로 상품정보를 20개씩 잘라서(start ~ end) 조회해오기 
	List<ProductDTO> selectByRank(Map<String, String> paraMap)   throws SQLException ;
	
	// Ajax(JSON)를 사용하여 상품목록을 "더보기" 방식으로 페이징 처리 해주기위해 전체개수 알아오기 
	int totalCount()    throws SQLException ;

	
	List<CartDTO> getCartList(String userid) throws SQLException;

	int updateProductQty(Map<String, String> paraMap) throws SQLException;

	int deleteUserCart(int[] cartIds) throws SQLException;
	
	//////////////////////////////////////////////////////////////////////////////////////
	// ADMIN Page 에 제품 목록 가져오는 메소드 
	// 제품의 총 개수를 알아오는 메소드 
	Map<String,Integer> getTotalNum(Map<String, String> paraMap) throws SQLException ;
 
	// 제품 목록들 가져오는 메소드 
	List<ProductDTO> selAllProduct(Map<String, String> paraMap)  throws SQLException  ;

	// 제품 목록에서 해당 제품을 삭제하는 메소드 
	int deleteProd(String prodNum) throws SQLException ;

	// 특정 제품 번호에 해당하는 제품의 상세정보 가져오기 
	ProductDTO selectOneProduct(String prodNum) throws SQLException  ;

	// 카테고리 종류 모두 가져오는 메소드 
	List<CategoryDTO> getCategoryList() throws SQLException ;

	// 특정 prodNum에 해당하는 PDTO 가져오는 메소드
	ProductDTO prodInfo(Map<String, String> paraMap) throws SQLException;

	// 제품 상세 정보에서 보여줄 영양소 가져오기 
	NutritionDTO nutritionInfo(String prodNum) throws SQLException ;

	// 제품 상세 정보에서 보여줄 리뷰 리스트 가져오기 
	List<ReviewDTO> getReviewList(Map<String, String> paraMap) throws SQLException ;

	// 제품 상세 정보에서 리뷰 총 페이지 구해오기 
	int getTotalReviewPage(Map<String, String> paraMap)throws SQLException  ;

	OrderDTO ProductOrderDetail(Map<String, String> paraMap) throws SQLException;
	

	
	int addReview(Map<String, String> paraMap)  throws SQLException;

	
	

	///////////////////////////////////////////////////////////////////////////////////////
	
	//결제 위한 체크아웃 데이터
	CheckoutDTO getCheckOutData(int[] cartIds, HttpServletRequest request) throws SQLException;
	//최종 주문 완료시 테이블 insert 작업
	int insertOrderInfo(Map<String, Object> orderMap) throws SQLException;

	////////////////////////////////////////////////////////////////////////////////////////
	
	// 제품 상세 페이지에서 장바구니 담기시 CART 에 INSERT 또는 업데이트 시 
	int insertCartlist(Map<String, String> paraMap) throws SQLException ;
	
	List<OrderDetailDTO> getReviewable(Map<String, String> paraMap) throws SQLException;

	List<OrderDetailDTO> getReviewed(Map<String, String> paraMap) throws SQLException;

	int getTotalReviewable(String userid) throws SQLException;

	int getTotalReviewed(String userid) throws SQLException;
	
	int reviewDel(Map<String, String> paraMap) throws SQLException;

	// 제품 등록하는 메소드 
	int insertProduct(ProductDTO pdto) throws SQLException;

}
