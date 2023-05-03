package semiproject.dak.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;

public class InformBoardDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String noticeId = request.getParameter("Note_id");
		
		InterMemberDAO mdao = new MemberDAO();
		int n = mdao.boardDelete(noticeId);
		
		String message = "";
		String loc = "";
		
		if(n == 1) {
			message = "공지사항 삭제가 완료되었습니다.";
			loc = request.getContextPath() + "/CSC/informBoardList.dak";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/views/msg.jsp");
		}
		else {
			message = "공지사항 삭제를 실패하였습니다.";
			loc = request.getContextPath() + "/CSC/informBoardList.dak";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/views/msg.jsp");
		}
		
	}

}
