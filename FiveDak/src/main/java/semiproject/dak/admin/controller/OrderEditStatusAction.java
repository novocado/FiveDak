package semiproject.dak.admin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.InterOrderDAO;
import semiproject.dak.product.model.OrderDAO;

public class OrderEditStatusAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String order_serial = request.getParameter("order_serial");
		String orderStatus = request.getParameter("orderStatus");
		String method = request.getMethod();
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("order_serial", order_serial);
		paraMap.put("orderStatus", orderStatus);
		
		if(!"POST".equalsIgnoreCase(method)) {
			// GET 방식이라면 
			String message = "비정상적인 경로로 들어왔습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/views/msg.jsp");
			return ;
			
		} // end of if
		
		else if("post".equalsIgnoreCase(method)){
			InterOrderDAO odao = new OrderDAO();
			int n = odao.goEditStatus(paraMap);
			
			JSONObject jsobj = new JSONObject(); // {} => 자바스크립트 객체
			jsobj.put("n", n) ;  // { n , 1 }
			
			String json = jsobj.toString();
			request.setAttribute("json", json);
			System.out.println(json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/views/jsonview.jsp");
					
		}// end of else 
		
		
		
	}

}
