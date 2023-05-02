package semiproject.dak.common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ErrorController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//
		super.setViewPage("/WEB-INF/views/error/error.jsp");
		
		
	}

}
