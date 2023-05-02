package semiproject.dak.product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import semiproject.dak.member.model.MembershipTierDTO;

public class ReviewDAO {

	private DataSource ds; 
	private PreparedStatement pstmt;
	private Connection conn;
	private ResultSet rs;
	
	public ReviewDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semi_oracle");
		    
		} catch(NamingException e) {
			e.printStackTrace();
		} 
	}
	
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
	
	
	//리뷰 정보 알아오는 메소드
	public List<HashMap<String, String>> getReview() throws SQLException {
		
		List<HashMap<String, String>> review = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " SELECT review_id, review_member_id, review_product_id, review_score, review_title,review_content, review_date "
				 		+ " FROM "
				 		+ " (SELECT rownum, review_id, review_member_id, review_product_id, review_score, review_title,review_content, review_date "
				 		+ " FROM "
				 		+ " (select review_id, review_member_id, review_product_id, review_score, review_title,review_content, to_char(review_date, 'yyyy-mm-dd') as review_date "
				 		+ " from tbl_review where review_product_id = 11 order by review_date desc) V)VV "
				 		+ " WHERE rownum between 1 and 5 ";
			 
			 pstmt = conn.prepareStatement(sql);
			 
			 rs = pstmt.executeQuery();  //select문이기 때문에 executeQuery() 사용
			 
			 while(rs.next()) {
				 
				 HashMap<String, String> map = new HashMap<>();
				 
				 review.add(map);
				 
			 }//end of while---------------------------------------------------
			 
		} finally {
			close();  //자원반납
			//close() : Statement 객체 반환할 때 사용(연결종료)
		}
		
		return review;
		
	}//end of public List<HashMap<String, String>> getUserInfo() throws SQLException----------------
	
	
	
	//리뷰 개수 알아오는 메소드
	public int getReviewCnt(int review_product_id) throws SQLException {
		
		int reviewCnt = 0;
		
		try {
			conn = ds.getConnection();
			 
			 String sql = " select count(*) as review_count from tbl_review where review_product_id = ? "
			 			+ " group by review_product_id ";
			 
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, review_product_id);
			 
			 rs = pstmt.executeQuery();  //select문이기 때문에 executeQuery() 사용
			 
			 if(rs.next()) {
				 
				 reviewCnt = rs.getInt("review_product_id");
			 }	 
		} finally {
			close();
		}
		
		return reviewCnt;
	}
	
	
	
}
 