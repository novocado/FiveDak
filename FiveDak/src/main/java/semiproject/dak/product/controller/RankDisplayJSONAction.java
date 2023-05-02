package semiproject.dak.product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.ProductDAO;
import semiproject.dak.product.model.ProductDTO;

public class RankDisplayJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String start = request.getParameter("start");
		String len = request.getParameter("len");
		String listType = request.getParameter("listType");
		
		if("".equals(listType)) {
			listType = "product_sales";
		}
		
	//	System.out.println("확인용 : " + listType);
		
		InterProductDAO pdao = new ProductDAO();
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("start", start);
		paraMap.put("listType", listType);
		
		String end = String.valueOf(Integer.parseInt(start)  + Integer.parseInt(len) - 1);
		paraMap.put("end", end);
		
		List<ProductDTO> prodList = pdao.selectByRank(paraMap);
		
		//System.out.println("prodList" +prodList);
		
		JSONArray jsonArr = new JSONArray();
		if(prodList.size() > 0) {
			// DB에서 조회해 온 결과물이 있을 경우
			
			for(ProductDTO pdto : prodList) {
				JSONObject jsonObj = new JSONObject();  		  // {} 이렇게만들어줌	예를들어 pnum이 36번인 제품을 보면
				jsonObj.put("rno", pdto.getProdRno()); 			 
				jsonObj.put("product_id", pdto.getProdNum());   		 
				jsonObj.put("product_name", pdto.getProdName());
				jsonObj.put("product_category_id", pdto.getCateDTO().getCateId());		  
				jsonObj.put("category_name", pdto.getCateDTO().getCateName());		 
	            jsonObj.put("brand_name", pdto.getBrandDTO().getBrandName());		 
	            jsonObj.put("product_price", pdto.getProdPrice());				 
	            jsonObj.put("product_sales", pdto.getProdSales());			 
	            jsonObj.put("product_discount", pdto.getProdDiscount());	 
	            jsonObj.put("average_rating", pdto.getProdAvgRating());  
	            jsonObj.put("product_image_url", pdto.getProdImage1());
	            
	            jsonArr.put(jsonObj); // [{}]
	            					  // [{},{}]
	            					  // [{},{},{}]
			}// end of for -----------------------
		} // end of if(prodList.size() > 0)---------------------------------------
		
		String json = jsonArr.toString(); 
		
	//	System.out.println("json" +json);
		
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/jsonview.jsp");
	}

}
