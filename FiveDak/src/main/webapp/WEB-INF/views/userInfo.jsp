<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>    
    
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<jsp:include page="/WEB-INF/views/header-final.jsp"/>
<%-- <jsp:include page="/WEB-INF/views/cscenter/cssidebar.jsp"/> --%>

<div class="col-md-9"> 

	<div class="container">
	
	<h4 style="margin-top:25px; font-weight: 600;">이용안내</h4>
	
	<hr style="border:solid 1px #ccc;">

<%-- <c:forEach var="map" items="${requestScope.userInfo}">
	<a href="<%= request.getContextPath()%>/service/instruction.dak?instruction_id=${map.instruction_id}">${map.instruction_title}</a>&nbsp;
</c:forEach> --%>
	<div id="accordionExample">
		<div class="panel-group" id="accordion">
		
		
			<div class="panel panel-default" style="overflow:hidden;">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a data-toggle="collapse" data-parent="#accordion" href="#collapse1">포인트 적립 안내</a>
					</h4>
				</div>
				<div id="collapse1" class="panel-collapse collapse">
					<div class="panel-body">
						<p class="txt">z
							<br>
							포인트 적립은 구매 확정 후 자동 적립 처리됩니다.
						</p>
					</div>
				</div>
			</div>
	  
	  
			<div class="panel panel-default" style="overflow:hidden;">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a data-toggle="collapse" data-parent="#accordion" href="#collapse2">현금영수증 발급 방법 안내 드립니다.</a>
					</h4>
				</div>
				<div id="collapse2" class="panel-collapse collapse">
					<div class="panel-body">
						<p class="txt">
						<p>아래 방법중 택일하여 진행해 주시면 됩니다.</p>
						<br>
						<p>1. 마이페이지 → 무통장입금 및 계좌이체로 결제하신 주문서 내역(주문번호) 클릭 → 하단 현금영수증란 현금영수증 발급 버튼 클릭 → 용도에 따라 소득공제용&amp;지출증빙용(사업자) 선택 → 정보 입력 후 발급버튼을 클릭.<br></p>
						<br>
						<p>2. 1:1 문의 게시판 또는 오조닭조 고객센터(02-6405-8088)로 연락 주시면 간단한 질문 드리고 발급 진행해 드립니다.<br></p>
					</div>
				</div>
			</div>
		  
	  
			<div class="panel panel-default" style="overflow:hidden;">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a data-toggle="collapse" data-parent="#accordion" href="#collapse3">주문취소 방법</a>
					</h4>
				</div>
				<div id="collapse3" class="panel-collapse collapse">
					<div class="panel-body">
					<p class="txt">
						<p style="font-size:14px; line-height: 26px; font-weight: 600;">오조닭조는 주문 완료 후 빠른 출고를 위해 구매 내역에서 취소가 불가합니다.</p>
						<br>
						<p style="font-size:14px; line-height: 22px; font-weight: 300; color:#333;">주문 취소를 원하시는 경우 1:1문의, 실시간채팅 또는 고객센터로 연락주시면 확인 후 안내드리겠습니다.</p>
						<br>
						<p style="font-size:14px; line-height: 22px; font-weight: 300; color:#333;">업무시간 이후의 경우 실시간채팅 또는 1:1문의에 남겨주시면 순차적으로 답변 드리겠습니다.</p>
						<br>
					</div>
				</div>
			</div>
		
	  
			<div class="panel panel-default" style="overflow:hidden;">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a data-toggle="collapse" data-parent="#accordion" href="#collapse4">한가지 제품만 왔어요</a>
					</h4>
				</div>
				<div id="collapse4" class="panel-collapse collapse">
					<div class="panel-body">
						<p style="font-size:15px; line-height: 22px; font-weight: 300; color:#000;">이용에 불편드려서 죄송합니다.</p>
						<br>
						<p style="font-size:14px; line-height: 22px; font-weight: 600; color:#000;">1. 누락- 누락된 상품과 수량을  게시판이나  고객센터(02-6405-8088)로 연락주시면 바로 출고하도록 하겠습니다.</p>
						<br>
						<p style="font-size:14px; line-height: 22px; font-weight: 600; color:#000;">2. 오배송- 오배송된상품의경우  오배송된 상품사진을 게시판에 첨부해주시거나 고객센타로 연락주시면 바로 주문하신상품으로 출고하도록 하겠습니다. </p>
						<br>
						<p style="font-size:13px; line-height: 22px; font-weight: 300; color:#000;">오배송된상품은 신선식품으로 회수되지 않으니 가능하시면 맛있게 섭취부탁드립니다(브랜드별 일부제외)</p>
						<br>
						<p style="font-size:13px; line-height: 22px; font-weight: 300; color:#000;">"오조닭조에서 판매되는 제품은 각 브랜드 별로만 묶음 배송이 가능합니다.
						주문시에 다른 브랜드의 제품 두가지를 주문하셨을 경우 브랜드에서 직접 출고되기 때문에 각각 따로 다른 배송사로 배송처리 됩니다."</p>
					</div>
				</div>
			</div>
	 
	 
			<div class="panel panel-default" style="overflow:hidden;">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a data-toggle="collapse" data-parent="#accordion" href="#collapse5">주문상품 언제 수령하나요</a>
					</h4>
				</div>
				<div id="collapse5" class="panel-collapse collapse">
					<div class="panel-body">
						<p style="font-size:16px; line-height: 26px; font-weight: 600;">1. 브랜드별 발송 마감시간 체크!</p>
						<p style="font-size:13px; line-height: 22px; font-weight: 300;">브랜드에 따라 발송 마감시간이 각각 다르오니 주문하실 제품의 상세페이지 하단의 배송 정보를 꼭 읽어주세요. 발송 마감전 입금이 확인된 주문건만 해당일 발송이 가능합니다.</p>
						<br>
						<p style="font-size:16px; line-height: 26px; font-weight: 600;">2. 주말/공휴일/휴일 전날에는 배송 휴무!</p>
						<p style="font-size:13px; line-height: 22px; font-weight: 300;">주말/공휴일/휴일 전날에는 발송업무를 하지 않습니다. 제품의 특성상(냉장/냉동식품) 배송시간을 최대한 짧게 하기 위한 조치입니다.</p>
						<br>
						<p style="font-size:13px; line-height: 22px; font-weight: 300;">토요일 전에 받아보시려면 꼭 금요일 발송마감시간 이전에는 주문&결제를 완료해 주세요.</p>
						<p style="font-size:13px; line-height: 22px; font-weight: 300; color:#f05623;">*공휴일 관련 배송 안내는 오조닭조 고객센터(공지사항 게시판)을 확인 해 주세요.</p>
					</div>
				</div>
			</div>
	   
	   
			<div class="panel panel-default" style="overflow:hidden;">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a data-toggle="collapse" data-parent="#accordion" href="#collapse6">앱에서 로그인이 안 될 때</a>
					</h4>
				</div>
				<div id="collapse6" class="panel-collapse collapse">
					<div class="panel-body">
						<br>
						<p style="font-size:14px; line-height: 24px; font-weight: 300; color:#000;">[로그인] 페이지 아이디/패스워드 입력란의 우측 하단 [아이디/비밀번호찾기]를 이용하시면 아이디 및 비밀번호를 확인/변경 하실 수 있습니다. </p>
						<br>
						<p style="font-size:14px; line-height: 22px; font-weight: 600; color:#000;">1. [로그인] 페이지로 이동</p>
						<p style="font-size:14px; line-height: 22px; font-weight: 600; color:#000;">2. 아이디/패스워드 입력란의 우측하단 [아이디/비밀번호 찾기] 버튼 클릭</p>
						<p style="font-size:14px; line-height: 22px; font-weight: 600; color:#000;">3. 휴대폰 번호 입력 인증번호 받기</p>
						<p style="font-size:14px; line-height: 22px; font-weight: 600; color:#000;">4. 인증번호 입력</p>
						<p style="font-size:14px; line-height: 22px; font-weight: 600; color:#000;">5. 인증 후 비밀번호 변경</p>
						<br>
						<p style="font-size:13px; line-height: 22px; font-weight: 300; color:#444;">위 방법으로도 로그인이 되지 않는 경우 고객센터(02-6405-8088)로 연락주시면 정보 확인 후 임시 비밀번호를 발급해 드립니다.
						<br>
					</div>
				</div>
			</div>
	   
	   
			<div class="panel panel-default" style="overflow:hidden;">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a data-toggle="collapse" data-parent="#accordion" href="#collapse7">앱다운로드 후 쿠폰발행</a>
					</h4>
				</div>
				<div id="collapse7" class="panel-collapse collapse">
					<div class="panel-body">
						<p style="font-size:16px; line-height: 26px; font-weight: 600;">어플을 설치하시고 로그인 상태에서 다시한번
						로그아웃을 해주시고, 재로그인을 해주시면 자동으로 쿠폰이 발급됩니다!</p>
						<br>
						<p style="font-size:14px; line-height: 22px; font-weight: 600; color:#f05623;">마이페이지 > 쿠폰 > 사용가능쿠폰 에서 확인이 가능합니다.</p>
						<br>
						<p style="font-size:13px; line-height: 22px; font-weight: 300;">* 재로그인시 쿠폰목록에서 확인이 안되시는경우 
						고객센터로 문의주시면 확인 후 빠른 처리 도와드리겠습니다.</p>
					</div>
				</div>
		   	</div>
	   
			<div class="panel panel-default" style="overflow:hidden;">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a data-toggle="collapse" data-parent="#accordion" href="#collapse8">배송 조회 확인 안내</a>
					</h4>
				</div>
				<div id="collapse8" class="panel-collapse collapse">
				<div class="panel-body">
					<br>
					<p style="font-size:14px; line-height: 26px; font-weight: 600;">오조닭조에서는 상품 발송 후 메일 문자를<br>이용하여 택배사/송장번호를 안내드리고 있습니다.</p> 
					<br>
					<p style="font-size:14px; line-height: 23px;">해당 주문의 조회를 원하시는 경우 아래 방법으로 조회가 가능합니다.</p>
					<br>
					<br>
					<p style="font-size:14px; line-height: 22px; font-weight: 600;">1. 마이페이지 > 해당 주문번호 클릭 > 택배 송장번호 클릭
					<br>
					<br>
					<p style="font-size:13px; line-height: 20px; color:#f05623;">*오조닭조에서는 택배가 두건 이상으로 발송되었을시에는 대표송장번호 조회만 가능합니다.</p>
					<br>
					<p style="font-size:14px; line-height: 22px;">대표상품 외 조회를 원하시는 경우 문자안내드린 송장번호로 아래 2번과 같이 조회해 주세요.</p>
					<br>
					<br>
					<p style="font-size:14px; line-height: 22px; font-weight: 600;">2. 메일/문자로 안내드린 택배송장번호로 해당 택배사 홈페이지에서 조회</p>
					<br>
				</div>
				</div>
			</div>
		   
	   
			<div class="panel panel-default" style="overflow:hidden;">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a data-toggle="collapse" data-parent="#accordion" href="#collapse9">특급배송 서비스 안내</a>
					</h4>
				</div>
				<div id="collapse9" class="panel-collapse collapse">
					<div class="panel-body">
						<p style="font-size:14px; line-height: 26px; font-weight: 600;"><span style="font-size:12px;"><span style="font-family:맑은 고딕;"></span></span><span style="font-size:14px;"><span style="font-family:맑은 고딕;"><span style="unicode-bidi:embed"><span style="color:black"><span style="font-weight:bold;">오조닭조 특급배송은 당일</span></span><span style="color:black;"><span style="font-weight:bold">, </span></span><span style="color:black"><span style="font-weight:bold">새벽</span></span><span style="color:black"><span style="font-weight:bold">, </span></span><span style="color:black"><span style="font-weight:bold">내일배송 </span></span><span style="color:black"><span style="font-weight:bold">3</span></span><span style="color:black"><span style="font-weight:bold">가지로 이용이 가능합니다</span></span><span style="color:black"><span style="font-weight:bold">.</span></span></span></span></span><span style="font-size:12px;"><span style="font-family:맑은 고딕;"><br />
						<span style="unicode-bidi:embed"><span style="color:black"></span></span></span></span><br>
						<span style="font-size:14px;"><span style="font-family:맑은 고딕;"><span style="unicode-bidi:embed"><span style="color:#f05623"><span style="font-weight:bold">오후 </span></span><span style="color:#f05623"><span style="font-weight:bold">1</span></span><span style="color:#f05623"><span style="font-weight:bold">시까지 주문</span></span><span style="color:#f05623"><span style="font-weight:bold">,</span></span> <span style="color:#f05623"><span style="font-weight:bold">오늘 도착</span></span><span style="color:#f05623"><span style="font-weight:bold">!</span></span></span><br />
						<span style="unicode-bidi:embed"><span style="color:#333333"><span style="font-weight:normal">오전에 주문하면 저녁에 딹</span></span><span style="color:#333333"><span style="font-weight:normal">!</span></span></span><br />
						<span style="unicode-bidi:embed"></span><br>
						<span style="unicode-bidi:embed"><span style="color:#f05623"><span style="font-weight:bold">저녁 </span></span><span style="color:#f05623"><span style="font-weight:bold">8</span></span><span style="color:#f05623"><span style="font-weight:bold">시까지 주문</span></span><span style="color:#f05623"><span style="font-weight:bold">, </span></span><span style="color:#f05623"><span style="font-weight:bold">내일 새벽 도착</span></span><span style="color:#f05623"><span style="font-weight:bold">!</span></span></span><br />
						<span style="unicode-bidi:embed"><span style="color:#333333"><span style="font-weight:normal">자고 일어나면 문 앞에 딹</span></span><span style="color:#333333"><span style="font-weight:normal">!&nbsp;</span></span></span><br />
						<br>
						<span style="unicode-bidi:embed"><span style="color:#f05623"><span style="font-weight:bold">밤 </span></span><span style="color:#f05623"><span style="font-weight:bold">12</span></span><span style="color:#f05623"><span style="font-weight:bold">시까지 주문</span></span><span style="color:#f05623"><span style="font-weight:bold">, </span></span><span style="color:#f05623"><span style="font-weight:bold">내일&nbsp;도착</span></span><span style="color:#f05623"><span style="font-weight:bold">!</span></span></span><br />
						<span style="unicode-bidi:embed"><span style="color:#333333"><span style="font-weight:normal">밤 늦게 주문해도 내일&nbsp;딹</span></span><span style="color:#333333"><span style="font-weight:normal">!</span></span></span></span></span><span style="font-size:12px;"><span style="font-family:맑은 고딕;"><br />
						<span style="unicode-bidi:embed"></span><br>
						<span style="unicode-bidi:embed"><span style="color:#444444"><span style="font-weight:normal">※ </span></span><span style="color:#444444"><span style="font-weight:normal">특급배송 상품 </span></span><span style="color:#444444"><span style="font-weight:normal">2</span></span><span style="color:#444444"><span style="font-weight:normal">만원 이상</span></span><span style="color:#444444"><span style="font-weight:normal">,</span></span><span style="color:#444444"><span style="font-weight:normal"> 내일도착 배송비 무료 </span></span><span style="color:#444444"><span style="font-weight:normal">(</span></span><span style="color:#444444"><span style="font-weight:normal">도서산간 제외</span></span><span style="color:#444444"><span style="font-weight:normal">)</span></span></span><br />
						<span style="unicode-bidi:embed"><span style="color:#444444"><span style="font-weight:normal">※ </span></span><span style="color:#444444"><span style="font-weight:normal">특급배송 상품 </span></span><span style="color:#444444"><span style="font-weight:normal">4</span></span><span style="color:#444444"><span style="font-weight:normal">만원 이상</span></span><span style="color:#444444"><span style="font-weight:normal">,</span></span><span style="color:#444444"><span style="font-weight:normal"> 당일</span></span><span style="color:#444444"><span style="font-weight:normal">/</span></span><span style="color:#444444"><span style="font-weight:normal">새벽도착 배송비 무료</span></span></span><br />
						<span style="unicode-bidi:embed"><span style="color:#444444"><span style="font-weight:normal">※ </span></span><span style="color:#444444"><span style="font-weight:normal">당일</span></span><span style="color:#444444"><span style="font-weight:normal">, </span></span><span style="color:#444444"><span style="font-weight:normal">새벽도착은 최소 주문 금액 </span></span><span style="color:#444444"><span style="font-weight:normal">2</span></span><span style="color:#444444"><span style="font-weight:normal">만원 이상일 경우</span></span> <span style="color:#444444"><span style="font-weight:normal">이용 가능하며</span></span><span style="color:#444444"><span style="font-weight:normal">,</span></span></span><br />
						<span style="unicode-bidi:embed"><span style="color:#444444"><span style="font-weight:normal">&nbsp; &nbsp; 오렌지멤버스 회원일 경우 최소 주문 금액에 상관없이 이용 가능합니다</span></span><span style="color:#444444"><span style="font-weight:normal">.</span></span></span><br />
						<span style="unicode-bidi:embed"><span style="color:#444444"><span style="font-weight:normal">※ </span></span><span style="color:#444444"><span style="font-weight:normal">당일</span></span><span style="color:#444444"><span style="font-weight:normal">, </span></span><span style="color:#444444"><span style="font-weight:normal">새벽도착은 수도권 </span></span><span style="color:#444444"><span style="font-weight:normal">/ </span></span><span style="color:#444444"><span style="font-weight:normal">충청권 </span></span><span style="color:#444444"><span style="font-weight:normal">/ </span></span><span style="color:#444444"><span style="font-weight:normal">대구 일부 지역에 한해 이용 가능합니다</span></span><span style="color:#444444"><span style="font-weight:normal">.&nbsp;(</span></span><span style="color:#444444"><span style="font-weight:normal">제공지역 확장 예정</span></span><span style="color:#444444"><span style="font-weight:normal">)</span></span></span><br />
						<span style="unicode-bidi:embed"><span style="color:#444444"><span style="font-weight:normal">※&nbsp;</span></span><span style="color:#444444"><span style="font-weight:normal">대구 지역은 </span></span><span style="color:#444444"><span style="font-weight:normal">18</span></span><span style="color:#444444"><span style="font-weight:normal">시 전 주문 시 익일 새벽에 도착합니다</span></span><span style="color:#444444"><span style="font-weight:normal">.</span></span></span></span></span><br />
						&nbsp;</p>
						<span style="font-size:12px;">
							<span style="font-family:맑은 고딕;"><br />
								<a href="#">특급배송 자세히 보러가기&gt;</a>
							</span>
						</span>
					</div>
				</div>
			</div>
    
				</div>
			</div>
		    
		</div>    <!-- <div class="container">의 끝! -->
	</div>  <!-- <div class="col-md-9">의 끝! -->    
	
</div>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>