<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/header-final.jsp"/>
<% String ctxPath = request.getContextPath();%>
<jsp:include page="/WEB-INF/views/member/mypageSidebar_admin.jsp"/>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.error").hide();
		
		// 제품수량에 스피너 달아주기 
		//jquery UI 에서 복붙 해준 거!
		$("input#spinnerPqty").spinner({
		   spin:function(event,ui){
		      if(ui.value > 100) {
		         $(this).spinner("value", 100);  //max 가 100
		         return false;
		      }
		      else if(ui.value < 1) {
		         $(this).spinner("value", 1);   //min 이 1
		         return false;
		      }
		   }
		});// end of $("#spinnerPqty").spinner()--------
		
		
		//추가이미지파일 스피너 달아주기
		$("input#spinnerImgQty").spinner({
			   spin:function(event,ui){
			      if(ui.value > 10) {
			         $(this).spinner("value", 10);  //max 가 10
			         return false;
			      }
			      else if(ui.value < 0) {
			         $(this).spinner("value", 0);   //min 이 1
			         return false;
			      }
			   }
		});// end of $("input#spinnerImgQty").spinner()--------
		
	
		// #### 스피너의 이벤트는 click 도 아니고 change 도 아니고 "spinstop" 이다. #### //
		$("input#spinnerImgQty").bind("spinstop", function(){
			
			let html = ``;
			let cnt = $(this).val();
		
			for(let i=0; i<Number(cnt); i++) {
				html += `<br><input type="file" name="attach\${i}" class="btn btn-default img_file" accept='image/*' />`;  /* 백틱에서 $가 안 먹으니 역슬래시(\) 를 사용해줘야 한다. */
			}//end of for--------------------------------
		
			$("div#divfileattach").html(html);
			$("input#attachCount").val(cnt);
		
		});//end of $("input#spinnerImgQty").bind("spinstop", function(){})--------------------------

		
		
		//파일이름을 변경해야만 이벤트가 일어나도록 해야 하므로 change 이벤트를 사용해야 한다.
		$(document).on("change", "input.img_file", function(e){
			
			const input_file = $(e.target).get(0); 	
	        
	        console.log(input_file.files);
	        
	        console.log(input_file.files[0]);  //input_file.files[0] 얘는 배열이 아니라 대괄호표기법!
	         
	        console.log(input_file.files[0].name);
	        //berkelekle심플라운드01.jpg
	        
	     	// File 객체의 실제 데이터(내용물)에 접근하기 위해 FileReader 객체를 생성하여 사용한다.
			const fileReader = new FileReader();   //얘는 자바스크립트
			
			fileReader.readAsDataURL(input_file.files[0]); // FileReader.readAsDataURL() --> 파일을 읽고, result속성에 파일을 나타내는 URL을 저장 시켜준다.
			
			 fileReader.onload = function() { // FileReader.onload --> 파일 읽기 완료 성공시에만 작동하도록 하는 것임. 
			    console.log(fileReader.result);
			 /*
			     data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAeAB4AAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAg 
			     이러한 형태로 출력되며, img.src 의 값으로 넣어서 사용한다.
			 */
			    document.getElementById("previewImg").src = fileReader.result;
			};
	        
		});
		// === 제품이미지 또는 추가이미지 파일을 선택하면 화면에 이미지를 미리 보여주기 끝 === //	
			
		
		
		//제품등록하기
		$("input#btnRegister").click(functon(){
		
			let flag = false;
			
			//반복하자!
			$(".infoData").each(function(index, elmt){
				const val = $(elmt).val().trim();
				if(val == "") {
					$(elmt).next().show();
					flag = true;
					return false;   //each() 반복문을 멈추기 위함
				}
			});  
			
			if(!flag) {
				const frm = document.prodInputFrm;
				frm.submit();
			}
			
		});
		
		
		
		//취소하기
		$("input[type:reset]").click(function(){
			
			$("span.error").hide();
			$("div.divfileattach").empty();
			$("img#previewImg").hide();
			
		});
		
		
		
	});//end of $(document).ready(function(){})-----------------------------------------
	
	
</script>

	
 <div class="col-md-9">   
    
    <!-- 오른쪽에 들어갈 내용 -->
      		<h2 class="float-left"> 새로운 제품 등록하기 </h2>
      		<hr style="border: 1px solid; clear:both;"/>
      		
 <div style="border: solid 1px black;">
 			<form name="prodInputFrm"
			      action="<%= request.getContextPath()%>/shop/admin/productRegister.up"
			      method="POST"                         
			      enctype="multipart/form-data">
            <table class="table">
               <tbody>
                  <tr>
                     <th class="MemberShowDetailth">제품이름</th>
                     <td><input name="prodName" type="text" placeholder="제품 이름을 입력하세요!" />
                     	 <span class="error" style="font-size:10pt; margin-left:10px; color:blue;">＊필수입력</span>
                     </td>
                     <th class="MemberShowDetailth">카테고리</th>
                     <td>
                  		<select id="orderStatus">
                  			<option value="">:::선택하세요:::</option>
                  			<%-- 
                  			<option value="1">결제완료</option>
                  			<option value="2">출고완료</option>
                  			<option value="7">미배송중</option>
                  			<option value="3">배송중</option>
                  			<option value="4">배송완료</option>
                  			<option value="6">결제취소</option>
                  			--%>
                  			<c:forEach var="map" items="${requestScope.categoryList}">
				            	<option value="${map.cnum}">${map.cname})</option> 
				            </c:forEach>
                  		</select>
                  	 <button type="button" class="btn" style="background-color: #FFA751;" onclick="goEdit()">수정</button>
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
                  </tr>
                  
                  <tr>
                  	<th>배송지 주소</th>
                  	<td>${requestScope.odto.combineAddress }</td>
					 <td><input type="text" align="left" style="width: 100px;" name="pname" class="box infoData" /></td>	
                  </tr>
                
								<tr>
							       <th class="prodInputName">주문 상품 이름</th>
							       <td align="left" style="border-top: hidden; border-bottom: hidden;" >
							          <input type="text" style="width: 300px;" name="pname" class="box infoData" />
							          <span class="error" style="font-size:10pt; margin-left:10px; color:blue;">필수입력</span>
							       </td>
							    </tr>
								
								<tr>
								<th class="prodInputName">브랜드 명</th>
							        <td align="left" style="border-top: hidden; border-bottom: hidden;">
							           <input type="text" align="left" style="width: 300px;" name="pcompany" class="box infoData" />
							           <span class="error" style="font-size:10pt; margin-left:10px; color:blue;">필수입력</span>
							        </td>
								</tr>
							
							<tr>
								<th class="prodInputName">주문 제품수 </th>
								<td align="left" style="border-top: hidden; border-bottom: hidden;">
					              <input id="spinnerPqty" name="pqty" value="1" style="width: 30px; height: 20px;">
					              <span class="error" style="font-size:10pt; margin-left:10px; color:blue;"> 개 필수입력</span>
					        	</td>	
							</tr>
               		</tbody>
           	 	</table>
            </form>
         </div>
         
         <div style = "text-align: center; margin-top: 50px;">
            <button type="button" class="btn" style="background-color: #FFA751; color:white;"  onclick="javascript:history.back();">뒤로가기</button>
            <button type="button" class="btn" style="background-color: #FFA751; color:white;">제품등록</button>
         </div>    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
      <!-- 오른쪽에 들어갈 내용 -->
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"/>    