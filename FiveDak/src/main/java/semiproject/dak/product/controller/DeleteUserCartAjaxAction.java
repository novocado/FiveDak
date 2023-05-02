package semiproject.dak.product.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.ProductDAO;

public class DeleteUserCartAjaxAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			return;
		}
		
		String cartNoList = request.getParameter("dataList");
		JSONArray jsonArray = new JSONArray(cartNoList);

		
		int[] cartIds = new int[jsonArray.length()];

		
		for (int i = 0; i < jsonArray.length(); i++) {
		    JSONObject jsonObject = jsonArray.getJSONObject(i);
		    int cartId = jsonObject.getInt("cartid");
		    cartIds[i] = cartId;
		}
		
		
		
		InterProductDAO dao = new ProductDAO();
		
		int n = dao.deleteUserCart(cartIds);
		
		JSONObject jsonObj = new JSONObject();
		String status = "";
		
		if(n > 0) {
			status = "succ";
		} else {
			status = "fail";
			jsonObj.put("message", "장바구니에서 선택하신 제품을 삭제하는 것에 실패했습니다.");
		}
		jsonObj.put("status", status);
		
		String json = jsonObj.toString();
		
		request.setAttribute("json", json);
		
		super.setViewPage("/WEB-INF/views/jsonview.jsp");

	}

}
