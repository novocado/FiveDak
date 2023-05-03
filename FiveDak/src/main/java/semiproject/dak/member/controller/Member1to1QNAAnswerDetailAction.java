package semiproject.dak.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;
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
		
		
		List<MemberQNADTO> QNAList = mdao.selectQNAList(paraMap);    // 메소드 생성
		
		System.out.println(QNAList);
	
		request.setAttribute("QNAList", QNAList);
		
		
			
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/member/member1to1QNADetail.jsp");

	}

}
