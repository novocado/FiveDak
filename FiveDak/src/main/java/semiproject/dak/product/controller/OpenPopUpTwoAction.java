package semiproject.dak.product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semiproject.dak.common.controller.AbstractController;

public class OpenPopUpTwoAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		super.setViewPage("/WEB-INF/views/product/Approval_modal2.jsp");

	}

}