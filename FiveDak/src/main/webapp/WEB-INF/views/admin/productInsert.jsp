<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/header-final.jsp"/>
<% String ctxPath = request.getContextPath();%>
<jsp:include page="/WEB-INF/views/member/mypageSidebar_admin.jsp"/>

<script type="text/javascript">
	$(document).ready(function(){
		
		
		
		
		
	});
	
	function goBack(){
		location.href = "<%=ctxPath%>/admin/adminProductSearch.dak";
		
	};// END OF FUNCTION GOBACK() 
</script>

	
 <div class="col-md-9">   
    
    <!-- 오른쪽에 들어갈 내용 -->
      		<h2 class="float-left"> 새로운 제품 등록하기 </h2>
      		<hr style="border: 1px solid; clear:both;"/>
      		
 <div style="border: solid 1px black;">
 			<form>
            <table class="table">
               <tbody>
                  <tr>
                     <th class="MemberShowDetailth">제품이름</th>
                     <td><input name="prodName" type="text" placeholder="제품 이름을 입력하세요!" /></td>
                     <th class="MemberShowDetailth">카테고리</th>
                     <td>
                     	<select>
                     		
                     	</select>
                     </td>
                  
                  </tr>
                  <tr>
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">주문 날짜</th>
                  	 <th></th>
					 <td></td>	
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">운송장 번호</th>
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
                  	 <th></th>
					 <td></td>	
                  </tr>
                
							<tr>
								<th>주문 상품 이름</th>	
								<td>${pdto.prodName}</td>
								
								<th>브랜드 명</th>
								<td>${pdto.brandDTO.brandName}</td>
								
							</tr>
							
							<tr>
								<th>주문 제품수 </th>
								<td>${pdto.orderNo}</td>
							</tr>
								
						
					
               		</tbody>
           	 	</table>
            </form>
         </div>
         
         <div style = "text-align: center; margin-top: 50px;">
            <button type="button" class="btn" style="background-color: #FFA751; color:white;" onclick="goBack()">뒤로가기</button>
         </div>    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
      <!-- 오른쪽에 들어갈 내용 -->
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"/>    