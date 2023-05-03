<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h3 style="font-weight:bold; font-size:12pt;">구매후기</h3>

<div class="reviewBox">
	<c:forEach var="rdto" items="${requestScope.reviewlist}">
	         <div class="reviewContent">
	            <span>평점 : ${rdto.review_score}</span><br>
	            <span>닉네임 : ${rdto.review_member_id }  | 날짜 :${rdto.review_date}  </span><br>
	            <span>${rdto.review_content }</span>
	         </div>
	</c:forEach>
</div>

<nav class="my-5">
	<div style='display:flex; width:80%; position:relative; left :175px;'>
	    <ul  id="pageBar"class="pagination" style='margin:auto; list-style-type: none'>
			<c:if test="${requestScope.pageNum != 1 }">
				<li class="page-item"><button type="button" class="btn btn-outline-warning " onclick="goReviewList(1)">맨처음</button></li>
			</c:if>
			
			<c:if test="${requestScope.startPage != 1 }">
				<li class="page-item"><button type="button" class="btn btn-outline-warning " onclick="goReviewList(${requestScope.pageNum -1})">이전</button></li>
			</c:if>
			
			<c:forEach begin="${requestScope.startPage}" end="${requestScope.endPage}" var="page">
				<li class="page-item">
					<button class="btn ${requestScope.pageNum == page ? 'btn-warning' : 'btn-outline-warning' }" onclick="goReviewList(${page})">${page}</button>
				</li>
			</c:forEach>
			
			<c:if test="${requestScope.endPage != requestScope.totalPage}">
				<li class="page-item"><button type="button" class="btn btn-outline-warning" onclick="goReviewList(${requestScope.pageNum +1})">다음</button></li>
			</c:if>
			
			<c:if test ="${requestScope.pageNum != requestScope.totalPage}">
				<li class="page-item"><button type="button" class="btn btn-outline-warning" onclick="goReviewList(${requestScope.endPage})">마지막</button></li>
			</c:if>

		</ul>
	</div>
</nav>




