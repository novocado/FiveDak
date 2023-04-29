package semiproject.dak.admin.controller;


import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.InterOrderDAO;
import semiproject.dak.product.model.OrderDAO;

public class AdminProfitAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		InterOrderDAO odao = new OrderDAO();		
		// 한달간 전체 주문 상품 수 알아오기 
		int sumMonthOrder = odao.getSumMonthOrder();
				
		// 한달간 현재 미 배송중인 주문 상품 수 알아오기
		int sumNotShipped = odao.getSumNotShipped();
				
		// 한달간 현재 누적 판매액 
		int sumTotalSales = odao.getSumTotalSales();
		int successShipped = sumMonthOrder - sumNotShipped ;
		int percent = (successShipped)*100 / sumMonthOrder ; 
				
		request.setAttribute("sumMonthOrder", sumMonthOrder);
		request.setAttribute("sumNotShipped", sumNotShipped);
		request.setAttribute("sumTotalSales", sumTotalSales);
		request.setAttribute("successShipped", successShipped);
		request.setAttribute("percent", percent);
				
		// SELECT SUM(price) FROM tbl_order WHERE order_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -1), 'MONTH') 
		// AND LAST_DAY(ADD_MONTHS(SYSDATE, -1));

	    super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/admin/AdminProfit.jsp");
		
		
		
	}

}
