<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/header-final.jsp"/>
<% String ctxPath = request.getContextPath();%>
<jsp:include page="/WEB-INF/views/member/mypageSidebar_admin.jsp"/>
<style type="text/css">
 	span.error{
 		color:red;
 		
 	}

</style>
<script type="text/javascript">
	$(document).ready(function(){
		
		 $('span.error').hide();
	     $(document).on("change",'input#img_file1',function(event){
				// alert("확인용");	
				const input_file = $(event.target)[0];		
	
		      console.log(input_file.files[0]);
	   		  console.log(input_file.files[0].name);
  	
		        // File 객체의 실제 데이터(내용물)에 접근하기 위해 FileReader 객체를 생성하여 사용한다.
		      const fileReader = new FileReader();
		      
		      fileReader.readAsDataURL(input_file.files[0]); // FileReader.readAsDataURL() --> 파일을 읽고, result속성에 파일을 나타내는 URL을 저장 시켜준다.
		   
		       fileReader.onload = function() { // FileReader.onload --> 파일 읽기 완료 성공시에만 작동하도록 하는 것임. 
	 	       		document.getElementById("previewImg1").src = fileReader.result;
      	  };
          
          
		 });
		
	     // === 제품이미지 또는 추가이미지 파일을 선택하면 화면에 이미지를 미리 보여주기 끝 === 
			     $(document).on("change",'input#img_file2',function(event){
				// alert("확인용");	
				const input_file = $(event.target)[0];		
	
		      console.log(input_file.files[0]);
	   		  console.log(input_file.files[0].name);
  	
		        // File 객체의 실제 데이터(내용물)에 접근하기 위해 FileReader 객체를 생성하여 사용한다.
		      const fileReader = new FileReader();
		      
		      fileReader.readAsDataURL(input_file.files[0]); // FileReader.readAsDataURL() --> 파일을 읽고, result속성에 파일을 나타내는 URL을 저장 시켜준다.
		   
		       fileReader.onload = function() { // FileReader.onload --> 파일 읽기 완료 성공시에만 작동하도록 하는 것임. 
	 	       		document.getElementById("previewImg2").src = fileReader.result;
      	  };
          
          
		 });
		// === 제품이미지 또는 추가이미지 파일을 선택하면 화면에 이미지를 미리 보여주기 끝 === 
		
			
			
			
	}); // END OF DOCUMENT.READY(FUCNTION)
	
	
	
	function goBack(){
		location.href = "<%=ctxPath%>/admin/adminProductSearch.dak";
		
	};// END OF FUNCTION GOBACK() 
	
	function goRegister(){
			$('span.error').hide();
			let flag = false ; 
			$(".infoData").each(function(index,elmt){
				const value = $(elmt).val().trim();
				if (value==""){
					$(elmt).next().show();
					flag = true ;
					return false ;
				}
					
			});
			
			if ( !flag ){
				const frm = document.prodInputFrm;
				frm.submit();
			}
			
		
	}// END OF FUNCTION goRegister
</script>

	
 <div class="col-md-9">   
    
    <!-- 오른쪽에 들어갈 내용 -->
      		<h2 class="float-left"> 새로운 제품 등록하기 </h2>
      		<hr style="border: 1px solid; clear:both;"/>
      		
 <div style="border: solid 1px black;">
 			<form name="prodInputFrm"
      action="<%= request.getContextPath()%>/admin/adminProductInsert.dak"
      method="POST"                         
      enctype="multipart/form-data">
            <table class="table">
               <tbody>
                  <tr>
                     <th class="MemberShowDetailth">제품이름</th>
                     <td><input class="infoData" name="prodName" type="text" placeholder="제품 이름을 입력하세요!" />
                     <span class="error">입력하세요</span></td>
                     <th class="MemberShowDetailth">카테고리</th>
                     <td>
                     	<select name="cateId">
                     		<c:forEach var="cdo" items="${requestScope.cdto}">
                     			<option value="${cdo.cateId}">${cdo.cateName}</option>
                     		</c:forEach>
                     	</select>
                     </td>
                  </tr>
                  
                  <tr>
                     <th class="MemberShowDetailth ">브랜드</th>
                  	 <td><input class="infoData" name="brandName" type="text" placeholder="브랜드 이름을 입력하세요!" />
                  	 <span class="error">입력하세요</span></td>
                  	 <th class="MemberShowDetailth">재고</th>
                  	 <td><input class="infoData" name="prodStock" type="number" placeholder="재고량을 입력하세요"/>
                  	 <span class="error">입력하세요</span></td>
                  </tr>
                  
                  <tr>
                     <th class="MemberShowDetailth">제품 정가</th>
                  	 <td><input class="infoData"  name="prodPrice" type="number" placeholder="제품의 정가를 입력하세요" /><span class="error">입력하세요</span>
                  	 </td>
                  	 <th class="MemberShowDetailth">제품 판매가</th>
                  	 <td><input class="infoData"  name="prodSales" type="number" placeholder="제품의 판매가를 입력하세요"/><span class="error">입력하세요</span>
                  	 </td>
                  </tr>
                  
                  <tr>
                     <th class="MemberShowDetailth">제품이미지</th>
                      <td>
				         <input id="img_file1" class="img_file infoData" type="file" name="pimage1" accept='image/*' /><span class="error">넣어주세요</span>
				      </td>

                  </tr>
                  
                   <tr>
			          <th class="prodInputName" style="padding-bottom: 10px;">이미지파일 <br>미리보기</th>
			          <td>
			             <img id="previewImg1" width="300" />
			          </td>
   				   </tr>
                  
                   <tr>
			          <th class="prodInputName" style="padding-bottom: 10px;">추가할 이미지<br> 파일 </th>
					   <td>
				         <input id="img_file2" class="img_file" type="file" name="pimage2" accept='image/*' />
				      </td>
   				   </tr>
          
   				   <tr>
			          <th class="prodInputName" style="padding-bottom: 10px;">이미지파일 <br>미리보기</th>
			          <td>
			             <img id="previewImg2" width="300" />
			          </td>
   				   </tr>
   				  
               		</tbody>
           	 	</table>
            </form>
         </div>
         
         <div style = "text-align: center; margin-top: 50px;">
            <button type="button" class="btn" style="background-color: #FFA751; color:white;" onclick="goBack()">뒤로가기</button>
            <button type="button" class="btn" style="background-color: #FFA751; color:white;" onclick="goRegister()">등록하기</button>
            
         </div>    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
      <!-- 오른쪽에 들어갈 내용 -->
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"/>    