package semiproject.dak.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.InterOrderDAO;
import semiproject.dak.product.model.OrderDAO;
import semiproject.dak.product.model.OrderDTO;

public class AdminShowOrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String start = request.getParameter("start"); // "HIT"
		String len = request.getParameter("len"); // "HIT"
		String order_status = request.getParameter("order_status"); // 처음 loading 되면 null 값을 준다.
		if ( order_status == null ) {
			order_status = "";
		}
		String order_date = request.getParameter("order_date");
		if ( order_date == null ) {
			order_date = "";
		}
		InterOrderDAO ordao = new OrderDAO();
		Map<String,String> paraMap = new HashMap<>();
		
		String end = String.valueOf(Integer.parseInt(start)+Integer.parseInt(len) - 1 ) ;
		paraMap.put("start", start);
		paraMap.put("end", end ); // end ==> start + len - 1 ;
		paraMap.put("order_status", order_status);
		paraMap.put("order_date", order_date);
		
		List<OrderDTO> orderList = ordao.showAllOrder(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if (orderList.size() > 0 ) {
			for ( OrderDTO odto : orderList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("order_id", odto.getOrderId());
				jsonObj.put("order_member_id", odto.getFk_orderMbrId());
				jsonObj.put("order_serial", odto.getOrderSerial());
				jsonObj.put("order_total_price", odto.getOrderTotalPrice());
				jsonObj.put("shipping_address", odto.getOrderAddress());
				jsonObj.put("tracking_number", odto.getOrderTrackNo());
				jsonObj.put("recipmobile", odto.getRecipMobile());
				jsonObj.put("order_status", odto.getOrderStatus());
				jsonObj.put("order_date", odto.getOrderDate());
				jsonObj.put("status_name", odto.getOrderStatus_name());
				
				jsonArr.put(jsonObj);
			}// end of for 문
			
		}// end of if
		
		String json = jsonArr.toString();
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/jsonview.jsp");
		
	}

}
