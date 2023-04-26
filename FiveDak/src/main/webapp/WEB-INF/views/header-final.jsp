<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<% String ctxPath = request.getContextPath(); %>    
<!DOCTYPE html>
<html>
<head>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="<%=ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">
    
<!-- Optional JavaScript -->
<script src="<%=ctxPath%>/js/jquery-3.6.4.min.js" type="text/javascript"></script>
<script src="<%=ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>

<!-- Font Awesome 6 Icons --> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
<!-- 글꼴 적용하기 -->
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.6/dist/web/static/pretendard.css" />
<link rel="icon" href="<%=ctxPath%>/images/파비콘.ico">
<title>오조닭조</title>
<script type="text/javascript">
	$(document).ready(function(){
		randomInput() ; // INPUT에 PLACEHOLDER 가 랜덤하게 들어가게 하는 방법
		setHeaderEvent();
		putSearchWord(); // INPUT 검색시에 검색값이 그대로 있도록 하는 메소드
		
	}); // END OF $(DOCUMENT).READY(FUNCTION(){
		
	/////////////////////////////////////////////////////////////////////////////////////////////////
	function randomInput(){
		  const placeholders = [
		    '원하는 날짜에 맞춰서 자동 배송',
		    '쿠폰 받고 여름 준비 시-작!',
		    '실시간 T.O.P를 소개합니다!',
		    '밤 12시 이전 주문시 내일 도착!'
		  ];

		  const randomIndex = Math.floor(Math.random() * placeholders.length);
		  console.log(`${placeholders[randomIndex]}`);

		  const input = $('<input>', { id: 'search-header', type: 'text', placeholder: placeholders[randomIndex],name:'searchWord' });
		  const button = $('<button>', { class: 'position-absolute btn-search' }).append($('<i>', { class: 'fa-solid fa-magnifying-glass' }));

		  $('div.div-input').empty().append(input).append(button);
		}
		
	function setHeaderEvent(){
		// 헤더 로고 클릭시 indexPage로 돌아올 수 있게 하기 
		
		// 헤더 카테고리 
	    // 2차 카테고리 열리게
	    $('.dropdown-menu li').mouseover(function(){
	        $(this).find('.header-list').show();
	    });

	    // 2차 카테고리 닫히게
	    $('.dropdown-menu li').mouseleave(function(){
	        $(this).find('.header-list').hide();
	    });
		
	    $('input#search-header').on('keyup', function(event){
	    	if( event.keyCode == 13 ){
	    		goSearch();
	    	}
	    });
	    $('button.btn-search').on('click',goSearch);
	} // END OF FUNCTION SETHEADEREVENT(){
	
	////////////////////////////////////////////////////////////////////////////////////////////////////
	function putSearchWord(){
		const searchWord = '${requestScope.searchWord}';
		$("input#search-header").val(searchWord);
	
	}// END OF D function putSearchWord
	
	function goSearch(){
		// console.log( '확인용 ~~')
		const searchText = $('input#search-header').val();
		
		const searchFrm = document.searchFrm;
		searchFrm.action="<%=ctxPath%>/product/searchProd.dak";
		searchFrm.method="get";

		searchFrm.submit();	
	
	}// END OF FUNCTION
	
	
	
	function deleteBanner(){
		$('div.banner').hide();
		$('img#header-banner').hide();
	}
	

	
		
	
	
</script>


<style type="text/css">
	* {
   font-family: "Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif;
   word-break : break-all ;
   
   }
	img#banner{
		position: absolute;
		top: 0;
		left: 0;
		width:100%;
		height:100%;
	}
	div.banner{
		height : 80px ;
	}
	input#search-header{
		border : 1px solid #FFA751 ;
		display : inline-block ;
		width: 100%;
    	height: 40px;
    	border-radius: 6px;
    	background: #fff;
	}
	ul#login_menu{
		position: absolute;
		top:10px ;
		right : 0 ;
	}
	div#header-search{
		height: 40px ; 
	}
	div#my_menu{
		top: 30px;
	}
	button.btn-search{
		background-color: #fff ;
		border: 0px ;
		top: 22%;
    	right: 10px;
	}
	.header-link{
		color:#666;
	}
	a.header-a{
		display: inline-block;
		width: 100px ;
		margin-right : 80px ;
	}
	a.header-category{
		display:inline-block;
		width: 126%;
	}
	span.li-category{
		color: #666;
		margin-top:10px;
		margin-bottom:10px;
	}

	.header-menu {
	  display: flex;
	  justify-content: center; /* 요소들을 가운데 정렬 */
	  align-items: center; /* 요소들을 수직 중앙 정렬 */
	  height: 100%;
	}

</style>
</head>

<body>


	<!-- 맨 위에 있는 배너 모음 -->
	<div class="container-fluid banner" style="margin-bottom:13px;">
		<div class="row justify-content-center">
			<img id="header-banner" src="<%=ctxPath%>/images/메인배너.png" style="width: 100%;">
 		</div>
		
		<button class="position-absolute btn-close" style="right:155px; top:0; background-color:#f8f8f8; border:0;" type="button" onclick="deleteBanner()">X</button>
	</div>



	<!-- 로그인, 회원가입 -->
	<div class="container position-relative" id="header-search">
		
		
		<c:if test="${sessionScope.loginuser == null }">
			<ul class="nav" id="login_menu" >
				  <li class="nav-item border-right">
				    <a style="font-size:10pt;" class="nav-link active header-link" href="<%= ctxPath %>/login.dak">로그인</a>
				  </li>
				  <li class="nav-item border-right">
				    <a style="font-size:10pt;" class="nav-link header-link" href="<%= ctxPath %>/register.dak">회원가입</a>
				  </li>
				  <li class="nav-item border-right">
				    <a style="font-size:10pt;" class="nav-link header-link" href="#">주문조회</a>
				  </li>
				  <li class="nav-item">
				    <a style="font-size:10pt;" class="nav-link header-link" href="#">고객센터</a>
				  </li>
			</ul>
		</c:if>
		
		<c:if test="${sessionScope.loginuser != null && sessionScope.loginuser.mbrId != 'admin'}">
			<ul class="nav" id="login_menu" >
				  <li class="nav-item border-right">
				    <a style="font-size:10pt;" class="nav-link active header-link" href="<%= ctxPath %>/logout.dak">로그아웃</a>
				  </li>
				  <li class="nav-item border-right">
				    <a style="font-size:10pt;" class="nav-link header-link" href="<%= ctxPath %>/mypage/infoedit.dak">내정보수정</a>
				  </li>
				  <li class="nav-item border-right">
				    <a style="font-size:10pt;" class="nav-link header-link" href="#">주문조회</a>
				  </li>
				  <li class="nav-item">
				    <a style="font-size:10pt;" class="nav-link header-link" href="#">고객센터</a>
				  </li>
			</ul>
		</c:if>
		
		<c:if test="${sessionScope.loginuser != null && sessionScope.loginuser.mbrId == 'admin' }">
			<ul class="nav" id="login_menu" >
				  <li class="nav-item border-right">
				    <a style="font-size:10pt;" class="nav-link active header-link" href="<%= ctxPath %>/logout.dak">로그아웃</a>
				  </li>
				  <li class="nav-item border-right">
				    <a style="font-size:10pt;" class="nav-link header-link" href="<%= ctxPath %>/admin/adminHome.dak">관리자페이지</a>
				  </li>
				  <li class="nav-item border-right">
				    <a style="font-size:10pt;" class="nav-link header-link" href="#">주문조회</a>
				  </li>
				  <li class="nav-item">
				    <a style="font-size:10pt;" class="nav-link header-link" href="#">고객센터</a>
				  </li>
			</ul>
		</c:if>
		
	</div>
	
	<!-- 로고, 검색창, 아이콘 -->
	<div class="container position-relative" style="display: flex; margin-bottom:50px;" >
		
			
		<a class="row col-3" href="<%=ctxPath%>/index.dak" ><img src="<%=ctxPath%>/images/5조닭조.png" /></a>
		
		
		<div class=" header-search col-5 offset-1" >
			<form name="searchFrm">
				<div class=" div-input" style="top:30px; position: relative;">
<!--  				자바스크립트를 통해서 랜덤하게 placeholder가 뜨도록 설정해서 주석표시				
					 <input id="search-header" type="text" placeholder="오늘은 무슨 닭가슴살 먹지?"/>			
					 <button class="position-absolute btn-search"><i class="fa-solid fa-magnifying-glass"></i></button> -->
				</div>
			</form>
		</div>
		
		
		<div id="my_menu" class="col-3 container">	
			<ul class="nav row">
				  <li class="nav-item col-3 offset-1">
				    <a class="nav-link header-link" onclick=""><i class="fa-solid fa-user fa-2x"></i></a>
				  </li>
				  <li class="nav-item col-3">
				    <a class="nav-link active header-link" href="#"><i class="fa-solid fa-cart-shopping fa-2x"  ></i></a>
				  </li>
				  <li class="nav-item col-3" style="left: 10px;">
				    <a class="nav-link header-link" href="#"><i class="fa-solid fa-receipt fa-2x"></i></a>
				  </li>
			</ul>	
		</div>
		
		
		
		
	</div>
	
	
	
	<!-- nav bar ( 메뉴 바 ) -->

	<div class="container-fluid sticky-top" style="background-color : #fff;">
		<div class="container ">
			<div class="row ">
		
			<nav class="col-12">        <!-- style="border: solid 1px blue; margin: 0 100px; max-width: 1300px; min-width: 120px; -->		  
			  <!-- Links -->
				  <ul class="header-menu" style="border-bottom: solid 1px #f2f2f2; display:flex; list-style: none; font-size:20px; padding-left:0; height: 50px; margin-bottom:0px;">
				
				    <!-- Dropdown -->
				   <!-- margin 상 우 좌 하 -->
				    <li class="col-2">
				      	<a class="header-category border-right" href="#" data-toggle="dropdown" style="color: black;">
				        	<i class="fa-solid fa-bars"></i>
				       		 카테고리
				      	</a>
				      
				      <div class="dropdown-menu" aria-labelledby="navbardrop">
				        <ul style="padding: 0; list-style: none;">
				        	
				        	<li>
						        <a id="ChickenBreast" class="dropdown-item" href="#">
						        	<i class="fa-solid fa-drumstick-bite" style="margin-right:10px;"></i>
						        	닭가슴살
						        </a>
						        <div class="header-list" style="border: solid 2px white;" id="show1">
						        	<ul style="list-style: none; overflow-y: auto; overflow-x: hidden; position: absolute; top: 0; left: 100%; z-index: 2; width: 160px; height: 100%; background: #f4f4f4; border: 1px solid #ccc; border-top: 0; border-left: 0; padding-top: 5px;">
						        			<li><a href="#"><span class="li-category">전체</span></a></li>
						        			<li><a href="#"><span class="li-category">스테이크</span></a></li>
						        			<li><a href="#"><span class="li-category">소스닭가슴살</span></a></li>
						        			<li><a href="#"><span class="li-category">스팀-소프트</span></a></li>
						        			<li><a href="#"><span class="li-category">볼-큐브</span></a></li>
						        			<li><a href="#"><span class="li-category">슬라이스</span></a></li>
        							</ul>
        						</div>
				        	</li>
				        	
				        	<li>
						        <a id="Instant" class="dropdown-item" href="#">
						        	<i class="fa-solid fa-bowl-rice" style="margin-right:10px;"></i>
						        	즉석 간편식
						        </a>
						        <div class="header-list" style="border: solid 2px white;" id="show2">
						        <ul  style="list-style: none; overflow-y: auto; overflow-x: hidden; position: absolute; top: 0; left: 100%; z-index: 2; width: 160px; height: 100%; background: #f4f4f4; border: 1px solid #ccc; border-top: 0; border-left: 0; padding-top: 5px;">
					     			   	<li><a href="#"><span class="li-category">전체</span></a></li>
					    				<li><a href="#"><span class="li-category">브리또</span></a></li>
					    				<li><a href="#"><span class="li-category">핫도그</span></a></li>
					    				<li><a href="#"><span class="li-category">만두-딤섬</span></a></li>
					    				<li><a href="#"><span class="li-category">분식</span></a></li>
					    				<li><a href="#"><span class="li-category">치킨</span></a></li>
					    				<li><a href="#"><span class="li-category">피자</span></a></li>
    							</ul>
    							</div>				
				        	</li>
				        	
				        	<li>
						        <a id="BoxLunch" class="dropdown-item" href="#">
						        	<i class="fa-solid fa-bowl-food" style="margin-right:10px;"></i>
						        	도시락, 볶음밥
						        </a>
						        <div class="header-list" style="border: solid 2px white;" id="show3">
						        	<ul  style="list-style: none; overflow-y: auto; overflow-x: hidden; position: absolute; top: 0; left: 100%; z-index: 2; width: 160px; height: 100%; background: #f4f4f4; border: 1px solid #ccc; border-top: 0; border-left: 0; padding-top: 5px;">
					     			   	<li><a href="#"><span class="li-category">전체</span></a></li>
					    				<li><a href="#"><span class="li-category">다이어트 도시락</span></a></li>
					    				<li><a href="#"><span class="li-category">더담은 도시락</span></a></li>
					    				<li><a href="#"><span class="li-category">간편 도시락</span></a></li>
					    				<li><a href="#"><span class="li-category">볶음밥</span></a></li>
					    				<li><a href="#"><span class="li-category">덮밥-컵밥</span></a></li>
					    			</ul>
					    		</div>					
				        	</li>	
				        	
				        	<li style="list-style: none;">
						        <a id="Beef" class="dropdown-item" href="#">
						        	<i class="fa-solid fa-cow" style="margin-right:10px;"></i>
						        	소고기
						        </a>
						        <div style="border: solid 2px white;" id="show4"></div>					
				        	</li>
				        	
				        	<li style="list-style: none;">
						        <a id="Pig" class="dropdown-item" href="#">
						        	<i class="fa-solid fa-bacon" style="margin-right:10px;"></i>
						        	돼지, 오리고기
						        </a>
						        <div style="border: solid 2px white;" id="show5"></div>					
				        	</li>	
				        	
				        	<li style="list-style: none;">
						        <a id="ChickenTenderloin" class="dropdown-item" href="#">
						        	<i class="fa-solid fa-utensils" style="margin-right:10px;"></i>
						        	닭안심살
						        </a>
						        <div style="border: solid 2px white;" id="show6"></div>					
				        	</li>	
				        	
				        	<li style="list-style: none;">
						        <a id="Salad" class="dropdown-item" href="#">
						        	<i class="fa-solid fa-apple-whole" style="margin-right:10px;"></i>
						        	샐러드, 과일
						        </a>
						        <div style="border: solid 2px white;" id="show7"></div>					
				        	</li>				        
				        	
				        	<li style="list-style: none;">
						        <a id="Cheese" class="dropdown-item" href="#">
						        	<i class="fa-solid fa-cheese" style="margin-right:10px;"></i>
						        	배이커리, 치즈
						        </a>
						        <div style="border: solid 2px white;" id="show8"></div>					
				        	</li>	
				        	
				        	<li style="list-style: none;">
						        <a id="Snacks" class="dropdown-item" href="#">
						        	<i class="fa-solid fa-hotdog" style="margin-right:10px;"></i>
						        	과자, 간식, 떡
						        </a>
						        <div style="border: solid 2px white;" id="show9"></div>					
				        	</li>	
				        	
				        	<li style="list-style: none;">
						        <a id="Beverage" class="dropdown-item" href="#">
						        	<i class="fa-solid fa-mug-hot" style="margin-right:10px;"></i>
						        	음료, 차, 프로틴
						        </a>
						        <div style="border: solid 2px white;" id="show10"></div>					
				        	</li>	
				        	
				        	<li style="list-style: none;">
						        <a id="HealthyFood" class="dropdown-item" href="#">
						        	<i class="fa-solid fa-thumbs-up" style="margin-right:10px;"></i>
						        	건강식품
						        </a>
						        <div style="border: solid 2px white;" id="show11"></div>					
				        	</li>	
				        	
				        	<li style="list-style: none;">
						        <a id="sportingGoods" class="dropdown-item" href="#">
						        	<i class="fa-solid fa-futbol" style="margin-right:10px;"></i>
						        	운동생활용품
						        </a>
						        <div style="border: solid 2px white;" id="show12"></div>					
				        	</li>	
				        </ul>
				      </div>
				    </li>
				 
				    <li class="col-2 offset-2">
				      <a class="header-category" href="<%= ctxPath %>/product/rankingList.dak" style="color: black;">랭킹</a>
				    </li>
				    <li class="col-2">
				      <a class="header-category" href="#" style="color: black;">신제품</a>
				    </li>
				    <li class="col-2">
				      <a class="header-category" href="#" style="color: black;">특가/혜택</a>
				    </li>
				    <li class="col-2">
				      <a class="header-category" href="#" style="color: black;">MD추천</a>
				    </li>
<!-- 				    <li style="margin: 10px 130px 10px 10px;">
				      <a class="header-category" href="#" style="color: black;">이벤트</a>
				    </li> -->
			  </ul>
		</nav>
		</div>
	</div>
	</div>



		
