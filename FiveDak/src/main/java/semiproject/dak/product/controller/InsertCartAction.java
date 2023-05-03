package semiproject.dak.product.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.MemberDTO;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.ProductDAO;

public class InsertCartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if ( "post".equalsIgnoreCase(method)) {
			HttpSession session = request.getSession();
			
			MemberDTO loginuser = (MemberDTO)session.getAttribute("loginuser");
			String userid = loginuser.getMbrId();
			
			InterProductDAO pdao = new ProductDAO();
			String prodNum = request.getParameter("prodNum");
			String oqty = request.getParameter("oqty");
			System.out.println(oqty);
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("prodNum", prodNum);
			paraMap.put("userid", userid);
			paraMap.put("oqty", oqty);
			String result = "false";
			int cartId = pdao.insertCartlist(paraMap);
			if ( cartId > 0 ) {
				result = "true";
			}
			
	        JSONObject jsobj = new JSONObject();  
	        jsobj.put("cartId", cartId);
	        jsobj.put("result", result);
	        String json = jsobj.toString();  // 문자열 형태로 변환해줌.
	         
	        request.setAttribute("json", json);
	         
	        super.setRedirect(false);
	        super.setViewPage("/WEB-INF/views/jsonview.jsp");
		}// end of if 
		
		else {
			 String message = "비정상적인 경로로 들어오셨습니다. 이 행위를 반복적으로 실행할 경우 불이익을 당하실 수 있습니다.";
             String loc = "javascript:history.back();";
             
             request.setAttribute("message", message);
             request.setAttribute("loc", loc);
             
             super.setRedirect(false);
             super.setViewPage("/WEB-INF/views/msg.jsp");
			
		}// end of else
	}

}
