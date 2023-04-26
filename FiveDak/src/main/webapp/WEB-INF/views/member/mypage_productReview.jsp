<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>        
<jsp:include page="/WEB-INF/views/member/mypageSidebar.jsp"/>
<style>
	
	* { font-family: "Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif; }
	
	span.product_review_reviewpossibledate {
		color: #666666;
	}
	
	
	div.body_1 {
		display: flex;
	}
	
	
	button.btn_review_write {
		border: solid 1px #FF7E32;
		color: #FF7E32;
		background-color: white;
		font-size: 10pt;
		font-weight: bold;
		border-radius: 10px;
		height: 35px;
		padding: 7px;
		width: 88px;
	}
		a.color_orange {
		color:#FF7E32;
	}
	
	span.span_review_expire {
		display: inline-block;
		border: solid 1px #d9d9d9;
		color: #d9d9d9;
		background-color: white;
		font-size: 10pt;
		font-weight: bold;
		padding: 7px;
		border-radius: 10px;
		height: 35px;
		width: 88px;
		text-align: center;
	}
	
	
	
</style>


			<div class="review_1" style="border-bottom: solid 1px #333; margin-left: 40px; padding-bottom: 120px; ">
				<h2 style="padding-bottom: 10px; margin: 20px 0px 15px 0px; color:#333; border-bottom : solid 1px #333;">상품후기</h2>
					<p style="margin: 20px 0px 15px 0px; font-size:14pt;">작성가능한 후기 
						<span style="color: #FF7E32;">1건</span>
						<button class="btn" type="button" data-toggle="collapse" data-target="#demo1" style="float:right;">
						  <i class="fa-solid fa-chevron-down"></i>
					  	</button>
					</p>
				<div id="demo1" class="collapse">
					<div class="card bg-light" style="margin: 20px 0px 40px 0px;">
					  	<div class="card-header row-12" style="display:flex; height: 45px; font-size:13pt;">
						  	<div class="col-md-8 text-center"><span class="product_review_reviewpossibledate">상품</span></div>
						  	<div class="col-md-2"><span class="product_review_reviewpossibledate">작성가능기간</span></div>
						  	<div class="col-md-2" style="margin-left:30px;"><span class="product_review_reviewpossibledate">후기작성</span></div>
					  	</div>
					  <div class="card-body body_1 row-md-12">
					  	  <div class="body col-md-2" style="padding:0px;">
					  		<img src="../images1/맛있닭 이미지.png"/>
					  	  </div>	
						  <div class="contents col-md-5" style="padding: 5px 0 10px 0px;">
						  	  <div style="margin-bottom: 15px;">
						  	  		<span style="color:#666666;">RK2304010003503276</span>
						  	  </div>
						  	  <a href="#" style="color:#333; ">맛있닭 스팀 닭가슴살 오리지널 100g X 30팩(3kg)</a>
						  </div>
						  <div class="col-md-3 text-center"style="padding-top:30px; margin-left:25px">
							  <span style="color:#666666;font-size:13pt; ">&nbsp;&nbsp;2023.04.22</span>
						  </div> 
						  <div class="col-md-1"style="padding:30px 0 0 0; margin-left:15px">
						  	  <button class="btn_review_write"><i class="fa-solid fa-pen"></i> 후기작성</button>
						  </div>   
					  </div>
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
			
			<div class="review_2" style="margin-left: 40px;">
				<div class="review-head">
						<p style="margin: 20px 0px 15px 0px; font-size:14pt;">작성 완료 후기
						 	<span style="color: #FF7E32;">1건</span>
						 	<button class="btn" type="button" data-toggle="collapse" data-target="#demo2" style="float:right;">
							   <i class="fa-solid fa-chevron-down"></i>
						  	</button>
						</p>
				</div>
				<div id="demo2" class="collapse">
					<div class="card bg-light" style="margin: 20px 0px 40px 0px;">
					  	<div class="card-header row-12" style="display:flex; height: 45px; font-size:13pt;">
						  	<div class="col-md-8 text-center"><span class="product_review_reviewpossibledate">상품</span></div>
						  	<div class="col-md-2"><span class="product_review_reviewpossibledate">작성일</span></div>
						  	<div class="col-md-2"style="margin-left:30px;"><span class="product_review_reviewpossibledate">후기작성</span></div>
					  	</div>
					  <div class="card-body body_1 row-md-12">
					  	  <div class="body col-md-2" style="padding:0px;">
					  		<img src="../images1/맛있닭 이미지.png"/>
					  	  </div>	
						  <div class="contents col-md-5" style="padding: 5px 0 10px 10px;">
						  	  <div style="margin-bottom: 15px;">
						  	  		<span style="color:#666666;">RK2304010003503276</span>
						  	  </div>
						  	  <a href="#" style="color:#333; ">맛있닭 스팀 닭가슴살 오리지널 100g X 30팩(3kg)</a>
						  </div>
						  <div class="col-md-3 text-center" style="padding-top:30px;">
							  <span style="color:#666666; font-size:13pt; margin-left:25px ">2023.04.22</span>
						  </div> 
						  <div class="col-md-1"style="padding:30px 0 0 0; margin-left:15px">
						  	  <span class="span_review_expire"> 기간만료</span>
						  </div>   
					  </div>
					</div>
					<div id="review-paging">
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
</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>