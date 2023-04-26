package semiproject.dak.member.controller;

import java.util.*;

import javax.servlet.http.*;
import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.*;

public class MemberPwdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();    // "GET" 또는 "POST" 
		
		System.out.println(method +"비ㅣㄹ번호");
		

		// POST 방식이라면 
		if("POST".equalsIgnoreCase(method)) {  
			
			String memberFindPwdId = request.getParameter("memberFindPwdId");
			String memberFindPwdName = request.getParameter("memberFindPwdName");
			String memberFindPwdEmail = request.getParameter("memberFindPwdEmail");
			
			request.setAttribute("memberFindPwdEmail", memberFindPwdEmail);

			InterMemberDAO mdao = new MemberDAO();
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("memberFindPwdId", memberFindPwdId);
			paraMap.put("memberFindPwdName", memberFindPwdName);
			paraMap.put("memberFindPwdEmail", memberFindPwdEmail);
			
			
			
			boolean isUserExist = mdao.isUserExist(paraMap);
			
			System.out.println(isUserExist);
			
			boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도 
			
				//true 일 경우
				if(isUserExist) {
					
					// 회원으로 존재하는 경우
					
					
					// 인증코드(인증키)를 랜덤하게 생성하도록 한다.
					Random rnd = new Random();
					
					String certificationCode = "";
					// 인증코드(인증키)는 영문소문자 5글자 + 숫자 7글자로 만들겠습니다.
					// 예 : certificationCode ==> dngrn4745003 
					
					for(int i =0; i<5; i++)
					{
						/*
			                min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면 
			                int rndnum = rnd.nextInt(max - min + 1) + min;
			                   영문 소문자 'a' 부터 'z' 까지 랜덤하게 1개를 만든다.     
						 */   
						
						char rndchr = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
						
						certificationCode += rndchr;   // 값을 받아와서 쌓는다.
				
					} // end of for 
					
					for(int i =0; i<7; i++)			// 숫자 랜덤하게 뽑아오기 
					{
						int rndnum = rnd.nextInt(9 - 0 + 1) + 0;
				
						certificationCode += rndnum;   // 값을 받아와서 쌓는다.
						
					} // end of for 
					
					//System.out.println("확인용 : certificationCode => " + certificationCode );
					// 결과 예시 : 확인용 : certificationCode => avpqh1428896
					
					
					// 랜덤하게 생성한 인증코드(certificationCode)를 비밀번호 찾기를 하고자 하는 사용자의 email 로 전송시킨다.
					GoogleMail mail = new GoogleMail();
					
					
					try {
						mail.sendmail(memberFindPwdEmail, certificationCode);		// sendmail 메소드 만들것 email에 인증코드를 보내주기 위해  email과 certificationCode를 보내준다.
						// 위 코드가 성공이면 다음 코드 실행 
						sendMailSuccess = true;     // 메일 전송이 성공했음을 기록함 
						
						
						// 메일이 정상적으로 갔으면 세션불러오기
						HttpSession session = request.getSession();
						session.setAttribute("certificationCode", certificationCode);
						// !!!! 발급한 인증코드를 세션에 저장시킴 !!!!!
						
						
					} catch(Exception e) {
						System.out.println("=== 메일 전송이 실패함 ㅠㅠ===");
						e.printStackTrace();
						sendMailSuccess = false;     // 메일 전송이 실패했음을 기록함 
					}
	
				
				
				
				
			}// end of if(isUserExist) {
			
			request.setAttribute("isUserExist", isUserExist); // 회원이 있든 없든 결과물을 보내주자 
			request.setAttribute("memberFindPwdId", memberFindPwdId);
			request.setAttribute("memberFindPwdName", memberFindPwdName);
			request.setAttribute("memberFindPwdEmail", memberFindPwdEmail);
			request.setAttribute("sendMailSuccess", sendMailSuccess);
			
			
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/views/member/pwdFindLast.jsp");
			
		}
		else {	
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/views/member/pwdFind.jsp");
		}
		
		
		

	}

}
