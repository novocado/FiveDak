package semiproject.dak.common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import semiproject.dak.member.model.MemberDTO;

public abstract class AbstractController implements InterCommand {
	
	private boolean isRedirect = false; 
	
	private String viewPage;

	public boolean isRedirect() {
		return isRedirect;
	}

	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}

	public String getViewPage() {
		return viewPage;
	}

	public void setViewPage(String viewPage) {
		this.viewPage = viewPage;
	}
	
	public boolean checkLogin(HttpServletRequest request) {
		
		HttpSession session = request.getSession();	// 세션에있는 로그인 유저를 불러오기위해 
		MemberDTO loginuser = (MemberDTO) session.getAttribute("loginuser");	// MemberDTO로 캐스팅
		
		if(loginuser != null) {
			// 로그인 한 경우
			return true;
		}
		else {
			// 로그인 안한 경우
			return false;
		}
		
	}// end of public boolean checkLogin(HttpServletRequest request) {}----------------------------------------
	
	
	
	
}
