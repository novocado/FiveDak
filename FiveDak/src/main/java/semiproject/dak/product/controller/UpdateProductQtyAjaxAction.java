package semiproject.dak.product.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.ProductDAO;

public class UpdateProductQtyAjaxAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			return;
		}
		
		String cartid = request.getParameter("cartid");
		String nqty = request.getParameter("nqty");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("cartid", cartid);
		paraMap.put("nqty", nqty);
		
		InterProductDAO dao = new ProductDAO();
		
		int n = dao.updateProductQty(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		String status = "";
		
		if(n == 1) {
			status = "succ";
		} else {
			status = "fail";
		}
		jsonObj.put("status", status);
		
		String json = jsonObj.toString();
		
		request.setAttribute("json", json);
		
		super.setViewPage("/WEB-INF/views/jsonview.jsp");
		

	}

}
