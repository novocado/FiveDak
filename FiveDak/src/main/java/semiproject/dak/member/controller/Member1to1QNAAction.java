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
import semiproject.dak.member.model.MemberQNADTO;

public class Member1to1QNAAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub

		String method = request.getMethod();
	      
	      if("POST".equalsIgnoreCase(method)) {
	    	 
	    	  HttpSession session = request.getSession();
	  		
	  		  MemberDTO userid = (MemberDTO) session.getAttribute("loginuser");  // 세션값 가져오기 
	  		
	  		  String id = userid.getMbrId();  // 세션값 String 타입으로 저장 
	    	  String select1to1 = request.getParameter("select1to1");
	    	  String title1to1 = request.getParameter("title1to1");
	    	  String contents = request.getParameter("contents");
	    	  
	    	  
	    	  Map<String, String> paraMap = new HashMap<>();  //Map 사용위해
	  		
	  		  paraMap.put("id", id);   // Map저장 
	  		  paraMap.put("select1to1",select1to1);
	  		  paraMap.put("title1to1", title1to1);
	  		  paraMap.put("contents", contents);
	  		  
	  		  InterMemberDAO mdao = new MemberDAO();
	  		  
	    	  
	    	  int n = mdao.goQNA(paraMap);
	    	  
	    	  if(n==1) {
	    		  
				String message = "문의하기 성공!!!";
				String loc = request.getContextPath() + "/index.dak";    
				
				request.setAttribute("message", message);		// 메세지를 나타내기 위해 
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/views/msg.jsp");			// 이 페이지로 이동시켜 실행 시킨다.
	    	  }
	    	  
	      }
	      else {
	    	  super.setRedirect(false);
	    	  super.setViewPage("/WEB-INF/views/member/member1to1QNA.jsp");
	      }
		
		
		
		
		
		
		
		
	}

}
