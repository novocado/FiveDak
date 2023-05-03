package semiproject.dak.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.MemberDTO;

public class Admin1to1QNAAnswerDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub

		String method = request.getMethod();		// "GET" 또는 "POST"
		
		if("post".equalsIgnoreCase(method)) {	// POST 이라면   이따 post 로 바꾸기
			
			String qnaId = request.getParameter("qnaId");
            String qnauserid = request.getParameter("qnauserid");
            String qnacontent = request.getParameter("qnacontent");
            String qnatitle = request.getParameter("qnatitle");
            String qnacreated_at = request.getParameter("qnacreated_at");
	

        	request.setAttribute("qnauserid", qnauserid);
        	request.setAttribute("qnaId", qnaId);
        	request.setAttribute("qnaId", qnaId);
        	request.setAttribute("qnacontent", qnacontent);
        	request.setAttribute("qnatitle", qnatitle);
        	request.setAttribute("qnacreated_at", qnacreated_at);
        	
        	
        	super.setRedirect(false);
    		super.setViewPage("/WEB-INF/views/admin/Admin1to1QNAAnswerDetail.jsp");

			
		}
		
		else {
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/views/index.jsp");
		}
		
	}

}
