package semiproject.dak.product.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;
import semiproject.dak.member.model.MemberDTO;
import semiproject.dak.product.model.CheckoutDTO;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.OrderDTO;
import semiproject.dak.product.model.ProductDAO;

public class OrderEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			String msg = "비정상적인 접근입니다.";
			String loc = "javascript:history.back()";
			request.setAttribute("message", msg);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/views/msg.jsp");
		}
		
		String dataList = request.getParameter("paymentData");
		System.out.println(dataList);
		JSONObject jsonObject = new JSONObject(dataList);
		JSONArray cartIdsJSON = jsonObject.getJSONArray("cartIds");
		
		int[] cartIds = new int[cartIdsJSON.length()];
		for (int i = 0; i < cartIdsJSON.length(); i++) {
			cartIds[i] = cartIdsJSON.getInt(i);
		}
		
		InterProductDAO dao = new ProductDAO();
		
		CheckoutDTO checkout = dao.getCheckOutData(cartIds, request);
		OrderDTO orderinfo = new OrderDTO();
		HttpSession session = request.getSession();
		MemberDTO loginuser = (MemberDTO)session.getAttribute("loginuser"); 
		
		orderinfo.setFk_orderMbrId(loginuser.getMbrId());
		orderinfo.setOrderTotalPrice(jsonObject.getInt("totAmountPrice"));
		orderinfo.setOrderPoint(jsonObject.getInt("usePoint"));
		orderinfo.setOrderPostcode(jsonObject.getString("recipientPostcode"));
		orderinfo.setOrderAddress(jsonObject.getString("recipientAddress"));
		orderinfo.setOrderDetailAddress(jsonObject.getString("recipientDetailAddress"));
		orderinfo.setRecipName(jsonObject.getString("recipientName"));
		orderinfo.setRecipMobile(jsonObject.getString("recipientMobile"));
		orderinfo.setOrderMessage(jsonObject.getString("requestMsg"));
		
	
		
		Map<String, Object> orderMap = new HashMap<>();
		orderMap.put("checkout", checkout);
		orderMap.put("orderinfo", orderinfo);
		
		
		
		
		int n = dao.insertOrderInfo(orderMap);
		String message = "";
		String loc = "";
		if(n > 0) {
			InterMemberDAO mdao = new MemberDAO();
			mdao.updateMemberSession(session);
			message = "정상적으로 결제되었습니다.";
			loc = request.getContextPath() + "/index.dak";
		} else {
			message = "결제가 정상적으로 되었지만 주문 접수에 실패했습니다. 관리자에게 문의하세요.";
			loc = "javascript:history.back()";
		}
		
		request.setAttribute("message", message);
	    request.setAttribute("loc", loc);
	    super.setViewPage("/WEB-INF/views/msg.jsp");

		
		
		

	}

}
