<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<% String ctxPath = request.getContextPath(); %>
<style type="text/css">

.no-data:before {
    display: block;
    content: '';
    margin: 0 auto 10px;
    width: 80px;
    height: 90px;
    background: url(<%=ctxPath%>/images/alert.png);
}

.no-data {
    text-align: center;
    width: 100%;
    padding: 160px 0;
    background-color: #fff;
}

.no-data .message {
    color: #333;
    font-size: 15px;
}

.pagination > li > a
{
    background-color: white;
    color: #ffba38;
}

.pagination > li > a:focus,
.pagination > li > a:hover,
.pagination > li > span:focus,
.pagination > li > span:hover
{
    color: #5a5a5a;
    background-color: #eee;
    border-color: #ddd;
}

.pagination > .active > a
{
    color: white;
    background-color: #ffba38 !Important;
    border: solid 1px #ffba38 !Important;
}

.pagination > .active > a:hover
{
    background-color: #ffba38 !Important;
    border: solid 1px #ffba38;
}


</style>

<script type="text/javascript">

	function goReviewDel(product_id, orderSerial) {
		
		if(confirm("정말로 삭제하겠습니까?")) {
			
			$.ajax({
				url:"<%= request.getContextPath()%>/mypage/reviewDelete.dak",
				type:"post",
				data:{"product_id":product_id
					 ,"orderSerial":orderSerial},
			    dataType:"json",
			    success:function(json) {
			    	if(json.n == 1) {
		                  alert("제품후기 삭제가 성공되었습니다.");
		                  location.href = "<%= ctxPath%>/mypage/reviewlist.dak";
		               }
		               else {
		                  alert("제품후기 삭제가 실패했습니다.");
		               }
			    },
			    error: function(request, status, error){
	                   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	               }
			});
			
		}
	}

</script>
               
               
                  <div class="review-head">
               
                        <p style="margin: 20px 0px 15px 0px; font-size:14pt;">작성 완료 후기
                            <span style="color: #FF7E32;">${totalReviewed}건 </span>
                            <button class="btn" type="button" data-toggle="collapse" data-target="#demo2" style="float:right;" aria-expanded="true">
                              <i class="fa-solid fa-chevron-down"></i>
                             </button>
                        </p>
               
                  </div>
                  <div id="demo2" class="collapse show">
                     <div class="card bg-light" style="margin: 20px 0px 40px 0px;">
                          <div class="card-header row-12" style="display:flex; height: 45px; font-size:13pt;">
                             <div class="col-md-8 text-center"><span class="product_review_reviewpossibledate">상품</span></div>
                             <div class="col-md-2"><span class="product_review_reviewpossibledate">작성일</span></div>
                             <div class="col-md-2"style="margin-left:30px;"><span class="product_review_reviewpossibledate">후기작성</span></div>
                          </div>
                       
                       <c:if test="${requestScope.totalReviewed eq 0}"> 
                       <div class="no-data">
                            <p class="message">작성 가능한 후기가 없습니다.</p>
                       </div> 
                       </c:if>
                       <c:if test="${requestScope.totalReviewed > 0}"> 
                       <c:forEach var="od" items="${reviewed}">
                       <div class="card-body body_1 row-md-12">
                            <div class="body col-md-2" style="padding:0px;">
                             <img src="/FiveDak/images/${od.orderDetailProd.prodImage1 }" style="width:80px; height:80px;"/>
                            </div>   
                          <div class="contents col-md-5" style="padding: 5px 0 10px 10px;">
                               <div style="margin-bottom: 15px;">
                                     <span style="color:#666666;">${od.orderSerial}</span>
                               </div>
                               <a href='<%= ctxPath%>/product/productDetail.dak?prodNum=${od.orderDetailProd.prodNum}' style="color:#333; ">[${od.orderDetailProd.brandDTO.brandName}] ${od.orderDetailProd.prodName }</a>
                          </div>
                          <div class="col-md-3 text-center" style="padding-top:30px;">
                             <span style="color:#666666; font-size:13pt; margin-left:25px ">${od.reviewedDate }</span>
                          </div> 
                          
                          <div class="col-md-1"style="padding:30px 0 0 0; margin-left:15px">
                               <button class="btn_review_write" onclick="goReviewDel('${od.orderDetailProd.prodNum}','${od.orderSerial}')">리뷰삭제</button>
                          </div>   
                       </div>
                       </c:forEach>
                       </c:if>
                       <div class="pageBar">
                 	  <c:if test="${requestScope.totalPage > 0}"> 
						<ul class="pagination justify-content-center pagination-sm">
					
							<c:if test="${requestScope.currentPage != 1}"> <!-- 현재 선택된 페이지가 첫페이지가 아니라면 맨처음으로 가는 버튼을 나타내줌 -->
							  <li class="page-item"><a class="page-link text-muted" href="javascript:void(0)" onclick="loadReviewedOrderDetail(1)">[맨처음]</a></li>
							</c:if>
							
							<c:if test="${requestScope.startPage != 1}">   <!-- 현재 선택된 페이지 블록의 제일 왼쪽 인덱스가 1이 아니라면 이전 버튼을 나타내줌 -->
							  <li class="page-item"><a class="page-link text-muted" href="javascript:void(0)" onclick="loadReviewedOrderDetail(${startPage - 1})">[이전]</a></li>
							</c:if>												<!-- 이전 버튼은 현재 페이지 블록의 제일 첫페이지의 이전 페이지임 ex 21이 startPage면 20페이지로 이동 -->
							
							<c:forEach begin="${requestScope.startPage}" end="${requestScope.endPage}" var="page">  <!-- 전달받은 startPage부터 endPage까지 숫자 페이지 버튼을 만들어줌 -->
							  <li class="page-item ${requestScope.currerntPage == page ? 'active' : ''}"><a class="page-link" href="javascript:void(0)" onclick="loadReviewedOrderDetail(${page})">${page}</a></li>
							</c:forEach>			<!-- 만드려는 페이지가 현재페이지라면 class에 active속성을 부여함 -->
							
							<c:if test="${requestScope.endPage != requestScope.totalPage}"> <!-- 이전 페이지와 반대임, 마지막 페이지 블록이 아니라면 다음 페이지블록으로 가는 버튼 나타냄 -->
							  <li class="page-item"><a class="page-link text-muted" href="javascript:void(0)" onclick="loadReviewedOrderDetail(${endPage + 1})" >[다음]</a></li>
							</c:if>
							
							<c:if test="${requestScope.currentPage != requestScope.totalPage}"> <!-- 맨처음과 반대임 마지막 페이지가 아니라면 마지막으로 가는 버튼 나타냄 -->
							  <li class="page-item"><a class="page-link text-muted" href="javascript:void(0)" onclick="loadReviewedOrderDetail(${totalPage})">[마지막]</a></li>
							</c:if>
						</ul>
					</c:if>
                 </div>
                       
                     </div>
                  </div>
                  
                  
                  
                  