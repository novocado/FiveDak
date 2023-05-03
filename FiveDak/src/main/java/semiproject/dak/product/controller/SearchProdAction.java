package semiproject.dak.product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.ProductDAO;
import semiproject.dak.product.model.ProductDTO;


public class SearchProdAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 검색창에서 입력한 단어
		String searchWord = request.getParameter("searchWord");
		if ( searchWord == null ) {
			searchWord = "";
		}
		// 어떤 순서로 상품들을 보여줄 것인가 ?
		// 예 >> 평균별점 , 가격순 , 이름순대로 
		String orderBy = request.getParameter("orderBy");
		if ( orderBy == null || !("AVERAGE_RATING".equalsIgnoreCase(orderBy) || "PRODUCT_DISCOUNT".equalsIgnoreCase(orderBy) || "PRODUCT_SALES".equalsIgnoreCase(orderBy)) ) {
			orderBy = "AVERAGE_RATING"; 
		}
		
		// 내림차순으로 보여줄 것인가 ? 오름차순으로 보여줄 것인가 ?
		String orderWay = request.getParameter("orderWay");
		if ( orderWay == null || !("asc".equalsIgnoreCase(orderWay) || "desc".equalsIgnoreCase(orderWay))) {
			orderWay = "desc";
		}
			
		
		// *** 페이정 처리를 한 검색한 상품 보여주기 *** // 
		// 한 페이지에 보여주고자 하는 
		String sizePerPage = request.getParameter("sizePerPage");
		
		if ( sizePerPage == null || !("6".equals(sizePerPage) || "12".equals(sizePerPage) || "24".equals(sizePerPage)) ) {
			sizePerPage = "6" ;
		}
		
		 // 조회하고자하는 페이지번호
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		if ( currentShowPageNo == null  ) {
			currentShowPageNo = "1" ;
		}
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("searchWord", searchWord);
		paraMap.put("orderBy", orderBy);
		paraMap.put("orderWay", orderWay);
		paraMap.put("sizePerPage", sizePerPage);
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		// == GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 
		//    숫자가 아닌 문자를 입력한 경우 또는 숫자가 int의 범위를 벗어날 정도로 큰 경우에
		//    currentShowPageNo 는 1페이지로 만들도록 한다. 
		try {
			if ( Integer.parseInt(currentShowPageNo) < 1 ) {
				currentShowPageNo = "1";
				paraMap.put("currentShowPageNo", currentShowPageNo); // 조회하고자하는 페이지번호
			}
						
		}catch(NumberFormatException e) {
				currentShowPageNo = "1";
				paraMap.put("currentShowPageNo", currentShowPageNo); // 조회하고자하는 페이지번호
		}		
		
		InterProductDAO pdao = new ProductDAO();
		// 총 페이지를 알아오는 메소드 
		int totalPage = pdao.getTotalPage(paraMap);
		
		// 검색된 상품의 총 개수를 알아오는 메소드 
		int totalProduct = pdao.getTotalProduct(paraMap);
		
		//
		List<ProductDTO> prodList = pdao.selectPagingProduct(paraMap);
		
		request.setAttribute("searchWord", searchWord);
		request.setAttribute("orderBy", orderBy);
		request.setAttribute("orderWay", orderWay);
		request.setAttribute("sizePerPage", sizePerPage);
		request.setAttribute("currentShowPageNo", currentShowPageNo);
		request.setAttribute("totalProduct", totalProduct);
		request.setAttribute("prodList", prodList);
		
		String pageBar = "";
		int blockSize = 10 ;
		// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		
		int loop = 1 ;
		// loop 는 1부터 증가하여 1개 블럭을 이루는 페이지 번호의 개수( 지금은 10개 ) 까지만 증가하는 용도이다.
		
		//  pageNo  ==> ( (currentShowPageNo - 1)/blockSize ) * blockSize + 1 
		int pageNo = ( (Integer.parseInt(currentShowPageNo)-1)/blockSize)*blockSize + 1 ;
		// pageNo 는 페이지 바에서 첫번째로 보여지는 번호이다.
		
		// **** [맨처음][이전] 만들기 ***** //
		
		pageBar += "<li class='page-item'><a class='page-link' href='searchProd.dak?"
				+ "searchWord="+searchWord+"&currentShowPageNo="
				+1+"&sizePerPage="+sizePerPage+"&orderBy="+orderBy+"&orderWay="+orderWay
				+"'>맨처음</a></li>" ;
				
		
		if( pageNo != 1) {
				pageBar += "<li class='page-item'><a class='page-link' href='searchProd.dak?"
				+ "searchWord="+searchWord+"&currentShowPageNo="
				+(pageNo-1)+"&sizePerPage="+sizePerPage+"&orderBy="+orderBy+"&orderWay="+orderWay
				+"'>이전</a></li>" ;
		}
		// !( 반복을 빠져나가는 조건 ) => for 문을 사용할 경우, 밑에서 if 문을 통해, 전체페이지를 넘는 경우에 대해 조건을 설정해야 한다.
		while(!(loop > blockSize || pageNo > totalPage)  ) {
			// 현재 있는 페이지는 href 를 안 준 것이다. 굳이 필요하지 않기 때문에
			if (pageNo == Integer.parseInt(currentShowPageNo) ) {
				pageBar += "<li class='page-item active'><a class='page-link activeNo'>"+pageNo+"</a></li>" ;					
			}
			
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='searchProd.dak?"
						+ "searchWord="+searchWord+"&currentShowPageNo="
						+pageNo+"&sizePerPage="+sizePerPage+"&orderBy="+orderBy+"&orderWay="+orderWay
						+"'>"+pageNo+"</a></li>" ;
			
			}
			loop ++ ; // 1 2 3 4 5 6 7 8 ~ 10 
			pageNo ++ ; // 이게 증가해야 하는 이유 : 혼자 생각해보면, 위의 조건을 넣기 위해서 필요하다. 전체 페이지를 넘지 않는 조건을 생성하기 위해서
			
		}// end of while ~~~
		
		// **** [다음][마지막] 만들기 ***** //
		if( pageNo <= totalPage) {
			pageBar += "<li class='page-item'><a class='page-link' href='searchProd.dak?"
					+ "searchWord="+searchWord+"&currentShowPageNo="
					+pageNo+"&sizePerPage="+sizePerPage+"&orderBy="+orderBy+"&orderWay="+orderWay
					+"'>다음</a></li>" ;
		}
		
		pageBar += "<li class='page-item'><a class='page-link' href='searchProd.dak?"
				+"searchWord="+searchWord+"&currentShowPageNo="
				+totalPage+"&sizePerPage="+sizePerPage+"&orderBy="+orderBy+"&orderWay="+orderWay
				+"'>마지막</a></li>" ;
		
		
		request.setAttribute("pageBar", pageBar);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/product/prodList.jsp");
	}// END OF 	PUBLIC VOID EXECUTE(HTTPSERVLETREQUEST REQUEST, HTTPSERVLETRESPONSE RESPONSE) THROWS EXCEPTION {

	
	

}
