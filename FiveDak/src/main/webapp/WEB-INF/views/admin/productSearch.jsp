<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String ctxPath = request.getContextPath();
%>    
<jsp:include page="/WEB-INF/views/header-final.jsp"/>

<jsp:include page="/WEB-INF/views/member/mypageSidebar_admin.jsp"/>
<style>


</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("input#searchWord").on('keyup',function(e){
			if( e.keyCode == 13){ // 검색어에서 엔터를 하면 검색하러 가도록 한다.
				goFindProd();
			}
			
		}); // END OF $("input#searchWord").on('keyup',function(e){
		
		// 페이지 로드시 한번 실행
		truncateText();
		
		const searchType = '${requestScope.searchType}';
		const searchWord = '${requestScope.searchWord}';
		
		if('${requestScope.searchType}' != "" &&  '${requestScope.searchWord}' != "" ){
			$("select#searchType").val(searchType);
			$("input#searchWord").val(searchWord);			
		}
		// 특정회원을 클릭하면 그 회원의 상세정보를 보여주도록 한다.
		$("td.prodInfo").click(function(e){
			
			const prodNum = ($(e.target).parent().find('.prodNum').text());
			location.href ="<%= ctxPath%>/admin/prodOneDetail.dak?prodNum="+prodNum;
			
		}); // END OF $("tr.prodInfo").click(function(e){ 
			
		$("button.prodDelete").click(function(e){
			
			const prodNum = ($(e.target).parent().parent().find('.prodNum').text() );
			const prodName = ($(e.target).parent().parent().find('.prodName').text() );
			
			if ( confirm("해당 제품' "+prodName+" '을 삭제하시겠습니까?")){
				$.ajax({
					url:"<%=ctxPath %>/admin/prodDelete.dak" ,
					type:"POST",
					data:{"prodNum":prodNum},
					dataType:"JSON",
					success:function(json){
						if(json.n == 1) { 
							alert("해당 제품' "+prodName+" '을 제품 삭제가 되었습니다.");
							location.href = `adminProductSearch.dak?searchType=${requestScope.searchType}&searchWord=${requestScope.searchWord}&currentShowPageNo=${requestScope.currentShowPageNo}`;
						}
					},
					 error: function(request, status, error){
			               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			         }
				
				});
				
				
			}
			
			else{
				alert("해당 제품' "+prodName+" '을 제품 삭제를 취소하셨습니다.");
				
			}
		}); // END OF $("tr.prodInfo").click(function(e){ 
	
	});  // END OF $(DOCUMENT).READY(FUNCTION(){
	
	function goFindProd(){
		const prodListFrm = document.prodListFrm;
		prodListFrm.action="adminProductSearch.dak";
		prodListFrm.method="get";
		prodListFrm.submit();
	
	}// END OF function goFindProd(){
	
	var maxLength = 20;
	// 글자수를 체크하고 생략 부호("...")를 붙여주는 함수
	  function truncateText() {
	    $('td.prodName').each(function() {
	      var text = $(this).text();
	      if (text.length > maxLength) {
	        var truncatedText = text.substring(0, maxLength) + '...';
	        $(this).text(truncatedText);
	      }
	    });
	  } // END OF  FUNCTION TRUNCATETEXT() {
	


</script>

<div class="col-md-9">
      <!-- 오른쪽에 들어갈 내용 -->
      		<h2 class="float-left">전체제품목록</h2>
      		
      		<h5 class="float-right" style="position:relative; top:10px;">전체 제품 수 : ${requestScope.totalProduct } </h5>
			<hr style="border: 1px solid; clear:both;"/>
	
	<form name="prodListFrm">
	
		<select id="searchType" name="searchType" clase="mx-1" style="margin-left : 200px ;">
			<option value="">선택하세요</option>
			<option value="PRODUCT_NAME">제품명</option>
			<option value="BRAND_NAME">브랜드</option>
			<option value="CATEGORY_NAME">카테고리</option>
		</select>
		
		<input class="input" type="text" id="searchWord" name="searchWord"/>
			 
		<button class="btn btn-warning mx-5" style="margin-right:30px;" type="button" onclick="goFindProd()">검색</button>

	</form>

	<table id="prodTbl" class="table table-hover" style=" margin-top: 20px;">
	        <thead>
	           <tr>
	              <th>제품번호</th>
	              <th>브랜드</th>
	              <th>제품명</th>
	              <th>판매량</th>
	              <th>평균별점</th>
	              <th>판매가</th>
	              <th></th>
	           </tr>
	        </thead>
	
			<tbody>
				<c:if test="${empty requestScope.prodList }">
					 <tr>
		              	<td colspan="4">검색내용에 해당하는 제품이 없습니다.</td>
          			 </tr>
				</c:if>
				
				<c:if test="${not empty requestScope.prodList }">
						<c:forEach var="prod" items="${requestScope.prodList}">
							<tr>
								<td class="prodNum prodInfo">${prod.prodNum }</td>
								<td class="prodInfo">${prod.brandDTO.brandName}</td>
								<td class="prodName prodInfo">${prod.prodName }</td>
								<td class="prodInfo">
									<fmt:formatNumber value="${prod.prodSales}" pattern="#,###"/>
								</td>
								<td class="prodInfo">${prod.prodAvgRating }</td>
								<td class="prodInfo">
									<fmt:formatNumber value="${prod.prodDiscount}" pattern="#,###"/>
								</td>
								<td><button class="btn btn-danger prodDelete" style="padding-top:3px; padding-bottom:3px;"
								>삭제</button></td>
							</tr>
						</c:forEach>
				</c:if>
			</tbody>
	</table>
		
	<nav class="my-5">
	        <div style='display:flex; width:80%;'>
	          <ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
	       </div>
	</nav>
        
      
      
      <!-- 오른쪽에 들어갈 내용 -->
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"/>
