<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>      

<jsp:include page="./header-final.jsp"/>
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.6/dist/web/static/pretendard.css" />
<title>오조 닭조</title>

<!-- slick 이용하기 위한 링크 -->
<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />

<script type="text/javascript">
	$(document).ready(function(){
		
		setEventHandling();
		
		
		
	}); // END OF $(DOCUMENT).READY(FUNCTION(){
		
	////////////////////////////////////////////////////////////////////////////////////////////////////
	 
	function setEventHandling(){
		imageSlider();
	
		eventTimer('timer','2023-05-20T00:00:00');
		eventTimer('timer1','2023-05-04T17:50:00');
		
	}// END OF FUNCTION SETEVENTHANDLING
	

	function imageSlider(){
	   
		// 이미지 슬라이드로 만들기 1
		$('.card-icon').slick({
	    	  infinite: true,
	    	  slidesToShow: 6,
	    	  slidesToScroll: 6
	    });
		
		// 이미지 슬라이드로 만들기 2
	    $('.card-md').slick({
	    	  dots: true,
	    	  infinite: false,
	    	  speed: 300,
	    	  slidesToShow: 4,
	    	  slidesToScroll: 4,
	    	  responsive: [
	    	    {
	    	      breakpoint: 1024,
	    	      settings: {
	    	        slidesToShow: 3,
	    	        slidesToScroll: 3,
	    	        infinite: true,
	    	        dots: true
	    	      }
	    	    },
	    	    {
	    	      breakpoint: 600,
	    	      settings: {
	    	        slidesToShow: 2,
	    	        slidesToScroll: 2
	    	      }
	    	    },
	    	    {
	    	      breakpoint: 480,
	    	      settings: {
	    	        slidesToShow: 1,
	    	        slidesToScroll: 1
	    	      }
	    	    }

	    	  ]
	    	});	
		

		// 슬라이드 버튼 CSS 적용하기 1	    
		$("button.slick-prev").html('<h4><</h4>');
		$("button.slick-prev").css('color','#666');
		$("button.slick-prev").eq(0).addClass("btn-first");
		$("button.slick-prev").eq(1).addClass("btn-second");		
		
		// 슬라이드 버튼 CSS 적용하기 2	    
		$("button.slick-next").html('<h4>></h4>');
		$("button.slick-next").css('color','#666');
		$("button.slick-next").eq(0).addClass("btn-first");
		$("button.slick-next").eq(1).addClass("btn-second");
	 
	}
	
	function deleteBanner(){
		$('div.banner').hide();
		$('img#header-banner').hide();
	}
	
	function eventTimer(id,date){
		 // 타이머 설정
		 var countDownDate = new Date(date).getTime();
		  
		  // 1초마다 타이머 업데이트
		  var timer = setInterval(function() {

		  // 현재 날짜와 시간 구하기 ( new Date 는 컴퓨터에 설정된 나라의 시간을 가져온다. 나의 경우 KST)
		  var now = new Date().getTime();
		  
		  // 남은 시간 계산
		  var distance = countDownDate - now ;
		  
		  // 일, 시간, 분, 초 계산
		  var days = Math.floor(distance / (1000 * 60 * 60 * 24));
		  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
		  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
		  var seconds = Math.floor((distance % (1000 * 60)) / 1000);
		  
		  // 시간 표시
		  document.getElementById(id).innerHTML = days + "일 " + hours + "시간 "
		  + minutes + "분 " + seconds + "초 ";
		    
		  // 타이머 종료시
		  if (distance < 0) {
		    clearInterval(timer);
		    document.getElementById(id).innerHTML = "이벤트 종료";
		  }
		}, 1000);
	}
	
	
</script>


<style type="text/css">

	/* ----------------------------------------------------------------------- */
	/* 메인 페이지 CSS */
	
	img.card-size{
		height: 256px;
	
	}
	button.btn-icon{
		border: 1px #f8f8f8 solid; 
		border-radius:10%;
		background-color:#f8f8f8;
	}
	div.card-time{
		background-color: #f79960;
		color: #fff;
	
	}
	.btn-first{
		margin-top:-36px;
	}
	.btn-second{
		margin-top:-28px;
	}
	.card-font{
		font-size: 17px;
	}
</style>
</head>


	<!-- 메인 콘텐츠  Carousel-->
	<div class="container-fluid" style="padding-left:0px; padding-right:0px;">
		<div id="carouselExampleIndicators2" class="carousel slide carousel-fade" data-ride="carousel">
		  <ol class="carousel-indicators">
		    <li data-target="#carouselExampleIndicators2" data-slide-to="0" class="active"></li>
		    <li data-target="#carouselExampleIndicators2" data-slide-to="1"></li>
		    <li data-target="#carouselExampleIndicators2" data-slide-to="2"></li>
		    <li data-target="#carouselExampleIndicators2" data-slide-to="3"></li>
		    <li data-target="#carouselExampleIndicators2" data-slide-to="4"></li>
		    <li data-target="#carouselExampleIndicators2" data-slide-to="5"></li>
		    <li data-target="#carouselExampleIndicators2" data-slide-to="6"></li>
		    <li data-target="#carouselExampleIndicators2" data-slide-to="7"></li>
		    
		    
		  </ol>
		  <div class="carousel-inner">
		  
		    <div class="carousel-item active">
		      <img style="height: 400px;" src="<%=ctxPath%>/images/배너1.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img style="height: 400px;" src="<%=ctxPath%>/images/배너2.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img style="height: 400px;" src="<%=ctxPath%>/images/배너3.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img style="height: 400px;" src="<%=ctxPath%>/images/배너4.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img style="height: 400px;" src="<%=ctxPath%>/images/배너5.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img style="height: 400px;" src="<%=ctxPath%>/images/배너6.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img style="height: 400px;" src="<%=ctxPath%>/images/배너7.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img style="height: 400px;" src="<%=ctxPath%>/images/배너8.jpg" class="d-block w-100" alt="...">
		    </div>
		    
		  </div>
		  <a class="carousel-control-prev" href="#carouselExampleIndicators2" role="button" data-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="sr-only">Previous</span>
		  </a>
		  <a class="carousel-control-next" href="#carouselExampleIndicators2" role="button" data-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="sr-only">Next</span>
		  </a>
		</div>
	</div>
		<!-- 메인 콘텐츠  Card 1 -->
		
		<div class="container my-5">
			 <div class="card-deck card-icon mb-5">
				  
				  <div class="card text-center" style="border:0px;">
				  	<div class="card-body">
				  		<button class="btn-icon"><i class="fa-solid fa-4x fa-drumstick-bite" style="color: #666;"></i></button>	
				  		<br><a href="/FiveDak/product/searchProd.dak?searchWord=닭가슴살">닭가슴살</a>
				  	</div>	
				  </div>
				  
				  <div class="card text-center" style="border:0px;">
					  <div class="card-body">
					 	<button class="btn-icon"><i class="fa-sharp fa-4x fa-solid fa-gift" style="color: #666;"></i></button>
					 	<br><a>선물하기</a>	
					  </div>	
				  </div>
				 
				  <div class="card text-center" style="border:0px;">
					  <div class="card-body">
					 	<button class="btn-icon"><i class="fa-solid  fa-4x fa-box" style="color: #666;"></i></button>
					 	<br><a href="/FiveDak/product/searchProd.dak?searchWord=도시락">도시락</a>	
					  </div>					  
				  </div>
				 
				  <div class="card text-center" style="border:0px;">
					  <div class="card-body">
					 	<button class="btn-icon"><i class="fa-solid fa-piggy-bank fa-4x"  style="color: #666;"></i></button>
					 	<br><a href="/FiveDak/product/searchProd.dak?searchWord=돼지고기">돼지고기</a>	
					  </div>					  
				  </div>
				 
				  <div class="card text-center" style="border:0px;">
					  <div class="card-body">
					 	<button class="btn-icon"><i class="fa-solid fa-4x fa-carrot" style="color: #666;"></i></button>
					 	<br><a href="/FiveDak/product/searchProd.dak?searchWord=샐러드">샐러드</a>	
					  </div>					  
				  </div>
				 
				  <div class="card text-center" style="border:0px;">
					  <div class="card-body">
					 	<button class="btn-icon"><i class="fa-solid fa-4x fa-whiskey-glass" style="color: #666;"></i></button>
					 	<br><a>음료.차.프로틴</a>	
					  </div>					  
				  </div>
				  
				  <div class="card text-center" style="border:0px;">
					  <div class="card-body">
					 	<button class="btn-icon"><i class="fa-solid fa-4x fa-egg" style="color: #666;"></i></button>
					 	<br><a>계란</a>	
					  </div>					  
				  </div>
				  
				  <div class="card text-center" style="border:0px;">
					  <div class="card-body">
					 	<button class="btn-icon"><i class="fa-solid fa-4x fa-drumstick-bite" style="color: #666;"></i></button>
					 	<br><a>저염식</a>	
					  </div>					  
				  </div>
				  
				  <div class="card text-center" style="border:0px;">
					  <div class="card-body">
					 	<button class="btn-icon"><i class="fa-solid fa-4x fa-drumstick-bite" style="color: #666;"></i></button>
					 	<br><a>도시락</a>	
					  </div>					  
				  </div>
				  
			</div>
		</div>	
		
		
		<!-- 메인 콘텐츠  Card 2-->
		<div class="container my-5">
			<h2 class="text-center"> MD Pick! 추천상품</h2>
			<div class="card-deck card-md mb-5">
			  
			  <div class="card">
			    <img src="<%=ctxPath%>/images/추천상품1.jpg" class="card-img-top card-size" alt="...">
			    <div class="card-body">
			      <h5 class="card-title card-font" >랭닭 MD의 소울 푸드</h5>
			      <p class="card-text"><span class="text-muted">닭가슴살 몬스터 볶음밥</span></p>
			    </div>
			  </div>
			  
			  <div class="card">
			    <img src="<%=ctxPath%>/images/추천상품2.jpg" class="card-img-top card-size" alt="...">
			    <div class="card-body ">
			      <h5 class="card-title  card-font">1팩 2천원 대 가성비 샐러드</h5>
			      <p class="card-text"><span class="text-muted">1am 알뜰샐러드</span></p>
			    </div>
			  </div>
			  <div class="card">
			    <img src="<%=ctxPath%>/images/추천상품3.jpg" class="card-img-top  card-size" alt="...">
			    <div class="card-body">
			      <h5 class="card-title  card-font">소스 닭가슴살계의 끝판왕</h5>
			      <p class="card-text"><span class="text-muted">한입 소스 닭가슴살</span></p>
			    </div>
			  </div>
			  <div class="card">
			    <img src="<%=ctxPath%>/images/추천상품4.jpg" class="card-img-top card-size" alt="...">
			    <div class="card-body">
			      <h5 class="card-title card-font">슬기로운 식단 최대 31%할인</h5>
			      <p class="card-text"><span class="text-muted">4월 한정 MD 패키지</span></p>
			    </div>
			  </div>
			  
			  <div class="card">
			    <img src="<%=ctxPath%>/images/추천상품5.jpg" class="card-img-top card-size" alt="...">
			    <div class="card-body">
			      <h5 class="card-title  card-font">한 팩으로 충전하는 단백질 22g</h5>
			      <p class="card-text"><span class="text-muted">프로틴러쉬 드링크</span></p>
			    </div>
			  </div>
			  
			  <div class="card">
			    <img src="<%=ctxPath%>/images/추천상품6.jpg" class="card-img-top card-size" alt="...">
			    <div class="card-body">
			      <h5 class="card-title  card-font">푸짐하게 더 담아드려요</h5>
			      <p class="card-text"><span class="text-muted">닭가슴살 도시락</span></p>
			    </div>
			  </div>
			  
			  <div class="card">
			    <img src="<%=ctxPath%>/images/추천상품7.jpg" class="card-img-top card-size" alt="...">
			    <div class="card-body">
			      <h5 class="card-title  card-font">30개의 달걀 흰자를 간편하게</h5>
			      <p class="card-text"><span class="text-muted">100% 순수 난백</span></p>
			    </div>
			  </div>
			  
			  <div class="card">
			    <img src="<%=ctxPath%>/images/추천상품8.jpg" class="card-img-top card-size" alt="...">
			    <div class="card-body">
			      <h5 class="card-title  card-font">판매량으로 증명된 No.1</h5>
			      <p class="card-text"><span class="text-muted">닭가슴살 스테이크</span></p>
			    </div>
			  </div>
			  
			 <div class="card">
			    <img src="<%=ctxPath%>/images/추천상품9.jpg" class="card-img-top card-size" alt="...">
			    <div class="card-body">
			      <h5 class="card-title  card-font">풍미 가득 치즈를 가득</h5>
			      <p class="card-text"><span class="text-muted">닭가슴살 볼</span></p>
			    </div>
			  </div>
			  
			 <div class="card">
			    <img src="<%=ctxPath%>/images/추천상품10.jpg" class="card-img-top card-size" alt="...">
			    <div class="card-body">
			      <h5 class="card-title  card-font">가마 안에서 8시간 구워낸</h5>
			      <p class="card-text"><span class="text-muted">구운란&amp;훈제란</span></p>
			    </div>
			  </div>
			  
			  <div class="card">
			    <img src="<%=ctxPath%>/images/추천상품11.jpg" class="card-img-top card-size" alt="...">
			    <div class="card-body">
			      <h5 class="card-title  card-font">처음 만나는 바삭함</h5>
			      <p class="card-text"><span class="text-muted">크리스피 닭가슴살</span></p>
			    </div>
			  </div>
			  
			  <div class="card">
			    <img src="<%=ctxPath%>/images/추천상품12.jpg" class="card-img-top card-size" alt="...">
			    <div class="card-body">
			      <h5 class="card-title card-font">당류 ZERO! 톡-쏘는 청량감!</h5>
			      <p class="card-text"><span class="text-muted">0kcal 스파클링</span></p>
			    </div>
			  </div>
			  
			</div>
		</div>
		
		<!-- 메인 페이지 콘텐츠 3 -->
		
		<div class="container position-relative" style="margin-top:100px;">
			<div class="row"  style="height: 321px;">
				<div style="top:72px;" class="col-md-4 position-absolute">
					<h2><i class="fa-solid fa-stopwatch" class="mx-3 my-3" style="color:#f79960"></i>지금 이순간<br>
					깜짝 타임세일</h2>
					<h4 class="text-muted my-3">오늘이 가면 없을 기회! 놓치지 마세요</h4>
				</div>
				
				<div style="left:379px; height: 320px;" class="col-md-4 position-absolute">
					<div class="card"> 
			  			<img src="<%=ctxPath%>/images/타임세일1.jpg" class="card-img-top" alt="튤립" style="width: 100%; height: 175px;" />
			  				<div class="card-body card-time">
			    				<p class="card-text text-center" id="timer" ></p>
			 				 </div>			 				 
					</div>
			 		<p class="my-2">TIME SALE 맛있닭 닭가슴살 한끼 삼계탕 1+1</p>
				</div>
				
				<div style="left:758px; height: 320px;" class="col-md-4 position-absolute">
					<div class="card"> 
			  			<img src="<%=ctxPath%>/images/타임세일2.jpg" class="card-img-top" alt="튤립" style="width: 100%; height: 175px;" />
			  				<div class="card-body card-time">
			    				<p class="card-text text-center" id="timer1"></p>
			 				 </div>
					</div>
			 		<p class="my-2">TIME SALE 잇메이트 몬스터 볶음밥 이지쿡 10+1 </p>
				</div>
				
			</div>
		</div>
		
		<div class="container-fluid text-center" style="margin-bottom:50px;">
			 <img style="border-radius:calc(0.25rem - 1px);"src="<%=ctxPath%>/images/메인전시1.jpg"  alt="...">
		</div>

		
<jsp:include page="./footer.jsp"/>