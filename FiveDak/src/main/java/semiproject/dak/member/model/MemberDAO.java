package semiproject.dak.member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

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
	
	// 이메일이 존재하는 이메일인지 확인하기
	@Override
	public boolean CheckDuplicateEmail(String email) throws SQLException {
		boolean result = false;
		
		
		try {
			conn = ds.getConnection();
			String sql = " select * "
					+    " from tbl_member "
					+    " where member_email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, aes.encrypt(email));
			
			rs = pstmt.executeQuery();
			result = rs.next();
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return result;
	}

	@Override
	public boolean CheckDuplicateID(String userid) throws SQLException {
		boolean result = false;
		
		try {
			conn = ds.getConnection();
			String sql = " select * "
					+    " from tbl_member "
					+    " where member_id = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			result = rs.next();
			
		} finally {
			close();
		}
		
		return result;
	}
	
	
	@Override
	public MemberDTO getMemberByLoginMap(Map<String, String> loginMap) throws SQLException {
		MemberDTO mdto = null ;
		try {
			conn = ds.getConnection();
			String sql = "SELECT  MEMBER_NUM , MEMBER_ID , MEMBER_NAME , MEMBER_MOBILE , MEMBER_EMAIL , "+
					"		   MEMBER_POINT , MEMBER_GENDER , MEMBER_BIRTH , MEMBER_POSTCODE , MEMBER_ADDRESS , "+
					"		   MEMBER_DETAIL_ADDRESS , MEMBER_TIER_ID , MEMBER_REG_DATE , pwdchangegap "+
					"        , nvl(lastlogin_time , trunc( months_between(sysdate, registerday) , 0 )) AS lastlogin_gap "+
					" FROM  "+
					" ( "+
					" select MEMBER_NUM , MEMBER_ID, MEMBER_NAME, MEMBER_EMAIL, MEMBER_MOBILE, MEMBER_POSTCODE, MEMBER_ADDRESS, MEMBER_DETAIL_ADDRESS "+
					"       , MEMBER_GENDER , MEMBER_POINT , MEMBER_BIRTH , MEMBER_TIER_ID , LAST_PWD_CHANGED , MEMBER_REG_DATE  "+
					"       , to_char(MEMBER_REG_DATE, 'yyyy-mm-dd') AS registerday "+
					"       , trunc(months_between(sysdate,LAST_PWD_CHANGED) ,0) AS pwdchangegap "+
					" from tbl_member   "+
					" where MEMBER_STATUS = 1 and MEMBER_ID = ? and MEMBER_PWD= ? "+
					" )M "+
					" CROSS JOIN "+
					" ( "+
					" select trunc( months_between(sysdate, max(LOGIN_TIME)) , 0 ) AS lastlogin_time  "+
					" from member_login_history  "+
					" where LOGIN_MEMBER_ID = ? "+
					" )H ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginMap.get("userid"));
			pstmt.setString(2, Sha256.encrypt(loginMap.get("pwd")));
			pstmt.setString(3, loginMap.get("userid"));
			
			
			rs = pstmt.executeQuery();
			int cnt = 1 ;
			if (rs.next()) {
				mdto = new MemberDTO();
				mdto.setMbrNum(rs.getInt(cnt++));
				mdto.setMbrId(rs.getString(cnt++));
				mdto.setMbrName(rs.getString(cnt++));
				mdto.setMbrMobile(aes.decrypt(rs.getString(cnt++)));
				mdto.setMbrEmail(aes.decrypt(rs.getString(cnt++)));
				mdto.setMbrPoint(rs.getInt(cnt++));
				mdto.setMbrGender(rs.getString(cnt++));
				mdto.setMbrBirth(rs.getString(cnt++));
				mdto.setMbrPostcode(rs.getString(cnt++));
				mdto.setMbrAddress(rs.getString(cnt++));
				mdto.setMbrDetailAddress(rs.getString(cnt++));
				mdto.setMbrTierId(rs.getInt(cnt++));
				mdto.setMbrRegDate(rs.getString(cnt++));
				
				
				
				if  ( rs.getInt(cnt++) >= 3 ) { // 패스워드 변경한지 3개월이 지났다면 
					mdto.setRequirePwdChange(true);
				}
				
				if ( rs.getInt(cnt++) >= 12 ) { 
					// 로그인 한지가 12개월이 지났다면
					// === tbl_member 테이블의 idle 컬럼의 값을 1로 변경하기
					mdto.setMbrIdle(1);
					
					sql = " update tbl_member set MEMBER_IDLE = 1 "
				     +    " where MEMBER_ID = ? ";
					 
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, loginMap.get("userid"));
					
					pstmt.executeUpdate();
				}// end of if 
				
				// === member_login_history(로그인기록) 테이블에 insert 하기 === // 
				// 휴면 계정이 아닌 경우에만 넣어주어야 한다.
				if ( mdto.getMbrIdle() != 1) {
					
					sql = " insert into member_login_history (LOGIN_MEMBER_ID, IP_ADDRESS) values ( ? , ? ) ";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.executeUpdate();
				}// end of if 
				
			}// end of if 
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return mdto;
	}

	
	

}
