package semiproject.dak.member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.member.model.MemberDTO;
import semiproject.dak.product.model.*;

public class ProductReviewAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      
      HttpSession session = request.getSession();
      MemberDTO loginuser = (MemberDTO) session.getAttribute("loginuser");
      
      InterProductDAO pdao = new ProductDAO();
      
      
      String userid = loginuser.getMbrId();
      String page = "1";
      Map<String, String> paraMap = new HashMap<>();
      paraMap.put("userid", userid);
      paraMap.put("page", page);
      
      List<OrderDetailDTO> Reviewable = pdao.getReviewable(paraMap);
      List<OrderDetailDTO> Reviewed = pdao.getReviewed(paraMap);
      
      request.setAttribute("Reviewable", Reviewable);
      request.setAttribute("Reviewed", Reviewed);
      
      super.setViewPage("/WEB-INF/views/member/mypage_productReview.jsp");
   
      
   }

	}


