package semiproject.dak.product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.DataSource;


public class BrandDAO {

	private DataSource ds; 
	private PreparedStatement pstmt;
	private Connection conn;
	private ResultSet rs;

	

	public String getBrandName(int brand_id) throws SQLException {

		
		String brandName = "";
		
		try {
			
			conn = ds.getConnection(); 
			
			
			String sql = " select brand_name "
					   + " from tbl_brand"
					   + " where brand_id = ? ";
		
			pstmt =conn.prepareStatement(sql);
			pstmt.setInt(1, brand_id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				brandName = rs.getString("BRAND_NAME");		
			}
			
		}finally {
			close();
		}
		
		return brandName;
		
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
	
}
