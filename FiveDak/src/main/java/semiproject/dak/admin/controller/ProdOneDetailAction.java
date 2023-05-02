package semiproject.dak.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.ProductDAO;
import semiproject.dak.product.model.ProductDTO;

public class ProdOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String prodNum = request.getParameter("prodNum");
		
		InterProductDAO pdao = new ProductDAO();
		
		ProductDTO pdto = pdao.selectOneProduct(prodNum);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/admin/productDetail.jsp");

	}

}
