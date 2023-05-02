package semiproject.dak.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.ProductDAO;

public class ProdDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String prodNum = request.getParameter("prodNum");
		String method = request.getMethod();
		
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
	
			InterProductDAO pdao = new ProductDAO();
			int n = pdao.deleteProd(prodNum);
			System.out.println(n);
			
			JSONObject jsobj = new JSONObject(); // {} => 자바스크립트 객체
			jsobj.put("n", n) ;  // { n , 1 }
			
			String json = jsobj.toString();
			request.setAttribute("json", json);
			System.out.println(json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/views/jsonview.jsp");
					
		}// end of else 
		
		
		
	}// END OF PUBLIC VOID EXECUTE(HTTPSERVLETREQUEST REQUEST, HTTPSERVLETRESPONSE RESPONSE) THROWS EXCEPTION {

}
