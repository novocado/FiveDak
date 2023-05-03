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
import semiproject.dak.member.model.MemberQNADTO;

public class Member1to1QNAAnswerAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
  		
		MemberDTO userid = (MemberDTO) session.getAttribute("loginuser");  // 세션값 가져오기 
		
		String id = userid.getMbrId();  // 세션값 String 타입으로 저장 
		
		
		// 페이징 처리를 위한 것 
		String ShowPage = request.getParameter("ShowPage");
		
		
		// 페이징 처리를 하기 위한 것 
		if(ShowPage == null) {
			ShowPage = "1";
		}
		
		try {
			if(Integer.parseInt(ShowPage) < 1) {    // 0 이하이면 1페이지로
				ShowPage = "1";
			}
		}
		catch(NumberFormatException e) {			// 문자로 장난칠 경우 1페이지로
			ShowPage = "1";
		}	

		InterMemberDAO mdao = new MemberDAO();
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("ShowPage", ShowPage);
		paraMap.put("id",id);
		
		
		int Show1to1TotalPage = mdao.Show1to1TotalPage(paraMap);
		
		System.out.println(Show1to1TotalPage);
		
		List<MemberQNADTO> QNAList = mdao.selectQNAList(paraMap);    // 메소드 생성
		
		System.out.println(QNAList);
	
		request.setAttribute("QNAList", QNAList);
		request.setAttribute("ShowPage", ShowPage);
		
		
		 // 페이지 바 부분 
		
		 String pageBar = "";
		  
		 int blockSize = 10; // blockSize 는 블럭(토막) 당 보여주는 페이지 번호의 개수이다. 
		 int loop = 1; 	
		 int pageNo  = ( ( Integer.parseInt(ShowPage) - 1)/blockSize ) * blockSize + 1;
		
		 pageBar += "<li class='page-item'><a class='page-link' href='1to1QNAAnswer.dak?ShowPage=1'>&lt;&lt;</a></li>"; 
		
		 if(pageNo != 1) {
		 	pageBar += "<li class='page-item'><a class='page-link' href='1to1QNAAnswer.dak?ShowPage="+(pageNo-1)+"'>[이전페이지]</a></li>"; 
	  	 }
		
		 while( !(loop > blockSize || pageNo > Show1to1TotalPage)) { 
			
			if(pageNo == Integer.parseInt(ShowPage)) {
				pageBar += "<li class='page-item active'><a style='background-color: #FF7E32; color:black; border-color : #FF7E32;' class='page-link' href= '#'>" + pageNo + "</a></li>";    
			}																
			else {
				pageBar += "<li class='page-item'><a style='color:black;' class='page-link' href='1to1QNAAnswer.dak?ShowPage="+pageNo+"'>" + pageNo + "</a></li>"; 
			}
			
			loop++;  
			
			pageNo++; 
			
		 } // end of while()~ 
		
		
		 if(pageNo <= Show1to1TotalPage) {
			pageBar += "<li class='page-item'><a class='page-link' href='1to1QNAAnswer.dak?ShowPage="+pageNo+"'>[다음페이지]</a></li>"; 
		 }

		 pageBar += "<li class='page-item'><a class='page-link' href='1to1QNAAnswer.dak?ShowPage="+Show1to1TotalPage+"'>&gt;&gt;</a></li>"; 
		
		
		
		 request.setAttribute("pageBar", pageBar);		
		 
		

		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/member/member1to1QNAAnswer.jsp");

	}

}
