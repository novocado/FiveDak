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

	.findid-input {
		border: solid 1px black;
		border-radius : 5px; 
		width: 100%;
	}
	
	.findid-span {
		margin-top : 20px;
		color: red;
	}
	

</style>




<script type="text/javascript">
	
	let check_ok_flag1 = false; 
	let check_ok_flag2 = false;

	$(document).ready(function(){
				
		$("span#findnameerror").hide();
		$("span#findemailerror").hide();
		$("input#findidsubmit").prop("disabled", true); // 초기 버튼 비활성화 
		
		setEventHandling();
	});
	
	
	function setEventHandling() {
		
		$("input#dh-findid-name").change(dhfindname);    // 성명 입력 부분을 변경하는 경우 
		$("input#dh-findid-email").change(dhfindemail);   // 이메일 입력 부분을 변경하는 경우 
		$("select#dh-select-findid").change(dhselectemail);	// select에서 이메일을 변경하는 경우 

	}
	
	
	function findidCommonboolfalse() {    // 정규표현식 틀렸을때
		
		const findidsubmit1 = $("input#findidsubmit");
  		findidsubmit1.css("background-color", "buttonface");
  		findidsubmit1.css("color", "black"); 
  		$("input#findidsubmit").prop("disabled", true);
	}
	
	function findidCommonbooltrue() {        // 정규표현식 올바를때
		const findidsubmit1 = $("input#findidsubmit");
  		findidsubmit1.css("background-color", "#FF7E32");
  		findidsubmit1.css("color", "white");
  		$("input#findidsubmit").prop("disabled", false);
  		
  		$("input#findidsubmit").click(findidsubmitclick);  //제출 결과 버튼 클릭시 
	}
	
	
	function dhfindname () {  // 성명을 입력하는 부분 
		 		
		const findid_namecheck = $("input#dh-findid-name").val();			// 값을 가져온다.
			
		// 정규표현식 한글만 
		const regExp = /^[가-힣]+$/; 
			
		const bool = regExp.test(findid_namecheck);  // 값을 넣어준다. 정규표현식이면 true 아니면 false
		
		let html = "";
		
		// false 라면 
		if(!bool) {
			html += "한글을 정확히 입력하거나 한글만 사용해 주십시오"
			$("span#findnameerror").html(html);
			$("span#findnameerror").show();
			//$("input#dh-findid-name").val("");		// 성명 찾기를 비워라 
			
			findidCommonboolfalse();  // 함수호출
			
	  		check_ok_flag1 = false;
			return;						// 종료
		}
		else {							
			$("span#findnameerror").hide();
			check_ok_flag1 = true;
		}
		
		// 모두 정확히 입력한다면 실행 
		if(check_ok_flag1 == true && check_ok_flag2 == true) {
			findidCommonbooltrue();  // 함수호출
	  	 }

				
	}
	
	function dhfindemail(){   // 이메일 입력하는 경우
		
	      let html = "";
	    
	      // 직접 입력인 경우 
	      if( $('select.findid-email-sel').val() == 'other' ){
	         const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;   // 이베일에 @가 들어가서 이메일 형식인지 파악하기 
	         const bool = regExp.test( $('input#dh-findid-email').val() );
	         
	         if( !bool ){ // 이메일이 정규표현식에 위배된 경우
	            //$('span#findemailerror').text("이메일이 적합한 형식이 아닙니다.");
	        	 html += "이메일이 적합한 형식이 아닙니다."
	     		 $("span#findemailerror").html(html);
	     		 $("span#findemailerror").show();
	     		 
	     		 findidCommonboolfalse();  // 함수호출
	     		 
	     		 check_ok_flag2 = false;
	     		 //$("input#dh-findid-email").val("");		// 이메일 부분을 비워라  
	     	     return;						// 종료
	         }
	         else{ // 이메일이 정규표현식에 위배되지않은경우
	        	 $("span#findemailerror").hide();   
	        	 check_ok_flag2 = true;	        	 
	         }
	         
	      }// end of if 
	      else{
	         const regExp = /^(?=.{4,16})(?!.*[^a-z0-9\-_])[a-z0-9\-_]*$/
	         const bool = regExp.test( $('input#dh-findid-email').val() );
	         
	         if ( !bool ){
	        	 html += "이메일이 적합한 형식이 아닙니다."
	     		 $("span#findemailerror").html(html);
	     		 $("span#findemailerror").show();
	     		 
	     		 findidCommonboolfalse();  // 함수호출
	     		 
	     		 check_ok_flag2 = false;
	     		 //$("input#dh-findid-email").val("");		// 이메일 부분을 비워라  
	     	     return;
	         }
	         else{
	        	 
	        	 $("span#findemailerror").hide(); 
	        	 check_ok_flag2 = true;
	         }
	         
	      }// end of else 
	    	  
	      // 모두 정확히 입력한다면 실행   
	      if(check_ok_flag1 == true && check_ok_flag2 == true) {
	    	  findidCommonbooltrue();  // 함수호출
	  	  }

	}
	
	// 이메일 선택하는 부분 
	function dhselectemail () {
		
		findidCommonboolfalse();  // 함수호출
  		dhfindemail();   // 함수 호출 
	}
	

	// 제출 버튼 클릭시
	function findidsubmitclick() {
			
			const inputEmail = $("input#dh-findid-email").val();
			const emailSelected = $("select#dh-select-findid").val();
			if(emailSelected == "other") {
				$("input#dh-findid-email").val(inputEmail);	
			} else {
				$("input#dh-findid-email").val(inputEmail + "@" + emailSelected);
			}
			
	       	const frm = document.idFindFrm;
			frm.action = "<%= ctxPath %>/memberIdFind.dak";    // action 부분
			frm.method = "post";    // 무슨 타입으로 보낼래? get? POST?
			frm.submit();	 	// 보내자 
	       	
	       	
	}
	

</script>





<div class="dh-findid-all">
	<div class="container">
		<div class="dh-all-divcss">
			<form id="idFindFrm" style="margin: 10% 10%;" method="post">   <%-- method="post" 를 해야만 post방식으로 넘어간다.  --%>
				<!-- <div class = "row"> -->
					
					<p class="h2 col-12" style="padding: 0;"> 아이디 찾기 </p>
					
					<p class ="h5 col-12" style="padding: 0;">이메일로 찾기</p>
				
				
					<input type="text" name="memberFindIdName" placeholder="이름 2자 이상 입력"  class="findid-input col-12" id="dh-findid-name" style="height:50px;"/>   <%--autofocus="autofocus" --%>
					
					<span id="findnameerror" class="findid-span"></span>
					
					 
			         <div style="display: flex;"> 			    
			           
			          <input type="text" name="memberFindIdEmail" class="findid-input col-7" id="dh-findid-email" aria-describedby="emailHelp" placeholder="이메일 주소" style="margin-top:20px;">
			           
			            <select class="findid-input findid-email-sel col-4 offset-1" id="dh-select-findid" style="height:50px; margin-top:20px;">
			              <option value="other" selected>직접입력</option>
			              <option value="naver.com">naver.com</option>
			              <option value="hanmail.com">hanmail.com</option>
			              <option value="daum.net">daum.net</option>
			              <option value="google.com">google.com</option>
			              <option value="gamil.com">gamil.com</option>
			            </select>			
				           
				          
			        </div>
					
					<span id="findemailerror" class="findid-span"></span>
					
					<div>
						<input type="submit" id="findidsubmit" style="width:100%; border-radius : 5px; border: none; height: 50px; margin-top: 3%;" />
					</div>
				
				<!-- </div> -->
			</form>
		</div>
	</div>
</div>

<jsp:include page="../footer.jsp"></jsp:include>				<!-- footer 불러오기-->
