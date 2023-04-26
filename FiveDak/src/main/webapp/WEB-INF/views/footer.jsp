<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>
    

<style type="text/css">
	
	div.footerMenu > nav > a:first-child:after,
	div.footerMenu > nav > a:nth-child(2):after,
	div.footerMenu > nav > a:nth-child(3):after,
	div.footerMenu > nav > a:nth-child(4):after {
		content:"";
		border: solid 1px #ccc;
		width: 1px;
		height: 11px;
		margin-left: 33px;
	}
	
	
	div.footerMenu {
		/* border: solid 1px red; */
		background-color: #f8f8f8;
		height: 65px;
		/* padding-top: 20px; */
		/* width: 95%; */	
		padding: 20px 0 0 250px;
	}
	
	div.footerMenu > nav {
		margin-left: 10%;
	}
	
	div.footerMenu > nav > a { 
		color: #7f7a76;
		/* border: solid 1px black; */
		margin-right: 3%;
	}
	
	div.footermyimg {
		margin: 50px 0 0 10%;
	}
	
	div.footerInfo {
		display: flex;	
	}
	
	div.footercompanyInfo {	
		/* border: solid 1px black; */
		width: 35%;
		margin: 30px;
	}
	div.footercompanyInfo > p {
		color: #7f7a76;
		font-size: 11pt;
	}
	
	div.footerclientService {
		margin: 30px;
		width: 35%;
	}
	
	div.footerclientService > a {
		border: solid 1px gray;
		color: #7f7a76;
		font-size: 11pt;
		padding: 5px;
		margin-right: 5px;
	}
	
	i.footer-i {
		font-size: 15pt;
		background-color: #9d9995;
		color: white;
		padding: 8px;
		border-radius: 50%;
		margin-right: 10px;
	}
	
	div.footericon {
		margin-top: 20px
	}
	
	div.footerbtm {
		text-align: center;
		margin: 20px auto;
		font-size: 11pt;
	}
	div.footerbtm > a {
		color: #7f7a76;
		margin-right: 2%;
	}
	
	div.footerclientService > a:hover, div#footerMenu > nav > a:hover
	,div.footerbtm > a:hover {
		text-decoration: none; 
	}
	
</style>



	<div class="footer position-relative" style="left : 67px;">
		<div class="footerMenu">
			<nav>
				<a href="#">회사소개</a>
				<a href="#">공지사항</a>
				<a href="#">입점 · 제휴 · 광고문의</a>
				<a href="#">이용약관</a>
				<a href="#" style="color:black">개인정보처리방침</a>
			</nav>
		</div>
		
		<div class="footerInfo">
		    <div class="footermyimg">
		    	<img src="<%=ctxPath %>/images/5조닭조.png"/>
		    </div>
		    
		    <div class="footercompanyInfo">
		    	<h6 style="font-size: 14pt">(주)오조닭조</h6>
		    	<p>대표 : 강성은 | 주소 : 서울특별시 마포구 월드컵북로 21, 2층(풍성빌딩) | 사업자등록번호 : 02-336-8546 <a href="#" style="color:#7f7a76; text-decoration: underline" >사업자정보 확인</a> | 강팀장조팀원 : 강성은, 지성인, 민동현, 손주선, 김형석, 김나윤 | 개인정보보호책임자 : 서영학</p>
		    	<p>&copy; Copyright©오조닭조 All rights reserved.</p>
		    </div>
		    
		    <div class="footerclientService">
		    	<h6 style="font-size: 14pt">고객센터 <span style="color: orange; font-weight: 750;">02-2025-4733</span></h6>
		    	<p>FAX 02-6937-0039 &nbsp;&nbsp; help@saramin.co.kr</p>
		    	<a href="#">고객의소리</a>
		    	<a href="#">1:1문의</a>
		    	<div class="footericon">
		    		<a href="https://www.youtube.com/"><i class="fa-brands fa-youtube footer-i"></i></a>
		    		<a href="https://ko-kr.facebook.com/"><i class="fa-brands fa-facebook-f footer-i"></i></a>
		    		<a href="https://www.instagram.com/"><i class="fa-brands fa-instagram footer-i"></i></a>
		    		<a href="https://twitter.com/?lang=ko"><i class="fa-brands fa-twitter footer-i"></i></a>
		    		<a href="https://section.blog.naver.com/BlogHome.naver?directoryNo=0&currentPage=1&groupId=0"><i class="fa-solid fa-blog footer-i"></i></a>
		    		<a href="https://www.google.com/?hl=ko"><i class="fa-brands fa-google footer-i"></i></a>
		    	</div>
		    </div>	
		</div>
		<hr style="width:90%; margin: 0 auto;">
		<div class="footerbtm">
			<a href="#">&nbsp;정보보호 관리체계 ISMS 인증 획득</a>
			<a href="#">&nbsp;우리은행 구매 안전 서비스 가입사실 확인</a>
		</div>
	</div>	


</body>
</html>
