package semiproject.dak.member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.MemberDTO;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.OrderDTO;
import semiproject.dak.product.model.ProductDAO;

public class ReviewWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		
		
		if("post".equalsIgnoreCase(method)) {
			
			HttpSession session = request.getSession();
			MemberDTO loginuser = (MemberDTO) session.getAttribute("loginuser");
			
			String orderSerial = request.getParameter("orderSerial");
			String product_id = request.getParameter("product_id");
			String userid = loginuser.getMbrId();
			String rating = request.getParameter("rating");
			String contents = request.getParameter("contents");
			contents = contents.replaceAll("<", "&lt;");
			contents = contents.replaceAll(">", "&gt;");
			contents = contents.replaceAll("\r\n", "<br>");
			
			//System.out.println("orderSerial : " +orderSerial);
			//System.out.println("product_id : " +product_id);
			Map<String, String> paraMap = new HashMap<>();
			
			
			
			paraMap.put("orderSerial", orderSerial);
			paraMap.put("product_id", product_id);
			paraMap.put("userid", userid);
			paraMap.put("rating", rating);
			paraMap.put("contents", contents);
			
			
			InterProductDAO pdao = new ProductDAO();
			
			
			int n = pdao.addReview(paraMap);
			
			if(n == 1) {
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/views/member/mypage_productReview.jsp");
				
			}
		}
		
		else {
			
			String product_id = request.getParameter("product_id");
			String order_serial = request.getParameter("order_serial");
			
		
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("product_id", product_id);
			paraMap.put("order_serial", order_serial);
			
			
			InterProductDAO pdao = new ProductDAO();
			OrderDTO odto =  pdao.ProductOrderDetail(paraMap);
			request.setAttribute("odto", odto);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/views/member/mypage_ReviewWrite.jsp");
		
		}
		
		
		
	
		
	}

}
