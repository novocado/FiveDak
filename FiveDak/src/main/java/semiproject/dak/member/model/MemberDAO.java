package semiproject.dak.member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import semiproject.dak.security.AES256;
import semiproject.dak.security.SecretMyKey;
import semiproject.dak.security.Sha256;



public class MemberDAO implements InterMemberDAO {
	private DataSource ds; // DataSource == Apache Tomcat이 제공하는 DBCP
	private PreparedStatement pstmt;
	private Connection conn;
	private ResultSet rs;
	private AES256 aes;
	
	public MemberDAO() {
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

	@Override
	public boolean registerMember(MemberDTO member) throws SQLException {
		boolean result = false;
		
		
		try {
			conn = ds.getConnection();
			String sql = " insert into tbl_member(member_id, member_pwd, member_name, member_mobile, member_email, member_gender, member_birth, member_postcode, member_address, member_detail_address)\r\n"
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
			pstmt = conn.prepareStatement(sql);
			
			int count = 1;
			pstmt.setString(count++, member.getMbrId());
			pstmt.setString(count++, Sha256.encrypt(member.getMbrPwd()));
			pstmt.setString(count++, member.getMbrName());
			pstmt.setString(count++, aes.encrypt(member.getMbrMobile()));
			pstmt.setString(count++, aes.encrypt(member.getMbrEmail()));
			pstmt.setString(count++, member.getMbrGender());
			pstmt.setString(count++, member.getMbrBirth());
			pstmt.setString(count++, member.getMbrPostcode());
			pstmt.setString(count++, member.getMbrAddress());
			pstmt.setString(count++, member.getMbrDetailAddress());
			
			result = (pstmt.executeUpdate() == 1);
			
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return result;
	}

	@Override
	public boolean CheckDuplicateEmail(String email) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}
	

}
