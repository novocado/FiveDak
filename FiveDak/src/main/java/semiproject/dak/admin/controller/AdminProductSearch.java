package semiproject.dak.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semiproject.dak.common.controller.AbstractController;
import semiproject.dak.product.model.InterProductDAO;
import semiproject.dak.product.model.ProductDAO;
import semiproject.dak.product.model.ProductDTO;

public class AdminProductSearch extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		InterProductDAO pdao = new ProductDAO();
		
			String searchType = request.getParameter("searchType"); // 회원명, 아이디 ,이메일
			String searchWord = request.getParameter("searchWord"); // 관리자가 검색창에 입력한 값!
			
			
			///////////////////////////////////////////////////////////////////////////////////////////////////////
			// SELECT 에서 선택하세요를 클릭하거나 GET 방식이므로 컬럼명의 아무거나 쳐서 들어올 경우를 막아주기 위함
			if(searchType == null ||
				 ( !"PRODUCT_NAME".equals(searchType) && !"BRAND_NAME".equals(searchType) && !"CATEGORY_NAME".equals(searchType))){
				searchType= "";
			}
			if(searchWord == null || (searchWord != null && searchWord.trim().isEmpty())) {
				searchWord = "";
			}
			
			/////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("searchWord", searchWord); 
			paraMap.put("searchType", searchType);
			
			Map<String,Integer> map = pdao.getTotalNum(paraMap);		
			 // 조회하고자하는 페이지번호
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			
			if ( currentShowPageNo == null  ) {
				currentShowPageNo = "1" ;
			}
			
			paraMap.put("currentShowPageNo", currentShowPageNo); // 조회하고자하는 페이지번호
			
			try {
				if ( Integer.parseInt(currentShowPageNo) < 1 ) {
					currentShowPageNo = "1";
					paraMap.put("currentShowPageNo", currentShowPageNo); // 조회하고자하는 페이지번호
				}
				
			}catch(NumberFormatException e) {
				currentShowPageNo = "1";
				paraMap.put("currentShowPageNo", currentShowPageNo); // 조회하고자하는 페이지번호
			}
			
			// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 제품에 대한 총 페이지 알아오기
			int totalPage = map.get("totalPage");
			
			// == GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 
			//    totalPage 보다 큰 값을 입력하여 장난친 경우에는 1페이지로 가게끔 막아주기
			if( Integer.parseInt(currentShowPageNo) > totalPage ) {
				currentShowPageNo = "1";
				paraMap.put("currentShowPageNo", currentShowPageNo); // 조회하고자하는 페이지번호
			}
			
			
			
			
			List<ProductDTO> prodList = pdao.selAllProduct(paraMap);
			
			request.setAttribute("prodList", prodList);
			request.setAttribute("searchWord", searchWord);
			request.setAttribute("searchType", searchType);
			
			
			String pageBar = "";
			int blockSize = 5 ;
			// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
			
			int loop = 1 ;
			// loop 는 1부터 증가하여 1개 블럭을 이루는 페이지 번호의 개수( 지금은 10개 ) 까지만 증가하는 용도이다.
			
			int pageNo = ( (Integer.parseInt(currentShowPageNo)-1)/blockSize)*blockSize + 1 ;
			// pageNo 는 페이지 바에서 첫번째로 보여지는 번호이다.
			
			// **** [맨처음][이전] 만들기 ***** //
			
			pageBar += "<li class='page-item'><a style='color:black;' class='page-link' href='adminProductSearch.dak?"
					+ "searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="
					+1+"'>맨처음</a></li>" ;
			
			if( pageNo != 1) {
					pageBar += "<li class='page-item'><a style='color:black;' class='page-link' href='adminProductSearch.dak?"
					+ "searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="
					+(pageNo-1)+"'>이전</a></li>" ;
			}
			// !( 반복을 빠져나가는 조건 ) => for 문을 사용할 경우, 밑에서 if 문을 통해, 전체페이지를 넘는 경우에 대해 조건을 설정해야 한다.
			while(!(loop > blockSize || pageNo > totalPage)  ) {
				
				if (pageNo == Integer.parseInt(currentShowPageNo) ) {
					pageBar += "<li class='page-item active'><a style='color:white; background-color:#FFA751; border:#FFA751; "
							+ " '  class='page-link'>"+pageNo+"</a></li>" ;					
				}
				
				else {
					pageBar += "<li class='page-item'><a style='color:black;'  class='page-link' href='adminProductSearch.dak?"
							+ "searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="
							+pageNo+"'>"+pageNo+"</a></li>" ;
				
				}
				loop ++ ; // 1 2 3 4 5 6 7 8 ~ 10 
				pageNo ++ ; // 이게 증가해야 하는 이유 : 혼자 생각해보면, 위의 조건을 넣기 위해서 필요하다. 전체 페이지를 넘지 않는 조건을 생성하기 위해서
				
			}// end of while ~~~
			
			// **** [다음][마지막] 만들기 ***** //
			if( pageNo <= totalPage) {
				pageBar += "<li class='page-item'><a style='color:black;'  class='page-link' href='adminProductSearch.dak?"
						+ "searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="
						+pageNo+"'>다음</a></li>" ;
			}
			
			pageBar += "<li class='page-item'><a  style='color:black;' class='page-link' href='adminProductSearch.dak?"
					+ "searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="
					+totalPage+"'>마지막</a></li>" ;
			
			

			
		
		
		
		
		
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("totalProduct", map.get("totalProduct"));
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/views/admin/productSearch.jsp");
		
	}

}
