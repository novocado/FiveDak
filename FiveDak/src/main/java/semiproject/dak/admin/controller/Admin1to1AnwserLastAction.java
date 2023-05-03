package semiproject.dak.admin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;
import semiproject.dak.member.model.MemberDTO;

public class Admin1to1AnwserLastAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
	      
	      if("POST".equalsIgnoreCase(method)) {
	    	 
	    	  HttpSession session = request.getSession();
	  		
	  		  MemberDTO userid = (MemberDTO) session.getAttribute("loginuser");  // 세션값 가져오기 
	  		
	  		  String id = userid.getMbrId();  // 세션값 String 타입으로 저장 
	    	  String contents = request.getParameter("contents");
	    	  String NumberNONO = request.getParameter("NumberNONO");
	    	  
	    	  Map<String, String> paraMap = new HashMap<>();  //Map 사용위해
	  		
	  		  paraMap.put("id", id);   // Map저장 
	  		  paraMap.put("contents", contents);
	  		  paraMap.put("NumberNONO", NumberNONO);
	  		  
	  		  InterMemberDAO mdao = new MemberDAO();
	  		  
	    	  
	    	  int n = mdao.AdmingoQNA(paraMap);
	    	  
	    	  if(n==1) {
	    		  
				String message = "답변하기 성공!!!";
				String loc = request.getContextPath() + "/admin/admin1to1Anwser.dak";    
				
				request.setAttribute("message", message);		// 메세지를 나타내기 위해 
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/views/msg.jsp");			// 이 페이지로 이동시켜 실행 시킨다.
	    	  }
	    	  else {
	    		  System.out.println("askjnfaksjdbgloj");
	    		  super.setRedirect(false);
	    		  super.setViewPage("/WEB-INF/views/admin/Admin1to1Anwser.jsp");
	    	  }
	    	  
	      }
	      else {
	    	  super.setRedirect(false);
	    	  super.setViewPage("/WEB-INF/views/admin/Admin1to1Anwser.jsp");
	      }
	      
		

	}

}
