package semiproject.dak.admin.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semiproject.dak.common.controller.AbstractController;

public class AdminProfitAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	    super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/admin/AdminProfit.jsp");
		
		
		
	}

}
