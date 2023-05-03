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
		
	});

	
</script>	
    
    
    
    
    
    <!-- 오른쪽에 들어갈 내용 -->
      	<table class="table">
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
		 	
		 	
      <!-- 오른쪽에 들어갈 내용 -->
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"/>