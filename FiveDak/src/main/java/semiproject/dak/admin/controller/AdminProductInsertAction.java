package semiproject.dak.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.ProductDAO;

public class AdminProductInsertAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		InterProductDAO pdao = new ProductDAO();
		List<String> list = pdao.getCategoryList();
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/admin/productInsert.jsp");
		
		
		
		
	}

}
