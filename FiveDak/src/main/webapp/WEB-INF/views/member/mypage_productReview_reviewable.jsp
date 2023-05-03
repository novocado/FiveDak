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

	$(document).ready(function(){
		
	});
	
	function goReviewWrite(product_id, orderSerial) {
	      
      
      location.href= "reviewWrite.dak?product_id="+product_id+"&order_serial="+orderSerial;
	      
	   }

</script>

<p style="margin: 20px 0px 15px 0px; font-size:14pt;">작성 가능한 후기  
                  <span style="color: #FF7E32;">${totalReviewable }건 </span>
                  <button class="btn" type="button" data-toggle="collapse" data-target="#demo1" style="float:right;" aria-expanded="true">
                    <i class="fa-solid fa-chevron-down"></i>
                    </button>
               </p>
               
               
            <div id="demo1" class="collapse show">
               <div class="card bg-light" style="margin: 20px 0px 40px 0px;">
                    <div class="card-header row-12" style="display:flex; height: 45px; font-size:13pt;">
                       <div class="col-md-8 text-center"><span class="product_review_reviewpossibledate">상품</span></div>
                       <div class="col-md-2"><span class="product_review_reviewpossibledate">상품구매일</span></div>
                       <div class="col-md-2" style="margin-left:30px;"><span class="product_review_reviewpossibledate">후기작성</span></div>
                    </div>
                   
                 
                 <c:if test="${requestScope.totalReviewable eq 0}"> 
                       <div class="no-data">
                            <p class="message">작성 가능한 후기가 없습니다.</p>
                       </div> 
                 </c:if>
                 
                 
                 <c:if test="${requestScope.totalReviewable > 0}">
                 <c:forEach var="od" items="${reviewable}">
                 <div class="card-body body_1 row-md-12">
                      <div class="body col-md-2" style="padding:0px;">
                       <img src="/FiveDak/images/${od.orderDetailProd.prodImage1 }" style="width:80px; height:80px;"/>
                      </div>   
                    <div class="contents col-md-5" style="padding: 5px 0 10px 0px;">
                         <div style="margin-bottom: 15px;">
                               <span id="serial_num"style="color:#666666;">${od.orderSerial}</span>
                         </div>
                         <a id="product_id"href='<%= ctxPath%>/product/productDetail.dak?prodNum=${od.orderDetailProd.prodNum}' style="color:#333;" >[${od.orderDetailProd.brandDTO.brandName}] ${od.orderDetailProd.prodName }</a>
                    </div>
                    <div class="col-md-3 text-center"style="padding-top:30px; margin-left:25px">
                       <span style="color:#666666;font-size:13pt; ">&nbsp;&nbsp;${od.orderedDate }</span>
                    </div> 
                    <div class="col-md-1"style="padding:30px 0 0 0; margin-left:15px">
                         <button type="button" id="btnCommentOK" class="btn_review_write" onclick="goReviewWrite('${od.orderDetailProd.prodNum}','${od.orderSerial}')"><i class="fa-solid fa-pen"></i> 후기작성</button>
                    </div>   
                 </div>
                 </c:forEach>
                 </c:if>
                 
                 
                 <div class="pageBar">
                 <c:if test="${requestScope.totalPage > 0}"> 
					<ul class="pagination justify-content-center pagination-sm">
				
						<c:if test="${requestScope.currentPage != 1}">
						  <li class="page-item"><a class="page-link text-muted" href="javascript:void(0)" onclick="loadReviewableOrderDetail(1)">[맨처음]</a></li>
						</c:if>
						
						<c:if test="${requestScope.startPage != 1}">
						  <li class="page-item"><a class="page-link text-muted" href="javascript:void(0)" onclick="loadReviewableOrderDetail(${startPage - 1})">[이전]</a></li>
						</c:if>
						
						<c:forEach begin="${requestScope.startPage}" end="${requestScope.endPage}" var="page">
						  <li class="page-item ${requestScope.currentPage == page ? 'active' : ''}"><a class="page-link" href="javascript:void(0)" onclick="loadReviewableOrderDetail(${page})">${page}</a></li>
						</c:forEach>
						
						<c:if test="${requestScope.endPage != requestScope.totalPage}">
						  <li class="page-item"><a class="page-link text-muted" href="javascript:void(0)" onclick="loadReviewableOrderDetail(${endPage + 1})" >[다음]</a></li>
						</c:if>
						
						<c:if test="${requestScope.currentPage != requestScope.totalPage}">
						  <li class="page-item"><a class="page-link text-muted" href="javascript:void(0)" onclick="loadReviewableOrderDetail(${totalPage})">[마지막]</a></li>
						</c:if>
					</ul>
					</c:if>
                 </div>
                 
               </div>
            </div>