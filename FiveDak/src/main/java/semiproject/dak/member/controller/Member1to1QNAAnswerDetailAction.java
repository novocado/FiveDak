package semiproject.dak.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semiproject.dak.common.controller.AbstractController;

public class Member1to1QNAAnswerDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/member/member1to1QNADetail.jsp");

	}

}
