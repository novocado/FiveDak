package semiproject.dak.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;

public class CheckDuplicateIdAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equals(method)) {
			String userid = request.getParameter("userid");
			InterMemberDAO dao = new MemberDAO();
			boolean isExists = dao.CheckDuplicateID(userid);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("isExists", isExists);
			String json = jsonObj.toString();
			request.setAttribute("json", json);
			
			
			super.setViewPage("/WEB-INF/views/jsonview.jsp");
		} else {
			String msg = "비정상적인 접근입니다.";
			String loc = "javascript:history.back()";
			request.setAttribute("message", msg);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/views/msg.jsp");
		}

	}
}
