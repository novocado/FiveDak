package semiproject.dak.product.model;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import semiproject.dak.security.AES256;
import semiproject.dak.security.SecretMyKey;

public class ProductDAO implements InterProductDAO {
	private DataSource ds; // DataSource == Apache Tomcat이 제공하는 DBCP
	private PreparedStatement pstmt;
	private Connection conn;
	private ResultSet rs;
	private AES256 aes;
	
	
	public ProductDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semi_oracle");
		    
		    aes = new AES256(SecretMyKey.KEY);
		} catch(NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}// end of public productDAO
	
	private void close() {
		try {
			if(pstmt != null) {
				pstmt.close();
				pstmt = null;
			
			}
			if(rs != null) {
				rs.close();
				rs = null;
			}
			if(conn != null) {
				conn.close();
				conn = null;
			}
			
			
		} catch(SQLException e) {
			e.printStackTrace();
		}	
	}// end of private void close 

	// 검색했을 경우에 총 페이지를 알아와서 돌려주는 메소드 
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException{
		int totalPage = 0 ;
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT ceil(count(*)/?) "+
					"        from tbl_product "+
					"        where PRODUCT_NAME like '%'|| ? || '%' " ;
			
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("sizePerPage") );
			pstmt.setString(2, paraMap.get("searchWord"));	
			rs = pstmt.executeQuery();
			
			rs.next();
			totalPage = rs.getInt(1);
			
		}finally {
			close();
		}
		
		return totalPage ;
	}

	// 검색을 하였을 때 검색리스트를 가져오는 메소드 
	@Override
	public List<ProductDTO> selectPagingProduct(Map<String, String> paraMap)  throws SQLException {
		List<ProductDTO> prodList = new ArrayList<>();
		try {
			conn = ds.getConnection();
			String sql = "";
				sql = " SELECT RNO, PRODUCT_ID, PRODUCT_NAME, PRODUCT_CATEGORY_ID , PRODUCT_PRICE, PRODUCT_DISCOUNT "+
						  " , AVERAGE_RATING, PRODUCT_IMAGE_URL , CATEGORY_NAME , BRAND_NAME "+
							" FROM "+
							" ( "+
							" select row_number() over (order by "+ paraMap.get("orderBy")+"  "+paraMap.get("orderWay") +" ) AS RNO  "+
							" , PRODUCT_ID, PRODUCT_NAME, PRODUCT_PRICE , PRODUCT_DISCOUNT, AVERAGE_RATING, PRODUCT_IMAGE_URL  "+
							" , PRODUCT_CATEGORY_ID , C.CATEGORY_NAME , B.BRAND_NAME  "+
							" from tbl_product P "+
							" JOIN tbl_category C  "+
							" ON P.PRODUCT_CATEGORY_ID = C.CATEGORY_ID "+
							" JOIN tbl_brand B  "+
							" ON P.PRODUCT_BRAND_ID = B.brand_id "+
							" WHERE P.PRODUCT_NAME like '%' || ? || '%'  or C.CATEGORY_NAME like '%' || ? || '%' or B.BRAND_NAME like '%' || ? || '%' "+
							" )V "+
							" WHERE RNO BETWEEN ?  AND ?  "
							+  "ORDER BY RNO ASC ";
				
			

			
			pstmt = conn.prepareStatement(sql);
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			
			// pstmt.setString(1, paraMap.get("orderBy"));
			pstmt.setString(1, paraMap.get("searchWord"));
			pstmt.setString(2, paraMap.get("searchWord"));
			pstmt.setString(3, paraMap.get("searchWord"));
			
			pstmt.setInt(4, (sizePerPage*currentShowPageNo)-(sizePerPage-1));
			pstmt.setInt(5, sizePerPage*currentShowPageNo);
			
			rs = pstmt.executeQuery();
			
			while ( rs.next()) {
				ProductDTO pdto = new ProductDTO();
				pdto.setProdNum(rs.getInt("PRODUCT_ID"));
				pdto.setProdName(rs.getString("PRODUCT_NAME"));
				pdto.setFk_prodCateNum(rs.getInt("PRODUCT_CATEGORY_ID"));
				pdto.setProdPrice(rs.getInt("PRODUCT_PRICE"));
				pdto.setProdDiscount(rs.getInt("PRODUCT_DISCOUNT"));
				pdto.setProdAvgRating(rs.getDouble("AVERAGE_RATING"));
				pdto.setProdImage1(rs.getString("PRODUCT_IMAGE_URL"));
				
				CategoryDTO cdto = new CategoryDTO();
				cdto.setCateName(rs.getString("CATEGORY_NAME"));
				pdto.setCateDTO(cdto);
				
				BrandDTO bdto = new BrandDTO();
				bdto.setBrandName(rs.getString("BRAND_NAME"));
				pdto.setBrandDTO(bdto);
				
				prodList.add(pdto);
				
			}// END OF WHILE( RS.NEXT()) {
			
			
			
		}finally {
			close();
		}
		
		return prodList;
	} // END OF PUBLIC LIST<PRODUCTDTO> SELECTPAGINGPRODUCT(MAP<STRING, STRING> PARAMAP)  THROWS SQLEXCEPTION {

	// 검색을 하였을 때 검색에 해당하는 총 제품 갯수 알아오기  
	@Override
	public int getTotalProduct(Map<String, String> paraMap)   throws SQLException {
		int totalProduct = 0 ;
		try {
			conn = ds.getConnection();
			String sql = " SELECT COUNT(*) "
					   + " FROM TBL_PRODUCT "
					   + " WHERE PRODUCT_NAME like '%' || ? || '%'  ";
				
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, paraMap.get("searchWord"));

			rs = pstmt.executeQuery();
			
			rs.next();
			totalProduct = rs.getInt(1);
			
		}finally {
			close();
		}
		return totalProduct;
	}
	
	
	
	// Ajax(JSON)를 이용한 더보기 방식(페이징처리)으로 상품정보를 20개씩 잘라서(start ~ end) 조회해오기
	@Override
	public List<ProductDTO> selectByRank(Map<String, String> paraMap) throws SQLException {
		
		List<ProductDTO> prodList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			 String sql = " select RNO, PRODUCT_ID, PRODUCT_NAME, PRODUCT_CATEGORY_ID , PRODUCT_PRICE, PRODUCT_SALES "
			 			+ "		 , AVERAGE_RATING, PRODUCT_IMAGE_URL , CATEGORY_NAME , BRAND_NAME , PRODUCT_DISCOUNT "
				 		+ " from "
				 		+ " ( "
				 		+ "     select row_number() over (order by "+paraMap.get("listType")+" DESC) AS RNO  "
				 		+ "          , PRODUCT_ID, PRODUCT_NAME, PRODUCT_PRICE , PRODUCT_SALES, AVERAGE_RATING, PRODUCT_IMAGE_URL "
				 		+ "			 , PRODUCT_CATEGORY_ID , C.CATEGORY_NAME , B.BRAND_NAME , PRODUCT_DISCOUNT"
				 		+ "    FROM tbl_product P "
				 		+ "    JOIN tbl_category C "
				 		+ "    ON P.product_category_id = C.category_id "
				 		+ "    JOIN tbl_brand B "
				 		+ "	   ON P.product_brand_id = B.brand_id"
				 		+ " ) V "
				 		+ " where RNO between ? and ? ";
			 
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("start"));
			pstmt.setString(2, paraMap.get("end"));
			
			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductDTO pvo = new ProductDTO();
				pvo.setProdRno(rs.getInt("RNO"));
				pvo.setProdNum(rs.getInt("PRODUCT_ID"));	
				pvo.setProdName(rs.getString("PRODUCT_NAME"));

				CategoryDTO categdto = new CategoryDTO();	
				categdto.setCateId(rs.getInt("PRODUCT_CATEGORY_ID")); 	
				categdto.setCateName(rs.getString("CATEGORY_NAME"));
				pvo.setCateDTO(categdto);				
				BrandDTO bdto = new BrandDTO();
				bdto.setBrandName(rs.getString("BRAND_NAME"));
				pvo.setBrandDTO(bdto);
				
	            pvo.setProdPrice(rs.getInt("PRODUCT_PRICE"));   		
	            pvo.setProdSales(rs.getInt("PRODUCT_SALES"));         
	            pvo.setProdDiscount(rs.getInt("PRODUCT_DISCOUNT"));        		
	            pvo.setProdAvgRating(rs.getDouble("AVERAGE_RATING"));	  		
	            pvo.setProdImage1(rs.getString("PRODUCT_IMAGE_URL"));
	            
	            
	            prodList.add(pvo);
			}// end of while ------------
			
		} finally {
			close();
		}
		
		return prodList;
	}
	
	
	// Ajax(JSON)를 사용하여 상품목록을 "더보기" 방식으로 페이징 처리 해주기위해 전체개수 알아오기 
	@Override
	public int totalCount() {
		
		int totalHITCount = 0;
		
		try {
			conn = ds.getConnection();
			
			 String sql = " select count(*) "
				 		+ " from "
				 		+ " ( "
				 		+ "     select row_number() over (order by AVERAGE_RATING DESC) AS RNO  "
				 		+ "          , PRODUCT_ID, PRODUCT_NAME, PRODUCT_PRICE , PRODUCT_SALES, AVERAGE_RATING, PRODUCT_IMAGE_URL "
				 		+ "			 , PRODUCT_CATEGORY_ID , C.CATEGORY_NAME , B.BRAND_NAME , PRODUCT_DISCOUNT"
				 		+ "    FROM tbl_product P "
				 		+ "    JOIN tbl_category C "
				 		+ "    ON P.product_category_id = C.category_id "
				 		+ "    JOIN tbl_brand B "
				 		+ "	   ON P.product_brand_id = B.brand_id"
				 		+ " ) V "
				 		+ " where RNO between 1 and 100 ";
			 
			pstmt = conn.prepareStatement(sql);
			
			
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalHITCount = rs.getInt(1);
		
		}
		 catch(SQLException e) {
			e.printStackTrace();
		}		
		 finally {
			close();
		}
		
		return totalHITCount;
	}
	
	
	

	@Override
	public List<CartDTO> getCartList(String userid) throws SQLException {
		List<CartDTO> cartlist = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			String sql = " SELECT CART_ID, CART_PRODUCT_ID, CART_QUANTITY, PRODUCT_NAME, BRAND_NAME, PRODUCT_PRICE, PRODUCT_STOCK, PRODUCT_DISCOUNT, PRODUCT_IMAGE_URL "
					+ " FROM TBL_CART C JOIN TBL_PRODUCT P ON C.CART_PRODUCT_ID = P.PRODUCT_ID"
					+ " JOIN TBL_BRAND B ON P.PRODUCT_BRAND_ID = B.BRAND_ID"
					+ " WHERE CART_MEMBER_ID = ? ";
				
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CartDTO cart = new CartDTO();
				cart.setCart_id(rs.getInt("CART_ID"));
				cart.setCart_product_id(rs.getInt("CART_PRODUCT_ID"));
				cart.setCart_quantity(rs.getInt("CART_QUANTITY"));
				
				ProductDTO prod = new ProductDTO();
				prod.setProdName(rs.getString("PRODUCT_NAME"));
				
				BrandDTO brand = new BrandDTO();
				brand.setBrandName(rs.getString("BRAND_NAME"));
				prod.setBrandDTO(brand);
				
				prod.setProdPrice(rs.getInt("PRODUCT_PRICE"));
				prod.setProdStock(rs.getInt("PRODUCT_STOCK"));
				prod.setProdDiscount(rs.getInt("PRODUCT_DISCOUNT"));
				prod.setProdImage1(rs.getString("PRODUCT_IMAGE_URL"));
				cart.setProd(prod);
				
				cartlist.add(cart);
			}
		}finally {
			close();
		}
		return cartlist;
	}

	
	
	
	@Override
	public int updateProductQty(Map<String, String> paraMap) throws SQLException {
		int n = 0; 
		
		try {
			conn = ds.getConnection();
			String sql = " UPDATE TBL_CART SET CART_QUANTITY = ? WHERE CART_ID = ? ";
				
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, Integer.parseInt(paraMap.get("nqty")));
			pstmt.setInt(2, Integer.parseInt(paraMap.get("cartid")));
			
			n = pstmt.executeUpdate();
			
			
		}finally {
			close();
		}
		return n;
	}

	
	@Override
	public int deleteUserCart(int[] cartIds) throws SQLException {
		int n = 0;

		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			
			String sql = "DELETE FROM TBL_CART WHERE CART_ID IN (" + String.join(",", Collections.nCopies(cartIds.length, "?")) + ")";
			pstmt = conn.prepareStatement(sql);
			
			for (int i = 0; i < cartIds.length; i++) {
		        pstmt.setInt(i + 1, cartIds[i]);
		    }

			
			n = pstmt.executeUpdate();
			if(n == cartIds.length) {
				conn.commit();
			} else {
				conn.rollback();
				n = 0;
			}
			
			
		}finally {
			conn.setAutoCommit(true);
			close();
			
			
		}
		return n;
		
		
	}

	private String generateOrderSerial() throws SQLException {
	    
	    String orderNo = null;
	    
	    try {
	    
	      conn = ds.getConnection();
	      
	    
	      pstmt = conn.prepareStatement("SELECT seq_order.NEXTVAL FROM DUAL");
	      rs = pstmt.executeQuery();
	      
	      
	      if (rs.next()) {
	        int seqNo = rs.getInt(1);
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	        String currentDate = sdf.format(new Date());
	        orderNo = "DAK" +currentDate + "-" + String.format("%08d", seqNo);
	      }
	      
	    } finally {
	      close();
	    }
	    
	    return orderNo;
	  }

	
	@Override
	public CheckoutDTO getCheckOutData(int[] cartIds, HttpServletRequest request) throws SQLException {
		List<CartDTO> cartlist = new ArrayList<>();
	    int totalPrice = 0, totalDiscount = 0, shippingCost = 0, pointsEarned = 0, totalAmount= 0;
	    CheckoutDTO checkout = null;
	    try {
			conn = ds.getConnection();
			
			String sql = "SELECT CART_ID, CART_PRODUCT_ID, CART_QUANTITY, PRODUCT_NAME, BRAND_NAME, PRODUCT_PRICE, PRODUCT_STOCK, PRODUCT_DISCOUNT, PRODUCT_IMAGE_URL "
					+ "FROM tbl_cart c JOIN tbl_product p ON c.cart_product_id = p.product_id "
					+ "JOIN tbl_brand b ON p.product_brand_id = b.brand_id "
					+ "WHERE CART_ID IN (" + String.join(",", Collections.nCopies(cartIds.length, "?")) + ")";
	
			pstmt = conn.prepareStatement(sql);
			
			for (int i = 0; i < cartIds.length; i++) {
			    pstmt.setInt(i + 1, cartIds[i]);
			    
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CartDTO cart = new CartDTO();
				cart.setCart_id(rs.getInt("CART_ID"));
				cart.setCart_product_id(rs.getInt("CART_PRODUCT_ID"));
				cart.setCart_quantity(rs.getInt("CART_QUANTITY"));
				
				ProductDTO prod = new ProductDTO();
				prod.setProdName(rs.getString("PRODUCT_NAME"));
				
				BrandDTO brand = new BrandDTO();
				brand.setBrandName(rs.getString("BRAND_NAME"));
				prod.setBrandDTO(brand);
				
				prod.setProdPrice(rs.getInt("PRODUCT_PRICE"));
				prod.setProdStock(rs.getInt("PRODUCT_STOCK"));
				prod.setProdDiscount(rs.getInt("PRODUCT_DISCOUNT"));
				prod.setProdImage1(rs.getString("PRODUCT_IMAGE_URL"));
				cart.setProd(prod);
				
				totalPrice += cart.getTotalProductPrice();
				totalDiscount += cart.getTotalDiscount();
				totalAmount += cart.getTotalAmount();
				pointsEarned += cart.getPointsEarned(request);
				
				cartlist.add(cart);
			}
			if(totalAmount < 30000) {
				shippingCost += 3000;
			}
			
			checkout = new CheckoutDTO(cartlist, totalPrice, totalDiscount, shippingCost, pointsEarned, totalAmount);
			
			
		}finally {
			close();
		}
		return checkout;
	}



	// 총 제품의 개수을 알아오는 메소드 
	@Override
	public Map<String,Integer> getTotalNum(Map<String, String> paraMap) throws SQLException {
		
		Map<String,Integer> map = new HashMap<>();
		
		try {
		    conn = ds.getConnection();
		      
		    String sql =  " select count ( * ) "
		    		    + " from tbl_product " ;
		      
		    pstmt = conn.prepareStatement(sql);
		    
		    rs = pstmt.executeQuery();
		    rs.next();
		    
		    map.put("totalProduct", rs.getInt(1));
		    
		    String colname = paraMap.get("searchType");
		    String searchWord = paraMap.get("searchWord");
		    
		    sql = " SELECT ceil(count(*)/ 10) "
		    		+ " FROM "
		    		+ " ( "
		    		+ "    SELECT row_number() over (order by PRODUCT_ID DESC) AS RNO  , PRODUCT_ID , PRODUCT_NAME , C.CATEGORY_NAME , B.BRAND_NAME"
		    		+ "    , PRODUCT_STOCK , PRODUCT_SALES , PRODUCT_DISCOUNT , AVERAGE_RATING , PRODUCT_IMAGE_URL "
		    		+ "    from tbl_product P "
		    		+ "    JOIN tbl_brand B "
		    		+ "    ON P.PRODUCT_BRAND_ID = B.BRAND_ID "
		    		+ "    JOIN tbl_category C "
		    		+ "    ON P.PRODUCT_CATEGORY_ID = C.CATEGORY_ID " ;
		    
		    if ( !"".equals(colname) &&  searchWord != null && !searchWord.trim().isEmpty() ) {
				sql += " WHERE "+colname+" like '%'|| ? || '%'  " ;
			} 		
		    		
		    	sql +=  " )V" ; 
		    
		    pstmt = conn.prepareStatement(sql);
		    
		    if ( !"".equals(colname)&& searchWord != null && !searchWord.trim().isEmpty() ) {
				pstmt.setString(1, searchWord);
			}
		    
		    rs = pstmt.executeQuery();
		    rs.next();
		    map.put("totalPage", rs.getInt(1));
		    	
					
		    } finally {
		      close();
		    }
		
		
		return map ;
	} // END OF PUBLIC INT GETTOTALPRODUCT() THROWS SQLEXCEPTION {

	@Override
	public List<ProductDTO> selAllProduct(Map<String, String> paraMap) throws SQLException {
		List<ProductDTO> list = new ArrayList<>() ;
		
		try {
		    String colname = paraMap.get("searchType");
		    String searchWord = paraMap.get("searchWord");
			conn = ds.getConnection();
		      
		    String sql =  " SELECT RNO , PRODUCT_ID , PRODUCT_NAME , CATEGORY_NAME , BRAND_NAME "
		    		+ "    , PRODUCT_STOCK , PRODUCT_SALES , PRODUCT_DISCOUNT , AVERAGE_RATING , PRODUCT_IMAGE_URL "
		    		+ " FROM "
		    		+ " ( "
		    		+ "    SELECT row_number() over (order by PRODUCT_ID DESC) AS RNO  , PRODUCT_ID , PRODUCT_NAME , C.CATEGORY_NAME , B.BRAND_NAME "
		    		+ "    , PRODUCT_STOCK , PRODUCT_SALES , PRODUCT_DISCOUNT , AVERAGE_RATING , PRODUCT_IMAGE_URL "
		    		+ "    from tbl_product P "
		    		+ "    JOIN tbl_brand B "
		    		+ "    ON P.PRODUCT_BRAND_ID = B.BRAND_ID "
		    		+ "    JOIN tbl_category C "
		    		+ "    ON P.PRODUCT_CATEGORY_ID = C.CATEGORY_ID " ;
		    		
		    if ( !"".equals(colname) &&  searchWord != null && !searchWord.trim().isEmpty() ) {
				sql += " WHERE "+colname+" like '%'|| ? || '%'  " ;
			}
		    	sql +=   " )V "
			    	   + " WHERE RNO BETWEEN ? AND ?  " ;
	    		
		      
		    pstmt = conn.prepareStatement(sql);
		    int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
		    
		    if ( !"".equals(colname)&& searchWord != null && !searchWord.trim().isEmpty() ) {
				pstmt.setString(1, searchWord);
				//pstmt.setInt(2, ( 조회하고자하는 페이지번호 * 한페이지당 보여줄 행의 개수 ) - (한페이지당 보여줄 행의 개수-1 ));
				//pstmt.setInt(3, ( 조회하고자하는 페이지번호 * 한페이지당 보여줄 행의 개수 ));
				pstmt.setInt(2, (10*currentShowPageNo)-(10-1));
				pstmt.setInt(3, 10*currentShowPageNo);
			}
		    
		    else {
				 pstmt.setInt(1, (10*currentShowPageNo)-(10-1));
				 pstmt.setInt(2, 10*currentShowPageNo);	
			}
		    
		    rs = pstmt.executeQuery();
		    
		    while(rs.next()) {
		    	ProductDTO pdto = new ProductDTO() ;
		    	pdto.setProdNum(rs.getInt("PRODUCT_ID"));
		    	pdto.setProdName(rs.getString("PRODUCT_NAME"));
		    	
		    	CategoryDTO catedto = new CategoryDTO();
		    	catedto.setCateName(rs.getString("CATEGORY_NAME"));
		    	pdto.setCateDTO(catedto);
		    	
		    	BrandDTO bdto = new BrandDTO() ;
		    	bdto.setBrandName(rs.getString("BRAND_NAME"));
		    	pdto.setBrandDTO(bdto);
		    	
		    	pdto.setProdStock(rs.getInt("PRODUCT_STOCK"));
		    	pdto.setProdSales(rs.getInt("PRODUCT_SALES"));
		    	pdto.setProdDiscount(rs.getInt("PRODUCT_DISCOUNT"));
		    	pdto.setProdAvgRating(rs.getDouble("AVERAGE_RATING"));
		    	pdto.setProdImage1(rs.getString("PRODUCT_IMAGE_URL"));
		    	
		    	list.add(pdto);
		    }
		    	
					
		    } finally {
		      close();
		    }
		
		return list ;
	}

	// 제품 목록에서 해당 제품을 삭제하는 메소드 
	@Override
	public int deleteProd(String prodNum) throws SQLException {
		int n = 0  ;
		try {
			conn = ds.getConnection();
			
			String sql = " DELETE FROM TBL_PRODUCT WHERE PRODUCT_ID = ? ";
					
			pstmt = conn.prepareStatement(sql);
	
			pstmt.setString(1, prodNum);
				
			n = pstmt.executeUpdate();
			
		}finally {
			close();
		}
		
		
		return n;
	}
	
	
	// 특정 제품 번호에 해당하는 제품의 상세정보 가져오기 
	@Override
	public ProductDTO selectOneProduct(String prodNum) throws SQLException {
	
		
		return null;
	}

	


	@Override
	public List<CategoryDTO> getCategoryList() throws SQLException {
		List<CategoryDTO> cdtolist = new ArrayList<>();
		try {
			conn = ds.getConnection();
			String sql = " select category_id , category_name from tbl_category ";
					
			pstmt = conn.prepareStatement(sql);
	
			rs = pstmt.executeQuery();
			
			while ( rs.next()) {
				CategoryDTO cdto = new CategoryDTO() ;
				cdto.setCateId(rs.getInt("category_id"));
				cdto.setCateName(rs.getString("category_name"));
				
				cdtolist.add(cdto);
			}
			
		}finally {
			close();
		}
		
	
	
		return cdtolist ; 
	}

	//  특정 prodNum에 해당하는 PDTO 가져오는 메소드
	@Override
	public ProductDTO prodInfo(Map<String, String> paraMap) throws SQLException {
		ProductDTO pdto = null ;
		try {
			conn = ds.getConnection();
			String sql=" select product_id, product_name, brand_name, product_price, product_stock, product_sales, product_discount, average_rating, product_image_url, review_count "
					 + " from (select product_id, product_name,brand_name, product_price, product_stock, product_sales, product_discount, average_rating, product_image_url "
					 + " from tbl_product P join tbl_brand B on P.product_brand_id = B.brand_id where product_id = ? ) A CROSS JOIN "
					 + " (select count(*) as review_count from tbl_review where review_product_id = ? ) C ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("prodNum"));
			pstmt.setString(2, paraMap.get("prodNum"));
			
			rs = pstmt.executeQuery();
		
			if(rs.next()) {
				
				pdto = new ProductDTO();
				pdto.setProdNum(rs.getInt("PRODUCT_ID"));
				pdto.setProdName(rs.getString("PRODUCT_NAME"));
				pdto.setProdPrice(rs.getInt("PRODUCT_PRICE"));
				pdto.setProdStock(rs.getInt("PRODUCT_STOCK"));
				pdto.setProdSales(rs.getInt("PRODUCT_SALES"));
				pdto.setProdDiscount(rs.getInt("PRODUCT_DISCOUNT"));
				pdto.setProdAvgRating(rs.getDouble("AVERAGE_RATING"));
				pdto.setProdImage1(rs.getString("PRODUCT_IMAGE_URL"));
				
				ReviewDTO rdto = new ReviewDTO();
				rdto.setReview_cnt(rs.getInt("REVIEW_COUNT"));
				pdto.setReviewDTO(rdto);
				
				BrandDTO bdto = new BrandDTO();
				bdto.setBrandName(rs.getString("BRAND_NAME"));
				pdto.setBrandDTO(bdto);
			
				
			}	
		
		}finally {
			close();
		}
		return pdto;
		
	}

	@Override
	public NutritionDTO nutritionInfo(String prodNum) throws SQLException {
		NutritionDTO ndto = null ;
		try {
			
			conn = ds.getConnection(); 
			
			String sql=" select nutrition_id,product_cal, product_protein, product_sodium, product_kal, product_fat, product_transfat, product_satfat, product_col, product_sug "
					 + " from tbl_product P join tbl_product_nutrition N on P.product_id = N.nutrition_id "
					 + " where P.PRODUCT_ID = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1,prodNum );
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				
				ndto = new NutritionDTO();
				ndto.setProduct_cal(rs.getDouble("PRODUCT_CAL"));
				ndto.setProduct_protein(rs.getDouble("PRODUCT_PROTEIN"));
				ndto.setProduct_sodium(rs.getInt("PRODUCT_SODIUM"));
				ndto.setProduct_kal(rs.getInt("PRODUCT_KAL"));
				ndto.setProduct_fat(rs.getInt("PRODUCT_FAT"));
				ndto.setProduct_transfat(rs.getInt("PRODUCT_TRANSFAT"));
				ndto.setProduct_satfat(rs.getInt("PRODUCT_SATFAT"));
				ndto.setProduct_col(rs.getInt("PRODUCT_COL"));
				ndto.setProduct_sug(rs.getInt("PRODUCT_SUG"));
				
			}
			
		}finally {
			close();
		}
	
		return ndto ;
	}

	// 제품 상세 정보에서 보여줄 리뷰 리스트 가져오기 
	@Override
	public List<ReviewDTO> getReviewList(Map<String, String> paraMap) throws SQLException {
		List<ReviewDTO> arraylist = new ArrayList<>();
		try {
			conn = ds.getConnection(); 
			
			String sql = " SELECT RNO, review_id, review_member_id, review_product_id , review_score, review_content , review_date "
					+ " FROM "
					+ " ( "
					+ " select row_number() over (order by review_date DESC) AS RNO   "
					+ " , review_id, review_member_id, review_product_id , review_score, review_content  "
					+ " , review_date "
					+ " from tbl_review "
					+ " where review_product_id = ? "
					+ " )V "
					+ " WHERE RNO BETWEEN ? AND ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			int pageNum = Integer.parseInt(paraMap.get("pageNum"));
			
			pstmt.setString(1, paraMap.get("prodNum"));
			pstmt.setInt(2, (5*pageNum)-(5-1));
			pstmt.setInt(3,  5* pageNum);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO rdto = new ReviewDTO();
				rdto.setReview_id(rs.getInt("review_id"));
				rdto.setReview_member_id(rs.getString("review_member_id"));
				rdto.setReview_product_id(rs.getInt("review_product_id"));
				rdto.setReview_score(rs.getDouble("review_score"));
				rdto.setReview_content(rs.getString("review_content"));
				rdto.setReview_date(rs.getDate("review_date"));
				
				arraylist.add(rdto);
			}
			
		}finally {
			close();
		}
		
		return arraylist ;
	}

	// 제품 상세 정보에서 리뷰 총 페이지 구해오기 
	@Override
	public int getTotalReviewPage(Map<String, String> paraMap) throws SQLException {
		int totalPage = 0 ;
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT ceil(count(*)/ 5 ) "+
					"        from tbl_review "+
					"        where review_product_id = 24 " ;
			
			
			pstmt = conn.prepareStatement(sql);
			
			// pstmt.setString(1, paraMap.get("prodNum") );
			
			rs = pstmt.executeQuery();
			
			rs.next();
			totalPage = rs.getInt(1);
			
		}finally {
			close();
		}
		
		return totalPage ;
	}
	
	

	
	@Override
	public int insertOrderInfo(Map<String, Object> orderMap) throws SQLException {
		
		int n = 0;
		String orderSerial = generateOrderSerial();
		orderMap.put("orderSerial", orderSerial);
		try {
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			insertOrderAndDetail(orderMap);
			updatePointsAndHistory(orderMap);
			updateMemberPurchaseAmountAndTier(orderMap);
			updateProductSalesAndDeleteCart(orderMap);
			
			n = 1;
			conn.commit();

			
			
		} catch(SQLException e) {
			conn.rollback();
			e.printStackTrace();
		} finally {
			conn.setAutoCommit(true);
			close();
			
		}
		return n;
		
	}
	
	
	
	
	// 멤버 구매 총액 추가하고 멤버 티어 변경하는 메소드
	public void updateMemberPurchaseAmountAndTier(Map<String, Object> orderMap) throws SQLException {
	    
	    String memberId = ((OrderDTO)orderMap.get("orderinfo")).getFk_orderMbrId();
		int purchaseAmount = ((OrderDTO)orderMap.get("orderinfo")).getOrderTotalPrice();
		
	    try {
	        conn = ds.getConnection();
	        conn.setAutoCommit(false);
	        
	        // 멤버 구매 총액 업데이트
	        pstmt = conn.prepareStatement("UPDATE tbl_member SET member_purchase_amount = member_purchase_amount + ? WHERE member_id = ?");
	        pstmt.setInt(1, purchaseAmount);
	        pstmt.setString(2, memberId);
	        int rowsUpdated = pstmt.executeUpdate();
	        
	        if (rowsUpdated != 1) {
	            throw new SQLException("멤버 구매 총액 업데이트 실패");
	        }
	        
	        // 추가된 구매 총액 바탕으로 해당하는 tier 확인
	        pstmt = conn.prepareStatement("SELECT tier_id FROM membership_tier WHERE amount_needed <= (SELECT member_purchase_amount FROM tbl_member WHERE member_id = ?) ORDER BY amount_needed DESC FETCH FIRST 1 ROWS ONLY");
	        pstmt.setString(1, memberId);
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	            int newTierId = rs.getInt("tier_id");
	            
	            // 멤버의 현재 tier_id 확인
	            pstmt = conn.prepareStatement("SELECT member_tier_id FROM tbl_member WHERE member_id = ?");
	            pstmt.setString(1, memberId);
	            rs = pstmt.executeQuery();
	            
	            if (rs.next()) {
	                int oldTierId = rs.getInt("member_tier_id");
	                
	                if (oldTierId != newTierId) {
	                    // 멤버 티어 변경이 필요하다면 업데이트
	                    pstmt = conn.prepareStatement("UPDATE tbl_member SET member_tier_id = ? WHERE member_id = ?");
	                    pstmt.setInt(1, newTierId);
	                    pstmt.setString(2, memberId);
	                    rowsUpdated = pstmt.executeUpdate();
	                    
	                    if (rowsUpdated != 1) {
	                        throw new SQLException("멤버 티어 업데이트 실패");
	                    }
	                }
	            } else {
	                throw new SQLException("멤버 현재 TIER 조회 실패");
	            }
	        } else {
	            throw new SQLException("멤버의 변경된 금액 바탕으로 바뀔 Tier 조회 실패");
	        }
	        
	        conn.commit();
	    } catch (SQLException e) {
	        if (conn != null) {
	            conn.rollback();
	        }
	        throw e;
	    }
	}
	
	
	
	// 구매로 인한 테이블 변동 반영
	public void updatePointsAndHistory(Map<String, Object> orderMap) throws SQLException {
	    
		String orderSerial = (String)orderMap.get("orderSerial");
		
		String memberId = ((OrderDTO)orderMap.get("orderinfo")).getFk_orderMbrId();
		int usePoint = ((OrderDTO)orderMap.get("orderinfo")).getOrderPoint();
		int earnedPoint = ((CheckoutDTO)orderMap.get("checkout")).getPointsEarned();
		
		try {
	        
	        // 멤버 테이블의 포인트 변경 + 변동전 포인트 받아오기
	        int currentPoints = 0;
	        pstmt = conn.prepareStatement("SELECT member_point FROM tbl_member WHERE member_id = ?");
	        pstmt.setString(1, memberId);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            currentPoints = rs.getInt("member_point");
	        }
	        int newPoints = currentPoints + earnedPoint - usePoint;
	        pstmt = conn.prepareStatement("UPDATE tbl_member SET member_point = ? WHERE member_id = ?");
	        pstmt.setInt(1, newPoints);
	        pstmt.setString(2, memberId);
	        pstmt.executeUpdate();
	        
	        // 히스토리 테이블에 insert 사용 획득포인트가 발생한 경우만
	        if (usePoint > 0) {
	            pstmt = conn.prepareStatement("INSERT INTO MEMBER_POINT_HISTORY (point_member_id, point_before, point_change, point_after, point_reason, point_change_type) VALUES (?, ?, ?, ?, ?, 0)");
	            pstmt.setString(1, memberId);
	            pstmt.setInt(2, currentPoints);
	            pstmt.setInt(3, usePoint);
	            pstmt.setInt(4, currentPoints - usePoint);
	            pstmt.setString(5, orderSerial + " | 구매시 사용으로 인한 차감");
	            pstmt.executeUpdate();
	        }
	        if (earnedPoint > 0) {
	            pstmt = conn.prepareStatement("INSERT INTO MEMBER_POINT_HISTORY (point_member_id, point_before, point_change, point_after, point_reason, point_change_type) VALUES (?, ?, ?, ?, ?, 1)");
	            pstmt.setString(1, memberId);
	            pstmt.setInt(2, newPoints - earnedPoint);
	            pstmt.setInt(3, earnedPoint);
	            pstmt.setInt(4, newPoints);
	            pstmt.setString(5, orderSerial + " | 구매로 인한 적립");
	            pstmt.executeUpdate();
	        }
	        
	        conn.commit();
	    } catch (SQLException e) {
	        if (conn != null) {
	            conn.rollback();
	        }
	        throw e;
	    }
	}
	
	
	
	public void updateProductSalesAndDeleteCart(Map<String, Object> orderMap) throws SQLException {

	    try {
	        // 맵에서 cartDTOList받아오기
	        List<CartDTO> cartDtoList = ((CheckoutDTO) orderMap.get("checkout")).getCartDtoList();


	        // for문으로 cartDtoList에 있는 데이터 바탕으로 테이블 변경, 삭제하기
	        for (CartDTO cartDTO : cartDtoList) {
	            int productId = cartDTO.getCart_product_id();
	            int quantity = cartDTO.getCart_quantity();

	            // 제품 재고, 판매량 변경
	            String sqlUpdate = "UPDATE tbl_product SET product_stock = product_stock - ?, product_sales = product_sales + ? WHERE product_id = ?";
	            pstmt = conn.prepareStatement(sqlUpdate);
	            pstmt.setInt(1, quantity);
	            pstmt.setInt(2, quantity);
	            pstmt.setInt(3, productId);
	            pstmt.executeUpdate();

	            // 모든 처리가 끝난 cart 테이블에서 삭제.
	            String sqlDelete = "DELETE FROM tbl_cart WHERE cart_id = ?";
	            pstmt = conn.prepareStatement(sqlDelete);
	            pstmt.setInt(1, cartDTO.getCart_id());
	            pstmt.executeUpdate();
	        }

	    } catch (SQLException e) {
	    	if (conn != null) {
	            conn.rollback();
	        }
	        throw e;
	    }
	}
	
	
	public void insertOrderAndDetail(Map<String, Object> orderMap) throws SQLException {

	    try {
	        // 맵에서 cartDTOList받아오기
	        List<CartDTO> cartDtoList = ((CheckoutDTO) orderMap.get("checkout")).getCartDtoList();
	        OrderDTO orderinfo = (OrderDTO)orderMap.get("orderinfo");
	        String orderSerial = (String)orderMap.get("orderSerial");
	        String sql = "";
	        
	        sql = "insert into tbl_order(ORDER_SERIAL,ORDER_MEMBER_ID, ORDER_TOTAL_PRICE, ORDER_POINT, RECIPIENT_NAME, SHIPPING_POSTCODE, SHIPPING_ADDRESS, SHIPPING_DETAIL_ADDRESS,RECIPIENT_MOBILE, ORDER_MESSAGE, ORDER_STATUS)"
	        		+ "VALUES(? , ? , ? , ? , ? , ?, ?, ?, ? , ? , 1)";
	        pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, orderSerial);
            pstmt.setString(2, orderinfo.getFk_orderMbrId());
            pstmt.setInt(3, orderinfo.getOrderTotalPrice());
            pstmt.setInt(4, orderinfo.getOrderPoint());
            pstmt.setString(5, orderinfo.getRecipName());
            pstmt.setString(6, orderinfo.getOrderPostcode());
            pstmt.setString(7, orderinfo.getOrderAddress());
            pstmt.setString(8, orderinfo.getOrderDetailAddress());
            pstmt.setString(9, orderinfo.getRecipMobile());
            pstmt.setString(10, orderinfo.getOrderMessage());
            pstmt.executeUpdate();
	        
	        // for문으로 cartDtoList에 있는 데이터 바탕으로 order_detail 테이블에 insert하기
	        for (CartDTO cartDTO : cartDtoList) {
	            
	        	int productId = cartDTO.getCart_product_id();
	            int quantity = cartDTO.getCart_quantity();
	            int pricePerUnit = cartDTO.getProd().getProdDiscount();
	            

	            // 제품 재고, 판매량 변경
	            sql = "INSERT INTO TBL_ORDER_DETAIL(FK_ORDER_SERIAL, ORDER_DETAIL_PRODUCT_ID , ORDER_QUANTITY, PRICE_PER_UNIT, REVIEW_STATUS)"
	            		+ "VALUES(? , ? , ? , ?, 0)";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, orderSerial);
	            pstmt.setInt(2, productId);
	            pstmt.setInt(3, quantity);
	            pstmt.setInt(4, pricePerUnit);
	            pstmt.executeUpdate();
	        }

	    } catch (SQLException e) {
	    	if (conn != null) {
	            conn.rollback();
	        }
	        throw e;
	    }
	}

	// 제품 상세 페이지에서 장바구니 담기시 CART 에 INSERT 또는 업데이트 시 
	@Override
	public int insertCartlist(Map<String, String> paraMap) throws SQLException {
		int n1 = 0 , n2 = 0 ;
		int cartId = 0;
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT COUNT(*) FROM TBL_CART  "
					+ " WHERE CART_PRODUCT_ID = ? AND CART_MEMBER_ID = ? " ;
	
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("prodNum") );
			pstmt.setString(2, paraMap.get("userid") );
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			n1 = rs.getInt(1);
			
			if ( n1 == 1 ) {
				sql = " update tbl_cart set cart_quantity = ?  , cart_insert_time = sysdate "
					+ " WHERE CART_PRODUCT_ID = ? AND CART_MEMBER_ID = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("oqty"));
				pstmt.setString(2, paraMap.get("prodNum"));
				pstmt.setString(3, paraMap.get("userid"));
				
				n2 = pstmt.executeUpdate();
				
				
			}
			else {
				sql = " INSERT INTO TBL_CART ( cart_member_id , cart_product_id , cart_quantity , cart_insert_time ) "
						+ " VALUES ( ? , ? , ? , default ) " ;
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setInt(2, Integer.parseInt(paraMap.get("prodNum")));
				pstmt.setInt(3, Integer.parseInt(paraMap.get("oqty")));
				
				n2 = pstmt.executeUpdate();
			}
			
			if ( n2 == 1) {
				sql =     " SELECT CART_ID FROM TBL_CART  "
						+ " WHERE CART_PRODUCT_ID = ? AND CART_MEMBER_ID = ? " ;
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(paraMap.get("prodNum"))) ;
				pstmt.setString(2, paraMap.get("userid"));
				
				rs = pstmt.executeQuery();
				if ( rs.next() ) {
					cartId = rs.getInt(1);
				}
			}
		}finally {
			close();
		}
		
		return cartId ;
	
	
	}
	
	

	
	
	
	
	@Override
	public int addReview(Map<String, String> paraMap)  throws SQLException {
		int n1 = 0, n2 = 0, n3 = 0;
		int isSuccess = 0;
		
		try {
			conn = ds.getConnection();
			
			conn.setAutoCommit(false); // 수동커밋으로 바꾼다.
			
			String sql = " insert into tbl_review(review_member_id, review_product_id, review_score, review_content, order_serial, review_date)"
					   + " values( ?, ?, ?, ?, ?, default) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setInt(2, Integer.parseInt(paraMap.get("product_id")) );
			pstmt.setDouble(3, Double.parseDouble(paraMap.get("rating")) / 2.0 );
			pstmt.setString(4, paraMap.get("contents"));
			
			pstmt.setString(5, paraMap.get("orderSerial"));
			
			n1 = pstmt.executeUpdate();
		//	System.out.println("n1 : " +n1);
			
			if(n1 == 1) {
				
				sql = " update tbl_order_detail set review_status = 2 "
					+ " where order_detail_product_id = ? and fk_order_serial = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, Integer.parseInt(paraMap.get("product_id")));
				pstmt.setString(2, paraMap.get("orderSerial"));
				
				n2 = pstmt.executeUpdate();
				
			//	System.out.println("n2 : " +n2);
			}
			
			if(n2 == 1) {
				
				sql = " UPDATE tbl_product"
					+ "    SET average_rating = ("
					+ "        SELECT ROUND(AVG(review_score), 1) "
					+ "        FROM tbl_review "
					+ "        WHERE review_product_id = ? "
					+ "    )"
					+ "    WHERE product_id = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, Integer.parseInt(paraMap.get("product_id")) );
				pstmt.setInt(2, Integer.parseInt(paraMap.get("product_id")) );
				
				n3 = pstmt.executeUpdate();
			//	System.out.println("n3 : " +n3);
			}
			
			
			
			if (n1 * n2 * n3 > 0) {
				
				conn.commit();
				
				conn.setAutoCommit(true);
				
				
				isSuccess = 1;
				
			}
			
			
		} catch (SQLException e) {
			
			conn.rollback();
			
			conn.setAutoCommit(true);
			
			isSuccess = 0;
		} 
		
		finally {
			close();
		}
		
		return isSuccess;
	}



	
	@Override
	public List<OrderDetailDTO> getReviewable(Map<String, String> paraMap) throws SQLException {
		

		List<OrderDetailDTO> orderDetails = new ArrayList<>();
		int page = Integer.parseInt(paraMap.get("page"));
		int pageSize = 5;
		String userid = paraMap.get("userid");
		
		
	    int offset = (page - 1) * pageSize;
	    
	    String sql = " SELECT p.product_name, p.product_id , p.product_image_url, b.brand_name, to_char(o.order_date,'yyyy-mm-dd') as order_date, o.order_serial, od.order_quantity, od.price_per_unit "
	    		+ "FROM tbl_order_detail od "
	    		+ "INNER JOIN tbl_order o ON od.fk_order_serial = o.order_serial "
	    		+ "INNER JOIN tbl_product p ON od.order_detail_product_id = p.product_id "
	    		+ "INNER JOIN tbl_brand b ON p.product_brand_id = b.brand_id "
	    		+ "WHERE od.review_status = 1 and o.order_member_id = ? "
	    		+ "ORDER BY o.order_date DESC "
	    		+ "OFFSET ? ROWS "
	    		+ "FETCH NEXT ? ROWS ONLY";
	    
	    try {
	    	conn = ds.getConnection();
	    	pstmt = conn.prepareStatement(sql);
	    	pstmt.setString(1, userid);
	    	pstmt.setInt(2, offset);
	    	pstmt.setInt(3, pageSize);
	    	
	    	rs = pstmt.executeQuery();
	    	while(rs.next()) {
	    		 OrderDetailDTO orderDetail = new OrderDetailDTO();
	    		 ProductDTO product = new ProductDTO();
	    		 product.setProdName(rs.getString("PRODUCT_NAME"));
	    		 product.setProdImage1(rs.getString("PRODUCT_IMAGE_URL"));
	    		 product.setProdNum(rs.getInt("PRODUCT_ID"));
	    		 BrandDTO brand = new BrandDTO();
	    		 brand.setBrandName(rs.getString("BRAND_NAME"));
	    		 product.setBrandDTO(brand);
	    		 orderDetail.setOrderDetailProd(product);
	    		 orderDetail.setOrderedDate(rs.getString("ORDER_DATE"));
	    		 orderDetail.setOrderSerial(rs.getString("ORDER_SERIAL"));
	    		 orderDetail.setOrderQuantity(rs.getInt("ORDER_QUANTITY"));
	    		 orderDetail.setPricePerUnit(rs.getInt("PRICE_PER_UNIT"));
	    		 orderDetails.add(orderDetail);
	    	}
	    	
	    	
	    } finally {
			close();
		}
	    
	    return orderDetails;
	}

	@Override
	public List<OrderDetailDTO> getReviewed(Map<String, String> paraMap) throws SQLException {
		List<OrderDetailDTO> orderDetails = new ArrayList<>();
		int page = Integer.parseInt(paraMap.get("page"));
		int pageSize = 5;
		String userid = paraMap.get("userid");
		
		
	    int offset = (page - 1) * pageSize;
	    
	    String sql = " SELECT p.product_name, p.product_id , p.product_image_url, b.brand_name, o.order_serial, to_char(r.review_date,'yyyy-mm-dd') as review_date,  od.order_quantity, od.price_per_unit "
	    		+ " FROM tbl_order_detail od "
	    		+ " INNER JOIN tbl_order o ON od.fk_order_serial = o.order_serial "
	    		+ " INNER JOIN tbl_product p ON od.order_detail_product_id = p.product_id "
	    		+ " INNER JOIN tbl_brand b ON p.product_brand_id = b.brand_id "
	    		+ " INNER JOIN tbl_review r ON o.order_serial = r.order_serial AND p.product_id = r.review_product_id "
	    		+ " WHERE od.review_status = 2 AND o.order_member_id = ?"
	    		+ " ORDER BY r.review_date DESC "
	    		+ " OFFSET ? ROWS "
	    		+ " FETCH NEXT ? ROWS ONLY";
	    
	    try {
	    	conn = ds.getConnection();
	    	pstmt = conn.prepareStatement(sql);
	    	pstmt.setString(1, userid);
	    	pstmt.setInt(2, offset);
	    	pstmt.setInt(3, pageSize);
	    	
	    	rs = pstmt.executeQuery();
	    	while(rs.next()) {
	    		 OrderDetailDTO orderDetail = new OrderDetailDTO();
	    		 ProductDTO product = new ProductDTO();
	    		 product.setProdName(rs.getString("PRODUCT_NAME"));
	    		 product.setProdImage1(rs.getString("PRODUCT_IMAGE_URL"));
	    		 product.setProdNum(rs.getInt("PRODUCT_ID"));
	    		 BrandDTO brand = new BrandDTO();
	    		 brand.setBrandName(rs.getString("BRAND_NAME"));
	    		 product.setBrandDTO(brand);
	    		 orderDetail.setOrderDetailProd(product);
	    		 orderDetail.setReviewedDate(rs.getString("REVIEW_DATE"));
	    		 orderDetail.setOrderSerial(rs.getString("ORDER_SERIAL"));
	    		 orderDetail.setOrderQuantity(rs.getInt("ORDER_QUANTITY"));
	    		 orderDetail.setPricePerUnit(rs.getInt("PRICE_PER_UNIT"));
	    		 orderDetails.add(orderDetail);
	    	}
	    	
	    	
	    } finally {
			close();
		}
	    
	    return orderDetails;
	}

	@Override
	public int getTotalReviewable(String userid) throws SQLException {
		 
			int totalOrder = 0;
			
		    String sql = " SELECT count(*) "
		    		+ "FROM tbl_order_detail od "
		    		+ "INNER JOIN tbl_order o ON od.fk_order_serial = o.order_serial "
		    		+ "INNER JOIN tbl_product p ON od.order_detail_product_id = p.product_id "
		    		+ "INNER JOIN tbl_brand b ON p.product_brand_id = b.brand_id "
		    		+ "WHERE od.review_status = 1 and o.order_member_id = ? ";

		    
		    try {
		    	conn = ds.getConnection();
		    	pstmt = conn.prepareStatement(sql);
		    	pstmt.setString(1, userid);
		    	
		    	rs = pstmt.executeQuery();
		    	if(rs.next()) {
		    		totalOrder = rs.getInt(1);
		    		
		    		
		    	}
		    	
		    	
		    } finally {
				close();
			}
		    
		    return totalOrder;
	}

	@Override
	public int getTotalReviewed(String userid) throws SQLException {
		
		int totalOrder = 0;
		
	    String sql = " SELECT count(*) "
	    		+ " FROM tbl_order_detail od "
	    		+ " INNER JOIN tbl_order o ON od.fk_order_serial = o.order_serial "
	    		+ " INNER JOIN tbl_product p ON od.order_detail_product_id = p.product_id "
	    		+ " INNER JOIN tbl_brand b ON p.product_brand_id = b.brand_id "
	    		+ " INNER JOIN tbl_review r ON o.order_serial = r.order_serial AND p.product_id = r.review_product_id "
	    		+ " WHERE od.review_status = 2 AND o.order_member_id = ?";

	    
	    try {
	    	conn = ds.getConnection();
	    	pstmt = conn.prepareStatement(sql);
	    	pstmt.setString(1, userid);
	    	
	    	rs = pstmt.executeQuery();
	    	if(rs.next()) {
	    		totalOrder = rs.getInt(1);
	    		
	    		
	    	}
	    	
	    	
	    } finally {
			close();
		}
	    
	    return totalOrder;
	}

	@Override
	public OrderDTO ProductOrderDetail(Map<String, String> paraMap) throws SQLException {
		OrderDTO odto = new OrderDTO();

		try {
			conn = ds.getConnection();
		
			String sql = " SELECT B.brand_name, O.order_serial, P.product_name, P.product_image_url, P.product_id "
					   + " from tbl_product P JOIN tbl_order_detail D "
					   + " on P.product_id = D.order_detail_product_id JOIN tbl_order O "
					   + " on O.order_serial = D.fk_order_serial "
					   + " JOIN tbl_brand B on B.brand_id = product_brand_id "
					   + " where P.product_id = ? and O.order_serial = ? ";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("product_id"));
			pstmt.setString(2, paraMap.get("order_serial"));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO pdto = new ProductDTO();
				pdto.setProdName(rs.getString("product_name"));
				pdto.setProdImage1(rs.getString("product_image_url"));
				pdto.setProdNum(rs.getInt("product_id"));
				BrandDTO bdto = new BrandDTO();
				bdto.setBrandName(rs.getString("brand_name"));
				pdto.setBrandDTO(bdto);
				
				odto.setOrderSerial((rs.getString("order_serial")));
				odto.setProd(pdto);
			}
			
			
		}finally {
			close();
		}
		return odto;
	}
	
	
	@Override
	public int reviewDel(Map<String, String> paraMap) throws SQLException {
		int n1 = 0, n2 = 0, n3 = 0;
	    int isSuccess = 0;

	    try {
	        conn = ds.getConnection();

	        conn.setAutoCommit(false); // 수동커밋으로 바꾼다.

	        String sql = " DELETE FROM tbl_review "
	                   + " WHERE review_member_id = ? and review_product_id = ? ";
	                  

	        pstmt = conn.prepareStatement(sql);
	        
	        pstmt.setString(1, paraMap.get("userid"));
	        pstmt.setInt(2, Integer.parseInt(paraMap.get("product_id")));

	        n1 = pstmt.executeUpdate();

	   //     System.out.println("n1 :" +n1);
	        
	        if (n1 == 1) {

	            sql = " UPDATE tbl_order_detail SET review_status = 1 "
	                + " WHERE order_detail_product_id = ? "
	                + " AND fk_order_serial = ? ";

	            pstmt = conn.prepareStatement(sql);

	            pstmt.setInt(1, Integer.parseInt(paraMap.get("product_id")));
	            pstmt.setString(2, paraMap.get("orderSerial"));

	            n2 = pstmt.executeUpdate();
	        //    System.out.println("n2 :" +n2);
	        }

	        if (n2 == 1) {

	            sql = " UPDATE tbl_product "
	                + " SET average_rating = ("
	                + "     SELECT ROUND(AVG(review_score), 1) "
	                + "     FROM tbl_review "
	                + "     WHERE review_product_id = ? "
	                + " ) "
	                + " WHERE product_id = ? "; 

	            pstmt = conn.prepareStatement(sql);

	            pstmt.setInt(1, Integer.parseInt(paraMap.get("product_id")));
	            pstmt.setInt(2, Integer.parseInt(paraMap.get("product_id")));

	            n3 = pstmt.executeUpdate();
	      //      System.out.println("n3 :" +n3);
	        }

	        if (n1 * n2 * n3 > 0) {

	            conn.commit();

	            conn.setAutoCommit(true);

	            isSuccess = 1;

	        }

	    } catch (SQLException e) {

	        conn.rollback();

	        conn.setAutoCommit(true);

	        isSuccess = 0;
	    }

	    finally {
	        close();
	    }

	    return isSuccess;
	}

	// 제품 등록 해주기 
	@Override
	public int insertProduct(ProductDTO pdto) throws SQLException {
		int n = 0 ;
		 	try {
			conn = ds.getConnection();
			
			
	        String sql = " Insert into tbl_product ( PRODUCT_NAME , PRODUCT_CATEGORY_ID , PRODUCT_BRAND_ID , PRODUCT_PRICE  "
	        		+    " ,  PRODUCT_SALES , PRODUCT_DISCOUNT , AVERAGE_RATING , PRODUCT_IMAGE_URL )  "
	                   + " values ( ? , ? , ? , ? , ? , ?  , ?  , ? ) ";
	                   
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, pdto.getProdNum() );
	        pstmt.setInt(2, pdto.getFk_prodCateNum());
	        pstmt.setInt(3, pdto.getFk_prodBrandNum());
	        pstmt.setInt(4, pdto.getProdPrice());
	        pstmt.setInt(5, 0 );
	        pstmt.setInt(6, pdto.getProdDiscount());
	        pstmt.setInt(7, 0 );
	        pstmt.setString(8, pdto.getProdImage1());
	        
	        n = pstmt.executeUpdate();
	        
		 	}finally {
		 		close();
		 	}
		return n ;
	}
	

	
}
	
	
	
