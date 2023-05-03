package semiproject.dak.member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.MemberDTO;
import semiproject.dak.product.model.*;

public class ReviewDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
	      
      if("POST".equalsIgnoreCase(method)) {
		
    	HttpSession session = request.getSession();  
    	MemberDTO loginuser = (MemberDTO)session.getAttribute("loginuser");
    	String userid = loginuser.getMbrId();
    	  
		String product_id = request.getParameter("product_id");
		String orderSerial = request.getParameter("orderSerial");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("userid", userid);
		paraMap.put("product_id", product_id);
		paraMap.put("orderSerial", orderSerial);
		
	    InterProductDAO pdao = new ProductDAO();
         
         int n = pdao.reviewDel(paraMap);
         
         JSONObject jsobj = new JSONObject();  
         jsobj.put("n", n);
         
         String json = jsobj.toString();  // 문자열 형태로 변환해줌.
         
         request.setAttribute("json", json);
         
         super.setRedirect(false);
         super.setViewPage("/WEB-INF/views/jsonview.jsp");
		
      }
      else {
	         // **** POST 방식으로 넘어온 것이 아니라면 **** //
	         
	         String message = "비정상적인 경로를 통해 들어왔습니다.!!";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setViewPage("/WEB-INF/views/msg.jsp");
	      }
   }
      

}
