<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
 
<%
	String ctxPath = request.getContextPath();
%> 
    
<jsp:include page="/WEB-INF/views/member/mypageSidebar.jsp"/>


<style type="text/css">

	.1to1borderccc {
		border: solid 1px #ccc;
	}	
	
	textarea#textarea1to1:focus {
		outline: none;
	}

	


</style>


<script type="text/javascript">
	$(document).ready(function(){
		
		$("button#fileadd1to1").click(goaddfile1to11);
		$("button#fileadd1to2").click(goaddfile1to12);
		$("button#fileadd1to3").click(goaddfile1to13);
		
		/* 
		// 이미지 를 보여주는 곳이다. 
		$("input[type='file']").change(function(e) {
			  const MAX_FILE_SIZE = 15 * 1024 * 1024; // 15MB
			  const fileInput = e.target;
			  const file = fileInput.files[0];

			  if (file && file.size > MAX_FILE_SIZE) {
			    alert('파일 크기는 15MB 이하로 선택해주세요.');
			    fileInput.value = null;
			  }
			  
			  let input1to1 = $(this);
			  let button1to1 = input1to1.prev();
			  let files = input1to1[0].files;

			  for (let i = 0; i < files.length; i++) {
			    let loopFile = files[i]; // 변수 이름 변경
			    let reader = new FileReader();
			    const input_file = $(this).get(i);
			    console.log(input_file.files[i].name);
			    
			    
			    
			    reader.onload = function(e) {
			      let img = $('<img />', {
			        src: e.target.result,
			        width: '100',
			        height: '100',			    
			      }).css({
			    	  position: 'relative',
			    	  bottom: '4px',
			    	  right: '7px',
			      });
			      button1to1.html(img);
			    }
			    reader.readAsDataURL(loopFile); // 변수 이름 변경
			  }
			});
		
				
		 */
			// textarea에 글자수를 제한과 글자수 실시간 표시하기 
			$('#textarea1to1').on('input', function() {
			  let inputText = $(this).val();
			  let characterCount = inputText.length;
			  let maxCharacterCount = 1000;
			  
			  $('#counter1to1').text(characterCount);
			  
			  if (characterCount > maxCharacterCount) {
			    $(this).val(inputText.substring(0, maxCharacterCount));
			    $('#counter1to1').text(maxCharacterCount);
			  }
			});

	});
	
	
	function goaddfile1to11() {
		
		 $("#fileInput1").click();
		
	}
	function goaddfile1to12() {
		
		 $("#fileInput2").click();
		
	}
	function goaddfile1to13() {
		
		 $("#fileInput3").click();
		
	}
	
	
	
	
	
	
	
	function goback() {
		location.href ="<%= ctxPath%>/index.dak"; 
	}
	
	function goQNA() {
				
		const O1to1Frm = document.O1to1Frm;
		O1to1Frm.method = "post";
		O1to1Frm.action="1to1QNA.dak";
		O1to1Frm.submit();	
	}
	
	
	
	
</script>



	     <!-- 오른쪽에 들어갈 내용 -->
	     	<div>    <%-- style="text-align: center; --%>
	     		<h2 class="h2">1대1 문의하기</h2>
	     	</div>
	     	
	     	<div style="border: solid 1px black; width:100%; margin-bottom: 20px;"></div>
	     	
	     	<form name="O1to1Frm">
	     	
	     		<table class="table">
	     			<tbody>
	     				<tr>
	     					<th>
	     						<span>문의 유형</span>
	     					</th>
	     					
	     					<td style="display: flex;">
	     					
	     						<select style="padding-right: 20px; margin-right: 20px;" class="1to1borderccc" name="select1to1">
					      			<option value="1">주문/결제</option>
					      			<option value="2">취소/반품</option>
					      			<option value="3">상품관련</option>
					      			<option value="4">배송관련</option>
					      			<option value="5">포인트</option>
					      			<option value="6">기타</option>
				      			</select>
				      		
				      			<input type="text" placeholder="   제목을 입력해주세요" style="width:100%;" class="1to1borderccc" name="title1to1"/>
				      		</td>
	     			
	     				</tr>
	     				<%-- 나중에 추가 할 수도 있음  --%>
	     				<!-- <tr>
	     					<th>
	     						<span>주문 상품</span>
	     					</th>
	     				
	     					<td style="display: flex;">	     						      		
					      		<input type="text" disabled="disabled" placeholder="   문의상품을 선택해주세요." style="padding-right: 20px; margin-right: 20px; width: 270%; background-color: #e6e6e6; " class="1to1borderccc"/>
					
					      		<button type="button" style="width:100%;">주문상품검색</button>
	     					
	     					</td>
	     				</tr> -->
	     				
	     				<tr>
	     					<th style="position: relative; top: 10px;">
	     						<span>문의 내용</span>
	     					</th>
	     					<td>
	     						<div style="padding: 10px; border: solid 1px red;">
	      							<textarea name="contents" placeholder="문의내용을 입력하세요." style="font-size: 12pt; border: none; width: 100%; height: 300px;" class="1to1borderccc" id="textarea1to1"></textarea>
									<div class="txt-count" style="text-align: right;"><span id="counter1to1">0</span> / <span class="total1to1">1,000</span></div>
								</div>
								<!-- <div style="margin-top: 20px;">
								
									<div style="background-color: #f2f2f2; font-weight: 700; margin-bottom: 10px; font-weight:500; padding: 20px;">
							           <i class="fa-solid fa-camera"></i>&nbsp;사진 첨부<span style="color: #666; font-size:13px;"></span>
							           <div style="margin-top:20px;">
							             <button type="button" id="fileadd1to1" class="image_button" style="width: 100px; height: 100px;"><i class="fa-solid fa-plus" style="color:#ccc"></i></button> 
										 <input type="file" accept="image/*" id="fileInput1" style="display:none" name="image1to11">
										 <button type="button" id="fileadd1to2" class="image_button" style="width: 100px; height: 100px;"><i class="fa-solid fa-plus" style="color:#ccc"></i></button> 
										 <input type="file" accept="image/*" id="fileInput2" style="display:none" name="image1to12">
										 <button type="button" id="fileadd1to3" class="image_button" style="width: 100px; height: 100px;"><i class="fa-solid fa-plus" style="color:#ccc"></i></button> 
										 <input type="file" accept="image/*" id="fileInput3" style="display:none" name="image1to13">
							           	  <span style="margin-top: 10px;">- 최대 15MB 이하의 이미지 파일만 첨부 가능합니다.</span>
							           </div>
							        </div>
					
								</div> -->
							</td>
	     				</tr>
	     				
	     				
	     				
	     			</tbody>
	     		</table>		
	     		
	     		<div style="display: flex;">
	     			<button type="button" class="col-md-3 offset-md-3" style="background-color: #e6e6e6; height:50px; border: none; border-radius: 5px;" onclick="goback();">취소하기</button>

	     			<button type="button" class="col-md-3 offset-md-1" style="background-color: #FF7E32; height:50px; border: none; border-radius: 5px;" onclick="goQNA()">문의하기</button>
			</div>
	     			
		</form>
	     <!-- 오른쪽에 들어갈 내용 -->
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"/>
