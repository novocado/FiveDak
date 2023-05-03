<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  
<jsp:include page="/WEB-INF/views/header-final.jsp"/>
<% String ctxPath = request.getContextPath();%>
<jsp:include page="/WEB-INF/views/member/mypageSidebar_admin.jsp"/>

<script type="text/javascript">
	$(document).ready(function(){
		$('select#orderStatus').val('${requestScope.odto.orderStatus}');
		
		
		
		
		
	});
	
	function goBack(){
		location.href = "<%=ctxPath%>/admin/adminHome.dak";
		
	};// END OF FUNCTION GOBACK() 
	
	function goEdit(){
		const order_serial = '${requestScope.odto.orderSerial}' ;
		const orderStatus = $('select#orderStatus').val();
		
		if ( confirm("해당 주문' "+order_serial+" '을 주문 상태를 변경하시겠습니까?")){
				$.ajax({
					url:"<%= request.getContextPath()%>/admin/orderEditStatus.dak",
					type:"post",
					data:{"order_serial":order_serial , "orderStatus" : orderStatus},
					dataType:"json",
					success:function(json){
						if(json.n == 1) { 
							location.href = "<%= request.getContextPath()%>/admin/orderDetail.dak?order_serial="+order_serial;
						}
						else{
							alert(' 주문 상태 변경이 제대로 수행되지 않았습니다.');	
						}
						
					},
					error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            }
					
				}); // END OF $.ajax
		} // end of if 문
		else{
			alert(' 주문 상태 변경을 취소하셨습니다.');
		}
		
	};// END OF FUNCTION GOEDIT() 
	
	function goDelete(){
		const order_serial = '${requestScope.odto.orderSerial}' ;
		
		if ( confirm("해당 주문' "+order_serial+" '을 주문을 삭제하시겠습니까?")){
				$.ajax({
					url:"<%= request.getContextPath()%>/admin/orderRemove.dak",
					type:"post",
					data:{"order_serial":order_serial},
					dataType:"json",
					success:function(json){
						if(json.n == 1) { 
							location.href = "<%=ctxPath%>/admin/adminHome.dak";
						}
						else{
							alert(' 주문 삭제가 제대로 수행되지 않았습니다.');	
						}
						
					},
					error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            }
					
				}); // END OF $.ajax
		} // end of if 문
		else{
			alert(' 주문 삭제를 취소하셨습니다.');
		}
		
		
	}// END OF FUNCTION GODELET ( )
	
</script>
<div class="col-md-9">
      <!-- 오른쪽에 들어갈 내용 -->
      		<h2 class="float-left"> 주문번호 ${requestScope.odto.orderSerial } 의 주문 상세 내역</h2>
      		<hr style="border: 1px solid; clear:both;"/>
      		
 <div style="border: solid 1px black;">
            <table class="table">
               <tbody>
                  <tr>
                     <th class="MemberShowDetailth">주문번호</th>
                     <td>${requestScope.odto.orderSerial}</td>    
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">주문자 아이디</th>
                     <td>${requestScope.odto.fk_orderMbrId }</td>
                     <th class="MemberShowDetailth">주문금액</th>
                     <td><fmt:formatNumber value="${requestScope.odto.orderTotalPrice }" pattern="#,###"/></td>
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">주문 날짜</th>
                     <td>${requestScope.odto.orderDate }</td>
					 <th></th>
					 <td></td>	
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">운송장 번호</th>
                     <td>${requestScope.odto.orderTrackNo }</td>
                     <th class="MemberShowDetailth">배송상태여부</th>
                  	<td>
                  		<select id="orderStatus">
                  			<option value="1">결제완료</option>
                  			<option value="2">출고완료</option>
                  			<option value="7">미배송중</option>
                  			<option value="3">배송중</option>
                  			<option value="4">배송완료</option>
                  			<option value="6">결제취소</option>
                  		</select>
                  	 <button type="button" class="btn" style="background-color: #FFA751;" onclick="goEdit()">수정</button>
                  	</td>
                  </tr>
                  
                  <tr>
                  	<th>배송지 주소</th>
                  	<td>${requestScope.odto.combineAddress }</td>
                  	 <th>배송시 요청사항</th>
					 <td>${odto.orderMessage}</td>	
                  </tr>
                
						<c:forEach var="list" items="${requestScope.odtolist}">
							<tr>
								<th>주문 상품 이름</th>	
								<td>${list.prod.prodName}</td>
								
								<th>브랜드 명</th>
								<td>${list.prod.brandDTO.brandName}</td>
								
							</tr>
							
							<tr>
								<th>주문 제품수 </th>
								<td>${list.orddt.orderQuantity}</td>
								<th>주문 제품가격 </th>
								<td><fmt:formatNumber value="${list.orddt.pricePerUnit}" pattern="#,###"/></td>
							</tr>
								
							<tr>
								<th>주문 이미지</th>
								<td><img src="/FiveDak/images/${list.prod.prodImage1}" style="width:80px; height:80px;"/></td>
							    <th></th>
							 	<td></td>	
							</tr>	
						
						</c:forEach>                  
                  
               </tbody>
            </table>
         </div>
         
         <div style = "text-align: center; margin-top: 50px;">
            <button type="button" class="btn" style="background-color: #FFA751; color:white;" onclick="goBack()">뒤로가기</button>
            <button type="button" class="btn" style="background-color: #FFA751; color:white;" onclick="goDelete()">주문취소하기</button>
         </div> 
      		



































      <!-- 오른쪽에 들어갈 내용 -->
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"/>