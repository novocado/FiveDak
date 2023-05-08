<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
 
<%
	String ctxPath = request.getContextPath();
%> 



<style type="text/css">





</style>


<script type="text/javascript">
	$(document).ready(function(){
		
		
		
	});
	
	function goList() {
		
		location.href = "<%= ctxPath %>/mypage/1to1QNAAnswer.dak";
		
		
	}

	
</script>	
    	<h4 style="text-align: center; margin-bottom: 20px;">문의 내용</h4>
      	<table class="table">
		 	<thead class="thead-light">
		 		<tr>
		 			<th>제목 : ${requestScope.qnatitle}</th>
		 			<th style="text-align: right;">글 번호 : ${requestScope.qnaId}</th>
		 		</tr>
		 		<tr style="">	
				 	<td>작성자 : ${requestScope.qnauserid}</td>
				 	<td style="text-align: right;">작성일자 : ${requestScope.qnacreated_at}</td>	
				</tr>
			</thead>			
		</table>		 	


		<div style="border-top: solid 1px black; padding: 20px; margin-bottom: 100px;">${requestScope.qnacontent}</div>
		
		<div style="border: solid 1px black; width:100%; margin-bottom: 20px;"></div>
		
		<h4 style="text-align: center; margin-bottom: 20px;">문의 답변</h4>
		
		<div style="border: solid 1px black; width:100%; margin-bottom: 20px;"></div>		
		
		<c:if test="${not empty adminQnaDTO}">		
			<table class="table">
			 	<thead class="thead-light">
			 		<tr>
			 			<th> 관리자의 답변</th>
			 			<th style="text-align: right;"></th>
			 		</tr>
			 		<tr style="">	
					 	<td>작성자 : ADMIN </td>
					 	<td style="text-align: right;">작성일자 : ${adminQnaDTO.ANSWER_CREATED_AT}</td>	
					</tr>
				</thead>			
			</table>		 	
		</c:if>

		<c:if test="${empty adminQnaDTO }">
			<h3 style="color:navy"> 아직 답변이 등록되지 않았습니다.</h3>
			<h3 style="color:navy"> 조금만 기다려주시면 감사하겠습니다. </h3>
			<h3 style="color:navy"> 빠른 시일내에 답변 드리겠습니다.</h3>
		</c:if>
		<div style="border-top: solid 1px black; padding: 20px; margin-bottom: 50px;">${adminQnaDTO.ANSWER_CONTENT}</div>
		
		<div style="text-align: center; margin-bottom: 100px;">
			<button type="button" style="background-color: #FF7E32; width: 150px; height:50px; color: white; border: none; border-radius: 5px; text-align: center;" onclick="goList()">목록보기</button>
		</div>		
				
				
				
				