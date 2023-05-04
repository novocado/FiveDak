package semiproject.dak.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;
import semiproject.dak.member.model.MemberDTO;
import semiproject.dak.member.model.NoticeBoardDTO;

public class InformBoardEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberDTO loginuser = (MemberDTO) session.getAttribute("loginuser");
		
		String message = "";
		String loc = "";
		
		if ((loginuser != null && !loginuser.getMbrId().equals("admin")) || loginuser == null) {
			
			message = "관리자만 접속 가능한 페이지입니다.";
			loc = "javascript:history.back()";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else {
			
			String note_id = request.getParameter("num");
			
			InterMemberDAO mdao = new MemberDAO();
			NoticeBoardDTO ndto = mdao.informBoardView(note_id);
				
			if(ndto != null) {
				request.setAttribute("ndto", ndto);
			}
			
			super.setViewPage("/WEB-INF/views/InformBoard/edit.jsp");
			
		}
		
		
	}

}
