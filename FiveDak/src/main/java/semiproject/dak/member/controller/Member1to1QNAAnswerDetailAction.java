package semiproject.dak.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.AdminQNADTO;
import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;
import semiproject.dak.member.model.MemberDTO;
import semiproject.dak.member.model.MemberQNADTO;

public class Member1to1QNAAnswerDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
  		
		MemberDTO userid = (MemberDTO) session.getAttribute("loginuser");  // 세션값 가져오기 
		
		String id = userid.getMbrId();  // 세션값 String 타입으로 저장 
		
		

		InterMemberDAO mdao = new MemberDAO();
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("id",id);
		
		
		
		
			
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/member/member1to1QNADetail.jsp");
		
		String method = request.getMethod();		// "GET" 또는 "POST"
		
		if("post".equalsIgnoreCase(method)) {	// POST 이라면   이따 post 로 바꾸기
			
			
			
			String qnaId = request.getParameter("qnaId");
            String qnauserid = request.getParameter("qnauserid");
            String qnacontent = request.getParameter("qnacontent");
            String qnatitle = request.getParameter("qnatitle");
            String qnacreated_at = request.getParameter("qnacreated_at");
	
            if(!id.equalsIgnoreCase(qnauserid)) {
            	
            	System.out.println("로그인 유저와 글쓴이가 같지 않습니다.");
            	super.setRedirect(false);
    			super.setViewPage("/WEB-INF/views/index.jsp");
            }
            
            else {
            	AdminQNADTO adminQnaDTO = mdao.getAdminQna(qnaId);
            	
            	request.setAttribute("adminQnaDTO", adminQnaDTO);
            	request.setAttribute("qnauserid", qnauserid);
            	request.setAttribute("qnaId", qnaId);
            	request.setAttribute("qnaId", qnaId);
            	request.setAttribute("qnacontent", qnacontent);
            	request.setAttribute("qnatitle", qnatitle);
            	request.setAttribute("qnacreated_at", qnacreated_at);
            	
            	
            	super.setRedirect(false);
    			super.setViewPage("/WEB-INF/views/member/member1to1QNADetail.jsp");
            }
			
		}
		
		else {
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/views/index.jsp");
		}


	}

}
