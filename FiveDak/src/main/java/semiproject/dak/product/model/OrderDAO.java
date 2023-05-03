package semiproject.dak.product.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import semiproject.dak.security.AES256;
import semiproject.dak.security.SecretMyKey;

public class OrderDAO implements InterOrderDAO{
	private DataSource ds; // DataSource == Apache Tomcat이 제공하는 DBCP
	private PreparedStatement pstmt;
	private Connection conn;
	private ResultSet rs;
	private AES256 aes;
	
	public OrderDAO() {
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
	} // end of public orderDAO
	
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
	}

	@Override
	public int getSumMonthOrder() throws SQLException {
		int n = 0 ; 
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*)  "
					+ " from tbl_order "
					+ " WHERE to_char(order_date, 'yyyy-mm') = to_char(sysdate, 'yyyy-mm' )   " ;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
			n = rs.getInt(1);
			
		}finally {
			close();
		}
		return n;
	}

	@Override
	public int getSumNotShipped() throws SQLException {
		int n = 0 ; 
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*)  "
					+ " from tbl_order "
					+ " WHERE to_char(order_date, 'yyyy-mm') = to_char(sysdate, 'yyyy-mm' ) AND order_status = 7 " ;
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			n = rs.getInt(1);
			
		}finally {
			close();
		}
		return n;
		
		
		
	}

	@Override
	public int getSumTotalSales() throws SQLException {
		int n = 0 ; 
		try {
			conn = ds.getConnection();
			
			String sql = " select sum(order_total_price)  "
					+ " from tbl_order "
					+ " WHERE to_char(order_date, 'yyyy-mm') = to_char(sysdate, 'yyyy-mm' )  " ;
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			n = rs.getInt(1);
			
		}finally {
			close();
		}
		return n;
		}

	@Override
	public List<OrderDTO> showAllOrder(Map<String, String> paraMap) throws SQLException {
		List<OrderDTO> orderList = new ArrayList<>();
		String sql = "";
		try {
			conn = ds.getConnection();
			
			if ("".equals(paraMap.get("order_date"))) {
				sql = " SELECT RNO, ORDER_ID, ORDER_MEMBER_ID, ORDER_TOTAL_PRICE , SHIPPING_ADDRESS, TRACKING_NUMBER, RECIPIENT_MOBILE  "+
						"					, ORDER_STATUS , ORDER_DATE , status_name , ORDER_SERIAL "+
						"					 FROM  "+
						"					 (  "+
						"					 select row_number() over (order by ORDER_DATE DESC) AS RNO   "+
						"					 , ORDER_ID, ORDER_MEMBER_ID, ORDER_TOTAL_PRICE , SHIPPING_ADDRESS, TRACKING_NUMBER, RECIPIENT_MOBILE   "+
						"					 , ORDER_STATUS , to_char( ORDER_DATE , 'yyyy-mm-dd') as order_date , S.status_name , O.ORDER_SERIAL  "+
						"					 from tbl_order O  "+
						"                     JOIN order_status S "+
						"                     ON O.ORDER_STATUS = S.status_id "+
						"                    WHERE to_char(order_date, 'yyyy-mm') = to_char(sysdate, 'yyyy-mm' ) " ;
						
						
			}
			
			else {
				if ( "6".equals(paraMap.get("order_date"))) {
					sql = " SELECT RNO, ORDER_ID, ORDER_MEMBER_ID, ORDER_TOTAL_PRICE , SHIPPING_ADDRESS, TRACKING_NUMBER, RECIPIENT_MOBILE  "+
							"					, ORDER_STATUS , ORDER_DATE , status_name , ORDER_SERIAL "+
							"					 FROM  "+
							"					 (  "+
							"					 select row_number() over (order by ORDER_DATE DESC) AS RNO   "+
							"					 , ORDER_ID, ORDER_MEMBER_ID, ORDER_TOTAL_PRICE , SHIPPING_ADDRESS, TRACKING_NUMBER, RECIPIENT_MOBILE   "+
							"					 , ORDER_STATUS , to_char( ORDER_DATE , 'yyyy-mm-dd') as order_date , S.status_name , O.ORDER_SERIAL "+
							"					 from tbl_order O  "+
							"                     JOIN order_status S "+
							"                     ON O.ORDER_STATUS = S.status_id "+
							"                   WHERE order_date >= ADD_MONTHS(TRUNC(SYSDATE), -6 ) " ;
					
				}
				
				else {
					sql = " SELECT RNO, ORDER_ID, ORDER_MEMBER_ID, ORDER_TOTAL_PRICE , SHIPPING_ADDRESS, TRACKING_NUMBER, RECIPIENT_MOBILE  "+
							"					, ORDER_STATUS , ORDER_DATE , status_name , ORDER_SERIAL "+
							"					 FROM  "+
							"					 (  "+
							"					 select row_number() over (order by ORDER_DATE DESC) AS RNO   "+
							"					 , ORDER_ID, ORDER_MEMBER_ID, ORDER_TOTAL_PRICE , SHIPPING_ADDRESS, TRACKING_NUMBER, RECIPIENT_MOBILE   "+
							"					 , ORDER_STATUS , to_char( ORDER_DATE , 'yyyy-mm-dd') as order_date , S.status_name , O.ORDER_SERIAL "+
							"					 from tbl_order O  "+
							"                     JOIN order_status S "+
							"                     ON O.ORDER_STATUS = S.status_id "+
							"                 WHERE order_date >= ADD_MONTHS(TRUNC(SYSDATE), -12 )" ;
				}

					
			}
			if ( !"".equals(paraMap.get("order_status"))) {
				sql += "and order_status = ? "; 
			}
			
			sql += "					 )  "+
			"	WHERE RNO BETWEEN ? AND ?  "
			; 
			pstmt = conn.prepareStatement(sql);
			int cnt = 1 ;
			
			if ( !"".equals(paraMap.get("order_status"))) {
				pstmt.setString(cnt++, paraMap.get("order_status"));
			}
			
			pstmt.setString(cnt++, paraMap.get("start"));
			pstmt.setString(cnt++, paraMap.get("end"));
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				OrderDTO odto = new OrderDTO();
				odto.setFk_orderMbrId(rs.getString("ORDER_MEMBER_ID"));
				odto.setOrderId(rs.getInt("ORDER_ID")); 
				odto.setOrderSerial(rs.getString("ORDER_SERIAL"));
				odto.setOrderTotalPrice(rs.getInt("ORDER_TOTAL_PRICE"));
				odto.setOrderAddress(rs.getString("SHIPPING_ADDRESS"));
				odto.setOrderTrackNo(rs.getString("TRACKING_NUMBER"));
				
				odto.setRecipMobile(rs.getString("RECIPIENT_MOBILE"));
				odto.setOrderStatus(rs.getInt("ORDER_STATUS"));
				odto.setOrderDate(rs.getString("ORDER_DATE"));
				odto.setOrderStatus_name(rs.getString("status_name"));
				orderList.add(odto);
			}
			/*
			 * }catch(GeneralSecurityException | UnsupportedEncodingException e ) {
			 * e.printStackTrace();
			 */
		}finally {
			close();
		}
		return orderList;
	}

	@Override
	public int getTotalNo(Map<String,String> paraMap) throws SQLException {
		int totalNo = 0 ;
		String sql = "";
		try {
			conn = ds.getConnection();
			
			if ( "".equals(paraMap.get("order_date")) ) {
				sql = " select count ( * ) as count  "+
						" from tbl_order O "+
						" JOIN order_status S "+
						" ON O.ORDER_STATUS = S.STATUS_ID  "+
						" WHERE TO_CHAR ( ORDER_DATE , 'YYYY-MM') = TO_CHAR(SYSDATE,'YYYY-MM' ) " ;
						
			}
			
			else {
				sql = " select count ( * ) as count  "+
						" from tbl_order O "+
						" JOIN order_status S "+
						" ON O.ORDER_STATUS = S.STATUS_ID  " ;
				if ( "6".equals(paraMap.get("order_date"))) {
					
						sql += 	" WHERE order_date >= ADD_MONTHS(TRUNC(SYSDATE), -6 ) " ;
				}
				else {
					sql += " WHERE order_date >= ADD_MONTHS(TRUNC(SYSDATE), -12 ) " ;
				}
				
				
			}
			
			if ( !"".equals(paraMap.get("order_status"))) {
				sql += "AND ORDER_STATUS = ? ";
			}
			pstmt = conn.prepareStatement(sql);
			int cnt = 1 ;
			
			if ( !"".equals(paraMap.get("order_status"))) {
				pstmt.setString(cnt++, paraMap.get("order_status"));
			}
			
			rs = pstmt.executeQuery();	
			
			rs.next();
			totalNo = rs.getInt("count"); 		

		}finally {
			close();
		}
			
			
			
			
		return totalNo ;
	}

	// 주문 상세 정보에 띄울 정보들 DB에서 가져오기
	@Override
	public OrderDTO getOrderInfo(String orderserial) throws SQLException {
		OrderDTO odto = null ;
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT  ORDER_MEMBER_ID ,ORDER_TOTAL_PRICE , (SHIPPING_ADDRESS || ' ' || SHIPPING_DETAIL_ADDRESS ) AS ORDER_ADDRESS "
					+ " , RECIPIENT_MOBILE , TRACKING_NUMBER , ORDER_STATUS  ,  STATUS_NAME , ORDER_SERIAL , ORDER_DATE , ORDER_MESSAGE "
					+ " FROM TBL_ORDER O "
					+ " JOIN order_status S "
					+ " ON O.ORDER_STATUS = S.STATUS_ID  "  
					+ " WHERE ORDER_SERIAL = ? "; 
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, orderserial);
			
			rs = pstmt.executeQuery();
			
			if ( rs.next()) {
				odto = new OrderDTO();
				odto.setFk_orderMbrId(rs.getString("ORDER_MEMBER_ID"));
				odto.setOrderSerial(rs.getString("ORDER_SERIAL"));
				odto.setOrderTotalPrice(rs.getInt("ORDER_TOTAL_PRICE"));
				odto.setCombineAddress(rs.getString("ORDER_ADDRESS"));
				odto.setRecipMobile(rs.getString("RECIPIENT_MOBILE"));
				odto.setOrderTrackNo(rs.getString("TRACKING_NUMBER"));
				odto.setOrderStatus(rs.getInt("ORDER_STATUS"));
				odto.setOrderStatus_name(rs.getString("STATUS_NAME"));
				odto.setOrderDate(rs.getString("ORDER_DATE"));
				odto.setOrderMessage(rs.getString("ORDER_MESSAGE"));
			}
		}finally {
			close();
		}
		
		return odto;
	}// END OF PUBLIC ORDERDTO GETORDERINFO(STRING ORDERID) THROWS SQLEXCEPTION {

	
	// 주문 상세 페이지 에서 ORDER_STATUS 변경한 경우
	@Override
	public int goEditStatus(Map<String, String> paraMap) throws SQLException {
		int n = 0 ;
		try {
			conn = ds.getConnection();
			
			String sql = " UPDATE tbl_order "
					+ " SET ORDER_STATUS = ? "
					+ " WHERE ORDER_SERIAL = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("orderStatus"));
			pstmt.setString(2, paraMap.get("order_serial"));
			
			n = pstmt.executeUpdate();
			
			if ( Integer.parseInt(paraMap.get("orderStatus")) == 4 ) {
				sql = " update tbl_order_detail  "
					+ "  set REVIEW_STATUS =  2 "
					+ "  where FK_ORDER_SERIAL ? " ;
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("order_serial"));
				
				n = pstmt.executeUpdate();
			}
		}finally {
			close();
		}
		return n;
	}

	// 주문 상세 페이지 에서 ORDER 를 삭제하는 경우 
	@Override
	public int goRemoveOrder(String order_serial) throws SQLException {
		int n = 0 ;
		try {
			conn = ds.getConnection();
			
			String sql =  " DELETE FROM TBL_ORDER_DETAIL WHERE FK_ORDER_SERIAL = ?  ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order_serial );
			
			n = pstmt.executeUpdate();
			
			sql = " DELETE FROM TBL_ORDER WHERE ORDER_SERIAL = ?  ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order_serial );
			
			n = pstmt.executeUpdate();
			
		}finally {
			close();
		}
		
		return n;
	}

	@Override
	public List<OrderDTO> getOrderDetail(String order_serial) throws SQLException {
		List<OrderDTO> list = new ArrayList<>();
		try {
			conn = ds.getConnection();
			String sql = " SELECT   D.ORDER_DETAIL_PRODUCT_ID, P.PRODUCT_NAME , D.ORDER_QUANTITY , O.ORDER_MESSAGE , D.PRICE_PER_UNIT , p.product_image_url , B.BRAND_NAME "
					+ " FROM tbl_order_detail D "
					+ " JOIN TBL_ORDER O "
					+ " ON D.FK_ORDER_SERIAL = O.ORDER_SERIAL "
					+ " JOIN TBL_PRODUCT P  "
					+ " ON D.ORDER_DETAIL_PRODUCT_ID = P.PRODUCT_ID "
					+ " JOIN TBL_BRAND B "
					+ " on P.PRODUCT_BRAND_ID = B.BRAND_ID "
					+ " WHERE D.FK_ORDER_SERIAL = ? ";
					
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, order_serial);
			
			rs = pstmt.executeQuery();
			
			while ( rs.next()) {
				OrderDTO odto = new OrderDTO();
				OrderDetailDTO oddto = new OrderDetailDTO();
					ProductDTO pdto = new ProductDTO();
					pdto.setProdNum(rs.getInt("ORDER_DETAIL_PRODUCT_ID"));
					pdto.setProdName(rs.getString("PRODUCT_NAME"));
					pdto.setProdImage1(rs.getString("product_image_url"));
					BrandDTO bdto = new BrandDTO();
					bdto.setBrandName(rs.getString("BRAND_NAME"));
					pdto.setBrandDTO(bdto);
				oddto.setOrderDetailProd(pdto);
				oddto.setOrderQuantity(rs.getInt("ORDER_QUANTITY"));
				oddto.setPricePerUnit(rs.getInt("PRICE_PER_UNIT"));
				odto.setOrderMessage(rs.getString("ORDER_MESSAGE"));
				odto.setOrddt(oddto);
				odto.setProd(pdto);
				
				list.add(odto);
			}
			
		}finally {
			close();
		}
	
		return list;
	}
	

	
	
	
	
} ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
