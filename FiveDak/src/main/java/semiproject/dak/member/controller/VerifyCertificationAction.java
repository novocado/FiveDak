package semiproject.dak.member.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;

public class VerifyCertificationAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 사용자가 보내준 인증 코드이다.
		String userCertificationCode = request.getParameter("userCertificationCode");
		String userid = request.getParameter("userid");
		
		// 사용자에게 발급해준 코드와 사용자가 입력한 코드 비교하기 
		
		
		HttpSession session = request.getSession(); //세션 불러오기
		String certificationCode = (String) session.getAttribute("certificationCode");// 세션에 저장된 인증코드 가져오기
		
		String message = "";
		String loc = "";
		
		// certificationCode 와 userCertificationCode 가 같다면 
		if(certificationCode.equals(userCertificationCode)) {

			session.setAttribute("userid", userid);
			 
		    super.setRedirect(false);
		    response.sendRedirect(request.getContextPath() + "/memberPwdUpdate.dak");
		    return;
		}
		else {
			message="발급된 인증코드가 아닙니다. \\n 인증코드를 다시 발급받으세요!!";
			loc = request.getContextPath() + "/memberPwdFind.dak";					// 처음부터 다시 시작한다.
		}
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);	       // 값을 넘겨준다.
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/msg.jsp");
		
		
		
		//// !!!!!!!!!!! 중요 !!!!!!!!!!!!!! //
		
		// !! session(세션)에 저장된 인증코드 삭제하기 !! //
		session.removeAttribute("certificationCode");   /// 삭제하자 (인증코드 삭제) 꼭 하기 
		

	}

	private void alert(String string) {
		// TODO Auto-generated method stub
		
	}

}
