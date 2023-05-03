<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

        
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
 
<%
	String ctxPath = request.getContextPath();
%> 
   
<jsp:include page="/WEB-INF/views/member/mypageSidebar.jsp"/>


<style type="text/css">





</style>


<script type="text/javascript">
	$(document).ready(function(){
		
		// *** 특정 회원을 클릭하면 그 회원의 상세정보를 보여주도록 한다. *** //
		$("tr.Show1to1Detail").click((e) => {

			const qnaId = $(e.target).parent().find("td#qna_ID").text();
			const qnauserid = $(e.target).parent().find("td#QNA_MEMBER_ID").text();
			const qnacontent = $(e.target).parent().find("td#QUESTION_CONTENT").text();
			const qnatitle = $(e.target).parent().find("td#QUESTION_TITLE").text();
			const qnacreated_at = $(e.target).parent().find("td#QUESTION_CREATED_AT").text();
					$.ajax({
					  url:"<%=ctxPath%>/mypage/1to1QNAAnswerDetail.dak",
					  type:"POST",
					  data:{"qnaId":qnaId,
						     "qnauserid": qnauserid,
						     "qnacontent": qnacontent,
						     "qnatitle": qnatitle,
						     "qnacreated_at":qnacreated_at},
					  success: function(result) {
						  $('div#mbr1to1').html(result);
					  },
					  error: function(request, status, error){
					    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					  }
					});						
		});		
		
		
	});
</script>

		 
<div>
	
	<h2 style="float:left;">1대1 문의 답변</h2>
    
</div>

<div id="mbr1to1" style="clear: both;">	

	<div style="border: solid 2px black; margin-bottom: 20px;"></div>

	
	
	<c:if test="${not empty requestScope.QNAList}">  <%-- 포인트 기록이 있을경우를 만들 if 문 하나 --%>
	

		<table class="table">
		  <thead>
		    <tr>
		      <th>글쓴 날짜</th>
		      <th>제목</th>
		      <th>글쓴이</th>
		    </tr>
		  </thead>
		  <tbody>
		  
		  <%--   반복문 items는 배열또는 LIST 만 테이블을 반복해야 하므로 임시로 사용함 기능 구현때 구현하기   --%>
		  	<c:forEach var="qna" items="${requestScope.QNAList}">
		  	

			    <tr class="Show1to1Detail" style="border-bottom: solid 1px black;">
			      <td id="QUESTION_CREATED_AT">${qna.QUESTION_CREATED_AT}</td>
			      <td id="QUESTION_TITLE">${qna.QUESTION_TITLE}</td>
			      <td id="QNA_MEMBER_ID">${qna.QNA_MEMBER_ID}</td>
			      <td style="display: none" id="qna_ID">${qna.QNA_ID}</td>
			      <td style="display: none" id="QUESTION_CONTENT">${qna.QUESTION_CONTENT}</td>
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




	
	<c:if test="${empty requestScope.QNAList}"> 
	
	<div style="text-align: center;">
		<div style="margin-top: 100px;"><i class="fad fa-exclamation fa-5x"></i></div>
		<span> 문의 내역이 없습니다.</span>
	
	</div>
	</c:if> <%-- if 문 끝 나는 곳 --%>  
	
		
	<div>



    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"/>




<%-- <table class="table">
		 		<thead>
		 			<tr>
		 				<th>제목 : ${qna.QUESTION_TITLE}</th>
		 				
		 			</tr>
		 		</thead>
		 	</table>
		 	
		 	<div>
		 		<span>작성자 : ${qna.QNA_MEMBER_ID}</span>
		 		<span style="float: right">작성일자 : ${qna.QUESTION_CREATED_AT}</span>
		 	</div>		
		 	
		 	
		 	<div style="clear: both; border-top: solid 1px black; padding: 10px 0;">${qna.QUESTION_CONTENT}</div>
		 	<div style="text-align: center; margin-bottom: 100px;"><button type="button" class="btn btn-secondary btn-lg">답변 확인하기</button></div>
		 	 --%>