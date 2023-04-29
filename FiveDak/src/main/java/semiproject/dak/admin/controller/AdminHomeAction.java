package semiproject.dak.admin.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.InterOrderDAO;
import semiproject.dak.product.model.OrderDAO;


public class AdminHomeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		InterOrderDAO odao = new OrderDAO() ;
		String order_status = request.getParameter("order_status");
		if ( order_status == null) {
			order_status = "";
		}
		String order_date = request.getParameter("order_date");
		if (order_date == null ) {
			order_date = "";
		}
		// System.out.println(order_status);
		
		// 한달간 전체 주문 상품 수 알아오기 
		int sumMonthOrder = odao.getSumMonthOrder();
		
		// 한달간 현재 미 배송중인 주문 상품 수 알아오기
		int sumNotShipped = odao.getSumNotShipped();
		
		// 한달간 현재 누적 판매액 
		int sumTotalSales = odao.getSumTotalSales();
		int successShipped = sumMonthOrder - sumNotShipped ;
		int percent = (successShipped)*100 / sumMonthOrder ; 
		
		// 페이징 처리시 필요한 해당 총 수 구해오기 
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("order_status", order_status);
		paraMap.put("order_date", order_date);
		
		int totalNo = odao.getTotalNo(paraMap);
		
		request.setAttribute("sumMonthOrder", sumMonthOrder);
		request.setAttribute("sumNotShipped", sumNotShipped);
		request.setAttribute("sumTotalSales", sumTotalSales);
		request.setAttribute("successShipped", successShipped);
		request.setAttribute("percent", percent);
		request.setAttribute("order_status", order_status);
		request.setAttribute("order_date", order_date);
		request.setAttribute("totalNo", totalNo);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/admin/mainAdmin.jsp");
		
	}

}
