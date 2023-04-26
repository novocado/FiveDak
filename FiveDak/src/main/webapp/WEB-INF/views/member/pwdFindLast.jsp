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
	
	.idFindorange3 {
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
		
		$("button#EmailCode").on("click", EmailCode);
		$("button#IdFindButtonClick2").on("click", GoMainPage);

	}
	
	function EmailCode() {

		const frm = document.verifyCertificationFrm;
		
		frm.userCertificationCode.value = $("input#Codecheck").val();   // input_confirmCode의 값을 담아서 보내자 
		frm.userid.value = "${memberFindPwdId}";
		//console.log(frm.userid.value);
		
		
		frm.action = "<%= ctxPath %>/verifyCertification.dak";
		frm.method = "post";
		frm.submit();
	}
	
	function GoMainPage() {
		// 메인페이지로 이동  
		location.href="<%= ctxPath %>/index.dak";       
	}
	
	

	

</script>

<c:set var="memberFindPwdId" value="${requestScope.memberFindPwdId}" />


<div class="dh-findid-all">
	<div class="container">
		<div class="dh-all-divcss">
			<div id="idFindResultFrm" style="margin: 10% 10%; text-align: center;" method="post">
				
										
					<p class="h3 col-12" style="padding: 0;">고객님의 이메일로 인증코드를 발송했습니다.</p>
					<p class="h5 col-12" style="padding: 0;">발송된 이메일 : ${requestScope.memberFindPwdEmail}</p>
					
					<input type="text" class = "col-10 offser-1" id="Codecheck" placeholder="인증번호를 입력하세요" style="border-radius: 5px; height:40px; margin-top: 40px;" />
				
					<div style="height: 50px;">
						<button type="button" id="EmailCode" class="idFindorange3 col-12" style="margin: 28px auto 20px auto; height: 50px;">인증번호 확인 및 비밀번호 재설정</button>
					</div>
			</div>
		</div>
	</div>
</div>

<form name="verifyCertificationFrm">

	<input type="hidden" name="userCertificationCode" />   <%-- 사용자가 입력한 인증코드 --%>
	<input type="hidden" name="userid" value="${memberFindPwdId}"/> 
</form>

<jsp:include page="../footer.jsp"></jsp:include>				<!-- footer 불러오기-->
