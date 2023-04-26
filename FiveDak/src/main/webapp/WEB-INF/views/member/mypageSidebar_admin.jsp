<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>




  <style type="text/css">
  	
  	
  	.orange-text {color: #FF7E32;}
  	
    .my-page-section {
      background-color: #f8f9fa;
      padding-top: 1rem;
    }
    .my-page-card {
      height: 100%;
    }
    
    .sidebar-menu-wrap {
    	width: 220px;
	}
	.sidebar-menu {
		display: block;
	    padding: 10px 24px;
	    border: 1px solid #E6E6E6;
	}

	.sidebar-left {
	    display: block;
	    float: left;
	    margin: 0;
	    padding: 0;
	    border: 0;
	}
	.sidebar-left ul.menu-list {
	    list-style: none;
	    margin: 0;
	    padding: 0;
	    border: 0;
	    display: block;
	    margin-block-start: 1em;
	    margin-block-end: 1em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;

	}
	.sidebar-left li.check {
	    padding: 5px 0;
	    margin: 0;
	    border: 0;
	    border-top: 1px solid #eee;
	    vertical-align: baseline;
	    display: list-item;
	}
	.sidebar-left .menu {
		font-weight: bold;
		text-decoration: none;
		color: inherit;
	}
	
	.sidebar-left a.list  {
	    background: transparent;
	    text-decoration: none;
	    color: inherit;
	    margin: 0;
	    padding: 0;
	    border: 0;
	    vertical-align: baseline;
	}
    
  </style>
</head>


<!-- 마이페이지 -->
<!-- 유저 정보 -->
<div class="container-fluid my-page-section py-3">
  <div class="container">
    <div class="row">
      <!-- 정보, 등급 등 -->
      <div class="col-md-6">
        <div class="card my-page-card">
          <div class="card-body">
            <h4 class="card-title"><span class="font-weight-bold">${sessionScope.loginuser.mbrName}</span>님 반갑습니다.</h4>
            <p class="card-text">${sessionScope.loginuser.mbrTier.tierName }</p>
            <p class="card-text orange-text">50,000원 더 구매 시,닭과장 진급</p>
          </div>
        </div>
      </div>
      <!-- 주문배송 -->
      <div class="col-md-2">
        <div class="card my-page-card">
          <div class="card-body">
            <p class="card-title">주문/배송</p>
            <p class="card-text font-weight-bold"><span class="h3">4</span>건</p>
          </div>
        </div>
      </div>
      <!-- 쿠폰 -->
      <div class="col-md-2">
        <div class="card my-page-card">
          <div class="card-body">
            <p class="card-title">누적구매금액</p>
            <p class="card-text font-weight-bold"><span class="h5">${sessionScope.loginuser.mbrPurchaseAmount }</span>원</p>
          </div>
        </div>
      </div>
      <!-- 포인트 -->
      <div class="col-md-2">
        <div class="card my-page-card">
          <div class="card-body">
            <p class="card-title">포인트</p>
            <p class="card-text orange-text font-weight-bold"><span class="h3">${sessionScope.loginuser.mbrPoint }</span>p</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div><!-- 유저 정보 -->

<!-- 사이드바 -->
<div class="container my-4">
  <div class="row">
    <div class="col-md-3">
		<div class="sidebar-left">
	    	<div class="sidebar-menu-wrap">
	        	<nav class="sidebar-menu">
	            	<ul class="menu-list">
	                	<li class="check">
	                    <a href="" class="menu">주문관리</a>
	                    <ul class="menu-list">
	                        <li class="check">
	                        	<a class="list" href="">전체주문내역</a>
	                        </li>
	                        <li class="check">
	                        	<a class="list" href="">취소/반품 내역</a>
	                        </li>
	                    </ul>
	                </li>
	                <li class="check">
	                    <a href="" class="menu">혜택관리</a>
	                    <ul class="menu-list">
	                        <li class="check"><a class="list" href="">쿠폰</a></li>
	                        <li class="check"><a class="list" href="">포인트</a></li>
	                    </ul>
	                </li>
	                <li class="check">
	                    <a href="" class="menu">활동관리</a>
	                    <ul class="menu-list">
	                        <li class="check"><a class="list" href="">최근 본 상품</a></li>
	                        <li class="check"><a class="list" href="">찜한상품</a></li>
	                        <li class="check"><a class="list" href="">관심브랜드</a></li>
	                        <li class="check"><a class="list" href="">1:1문의</a></li>
	                        <li class="check"><a class="list" href="">상품후기</a></li>
	                        <li class="check"><a class="list" href="">상품문의내역</a></li>
	                    </ul>
	                </li>
	                <li class="check">
	                    <a href="" class="menu">회원정보관리</a>
	                    <ul class="menu-list">
	                        <li class="check"><a class="list" href="">배송지 관리</a></li>
	                        <li class="check"><a class="list" href="">정보수정</a></li>
	                    </ul>
	                </li>
	            </ul>
	        </nav><!--end of menu-mypage -->
	    </div><!--end of sidebar-menu-wrap -->
	</div>
    </div><!-- 사이드바 -->
    
    




<!-- 마이페이지 -->





	