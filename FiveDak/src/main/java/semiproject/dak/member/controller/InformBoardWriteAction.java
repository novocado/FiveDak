package semiproject.dak.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;
import semiproject.dak.member.model.MemberDTO;

public class InformBoardWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		String message = "";
		String loc = "";
		
		HttpSession session = request.getSession();
		MemberDTO loginuser = (MemberDTO) session.getAttribute("loginuser");
		
		if ((loginuser != null && !loginuser.getMbrId().equals("admin")) || loginuser == null) {
			
			message = "관리자만 접속 가능한 페이지입니다.";
			loc = "javascript:history.back()";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else {
			super.setViewPage("/WEB-INF/views/InformBoard/write.jsp");
		}
		
		if("POST".equalsIgnoreCase(method)) {
			
			MultipartRequest mtrequest = null;
			
			String title = mtrequest.getParameter("notice_title");
			String content = mtrequest.getParameter("notice_content");
			content = content.replaceAll("<", "&lt;");
			content = content.replaceAll(">", "&gt;");
			content = content.replace("\r\n", "<br>");
			
			
			
			InterMemberDAO mdao = new MemberDAO();
			String seq = mdao.getSeqNo();
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("seq", seq);
			paraMap.put("title", title);
			paraMap.put("content", content);
			
			
			int n = mdao.boardWrite(paraMap);
			
			if(n==1) {
				message = "공지사항 등록이 완료되었습니다.";
				loc = request.getContextPath()+"/CSC/informBoardView.dak?num="+seq;

				request.setAttribute("message", message);
				request.setAttribute("loc", loc);

				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			else {
				message = "공지사항 등록이 실패하였습니다.";
				loc = "javascript:location.reload()";

				request.setAttribute("message", message);
				request.setAttribute("loc", loc);

				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
		
	}

}
