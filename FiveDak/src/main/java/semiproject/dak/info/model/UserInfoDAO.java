package semiproject.dak.info.model;

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

import semiproject.dak.security.AES256;
import semiproject.dak.security.SecretMyKey;

public class UserInfoDAO {
	
	private DataSource ds; 
	private PreparedStatement pstmt;
	private Connection conn;
	private ResultSet rs;
	
	public UserInfoDAO() {
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
	
	public List<HashMap<String, String>> getUserInfo() throws SQLException {
		
		List<HashMap<String, String>> userInfo = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select instruction_id, instruction_title, instruction_content "
			 		    + " from tbl_instruction "
			 		    + " order by instruction_id asc ";
			 
			 pstmt = conn.prepareStatement(sql);
			 
			 rs = pstmt.executeQuery();  //select문이기 때문에 executeQuery() 사용
			 
			 while(rs.next()) {
				 
				 HashMap<String, String> map = new HashMap<>();
				 
				 map.put("instruction_id", Integer.toString(rs.getInt(1)) );
				 map.put("instruction_title", rs.getString(2));
				 map.put("instruction_content", rs.getString(3));
				 
				 userInfo.add(map);
				 
			 }//end of while---------------------------------------------------
			 
		} finally {
			close();  //자원반납
			//close() : Statement 객체 반환할 때 사용(연결종료)
		}
		
		return userInfo;
		
	}//end of public List<HashMap<String, String>> getUserInfo() throws SQLException----------------
	
	
	
}
