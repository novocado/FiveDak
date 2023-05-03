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
				
				
				
				
				
				