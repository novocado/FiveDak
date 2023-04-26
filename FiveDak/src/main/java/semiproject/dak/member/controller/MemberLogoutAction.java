package semiproject.dak.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.MemberDTO;

public class MemberLogoutAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

				// 로그아웃 처리하기
				HttpSession session = request.getSession(); 
				
				MemberDTO loginuser = (MemberDTO) session.getAttribute("loginuser");
				
				session.invalidate();	

				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/index.dak");	
				
		
	}

}
