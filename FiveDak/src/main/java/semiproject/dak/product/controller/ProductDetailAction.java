package semiproject.dak.product.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.BrandDTO;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.NutritionDTO;
import semiproject.dak.product.model.ProductDAO;
import semiproject.dak.product.model.ProductDTO;

public class ProductDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String prodNum = request.getParameter("prodNum");
		String review_member_id = request.getParameter("review_member_id");
		
		InterProductDAO pdao = new ProductDAO() ;
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("prodNum", prodNum);
		paraMap.put("review_member_id", review_member_id);
		ProductDTO pdto = pdao.selectOneProduct(prodNum) ;
		
		String prodName = pdto.getProdName(); // 제품명
		int prodPrice = pdto.getProdPrice(); // 정가
		int prodStock = pdto.getProdStock();// 재고 
		int prodSales = pdto.getProdSales(); // 판매량
		int prodDiscount = pdto.getDiscountPercent(); // 판매가
		double prodAvgRating = pdto.getProdAvgRating(); // 평균 별점
		String prodImage1 = pdto.getProdImage1(); // 제품 이미지
		request.setAttribute("prodName", prodName);
		request.setAttribute("prodPrice", prodPrice);
		request.setAttribute("prodStock", prodStock);
		request.setAttribute("prodSales", prodSales);
		request.setAttribute("prodDiscount", prodDiscount);
		request.setAttribute("prodAvgRating", prodAvgRating);
		request.setAttribute("prodImage1", prodImage1);
		
		
		NutritionDTO ndto = pdao.nutritionInfo(prodNum);
		double product_cal = ndto.getProduct_cal();
	    double product_protein = ndto.getProduct_protein();
	    double product_sodium = ndto.getProduct_sodium();
	    double product_kal = ndto.getProduct_kal();
	    double product_fat = ndto.getProduct_fat();
	    double product_transfat = ndto.getProduct_transfat();
	    double product_satfat = ndto.getProduct_satfat();
	    double product_col = ndto.getProduct_col();
	    double product_sug = ndto.getProduct_sug();
		
	    request.setAttribute("product_cal", product_cal);
	    request.setAttribute("product_protein", product_protein);
	    request.setAttribute("product_sodium", product_sodium);
	    request.setAttribute("product_kal", product_kal);
	    request.setAttribute("product_fat", product_fat);
	    request.setAttribute("product_transfat", product_transfat);
	    request.setAttribute("product_satfat", product_satfat);
	    request.setAttribute("product_col", product_col);
	    request.setAttribute("product_sug", product_sug);
	    
	    
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/product/prodDetail.jsp");

	}

}
