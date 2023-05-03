<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
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
   
   button.span_review_expire {
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

<script type="text/javascript">
   
   
   
   $(document).ready(function(){
	   loadReviewableOrderDetail(1);
	   loadReviewedOrderDetail(1);
      
   });
   
   
   
   
   function loadReviewableOrderDetail(page) { 
	   
	   $.ajax({  
	     	   url:"<%=ctxPath %>/mypage/reviewableorderdetail.dak" , 
	     	   data:{"page":page} , 
	     	   type:"post" , 
	           async:true ,
	           success:function(result){
	               $("div.review_1").html(result);
	            							
	             },
	             error: function(request, status, error){
	                 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	               }
	       	}); 
	   
   }
   
   
	function loadReviewedOrderDetail(page) { 
	   
	   $.ajax({  
	     	   url:"<%=ctxPath %>/mypage/reviewedorderdetail.dak" , 
	     	   data:{"page":page} , 
	     	   type:"post" , 
	           async:true ,
	           success:function(result){
	               $("div.review_2").html(result);
	            							
	             },
	             error: function(request, status, error){
	                 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	               }
	       	}); 
	   
   }
</script>

		 <h2 style="padding-bottom: 10px; margin: 20px 0px 15px 0px; color:#333; border-bottom : solid 1px #333;">상품후기</h2>
		 
         <div class="review_1" style="border-bottom: solid 1px #333; margin-left: 40px; padding-bottom: 120px; ">
        
            
            
         </div>
         
         <div class="review_2" style="margin-left: 40px;">
            

               
            </div>
      
</div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/footer.jsp"/>  