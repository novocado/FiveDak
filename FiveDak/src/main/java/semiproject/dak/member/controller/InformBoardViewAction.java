package semiproject.dak.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;
import semiproject.dak.member.model.NoticeBoardDTO;
import semiproject.dak.common.controller.AbstractController;

public class InformBoardViewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String note_id = request.getParameter("num");
	//	System.out.println(note_id);
		
		InterMemberDAO mdao = new MemberDAO();
		NoticeBoardDTO ndto = mdao.informBoardView(note_id);
		
		if(ndto != null) {
			request.setAttribute("ndto", ndto);
		}
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/InformBoard/view.jsp");
		
		
	}

}
