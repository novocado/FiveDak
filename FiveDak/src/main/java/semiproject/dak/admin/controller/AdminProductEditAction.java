package semiproject.dak.admin.controller;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.BrandDTO;
import semiproject.dak.product.model.CategoryDTO;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.ProductDAO;
import semiproject.dak.product.model.ProductDTO;
import semiproject.dak.product.model.ReviewDTO;

public class AdminProductEditAction extends AbstractController {
	
	private ResultSet rs;

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod(); // get or post
		
		String message = "";
		String loc = "";
		
		if("POST".equalsIgnoreCase(method)) {   // *** POST 방식으로 넘어온 것이라면 *** //
		
			int prodNum = Integer.parseInt(request.getParameter("prodNum")); // 제품번호
			String prodName = request.getParameter("prodName"); // 제품명
			int fk_prodCateNum = Integer.parseInt(request.getParameter("fk_prodCateNum")); // 제품 카데고리 코드(번호)
			int fk_prodBrandNum = Integer.parseInt(request.getParameter("fk_prodBrandNum")); // 제품 브랜드 코드(번호)
			int prodPrice = Integer.parseInt(request.getParameter("prodPrice")); // 정가
			int prodStock = Integer.parseInt(request.getParameter("prodStock")); // 재고 
			int prodDiscount = Integer.parseInt(request.getParameter("prodDiscount")); // 판매가
			
			ProductDTO pdto = new ProductDTO();
			
			pdto.setProdNum(prodNum);
			pdto.setProdName(prodName);
			pdto.setFk_prodCateNum(fk_prodCateNum);
			pdto.setFk_prodBrandNum(fk_prodBrandNum);
			pdto.setProdPrice(prodPrice);
			pdto.setProdStock(prodStock);
			pdto.setProdDiscount(prodDiscount);
			
			
		InterProductDAO pdao = new ProductDAO();
		int n = pdao.updateProduct(pdto);
		
		//json object 생성
		JSONObject jsonObj = new JSONObject();  
		
		jsonObj.put("n", n);   // {"n":1} 또는 {"n":-1} 또는 {"n":0}
		                       //정상이라면 n==1
		
		String json = jsonObj.toString();
		
		request.setAttribute("json", json);
		
		
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/views/jsonview.jsp");
		}
		else {			
			// *** "POST" 방식으로 넘어온 것이 아니라면 *** //
			message = "비정상적인 경로를 통해 들어왔습니다.";
			loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동한다
			
			request.setAttribute("message", message) ;
			request.setAttribute("loc", loc) ;
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/views/msg.jsp");
		}
		
		
		
	
		
	}		
	

}
