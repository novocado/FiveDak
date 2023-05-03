<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

.bt_wrap .button1 .button2 {
    display: inline-block;
    min-width: 80px;
    margin-left: 10px;
    padding: 10px;
    border: 1px solid #FF7E32;
    border-radius: 2px;
    font-size: 15px;
}

.bt_wrap .button1 {
    margin-left: 0;
}

.bt_wrap a.on {
    background: #FF7E32;
    color: #fff;
}

.button1 {width:187px; margin-right:2px; box-sizing: border-box; display: inline-block; *zoom: 1; *display: inline; vertical-align: middle; border: 1px solid; border-color: #999; text-align: center; overflow: hidden; text-decoration: none!important; cursor: pointer; -webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; background-color: #fff;}
.button2 {width:187px; box-sizing: border-box; display: inline-block; *zoom: 1; *display: inline; vertical-align: middle; border: 1px solid; border-color: #c82370; text-align: center; overflow: hidden; text-decoration: none!important; cursor: pointer; -webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; background-color: #ff7E32;}
span.button_gray {color:#555; width:187px; padding:13px 20px 14px 20px; box-sizing: border-box; display: block; font-size: 15px; font-weight: bold;}
span.button_orange {color:#fff; width:187px; padding:13px 20px 14px 20px; box-sizing: border-box; display: block; font-size: 15px; font-weight: bold;} 
.button2 span:hover {text-decoration: none!important; background: #ff7232!important; width:187px; padding:13px 20px 14px 20px; }
.button1 span:hover {text-decoration: none!important; background: #fafafa!important; width:187px; padding:13px 20px 14px 20px; }

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
    font-size: 1.2rem;
    letter-spacing: -1px;
}

.board_page a.num {
    padding-top: 9px;
    font-size: 1.4rem;
}

.board_page a.num.on {
    border-color: #FF7E32;
    background: #FF7E32;
    color: #fff;
}

.board_page a:first-child {
    border-left: 1px solid #ddd;
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
</style>

<script type="text/javascript">

$(document).ready(function(){
	

	$("span.button_orange").click(function(){
		
		const frm = document.boardWriteFrm;
		frm.action = "InformBoardWriteEnd.dak";
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
        
        <form name="boardWriteFrm">
        	<div class="board_write_wrap">
        		<div class="board_write">
	                <div class="title">
	                    <dl>
	                        <dt>제목</dt>
	                        <dd><input name="title" type="text" placeholder="제목 입력"></dd>
	                    </dl>
	                </div>
	
	                <div class="cont">
	                    <textarea name="content" placeholder="내용 입력"></textarea>
	                </div>
	            </div>
	            
	            <div class="bt_wrap" style="list-style: none">
	                <button type="button" class="button2" name="button2"><span class="button_orange">등록</span></button>
	                <button type="button" class="button1" name="button1" onClick="location.href='informBoardList.dak'"><span class="button_gray">취소</span></button>
	            </div>
        	</div>
        </form>
        
    </div>
</body>
      <!-- 오른쪽에 들어갈 내용 -->
</div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>