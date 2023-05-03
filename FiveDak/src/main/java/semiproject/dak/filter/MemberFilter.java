package semiproject.dak.filter;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import semiproject.dak.member.model.InterMemberDAO;
import semiproject.dak.member.model.MemberDAO;
import semiproject.dak.member.model.MemberDTO;
import semiproject.dak.product.model.OrderDTO;

/**
 * Servlet Filter implementation class MemberFilter
 */
@WebFilter("/mypage/*")
public class MemberFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public MemberFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		
		/*
		 * HttpServletRequest httpRequest = (HttpServletRequest) request; HttpSession
		 * session = httpRequest.getSession(false); MemberDTO mdto =
		 * (MemberDTO)session.getAttribute("loginuser"); OrderDTO odto = new OrderDTO();
		 * 
		 * 
		 * if (session == null || session.getAttribute("loginuser") == null) {
		 * HttpServletResponse httpResponse = (HttpServletResponse) response;
		 * httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.dak"); }
		 * else {
		 * 
		 * odto.setFk_orderMbrId(mdto.getMbrId());
		 * 
		 * String Order_Member_count = odto.getFk_orderMbrId();
		 * 
		 * InterMemberDAO mdao = new MemberDAO();
		 * 
		 * try { int order_count = mdao.CountOrder(Order_Member_count);
		 * request.setAttribute("order_count",order_count); } catch (SQLException e) {
		 * // TODO Auto-generated catch block e.printStackTrace(); }
		 * 
		 * 
		 * 
		 * 
		 * 
		 * 
		 * 
		 * 
		 * }
		 */
		
        chain.doFilter(request, response);
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
