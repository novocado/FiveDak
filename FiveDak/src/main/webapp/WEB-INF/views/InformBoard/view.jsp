<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    font-size: 15px;
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
.cont {
	height: 300px;
}


</style>

<%--
<c:if test="${not empty requestScope.mvo}">
   <h3>::: ${requestScope.mvo.name}님의 회원 상세정보 :::</h3>

   <div id="mvoInfo">
    <ol>   
       <li><span class="myli">아이디 : </span>${mvo.userid}</li>
       <li><span class="myli">회원명 : </span>${mvo.name}</li>
       <li><span class="myli">이메일 : </span>${mvo.email}</li>
       <li><span class="myli">휴대폰 : </span>${fn:substring(mobile, 0, 3)}-${fn:substring(mobile, 3, 7)}-${fn:substring(mobile, 7, 11)}</li>
       <li><span class="myli">우편번호 : </span>${mvo.postcode}</li>
       <li><span class="myli">주소 : </span>${mvo.address}&nbsp;${mvo.detailaddress}&nbsp;${mvo.extraaddress}</li>
       <li><span class="myli">성별 : </span><c:choose><c:when test="${mvo.gender eq '1'}">남</c:when><c:otherwise>여</c:otherwise></c:choose></li> 
       <li><span class="myli">생년월일 : </span>${fn:substring(birthday, 0, 4)}.${fn:substring(birthday, 4, 6)}.${fn:substring(birthday, 6, 8)}</li> 
       <li><span class="myli">나이 : </span>${mvo.age}세</li> 
       <li><span class="myli">코인액 : </span><fmt:formatNumber value="${mvo.coin}" pattern="###,###" /> 원</li>
       <li><span class="myli">포인트 : </span><fmt:formatNumber value="${mvo.point}" pattern="###,###" /> POINT</li>
       <li><span class="myli">가입일자 : </span>${mvo.registerday}</li>
     </ol>
   </div>
   
</c:if>
 --%>

<body>
    <div class="board_wrap">
        <div class="board_title">
            <strong>공지사항</strong>
            <p>공지사항을 안내해드립니다.</p>
        </div>
        <div class="board_view_wrap">
            <div class="board_view">
            <c:if test="${empty requestScope.ndto}">
			   <div class="title">
                </div>
                <div class="info">
                    <dl>
                        <dt>번호</dt>
                        <dd></dd>
                    </dl>
                    <dl>
                        <dt>작성일</dt>
                        <dd></dd>
                    </dl>
                </div>
                <div class="cont">
                </div>
			</c:if>

			<c:if test="${not empty requestScope.ndto}">
                <div class="title">
                    ${ndto.note_title}
                </div>
                <div class="info">
                    <dl>
                        <dt>번호</dt>
                        <dd>${ndto.note_id}</dd>
                    </dl>
                    <dl>
                        <dt>작성일</dt>
                        <dd>${ndto.note_created_at}</dd>
                    </dl>
                </div>
                <div class="cont">
                    ${ndto.note_content}
                </div>
            </c:if>
            
            </div>
            <div class="bt_wrap">
                <a href="<%= ctxPath%>/CSC/informBoardList.dak" class="on">목록</a>
                <a href="<%= ctxPath%>/CSC/informBoardEdit.dak">수정</a>
            </div>
        </div>
    </div>

    
          <!-- 오른쪽에 들어갈 내용 -->
</div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>