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
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import semiproject.dak.product.model.BrandDTO;
import semiproject.dak.product.model.OrderDTO;
import semiproject.dak.product.model.OrderDetailDTO;
import semiproject.dak.product.model.ProductDTO;
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
			String sql = " SELECT  MEMBER_NUM , MEMBER_ID , MEMBER_NAME , MEMBER_MOBILE , MEMBER_EMAIL , "+
					"		   MEMBER_POINT , MEMBER_GENDER , MEMBER_BIRTH , MEMBER_POSTCODE , MEMBER_ADDRESS , "+
					"		   MEMBER_DETAIL_ADDRESS , MEMBER_TIER_ID , MEMBER_REG_DATE , pwdchangegap "+
					"        , nvl(lastlogin_time , trunc( months_between(sysdate, registerday) , 0 )) AS lastlogin_gap, MEMBER_PURCHASE_AMOUNT, T.TIER_NAME, T.AMOUNT_NEEDED, T.REWARD_PERCENTAGE, T.TIER_IMAGE, "+
					" T2.tier_name AS next_tier_name, T2.amount_needed AS next_tier_amount "+
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
					" )H JOIN membership_tier T ON M.MEMBER_TIER_ID = T.TIER_ID "+
					" LEFT JOIN membership_tier T2 ON T.tier_id + 1 = T2.tier_id ";
			
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
				mbrTier.setNextTierName(rs.getString("NEXT_TIER_NAME"));
				mbrTier.setNextTierNeeded(rs.getInt("NEXT_TIER_AMOUNT"));
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
					   + " FROM ( "
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
	
	// 페이징 처리를 하기 위해 회원정보 목록 보기 
	@Override
	public int getShowMemberTotalPage(Map<String, String> paraMap)  throws SQLException {
		
		int ShowMemberTotalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String MemberSearch = paraMap.get("MemberSearch");
			
			String sql = " select ceil(count(*) / ? ) "   //보여줄 페이지 개수를 넣는 위치홀더
					   + " from tbl_member "
					   + " where MEMBER_ID != 'admin' ";
			
			if (!MemberSearch.equals("")) {
			   if (MemberSearch.contains("@")) {
			      // 이메일을 검색하는 쿼리를 추가
			      sql += " and Member_EMAIL like '%' || ? || '%'";
			   } else {
			      // 이름 또는 아이디를 검색하는 쿼리를 추가
			      sql += " and (MEMBER_NAME like '%' || ? || '%' or MEMBER_ID like '%' || ? || '%')";
			   }
			}
				
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1,"10");
			if (!MemberSearch.equals("")) {
			   if (MemberSearch.contains("@")) {
				  MemberSearch = aes.encrypt(MemberSearch);
			      pstmt.setString(2, MemberSearch);
			   } else {
			      pstmt.setString(2, MemberSearch);
			      pstmt.setString(3, MemberSearch);
			   }
			}
			
			rs = pstmt.executeQuery();
			
			
			rs.next();   // 이건 무조건 필요한 것이다.
			
			
			ShowMemberTotalPage =  rs.getInt(1);
			
			
		} catch ( GeneralSecurityException | UnsupportedEncodingException e) {			// 오류 두개를 같이 잡을때 | 는 or를 뜻한다.
			e.printStackTrace();
		}  finally { 
			close();
		}
			
			
		return ShowMemberTotalPage;
		
	}

	// 회원 목록 보기 
	@Override
	public List<MemberDTO> memberShowList(Map<String, String> paraMap) throws SQLException {
		
		List<MemberDTO> MemberShowList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();     // return 타입 connection   이렇게 하면 자기 오라클 DB와 붙는다. 
			
			String MemberSearch = paraMap.get("MemberSearch");
					
			String sql = " select Member_num, Member_id, Member_name, Member_Email, Member_Tier_ID "
				   	   + " from (  "
					   + "    select rownum AS RNO, Member_num, Member_id, Member_name, Member_Email, Member_Tier_ID "
					   + "    from ( "
					   + "        select Member_num, Member_id, Member_name, Member_Email, Member_Tier_ID "
					   + "        from tbl_Member "
					   + "        where Member_id != 'admin' ";
				
			
			if (!MemberSearch.equals("")) {
			   if (MemberSearch.contains("@")) {
			      // 이메일을 검색하는 쿼리를 추가			
			      sql += " and Member_EMAIL like '%' || ? || '%'";
			   } else {
			      // 이름 또는 아이디를 검색하는 쿼리를 추가
			      sql += " and (MEMBER_NAME like '%' || ? || '%' or MEMBER_ID like '%' || ? || '%')";
			   }
			}
			
			
			sql += " order by Member_Tier_ID desc, Member_Name asc "
			     + "         ) A "
				 + "     ) B "
				 + " WHERE RNO BETWEEN ? AND ? ";
				
			
			pstmt = conn.prepareStatement(sql);
			
			
			int ShowPage = Integer.parseInt(paraMap.get("ShowPage"));		
			
			
			
			
			if (!MemberSearch.equals("")) {
			   if (MemberSearch.contains("@")) {
			      // 이메일을 검색하는 쿼리를 추가
				   MemberSearch = aes.encrypt(MemberSearch);	
				   pstmt.setString(1, MemberSearch);
				   pstmt.setInt(2, (ShowPage * 10) - (10 - 1) );
				   pstmt.setInt(3, (ShowPage * 10) );
			   } else {
			      // 이름 또는 아이디를 검색하는 쿼리를 추가
				   pstmt.setString(1, paraMap.get("MemberSearch"));
				   pstmt.setString(2, paraMap.get("MemberSearch"));
				   pstmt.setInt(3, (ShowPage * 10) - (10 - 1) );
				   pstmt.setInt(4, (ShowPage * 10) );
			   }
			}
			else {
				pstmt.setInt(1, (ShowPage * 10) - (10 - 1) );
				pstmt.setInt(2, (ShowPage * 10) );
			}
			
			// 우편 배달부
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				
				MemberDTO mdto = new MemberDTO();
				
				mdto.setMbrNum(rs.getInt("Member_num"));
				mdto.setMbrId(rs.getString("Member_ID"));
				mdto.setMbrName(rs.getString("Member_name"));
				mdto.setMbrEmail(aes.decrypt(rs.getString("Member_Email"))); 
				mdto.setMbrTierId(rs.getInt("Member_Tier_ID")); 
				
				
				MemberShowList.add(mdto);	
				
				
			} // end of while(rs != null) {
			
			
		} catch(SQLException | GeneralSecurityException | UnsupportedEncodingException e) {
			e.getStackTrace();
		}finally {
			close();
		}
		
		
		
		return MemberShowList;
		
		
		
		
	}

	// 회원 정보 디테일하게 보기 위해 
	@Override
	public MemberDTO MemberShowDetail(String MemberId) throws SQLException {
		
		MemberDTO memberDetail = null;
		

		try {
			
			conn = ds.getConnection();
			
			String sql = " select MEMBER_NUM, MEMBER_ID, MEMBER_NAME, MEMBER_MOBILE, MEMBER_EMAIL, MEMBER_POINT, MEMBER_GENDER, MEMBER_BIRTH, MEMBER_POSTCODE "
					   + "		, MEMBER_ADDRESS, MEMBER_DETAIL_ADDRESS , MEMBER_TIER_ID  "
					   + "		, MEMBER_PURCHASE_AMOUNT , MEMBER_REG_DATE , MEMBER_STATUS, MEMBER_IDLE"
					   + " from tbl_Member "
					   + " where MEMBER_ID = ? ";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, MemberId);
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				memberDetail = new MemberDTO();
				
				memberDetail.setMbrNum(rs.getInt("MEMBER_NUM"));
				memberDetail.setMbrId(rs.getString("MEMBER_ID"));
				memberDetail.setMbrName(rs.getString("MEMBER_NAME"));
				memberDetail.setMbrMobile(aes.decrypt(rs.getString("MEMBER_MOBILE")));
				memberDetail.setMbrEmail(aes.decrypt(rs.getString("MEMBER_EMAIL")));
				memberDetail.setMbrPoint(rs.getInt("MEMBER_POINT"));
				memberDetail.setMbrGender(rs.getString("MEMBER_GENDER"));
				memberDetail.setMbrBirth(rs.getString("MEMBER_BIRTH"));
				memberDetail.setMbrPostcode(rs.getString("MEMBER_POSTCODE"));
				
				memberDetail.setMbrAddress(rs.getString("MEMBER_ADDRESS"));
				memberDetail.setMbrDetailAddress(rs.getString("MEMBER_DETAIL_ADDRESS"));
				memberDetail.setMbrTierId(rs.getInt("MEMBER_TIER_ID"));
				
				memberDetail.setMbrPurchaseAmount(rs.getInt("MEMBER_PURCHASE_AMOUNT"));
				memberDetail.setMbrRegDate(rs.getString("MEMBER_REG_DATE"));
				memberDetail.setMbrStatus(rs.getInt("MEMBER_STATUS"));
				memberDetail.setMbrIdle(rs.getInt("MEMBER_IDLE"));
				
				
			}// end of if(rs.next() }
			
				
				
		} catch ( GeneralSecurityException | UnsupportedEncodingException e) {			// 오류 두개를 같이 잡을때 | 는 or를 뜻한다.
			e.printStackTrace();
		} finally { 
			close();
		}
			
		
		
		return memberDetail;
	}

	@Override
	public List<MemberDTO> memberShowListPoint(Map<String, String> paraMap) throws SQLException {

		List<MemberDTO> MemberShowList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();     // return 타입 connection   이렇게 하면 자기 오라클 DB와 붙는다. 
			
			String MemberSearch = paraMap.get("MemberSearch");
					
			String sql = " select Member_num, Member_id, Member_name, Member_Email, Member_point "
				   	   + " from (  "
					   + "    select rownum AS RNO, Member_num, Member_id, Member_name, Member_Email, Member_point "
					   + "    from ( "
					   + "        select Member_num, Member_id, Member_name, Member_Email, Member_point "
					   + "        from tbl_Member "
					   + "        where Member_id != 'admin' ";
				
			
			if (!MemberSearch.equals("")) {
			   if (MemberSearch.contains("@")) {
			      // 이메일을 검색하는 쿼리를 추가			
			      sql += " and Member_EMAIL like '%' || ? || '%'";
			   } else {
			      // 이름 또는 아이디를 검색하는 쿼리를 추가
			      sql += " and (MEMBER_NAME like '%' || ? || '%' or MEMBER_ID like '%' || ? || '%')";
			   }
			}
			
			
			sql += " order by Member_Point desc, Member_Tier_ID desc, Member_Name asc "
			     + "         ) A "
				 + "     ) B "
				 + " WHERE RNO BETWEEN ? AND ? ";
				
			
			pstmt = conn.prepareStatement(sql);
			
			
			int ShowPage = Integer.parseInt(paraMap.get("ShowPage"));		
			
			
			
			
			if (!MemberSearch.equals("")) {
			   if (MemberSearch.contains("@")) {
			      // 이메일을 검색하는 쿼리를 추가
				   MemberSearch = aes.encrypt(MemberSearch);	
				   pstmt.setString(1, MemberSearch);
				   pstmt.setInt(2, (ShowPage * 10) - (10 - 1) );
				   pstmt.setInt(3, (ShowPage * 10) );
			   } else {
			      // 이름 또는 아이디를 검색하는 쿼리를 추가
				   pstmt.setString(1, paraMap.get("MemberSearch"));
				   pstmt.setString(2, paraMap.get("MemberSearch"));
				   pstmt.setInt(3, (ShowPage * 10) - (10 - 1) );
				   pstmt.setInt(4, (ShowPage * 10) );
			   }
			}
			else {
				pstmt.setInt(1, (ShowPage * 10) - (10 - 1) );
				pstmt.setInt(2, (ShowPage * 10) );
			}
			
			// 우편 배달부
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				
				MemberDTO mdto = new MemberDTO();
				
				mdto.setMbrNum(rs.getInt("Member_num"));
				mdto.setMbrId(rs.getString("Member_ID"));
				mdto.setMbrName(rs.getString("Member_name"));
				mdto.setMbrEmail(aes.decrypt(rs.getString("Member_Email"))); 
				mdto.setMbrPoint(rs.getInt("Member_Point")); 
				
				
				MemberShowList.add(mdto);	
				
				
			} // end of while(rs != null) {
			
			
		} catch(SQLException | GeneralSecurityException | UnsupportedEncodingException e) {
			e.getStackTrace();
		}finally {
			close();
		}
		
		
		
		return MemberShowList;
		
		
	}

	
	// 암호변경하기
	@Override
	public int pwdUpdate(MemberDTO mdto) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_member set MEMBER_PWD = ? "
					   + " 		 , LAST_PWD_CHANGED = sysdate "
					   + " where MEMBER_ID = ? ";
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, Sha256.encrypt(mdto.getMbrPwd())); // 암호를 Sha256 알고리즘으로 단방향 암호화 시킨다.
			pstmt.setString(2, mdto.getMbrId());
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}

	// *** 페이징 처리를 한 모든 공지사항 목록 보여주기 *** //
	@Override
	public List<NoticeBoardDTO> selectPagingMember(Map<String, String> paraMap) throws SQLException {
		
		List<NoticeBoardDTO> boardList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select * "
					   + " FROM "
					   + " ( "
					   + "    select rownum AS RNO, notice_id, notice_title, notice_content, to_char(notice_created_at,'yyyy-mm-dd') "
					   + "    from "
					   + "    ( "
					   + "        select * "
					   + "        from tbl_notice "; 
			
			String colname = paraMap.get("searchField");
			String searchText = paraMap.get("searchText");
			/*
			if("email".equals(colname)) {
				// 검색대상이 email인 경우
				searchWord = aes.encrypt(searchWord);
			}
			*/
			
			if(!"".equals(colname) && searchText != null && !searchText.trim().isEmpty()) {
				sql += " where " + colname + " like '%' || ? || '%' ";
				// 컬럼명과 테이블명은 위치홀더(?)로 사용하면 꽝!!이다.
				// 위치홀더(?)로 들어오는 것은 컬럼명과 테이블명이 아닌 오로지 데이터 값만 들어온다.
			}
			
			sql += " order by notice_id desc ) V "
				 + " ) T "
				 + " WHERE RNO between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo")); 	// 조회하고자하는 페이지번호
			int sizePerPage = 10;			// 한페이지당 보여줄 행의 개수
			
		/*
		    === 페이징 처리 공식 ===
		    where RNO between (조회하고자하는 페이지번호*한페이지당 보여줄 행의 개수) - (한페이지당 보여줄 행의 개수-1) and (조회하고자하는 페이지번호 * 한페이지당 보여줄 행의 개수);
		*/
			if(!"".equals(colname) && searchText != null && !searchText.trim().isEmpty()) {
				pstmt.setString(1, searchText);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			}
			
			else {
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage));
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeBoardDTO board = new NoticeBoardDTO();
				
				board.setNote_id(rs.getInt(2));
				board.setNote_title(rs.getString(3));
				board.setNote_content(rs.getString(4));
				board.setNote_created_at(rs.getString(5));
				
				
				
				boardList.add(board);
				
			} // end of while(rs.next())----------------------------------------
			
		} finally {
			close();
		}
		
		return boardList;
	}

	// 페이징 처리를 위한 검색이 있거나 없는 공지사항에 대한 총페이지 알아오기
	@Override
	public int getBoardTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int boardTotalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/?) "
					   + " from tbl_notice "; 
			
			String colname = paraMap.get("searchField");
			String searchText = paraMap.get("searchText");
			/*
			if("email".equals(colname)) {
				// 검색대상이 email인 경우
				searchText = aes.encrypt(searchText);
			}
			*/
			if(!"".equals(colname) && searchText != null && !searchText.trim().isEmpty()) {
				sql += " Where " + colname + " like '%' || ? || '%' ";
				// 컬럼명과 테이블명은 위치홀더(?)로 사용하면 꽝!!이다.
				// 위치홀더(?)로 들어오는 것은 컬럼명과 테이블명이 아닌 오로지 데이터 값만 들어온다.
			}
			
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, 10);
			
			if(!"".equals(colname) && searchText != null && !searchText.trim().isEmpty()) {
				pstmt.setString(2, searchText);
			}
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			boardTotalPage = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return boardTotalPage;
	}

	// 게시판 내용 보기
	@Override
	public NoticeBoardDTO informBoardView(String note_id) throws SQLException {
		
		NoticeBoardDTO boardContents = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select NOTICE_ID, NOTICE_TITLE, NOTICE_CONTENT, to_char(NOTICE_CREATED_AT,'yyyy-mm-dd') "
					   + " from tbl_notice "
		 		       + " where NOTICE_ID = ? "; 
			
			
			
			pstmt = conn.prepareStatement(sql);
			
			
			pstmt.setString(1, note_id);
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				boardContents = new NoticeBoardDTO();
				
				boardContents.setNote_id(Integer.parseInt(rs.getString(1)));
				boardContents.setNote_title(rs.getString(2));
				boardContents.setNote_content(rs.getString(3));
				boardContents.setNote_created_at(rs.getString(4));
				
			} // end of while(rs.next())----------------------------------------
			
		} finally {
			close();
		}
		
		return boardContents;
	}

	@Override
	public void updateMemberSession(HttpSession session) throws SQLException {
		
		
		try {
			
			conn = ds.getConnection(); 

			MemberDTO loginuser = ((MemberDTO)session.getAttribute("loginuser"));
			
			String sql = " SELECT m.*, t1.*, t2.tier_name AS next_tier_name, t2.amount_needed AS next_tier_amount "
					+ "FROM tbl_member m "
					+ "INNER JOIN membership_tier t1 ON m.member_tier_id = t1.tier_id "
					+ "LEFT JOIN membership_tier t2 ON t1.tier_id + 1 = t2.tier_id "
					+ "WHERE m.member_id = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginuser.getMbrId());
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				loginuser.setMbrMobile(aes.decrypt(rs.getString("MEMBER_MOBILE")));
				loginuser.setMbrEmail(aes.decrypt(rs.getString("MEMBER_EMAIL")));
				loginuser.setMbrPoint(rs.getInt("MEMBER_POINT"));
				loginuser.setMbrGender(rs.getString("MEMBER_GENDER"));
				loginuser.setMbrBirth(rs.getString("MEMBER_BIRTH"));
				loginuser.setMbrPostcode(rs.getString("MEMBER_POSTCODE"));
				loginuser.setMbrAddress(rs.getString("MEMBER_ADDRESS"));
				loginuser.setMbrDetailAddress(rs.getString("MEMBER_DETAIL_ADDRESS"));
				loginuser.setMbrPurchaseAmount(rs.getInt("MEMBER_PURCHASE_AMOUNT"));
				MembershipTierDTO tierDTO = new MembershipTierDTO();
				tierDTO.setTierId(rs.getInt("TIER_ID"));
				tierDTO.setRewardPercentage(rs.getInt("REWARD_PERCENTAGE"));
				tierDTO.setAmountNeeded(rs.getInt("AMOUNT_NEEDED"));
				tierDTO.setTierImage(rs.getString("TIER_IMAGE"));
				tierDTO.setNextTierName(rs.getString("NEXT_TIER_NAME"));
				tierDTO.setNextTierNeeded(rs.getInt("NEXT_TIER_AMOUNT"));
				loginuser.setMbrTier(tierDTO);
				session.setAttribute("loginuser", loginuser);

			}
					
		} catch ( GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		
	}

	// 글번호 시퀀스
	@Override
	public String getSeqNo() throws SQLException {
		
		String seq = "";
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT notice_id "
					   + " FROM( "
					   + "    SELECT "
					   + "        notice_id "
					   + "    FROM tbl_notice "
					   + "    ORDER BY ROWNUM DESC "
					   + " ) WHERE ROWNUM = 1 ";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			
			seq = rs.getString(1);
			
		} finally {
			close();
		}
		
		return seq;
	}

	// 공지사항 등록
	@Override
	public int boardWrite(Map<String, String> paraMap) throws SQLException {
		int n = 0;
		
		try {
			conn = ds.getConnection(); 
			
			String sql = " insert into tbl_notice(notice_title, notice_content, NOTICE_CREATED_AT) "
					   + " values(?, ?, TRUNC(SYSDATE)) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("title"));
			pstmt.setString(2, paraMap.get("content"));
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}

	// 공지사항 삭제
	@Override
	public int boardDelete(String noticeId) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection(); 
			
			String sql = " delete from tbl_notice where notice_id = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, noticeId);
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}
	
	
	// 회원마다 주문건수 찾기
		@Override
		public int CountOrder(String order_Member_count) throws SQLException {
			

			int result = 0;
			
			try {
				
				conn = ds.getConnection();
				
				String sql = " select count(*) "   //보여줄 페이지 개수를 넣는 위치홀더
						   + " from tbl_Order "
						   + " where ORDER_MEMBER_ID = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				
				pstmt.setString(1,order_Member_count);
				
				rs = pstmt.executeQuery();
				
				
				rs.next();   // 이건 무조건 필요한 것이다.
				
				
				result =  rs.getInt(1);
				
				
			} finally { 
				close();
			}
				
				
			return result;
			
			
		}

		// QNA 보내기 
		@Override
		public int goQNA(Map<String, String> paraMap) throws SQLException {
			
			int n = 0;
			
			try {
				
				conn = ds.getConnection();
				
				String sql = " insert into TBL_QNA(QNA_MEMBER_ID, QUESTION_TITLE, QUESTION_CONTENT, QUESTION_CREATED_AT) "
						   + " values(?, ?, ?, sysdate) ";

				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("id"));
				pstmt.setString(2, paraMap.get("title1to1"));
				pstmt.setString(3, paraMap.get("contents"));

				n = pstmt.executeUpdate();

				
			}finally {
				close();
			}
			
			return n;

		}

		// 문의하기 페이징바 처리 
		@Override
		public int Show1to1TotalPage(Map<String, String> paraMap) throws SQLException {
			
			int Show1to1TotalPage = 0;
			
			try {
				
				conn = ds.getConnection();
				
				String sql = " select ceil(count(*) / ? ) "   //보여줄 페이지 개수를 넣는 위치홀더
						   + " from tbl_qna  ";
				
				String id = paraMap.get("id");
				
				if(!"admin".equalsIgnoreCase(id)) {
					sql += " where QNA_MEMBER_ID = ? ";
				}
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, "5");
				
				if(!"admin".equalsIgnoreCase(id)) {
					pstmt.setString(2, id);
				}
				
				rs = pstmt.executeQuery();
				
				rs.next();   // 이건 무조건 필요한 것이다.
				
				Show1to1TotalPage =  rs.getInt(1);
				
				
			}finally { 
				close();
			}
				
				
			return Show1to1TotalPage;
			
		}
		
		// 문의하기 한것돌 가져오기 
		@Override
		public List<MemberQNADTO> selectQNAListAdmin(Map<String, String> paraMap) throws SQLException {
			
			List<MemberQNADTO> QNAList = new ArrayList<>();
			
			try {
				conn = ds.getConnection();     // return 타입 connection   이렇게 하면 자기 오라클 DB와 붙는다. 
			
				String sql = " select QNA_ID, QNA_MEMBER_ID, QUESTION_TITLE, QUESTION_CONTENT, QUESTION_CREATED_AT "
						   + " from (  select rownum AS RNO,QNA_ID, QNA_MEMBER_ID, QUESTION_TITLE, QUESTION_CONTENT, QUESTION_CREATED_AT "
						   + "        from ( select QNA_ID, QNA_MEMBER_ID, QUESTION_TITLE, QUESTION_CONTENT, QUESTION_CREATED_AT "
						   + "               from tbl_qna ";
				
				String id = paraMap.get("id");
				
				if(!"admin".equalsIgnoreCase(id)) {
					sql += " where QNA_MEMBER_ID = ? ";
				}
				sql += "               order by QUESTION_CREATED_AT asc "
					 + "               ) A "
					 + "      ) B "
					 + "where RNO BETWEEN ? and ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				int ShowPage = Integer.parseInt(paraMap.get("ShowPage"));	
				
				if(!"admin".equalsIgnoreCase(id)) {
					pstmt.setString(1, id);
					pstmt.setInt(2, (ShowPage * 5) - (5 - 1) );
					pstmt.setInt(3, (ShowPage * 5) );
				}
				else {
					pstmt.setInt(1, (ShowPage * 5) - (5 - 1) );
					pstmt.setInt(2, (ShowPage * 5) );
				}
				
				// 우편 배달부
				rs = pstmt.executeQuery();
				
				
				while(rs.next()) {     // 다음이 있으면 실행 
					
					MemberQNADTO qnadto = new MemberQNADTO();
					qnadto.setQNA_ID(rs.getInt("QNA_ID"));
					qnadto.setQNA_MEMBER_ID(rs.getString("QNA_MEMBER_ID"));
					qnadto.setQUESTION_TITLE(rs.getString("QUESTION_TITLE"));
					qnadto.setQUESTION_CONTENT(rs.getString("QUESTION_CONTENT"));
					qnadto.setQUESTION_CREATED_AT(rs.getString("QUESTION_CREATED_AT"));
					
					QNAList.add(qnadto);
				}  // end of while(rs.next())
				
				
			} finally {
				close();
			}
			
			return QNAList;
		}

		
		// 문의하기 페이징바 처리 
	      @Override
	      public int Show1to1TotalPageAdmin(Map<String, String> paraMap) throws SQLException {
	         
	         int Show1to1TotalPage = 0;
	         
	         try {
	            
	            conn = ds.getConnection();
	            
	            String sql = " select ceil(count(*) / ? ) "   //보여줄 페이지 개수를 넣는 위치홀더
	                     + " from tbl_qna  ";
	            
	            String id = paraMap.get("id");
	            
	            if(!"admin".equalsIgnoreCase(id)) {
	               sql += " where QNA_MEMBER_ID = ? ";
	            }
	            
	            pstmt = conn.prepareStatement(sql);
	            
	            pstmt.setString(1, "5");
	            
	            if(!"admin".equalsIgnoreCase(id)) {
	               pstmt.setString(2, id);
	            }
	            
	            rs = pstmt.executeQuery();
	            
	            rs.next();   // 이건 무조건 필요한 것이다.
	            
	            Show1to1TotalPage =  rs.getInt(1);
	            
	            
	         }finally { 
	            close();
	         }
	            
	            
	         return Show1to1TotalPage;
	         
	      }


	   // 문의하기 한것돌 가져오기 
	      @Override
	      public List<MemberQNADTO> selectQNAList(Map<String, String> paraMap) throws SQLException {
	         
	         List<MemberQNADTO> QNAList = new ArrayList<>();
	         
	         try {
	            conn = ds.getConnection();     // return 타입 connection   이렇게 하면 자기 오라클 DB와 붙는다. 
	         
	            String sql = " select QNA_ID, QNA_MEMBER_ID, QUESTION_TITLE, QUESTION_CONTENT, QUESTION_CREATED_AT , ANSWER_ID "
	            		+ " from (   "
	            		+ " select rownum AS RNO,QNA_ID, QNA_MEMBER_ID, QUESTION_TITLE, QUESTION_CONTENT, QUESTION_CREATED_AT  , ANSWER_ID"
	            		+ " from  "
	            		+ " ( select Q.QNA_ID, Q.QNA_MEMBER_ID, Q.QUESTION_TITLE, Q.QUESTION_CONTENT, Q.QUESTION_CREATED_AT  , A.ANSWER_ID  "
	            		+ " from tbl_qna Q LEFT JOIN TBL_QNA_ANSWER A "
	            		+ " ON Q.QNA_ID = A.QNA_ID  ";
	             
	            String id = paraMap.get("id");
	            if(!"admin".equalsIgnoreCase(id)) {
	               sql += " WHERE Q.QNA_MEMBER_ID = ? ";
	            }
	            sql += "               order by QUESTION_CREATED_AT desc "
	                + "               ) A "
	                + "      ) B "
	                + "where RNO BETWEEN ? and ? ";
	            
	            pstmt = conn.prepareStatement(sql);

	            int ShowPage = Integer.parseInt(paraMap.get("ShowPage"));   
	            
	            
	            if(!"admin".equalsIgnoreCase(id)) {
	               pstmt.setString(1, id);
	               pstmt.setInt(2, (ShowPage * 5) - (5 - 1) );
	               pstmt.setInt(3, (ShowPage * 5) );
	            }
	            else {
	               pstmt.setInt(1, (ShowPage * 5) - (5 - 1) );
	               pstmt.setInt(2, (ShowPage * 5) );
	            }
	            
	            // 우편 배달부
	            rs = pstmt.executeQuery();
	            
	            
	            while(rs.next()) {     // 다음이 있으면 실행 
	               
	               MemberQNADTO qnadto = new MemberQNADTO();
	               qnadto.setQNA_ID(rs.getInt("QNA_ID"));
	               qnadto.setQNA_MEMBER_ID(rs.getString("QNA_MEMBER_ID"));
	               qnadto.setQUESTION_TITLE(rs.getString("QUESTION_TITLE"));
	               qnadto.setQUESTION_CONTENT(rs.getString("QUESTION_CONTENT"));
	               qnadto.setQUESTION_CREATED_AT(rs.getString("QUESTION_CREATED_AT"));
	               if ( rs.getString("ANSWER_ID") == null) {
	            	   qnadto.setQUESTION_STATUS("미답변");
	               }
	               else {
	            	   qnadto.setQUESTION_STATUS("답변완료");
	               }
	               
	               QNAList.add(qnadto);
	            }  // end of while(rs.next())
	            
	            
	         } finally {
	            close();
	         }
	         
	         return QNAList;
	      }


	    // 문의하기 답변하기 
		@Override
		public int AdmingoQNA(Map<String, String> paraMap) throws SQLException {
			
			int n = 0;
			
			try {
				
				conn = ds.getConnection();
				
				String sql = " insert into tbl_qna_answer(QNA_ID, ANSWER_MEMBER_ID, ANSWER_CONTENT, ANSWER_CREATED_AT)"
						   + " values(?, ?, ?, sysdate) ";

				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("NumberNONO"));
				pstmt.setString(2, paraMap.get("id"));
				pstmt.setString(3, paraMap.get("contents"));

				n = pstmt.executeUpdate();

				
			}finally {
				close();
			}
			
			return n;

			
			
		}
		
		// 공지사항 수정
		@Override
		public int boardEdit(Map<String, String> paraMap) throws SQLException {
			
			int n = 0;
			
			try {
				conn = ds.getConnection(); 
				
				String sql = " update tbl_notice set notice_title = ?, notice_content = ? "
						   + " where notice_id = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, paraMap.get("title"));
				pstmt.setString(2, paraMap.get("content"));
				pstmt.setString(3, paraMap.get("seq"));
				
				n = pstmt.executeUpdate();
				
				
			} finally {
				close();
			}
			
			return n;
		}

		// 관리자 답변 보여주는 메소드
		@Override
		public AdminQNADTO getAdminQna(String qnaId) throws SQLException {
			AdminQNADTO qnadto = null ;
			try {
				
				conn = ds.getConnection();
				
				String sql = " select ANSWER_ID , QNA_ID , ANSWER_MEMBER_ID, ANSWER_CONTENT , ANSWER_CREATED_AT  "
						+ " from tbl_qna_answer  where QNA_ID = ?  ";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, qnaId);
				rs = pstmt.executeQuery();
				if ( rs.next()) {
					qnadto = new AdminQNADTO();
					qnadto.setANSWER_ID(rs.getInt("ANSWER_ID"));
					qnadto.setANSWER_MEMBER_ID(rs.getString("ANSWER_MEMBER_ID"));
					qnadto.setANSWER_CONTENT(rs.getString("ANSWER_CONTENT"));
					qnadto.setANSWER_CREATED_AT(rs.getString("ANSWER_CREATED_AT"));
				}
				
			}finally {
				close();
			}
			
			return qnadto ;
		}

		@Override
		public int getTotalQna() throws SQLException {
			int n = 0 ;
			try {
				
				conn = ds.getConnection();
				
				String sql = " SELECT COUNT(*) AS NOANSWERCOUNT "
						+ " FROM TBL_QNA Q "
						+ " LEFT JOIN TBL_QNA_ANSWER A "
						+ " ON Q.QNA_ID = A.QNA_ID "
						+ " WHERE A.QNA_ID IS NULL " ;
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				if (rs.next()) {
					n = rs.getInt(1);
				}
				
				
			}finally {
				close();
			}
			
			return n ;
		}

	

	

		@Override
		public int getOrderListTotalPage(Map<String, String> paraMap) throws SQLException {
			int totalOrder = 0;
			
			try {
				
				conn = ds.getConnection();
				
				
				String sql = " SELECT COUNT(*) FROM tbl_order "
						+ " WHERE order_member_id = ? AND order_date >= ? AND order_date <= ? ";

				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, paraMap.get("startdate"));
				pstmt.setString(3, paraMap.get("enddate"));
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					totalOrder = rs.getInt(1);
				}
				
				
				
				
			}finally { 
				close();
			}
				
				
			return totalOrder;
		}

		@Override
		public List<OrderDTO> getOrdersByDateRange(Map<String, String> paraMap) throws SQLException {
			List<OrderDTO> orders = new ArrayList<>();
			
			
			try {
				conn = ds.getConnection();
				String sql = " SELECT o.order_serial, to_char(o.order_date,'yyyy-mm-dd') as order_date , o.order_total_price , o.recipient_name, o.shipping_postcode, o.shipping_address, o.shipping_detail_address, o.recipient_mobile, o.order_message, o.order_status, od.order_detail_product_id, od.order_quantity, od.price_per_unit, od.review_status, p.product_name, p.product_image_url, p.product_brand_id, b.brand_name "
						+ "FROM tbl_order o "
						+ "JOIN tbl_order_detail od ON o.order_serial = od.fk_order_serial "
						+ "JOIN tbl_product p ON od.order_detail_product_id = p.product_id "
						+ "JOIN tbl_brand b ON p.product_brand_id = b.brand_id "
						+ "WHERE o.order_date >= ? AND o.order_date <= ? and o.order_member_id = ? "
						+ "AND o.order_serial IN ( "
						+ "  SELECT order_serial FROM ( "
						+ "    SELECT order_serial, ROW_NUMBER() OVER (ORDER BY order_serial DESC) AS row_num "
						+ "    FROM tbl_order "
						+ "    WHERE order_date >= ? AND order_date <= ? and order_member_id = ? "
						+ "  ) "
						+ "  WHERE row_num BETWEEN 0 AND 5 "
						+ ") "
						+ "ORDER BY o.order_serial DESC ";
				
				pstmt = conn.prepareStatement(sql);
				
				
				pstmt.setString(1, paraMap.get("startdate"));
				pstmt.setString(2, paraMap.get("enddate"));
				pstmt.setString(3, paraMap.get("userid"));
				pstmt.setString(4, paraMap.get("startdate"));
				pstmt.setString(5, paraMap.get("enddate"));
				pstmt.setString(6, paraMap.get("userid"));
				
				rs = pstmt.executeQuery();
				String currentOrderSerial = "";
				OrderDTO currentOrder = null;
				List<OrderDetailDTO> orderDetails = null;
				
				
				while(rs.next()) {
					String orderSerial = rs.getString("order_serial");
					
					if(!currentOrderSerial.equals(orderSerial)) {
						if (currentOrder != null) {
		                    currentOrder.setOrderdetailList(orderDetails);
		                    orders.add(currentOrder);
		                }
						currentOrderSerial = orderSerial;
						currentOrder = new OrderDTO();
						orderDetails = new ArrayList<>();
						currentOrder.setOrderSerial(orderSerial);
				        currentOrder.setOrderDate(rs.getString("order_date"));
				        currentOrder.setOrderTotalPrice(rs.getInt("order_total_price"));
				        currentOrder.setRecipName(rs.getString("recipient_name"));
				        currentOrder.setOrderPostcode(rs.getString("shipping_postcode"));
				        currentOrder.setOrderAddress(rs.getString("shipping_address"));
				        currentOrder.setOrderDetailAddress(rs.getString("shipping_detail_address"));
				        currentOrder.setRecipMobile(rs.getString("recipient_mobile"));
				        currentOrder.setOrderMessage(rs.getString("order_message"));
				        currentOrder.setOrderStatus(rs.getInt("order_status"));
					}
					
					
				    OrderDetailDTO orderDetailDTO = new OrderDetailDTO();
				    
				    orderDetailDTO.setOrderQuantity(rs.getInt("order_quantity"));
				    orderDetailDTO.setPricePerUnit(rs.getInt("price_per_unit"));
				    orderDetailDTO.setReviewStatus(rs.getInt("review_status"));
				    
				    ProductDTO prod = new ProductDTO();
				    prod.setProdNum(rs.getInt("order_detail_product_id"));
				    prod.setProdName(rs.getString("product_name"));
				    prod.setProdImage1(rs.getString("product_image_url"));
				    BrandDTO brand = new BrandDTO();
				    brand.setBrandName(rs.getString("brand_name"));
				    prod.setBrandDTO(brand);
				    orderDetailDTO.setOrderDetailProd(prod);
				    
				    orderDetails.add(orderDetailDTO);
				}
				if (currentOrder != null) {
		            currentOrder.setOrderdetailList(orderDetails);
		            orders.add(currentOrder);
		        }
				
				
			} finally {
				close();
			}
			
			
			return orders;
		}
		
		
		@Override
		public int confirmOrder(String orderserial) throws SQLException {
			int n = 0;
			
			try {
				conn = ds.getConnection();
				conn.setAutoCommit(false);
				
				pstmt = conn.prepareStatement("update tbl_order set order_status = 5 where order_serial = ?");
				
				pstmt.setString(1, orderserial);
				int updateresult = pstmt.executeUpdate();
				if (updateresult == 1) {
					pstmt = conn.prepareStatement("update tbl_order_detail set review_status = 1 where fk_order_serial = ?");
					pstmt.setString(1, orderserial);
					updateresult = pstmt.executeUpdate();
					if(updateresult > 0) {
						conn.commit();
						n = 1;
					}
				}
				conn.setAutoCommit(true);
				 
				
			} catch (SQLException e) {
				conn.rollback();
				conn.setAutoCommit(true);
				e.printStackTrace();
				
			} finally {
				close();
			}
					
			return n;
		}



}
