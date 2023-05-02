<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:include page="/WEB-INF/views/member/mypageSidebar.jsp"/>




<style type="text/css">




</style>



<script type="text/javascript">	
	
	$(document).ready(function(){
	    		
		/* let selectedValue = localStorage.getItem("selectedValue");    // localStorage에서 값 불러오기
		if (selectedValue != null) {	
			$("select#pointSelect").val(selectedValue); // 값이 저장되어 있다면 선택된 값으로 설정
		} */
		
	/* 	if($("select#pointSelect").val() != "") {
			
		}	 */	
		
		
		
		// 이거 없으면 새로 고침 할때 다시 처음으로 돌아감 
		$("select#pointSelect").val("${requestScope.pointSelect}");
		
		
		setEventHandling();

	});	// END OF $(DOCUMENT).READY(FUNCTION()

		
	function setEventHandling () { 
		 $("select#pointSelect").change(PointSelectChange);    // select 값이 변경된다면 실행 
	}
	
	// // select 값이 변경된다면 실행 코드 
	function PointSelectChange() {
		/* selectedValue = $(this).val(); // 선택된 값을 저장
	    localStorage.setItem("selectedValue", selectedValue); // localStorage에 값 저장
	         
	    location.reload();  // 새로고침 하기  */
	    
	    
	    
	    const Pointfrm = document.Pointform;
	    
	    Pointfrm.action = "point.dak";
	    Pointfrm.method = "get";
	    Pointfrm.submit();
		
	    
	}

</script>




<div>
	
	<h2 style="float:left;">포인트 </h2>
    
    <form name="Pointform">
	    <select class="form-select-lg" style="float:right; border-radius: 5px; height: 30px; width: 90px;" id="pointSelect" name="pointSelect">
			
			<option value="">전체내역</option>
		    <option value="1">지급내역</option>
		    <option value="2">차감내역</option>
		</select> 
		<input type="hidden" value="${requestScope.pointSelect}" />
	</form>  
</div>

<div style="clear: both;">	

	<div style="border: solid 2px black; margin-bottom: 20px;"></div>

	
	
	<c:if test="${not empty requestScope.memberPointList}">  <%-- 포인트 기록이 있을경우를 만들 if 문 하나 --%>
	

		<table class="table">
		  <thead>
		    <tr>
		      <th>날짜</th>
		      <th>내용</th>
		      <th>지급/차감</th>
		      <th>변동 포인트</th>
		      <th>보유 포인트</th>
		    </tr>
		  </thead>
		  <tbody>
		  
		  <%--   반복문 items는 배열또는 LIST 만 테이블을 반복해야 하므로 임시로 사용함 기능 구현때 구현하기   --%>
		  	<c:forEach var="point" items="${requestScope.memberPointList}">
		  	

			    <tr style="border-bottom: solid 1px black;">
			      <td id="Point-Date">
			      
			      	<span>${point.point_date}</span>
			      
			      </td>
			      <td id="Point-Content">
			        
			      	<span>${point.point_reason}</span>
			      
			      </td>
			      <td id="Point-Payment-deduction">
			      
			      	<c:choose>
			      		      		
			      		<c:when test="${point.point_change_type == 1}">
			  				<span>지급</span>
			  			</c:when>
			  			
			  			<c:when test="${point.point_change_type == 0}">
			  				<span>차감</span>
			  			</c:when>		
			  		</c:choose>
			  	  </td>
			      <td id="Point-Variation">
			      
			      	<span>${point.point_change}</span>
			      
			      
			      </td>
			      <td id="Point-Hold">
			      
			      
			     	 <span>${point.point_after}</span>
			      
			      
			      </td>
			    </tr>
		    	
		  
		   
		  
		  </c:forEach>
		    
			
		  
		  
		  
		  </tbody>
		</table>
		
		
		<nav class="my-5">
	        <div style='display:flex; width:100%;'>
	          <ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
	       </div>
	    </nav>

	
	</c:if>  <%--if 문 끝 나는 곳 --%>   




	<%-- 또다른 if 문 포인트 기록이 없으면 나타내 줄 HTML 부분  --%>
	
	<c:if test="${empty requestScope.memberPointList}"> <%-- 포인트 기록이 없으면은 포인트 지급/차감내역이 없습니다. --%>
	
	<div style="text-align: center;">
		<div style="margin-top: 100px;"><i class="fad fa-exclamation fa-5x"></i></div>
		<span> 포인트 지급/ 차감 내역이 없습니다.</span>
	
	</div>
	</c:if> <%-- if 문 끝 나는 곳 --%>  
	
	<div style="background-color: #e6e6e6; margin-top: 20%">
	
	
                <p style="padding: 20px 20px;">
	                ※ 상품구매 적립 포인트는&nbsp;구매확정 후&nbsp;자동 지급됩니다.<br>
					※ 적립일이&nbsp;오래된 포인트부터&nbsp;순차적으로 사용 처리됩니다.<br>
					※ 지급일로부터 1년이 지난 포인트는 자동 소멸됩니다.<br>
					※&nbsp;포인트 적립 및 사용에 대한 자세한 내역은 고객센터로 문의해주시기 바랍니다.&nbsp;
				</p>
	
	
	</div>
	
	
<div>



	</div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>