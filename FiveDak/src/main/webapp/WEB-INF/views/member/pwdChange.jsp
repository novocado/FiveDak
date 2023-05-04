<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header-final.jsp" />
    
<style type="text/css"> 

	.box_pwdChange { border:1px solid #e4e4e4; width:930px; margin:20px auto; background:#fbfbfb; padding: 65px 0 85px 0; box-sizing: border-box; font-family: "Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif; }
	.box_pwdChange .password_title {width:667px; height:128px; margin:80px auto 30px auto;}        
    .box_pwdChange .password_txt {font-size:13px; color:#666; width:360px; padding:5px 0 45px 0px; margin:0 auto;}
    .box_pwdChange .password_title1 {font-size: 36px; color:#333; line-height: 160%; font-weight: 600; padding-bottom: 13px; letter-spacing: -0.05em; text-align: center;}
    .box_pwdChange .password_title1 span {color:#ff7E32;}
    .box_pwdChange .password_title2 {margin-left: 180px;} 
    .box_pwdChange .password_box {width:384px; margin:35px auto 10px auto;}
    .box_pwdChange .input-box {position:relative; margin:10px 0; background: #fff; }
    .box_pwdChange .input-box > input{ background:transparent; border:none; border: solid 1px #ccc; padding:27px 0px 7px 5px; font-size:14pt; width:100%;  display: block; border-radius: 3px;}
      
    .box_pwdChange .input-box > input:placeholder-shown + label{ color:#555; font-size:19px; top:20px;  left: 13px;  font-weight: 400;  }
    .box_pwdChange .input-box > input::placeholder{ color:transparent; }
    .box_pwdChange .input-box > input:-ms-input-placeholder {color:transparent; }
    .box_pwdChange .input-box > input:focus + label, label{ color:#333; font-size:11pt; pointer-events: none; position: absolute; left: 5px; top:5px; transition: all 0.2s ease ; -ms-transition: all 0.2s ease; -webkit-transition: all 0.2s ease; -moz-transition: all 0.2s ease; -o-transition: all 0.2s ease; }
    .box_pwdChange .input-box > input:focus, input:not(:placeholder-shown){ border-bottom: solid 1px #ccc; outline:none; }
    .wrap_button {width:400px; margin: auto; display: flex; align-items: center;}
    
    .box_pwdChange .password_button1 {width:187px; margin-right:10px; box-sizing: border-box; display: inline-block; *zoom: 1; *display: inline; vertical-align: middle; border: 1px solid; border-color: #999; text-align: center; overflow: hidden; text-decoration: none!important; cursor: pointer; -webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; background-color: #fff;}
    .box_pwdChange .password_button2 {width:187px; box-sizing: border-box; display: inline-block; *zoom: 1; *display: inline; vertical-align: middle; border: 1px solid; border-color: #c82370; text-align: center; overflow: hidden; text-decoration: none!important; cursor: pointer; -webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; background-color: #ff7E32;}
	.box_pwdChange  span.password_button_gray {color:#555; width:180px; padding:13px 20px 13px 20px; box-sizing: border-box; display: block; font-size: 15px; font-weight: bold;}
    .box_pwdChange  span.password_button_orange {color:#fff; width:180px; padding:13px 20px 13px 20px; box-sizing: border-box; display: block; font-size: 15px; font-weight: bold;} 
	.password_button2 span:hover {text-decoration: none!important; background: #ff7232!important; width:180px; padding:13px 20px 14px 20px; }
    .password_button1 span:hover {text-decoration: none!important; background: #fafafa!important; width:180px; padding:13px 20px 14px 20px; }


</style>

<script type="text/javascript">
$(document).ready(function(){
	$("span.password_button_orange").click(function(){
		const pwd = $("input#pwd").val();
		const pwd2 = $("input#chknewpassword").val();
			
		const regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
		const bool = regExp.test(pwd);
			
		if(!bool) {
			alert("암호는 8글자 이상 15글 이하의 영문자, 숫자, 특수기호가 혼합되어야만 합니다.")
			$("input#pwd").val("");
			$("input#chknewpassword").val("");
			return; // 종료
		}
		else if(bool && pwd != pwd2) {
			alert("암호가 일치하지 않습니다.")
			$("input#pwd").val("");
			$("input#chknewpassword").val("");
			return; // 종료
		}
		else {
			const frm = document.pwdChangeForm;
				
			frm.action = "memberPwdChange.dak";
			frm.method = "POST";
			frm.submit();
		}
			
	}); // end of $("button#btnUpdate").click(function(){})
		
		
}); // end of $(document).ready(function(){})
</script>


<form name="pwdChangeForm" method="post">
  
        <!-- 주기적인 비밀 번호 변경 -->    
        <div class="box_pwdChange">
            <div class="password_title1">회원님의 <span>비밀번호</span>를 변경해주세요.</div> 
            <div class="password_title2">이용자의 소중한 개인정보를 보호하기 위해 비밀번호 변경을 주기적으로 안내 드리고 있습니다.<br>안전한 서비스 이용을 위해 새로운 비밀번호로 변경해주세요.</div>   

            <div class="password_box">
                <div class="input-box"> <input type="password" id="pwd" name="pwd" placeholder="새 비밀번호를 입력하세요"> <label for="pwd">새 비밀번호</label> <span id="duplicate_pwd" style="color: red"></span></div>
                
                <div class="input-box"> <input type="password" id="chknewpassword" name="chknewpassword" placeholder="새 비밀번호를 한번 더 입력하세요"> <label for="chknewpassword">새 비밀번호 확인</label> </div>
            </div>
    
            <div class="password_txt">비밀번호는 영문자, 숫자, 특수문자를 3가지 이상 사용하여 <br> 8자 이상, 16자 이하로 설정해주세요.</div>

	        <div class="wrap_button" style="list-style: none">
	        	<button type="button" class="password_button1" name="password_button1" onClick="location.href='index.dak'"><span class="password_button_gray">나중에 변경하기</span></button>
                <button type="button" class="password_button2" name="password_button2"><span class="password_button_orange">비밀번호 변경하기</span></button>
	        </div>     
        </div>
        <!-- 주기적인 비밀 번호 변경 end --> 
</form>

<jsp:include page="../footer.jsp" />