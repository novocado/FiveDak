<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>    

<jsp:include page="/WEB-INF/views/header-final.jsp"/>


<style type="text/css">
	
	div#container {
		width: 60%;
		margin: 0 auto;
		border: solid 1px #cccccc;
		border-radius: 10%;
		
	}
	form[name='myfrm'] {
		width:80%;
		margin: 0 auto;
	}
	
	button.idcheck {
		height: 50px;
		width: 170px;
	}
	
	span.star {
		color: #ff471a;
	}
	
	input.input_height {
		height: 50px;
	}
	
	div.phonenum {
		display:flex;
	}
	
	input.exampleInputphonenum {
		width: 70px;
		height: 35px;
	}
	
	
	inpraAddress'] {
		position: relative;
		left: -40px;
		top: -50px;
		float: right;	
	}
	
	button.btn_register {
		margin: 40px 0px 100px 0px;
		width: 100%;
		height: 80px;
		background-color: #cccccc;
		color: white;
	}
	
	label {
		font-weight: bold;
	}
	button.check{
		color:#ffffff !important; 
		border: solid 1px #cccccc; 
		background-color:#FFA751;
		width:100px;
		font-size: 10pt;
	}
	button.check_success{
		color:#ccc !important; 
		border: solid 1px #cccccc; 
		font-size: 10pt;
		background-color:##ffffff;
		width:100px;
	}
	button#find_address{
		color:#ffffff !important; 
		font-weight:bold; 
		background-color:#FFA751;
	}
</style>


<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
	let email_flag = false ; // 중복확인을 통과하면 true
	let id_flag = false ;
	let pwd_flag = false ;
	let birth_Flag = false;
	$(document).ready(function(){
		setEventHandling();
		
	});
	
	function setEventHandling(){
		// 회원 가입 페이지 로드시 조건들
		loadPage();
		
		//성명
		$('input#name').on('input', nameCheck);
		
		// ID 유효성 검사 및 중복 검사 
		$('input#inputId1').on('input',idCheck);
		$('button.idcheck').click(idDuplicateCheck);
		
		// PWD 유효성 검사 및 비밀번호 일치 검사
		$('input#inputPwd1').on('input',pwdCheck);
		$('input#inputPwd2').on('input',pwdSame);
		
		// 이메일 유효성 검사 및 중복 검사
		$('input#inputEmail1').on('input',EmailCheck);
		$('select.email_sel').on('change',EmailCheck);
		
		$('button.emailcheck').click(emailDuplicateCheck);
		
		// 휴대폰 번호에 숫자만 입력가능
		$('input.mobile1, input.mobile2').on({
			'keyup':mobileCheck1,
			'blur':mobileCheck2
		});
		
		
		// 우편번호 찾기 클릭시 
		$("button#find_address").click(addressDaum);
		
		$('#birthyy, #birthmm, #birthdd').on('change', validDate);
	 	
	
	} // END OF FUNCTION SETEVENTHANDLING()
	
	
	function loadPage(){

		$('input#inputId1').focus();
		
		createMonth();
		createDay();
		createYear();
   
	}// END OF FUNCTION LOADPAGE()
	
	//날짜 유효성 func 만들기 
	function validDate() {

	    const year = parseInt($('#birthyy').val());
	    const month = parseInt($('#birthmm').val());
	    const day = parseInt($('#birthdd').val());
	    
	    if (isNaN(year) || isNaN(month) || isNaN(day)) {
	        return;
	      }
	    const date = new Date(year, month - 1, day);
	    
	    
	    if (date.getFullYear() !== year || date.getMonth() !== month - 1 || date.getDate() !== day) {
	        const lastDayOfMonth = new Date(year, month, 0).getDate();
	        $('#dateWarning').text(` \${year}년 \${month}월은 \${lastDayOfMonth}일 까지입니다.`);
	        birth_Flag = false;
	      } else {
	        $('#dateWarning').text('');
	        birth_Flag = true;
	      }
	}// end of valiDate

	function createYear(){
		const date = new Date();
		   const year = date.getFullYear();
		   $('select#birthyy').append("<option selected disabled value=''>선택</option>")
		     for (let i = year; i >= year - 100; i--) {
		       $('select#birthyy').append($('<option>', {
		         value: i,
		         text: i
		       }));
		     }
	}// END OF FUNCTION CREATEYEAR(){
	
	function createMonth(){
		let html = "";
			html += "<option selected disabled value=''>선택</option>";
		for(let i=1; i<=12; i++) {		
			if(i<10){
				html += "<option>0"+i+"</option>";
			}
			else{
				html += "<option>"+i+"</option>";
			}
		} //end of for ----------------------------------------------
		
		$("select#birthmm").html(html);
		
		
	}; // 
	
	function createDay(){
		let html = ``;
	    	html += "<option selected disabled value=''>선택</option>";
	      for(let i=1; i<=31; i++) {	    	
	         if(i<10) {
	            html += `<option>0\${i}</option>`;
	         }
	         else {
	            html += `<option>\${i}</option>`;
	         }
	      }
	      $("select#birthdd").html(html);

	} // 
	
	
	function btnFlag(flag,id){
		if( flag ){ // 중복확인이 된 경우
			$('button.'+id).removeClass("check");
			$('button.'+id).addClass("check_success");
			$('button.'+id).text("확인완료");
		}
		else{
			$('button.'+id).removeClass("check_success");
			$('button.'+id).addClass("check");
			$('button.'+id).text("중복확인");
		}
		
		
	} // END OF FUNCTION BTNFLAG 
	
	function idDuplicateCheck(e){
		if ( $('span#error_id').text() != "" || $("input#inputId1").val() == ""){
			alert('아이디 입력 형식에 맞게 정확히 입력해주세요.');
			return ;
		}
		
		$.ajax({  
     	   url:"<%=ctxPath %>/register/checkDuplicateId.dak" , 
     	   data:{"userid":$("input#inputId1").val() } , 
     	   type:"post" , 
     	   dataType: "json" , 
             async:false ,
             success:function(json){
             	if(json["isExists"]){ // 입력한 userid 가 이미 사용중이라면 
             		$("input#userid").val("");
             		alert("이미 사용중인 아이디입니다.");
             	}
             	else if( !json.isExists && $("input#inputId1").val().trim() != ""){
             		id_flag = true ;
            		btnFlag(id_flag,'idcheck');
             	}
            							
             },
             error: function(request, status, error){
                 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
               }
       	}); // end of $.ajax 
		
		
	}// END OF FUNCTION IDDUPLICATECHECK
	
	function nameCheck(e) {
		const inputName = $("input#name").val();
		
		
		const regExp = /^[가-힣]{2,10}$/;
		if (!regExp.test(inputName)) {
			$("span#error_name").text("한글 2자~10자만 입력 가능합니다.");
		} else {
			$("span#error_name").text("");
		}
			
		
	}
	
	function idCheck(e){
		id_flag = false ;
		btnFlag(id_flag,'idcheck');
		
		const regExp = /^[a-z0-9]{4,16}$/g; 
		const bool = regExp.test($(e.target).val());
		const error_id = $('span#error_id') ;
		if( $(e.target).val().length < 4 || $(e.target).val().length > 16 ){
			error_id.text("4 ~ 16자 사이이어야 합니다.") ;
		}
		else if(!bool) {
			// 아이디가 정규표현식에 위배된 경우
			error_id.text("4~16자 이상 소문자 또는 숫자만 사용 가능") ;
		}
		else {
			// 아이디가 정규표현식에 맞는 경우
			error_id.text("") ;	
		}
		
	} // END OF FUNCTION IDCHECK(E){	
		
	function pwdCheck(e){
		const regExp= /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{6,16}$/;
		// console.log($('input#inputPwd1').val().length);
		// console.log($(e.target).val().length);
		const target_val = $(e.target).val();
		const bool = regExp.test(target_val);
		
		if ( target_val.length < 6 || target_val.length > 16  ){
			// $(e.target).parent().find("span#error_pwd").text("6 ~ 16자 영문,숫자,특수문자 1개 이상씩 혼용 필수");
			$('span#error_pwd').text("6 ~ 16자 사이이어야 합니다.");
		}
		else if ( !bool ){ // 정규표현식 조건에 맞지 않는 경우
			$('span#error_pwd').text("6 ~ 16자 영문,숫자,특수문자 1개 이상씩 혼용 필수");
		}
		else{
			$('span#error_pwd').text("");
		}
	
	} // END OF FUNCTION PWDCHECK()
	function pwdSame(e){
		const pwd1 = $('input#inputPwd1').val(); // 비밀번호
		const pwd2 = $(this).val(); // 비밀번호 확인 
		
		if ( pwd1 == pwd2 ){
			$('span#error_pwd_check').text("");
		}
		else{
			$('span#error_pwd_check').text("비밀번호가 일치하지 않습니다.");
		}
		
		
	}// END OF FUNCTION PWDSAME()
	
	function EmailCheck(e){
		email_flag = false ;
		btnFlag(email_flag,'emailcheck');
	
		if(  $('select.email_sel').val() == 'other' ){
			const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			const bool = regExp.test( $('input#inputEmail1').val() );
			
			if( !bool ){ // 이메일이 정규표현식에 위배된 경우
				$('span#error_email').text("이메일이 적합한 형식이 아닙니다.");
			}
			else{ // 이메일이 정규표현식에 위배되지않은경우
				$('span#error_email').text("");		
			}
			
		}// end of if 
		else{
			const regExp = /^(?=.{4,16})(?!.*[^a-z0-9\-_])[a-z0-9\-_]*$/
			const bool = regExp.test( $('input#inputEmail1').val() );
			
			if ( !bool ){
				$('span#error_email').text("도메인을 제외한 이메일 아이디를 정확하게 입력해주세요.");
			}
			else{
				$('span#error_email').text("");
			}
			
		}// end of else 
	
	
	
	}// END OF FUNCTION EMAILCHECK
	
	function emailDuplicateCheck(){
		if ($('span#error_email').text() != "" || $("input#inputEmail1").val() == ""){
			alert('이메일을 정확하게 입력해주세요.');
			return ;
		}
		
		const inputEmail = $("input#inputEmail1").val();
		const emailSelected = $("select#emailSelector").val();
		let email = "";
		if(emailSelected == "other") {
			email = inputEmail;	
		} else {
			email = inputEmail + emailSelected;
		}
		
		
		$.ajax({
	      	url:"<%=ctxPath%>/register/checkDuplicateEmail.dak",
	      	data:{"email":email},
	      	type:"post", // 생략시 get
	      	dataType:"json",
	      	async:false,
	      	success:function(json) {
	      		
	      		if(json["isExists"]) {
	      			alert("이미 존재하는 이메일입니다.\n다른 이메일 주소를 입력해주세요.");
	      		} else {

	      			email_flag = true ;
	      			btnFlag(email_flag,'emailcheck');
	      			
	      		}
	      	},
	      	error: function(request, status, error){
	              alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
	      });
		
		
		
	}// END OF EMAILDUPLICATECHECK
	
	function mobileCheck1(e){
		var val = $(this).val();
	    
	    // 숫자 이외의 값이 입력되었다면
	    if (isNaN(val)) {
	      // 값을 빈 문자열로 변경
	      $(this).val('');
	    }
		
	}// END OF MOBILECHECK
	
	function mobileCheck2(e){
			const regExp = /^[0-9]{4}$/g;
			const regExp2 = /^[0-9]{4}$/g;
		    const bool1 = regExp.test($('input.mobile1').val());
		    const bool2 = regExp2.test($('input.mobile2').val());
			if ( !bool1 || !bool2 ){
				$('span#error_mobile').text("4자리 숫자만 입력이 가능합니다."); 
			}
			else{
				$('span#error_mobile').text("");
			}	
	}// 
	
	function addressDaum(){
		new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let addr = ''; // 주소 변수
                let extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    addr += extraAddr ;
                
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();	
	
	} // END OF function addressDaum(){
		
	function goRegister(){
		
		
		// 아이디
		if($('input#inputId1').val() == ""){
			alert('아이디는 필수 입력사항입니다.');
			return ;
		}
		if (!id_flag){
			alert('아이디 중복확인을 클릭해주세요');
			return ;
		}
		
		// 비밀번호 
		if( $('input#inputPwd1').val() == "" || $('input#inputPwd2').val() == ""){
			alert('비밀번호와 비밀번호 확인은 필수 입력사항입니다.');	
			return ;
		}
		
		if ( $('span#error_pwd').text() != "" || $('span#error_pwd_check').text() != ""  ){
			alert('비밀번호와 비밀번호확인은 조건에 따라 입력하셔야 합니다.');
			return ;
		}
		
		// 이메일 	
		if( $('input#inputEmail1').val() == "" ) {
			alert('이메일은 필수 입력사항입니다.');	
			return ;
		}
		
		if( !email_flag ){
			alert('이메일 중복확인을 클릭해주세요');
			return ;
		}
		
		// 주소
		// console.log($('input#postcode').val());
		if ($('input#postcode').val() == ""){
			alert('우편주소를 입력해주세요');
			return ;
		}

		// 성별 
		const genderSelect = $("#gender");
		if (!genderSelect.val()) {
			 alert("성별을 선택해주세요.");
			 return ;
		}
		// 생년월일
		const birthyySelect = $("#birthyy");
		if (!birthyySelect.val()) {
			 alert("년도를 선택해주세요.");
			 return ;
		}
		
		const birthmmSelect = $("#birthmm");
		if (!birthmmSelect.val()) {
			 alert("월을 선택해주세요.");
			 return ;
		}
		const birthddSelect = $("#birthdd");
		if (!birthddSelect.val()) {
			 alert("일을 선택해주세요.");
			 return ;
		}
		if(!birth_Flag) {
			alert("올바른 생년월일을 선택해주세요.");
			return;
		}
		//////////////////////////////////////
		const myfrm = document.myfrm;
		
		const inputEmail = $("input#inputEmail1").val();
		const emailSelected = $("select#emailSelector").val();
		if(emailSelected == "other") {
			myfrm.email.value = inputEmail;	
		} else {
			myfrm.email.value = inputEmail + emailSelected;
		}
		
		
		myfrm.action = "register.dak"
		myfrm.method = "post";
		myfrm.submit();
		
	}// END OF FUNCTIO GOREGISTER
	
</script>



<div id="container" style="margin-top: 50px; margin-bottom:50px;">

	<h2 style="margin: 50px 0 30px 30px; position: relative; left: 50px; font-weight: 700;">회원가입</h2>
	
	<form name="myfrm">
		  <label for="name">이름<span class="star">*</span></label>
		  <div class="form-group" style="width:100%; display:flex; margin-bottom: 0;">
		    <input type="text" class="form-control input_height" id="name" name="name" aria-describedby="emailHelp" placeholder="한글만 입력가능">
		  </div>
		  	<div><span id="error_name" style="color:red;"></span></div>
		  
		  <label for="inputId1">아이디<span class="star">*</span></label>
		  <div class="form-group" style="width:100%; display:flex; margin-bottom: 0;">
		    <input type="text" class="form-control input_height" id="inputId1" name="userid" aria-describedby="emailHelp" placeholder="4~16자 이상 영문 또는 숫자만 사용 가능">
		  	<button type="button" class="btn idcheck check mx-5">중복확인</button>
		  </div>
		  	<div><span id="error_id" style="color:red;"></span></div>
		  
		  <div class="form-group">
		    <label for="exampleInputPassword1">비밀번호<span class="star">*</span></label>
		    <input type="password" class="form-control input_height" id="inputPwd1" name="pwd" placeholder="6 ~ 16자 영문,숫자,특수문자 1개 이상씩 혼용 필수">
			  <div><span id="error_pwd" style="color:red;"></span></div>
		    <br>
		    <input type="password" class="form-control input_height" id="inputPwd2" placeholder="비밀번호 확인">
			  <div><span id="error_pwd_check" style="color:red;"></span></div>
		  </div>
		  
		  <label for="inputEmail1">이메일<span class="star">*</span></label>
		  <div class="form-group" style="width:100%; display:flex; margin-bottom: 0px;"> 
		    <input type="text" class="form-control input_height" id="inputEmail1" aria-describedby="emailHelp" placeholder="이메일 주소" style="width:230px;">
		    <input type="hidden" name="email">
		  	<div class="form-group mx-3" style="margin-bottom: 0px;">
		      <select class="form-control email_sel" id="emailSelector" style="height:50px; width:180px" onchange="EmailCheck()">
		        <option value="other" selected>직접입력</option>
		        <option value="@naver.com">naver.com</option>
		        <option value="@hanmail.com">hanmail.com</option>
		        <option value="@daum.net">daum.net</option>
		        <option value="@google.com">google.com</option>
		        <option value="@gmail.com">gamil.com</option>
		      </select>
		      
		    </div>
		    <button type="button" class="btn emailcheck check" style="height: 50.22222px !important;
    														width: 106px !important;">중복확인</button>
		  </div>
		  
		  <div><span id="error_email" style="color:red;"></span></div>
		  
		  <label for="exampleInputphonenum1">연락처<span class="star">*</span></label>
		  <div class="form-group phonenum">
		    <input type="text" class="form-control exampleInputphonenum" id="exampleInputphonenum1" name="mobile0" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
		    <input type="text" class="form-control exampleInputphonenum mobile1" name="mobile1" maxlength="4" />&nbsp;-&nbsp;
		    <input type="text" class="form-control exampleInputphonenum mobile2" name="mobile2" maxlength="4" />
		  </div>
		  <div><span id="error_mobile" style="color:red;"></span></div>
		  
		  <label for="exampleInput">우편번호<span class="star">*</span></label>
		  <div style="display:flex;">
			  <input type="text" id="postcode" name="postcode" size="6" maxlength="5" class="form-control input_height" readonly style="width:100px;"/>
			  <%-- 우편번호 찾기 --%>
	     	  <button type="button" class="btn mx-3" id="find_address">우편주소 찾기</button>
	     </div>  
		 
		 <label for="address">주소</label>
		 <div class="row">
			<input type="text"  id="address" class="form-control  col-md-5 mx-3" name="address" placeholder="주소" readonly/><br/>
            <input type="text" id="detailAddress" class="form-control col-md-5 mx-3" name="detailAddress"  placeholder="상세주소" />
        </div> 
		 
		 <label for="gender">성별</label>
		 <div class="form-group">
		      <select class="form-control" id="gender" name="gender">
		        <option value="" selected disabled>성별선택</option>
		        <option value="1" >남자</option>
		        <option value="2" >여자</option>
		      </select>
		 </div>
		 
		 <label for="exampleInputgender">생년월일</label>
		 
		 <div class="row">
		 		<select id="birthyy" name="birthyy" class="mx-3 col-md-2" style="width: 100px !important; padding: 8px;"></select>
		    	<select id="birthmm" name="birthmm" class="mx-3 col-md-2" style="width: 60px; padding: 8px;"></select>
            	<select id="birthdd" name="birthdd" class="mx-3 col-md-2" style="width: 60px; padding: 8px;"></select> 
		 </div>
		 <div><span id="dateWarning" style="color:red;"></span></div>
		 
		 <div class="row my-5">
		 	<div class="col-md-10">
		 		<button type="button" class="btn btn_register" style="border: 1px solid gray" onclick="goRegister()">가입하기</button>
			</div>
		</div>
	</form>



</div>



<jsp:include page="/WEB-INF/views/footer.jsp"/>
