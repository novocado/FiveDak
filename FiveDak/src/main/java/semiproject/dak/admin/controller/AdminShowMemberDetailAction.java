package semiproject.dak.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;
import semiproject.dak.member.model.MemberDTO;

public class AdminShowMemberDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String MemberId = request.getParameter("MemberId");
		//System.out.println(MemberId);
		
		InterMemberDAO mdao = new MemberDAO();
		
		MemberDTO mdto = mdao.MemberShowDetail(MemberId);
		
		request.setAttribute("mdto", mdto);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/admin/adminShowMemberDetail.jsp");

	}

}
