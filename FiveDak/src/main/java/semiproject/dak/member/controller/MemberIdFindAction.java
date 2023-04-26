package semiproject.dak.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;

public class MemberIdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();    // "GET" 또는 "POST" 

		// POST 방식이라면 
		if("POST".equalsIgnoreCase(method)) {  
			
			String memberFindIdName = request.getParameter("memberFindIdName");
			String memberFindIdEmail = request.getParameter("memberFindIdEmail");
			
			//System.out.println(memberFindIdEmail);		
			
			//DB에 보내자 
			InterMemberDAO mdao = new MemberDAO();
			
			Map<String, String> paraMap = new HashMap<>();		// 맵에 저장하기 위해 선언
			
			paraMap.put("memberFindIdName", memberFindIdName);
			paraMap.put("memberFindIdEmail", memberFindIdEmail);		// Map 에 저장한다.
			
			
			String userid =  mdao.findUserid(paraMap); // 보내 주자 // 아이디 값이므로 리턴 값은 String
			
			//userid 값이 null 인지 판단 
			if(userid != null) {
				request.setAttribute("userid" , userid);     // request 영역에 저장 (값을 저장함)
			}
			else {   //userid가 null 이라면 
				request.setAttribute("userid" , "존재하지 않습니다."); // null 이므로 존재하지 않습니다를 저장 
			}
			
			
			request.setAttribute("memberFindIdName", memberFindIdName);			// POST 방식일때 이름, 이메일이 넘어간다.
			request.setAttribute("memberFindIdEmail", memberFindIdEmail);
			
			
			
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/views/member/Idfindresult.jsp");
			 
		}
		else {	
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/views/member/Idfind.jsp");
		}
		
	}

}
