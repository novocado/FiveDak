package semiproject.dak.member.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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

	// 암호변경
	int pwdUpdate(MemberDTO mdto) throws SQLException;

	// 페이징 처리를 하기 위해 회원정보 목록 보기 
	int getShowMemberTotalPage(Map<String, String> paraMap) throws SQLException;

	// 회원 목록 보기 
	List<MemberDTO> memberShowList(Map<String, String> paraMap) throws SQLException;

	// 회원 정보 디테일하게 보기 위해 
	MemberDTO MemberShowDetail(String MemberId) throws SQLException;
	
	// 회원 정보 포인트 부분 
	List<MemberDTO> memberShowListPoint(Map<String, String> paraMap) throws SQLException;

	// *** 페이징 처리를 한 모든 공지사항 목록 보여주기 *** //
	List<NoticeBoardDTO> selectPagingMember(Map<String, String> paraMap) throws SQLException;

	// 게시판 총페이지
	int getBoardTotalPage(Map<String, String> paraMap) throws SQLException;

	// 게시판 내용 보기
	NoticeBoardDTO informBoardView(String note_id) throws SQLException;

	// 멤버 세션 갱신
	void updateMemberSession(HttpSession session) throws SQLException;


	// 공지사항 글번호
	String getSeqNo() throws SQLException;

	// 공지사항 등록
	int boardWrite(Map<String, String> paraMap) throws SQLException;

	// 회원마다 주문건수 찾기
	int CountOrder(String order_Member_count) throws SQLException;


	// QNA 보내기 
	int goQNA(Map<String, String> paraMap)  throws SQLException;

	// 문의하기 한것돌 가져오기 
	List<MemberQNADTO> selectQNAList(Map<String, String> paraMap) throws SQLException;

	// 문의하기 페이징바 처리
	int Show1to1TotalPage(Map<String, String> paraMap) throws SQLException;
	
	
	// 문의하기 페이징바 처리 
	int Show1to1TotalPageAdmin(Map<String, String> paraMap) throws SQLException;
	
	// 문의하기 한것돌 가져오기 
	List<MemberQNADTO> selectQNAListAdmin(Map<String, String> paraMap) throws SQLException;

	// 문의하기 답변하기 
	int AdmingoQNA(Map<String, String> paraMap)  throws SQLException;

	
	
	
}
	