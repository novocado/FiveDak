package semiproject.dak.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;
import semiproject.dak.member.model.MemberDTO;

public class MemberPwdUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		// 세션 사용 해서 userid 가져옴 
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		
		
		
		String message = "";
		String loc = "";
	
		//세션 삭제 session.removeAttribute("userid"); /// 삭제하자 (userid 삭제) 꼭 하기
		 
		// 직접 uri 를 치고 들어오는 경우 
		if(!"POST".equalsIgnoreCase(method) && userid == null) { 
			message=("장난치지 말고 비밀번호 찾기 및 변경을 통해 들어오십시오."); 
			loc = request.getContextPath() + "/index.dak";
		
			request.setAttribute("message", message); request.setAttribute("loc", loc);
			// 값을 넘겨준다.
		
			super.setRedirect(false); 
			super.setViewPage("/WEB-INF/views/msg.jsp");
			return; 
		}
		else {
			super.setRedirect(false); 
        	super.setViewPage("/WEB-INF/views/member/pwdUpdate.jsp");
        }
		
		System.out.println(method);
		
		if("POST".equalsIgnoreCase(method)) {
			// 암호변경하기 버튼을 클릭한 경우
			String pwd = request.getParameter("pwd");
		
			System.out.println(userid);
			System.out.println(pwd);
			
			MemberDTO mdto = new MemberDTO(userid, pwd);

			InterMemberDAO mdao = new MemberDAO();
			////////////////
			int updateCount = mdao.pwdUpdate(mdto);
			
			//세션 삭제 
			session.removeAttribute("userid");
			
			try {
				if(updateCount != 0) {
					
					request.setAttribute("userid", userid);
					request.setAttribute("pwd", pwd);
					
					super.setRedirect(false);
					
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
		
		/////////////////////////////////////////////

	}



}
