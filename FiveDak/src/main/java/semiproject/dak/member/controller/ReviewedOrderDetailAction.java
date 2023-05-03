package semiproject.dak.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.MemberDTO;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.OrderDetailDTO;
import semiproject.dak.product.model.ProductDAO;

public class ReviewedOrderDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		 
		  
		  HttpSession session = request.getSession();
	      MemberDTO loginuser = (MemberDTO) session.getAttribute("loginuser");
	      
	      InterProductDAO pdao = new ProductDAO();
	      String userid = loginuser.getMbrId();
	      String page = request.getParameter("page");
	      Map<String, String> paraMap = new HashMap<>();
	      paraMap.put("userid", userid);
	      paraMap.put("page", page);
	      
	      int blocksize = 5;
	      int totalReviewed = pdao.getTotalReviewed(userid);
	      int totalPage = (int) Math.ceil((double) totalReviewed / blocksize);
	      
	       
		  int startPage = ((Integer.parseInt(page) - 1)/blocksize) * blocksize + 1;
		  int endPage = Math.min(totalPage, startPage + blocksize - 1);
	      
		  request.setAttribute("totalPage", totalPage);
		  request.setAttribute("currentPage", Integer.parseInt(page));
		  request.setAttribute("startPage", startPage);
		  request.setAttribute("endPage", endPage);
		  request.setAttribute("totalReviewed", totalReviewed);
	      
	      
	      
	      List<OrderDetailDTO> reviewed = pdao.getReviewed(paraMap);
	      
	      request.setAttribute("reviewed", reviewed);
	      
	      super.setViewPage("/WEB-INF/views/member/mypage_productReview_reviewed.jsp");
	}

}
