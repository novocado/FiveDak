package semiproject.dak.product.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.NutritionDTO;
import semiproject.dak.product.model.ProductDAO;
import semiproject.dak.product.model.ProductDTO;

public class ProductDetailAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      String prodNum = request.getParameter("prodNum");
      
      InterProductDAO pdao = new ProductDAO() ;
      
      Map<String,String> paraMap = new HashMap<>();
      
      paraMap.put("prodNum", prodNum);
      
      ProductDTO pdto = pdao.prodInfo(paraMap) ;
      request.setAttribute("pdto", pdto);      
      double percent = pdto.getAveragePercent() ;
      request.setAttribute("percent", percent);
      
      NutritionDTO ndto = pdao.nutritionInfo(prodNum);
      request.setAttribute("ndto", ndto);
      
      
      super.setRedirect(false);
      super.setViewPage("/WEB-INF/views/product/prodDetail.jsp");
      
      

   }

}