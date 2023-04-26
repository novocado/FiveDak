<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>        

<jsp:include page="/WEB-INF/views/member/mypageSidebar.jsp"/>

<style type="text/css">
	
	* {
   font-family: "Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif;
   }
	
	
	div#all {
		/* border: solid 1px black; */
	}
	
	h2.mypage_order {
		margin: 40px 0 20px 40px;
		color: #333;
	}
	
	div.mypage_order {
		border: solid 1px #ECECEC;
		margin-left: 40px;
		background-color: #F8F8F8;
	}
	
	div.period {
		border-bottom: solid 1px #e6e6e6;
		margin-top: 25px;
		padding-bottom: 20px;
	}
	
	input.search {
		margin-left: 360px;

	}
	button.period {
		width: 140px;
		margin-left: 50px;
		border-radius: 50px;
	}
	
	div.period_check {
		margin: 30px 30px 30px 0px;
		/* border: solid 1px gray; */
		width: 95%;
		padding-bottom: 30px;
	}
	
	button.period_check {
		float:right;
	}
	
	a.product_info:hover {
		text-decoration: none;
	}
	a.deliver_check {
		position: relative;
		left: 600px;
		color: #666666;
		text-decoration: underline;
	}
	a.deliver_check:hover {
		text-decoration: none;
	}
	
	div.body {
		width: 12%;
	}
	
	div.contents {
		width: 40%;
		
	}
	
	div.body_1 {
		display: flex;
	}
	
	div.search {
		position: relative;
		top: -60px;
		left: 30px;
	}
	
	button.btn_review_write {
		border: solid 1px #FF7E32;
		color: #FF7E32;
		background-color: white;
		font-size: 10pt;
		padding: 7px;
	}
	button.btn_review_decide {
		border: solid 1px white;
		color: #666666;
		font-size: 10pt;
		padding: 7px;
	}
	a.color_orange {
		color:#FF7E32;
	}


</style>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.6/dist/web/static/pretendard.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>
</head>
<body>

<div class="row">
	<div id="all" class="col-md-9">
		<h2 class="mypage_order">주문내역</h2>
		<div class="mypage_order">
			<form class="form-inline my-2 my-lg-0">
				  <span style="margin:30px 0px 0px 30px; color: #666666;">조회기간 2023.03.11 ~ 2023.04.11</span>
			      <div class="search">
				      <input class="form-control search mr-sm-2" type="search" placeholder="주문 상품명 검색" aria-label="Search">
				      <button class="btn  btn-outline-success my-2 my-sm-0" type="submit">검색</button>
		      	  </div>	
		    </form>
			<div class="period">
				<button style="width: 140px;border-radius: 50px; margin-left: 10px;"type="button" class="btn btn-outline-secondary">2주일</button>
				<button type="button" class="btn period btn-outline-secondary">1개월</button>
				<button type="button" class="btn period btn-outline-secondary">3개월</button>
				<button type="button" class="btn period btn-outline-secondary">6개월</button>
				<button type="button" class="btn period btn-outline-secondary">1년</button>
			</div>
			<div class="period_check">
				<button style="color:#b8b894; margin-left:10px; "type="button" class="btn period_check btn-outline-light"><i class="fa-solid fa-rotate-right mr-2"></i>초기화</button>
				<button type="button" class="btn period_check btn-dark">조회하기</button>
			</div>	
		</div>
		
		<h2 class="mypage_order" style="font-weight:bold;">2023.04.01&nbsp;&nbsp;<a class="product_info" href="#" style="font-size:15pt; color:#666666;">RK2304010003503276 ></a></h2>
		
		<div class="card bg-light" style="margin: 20px 0px 40px 40px;">
		  	<div class="card-header" style="display:flex; height: 45px; font-size:13pt;"><span style="color:#FF7E32">구매확정</span>
			  	<p style="margin-left: 30px; font-size: 11pt; color:#666666;">00월 00일 구매확정완료</p>
			  	<a href="#" class="deliver_check">배송조회</a>
		  	</div>
		  <div class="card-body body_1" style="padding-bottom: 0px;">
		  	  <div class="body">
		  		<img src="../images1/맛있닭 이미지.png"/>
		  	  </div>	
			  <div class="contents" style="width:60%; padding: 5px 0 10px 10px;">
			  	  <a href="#" style="color:#666666;">맛있닭 스팀 닭가슴살 오리지널 100g X 30팩(3kg)</a>
			  		<span style="color:#333;">56,700원</span>&nbsp;&nbsp;
			  		<span style="color:#666666;">1개</span>
			  </div>
			  <div style="padding-top:30px; width: 50%;">
				  <span style="color:#666666; margin-left: 200px; font-size:15pt; font-weight:bold; ">56,700원</span>
			  </div> 
			  <div style="width: 23%; padding-right: 20px; height:115px; position: relative; left:60px;">
			  	  <button class="btn_review_write">후기작성</button>
				  <button class="btn_review_decide" style="margin-top:40px;">주문확정</button>
			  </div>   
		  </div>
		  <hr>
		  	<span style="margin: 0px 0px 20px 20px; color:#666666"><i class="fa-solid fa-house"></i>[12345] 서울 서구 크리스탈로 17(석천동, 시그니엘) 101동 9999호</span>
		</div>
		<ul class="pagination justify-content-center pagination-sm">
			<li class="page-item"><a class="page-link text-muted" href="#"><</a></li>
			<li class="page-item active"><a class="page-link color_orange" href="#">1</a></li>
			<li class="page-item"><a class="page-link color_orange" href="#">2</a></li>
			<li class="page-item"><a class="page-link color_orange" href="#">3</a></li>
			<li class="page-item"><a class="page-link text-muted" href="#">></a></li>
		</ul>
	</div>
</div>

</div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>