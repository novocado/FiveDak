<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>


  <style type="text/css">
	  	.progress-bar {
	    width: 100%;
	    height: 30px;
	    background-color: #dedede;
	    font-weight: 600;
	    font-size: .8rem;
	}
	
	.progress-bar .progress {
	      /* // 나타내고자 하는 퍼센트 값을 넣으면 됩니다. */
	    height: 30px;
	    padding: 0;
	    text-align: center;
	    background-color: #FFA751;
	    color: #FFA751 ;
	}
  	
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
    a.admin-sidebar:hover{
    	cursor : pointer ;
    	color: #FFA751 ;
    	font-weight: bold ;
    
    }
  </style>
  
  <script type="text/javascript">
  	$(document).ready(function(){
  		let t = 0
  		$('div.progress').css('width','0');
  		const barAnimation = setInterval(() => {
  			$('div.progress').css('width', t+'%');
  	  		t++ >= ${requestScope.percent} && clearInterval(barAnimation)
  		}, 10)	
  		
  		
  		
  		
  	});
  	
  
  
  </script>
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
            <p class="card-text font-weight-bold">배송진행률 : ${requestScope.percent}% ( ${requestScope.successShipped} / ${requestScope.sumMonthOrder} )</p>
            <div class="progress-bar">           
   				<div class="progress"> </div>
			</div>		
          </div>
        </div>
      </div>
      <!-- 주문배송 -->
      <div class="col-md-2">
        <div class="card my-page-card">
          <div class="card-body">
            <p class="card-title">미배송건</p>
            <p class="card-text font-weight-bold"><span class="h3">${requestScope.sumNotShipped}</span>건</p>
          </div>
        </div>
      </div>
      <!-- 쿠폰 -->
      <div class="col-md-2">
        <div class="card my-page-card">
          <div class="card-body">
            <p class="card-title">이번달<br>누적판매금액</p>
            <p class="card-text font-weight-bold"><span class="h5"><fmt:formatNumber value="${requestScope.sumTotalSales}" pattern="#,###"/></span>원</p>
          </div>
        </div>
      </div>
      <!-- 포인트 -->
      <div class="col-md-2">
        <div class="card my-page-card">
          <div class="card-body">
            <p class="card-title">문의사항 요청</p>
            <p class="card-text orange-text font-weight-bold"><span class="h3">100</span>건</p>
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
	                        	<a class="list admin-sidebar" href="<%=ctxPath%>/admin/adminHome.dak">전체주문내역</a>
	                        </li>
	                        <li class="check">
	                        	<a class="list admin-sidebar" href="<%=ctxPath%>/admin/adminProfit.dak">수익 내역</a>
	                        </li>
	                    </ul>
	                </li>
	                <li class="check">
	                    <a href="" class="menu">멤버관리</a>
	                    <ul class="menu-list">
	                        <li class="check"><a class="list admin-sidebar" href="<%=ctxPath%>/admin/adminShowMember.dak">회원관리</a></li>
	                        <li class="check"><a class="list admin-sidebar" href="<%=ctxPath%>/admin/adminShowMemberPoint.dak">포인트</a></li>
	                    </ul>
	                </li>
	                <li class="check">
	                    <a href="" class="menu">제품관리</a>
	                    <ul class="menu-list">
	                        <li class="check"><a class="list admin-sidebar" href="<%=ctxPath%>/admin/adminProductSearch.dak">전체 제품 관리</a></li>
	                        <li class="check"><a class="list admin-sidebar" href="<%=ctxPath%>/admin/adminProductInsert.dak">제품 등록하기</a></li>
	                        <li class="check"><a class="list admin-sidebar" href="">관심브랜드</a></li>
	                        <li class="check"><a class="list admin-sidebar" href="">1:1문의</a></li>
	                        <li class="check"><a class="list admin-sidebar" href="">상품후기</a></li>
	                        <li class="check"><a class="list admin-sidebar" href="">상품문의내역</a></li>
	                    </ul>
	                </li>
	                <li class="check">
	                    <a href="" class="menu">회원정보관리</a>
	                    <ul class="menu-list">
	                        <li class="check"><a class="list admin-sidebar" href="">배송지 관리</a></li>
	                        <li class="check"><a class="list admin-sidebar" href="">정보수정</a></li>
	                    </ul>
	                </li>
	            </ul>
	        </nav><!--end of menu-mypage -->
	    </div><!--end of sidebar-menu-wrap -->
	</div>
    </div><!-- 사이드바 -->
    
    




<!-- 마이페이지 -->
