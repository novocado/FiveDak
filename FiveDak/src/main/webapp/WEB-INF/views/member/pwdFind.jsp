<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

	.findpwd-input {
		border: solid 1px black;
		border-radius : 5px; 
		width: 100%;
	}
	
	.findpwd-span {
		margin-top : 20px;
		color: red;
	}
	

</style>




<script type="text/javascript">
	
	let check_ok_flag1 = false; 
	let check_ok_flag2 = false;
	let check_ok_flag3 = false;

	$(document).ready(function(){		
		setEventHandling();
	});
	
	
	function setEventHandling() {
		
		$("span#findPwdNameError").hide();
		$("span#findPwdEmailError").hide();
		$("span#findPwdIdError").hide();
		
		$("input#findPwdSubmit").prop("disabled", true); // 초기 버튼 비활성화 
		
		$("input#dh-findpwd-id").change(dhpwdfindid);         // 아이디 입력 부분을 변경하는 경우
		$("input#dh-findpwd-name").change(dhpwdfindname);    // 성명 입력 부분을 변경하는 경우 
		$("input#dh-findpwd-email").change(dhpwdfindemail);   // 이메일 입력 부분을 변경하는 경우 
		$("select#dh-select-findpwd").change(dhpwdselectemail);	// select에서 이메일을 변경하는 경우 

	}
	
	
	function findpwdCommonboolfalse() {    // 정규표현식 틀렸을때
		
		const findPwdSubmit1 = $("input#findPwdSubmit");
  		findPwdSubmit1.css("background-color", "buttonface");
  		findPwdSubmit1.css("color", "black"); 
  		$("input#findPwdSubmit").prop("disabled", true);
	}
	
	function findpwdCommonbooltrue() {        // 정규표현식 올바를때
		const findPwdSubmit1 = $("input#findPwdSubmit");
  		findPwdSubmit1.css("background-color", "#FF7E32");
  		findPwdSubmit1.css("color", "white");
  		$("input#findPwdSubmit").prop("disabled", false);
  		
  		$("input#findPwdSubmit").click(findPwdSubmitclick);  //제출 결과 버튼 클릭시 
	}
	
	// 아이디 입력했을때 맞는지 확인하는 것
	function dhpwdfindid() {
		
		const findpwd_idcheck = $("input#dh-findpwd-id").val();			// 값을 가져온다.
		
		const regExp = /^[a-z0-9]{4,16}$/g; 
		
		const bool = regExp.test(findpwd_idcheck);
		
		let html = "";
		
		// false 라면 
		if(!bool) {
			html += "영어 숫자만으로 4 ~ 16자 사이이어야 합니다."
			$("span#findPwdIdError").html(html);
			$("span#findPwdIdError").show();
			//$("input#dh-findpwd-name").val("");		// 성명 찾기를 비워라 
			
			findpwdCommonboolfalse();  // 함수호출
			
	  		check_ok_flag1 = false;
			return;						// 종료
		}
		else {							
			$("span#findPwdIdError").hide();
			check_ok_flag1 = true;
		}
		
		// 모두 정확히 입력한다면 실행 
		if(check_ok_flag1 == true && check_ok_flag2 && check_ok_flag3 == true ) {
			findpwdCommonbooltrue();  // 함수호출
	  	 }
		
	}
	
	function dhpwdfindname () {  // 성명을 입력하는 부분 
		 		
		const findpwd_namecheck = $("input#dh-findpwd-name").val();			// 값을 가져온다.
			
		// 정규표현식 한글만 
		const regExp = /^[가-힣]+$/; 
			
		const bool = regExp.test(findpwd_namecheck);  // 값을 넣어준다. 정규표현식이면 true 아니면 false
		
		let html = "";
		
		// false 라면 
		if(!bool) {
			html += "한글을 정확히 입력하거나 한글만 사용해 주십시오"
			$("span#findPwdNameError").html(html);
			$("span#findPwdNameError").show();
			//$("input#dh-findpwd-name").val("");		// 성명 찾기를 비워라 
			
			findpwdCommonboolfalse();  // 함수호출
			
	  		check_ok_flag2 = false;
			return;						// 종료
		}
		else {							
			$("span#findPwdNameError").hide();
			check_ok_flag2 = true;
		}
		
		// 모두 정확히 입력한다면 실행 
		if(check_ok_flag1 == true && check_ok_flag2 == true && check_ok_flag3 == true ) {
			findpwdCommonbooltrue();  // 함수호출
	  	 }

				
	}
	
	function dhpwdfindemail(){   // 이메일 입력하는 경우
		
	      let html = "";
	    
	      // 직접 입력인 경우 
	      if( $('select.findpwd-email-sel').val() == 'other' ){
	         const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;   // 이베일에 @가 들어가서 이메일 형식인지 파악하기 
	         const bool = regExp.test( $('input#dh-findpwd-email').val() );
	         
	         if( !bool ){ // 이메일이 정규표현식에 위배된 경우
	            //$('span#findPwdEmailError').text("이메일이 적합한 형식이 아닙니다.");
	        	 html += "이메일이 적합한 형식이 아닙니다."
	     		 $("span#findPwdEmailError").html(html);
	     		 $("span#findPwdEmailError").show();
	     		 
	     		 findpwdCommonboolfalse();  // 함수호출
	     		 
	     		 check_ok_flag3 = false;
	     		 //$("input#dh-findpwd-email").val("");		// 이메일 부분을 비워라  
	     	     return;						// 종료
	         }
	         else{ // 이메일이 정규표현식에 위배되지않은경우
	        	 $("span#findPwdEmailError").hide();   
	        	 check_ok_flag3 = true;	        	 
	         }
	         
	      }// end of if 
	      else{
	         const regExp = /^(?=.{4,16})(?!.*[^a-z0-9\-_])[a-z0-9\-_]*$/
	         const bool = regExp.test( $('input#dh-findpwd-email').val() );
	         
	         if ( !bool ){
	        	 html += "이메일이 적합한 형식이 아닙니다."
	     		 $("span#findPwdEmailError").html(html);
	     		 $("span#findPwdEmailError").show();
	     		 
	     		 findpwdCommonboolfalse();  // 함수호출
	     		 
	     		 check_ok_flag3 = false;
	     		 //$("input#dh-findpwd-email").val("");		// 이메일 부분을 비워라  
	     	     return;
	         }
	         else{
	        	 
	        	 $("span#findPwdEmailError").hide(); 
	        	 check_ok_flag3 = true;
	         }
	         
	      }// end of else 
	    	  
	      // 모두 정확히 입력한다면 실행   
	      if(check_ok_flag1 == true && check_ok_flag2 == true && check_ok_flag3 == true ) {
	    	  findpwdCommonbooltrue();  // 함수호출
	  	  }

	}
	
	// 이메일 선택하는 부분 
	function dhpwdselectemail () {
		
		findpwdCommonboolfalse();  // 함수호출
  		dhpwdfindemail();   // 함수 호출 
	}
	

	// 제출 버튼 클릭시
	function findPwdSubmitclick() {
			
			const inputEmail = $("input#dh-findpwd-email").val();
			const emailSelected = $("select#dh-select-findpwd").val();
			if(emailSelected == "other") {
				$("input#dh-findpwd-email").val(inputEmail);	
			} else {
				$("input#dh-findpwd-email").val(inputEmail + "@" + emailSelected);
			}
			
	       	const frm = document.getElementById("pwdFindFrm");
			frm.action = "<%= ctxPath %>/memberPwdFind.dak";    // action 부분
			frm.method = "post";    // 무슨 타입으로 보낼래? get? POST?
			frm.submit();	 	// 보내자 
	       	
	       	
	}

	

</script>





<div class="dh-findid-all">
	<div class="container">
		<div class="dh-all-divcss">
			<form id="pwdFindFrm" style="margin: 10% 10%;" method="post">   <%-- method="post" 를 해야만 post방식으로 넘어간다.  --%>
				<!-- <div class = "row"> -->
					
					<p class="h2 col-12" style="padding: 0;">비밀번호 찾기</p>
					
					<p class ="h5 col-12" style="padding: 0;">이메일로 찾기</p>
				
					<input type="text" name="memberFindPwdId" placeholder="아이디"  class="findpwd-input col-12" id="dh-findpwd-id" style="height:50px;"/>   <%--autofocus="autofocus" --%>
					
					<span id="findPwdIdError" class="findpwd-span"></span>
					
					<input type="text" name="memberFindPwdName" placeholder="이름 2자 이상 입력"  class="findpwd-input col-12" id="dh-findpwd-name" style="height:50px; margin-top:20px;"/>   <%--autofocus="autofocus" --%>
					
					<span id="findPwdNameError" class="findpwd-span"></span>
					
					 
			         <div style="display: flex;"> 			    
			           
			          <input type="text" name="memberFindPwdEmail" class="findpwd-input col-7" id="dh-findpwd-email" aria-describedby="emailHelp" placeholder="이메일 주소" style="margin-top:20px;">
			           
			            <select class="findpwd-input findpwd-email-sel col-4 offset-1" id="dh-select-findpwd" style="height:50px; margin-top:20px;">
			              <option value="other" selected>직접입력</option>
			              <option value="naver.com">naver.com</option>
			              <option value="hanmail.com">hanmail.com</option>
			              <option value="daum.net">daum.net</option>
			              <option value="google.com">google.com</option>
			              <option value="gamil.com">gamil.com</option>
			            </select>			
				           
				          
			        </div>
					
					<span id="findPwdEmailError" class="findpwd-span"></span>
					
					
					<div>
						<input type="submit" id="findPwdSubmit" style="width:100%; border-radius : 5px; border: none; height: 50px; margin-top: 3%;" value="인증번호 받기"/>
					</div>

			</form>
			
		</div>
	</div>
</div>

<jsp:include page="../footer.jsp"></jsp:include>				<!-- footer 불러오기-->
