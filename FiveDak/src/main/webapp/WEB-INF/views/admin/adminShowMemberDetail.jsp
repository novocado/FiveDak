<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
 
<%
	String ctxPath = request.getContextPath();
%> 
    
<jsp:include page="/WEB-INF/views/header-final.jsp"/>

<jsp:include page="/WEB-INF/views/member/mypageSidebar_admin.jsp"/>

<style type="text/css">

	.MemberShowDetailth {
		background-color: #e6e6e6;
	}

</style>


<script type="text/javascript">
	$(document).ready(function(){
		
		
				
	});
	
	
	function gobackMemberShow() {
		
		location.href = "<%=ctxPath%>/admin/adminShowMember.dak";
		
	}
	
</script>

<div class="col-md-9">
      <!-- 오른쪽에 들어갈 내용 -->
      	<h2 class="h2 mb-3" style="text-align: center;">${requestScope.mdto.mbrName} 회원 정보 상세 페이지</h2>
      	<div style="border: solid 1px black;">
      		<table class="table">
      			<tbody>
      				<tr>
      					<th class="MemberShowDetailth">회원번호</th>
      					<td>${requestScope.mdto.mbrNum}</td>    
      				</tr>
      				<tr>
      					<th class="MemberShowDetailth">이름</th>
      					<td>${requestScope.mdto.mbrName}</td>
      					<th class="MemberShowDetailth">아이디</th>
      					<td>${requestScope.mdto.mbrId}</td>
      				</tr>
      				<tr>
      					<th class="MemberShowDetailth">휴대폰</th>
      					<td>${requestScope.mdto.mbrMobile.substring(0, 3)}-${requestScope.mdto.mbrMobile.substring(3, 7)}-${requestScope.mdto.mbrMobile.substring(7)}</td>
      					<th class="MemberShowDetailth">이메일</th>
      					<td>${requestScope.mdto.mbrEmail}</td>
      				</tr>
      				<tr>
      					<th class="MemberShowDetailth">성별</th>
      					<c:if test="${requestScope.mdto.mbrGender =='1'}">
      						<td>남자</td>
      					</c:if>
      					<c:if test="${requestScope.mdto.mbrGender =='2'}">
      						<td>여자</td>
      					</c:if>
      					<th class="MemberShowDetailth">생일</th>
      					<td>${requestScope.mdto.mbrBirth.substring(0,4)}/${requestScope.mdto.mbrBirth.substring(4,6)}/${requestScope.mdto.mbrBirth.substring(6)}</td>
      				</tr>
      				
      				<tr>
      					<th class="MemberShowDetailth">우편번호</th>
      					<td>${requestScope.mdto.mbrPostcode}</td>
      				</tr>
      				<tr>
      					<th class="MemberShowDetailth">주소</th>
      					<td>${requestScope.mdto.mbrAddress}</td>
      					<th class="MemberShowDetailth">상세주소</th>
      					<td>${requestScope.mdto.mbrDetailAddress}</td>
      				</tr>
      				<tr>
      					<th class="MemberShowDetailth">보유 포인트</th>
      					<td>${requestScope.mdto.mbrPoint}</td>
      					<th class="MemberShowDetailth">회원 티어</th>
      					<td>${requestScope.mdto.mbrTierId}</td>
      				</tr>
      				<tr>
      					<th class="MemberShowDetailth">구입수량</th>
      					<td>${requestScope.mdto.mbrPurchaseAmount}</td>
      					<th class="MemberShowDetailth">회원 가입일</th>
      					<td>${requestScope.mdto.mbrRegDate}</td>
      				</tr>
      				<tr>
      					<th class="MemberShowDetailth">회원 상태</th>
      					<c:if test="${requestScope.mdto.mbrStatus =='1'}">
      						<td>활동 가능</td>
      					</c:if>
      					<c:if test="${requestScope.mdto.mbrStatus =='0'}">
      						<td>활동 정지</td>
      					</c:if>
      				</tr>
      				<tr>
      					<th class="MemberShowDetailth">계정 상태</th>
      					<c:if test="${requestScope.mdto.mbrIdle =='1'}">
      						<td>활성화 상태</td>
      					</c:if>
      					<c:if test="${requestScope.mdto.mbrIdle =='0'}">
      						<td>휴먼 상태</td>
      					</c:if>
      				</tr>
      				
      				
      			</tbody>
      		</table>
      	</div>
      	
      	<div style = "text-align: center; margin-top: 50px;">
      		<button type="button" class="btn" style="background-color: #FF7E32;" onclick="gobackMemberShow()">회원목록으로 돌아가기</button>
      	</div> 
      <!-- 오른쪽에 들어갈 내용 -->
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"/>
