package semiproject.dak.member.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.*;

public class MemberEditInfoEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		String message = "";
		String loc = "";
		
		if("POST".equalsIgnoreCase(method)) { // POST방식으로 넘어온것이라면 
			
			String userid = request.getParameter("userid");
			String password = request.getParameter("password");
			String email = request.getParameter("email");
			String hp1 = request.getParameter("hp1");
			String hp2 = request.getParameter("hp2");
			String hp3 = request.getParameter("hp3");
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailAddress = request.getParameter("detailAddress");
			String gender = request.getParameter("gender");
			String birthyy = request.getParameter("birthyy");
			String birthmm = request.getParameter("birthmm");
			String birthdd = request.getParameter("birthdd");
			
			String mobile = hp1+hp2+hp3;
			String birthday = birthyy+birthmm+birthdd;
			
			MemberDTO member = new MemberDTO(userid, password, email, mobile, postcode, address, detailAddress, gender, birthday );
			
			
			try {
				InterMemberDAO mdao = new MemberDAO();
				int n = mdao.updateMember(member);
				
				if(n==1) {
					
					// !!! session 에 저장된 loginuser 를 변경된 사용자의 정보값으로 변경해주어야 한다.
					HttpSession session = request.getSession();
					MemberDTO loginuser= (MemberDTO) session.getAttribute("loginuser");
					
					loginuser.setMbrEmail(email);
					loginuser.setMbrMobile(mobile);
					loginuser.setMbrPostcode(postcode);
					loginuser.setMbrAddress(address);
					loginuser.setMbrDetailAddress(detailAddress);
					loginuser.setMbrGender(gender);
					loginuser.setMbrBirth(birthday);
					
					
					message = "회원정보가 정상적으로 변경되었습니다.";
					loc = request.getContextPath() + "/index.dak";
				}

			} catch(SQLException e) {
				message = "SQL구문 오류발생";
				e.printStackTrace();
			}
			
		}
		else {
			// POST 방식으로 넘어온 것이 아니라면 //
			message = "비정상적인 경로를 통해 들어왔습니다.!!";
			loc = "javascript:history.back()";
		}
		
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/msg.jsp");
		
	}

}
