<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
%> 


<jsp:include page="/WEB-INF/views/member/mypageSidebar.jsp"/>

<style type="text/css">
   div {
    color: #333;
    font-size: 14px;
    font-weight: 400;
    font-family: "Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif;
    word-break: break-all;
    margin: 0;
    padding: 0;
    border: 0;
}
/* .MPE1{
   width: 1000px;
    min-width: 320px;
    padding: 0 30px;
    float: right;
} */
.MPE2{
    width: 820px;
}
.MPE3{
    position: relative;
    min-height: 30px;
}
.MPE4 {
    display: inline-block;
    font-size: 24px;
    font-weight: 500;
}
.MPE5 {
    width: 100%;
    border-top: 1px solid #666;
    border-bottom: 0;
    margin-top: 10px;
}
.MPE6 {
    background: #F9F9F9;
    padding: 100px 0;
}
.MPE7 {
    padding: 0 175px;
}
.MPE8 {
    font-size: 18px;
    margin-bottom: 5px;
    font-weight: 500;
}
.MPE9 {
    word-break: break-all;
    color: #666;
    line-height: 22px;
    margin-bottom: 20px;
}
.MPE10 {
    position: relative;
    display: table;
    border-collapse: collapse;
    width: 100% !important;
    height: 50px;
}
input#MPE11password {
    border-collapse: collapse;
    vertical-align: middle;
    font: inherit;
    margin: 0;
    appearance: none;
    overflow: visible;
    background: #fff;
    color: #333;
    box-sizing: border-box;
    position: relative;
    display: table-cell;
    float: left;
    width: 100%;
    z-index: 2;
    height: 50px;
    padding: 3px 15px;
    background-color: #fff;
    border: 1px solid #ccc;
    font-size: 13px;
    border-radius: 6px;
 }
.MPE12 {
    display: table-cell;
    position: relative;
    white-space: nowrap;
    width: 1%;
    vertical-align: middle;
    border: 0;
    padding: 0 0 0 6px;
 }
 .MPE13 {
    white-space: nowrap;
    font: inherit;
    box-sizing: border-box;
    overflow: visible;
    text-transform: none;
    font-family: "Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif;
    outline: none;
    margin: 0;
    appearance: none;
    cursor: pointer;
    display: inline-block;
    text-align: center;
    border-radius: 3px;
    background: #FF7E32;
    color: #fff;
    border: 1px solid #FF7E32;
    height: 50px;
    padding: 0 10px;
    min-width: auto;
    width: 100px;
    font-size: 15px;
 }
</style>
<script type="text/javascript">

	$(document).ready(function(){
		$("button#checkPwdBtn").on('click',passwdCheck); 
		
	});
	
	function passwdCheck() {
		$.ajax({  
	     	   url:"<%=ctxPath %>/mypage/infoedit.dak" , 
	     	   data:{"password":$("input#password").val() , "userid":"${sessionScope.loginuser.mbrId}"} , 
	     	   type:"post" , 
	             async:true ,
	             success:function(result){
	            	 
	            	 
	             	if(result.trim() == 'false') {
	             		alert("비밀번호가 일치하지 않습니다.");
	             	} else {
	             		$("div#editInfoBox").html(result);
	             	}
	            							
	             },
	             error: function(request, status, error){
	                 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	               }
	       	}); // end of $.ajax 
	}

</script>

<div id="editInfoBox">
<form name="pwdCheckForEdit" onsubmit="return false;">
	<div class="MPE1" id="memberInfoContents">
	    <div class="MPE2">
	        <div class="MPE3">
	            <h3 class="MPE4">회원정보수정 </h3>
	        </div><!--// menu-title-area -->
	        <div class="MPE5 type3">
	            <div class="MPE6">
	                <div class="MPE7">
	                    <h4 class="MPE8">비밀번호를 입력해주세요.</h4>
	                    <p class="MPE9">회원님의 개인정보 보호를 위해 비밀번호를 다시 한번 확인 합니다.<br>비밀번호가 노출되지 않도록 주의해주세요.</p>
	                    <div class="MPE10 type-lg w-full">
	                        <input id="password" type="password" id="MPE11password" name="password" class="input-text" placeholder="비밀번호 입력">
	                        <span class="MPE12"><button type="button" id="checkPwdBtn" class="MPE13 btn-primary btn_submit"><span>확인</span></button></span>
	                    </div>
	                </div>
	            </div><!--// input-guide-box -->
	        </div><!--// board-form -->
	    </div><!--// frame-cnt-inner -->
</div>
</form>
</div>
 </div>
  </div>
</div>


<jsp:include page="/WEB-INF/views/footer.jsp"/>

