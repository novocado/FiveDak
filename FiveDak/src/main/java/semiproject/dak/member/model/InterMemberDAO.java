package semiproject.dak.member.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterMemberDAO {

	//Register Method
	boolean registerMember(MemberDTO dto) throws SQLException;

	boolean CheckDuplicateEmail(String email) throws SQLException;

	MemberDTO getMemberByLoginMap(Map<String, String> loginMap) throws SQLException;

	boolean CheckDuplicateID(String userid)  throws SQLException;
	
	// 아이디찾기에서 성명과 이메일로 아이디가 있는지 확인하기 위해 
	String findUserid(Map<String, String> paraMap) throws SQLException;

	// 비밀번호 찾기(아이디, 성명, 이메일을 입력받아서 해당 사용자가 존재하는지 유뮤를 알려준다.)
	boolean isUserExist(Map<String, String> paraMap) throws SQLException;
	
	int updateMember(MemberDTO member) throws SQLException;

	boolean passwdCheck(Map<String, String> paraMap) throws SQLException;


	// 포인트 정보 찾기
	List<MemberPointDTO> selectPoint(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리 토탈 페이지 알아오기 
	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	

}
