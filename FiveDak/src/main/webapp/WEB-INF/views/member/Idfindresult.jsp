<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /Fivedak
%>

<jsp:include page="../header-final.jsp"></jsp:include>				<!-- header 불러오기-->    
    
<style type="text/css"> 

	.dh-findid-all {
		background-color: #f7f7f7;
		padding: 3%;
	}
	
	.dh-all-divcss {
		border: solid 1px gray;
		border-radius: 20px;		
		margin: 0 20%;
		background-color: #fff;  
	}

	.findid-input {
		border: solid 1px black;
		border-radius : 5px; 
		width: 100%;
	}
	
	.idFindorange {
		border: solid 1px #FF7E32;
		color: #FF7E32;
		background-color: white;
		border-radius: 5px;
	}
	
	.idFindorange2 {
		border: solid 1px #FF7E32;
		color: white;
		background-color: #FF7E32;
		border-radius: 5px;
	}
	

</style>




<script type="text/javascript">

	$(document).ready(function(){
		
		setEventHandling();
	});
	
	
	function setEventHandling() {
		
		$("button#IdFindButtonClick1").on("click", GoPwdFind);
		$("button#IdFindButtonClick2").on("click", GoMainPage);

	}
	
	function GoPwdFind() {
	   // 비밀번호 찾기로 이동  
		location.href="<%= ctxPath %>/memberPwdFind.dak";
	}
	
	function GoMainPage() {
		// 메인페이지로 이동  
		location.href="<%= ctxPath %>/login.dak";       
	}
	
	

	

</script>

<c:set var="memberFindIdName" value="${requestScope.memberFindIdName}"/>
<c:set var="memberFindIdEmail" value="${requestScope.memberFindIdEmail}"/>





<div class="dh-findid-all">
	<div class="container">
		<div class="dh-all-divcss">
			<form id="idFindResultFrm" style="margin: 10% 10%; text-align: center;" method="post">
				
					
					<i class="far fa-id-card fa-5x"></i>
					
					<p class="h2 col-12" style="padding: 0;">고객님의 아이디는</p>
					
					<p class ="h5 col-12" style="padding: 0;">▶&nbsp;<span style="color:#FF7E32;" id="idFindResultID">${requestScope.userid}</span>&nbsp;◀</p>
				
					<div class="row" style="height: 50px;">
						<button type="button" id="IdFindButtonClick1" class="idFindorange col-3 offset-2">비밀번호 찾기</button>
						<button type="button" id="IdFindButtonClick2" class="idFindorange2 col-3 offset-2">확인</button>
					
					</div>
			</form>
		</div>
	</div>
</div>

<jsp:include page="../footer.jsp"></jsp:include>				<!-- footer 불러오기-->
