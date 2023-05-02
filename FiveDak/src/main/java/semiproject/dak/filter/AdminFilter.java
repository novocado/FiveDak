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

import semiproject.dak.member.model.MemberDTO;
import semiproject.dak.product.model.InterOrderDAO;
import semiproject.dak.product.model.OrderDAO;
import semiproject.dak.product.model.ProductDAO;



/**
 * Servlet Filter implementation class AdminFilter
 */
@WebFilter("/admin/*")
public class AdminFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public AdminFilter() {
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
		HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession(false);
        MemberDTO mdto = (MemberDTO)session.getAttribute("loginuser") ;
        if (session == null || session.getAttribute("loginuser") == null) {
            HttpServletResponse httpResponse = (HttpServletResponse) response;
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.dak");
        } 
        else if( !"admin".equals(mdto.getMbrId()) ) {
        	String message = " 비정상적인 경로로 입장하셨습니다. 계속 시도하시면 불이익을 당하실 수도 있습니다.";
        	String loc = httpRequest.getContextPath() + "/index.dak" ;
        	request.setAttribute("message", message);
        	request.setAttribute("loc", loc);
        	request.getRequestDispatcher("/WEB-INF/views/msg.jsp").forward(request, response);
        }
        else {
        	try {
        		int percent = 0 ;
        		InterOrderDAO odao = new OrderDAO();
        		
        		// 한달간 전체 주문 상품 수 알아오기 
        		int sumMonthOrder = odao.getSumMonthOrder();
        				
        		// 한달간 현재 미 배송중인 주문 상품 수 알아오기
        		int sumNotShipped = odao.getSumNotShipped();
        				
        		// 한달간 현재 누적 판매액 
        		int sumTotalSales = odao.getSumTotalSales();
        		int successShipped = sumMonthOrder - sumNotShipped ;
        		if (  !(sumMonthOrder == 0 ) ) {
        			percent = (successShipped)*100 / sumMonthOrder ;         			
        		}
        		
        		request.setAttribute("sumMonthOrder", sumMonthOrder);
        		request.setAttribute("sumNotShipped", sumNotShipped);
        		request.setAttribute("sumTotalSales", sumTotalSales);
        		request.setAttribute("successShipped", successShipped);
        		request.setAttribute("percent", percent);
        	
        	
        	}catch(SQLException e) {
        		
        	}

        	
            chain.doFilter(request, response);
        }
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
