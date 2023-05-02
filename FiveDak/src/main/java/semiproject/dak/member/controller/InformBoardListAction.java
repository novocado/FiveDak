package semiproject.dak.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;
import semiproject.dak.member.model.MemberDTO;
import semiproject.dak.common.controller.AbstractController;

public class InformBoardListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterMemberDAO mdao = new MemberDAO();
		
		String searchType = request.getParameter("searchType");	
		// 회원목록 페이지로 보여줄때 즉, 처음에는 넘어오는 값이 없다. 그러므로 searchType 에는 NULL 이 들어온다.
		// 회원목록 페이지에서 "검색" 버튼을 클릭 시 넘어온다. 그러므로 searchType 에는 NULL이 아닌 어떤 값이 들어온다.
		
		String searchWord = request.getParameter("searchWord");	
		// 회원목록 페이지로 보여줄때 즉, 처음에는 넘어오는 값이 없다. 그러므로 searchWord 에는 NULL 이 들어온다.
		// 회원목록 페이지에서 "검색" 버튼을 클릭 시 넘어온다. 그러므로 searchWord 에는 NULL이 아닌 어떤 값이 들어온다.
		
		
		if(searchType == null ||
				  (!"name".equals(searchType) && 
				   !"userid".equals(searchType) && 
				   !"email".equals(searchType))) {
					searchType = "";
				}
		if(searchWord == null ||
				(searchWord != null && searchWord.trim().isEmpty())) {
			searchWord = "";
		}
		
		
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		
		
		// *** 페이징 처리를 안한 모든 회원 또는 검색한 회원 목록 보여주기 *** //
	/*	
		List<MemberVO> memberList = mdao.selectMember(paraMap);
	*/
		// === 페이징 처리를 한 모든 회원 또는 검색한 회원 목록 보여주기 === //
		String currentShowPageNo = request.getParameter("currentShowPageNo");			
		// currentShowPageNo 는 사용자가 보고자하는 페이지바의 페이지번호이다.
		// 메뉴에서 회원목록 만을 클릭했을 경우에는 currentShowPageNo 는 null 이 된다.
		// currentShowPageNo 가 null 이라면 currentShowPageNo 를 1 페이지로 바꾸어야 한다.
		
		String sizePerPage = request.getParameter("sizePerPage");
		// 한 페이지당 화면상에 보여줄 회원의 개수
		// 메뉴에서 회원목록 만을 클릭했을 경우에는 sizePerPage 는 null 이 된다.
		// sizePerPage 가 null 이라면 sizePerPage 를 10 으로 바꾸어야 한다.
		// "10" 또는 "5" 또는 "3"
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		if(sizePerPage == null ||
			!("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage))) {
			sizePerPage = "10";
		}
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는
		//	   int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다.
		//	   또한 currentShowPageNo	이 0 이하이면 currentShowPageNo 는 1 페이지로 만들도록 한다.
		try {
			if(Integer.parseInt(currentShowPageNo) < 1) {
				currentShowPageNo = "1";
			}
		} catch(NumberFormatException e) {
			currentShowPageNo = "1";
		}
		
		
		
		paraMap.put("currentShowPageNo", currentShowPageNo);	// 조회하고자하는 페이지번호
		paraMap.put("sizePerPage", sizePerPage); 				// 한페이지당 보여줄 행의 개수
		
		// 페이징 처리를 위한 검색이 있거나 없는 전체회원에 대한 총페이지 알아오기
		int totalPage = mdao.getTotalPage(paraMap);
	//	System.out.println("확인 totalPage => " + totalPage);
		
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에
		//	   totalPage 보다 큰 값을 입력하여 장난친 경우에는 1페이지로 가게끔 막아주기
		if(Integer.parseInt(currentShowPageNo) > totalPage) {
			currentShowPageNo = "1";
			paraMap.put("currentShowPageNo", currentShowPageNo);
		}
		
		
		List<MemberDTO> memberList = mdao.selectPagingMember(paraMap);
		
		request.setAttribute("memberList", memberList);
		
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchWord", searchWord);
		request.setAttribute("sizePerPage", sizePerPage);
		
		
		//////////////////////////////////////////////////////////////////////////////

		
		String pageBar = "";
		
		int blockSize = 10;
		// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		
		int loop = 1;
		// loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(현재는 10개)까지만 증가하는 용도이다.
		
		// !!! 다음은 pageNo 를 구하는 공식이다. !!! //
		int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
		// pageNo 는 pageBar 에서 보여지는 첫번째 번호이다.
		
		/////////////////////////////////////////////////////////////////////////
		
		// *** [맨처음][이전] 만들기 *** //
		
		pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1&sizePerPage="+sizePerPage+"'>[맨처음]</a></li>";
		if(pageNo != 1) {
			pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'>[이전]</a></li>";
		}
		
		while(!(loop > blockSize || pageNo > totalPage)) {
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>" + pageNo + "</a></li>";
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>" + pageNo + "</a></li>";
			}
			loop++; 	// 1 2 3 4 5 6 7 8 9 10
			
			pageNo++;	// 1  2  3  4  5  6  7  8  9  10
						// 11 12 13 14 15 16 17 18 19 20
		} // end of while()
		
		
		// *** [다음][마지막] 만들기 *** //
		if(pageNo <= totalPage) {
			pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>[다음]</a></li>";
		}
		pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"'>[마지막]</a></li>";
		
		
		request.setAttribute("pageBar", pageBar);
		
		super.setRedirect(false);
		
		super.setViewPage("/WEB-INF/views/InformBoard/list.jsp");
		
	}

}
