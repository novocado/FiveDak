package semiproject.dak.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;
import semiproject.dak.member.model.MemberDTO;
import semiproject.dak.member.model.MemberPointDTO;

public class MyPagePointAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		MemberDTO userid = (MemberDTO) session.getAttribute("loginuser");  // 세션값 가져오기 
		
		String id = userid.getMbrId();  // 세션값 String 타입으로 저장 
		String pointSelect = request.getParameter("pointSelect");
		String ShowPageNo = request.getParameter("ShowPageNo");  // 페이징 처리 하기 위한 것 
		
		// 기본 값을 1로 줘서 1페이지부터 보이게 한다.
		if(ShowPageNo == null) {
			ShowPageNo = "1";    
		}
		if(pointSelect == null) {
			pointSelect = "";    
		}
		
		try {
			if(Integer.parseInt(ShowPageNo) < 1) {    // 0 이하이면 1페이지로
				ShowPageNo = "1";
			}
		}
		catch(NumberFormatException e) {			// 문자로 장난칠 경우 1페이지로
			ShowPageNo = "1";
		}
		
		
		
		request.setAttribute("pointSelect", pointSelect);
		

		InterMemberDAO mdao = new MemberDAO();
		
		Map<String, String> paraMap = new HashMap<>();  //Map 사용위해
		
		paraMap.put("id", id);   // Map저장 
		paraMap.put("pointSelect",pointSelect);
		paraMap.put("ShowPageNo", ShowPageNo);// 조회하고자하는 페이지 번호 
		
		
		int totalPage = mdao.getTotalPage(paraMap);
		
		
		
		List<MemberPointDTO> memberPointList = mdao.selectPoint(paraMap);
		
		request.setAttribute("memberPointList", memberPointList);
		
		

		// 페이지 바 부분
		String pageBar = "";
		
		int blockSize = 5;   // blockSize 는 블럭(토막) 당 보여주는 페이지 번호의 개수이다.
		int loop = 1; 	
		int pageNo  = ( ( Integer.parseInt(ShowPageNo) - 1)/blockSize ) * blockSize + 1;
		
		pageBar += "<li class='page-item'><a class='page-link' href='point.dak?pointSelect="+pointSelect+"&ShowPageNo=1'>&lt;&lt;</a></li>"; 
		
		if(pageNo != 1) {
			pageBar += "<li class='page-item'><a class='page-link' href='point.dak?pointSelect="+pointSelect+"&ShowPageNo="+(pageNo-1)+"'>[이전페이지]</a></li>"; 
		}
		
		while( !(loop > blockSize || pageNo > totalPage)) { 
			
			if(pageNo == Integer.parseInt(ShowPageNo)) {
				pageBar += "<li class='page-item active'><a style='background-color: #FF7E32; color:black; border-color : #FF7E32;' class='page-link' href= '#'>" + pageNo + "</a></li>";    
			}																
			else {
				pageBar += "<li class='page-item'><a style='color:black;' class='page-link' href='point.dak?pointSelect="+pointSelect+"&ShowPageNo="+pageNo+"'>" + pageNo + "</a></li>"; 
			}
			
			loop++;  
			
			pageNo++; 
			
		} // end of while()~ 
		
		
		if(pageNo <= totalPage) {
			pageBar += "<li class='page-item'><a class='page-link' href='point.dak?pointSelect="+pointSelect+"&ShowPageNo="+pageNo+"'>[다음페이지]</a></li>"; 
		}

		pageBar += "<li class='page-item'><a class='page-link' href='point.dak?pointSelect="+pointSelect+"&ShowPageNo="+totalPage+"'>&gt;&gt;</a></li>"; 
		
		
		
		request.setAttribute("pageBar", pageBar);		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/member/mypagePoint.jsp");
	}

}
