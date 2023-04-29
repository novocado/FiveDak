 package semiproject.dak.member.model;

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
			String sql = " insert into tbl_member(member_id, member_pwd, member_name, member_mobile, member_email, member_gender, member_birth, member_postcode, member_address, member_detail_address )"
					+ " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getMbrId());
			pstmt.setString(2, Sha256.encrypt(member.getMbrPwd()));
			pstmt.setString(3, member.getMbrName());
			pstmt.setString(4, aes.encrypt(member.getMbrMobile()));
			pstmt.setString(5, aes.encrypt(member.getMbrEmail()));
			pstmt.setString(6, member.getMbrGender());
			pstmt.setString(7, member.getMbrBirth());
			pstmt.setString(8, member.getMbrPostcode());
			pstmt.setString(9, member.getMbrAddress());
			pstmt.setString(10, member.getMbrDetailAddress());
			
			result = (pstmt.executeUpdate() == 1);
			
			if(result) {
				//회원가입 완료시 1000포인트 지급
				int registerPoint = 1000;
				
				//멤버 테이블 업데이트
		        pstmt = conn.prepareStatement("UPDATE tbl_member SET member_point = member_point + ? WHERE member_id = ?");
		        pstmt.setInt(1, registerPoint);
		        pstmt.setString(2, member.getMbrId());
		        pstmt.executeUpdate();

		        // 포인트 변동내역 업데이트
		        pstmt = conn.prepareStatement("INSERT INTO member_point_history (point_member_id, point_before, point_change, point_after, point_reason, point_change_type) VALUES (?, ?, ?, ?, ?, ?)");
		        pstmt.setString(1, member.getMbrId());
		        pstmt.setInt(2, 0);
		        pstmt.setInt(3, registerPoint);
		        pstmt.setInt(4, registerPoint);
		        pstmt.setString(5, "회원가입 지급");
		        pstmt.setInt(6, 1);
		        pstmt.executeUpdate();
			}
			
			
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
					"        , nvl(lastlogin_time , trunc( months_between(sysdate, registerday) , 0 )) AS lastlogin_gap, MEMBER_PURCHASE_AMOUNT, TIER_NAME, AMOUNT_NEEDED, REWARD_PERCENTAGE, TIER_IMAGE "+
					" FROM  "+
					" ( "+
					" select MEMBER_NUM , MEMBER_ID, MEMBER_NAME, MEMBER_EMAIL, MEMBER_MOBILE, MEMBER_POSTCODE, MEMBER_ADDRESS, MEMBER_DETAIL_ADDRESS "+
					"       , MEMBER_GENDER , MEMBER_POINT , MEMBER_BIRTH , MEMBER_TIER_ID , LAST_PWD_CHANGED , MEMBER_REG_DATE  "+
					"       , to_char(MEMBER_REG_DATE, 'yyyy-mm-dd') AS registerday "+
					"       , trunc(months_between(sysdate,LAST_PWD_CHANGED) ,0) AS pwdchangegap, MEMBER_PURCHASE_AMOUNT "+
					" from tbl_member   "+
					" where MEMBER_STATUS = 1 and MEMBER_ID = ? and MEMBER_PWD= ? "+
					" )M "+
					" CROSS JOIN "+
					" ( "+
					" select trunc( months_between(sysdate, max(LOGIN_TIME)) , 0 ) AS lastlogin_time  "+
					" from member_login_history  "+
					" where LOGIN_MEMBER_ID = ? "+
					" )H JOIN membership_tier T ON M.MEMBER_TIER_ID = T.TIER_ID ";
			
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
				mdto.setMbrPurchaseAmount(rs.getInt("MEMBER_PURCHASE_AMOUNT"));
				
				MembershipTierDTO mbrTier = new MembershipTierDTO();				
				mbrTier.setTierName(rs.getString("TIER_NAME"));
				mbrTier.setRewardPercentage(rs.getInt("REWARD_PERCENTAGE"));
				mbrTier.setAmountNeeded(rs.getInt("AMOUNT_NEEDED"));
				mbrTier.setTierImage(rs.getString("TIER_IMAGE"));
				mdto.setMbrTier(mbrTier);
				
				
				
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
					pstmt.setString(1, loginMap.get("userid"));
					pstmt.setString(2, loginMap.get("clientip"));
					
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
	


	// // 아이디찾기에서 성명과 이메일로 아이디가 있는지 확인하기 위해 
	@Override
	public String findUserid(Map<String, String> paraMap) throws SQLException {

		String userid = null;
		
		try {
			
			conn = ds.getConnection();   // date source 에서 가져옴
			
			String sql = " select member_id "
					   + " from tbl_member "
					   + " where member_name = ? and member_email = ? ";
			
			
			// 우편배달부
			pstmt = conn.prepareStatement(sql);
			
			// 위치 홀더
			pstmt.setString(1, paraMap.get("memberFindIdName"));   //name 키값을써서 name 을 가져오자	
			pstmt.setString(2, aes.encrypt(paraMap.get("memberFindIdEmail")) );  // email 키 값을 써서 email 을 가져올껀데 암호화가 되어 있으므로 암호화 하여 비교한다.
			
			rs = pstmt.executeQuery();
			
			// selete 된 값이 있다면  
			if(rs.next()) {
				userid = rs.getString(1);    // 첫번째 컬럼을 userid 에 넣는다.
			}
			// selete 값이 없다면 null 이 넘어간다. 
			
					
		} catch ( GeneralSecurityException | UnsupportedEncodingException e) {			// 오류 두개를 같이 잡을때 | 는 or를 뜻한다.
			e.printStackTrace();
		} finally {
			close();
		}
		
		
		return userid;
	}
	
	@Override
	public boolean passwdCheck(Map<String, String> paraMap) throws SQLException {
		boolean result = false;
		
		try {
			conn = ds.getConnection();
			String sql = " select * "
					+    " from tbl_member "
					+    " where member_id = ? and member_pwd = ? ";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, Sha256.encrypt(paraMap.get("password")));	
			
			rs = pstmt.executeQuery();
			result = rs.next();
			
		} finally {
			close();
		}
		
		return result;
	}
	

	// 회원의 개인 정보 변경하기
	@Override
	public int updateMember(MemberDTO member) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_member set member_pwd = ? "
												 + " , member_email = ? "
												 + " , member_mobile = ? "
												 + " , member_postcode = ? "
												 + " , member_address = ? "
												 + " , member_detail_address = ? "
												 + " , member_gender = ? "
												 + " , member_birth = ? "
												 + " , LAST_PWD_CHANGED = sysdate "
					   + " where member_id = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, Sha256.encrypt(member.getMbrPwd()) );  
			pstmt.setString(2, aes.encrypt(member.getMbrEmail()) );   
			pstmt.setString(3, aes.encrypt(member.getMbrMobile()) );  
			pstmt.setString(4, member.getMbrPostcode());	
			pstmt.setString(5, member.getMbrAddress());
			pstmt.setString(6, member.getMbrDetailAddress());
			pstmt.setString(7, member.getMbrGender());
			pstmt.setString(8, member.getMbrBirth());
			pstmt.setString(9, member.getMbrId());
			
			result = pstmt.executeUpdate();	
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		} 
		
		return result;
	}// end of public int updateMember(MemberVO member) throws SQLException{} -----------------------------


	// 비밀번호 찾기 부분 
	@Override
	public boolean isUserExist(Map<String, String> paraMap) throws SQLException {

		boolean isUserExist = false;
		
		try {
			
			conn = ds.getConnection();   // date source 에서 가져옴
			
			String sql = " select member_id "
					   + " from tbl_member "
					   + " where member_status = 1 and member_id = ?  and member_name = ? and member_email = ? ";
			
			
			// 우편배달부
			pstmt = conn.prepareStatement(sql);
						
			// 위치 홀더
			pstmt.setString(1, paraMap.get("memberFindPwdId"));
			pstmt.setString(2, paraMap.get("memberFindPwdName"));   //name 키값을써서 name 을 가져오자	
			pstmt.setString(3, aes.encrypt(paraMap.get("memberFindPwdEmail")) );  // email 키 값을 써서 email 을 가져올껀데 암호화가 되어 있으므로 암호화 하여 비교한다.
			
			rs = pstmt.executeQuery();
			
			
			isUserExist = rs.next();    // 다음 행이 있느냐 ? 있으면 true 없으면 false
			
					
		} catch ( GeneralSecurityException | UnsupportedEncodingException e) {			// 오류 두개를 같이 잡을때 | 는 or를 뜻한다.
			e.printStackTrace();
		} finally {
			close();
		}
		
		
		return isUserExist;
	}



	// 포인트 정보 찾기 
	@Override
	public List<MemberPointDTO> selectPoint(Map<String, String> paraMap) {
		
		List<MemberPointDTO> PointList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();     // return 타입 connection   이렇게 하면 자기 오라클 DB와 붙는다. 
			
			String sql = " SELECT rn, to_char(point_date,'yyyy-mm-dd') as point_date, point_reason, point_change_type , point_change, point_after "
					   + "FROM ( "
					   + "  SELECT ROW_NUMBER() OVER (ORDER BY point_date DESC) AS rn, point_date, point_reason, point_change_type, point_change, point_after "
				       + "  FROM member_point_history "
				  	   + "  WHERE point_member_id = ? ";
					   
			String select_type = paraMap.get("pointSelect");
			
			
			if( "1".equals(select_type)) {
				sql += " and point_change_type = 1 ";
			}
			else if("2".equals(select_type)) {
				sql += " and point_change_type = 0 ";
			}

			sql += " order by point_date desc "
			    + "  ) "
			    + " WHERE rn BETWEEN ? AND ? ";
				
			pstmt = conn.prepareStatement(sql);
			
			
			int ShowPageNo = Integer.parseInt(paraMap.get("ShowPageNo"));		
			
			
			
			pstmt.setString(1, paraMap.get("id"));
			pstmt.setInt(2, (ShowPageNo * 5) - (5 - 1) );
			pstmt.setInt(3, (ShowPageNo * 5) );
			
			// 우편 배달부
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				
				MemberPointDTO mpdto = new MemberPointDTO();
				
				mpdto.setPoint_date(rs.getString("point_date"));      // 포인트 변동 날짜 
				mpdto.setPoint_reason(rs.getString("point_reason"));   // 포인트 변동 이유
				mpdto.setPoint_change_type(rs.getInt("point_change_type"));   // 포인트 지급 차감 
				mpdto.setPoint_change(rs.getInt("point_change"));   // 포인트 변동 포인트
				mpdto.setPoint_after(rs.getInt("point_after"));   // 포인트 보유 포인트
				
				
				
	            PointList.add(mpdto);	
				
			} // end of while(rs != null) {
			
			
		} catch(SQLException e) {
			e.getStackTrace();
		}finally {
			close();
		}
		
		return PointList;
	}

	// 페이징 처리 토탈 페이지 알아오기 
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String select_type = paraMap.get("pointSelect");
			
			
			String sql = " select ceil(count(*) / ? ) "   //보여줄 페이지 개수를 넣는 위치홀더
					   + " from member_point_history "
					   + " where POINT_MEMBER_ID = ? ";
			
			if( "1".equals(select_type)){
				sql += " and point_change_type = 1 ";
			}
			else if("2".equals(select_type)){
				sql += " and point_change_type = 0 ";
			}
				
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1,"5");
			pstmt.setString(2, paraMap.get("id"));
			
			rs = pstmt.executeQuery();
			
			
			rs.next();   // 이건 무조건 필요한 것이다.
			
			
			totalPage =  rs.getInt(1);
			
			
		} finally { 
			close();
		}
			
			
		return totalPage;
		
		
		
		
	}



}
