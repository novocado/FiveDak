package semiproject.dak.product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.MemberDTO;
import semiproject.dak.product.model.CartDTO;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.ProductDAO;

public class CartListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		
		MemberDTO loginuser = (MemberDTO)session.getAttribute("loginuser");
		String userid = loginuser.getMbrId();
		
		InterProductDAO dao = new ProductDAO();
		
		List<CartDTO> cartlist = dao.getCartList(userid);
		
		if(cartlist.size() == 0) {
			super.setViewPage("index.dak");
			return;
		}
		
		request.setAttribute("cartlist", cartlist);
		super.setViewPage("/WEB-INF/views/product/cartList2.jsp");

	}

}
