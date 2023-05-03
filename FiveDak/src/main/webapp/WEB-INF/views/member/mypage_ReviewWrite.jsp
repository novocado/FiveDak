<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
  
%>       
<!DOCTYPE html>
<jsp:include page="/WEB-INF/views/member/mypageSidebar.jsp"/>

<style type="text/css">

	* { font-family: "Pretendard Variable", Pretendard, -apple-system, BlinkMacSystemFont, system-ui, Roboto, "Helvetica Neue", "Segoe UI", "Apple SD Gothic Neo", "Noto Sans KR", "Malgun Gothic", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", sans-serif; }


.rate { display: inline-block;border: 0;margin-right: 15px;}

.rate > input {display: none;}
.rate > label {float: right;color: #ddd}
.rate > label:before {display: inline-block;font-size: 3rem;padding: .3rem .2rem;margin: 0;cursor: pointer;font-family: FontAwesome;content: "\f005 ";}
.rate .half:before {content: "\f089 "; position: absolute;padding-right: 0;}
.rate input:checked ~ label, 
.rate label:hover,.rate label:hover ~ label { color: #FDD346} 
.rate input:checked + .rate label:hover,
.rate input input:checked ~ label:hover,
.rate input:checked ~ .rate label:hover ~ label,  
.rate label:hover ~ input:checked ~ label { color: #FDD346} 

	#textAreaBox {
  position: relative;
  margin-bottom: 10px;
  border: 1px solid #333;
  padding: 10px;
}

#reviewText {
  resize: none;
  width: 100%;
  border: none;
  outline: none;
}

#txtCount {
  position: absolute;
  bottom: 10px;
  right: 10px;
  font-size: 12px;
}


button.submit-review {
  background-color: gray;
  color: #fff;
  border: none;
  padding: 10px 15px;
  border-radius: 5px;
  width: 150px;
}

button.submit-review:disabled {
  background-color: gray;
  opacity: 0.5;
}

button.submit-review:enabled {
  background-color: #111;
  cursor: pointer;
}

button.reset-review {
	width: 150px;
	border-radius: 5px;
	padding: 10px 15px;
	background-color: white;
	border: solid 1px #ccc;
}

button.image_button {
	position: relative;
    display: inline-block;
    vertical-align: top;
    width: 68px;
    height: 68px;
    padding: 22px;
    border: solid 1px #ccc;
}	

div > ul > li {
	position:relative;
	left: -25px;
	color: #666;
}

</style>	

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.6/dist/web/static/pretendard.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>


<script type="text/javascript">

	$(document).ready(function() {
		   
		setEventHandling();
		
		
		  $("button#fileadd1to1").click(goaddfile1to11);
	      $("button#fileadd1to2").click(goaddfile1to12);
	      $("button#fileadd1to3").click(goaddfile1to13);
	      
	      $("input[type='file']").change(function(e) {
	         const MAX_FILE_SIZE = 15 * 1024 * 1024; // 15MB
	           const fileInput = e.target;
	           const file = fileInput.files[0];

	           if (file && file.size > MAX_FILE_SIZE) {
	             alert('파일 크기는 15MB 이하로 선택해주세요.');
	             fileInput.value = null;
	           }
	           
	           let $input = $(this);
	           let $button = $input.prev();
	           let files = $input[0].files;

	           for (let i = 0; i < files.length; i++) {
	             let loopFile = files[i]; // 변수 이름 변경
	             let reader = new FileReader();
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
	               $button.html(img);
	             }
	             reader.readAsDataURL(loopFile); // 변수 이름 변경
	           }
	         });

	   
	});// end of $(document).ready(function() {})-------------------------------------------
	
	
	
	function setEventHandling() {
		 $('#reviewText').on('input', inputReviewText);
		 starScore();
	}
	
	
	function inputReviewText() {
	   const reviewLength = $(this).val().length;
	   $('#counter').text(reviewLength);
	   if (reviewLength >= 10) {
	      	$('.submit-review').prop('disabled', false);
	    } 
	   else {
	      	$('.submit-review').prop('disabled', true);
	      	
	    }
	}
	
	function starScore() {
		$("input:radio[name='rating']").on('click', function(){
			if ($(this).val() == "1") {
				$("span#star_content").html("0.5점 별로에요");
			}
			if ($(this).val() == "2") {
				$("span#star_content").html("1점 별로에요");
			}
			if ($(this).val() == "3") {
				$("span#star_content").html("1.5점 그저그래요");
			}
			if ($(this).val() == "4") {
				$("span#star_content").html("2점 그저그래요");
			}
			if ($(this).val() == "5") {
				$("span#star_content").html("2.5점 보통이에요");
			}
			if ($(this).val() == "6") {
				$("span#star_content").html("3점 보통이에요");
			}
			if ($(this).val() == "7") {
				$("span#star_content").html("3.5점 좋아요");
			}
			if ($(this).val() == "8") {
				$("span#star_content").html("4점 좋아요");
			}
			if ($(this).val() == "9") {
				$("span#star_content").html("4.5점 최고에요");
			}
			if ($(this).val() == "10") {
				$("span#star_content").html("5점 최고에요");
			}
			$("input#insertvalue").val($(this).val());
		});
	}	
	
	 function goaddfile1to11() {
	      
	       $("#fileInput1").click();
	      
	   }
	   function goaddfile1to12() {
	      
	       $("#fileInput2").click();
	      
	   }
	   function goaddfile1to13() {
	      
	       $("#fileInput3").click();
	      
	   }

	
	
	
	
	 function goRegister(){
	 
     if ( $("input[name='insertvalue']").val() == "") {
    	 alert("제품 평균별점을 선택해주세요");
     }		 
     else{
		 
	 const frm = document.reviewRegister
	 frm.action = "<%= ctxPath%>/mypage/reviewWrite.dak";
	 frm.method = "post";
	 frm.submit();
	 }
 }	


</script>
	<form name="reviewRegister">
		<div class="" style="margin-left:40px; border-bottom: solid 1px #ccc;">
			<h2 style="padding-bottom: 10px; margin: 20px 0px 20px 0px; color:#333; border-bottom : solid 1px #333;">후기작성</h2>
			<div class="row">
				<div class="col-1" style="margin: 8px 0 25px 0; ">
					<img src="/FiveDak/images/${odto.prod.prodImage1}" style="width:80px; height:80px;"/>
				</div>
				<div class="contents col-auto" style="padding: 5px 0 10px 60px;">
			  	    <div style="margin-bottom: 15px;">
			  	  		<span style="color:#666666;">${odto.orderSerial}</span>
			  	    </div>
				  	    <a href="#" style="color:#333; ">[${odto.prod.brandDTO.brandName}]${odto.prod.prodName}</a>
				  	    <input type="hidden" name="product_id" value="${odto.prod.prodNum}"/>
				  	    <input type="hidden" name="orderSerial" value="${odto.orderSerial}"/>
			    </div>
			</div>
			<div class="rating_bar" style="border-top:solid 1px #ccc; text-align:center; color:#222222; padding-top:30px; position:relative; top:20px;">
				<h5 style="font-weight: 700;">상품이 고객님 마음에 쏙- 들었나요?</h5>
				<fieldset class="rate">
                    <input type="radio" id="rating10" name="rating" value="10"><label for="rating10" title="5점"></label>
                    <input type="radio" id="rating9" name="rating" value="9"><label class="half" for="rating9" title="4.5점"></label>
                    <input type="radio" id="rating8" name="rating" value="8"><label for="rating8" title="4점"></label>
                    <input type="radio" id="rating7" name="rating" value="7"><label class="half" for="rating7" title="3.5점"></label>
                    <input type="radio" id="rating6" name="rating" value="6"><label for="rating6" title="3점"></label>
                    <input type="radio" id="rating5" name="rating" value="5"><label class="half" for="rating5" title="2.5점"></label>
                    <input type="radio" id="rating4" name="rating" value="4"><label for="rating4" title="2점"></label>
                    <input type="radio" id="rating3" name="rating" value="3"><label class="half" for="rating3" title="1.5점"></label>
                    <input type="radio" id="rating2" name="rating" value="2"><label for="rating2" title="1점"></label>
                    <input type="radio" id="rating1" name="rating" value="1"><label class="half" for="rating1" title="0.5점"></label>
                </fieldset>
                <input type="hidden" name="insertvalue" id="insertvalue" value="" />
			</div>
				<div style="text-align: center; margin-bottom: 30px;">
                	<span id=star_content></span>
                </div>
		
			<div id="textAreaBox" style="border: 1px solid #ccc;">
				  <textarea name="contents" id="reviewText" rows="8" maxlength="1000" style="color: inherit;  font-size: 13px;" placeholder="맛있는 조리사진/솔직한 후기를 10자 이상 남겨 주시면 적립금이 지급됩니다! 맛,품질,만족도,배송에 대해 알려주시면 다른 분들에게 큰 도움이 돼요:)"></textarea>
				  <div id="txtCount">
				    <span id="counter">0</span>/1000
				  </div>
			</div>
			<div style="background-color: #f2f2f2; font-weight: 700; margin-bottom: 10px; font-weight:500; padding: 20px;">
                                <i class="fa-solid fa-camera"></i>&nbsp;사진 첨부<span style="color: #666; font-size:13px;"></span>
                                <div style="margin-top:20px;">
                                  <button type="button" id="fileadd1to1" class="image_button" style="width: 100px; height: 100px;"><i class="fa-solid fa-plus" style="color:#ccc"></i></button> 
                               <input type="file" accept="image/*" id="fileInput1" style="display:none">
                               <button type="button" id="fileadd1to2" class="image_button" style="width: 100px; height: 100px;"><i class="fa-solid fa-plus" style="color:#ccc"></i></button> 
                               <input type="file" accept="image/*" id="fileInput2" style="display:none">
                               <button type="button" id="fileadd1to3" class="image_button" style="width: 100px; height: 100px;"><i class="fa-solid fa-plus" style="color:#ccc"></i></button> 
                               <input type="file" accept="image/*" id="fileInput3" style="display:none">
                                     <span style="margin-top: 10px;">- 최대 15MB 이하의 이미지 파일만 첨부 가능합니다.</span>
                                </div>
                             </div>

			<ul style="list-style: none;">
				<li>- 구매하신 상품관련 문의는 "1:1문의"를 이용해주세요.</li>
				<li>- 제품과 관련 없는 내용이 포함된 후기는 예고없이 블라인드 처리 될 수 있습니다.</li>
				<li>- 최대 15MB 이하의 JPG, PNG, GIF, BMP 파일 2장까지 첨부 가능합니다.</li>
			</ul>
		</div>
		
		
		</form>	
			<div style="width:100%; margin:35px 0;" class="text-center">
				<button class="reset-review">취소</button>
				<button onclick="goRegister()" class="submit-review" disabled >등록</button>
			</div>
	</div>
	
</div>
	
	
	
	
	
	
<jsp:include page="../footer.jsp"/>