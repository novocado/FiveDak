<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>  
<%@ page import="semiproject.dak.product.model.ProductDAO" %>
<%@ page import="semiproject.dak.product.model.ProductDTO" %>
<% String ctxPath = request.getContextPath(); %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>     
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%--     직접 만든 CSS   
<link rel="stylesheet" type="text/css" href="./Product.css" />
--%>

<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" /> 


<jsp:include page="../header-final.jsp"/>
<%--<jsp:include page="../serviceSidebar.jsp"/> --%>

<style>


	.content_container  {
		margin-bottom: 10px;
	}


	.content_container > .productBox {
		border-top: solid 2px #ccc; 
		display: flex; 
		/* height: 1200px; */   /* 사이드바 sticky 안 되면 이 부분 수정해보기 */
		margin: 0 0 ; 
	}

	.productDetail_Info,
	.sideMenubar {
		padding: 10px;
		background-color: #fff;
	}
	
	.productDetail_Info {
		width: 100%;
		border-right: solid 1px #ccc;
		/* height: 1200px; */
	}

	.sideMenubar {
		width: 25%;
		height: 900px;
		position: -webkit-sticky;
		position: sticky;
		top: 0;
	}
	
		
		
	.detail_images > img#detailcut {
		width: 80%;
		margin-left: 100px;
	}


	div.product_box > main.spa-main > section.spa-slid > div.nutrition_Info > div.ingredient_tbl > table > tbody > tr > td {
		content: '';
		display: inline-block;
		width: 1px;
		height: 35px;
		background-color: #E8E8E8;
		position: absolute;
		top: 0px;
		right: 0;
	}


	/* 제품 상세보기 버튼 css */
	div.product_box > main.spa-main > .btn-area {
		position:relative;
		text-align:center;
	}
	
	div.product_box > main.spa-main > .btn-area .btn-article-lg {
		position:relative;
		z-index:1;
	}
	
	
	.product_box > .detail_images .btn-area:before { 
		content:none
	}	
		


    .showstep1{
        max-height: 1000px;
        overflow: hidden;
    }
     .showstep2{
        max-height: 600px;
        overflow: hidden;
    } 
    .hide{
        display: none;
    }
    
    
    .btn_open,
	.btn_close {
		border: solid 1px#000;
		width: 646px;
		padding: 13px 0;
		margin-left: 250px;
		background-color: #fff;
	}
    
	
	/* 상세보기 버튼 상단 그라데이션..인데 안 먹음....ㅠ */
	.btnDetail + .btn_open::before {
		border: solid 1px red;
		/* display: block;
		content: '';
		width: 100%;
		background: linear-gradient(180deg, rgba(255, 255, 255, 0) 4.17%, rgba(255, 255, 255, 0,961)71.35%, #fff 100%);
		position: absolute;
		bottom: 0;
		left: 0; */
	}
	
	
	.nutritionBox {
		margin: 2px 10px 2px 10px;
	}
	
	.nutritionCheck {
		width: 79%;
		margin-top: 20px;
	}
    
    .ingredient_tbl > table > tbody > tr > td {
		border-right: solid 1px #ccc;
		padding-right: 50px;
	}
	
	
	
	ul.deliveryInfo_contents,
	ul.exchangeInfo_contents {
		list-style: none;
	}
	
	
	.reviewContent {
		border-top: solid 1px #ccc;
		height: 80px;
	}
    
    
    .nutrition_Info {
    	padding-left: 90px;
    }
    
    
    .deliveryImage {
    	list-style: none;
		display: inline-block;
	}
    
    
    div.tbl_cols, div.tbl_col1, div.tbl_col2 {
    	display: inline-block;
    }
    
    
    .star-rate-md{background: url(images/ico_rating.png) 0 -40px no-repeat; position: relative; width:100px; height:20px;}
	.star-rate-md span{position: absolute;background: url(images/ico_rating.png) 0 -60px;width: auto;height: 20px;}
   
   
   .deliveryInfo_contents > li.tbl_row1 > .tbl_cols > .tbl_cols . > .tbl_col1 > ul > li,
   .deliveryInfo_contents > li.tbl_row1 > .tbl_cols > .tbl_cols . > .tbl_col1 > ul > li {
   		list-style: none;
   }
   
   
   span.tbl_col_li, ul.tbl_col_li {
   	display:inline-block;
   }
   
   span.tbl-cell, div.tbl-cell {
   	display: inline-block;
   }
   
   span.tbl-cell {
   	width: 170px;
   	vertical-align: top;
   	margin-top: 22px;
   	font-weight: bold;
   }
   
   .exchangeInfo, .deliveryInfo {
   	color: #666;
   }
    
    
    .exchangeInfo_head {
		border-bottom:solid 1px #e6e6e6; 
		font-color:#000; 
		font-size:12pt; 
		font-weight:bold; 
		margin-left:40px;
	}
	
	.tbl_col1 {
		display: inline-block;
	}
	
	*{
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
      width: 380px;
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
      height: 120px ; 
   }
   div#my_menu{
      position: absolute ;
      top: 55px;
       right: 0;
   }
   button.btn-search{
      background-color: #fff ;
      border: 0px ;
      top: 22%;
       right: 10px;
   }
   div.header-search {
      top: 60px;
      left : 370px ;
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
      width: 141px;
   }
   span.li-category{
      color: #666;
      margin-top:10px;
      margin-bottom:10px;
   }

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


	/* ----------------------------------------------------------------------- */












/* 전체 페이지 영역 */
	.product_head {
		/* border: solid 2px gray; */
		display: flex;
		padding-top: 70px;
		margin: 0 100px;
	}
	
	/* 좌측 이미지 영역 */
	.product_head > .product_images {
		/* border: solid 1px red; */
		margin-left: 30px;
	}
	
	/* 우측 제품구매상세 영역 */
	.product_choice {
		border: solid 0px blue; 
		margin: 0 auto;
	}
	
	
	
	
	/* 제품 대표이미지 */
	.product_images > .image_main > img {
		max-width: 100%;
		width: 480px;
		height: 480px;
		margin-bottom: 17px;
	}
	
	
	/* 제품 대표이미지 하단 광고 배너 이미지 */ 
	.product_images > .image_ad > img {
		max-width: 100%;
		width: 480px;
		height: 70px;
	}

	
	
	/* 제품 주문상세 요소 */
	.product_choice {
		padding: 0 40px 0 0;
	}
	
	.product_choice > .product_info_tbl > ul {
		list-style: none;
	}	
	
	.product_head > .product_choice > .product_info_tbl > ul {
		border-bottom: 1px solid #EDEDED;
		padding: 15px 0;
	}



	/* 장바구니/바로구매 버튼 꾸미기 */
	.btn_area {
		margin: 40px 0 60px 0;
	}
	
	
	.btn_area > .go_cart,
	.btn_area > .go_buy {
			width: 280px;
			height: 60px;
			border-radius: 5px;
	}
	
	.btn_area > .go_cart {
		background-color: #fff;
		border: solid 1.5px #ff6001;
		margin-right: 10px;
		color: #ff6001;
		font-size: 14pt;
		font-weight: bold;
	}
	
	.btn_area > .go_buy {
		background-color: #ff7e32;
		border: solid 1.5px #ff7e32;
		color: #fff;
		font-size: 14pt;
		font-weight: bold;
	}
	
	/* 
	.product_detail > nav {
	display: table;
	table-layout: fixed;
	width: 1100px;
	padding-right: 279px;
	margin: 0 auto;
	border-left: 1px solid #eee;
} */
	
	
	.product_choice > .product_info_tbl > dl > dt, 
	.product_choice > .product_info_tbl > dl > dd {
		display: inline-block;
	}
	
	
	.product_choice > .product_info_tbl > dl > dt {
		vertical-align: top;
	}
	

	.product_choice > .product_info_tbl > dl:nth-child(2) > dd > ul,
	.product_choice > .product_info_tbl > dl:nth-child(3) > dd > ul {
		list-style: none;
		
	}
	
	.product_choice > .product_info_tbl > dl:nth-child(4) > dd {
		margin-left: 40px; 
		text-decoration: none;
	}
	
	
	
	
	
	
	
body { font-family: "Lato", sans-serif; }

a.sticky-nav-tab { text-decoration: none; }

/* .spa-header {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: horizontal;
  -webkit-box-direction: normal;
  -ms-flex-direction: row;
  flex-direction: row;
  -webkit-box-pack: justify;
  -ms-flex-pack: justify;
  justify-content: space-between;
  -webkit-box-align: center;
  -ms-flex-align: center;
  align-items: center;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  padding: 0 2em;
  height: 75px;
  z-index: 2;
  -webkit-transition: all 0.3s cubic-bezier(0.19, 1, 0.22, 1);
  transition: all 0.3s cubic-bezier(0.19, 1, 0.22, 1);
}

.spa-header--scrolled {
  background: #fafafa;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
}

.spa-header--move-up {
  -webkit-transform: translateY(-75px);
  transform: translateY(-75px);
  -webkit-transition: all 0.3s cubic-bezier(0.19, 1, 0.22, 1);
  transition: all 0.3s cubic-bezier(0.19, 1, 0.22, 1);
}

.spa-header__logo { color: #000; }

.spa-header__link {
  margin-left: 1em;
  color: #000;
} */

.sticky-nav-tabs {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: vertical;
  -webkit-box-direction: normal;
  -ms-flex-direction: column;
  flex-direction: column;
  -webkit-box-pack: center;
  -ms-flex-pack: center; 
  justify-content: center;
  -webkit-box-align: center;
  -ms-flex-align: center;
 align-items: center;
/*   height: 100px; */
  position: relative;
  background: #fff;
 /*  text-align: center; */
  padding: 0 2em;
}


.sticky-nav-tabs-container {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: horizontal;
  -webkit-box-direction: normal;
  -ms-flex-direction: row;
  flex-direction: row;
  position: absolute;
  bottom: 0;
  width: 100%;
  height: 60px;
  /* box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); */
  background: #fafafa;
  z-index: 1;
  -webkit-transition: all 0.3s cubic-bezier(0.19, 1, 0.22, 1);
  transition: all 0.3s cubic-bezier(0.19, 1, 0.22, 1);
}

.sticky-nav-tabs-container--top-first {
  position: fixed;
  top: 80px;
  -webkit-transition: all 0.3s cubic-bezier(0.19, 1, 0.22, 1);
  transition: all 0.3s cubic-bezier(0.19, 1, 0.22, 1);
}

.sticky-nav-tabs-container--top-second {
  position: fixed;
  top: 0;
}

.sticky-nav-tab {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-pack: center;
  -ms-flex-pack: center;
  justify-content: center;
  -webkit-box-align: center;
  -ms-flex-align: center;
  align-items: center;
  -webkit-box-flex: 1;
  -ms-flex: 1;
  flex: 1;
  color: #000;
  letter-spacing: 0.1rem;
  -webkit-transition: all 0.5s ease;
  transition: all 0.5s ease;
  font-size: 0.8rem;
}

.sticky-nav-tab:hover {
  color: #000;
  background: #fff;
  -webkit-transition: all 0.5s ease;
  transition: all 0.5s ease;
}

.sticky-nav-tab-slider {
  position: absolute;
  bottom: 0;
  width: 0;
  height: 6px;
  background: #fff;
  -webkit-transition: left 0.3s ease;
  transition: left 0.3s ease;
}
 @media (min-width: 800px) {

.sticky-nav-tabs h1,  .spa-slide h1 { font-size: 3rem; }

.sticky-nav-tabs h3,  .spa-slide h3 { font-size: 1rem; }

.sticky-nav-tab { font-size: 1rem; }
}
	
	
	
	
	
	.product_box > .spa-main > .spa-slide > .nutrition_Info {
		border: solid 1px gray;
	}
    
</style>



<%
	String product_id = request.getParameter("product_id");	
	if(product_id==null || product_id.isEmpty()){
%>
	<script type="text/javascript">
		alert("잘못된 url입니다.");
		location.href="index.jsp";
	</script>
	<%

	ProductDAO dao = new ProductDAO();
	
	ProductDTO dto=null;
	try{
		dto=dao.prodInfo(Integer.parseInt(product_id));
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	int prodNum = dto.getProdNum(); // 제품번호
	String prodName = dto.getProdName(); // 제품명
	int fk_prodCateNum = dto.getFk_prodCateNum(); // 제품 카데고리 코드(번호)
	int fk_prodBrandNum = dto.getFk_prodBrandNum(); // 제품 브랜드 코드(번호)
	int prodPrice = dto.getProdPrice(); // 정가
	int prodStock = dto.getProdStock(); // 재고 
	int prodSales = dto.getProdSales(); // 판매량
	int prodDiscount = dto.getProdDiscount(); // 판매가
	double prodAvgRating = dto.getProdAvgRating(); // 평균 별점
	String prodImage1 = dto.getProdImage1(); // 제품 이미지
%>


<!-- 맨 위에 있는 배너 모음 -->
   <div class="container-fluid">
      <div class="row justify-content-center banner">
         <div class="col-md-10" id="image-container"><img id="banner" src="../images/메인배너.png"/></div>
      </div>
   </div>
   
   <!-- 로고, 검색창, 로그인, 회원가입 -->
   <div class="container position-relative" id="header-search">
      <a class="position-absolute"style="top:20px;" href="#" ><img src="../images/5조닭조.png" /></a>
      
      <div class="position-absolute header-search" >
         <div class="position-relative">
            <input id="search-header" type="text" placeholder="오늘은 무슨 닭가슴살 먹지?"/>
            <button class="position-absolute btn-search"><i class="fa-solid fa-magnifying-glass"></i></button>
         </div>
      </div>
      
      <ul class="nav" id="login_menu" >
           <li class="nav-item border-right">
             <a style="font-size:10pt;" class="nav-link active header-link" href="#">로그인</a>
           </li>
           <li class="nav-item border-right">
             <a style="font-size:10pt;" class="nav-link header-link" href="#">회원가입</a>
           </li>
           <li class="nav-item border-right">
             <a style="font-size:10pt;" class="nav-link header-link" href="#">주문조회</a>
           </li>
           <li class="nav-item">
             <a style="font-size:10pt;" class="nav-link header-link" href="#">고객센터</a>
           </li>
         </ul>
   
      <div id="my_menu">   
         <ul class="nav">
              <li class="nav-item">
                <a class="nav-link header-link" href="#"><i class="fa-solid fa-user fa-2x"></i></a>
              </li>
              <li class="nav-item">
                <a class="nav-link active header-link" href="#"><i class="fa-solid fa-cart-shopping fa-2x"  ></i></a>
              </li>
              <li class="nav-item">
                <a class="nav-link header-link" href="#"><i class="fa-solid fa-receipt fa-2x"></i></a>
              </li>
            </ul>   
      </div>   
   </div>


<!-- nav bar ( 메뉴 바 ) 시작 -->
<div class="container-fluid sticky-top" style="background-color : #fff;">
	<div class="container">
	<nav>        <!-- style="border: solid 1px blue; margin: 0 100px; max-width: 1300px; min-width: 120px; -->        
	    <!-- Links -->
	       <ul style="border-bottom: solid 1px #f2f2f2; display:flex; list-style: none; padding-left:0;">
	     
	         <!-- Dropdown -->
	        <!-- margin 상 우 좌 하 -->
	         <li style="margin: 10px 50px 10px 10px;">
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
	      
	         <li style="margin: 10px 130px 10px 10px;">
	           <a class="header-category" href="#" style="color: black;">랭킹</a>
	         </li>
	         <li style="margin: 10px 130px 10px 10px;">
	           <a class="header-category" href="#" style="color: black;">신제품</a>
	         </li>
	         <li style="margin: 10px 130px 10px 10px;">
	           <a class="header-category" href="#" style="color: black;">특가/혜택</a>
	         </li>
	         <li style="margin: 10px 130px 10px 10px;">
	           <a class="header-category" href="#" style="color: black;">MD추천</a>
	         </li>
	<!--                 <li style="margin: 10px 130px 10px 10px;">
	                  <a class="header-category" href="#" style="color: black;">이벤트</a>
	                </li> -->
	        </ul>
	   </nav>
	</div>
</div>
<!-- nav bar ( 메뉴 바 ) 끝 -->


<!-- 여기서부터는 제품상세 페이지 영역입니다. -->
<div class="content_container">

	<div class="product_intro">
		<div class="product_head">
			 <!-- 좌측 제품 이미지 삽입 영역 
			     좌측 제품이미지 영역: 1)제품대표이미지 2)중간여백 3)광고배너이미지 --> 
			<div class="product_images">
				<div class="image_main">
					<img alt="제품상세대표 이미지 입니다." src="./images/제품상세대표.jpg">
				</div>
				<div class="image_ad">
					<img alt="배송배너 이미지 입니다." src="./images/배송배너.jpg">
				</div>
			</div>
		
		
			<!-- 우측 상품선택 영역 -->
			<div class="product_choice">
				<h2>맛있닭 소프트 닭가슴살 탄두리맛 100g</h2>
				<div class="product_rating">
					<div class="star-rate-md">
        				<span style="width: 70%"></span>
					</div>
					<a>예시: 4.9점</a>
					<a>예시: (2,324)</a>
				</div>
				
				<div class="product_price">
					<p class="price"><strong style="font-size:30pt;">20,300</strong>원</p>
					<p class="per_price" style="color:#666;">(1팩당 2,300 ~ 3,400)</p>
				</div>
				
				<div class="product_info_tbl">
					<dl style="border-bottom:solid 1px #ccc;">
						<dt style="margin:12px 0;">판매량</dt>
						<dd></dd>
					</dl>
					<dl style="border-bottom:solid 1px #ccc;">
						<dt style="margin-bottom:12px;">배송방법</dt>
						<dd>
							<ul>
								<li>일반&nbsp;&nbsp;&nbsp;<strong>24시</strong> 이전 주문 시 <strong>내일</strong> 도착</li>
								<li>기본&nbsp;&nbsp;&nbsp;<strong>2만원 이상</strong> 무료배송</li>
							</ul>
						</dd>
					</dl>
					<dl style="border-bottom:solid 1px #ccc;">
						<dt style="margin-bottom:12px;">추가혜택</dt>
						<dd>
							<ul>
								<li>[추가증정 EVENT★]<br></li>
								<li>10팩 / 30팩 이상 구매 시, 수량 별 증정품 추가 지급!<br></li>
								<li>10팩이상: 스파클링<br></li>
								<li>30팩이상: 스파클링+프로바이오틱스</li>
							</ul>
						</dd>
					</dl>
					<dl style="border-bottom:solid 1px #ccc;">
						<dt style="margin-bottom:12px;">브랜드관</dt>
						<dd>
							<span style="text-decoration: none; color:#212529;">맛있닭</span>
						</dd>
					</dl>
					<%-- ==== 장바구니 담기 폼 ==== --%>
			          <form name="cartOrderFrm">       
			             <ul class="list-unstyled mt-3">
			                <li>
			                    <label for="spinner">주문개수&nbsp;</label>
			                    <input id="spinner" name="oqty" value="1" style="width: 110px;">
			               </li>
			               <li class="btn_area" style="position:relative; text-align:center;">
			                  <button type="button" class="go_cart" onclick="goCart()">장바구니담기</button>
			                  <button type="button" class="go_buy" onclick="goOrder()">바로주문하기</button>
			               </li>
			            </ul>
			            <input type="hidden" name="pnum" value="${requestScope.pvo.pnum}" />
			         </form>   
				</div>
				
			</div>   <!-- 여기까지가 div.product_choice 끝! -->
		</div>  <!-- 여기까지가 div.product_head 끝! -->
		
	</div>  <!-- 여기까지가 .product_intro div태그 끝! -->
	
	<div class="productBox">
		<div class="productDetail_Info">
		
			<section class="sticky-nav-tabs" style="height:90px;">
				<div class="sticky-nav-tabs-container">
					<a class="sticky-nav-tab" href="#tab-react">영양성분</a>
					<a class="sticky-nav-tab" href="#tab-angular">상품정보</a> 
					<a class="sticky-nav-tab" href="#tab-cssscript">구매후기</a> 
					<a class="sticky-nav-tab" href="#tab-vue">상품문의</a> 
					<a class="sticky-nav-tab" href="#tab-last">구매정보</a> 
					<span class="sticky-nav-tab-slider"></span> 
				</div>
			</section>
			
			<div class="detailinfo showstep1">
				<div class="content">
					<section class="nutritionBox">
						<div class="nutrition_Info">
							<h5 style="font-size:14pt; font-weight: bold; margin-top: 40px;">영양성분<span style="font-size:10pt; color:#ccc;">(100g 기준)</span></h5>
							<div class="ingredient_tbl" >
								<table>
									<tbody>
										<tr>
											<td>열량</td>
											<td>단백질</td>
											<td>나트륨</td>
											<td>탄수화물</td>
											<td>지방</td>
											<td>트랜스지방</td>
											<td>포화지방</td>
											<td>콜레스테롤</td>
											<td>당류</td>
										</tr>
										<tr>
											<td>값</td>
											<td>값</td>
											<td>값</td>
											<td>값</td>
											<td>값</td>
											<td>값</td>
											<td>값</td>
											<td>값</td>
											<td>값</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="nutritionCheck" style="background-color: #e8e8e8; margin:30px 0 60px 5px; width:85%;">
								<span style="margin-left:20px; font-size:14pt; font-weight:bold;">
									<i class="fa-solid fa-circle-info"></i>
									오조닭조 내 ‘영양성분 성적서‘ 2차 확인완료
								</span>
								<p style="margin-left:20px;">표시된 데이터는 정기적으로 진행된 영양성분 성적서 기반이며, 패키지 내 영양성분 표기와는 차이가 있을 수 있습니다.</p>
							</div>
						</div>
					</section>
			  		<!-- <section class="spa-slide" id="tab-angular">
					  <div id="myCarousel" class="carousel slide" data-ride="carousel">
					    Indicators
					    <ol class="carousel-indicators">
					      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					      <li data-target="#myCarousel" data-slide-to="1"></li>
					    </ol>
					
					    Wrapper for slides
					    <div class="carousel-inner">
					      <div class="item active">
					        <img src="images/제품상세증정이벤트1.jpg" alt="제품구매혜택1" style="width:100%;">
					      </div>
					
					      <div class="item">
					        <img src="제품상세증정이벤트1.jpg" alt="제품구매혜택1" style="width:100%;">
					      </div>
					    
					    </div>
					
					    Left and right controls
					    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
					      <span class="glyphicon glyphicon-chevron-left"></span>
					      <span class="sr-only">Previous</span>
					    </a>
					    <a class="right carousel-control" href="#myCarousel" data-slide="next">
					      <span class="glyphicon glyphicon-chevron-right"></span>
					      <span class="sr-only">Next</span>
					    </a>
					  </div>
			  		</section> -->
			    
					<div class="detail_images">	  		
						<img id="detailcut" alt="랭킹닭컴배송" src="https://file.rankingdak.com/store/store/notice/notice_ice_banner.jpg">
						<br>
						<img id="detailcut" alt="누적판매량" src="https://file.rankingdak.com/store/msd/item/msd_n_sales.gif">
						<br>
						<img id="detailcut" alt="맛있닭탄두리리뉴얼" src="https://file.rankingdak.com/store/msd/item/msd_soft/md268/md268_01.jpg">
						<br>
						<img id="detailcut" alt="그림4" src="https://file.rankingdak.com/store/msd/item/msd_soft/md_soft_01.jpg">
						<br>
						<img id="detailcut" alt="그림5" src="https://file.rankingdak.com/store/msd/item/msd_soft/md268/md268_02.jpg">
						<br>
						<img id="detailcut" alt="그림6" src="https://file.rankingdak.com/store/msd/item/msd_soft/md_soft_02.jpg">
						<br>
						<img id="detailcut" alt="그림7" src="https://file.rankingdak.com/store/msd/item/msd_soft/md_soft_03.jpg">
						<br>
						<img id="detailcut" style="margin-bottom:20px;" alt="공통중간사진" src="https://file.rankingdak.com/store/msd/item/msd_soft/md_soft_04.jpg">
						<br>
						<img id="detailcut" alt="그림8" src="https://file.rankingdak.com/store/msd/item/msd_soft/md_soft_05.jpg" >
						<br>
						<img id="detailcut" alt="그림9" src="https://file.rankingdak.com/store/msd/item/msd_soft/md268/md268_03.jpg">
						<br>
						<img id="detailcut" alt="그림10" src="https://file.rankingdak.com/store/msd/item/msd_soft/md_soft_07.jpg">
						<br>
						<img id="detailcut" alt="그림11" src="https://file.rankingdak.com/store/msd/item/msd_soft/md_soft_08.jpg">
					</div>
					<!-- 여기까지가 div.detail_images 끝! -->
					
					
				</div>
			</div>
			
			
	<!-- 상품설명 전체보기 버튼 on/off	 -->		
	<div class="btnDetail">
		<button href="#" class="btn_open" style="position:relative;z-index:1;">상품설명 전체보기</button>
		<button href="#" class="btn_close hide" style="position:relative;z-index:1;">상품설명 접기</button>
	</div>
		
		
		
<div class="content_container2">	
	<section class="spa-slide" id="tab-cssscript" style="margin-left:30px;">
		<h3 style="font-weight:bold; font-size:12pt;">구매후기</h3>
		<div class="reviewBox">
			<div class="reviewContent">
				<span>평점<br></span>
				<span>닉네임 | 날짜 <br></span>
				<span>리뷰 내용을 작성해주세요.</span>
			</div>
			<div class="reviewContent">
				<span>평점<br></span>
				<span>닉네임 | 날짜 <br></span>
				<span>리뷰 내용을 작성해주세요.</span>
			</div>
			<div class="reviewContent">
				<span>평점 <br></span>
				<span>닉네임 | 날짜 <br></span>
				<span>리뷰 내용을 작성해주세요.</span>
			</div>
			<div class="reviewContent">
				<span>평점<br></span>
				<span>닉네임 | 날짜 <br></span>
				<span>리뷰 내용을 작성해주세요.</span>
			</div>
			<div class="reviewContent" style="border-bottom:solid 1px #ccc; margin-bottom:50px;">
				<span>평점<br></span>
				<span>닉네임 | 날짜 <br></span>
				<span>리뷰 내용을 작성해주세요.</span>
			</div>
		</div>
	</section>
	
	<section class="spa-slide" id="tab-vue">
 		<h3 style="margin-left:35px;">상품문의</h3>
 		<ul> 
	        <li class="qna-item" data-id="20230320000000019161" data-secret="Y" data-regid="phj4213" data-productcd="9024" style="list-style: none;">
	            <input type="hidden" name="questionType" value="200">
	            <input type="hidden" name="questionTypenm" value="배송문의">
	            <input type="hidden" name="questionCont" value="언제 배송되나요ㅠㅠ">
	            <div>
	                <div style="border-bottom: solid 1px #e6e6e6; border-top:solid 1px #e6e6e6; padding:10px 0 10px 0;">
	                    <div style="display:inline-block; margin-right:50px;"><span class="text-primary">답변완료</span></div>
	                    <div class="tit-cell" style="display:inline-block;">
	                        <a href="javascript:void(0)" class="ui-toggle-btn">[배송문의] 입니다.</a>
	                        <i class="fa-solid fa-lock" style="color: #000000;"></i>
	                        </div><!--// tit-cell -->
	                    <div class="name-cell" style="display:inline-block; margin-left:500px;"><span>phj4213</span></div>
	                    <div class="date-cell" style="display:inline-block;"><span>2023.03.20</span></div>
	                </div>
	                <div style="border-bottom: solid 1px #e6e6e6; padding:10px 0 10px 0;">
	                    <div style="display:inline-block; margin-right:50px;"><span class="text-primary">답변완료</span></div>
	                    <div class="tit-cell" style="display:inline-block;">
	                        <a href="javascript:void(0)" class="ui-toggle-btn">[배송문의] 입니다.</a>
	                        <i class="fa-solid fa-lock" style="color: #000000;"></i>
	                        </div><!--// tit-cell -->
	                    <div class="name-cell" style="display:inline-block; margin-left:500px;"><span>phj4213</span></div>
	                    <div class="date-cell" style="display:inline-block;"><span>2023.03.20</span></div>
	                </div>
	                <div style="border-bottom: solid 1px #e6e6e6; padding:10px 0 10px 0;">
	                    <div style="display:inline-block; margin-right:50px;"><span class="text-primary">답변완료</span></div>
	                    <div class="tit-cell" style="display:inline-block;">
	                        <a href="javascript:void(0)" class="ui-toggle-btn">[배송문의] 입니다.</a>
	                        <i class="fa-solid fa-lock" style="color: #000000;"></i>
	                        </div><!--// tit-cell -->
	                    <div class="name-cell" style="display:inline-block; margin-left:500px;"><span>phj4213</span></div>
	                    <div class="date-cell" style="display:inline-block;"><span>2023.03.20</span></div>
	                </div>
	                <div style="border-bottom: solid 1px #e6e6e6; padding:10px 0 10px 0;">
	                    <div style="display:inline-block; margin-right:50px;"><span class="text-primary">답변완료</span></div>
	                    <div class="tit-cell" style="display:inline-block;">
	                        <a href="javascript:void(0)" class="ui-toggle-btn">[배송문의] 입니다.</a>
	                        <i class="fa-solid fa-lock" style="color: #000000;"></i>
	                        </div><!--// tit-cell -->
	                    <div class="name-cell" style="display:inline-block; margin-left:500px;"><span>phj4213</span></div>
	                    <div class="date-cell" style="display:inline-block;"><span>2023.03.20</span></div>
	                </div>
	                <div style="border-bottom: solid 1px #e6e6e6; padding:10px 0 10px 0;">
	                    <div style="display:inline-block; margin-right:50px;"><span class="text-primary">답변완료</span></div>
	                    <div class="tit-cell" style="display:inline-block;">
	                        <a href="javascript:void(0)" class="ui-toggle-btn">[배송문의] 입니다.</a>
	                        <i class="fa-solid fa-lock" style="color: #000000;"></i>
	                        </div><!--// tit-cell -->
	                    <div class="name-cell" style="display:inline-block; margin-left:500px;"><span>phj4213</span></div>
	                    <div class="date-cell" style="display:inline-block;"><span>2023.03.20</span></div>
	                </div>
	            </div>
	        </li>
        </ul>
	</section>
 		
    <section class="spa-slide" id="tab-last">
    	<div class="deliveryInfo">
    		<div class="deliveryInfo_head">
    			<h3 style="border-bottom: solid 1px #e6e6e6; margin-left:40px; font-size:16px; margin-top:100px;">배송안내</h3>
    		</div>
    		
    		<ul class="deliveryInfo_contents">
    			<li class="tbl_row1" style="border-bottom: solid 1px #e6e6e6;">
    				<span>
    					<img class="deliveryImage" alt="일반배송" src="images/일반배송.png" style="vertical-align: top; margin-right:100px; margin-top:20px;">
    				</span>
    				<div class="tbl_cols">
    					<div class="tbl_col2">
    						<ul class="tbl_col_li" style="list-style:none;">
    							<li>평일 24시까지 주문 시, 다음날 도착!</li>
    							<li>일요일 21시까지 주문 시, 다음날 도착!</li>
    							<li>2만원 이상 : 무료배송2만원 미만 : 3,000원</li>
    							<li>제주도 및 도서산간 운임 : 4,000원</li>
    							<li>( 전 지역 배송 가능 )</li>
    							<li>주말, 공휴일 결제 시 다음 영업일 발송</li>
    						</ul>
    					</div>
    				</div>
    			</li>
    			<li class="tbl_row2" style="border-bottom: solid 1px #e6e6e6;"> 
    				<span class="tbl_col1" style="display: inline-block; margin-right:220px; font-weight:bold;">택배사</span>
    				<span class="tbl_col2" style="display: inline-block;">CJ대한통운 (1588-1255), 롯데택배(1588-2121), 한진택배(1588-0011)</span>
    			</li> 
    			<li class="tbl_row3" style="border-bottom: solid 1px #e6e6e6; height: 200px;">
    				<span class="tbl_col1" style="display: inline-block; vertical-align: top; margin-right:200px; padding-top:20px; font-weight:bold;">유의사항</span>
    				<div style="display: inline-block; margin-top:20px;">
    					<span class="tbl_col2">
    						※ 최소 주문 금액 2만원 이상일 경우 특급배송 서비스 이용 가능
    						<br>
    						※ 도서산간, 택배사 사유, 재고 상황 등의 이유로 도착 예정일은 변동될 수 있습니다.
    						<br>
    						※ 금요일 주문 마감 시간 이전 주문은 토요일에 배송됩니다.
    						<br>
    						  주말 수령이 어려운 경우, 배송 메시지 하단에 '월요일 출고'를 표시해주시면
    						<br>
    						  월요일에 발송되어 화요일에 받아보실 수 있습니다.
    						<br>
    						  (공휴일인 경우, 다음 영업일 발송)
    					</span>
    				</div>
    			</li>
    		</ul>
    		
    	</div> 
    	<!-- 여기까지가 div.deliveryInfo 끝! -->
    	
    	<div class="exchangeInfo">
    		<div class="exchangeInfo_head" style="margin-top:100px;">
    			<h3>교환/반품 안내</h3>
    		</div>
    		
    		<ul class="exchangeInfo_contents">
    			<li>
    				<span class="tbl-cell" style="margin-top: 10px;">주의사항</span>	
    				<div class="tbl-cell">
    					<span>
    					- 본 상품은 제품 특성상 단순 변심에 의한 교환 · 반품은 불가합니다.
    					<br>
    					- 군부대, 사서함 주소의 경우 배송이 안될 수 있으니 고객센터 확인 후 주문 바랍니다.
    					<br>
    					(구매 전 제품 상세 및 배송 · 반품에 대한 내용을 확인해 주세요.)
    					</span>
    				</div>
    			</li>
    			<li class="tbl_row2"  style="border-bottom:solid 1px #e6e6e6;">
    				<span class="tbl-cell">교환/반품 신청</span>	
    				<div class="tbl-cell">
    					<span>
    					제품의 교환 및 반품 시 고객센터 담당자에게 교환 또는 반품 신청을 해주시기 바랍니다.
    					<br>
    					(전화 : 02-6405-8088 / 홈페이지 고객센터)
    					<br><br>
    					- 교환 및 반품은 고객센터 담당자와 협의를 통해 이루어지며, 임의로 수취거부 및 반송하는 경우 반품 처리되지 않습니다.
    					<br>
    					- 냉동/냉장 식품의 경우 제품의 특성상 ‘단순변심’에 의한 반품 및 환불은 불가합니다.
    					<br>
    					  주문전 충분히 제품 상세페이지 및 제품 설명을 참고하시고 주문바랍니다. 
    					<br>
    					- N페이 결제건은 출고/반품 주소지가 상품별로 상이하여, 자동 수거 지시 기능이 불가합니다.
    					</span>
    				</div>
    			</li>
    			<li class="tbl_row3" style="border-bottom:solid 1px #e6e6e6;">
    				<span class="tbl-cell">교환/반품이 가능한 경우</span>	
    				<div class="tbl-cell">
    					<span>
    					- 주문한 제품과 다르거나 판매자의 제공정보와 상이한 경우
    					<br>
    					- 제품이 불량이거나 손상된 경우
    					<br>
    					- 배송사의 귀책 사유에 따른 배송 지연 발생 및 제품이 변질 된 경우
    					</span>
    				</div>
    			</li>
    			<li class="tbl_row4" style="border-bottom:solid 1px #e6e6e6;">
    				<span class="tbl-cell">교환/반품이 불가능한 경우</span>	
    				<div class="tbl-cell">
    					<span>
    					- 판매자와 교환/반품에 대한 협의 없이 임의로 폐기 처분 또는 반품/배송한 경우
    					<br>
    					- 냉동·냉장 보관 식품 및 채소, 유통기한이 2개월 미만인 상품에 대한 단순 변심의 경우
    					<br>
    					- 잘못된 주소나 연락처 기재로 인한 반송 또는 고객의 부재로 인해 배송이 지연되어 제품이 변질된 경우
    					<br>
    					- 수령 후, 보관/취급 부주의로 인해 제품이 변질 또는 손상된 경우
    					<br>
    					- PC 및 휴대폰의 화면과 실제 상품의 색상이나 이미지 차이 또는 개인적 취향이나 기호에 따른 교환/반품
    					</span>
    				</div>
    			</li>
    			<li class="tbl_row5" style="border-bottom:solid 1px #e6e6e6;">
    				<span class="tbl-cell">교환/반품이 절차</span>	
    				<div class="tbl-cell">
    					<span>
    					- 전화 및 이메일을 통해 반송처 및 교환/반품 방법을 안내해드립니다.
    					<br>
    					- 반품시 결제방식에 따라 카드 승인취소 또는 계좌입금 처리를 해드립니다.
    					</span>
    				</div>
    			</li>
    		</ul>
    	</div>    <!-- 여기까지 div.exchangeInfo 끝! -->
	    	
</section>
</div> 	<!-- 여기까지 div.content_container2 끝! -->	
			
			
		</div>  <!-- 여기까지가 div.productDetail_Info 끝! -->
		
		
		<!-- 스티키 사이드메뉴바 -->
		<div class="sideMenubar" style="padding-top:60px; height:80%;">
			<span style="font-size:12pt;">옵션선택<br></span>
			<div>
				<h4 style="margin-top: 20px; margin-bottom:250px;" ><%=prodName %></h4>
				<div class="product_price" style="text-align: right;">
					<strong style="font-size:30pt;">20,300</strong>원
					<p class="per_price" style="color:#666; margin-top:0;">(1팩당 2,300 ~ 3,400)</p>
				</div>
				<%-- ==== 장바구니 담기 폼 ==== --%>
			          <form name="cartOrderFrm">       
			             <ul class="list-unstyled mt-3">
			                <li>
			                    <label for="spinner">주문개수&nbsp;</label>
			                    <input id="spinner" name="oqty" value="1" style="width: 110px;">
			               </li>
			               <li class="btn_area" style="position:relative; text-align:center;">
			                  <button type="button" class="go_cart" onclick="goCart()">장바구니담기</button>
			                  <button type="button" class="go_buy" onclick="goOrder()">바로주문하기</button>
			               </li>
			            </ul>
			            <input type="hidden" name="pnum" value="${requestScope.pvo.pnum}" />
			         </form>   
			</div>
			<div class="btn_area" style="margin: 50px 5px  5px 20px;">
				<button type="submit" class="go_cart" style="margin-bottom:12px">장바구니</button>
				<button type="submit" class="go_buy">바로구매</button>
			</div>
		</div>
		
		
	</div>  <!-- 여기까지가 div.productBox 끝! -->
	
	
	
   <!-- 여기까지가 div.content_container 끝! -->

		
  </div>	
  
  
  <script type="text/javascript">

$(document).ready(function(){
    
    
    // 헤더 카테고리 
     // 2차 카테고리 열리게
     $('.dropdown-menu li').mouseover(function(){
         $(this).find('.header-list').show();
     });

     // 2차 카테고리 닫히게
     $('.dropdown-menu li').mouseleave(function(){
         $(this).find('.header-list').hide();
     });
    
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
    
    
    
    
 }); // END OF $(DOCUMENT).READY(FUNCTION(){


	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		document.addEventListener('DOMContentLoaded', function(){ //DOM 생성 후 이벤트 리스너 등록
	    //더보기 버튼 이벤트 리스너
	    document.querySelector('.btn_open').addEventListener('click', function(e){
	        
	        let classList = document.querySelector('.detailinfo').classList; // 더보기 프레임의 클래스 정보 얻기
	        let contentHeight = document.querySelector('.detailinfo > .content').offsetHeight; //컨텐츠 높이 얻기

	       /*  // 2단계이면 전체보기로
	        if(classList.contains('showstep2')){
	            classList.remove('showstep2');
	        } */
	        // 1단계이면 2단계로
	        if(classList.contains('showstep1')){
	            classList.remove('showstep1');
	            if(contentHeight > 1000){
	                classList.add('showstep2');
	            }else{
	                document.querySelector('.btn_open').classList.add('hide');
	            }
	        }
	        //전체보기시 더보기 버튼 감추기 & 감추기 버튼 표시
	        if(!classList.contains('showstep1') && !classList.contains('showstep2')){
	            e.target.classList.add('hide');
	            document.querySelector('.btn_close').classList.remove('hide');
	            
	        }
	        
	        
	        //////////////////////////////////////////////////////////////////////////////////
	        //2단계 생략
	        
	        // 2단계이면 전체보기로
	        if(classList.contains('showstep2')){
	            classList.remove('showstep2');
	        }
	        // 1단계이면 2단계로
	        if(classList.contains('showstep1')){
	            classList.remove('showstep1');
	            if(contentHeight > 600){
	                classList.add('showstep2');
	            }else{
	                document.querySelector('.btn_open').classList.add('hide');
	            }
	        }
	        //전체보기시 더보기 버튼 감추기 & 감추기 버튼 표시
	        if(!classList.contains('showstep1') && !classList.contains('showstep2')){
	            e.target.classList.add('hide');
	            document.querySelector('.btn_close').classList.remove('hide');
	            
	        }
	        
	    });
	});
		
		
		
		// 감추기 버튼 이벤트 리스너
		document.querySelector('.btn_close').addEventListener('click', function(e){
		    e.target.classList.add('hide');
		    document.querySelector('.btn_open').classList.remove('hide'); // 더보기 버튼 감춤
		    document.querySelector('.detailinfo').classList.add('showstep1'); // 초기 감춤 상태로 복귀
		});
		
		
		//컨텐츠 로딩 완료 후 높이 기준으로 클래스 재처리
		window.addEventListener('load', function(){
		    let contentHeight = document.querySelector('.detailinfo > .content').offsetHeight; //컨텐츠 높이 얻기
		    if(contentHeight <= 300){
		        document.querySelector('.detailinfo').classList.remove('showstep1'); // 초기값보다 작으면 전체 컨텐츠 표시
		        document.querySelector('.btn_open').classList.add('hide'); // 버튼 감춤
		    }
		});

		
		$("input#spinner").spinner( {
	         spin: function(event, ui) {
	            if(ui.value > 100) {
	               $(this).spinner("value", 100);
	               return false;
	            }
	            else if(ui.value < 1) {
	               $(this).spinner("value", 1);
	               return false;
	            }
	         }
	      } );// end of $("input#spinner").spinner({});----------------    
	      
		
		
		// *** 장바구니 담기 ***//
		   function goCart() {
		   
		      // === 주문량에 대한 유효성 검사하기 === //
		      var frm = document.cartOrderFrm;
		      
		      var regExp = /^[0-9]+$/;  // 숫자만 체크하는 정규표현식
		      var oqty = frm.oqty.value;
		      var bool = regExp.test(oqty);
		      
		      if(!bool) {
		         // 숫자 이외의 값이 들어온 경우 
		         alert("주문갯수는 1개 이상이어야 합니다.");
		         frm.oqty.value = "1";
		         frm.oqty.focus();
		         return; // 종료 
		      }
		      
		      // 문자형태로 숫자로만 들어온 경우
		      oqty = parseInt(oqty);
		      if(oqty < 1) {
		         alert("주문갯수는 1개 이상이어야 합니다.");
		         frm.oqty.value = "1";
		         frm.oqty.focus();
		         return; // 종료 
		      }
		      
		      // 주문개수가 1개 이상인 경우
		      frm.method = "POST";
		      frm.action = "<%= request.getContextPath()%>/shop/cartAdd.up";
		      frm.submit();
		   
		   }// end of function goCart()-------------------------
		
	
	</script>



<jsp:include page="../footer.jsp"/>