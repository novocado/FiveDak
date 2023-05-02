<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/header-final.jsp"/>
<% String ctxPath = request.getContextPath();%>
<jsp:include page="/WEB-INF/views/member/mypageSidebar_admin.jsp"/>
<style type="text/css">
	
	
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('span#countHIT').hide();
	    $('span#totalHITCount').hide();
		displayOrder("1");
		$('select#order_status').val('${requestScope.order_status}');
		$('select#order_date').val('${requestScope.order_date}');
		
		$('select#order_status').on('change',goRedirect) ;
		$('select#order_date').on('change',goRedirect) ;
		
		$('button#btnMoreHIT').click(function(){
			if( $(this).text() == "처음으로" ){
				$('span#end').empty();
				$("tbody#json_put").empty();
				displayOrder("1");
				$('button#btnMoreHIT').text("더보기...");
			}
			else{
				displayOrder($(this).val());				
			}
			
		}); // END OF $('BUTTON#BTNMOREHIT').CLICK(FUNCTION(){
			
		$(document).on('click', 'tr.orderInfo', function(e){
			
			const orderserial = $(this).data('orderserial') ;
			location.href ="<%= ctxPath%>/admin/orderDetail.dak?order_serial="+orderserial;
		});
			
		$(document).on('mouseenter', 'tr.orderInfo', function() {
		    $(this).css('cursor', 'pointer');
		});

		$(document).on('mouseleave', 'tr.orderInfo', function() {
		    $(this).css('cursor', '');
		});
		
	}); // END OF 	$(DOCUMENT).READY(FUNCTION(){
	
	let lenHIT = 10 ;
	
	
 	function displayOrder(start){
 		$.ajax({ 
			url:"<%=request.getContextPath()%>/admin/adminShowOrder.dak"
			,type:"get"
			,data:{"order_date":'${requestScope.order_date}' 
				,"order_status":'${requestScope.order_status}'  
					,"start":start // "1" "9" "17" "25" "33"
					,"len":lenHIT} // "8" "8" "8"  "8"  "8"
			,dataType:"json"
		//	,async:true => 비동기 방식 (default 가 false)
			,success:function(json){
				let html = `` ;
				
				if (start == "1" && json.length == 0 ){
				
					// HIT 상품 결과물 출력하기
					$("span#no_data").text('요청하신 기간에 요건에 해당하는 주문이 없습니다.');
				}
				else if ( json.length > 0 ){
					$.each(json,function(index,item){
						html += 
							"<tr class='orderInfo' data-orderserial='"+item.order_serial+"'>"
					    +"<td class='orderid'>"+item.order_id+"</td>"
					    +"<td>"+item.order_member_id+"</td>"
					    +"<td>"+item.order_total_price+"</td>"
					    +"<td>"+item.shipping_address+"</td>"
					    +"<td>"+item.tracking_number+"</td>"
					    +"<td>"+item.recipmobile+"</td>"
					    +"<td>"+item.status_name+"</td>"
					    +"</tr>" ;
						
					});
						
					
					
					$("tbody#json_put").append(html);
					
					$('button#btnMoreHIT').val(Number(start)+lenHIT);
					// "더보기..." 버튼의 value 값이 9가 된다.
					//   ...
					// "더보기..." 버튼의 value 값이 41로 변경된다. (존재하지 않는 것이다.)
					
					// span#countHIT 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
					$('span#countHIT').text( Number($('span#countHIT').text())+ json.length);
					
					if (Number($('span#countHIT').text()) == Number($('span#totalHITCount').text())){
						// 더보기... 버튼을 계속해서 클릭하여 countHIT 값과 totalHITCount 값이 일치하는 경우 
						
						// alert('더이상 조회할 제품이 없습니다.');
						$('span#end').text('더이상 해당기간에 주문이 없습니다.');
						$('button#btnMoreHIT').text("처음으로");
						$('span#countHIT').text("0");
					}
					
					
				}// end of else if 
				
			}
			,error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		
 		}); 
	
 	}
 	
	function goRedirect(){
		const orderListFrm = document.orderListFrm;
		orderListFrm.method = "get";
		orderListFrm.action="adminHome.dak";
		orderListFrm.submit();	
		
	}
</script>

<div class="col-md-9">
      <!-- 오른쪽에 들어갈 내용 -->
      		<h2 class="float-left">전체주문내역</h2>
      		<h5 class="float-right" style="position:relative; top:10px;">전체 주문 수 : ${requestScope.sumMonthOrder} / 미배송중 : ${requestScope.sumNotShipped} </h5>
			<hr style="border: 1px solid; clear:both;"/>
		<form name="orderListFrm">
			<select id="order_date" name="order_date" class="mx-3 form-select float-right">
	            <option value="">이번달</option>
	            <option value="6">6개월</option>
	            <option value="12">12개월</option>
       		</select>
			
			<select id="order_status" name="order_status" class="mx-3 form-select float-right">
				<option value="">전체</option>
				<option value="1">결제완료</option>
				<option value="2">출고완료</option>
				<option value="3">배송중</option>
				<option value="4">배송완료</option>
				<option value="5">구매확정</option>
				<option value="6">결제취소</option>
				<option value="7">미배송중</option>
			</select>
		</form>
		
		<table class="table table-hover my-5">
		  <tr>
		    <th>주문번호</th>
		    <th>고객아이디</th>
		    <th>주문금액</th>
		    <th>배송주소</th>
		    <th>운송장 번호</th>
		    <th>수령인 연락처</th>
		    <th>배송상태여부</th>
		  </tr>
		  <tbody id="json_put">
		  	 
		  </tbody>
		</table>
		
        <p class="text-center">
            <span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span> 
            <span id="no_data" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span> 
            <button type="button" class="btn btn-secondary btn-lg" id="btnMoreHIT" value="" style="border-color:#FFA751; background-color: #FFA751">더보기...</button>
            <span id="totalHITCount">${requestScope.totalNo}</span>
            <span id="countHIT">0</span>
         </p>
        
      
      
      <!-- 오른쪽에 들어갈 내용 -->
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"/>
