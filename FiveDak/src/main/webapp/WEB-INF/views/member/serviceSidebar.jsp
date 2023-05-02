<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="/WEB-INF/views/header-final.jsp"/>


  <style type="text/css">
  	
  	
  	.orange-text {color: #FF7E32;}
  	
    
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
	    padding: 15px 0;
	    margin: 0;
	    border: 0;
	    border-top: 1px solid #eee;
	    vertical-align: baseline;
	    display: list-item;
	}
	.sidebar-left .menu {
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


<!-- 사이드바 -->
<div class="container my-4">
  <div class="row">
    <div class="col-md-3">
		<div class="sidebar-left">
	    	<div class="sidebar-menu-wrap">
	        	<nav class="sidebar-menu">
	            	<ul class="menu-list">
	                	<li class="check">
	                    	<a href="<%= ctxPath %>/CSC/informBoardList.dak" class="menu">공지사항</a>
	                	</li>
	                	<li class="check">
	                    	<a href="<%= ctxPath %>/cscenter/instruction.dak" class="menu">이용안내</a>
	                    </li>
	                	<li class="check">
	                    	<a href="<%= ctxPath %>/cscenter/qna.dak" class="menu">1:1문의하기</a>
	                	</li>
	                </ul>
	        	</nav><!--end of menu-mypage -->
	    	</div><!--end of sidebar-menu-wrap -->
		</div>
    </div><!-- 사이드바 -->
    
    <div class="col-md-9">
      <!-- 오른쪽에 들어갈 내용 -->
      
      
      
      
      
      <%-- <!-- 오른쪽에 들어갈 내용 -->
    </div>
  </div>
</div>
<!-- 마이페이지 -->
<jsp:include page="/WEB-INF/views/footer.jsp"/> --%>