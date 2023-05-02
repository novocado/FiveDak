package semiproject.dak.product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import semiproject.dak.security.AES256;

public class BrandDAO {

	private DataSource ds; 
	private PreparedStatement pstmt;
	private Connection conn;
	private ResultSet rs;
	private AES256 aes;
	

	public String getBrandName(int brand_id) throws SQLException {
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		String brandName = "";
		
		try {
			
			conn = ds.getConnection(); 
			
			
			String sql = " select brand_name "
					   + " from tbl_brand"
					   + " where brand_id = ? ";
		
			ps=conn.prepareStatement(sql);
			ps.setInt(1, brand_id);
			
			rs=ps.executeQuery();
			
			if(rs.next()) {
				
				brandName = rs.getString("BRAND_NAME");
				
			}
		//	System.out.println("제발 나와주세요"+pdto);
			
			
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
