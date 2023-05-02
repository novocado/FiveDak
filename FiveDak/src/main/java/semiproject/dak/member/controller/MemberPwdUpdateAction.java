package semiproject.dak.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.MemberVO;
import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;
import semiproject.dak.member.model.MemberDTO;

public class MemberPwdUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();    // "GET" 또는 "POST" 
		
		System.out.println(method);
		
		String message = "";
		String loc = "";
		
		// 세션 사용 해서 userid 가져옴 
		HttpSession session  = request.getSession();
		MemberDTO loginuser = (MemberDTO) session.getAttribute("loginuser");
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		
		 
		System.out.println(userid);
		System.out.println(pwd);
		 
		//세션 삭제 session.removeAttribute("userid"); /// 삭제하자 (userid 삭제) 꼭 하기
		 
		
		/*
		// 직접 uri 를 치고 들어오는 경우 
		if(userid == null ) { 
			message=("장난치지 말고 비밀번호 찾기 및 변경을 통해 들어오도록 하거라"); 
			loc = request.getContextPath() + "/index.dak";
		
			request.setAttribute("message", message); request.setAttribute("loc", loc);
			// 값을 넘겨준다.
		
			super.setRedirect(false); super.setViewPage("/WEB-INF/views/msg.jsp");
			return; 
		}
		*/
		if("POST".equalsIgnoreCase(method)) {
			// 암호변경하기 버튼을 클릭한 경우
		//	String userid = request.getParameter("userid");
			String newPwd = request.getParameter("pwd");
		
		//	CustomerDAO dao = new CustomerDAO();
			
			
			
			InterMemberDAO mdao = new MemberDAO();
			
			int updateCount = mdao.pwdUpdate(userid, newPwd);
			/* int n = mdao.pwdUpdate(dto);
			
			request.setAttribute("n", n); */
			
			try {
				if(updateCount != 0) {
					
					super.setRedirect(false);
					//super.setViewPage("/WEB-INF/login/registerAfterAutoLogin.jsp");  
					// 임시조치 login 메소드 구현후 재수정
					
					message = "비밀번호변경이 성공했습니다.";
					loc = request.getContextPath() + "/index.dak";
				} else {
					
					message = "비밀번호변경에 실패했습니다.";
					loc = "javascript:history.back()";
					
				}
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/views/msg.jsp");
			} catch (Exception e) {
				e.printStackTrace();
				
				System.out.println("SQL 에러 // MemberPwdUpdateAction");
			}
			
		}
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/member/pwdUpdate.jsp");

	}



}
