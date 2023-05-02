package semiproject.dak.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;
import semiproject.dak.member.model.MemberDTO;
import semiproject.dak.member.model.MemberPointDTO;
import semiproject.dak.product.model.InterOrderDAO;
import semiproject.dak.product.model.OrderDAO;

public class AdminShowMemberAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterMemberDAO mdao = new MemberDAO();
		
		// input 태그 를 가져옴 
		String MemberSearch = request.getParameter("MemberSearch");
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
		
		// 검색어가 null 이거나 공백만 있을경우 
		if(MemberSearch == null || 											
		  (MemberSearch != null && MemberSearch.trim().isEmpty())	) {
			MemberSearch = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("ShowPage", ShowPage);
		paraMap.put("MemberSearch", MemberSearch);
		
		
		int ShowMemberTotalPage = mdao.getShowMemberTotalPage(paraMap);
		
		List<MemberDTO> memberShowList = mdao.memberShowList(paraMap);
		
	
		
		request.setAttribute("memberShowList", memberShowList);
		request.setAttribute("MemberSearch", MemberSearch);
		request.setAttribute("ShowPage", ShowPage);
		
		
		 // 페이지 바 부분 
		
		 String pageBar = "";
		  
		 int blockSize = 10; // blockSize 는 블럭(토막) 당 보여주는 페이지 번호의 개수이다. 
		 int loop = 1; 	
		 int pageNo  = ( ( Integer.parseInt(ShowPage) - 1)/blockSize ) * blockSize + 1;
		
		 pageBar += "<li class='page-item'><a class='page-link' href='adminShowMember.dak?MemberSearch="+MemberSearch+"&ShowPage=1'>&lt;&lt;</a></li>"; 
		
		 if(pageNo != 1) {
		 	pageBar += "<li class='page-item'><a class='page-link' href='adminShowMember.dak?MemberSearch="+MemberSearch+"&ShowPage="+(pageNo-1)+"'>[이전페이지]</a></li>"; 
	  	 }
		
		 while( !(loop > blockSize || pageNo > ShowMemberTotalPage)) { 
			
			if(pageNo == Integer.parseInt(ShowPage)) {
				pageBar += "<li class='page-item active'><a style='background-color: #FF7E32; color:black; border-color : #FF7E32;' class='page-link' href= '#'>" + pageNo + "</a></li>";    
			}																
			else {
				pageBar += "<li class='page-item'><a style='color:black;' class='page-link' href='adminShowMember.dak?MemberSearch="+MemberSearch+"&ShowPage="+pageNo+"'>" + pageNo + "</a></li>"; 
			}
			
			loop++;  
			
			pageNo++; 
			
		 } // end of while()~ 
		
		
		 if(pageNo <= ShowMemberTotalPage) {
			pageBar += "<li class='page-item'><a class='page-link' href='adminShowMember.dak?MemberSearch="+MemberSearch+"&ShowPage="+pageNo+"'>[다음페이지]</a></li>"; 
		 }

		 pageBar += "<li class='page-item'><a class='page-link' href='adminShowMember.dak?MemberSearch="+MemberSearch+"&ShowPage="+ShowMemberTotalPage+"'>&gt;&gt;</a></li>"; 
		
		
		
		 request.setAttribute("pageBar", pageBar);		
		 
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/admin/adminShowMember.jsp");

	}

}
