<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%> 
<<<<<<< HEAD
<jsp:include page="/WEB-INF/views/member/mypageSidebar.jsp"/>

<style type="text/css">
.board_wrap {
    margin: 100px auto;
}

.board_title {
    margin-bottom: 30px;
}

.board_title strong {
    font-size: 30px;
}

.board_title p {
    margin-top: 5px;
    font-size: 1.4rem;
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

.board_list {
    width: 100%;
    border-top: 2px solid #000;
}

.board_list > div {
    border-bottom: 1px solid #ddd;
    font-size: 0;
}

.board_list > div.top {
    border-bottom: 1px solid #999;
}

.board_list > div:last-child {
    border-bottom: 1px solid #000;
}

.board_list > div > div {
    display: inline-block;
    padding: 15px 0;
    text-align: center;
    font-size: 16px;
}

.board_list > div.top > div {
    font-weight: 600;
}

.board_list .num {
    width: 10%;
}

.board_list .title {
    width: 60%;
    text-align: left;
}

.board_list .top .title {
    text-align: center;
}

.board_list .writer {
    width: 10%;
}

.board_list .date {
    width: 10%;
}

.board_list .count {
    width: 10%;
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


</style>

<body>
    <div class="board_wrap">
        <div class="board_title">
            <strong>공지사항</strong>
           <div class="container" style="position:relative;" >
				<div class="row" style="position: absolute; right: 0px; bottom: 0px;">
					<form method="post" class="search">
						<table class="pull-right">
							<tr>
								<td><select class="form-control" name="searchField">
										<option value="0">선택</option>
										<option value="bbsTitle">제목</option>
										<option value="userID">작성자</option>
								</select></td>
								<td><input type="text" class="form-control"
									placeholder="검색어 입력" name="searchText" ></td>
								<td><button type="submit" class="btn btn-secondary">검색</button></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
        </div>
=======
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
    font-size: 1.4rem;
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

.board_list {
    width: 100%;
    border-top: 2px solid #000;
}

.board_list > div {
    border-bottom: 1px solid #ddd;
    font-size: 0;
}

.board_list > div.top {
    border-bottom: 1px solid #999;
}

.board_list > div:last-child {
    border-bottom: 1px solid #000;
}

.board_list > div > div {
    display: inline-block;
    padding: 15px 0;
    text-align: center;
    font-size: 16px;
}

.board_list > div.top > div {
    font-weight: 600;
}

.board_list .num {
    width: 10%;
}

.board_list .title {
    width: 60%;
    text-align: left;
}

.board_list .top .title {
    text-align: center;
}

.board_list .writer {
    width: 10%;
}

.board_list .date {
    width: 10%;
}

.board_list .count {
    width: 10%;
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


</style>

<body>
    <div class="board_wrap">
        <div class="board_title">
            <strong>공지사항</strong>
           <div class="container" style="position:relative;" >
				<div class="row" style="position: absolute; right: 0px; bottom: 0px;">
					<form method="post" class="search">
						<table class="pull-right">
							<tr>
								<td><select class="form-control" name="searchField">
										<option value="0">선택</option>
										<option value="bbsTitle">제목</option>
										<option value="userID">작성자</option>
								</select></td>
								<td><input type="text" class="form-control"
									placeholder="검색어 입력" name="searchText" ></td>
								<td><button type="submit" class="btn btn-secondary">검색</button></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
        </div>
        
        
        
        
        
        

        <div class="board_list_wrap">
            <div class="board_list">
                <div class="top">
                    <div class="num">번호</div>
                    <div class="title">제목</div>
                    <div class="writer">작성자</div>
                    <div class="date">작성일</div>
                    <div class="count">조회</div>
                </div>
                <div>
                    <div class="num">5</div>
                    <div class="title"><a href="<%= ctxPath%>/CSC/informBoardView.dak">글 제목</a></div>
                    <div class="writer">이름</div>
                    <div class="date">2023.4.13</div>
                    <div class="count">33</div>
                </div>
                <div>
                    <div class="num">4</div>
                    <div class="title"><a href="<%= ctxPath%>/CSC/informBoardView.dak">글 제목</a></div>
                    <div class="writer">이름</div>
                    <div class="date">2023.4.13</div>
                    <div class="count">33</div>
                </div>
                <div>
                    <div class="num">3</div>
                    <div class="title"><a href="<%= ctxPath%>/CSC/informBoardView.dak">글 제목</a></div>
                    <div class="writer">이름</div>
                    <div class="date">2023.4.13</div>
                    <div class="count">33</div>
                </div>
                <div>
                    <div class="num">2</div>
                    <div class="title"><a href="<%= ctxPath%>/CSC/informBoardView.dak">글 제목</a></div>
                    <div class="writer">이름</div>
                    <div class="date">2023.4.13</div>
                    <div class="count">33</div>
                </div>
                <div>
                    <div class="num">1</div>
                    <div class="title"><a href="<%= ctxPath%>/CSC/informBoardView.dak">글 제목</a></div>
                    <div class="writer">이름</div>
                    <div class="date">2023.4.13</div>
                    <div class="count">33</div>
                </div>
            </div>
            <div class="board_page">
                <a href="#" class="bt first"></a>
                <a href="#" class="bt prev"></a>
                <a href="#" class="num on">1</a>
                <a href="#" class="num">2</a>
                <a href="#" class="num">3</a>
                <a href="#" class="num">4</a>
                <a href="#" class="num">5</a>
                <a href="#" class="bt next">></a>
                <a href="#" class="bt last">>></a>
            </div>
            <div class="bt_wrap">
                <a href="<%= ctxPath%>/CSC/informBoardWrite.dak" class="on">작성</a>
                <!--<a href="#">수정</a>-->
            </div>
        </div>
    </div>
</body>

      
      
      <!-- 오른쪽에 들어갈 내용 -->
</div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>