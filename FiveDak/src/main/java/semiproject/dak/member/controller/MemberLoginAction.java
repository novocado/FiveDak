package semiproject.dak.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;
import semiproject.dak.member.model.MemberDTO;

public class MemberLoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
        
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		super.setRedirect(false);
		
		if (member != null) {
			String message = "이미 로그인된 상태입니다.";
        	String loc = "javascript:history.back()";
        	
        	request.setAttribute("message", message);
        	request.setAttribute("loc", loc);
        	
        	
        	super.setViewPage("/WEB-INF/views/msg.jsp");
            return;
        } else {
        	super.setViewPage("/WEB-INF/views/member/login.jsp");
        }
		
		String method = request.getMethod();
        
        
        if ( "POST".equalsIgnoreCase(method)) {
	        //이미 로그인했을 때
	        
	        
	        // form에서 입력값 가져오기
	        String userid = request.getParameter("userid");
	        String pwd = request.getParameter("pwd");
	        
	        
	        
	        String clientip = request.getRemoteAddr();
	        
	        InterMemberDAO dao = new MemberDAO();
	        Map<String, String> loginMap = new HashMap<>();
	        loginMap.put("userid", userid);
	        loginMap.put("pwd", pwd);
	        loginMap.put("clientip", clientip);
	        
	        MemberDTO loginuser = dao.getMemberByLoginMap(loginMap);
	        
	        if (loginuser != null) {
	            
	        	//로그인 성공했을 때
	            session.setAttribute("loginuser", loginuser);
	            // 메인페이지로 보내기 추가
	            
	            if (loginuser.isRequirePwdChange()) {
					
					String message = "비밀번호를 변경하신지 3개월이 지났습니다. 암호를 변경하세요!!" ;
					String loc = request.getContextPath()+"/index.dak";
					// 원래는 위와 같이 index.up 이 아니라 휴면인 계정을 풀어주는 페이지로 잡아주어야 한다.
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				else { // 비밀번호를 변경한지 3개월 이내 인 경우
					super.setRedirect(true);
					super.setViewPage(request.getContextPath()+"/index.dak");					
				}
	        }  //로그인 성공
	        else {
	            // 로그인 실패 에러메시지 + 로그인창으로 돌아가기 추가
	        	String message = "로그인 실패하셨습니다";
	        	String loc = "javascript:history.back()";
	        	
	        	request.setAttribute("message", message);
	        	request.setAttribute("loc", loc);
	        	
	        	super.setRedirect(false);
	        	super.setViewPage("/WEB-INF/views/msg.jsp");
	        }  // 로그인 실패
        } // if post end
		
	}

}
