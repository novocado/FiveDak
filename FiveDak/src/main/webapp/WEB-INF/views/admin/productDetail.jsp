<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/header-final.jsp"/>

<jsp:include page="/WEB-INF/views/member/mypageSidebar_admin.jsp"/>

<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<style type="text/css">

</style>

<script type="text/javascript">

$(document).ready(function(){

	$("span.error").hide();
	

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




	//#### 스피너의 이벤트는 click 도 아니고 change 도 아니고 "spinstop" 이다. #### //
	$("input#spinnerImgQty").bind("spinstop", function(){
		
		let html = ``;
		let cnt = $(this).val();   //$(this) 는 $("input#spinnerImgQty") 얘를 가리킴
	/*	
		console.log("~~~ 확인용 cnt : " + cnt);
		console.log("~~~ 확인용 typeof cnt : " + typeof cnt);
		//~~~ 확인용 typeof cnt : string
	*/
	
		for(let i=0; i<Number(cnt); i++) {
			html += `<br><input type="file" name="attach\${i}" class="btn btn-default img_file" accept='image/*' />`;  /* 백틱에서 $가 안 먹으니 역슬래시(\) 를 사용해줘야 한다. */
		}//end of for--------------------------------
	
		$("div#divfileattach").html(html);
		$("input#attachCount").val(cnt);
	
	});//end of $("input#spinnerImgQty").bind("spinstop", function(){})--------------------------




	/* //제품등록하기
	$("input#btnUpdater").click(function(){
	
		let flag = false;
		
		//반복하자!
		$(".MemberShowDetailth").each(function(index, elmt){
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
		
	}); */


	
	//제품정보 삭제하기
	$("button#prodDelete").click(function(e){
        
        const prodNum = '${requestScope.pdto.prodNum}';
        const prodName = '${requestScope.pdto.prodName}';
        
        if ( confirm("해당 제품 '"+prodName+"' 을 삭제하시겠습니까?")){
           $.ajax({
              url:"<%=ctxPath %>/admin/prodDelete.dak" ,
              type:"POST",
              data:{"prodNum":prodNum},
              dataType:"JSON",
              success:function(json){
                 if(json.n == 1) { 
                    alert("해당 제품 '"+prodName+"' 을 제품 삭제가 되었습니다.");
                    location.href = `adminProductSearch.dak?searchType=${requestScope.searchType}&searchWord=${requestScope.searchWord}&currentShowPageNo=${requestScope.currentShowPageNo}`;
                 }
              },
               error: function(request, status, error){
                       alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                 }
           
           });
           
           
        }
        
        else{
           alert("해당 제품 '"+prodName+"' 을 제품 삭제를 취소하셨습니다.");
           
        }
     }); // END OF $("tr.prodInfo").click(function(e){ 


	
		
		
}); // end of document		



//제품정보 수정하기
////////////////////////////////////////////////////////////////////////////////////////////////

	function updateProduct (){
	
		const prodNum = ($(event.target).parent().parent().find('.prodNum').text() );
		const prodName = '${requestScope.pdto.prodName}';
	
		let flag = false;
		
		//반복하자!
		$(".MemberShowDetailth").each(function(index, elmt){
			const val = $(elmt).val().trim();

			if(val == "") {
				$(elmt).next().show();
				flag = true;
				return false;   //each() 반복문을 멈추기 위함
			}
		});  
		
		if(!flag) {
			
			$.ajax({
				url:"<%=request.getContextPath()%>/admin/adminProductEdit.dak",
				type:"POST",
				data:{"prodNum":prodNum},
				dataType:"JSON",
				success:function(json){
					if(json.n == 1) { 
						alert("해당 제품 '"+prodName+"' 정보가 수정되었습니다.");
						location.href = `adminProductSearch.dak?searchType=${requestScope.searchType}&searchWord=${requestScope.searchWord}&currentShowPageNo=${requestScope.currentShowPageNo}`;
					}
				},
				 error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		         }
			
			});
		
		}
	
	
	
	}




	/* 수정완료 버튼 누를 때 실행 */
	function update() {
		alert("제품 정보를 수정하시겠습니까?");
		const productName = $('input#prodName').val();  //text란에 있는 값을 변수로 저장
		const productCateNum = $('input#fk_prodCateNum').val();
		const productBrandNum = $('input#fk_prodBrandNum').val();
		const productBrandId = $('input#brandId').val();
		const productBrandName = $('input#brandName').val();
		const productPrice = $('input#prodPrice').val();
		const productDiscount = $('input#prodDiscount').val();
		const productStock = $('input#prodStock').val();
	
		let flag = false;
		const prodNum = '${requestScope.pdto.prodNum}';
		const prodName = '${requestScope.pdto.prodName}';
		
		//반복하자!
		$(".MemberShowDetailth").each(function(index, elmt){
			const val = $(elmt).val().trim();

			if(val == "") {
				$(elmt).next().show();
				flag = true;
				return false;   //each() 반복문을 멈추기 위함
			}
		});  
		
	
		if(prodNum != null && prodNum == ${pdto.prodNum}) {  //제품번호가 일치하다면
			$.ajax({
				type:"post",
				url:"<%=request.getContextPath()%>/admin/adminProductEdit.dak",
				data: { //컬럼네임에 입력한 값 담기
					"prodNum":"${pdto.prodNum}",
					"prodName":productName,
					"fk_prodCateNum":productCateNum,
					"fk_prodBrandNum":productBrandNum,
					"prodPrice":productPrice,
					"prodDiscount":productDiscount,
					"prodStock":productStock
				},
				dataType:"JSON",
				success:function(data) { //data라는 변수에 값을 받아옴
					console.log(data);
					alert("제품 정보가 수정되었습니다.");
					location.href = "prodOneDetail.dak?prodNum=${pdto.prodNum}";
				},
				error:function(request,status,error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
		else {
			alert("제품번호를 다시 확인해주세요.");
		}
		
	}



</script>	


<div class="col-md-9">
      <!-- 오른쪽에 들어갈 내용 -->
         <h2 class="h2 mb-3" style="text-align: center;"> 제품 정보 상세 페이지</h2>
         <hr style="border: 1px solid; clear:both;"/>
         <div style="border: solid 1px black;">
            <table class="table">
               <tbody>
                  <tr>
                     <th class="MemberShowDetailth">제품번호</th> 
                     <td>${requestScope.pdto.prodNum}</td>
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">제품이름</th>
                     <td><input type="text" id="prodName" value="${requestScope.pdto.prodName}" style="width:250px;" /><span class="error">필수입력</span></td>
                  </tr>
                  <tr>
				  	 <th class="MemberShowDetailth">제품 이미지</th> 
                     <td><img style="width:250px;height:250px;" src="<%=ctxPath %>/images/${requestScope.pdto.prodImage1}" alt="${requestScope.pdto.prodImage1}" /></td>
				     <th class="ProductImage_add">제품 추가이미지파일<br>(선택)</th>
				     	<td>
				          <label for="spinnerImgQty">파일갯수 : </label>
				          <input id="spinnerImgQty" value="0" style="width:50px; height: 20px;">
				             <div id="divfileattach" style="border:solid 1px #fff; width:100px;"></div>
				          <input type="hidden" name="attachCount" id="attachCount" />
				     	</td>
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">카테고리 번호</th>
                     <td><input type="text" name="fk_prodCateNum" id="fk_prodCateNum" value="${requestScope.pdto.cateDTO.cateId}" style="width:180px;"  /><span class="error">필수입력</span></td>
                     <th class="MemberShowDetailth">카테고리명</th>
                     <td><input type="text" name="fk_prodBrandNum" id="categoryName" value="${requestScope.pdto.cateDTO.cateName}" style="width:180px;" /><span class="error">필수입력</span></td>
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">브랜드 번호</th>
                     <td><input type="text" id="fk_prodBrandNum" value="${requestScope.pdto.brandDTO.brandId}" style="width:180px;" /><span class="error">필수입력</span></td>
                     <th class="MemberShowDetailth">브랜드명</th>
                     <td><input type="text" id="brandName" value="${requestScope.pdto.brandDTO.brandName}" style="width:180px;" /><span class="error">필수입력</span></td>
                  </tr>
                  
                  <tr>
                     <th class="MemberShowDetailth">제품정가</th>
                     <td><input type="text" id="prodPrice" value="${requestScope.pdto.prodPrice}" style="width:180px;" /><span class="error">필수입력</span></td>
                     <th class="MemberShowDetailth">제품할인가</th>
                     <td><input type="text" id="prodDiscount" value="${requestScope.pdto.prodDiscount}" style="width:180px;"/><span class="error">필수입력</span></td>
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">제품수량</th>
                     <td><input type="text" id="prodStock" value="${requestScope.pdto.prodStock}" style="width:180px;" /><span class="error">필수입력</span></td>
                     <th class="MemberShowDetailth">판매량</th>
                     <td><fmt:formatNumber value="${requestScope.pdto.prodSales}" pattern="###,###" /><span class="error">필수입력</span></td>
                  </tr>
                  <tr>
                     <th class="MemberShowDetailth">제품평점</th>
                     <td>${requestScope.pdto.prodAvgRating}</td>
                  </tr>
                  
                  
               </tbody>
            </table>
         </div>
         
         <div style = "text-align: center; margin-top: 50px;">
            <button type="button" class="btn" style="background-color: #FF7E32; color:#fff;" onclick="javascript:history.back();">뒤로가기</button>
            <!-- <button type="button" class="btn" style="background-color: #FF7E32;">수정하기</button> -->
            <button type="button" class="btn" id="btnUpdate" style="background-color: #FF7E32; color:#fff;" onClick="update()" >수정하기</button>
            <button type="button" class="btn" id="prodDelete" style="background-color: #FF7E32; color:#fff;">삭제하기</button> 
         </div> 
      <!-- 오른쪽에 들어갈 내용 -->
    </div>
  </div>
</div>












<jsp:include page="/WEB-INF/views/footer.jsp"/>
