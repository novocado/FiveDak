package semiproject.dak.product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.*;

public class RankingListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// System.out.println("~~ 확인용 : "+average_rating);

		String listType = request.getParameter("listType");
		if(listType == null) {
			listType ="";
		}
		
		InterProductDAO pdao = new ProductDAO();
		int totalHITCount = pdao.totalCount();
		
		request.setAttribute("totalHITCount", totalHITCount);
		request.setAttribute("listType", listType);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/product/rankingList.jsp");
		
		
		
	}

}
