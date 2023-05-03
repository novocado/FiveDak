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
	
		// textarea에 글자수를 제한과 글자수 실시간 표시하기 
		$('#Admintextarea1to1').on('input', function() {
		  let inputText = $(this).val();
		  let characterCount = inputText.length;
		  let maxCharacterCount = 1000;
		  
		  $('#counter1to1').text(characterCount);
		  
		  if (characterCount > maxCharacterCount) {
		    $(this).val(inputText.substring(0, maxCharacterCount));
		    $('#counter1to1').text(maxCharacterCount);
		  }
		});

});



	function AdminGoback() {
		location.href ="<%= ctxPath%>/index.dak"; 
	}
	
	function AdminGoQNA() {
				
		const AdminO1to1Frm = document.AdminO1to1Frm;
		AdminO1to1Frm.method = "post";
		AdminO1to1Frm.action="admin1to1AnswerFin.dak";
		AdminO1to1Frm.submit();	
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
	     	
	     	<form name="AdminO1to1Frm">
	     	
	     		<input type="hidden"  name="NumberNONO" value="${requestScope.qnaId}"/> 
	     	
	     		<table class="table">
	     			<tbody>    				
	     				<tr>
	     					<th style="position: relative; top: 10px;">
	     						<span>답변 내용</span>
	     					</th>
	     					<td>
	     						<div style="padding: 10px; border: solid 1px red;">
	      							<textarea name="contents" placeholder="답변내용을 입력하세요." style="font-size: 12pt; border: none; width: 100%; height: 300px;" class="1to1borderccc" id="Admintextarea1to1"></textarea>
									<div class="txt-count" style="text-align: right;"><span id="counter1to1">0</span> / <span class="total1to1">1,000</span></div>
								</div>
							</td>
	     				</tr>
	     				
	     				
	     				
	     			</tbody>
	     		</table>		
	     		
	     		<div style="display: flex;">
	     			<button type="button" class="col-md-3 offset-md-3" style="background-color: #e6e6e6; height:50px; border: none; border-radius: 5px;" onclick="AdminGoback();">취소하기</button>

	     			<button type="button" class="col-md-3 offset-md-1" style="background-color: #FF7E32; height:50px; border: none; border-radius: 5px;" onclick="AdminGoQNA()">답변하기</button>
			</div>
	     			
		</form>		
				
				
				
				
				
				