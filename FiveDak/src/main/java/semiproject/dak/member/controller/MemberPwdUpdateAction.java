package semiproject.dak.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;

public class MemberPwdUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();    // "GET" 또는 "POST" 
		
		System.out.println(method);
		
		String message = "";
		String loc = "";
		
		// 세션 사용 해서 userid 가져옴 
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		
		//세션 삭제 
		session.removeAttribute("userid");   /// 삭제하자 (userid 삭제) 꼭 하기 
		
		// 직접 uri 를 치고 들어오는 경우 
		if(userid == null ) {
			message=("장난치지 말고 비밀번호 찾기 및 변경을 통해 들어오도록 하거라");
			loc = request.getContextPath() + "/index.dak";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);	       // 값을 넘겨준다.
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/views/msg.jsp");
			return;
		}
		
		
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/member/pwdUpdate.jsp");

	}



}
