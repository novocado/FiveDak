<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%> 

<jsp:include page="/WEB-INF/views/member/serviceSidebar.jsp"/>

<style type="text/css">
.board_wrap {
    margin: 30px auto;
}

.board_title {
    margin-bottom: 30px;
}

.board_title strong {
    font-size: 30px;
}

.board_title p {
    margin-top: 5px;
    font-size: 15px;
}

.bt_wrap {
    margin-top: 30px;
    text-align: center;
    font-size: 0;
}

.bt_wrap a {
    display: inline-block;
    min-width: 80px;
    margin-left: 10px;
    padding: 10px;
    border: 1px solid #FF7E32;
    border-radius: 2px;
    font-size: 15px;
}

.bt_wrap a:first-child {
    margin-left: 0;
}

.bt_wrap a.on {
    background: #FF7E32;
    color: #fff;
}

.board_page {
    margin-top: 30px;
    text-align: center;
    font-size: 0;
}

.board_page a {
    display: inline-block;
    width: 32px;
    height: 32px;
    box-sizing: border-box;
    vertical-align: middle;
    border: 1px solid #ddd;
    border-left: 0;
    line-height: 100%;
}

.board_page a.bt {
    padding-top: 10px;
    font-size: 15px;
    letter-spacing: -1px;
}

.board_page a.num {
    padding-top: 9px;
    font-size: 16px;
}

.board_page a.num.on {
    border-color: #FF7E32;
    background: #FF7E32;
    color: #fff;
}

.board_page a:first-child {
    border-left: 1px solid #ddd;
}
.board_view {
    width: 100%;
    border-top: 2px solid #000;
}

.board_view .title {
    padding: 20px 15px;
    border-bottom: 1px dashed #ddd;
    font-size: 16px;
}

.board_view .info {
    padding: 15px;
    border-bottom: 1px solid #999;
    font-size: 0;
}

.board_view .info dl {
    position: relative;
    display: inline-block;
    padding: 0 20px;
}

.board_view .info dl:first-child {
    padding-left: 0;
}

.board_view .info dl::before {
    content: "";
    position: absolute;
    top: 1px;
    left: 0;
    display: block;
    width: 1px;
    height: 13px;
    background: #ddd;
}

.board_view .info dl:first-child::before {
    display: none;
}

.board_view .info dl dt,
.board_view .info dl dd {
    display: inline-block;
    font-size: 16px;
}

.board_view .info dl dd {
    margin-left: 10px;
    color: #777;
}

.board_view .cont {
    padding: 15px;
    border-bottom: 1px solid #000;
    line-height: 160%;
    font-size: 16px;
}
.board_write {
    border-top: 2px solid #000;
}

.board_write .title,
.board_write .info {
    padding: 15px;
    border-bottom: 1px solid #999;
}

.board_write .info {
    border-top: 1px dashed #ddd;
    border-bottom: 1px solid #000;
    font-size: 0;
}

.board_write .title dl {
    font-size: 0;
}

.board_write .info dl {
    display: inline-block;
    width: 50%;
    vertical-align: middle;
}

.board_write .title dt,
.board_write .title dd,
.board_write .info dt,
.board_write .info dd {
    display: inline-block;
    vertical-align: middle;
    font-size: 15px;
}

.board_write .title dt,
.board_write .info dt {
    width: 100px;
}

.board_write .title dd {
    width: calc(100% - 100px);
}

.board_write .title input[type="text"],
.board_write .info input[type="text"],
.board_write .info input[type="password"] {
    padding: 10px;
    box-sizing: border-box;
}

.board_write .title input[type="text"] {
    width: 80%;
}

.board_write .cont {
    border-bottom: 1px solid #000;
}

.board_write .cont textarea {
    display: block;
    width: 100%;
    height: 300px;
    padding: 15px;
    box-sizing: border-box;
    border: 0;
    resize: vertical;
}
.button1 {width:100px; box-sizing: border-box; display: inline-block; *zoom: 1; *display: inline; vertical-align: middle; border: 1px solid; border-color: #999; text-align: center; overflow: hidden; text-decoration: none!important; cursor: pointer; border-radius: 3px; background-color: #fff;}
.button2 {width:100px; margin-right: 10px; box-sizing: border-box; display: inline-block; *zoom: 1; *display: inline; vertical-align: middle; border: 1px solid; border-color: #c82370; text-align: center; overflow: hidden; text-decoration: none!important; cursor: pointer; border-radius: 3px; background-color: #ff7E32;}
span.button_gray {color:#555; padding:13px 20px 14px 20px; box-sizing: border-box; display: block; font-size: 15px; font-weight: bold;}
span.button_orange {color:#fff; padding:13px 20px 14px 20px; box-sizing: border-box; display: block; font-size: 15px; font-weight: bold;} 
.button2 span:hover {text-decoration: none!important; background: #ff7232!important; padding:13px 20px 14px 20px; }
.button1 span:hover {text-decoration: none!important; background: #fafafa!important; padding:13px 20px 14px 20px; }

</style>

<script type="text/javascript">

$(document).ready(function(){
	

	$("span.button_orange").click(function(){
		
		const num = $("div.title").find(".num").text();
		const frm = document.boardEditFrm;
		frm.action = "informBoardEditEnd.dak?num="+num;
		frm.method = "post";
		frm.submit();
	});
	
});

</script>

<body>
    <div class="board_wrap">
        <div class="board_title">
            <strong>공지사항</strong>
            <p>공지사항을 안내해드립니다.</p>
        </div>
        
        <form name="boardEditFrm">
        	<div class="board_write_wrap">
        	
	        		<c:if test="${not empty requestScope.ndto}">
		        		<div class="board_write">
			                <div class="title">
			                	<dl>
			                        <dt>글번호</dt>
			                        <dd class="num">${ndto.note_id}</dd>
			                    </dl>
			                    <dl>
			                        <dt>제목</dt>
			                        <dd><input name="title" type="text" value="${ndto.note_title}"></dd>
			                    </dl>
			                </div>
			
			                <div class="cont">
			                    <textarea name="content">${ndto.note_content}</textarea>
			                </div>
			            </div>
		            </c:if>
		            
		            <c:if test="${empty requestScope.ndto}">
		            	<div class="board_write">
			                <div class="title">
			                	<dl>
			                        <dt>글번호</dt>
			                        <dd></dd>
			                    </dl>
			                    <dl>
			                        <dt>제목</dt>
			                        <dd><input name="title" type="text" placeholder=""></dd>
			                    </dl>
			                </div>
			
			                <div class="cont">
			                    <textarea name="content" placeholder=""></textarea>
			                </div>
			            </div>
		            </c:if>
		            
		            <div class="bt_wrap" style="list-style: none">
		                <button type="button" class="button2" name="button2"><span class="button_orange">등록</span></button>
		                <button type="button" class="button1" name="button1" onClick="location.href='informBoardList.dak'"><span class="button_gray">취소</span></button>
		            </div>
		    	
        	</div>
        </form>
        
    </div>
</body>
</html>