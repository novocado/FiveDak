<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>    
    
<!DOCTYPE html>
<jsp:include page="../header-final.jsp"/>

<style type="text/css">

	.ranking {
		color:#ff6001 !important;
	}
	
	.orderby {
		 display: inline-block;
		 text-decoration: none;
	}
	
	.my_ranking {
		width: 75%;
		margin: 50px auto;
	}
	
	div.row.my_ranking > div.row-12 > ul > li > a {
		text-decoration: none;
		display: block;
		text-align: center;
		font-size: 15px;
		border-radius: 100px;
		padding: 11px 18px;
	}
	
	div.rank_list_top {
		margin-top :
	}
	
	span.prod_number {
		border-bottom: 2px solid #333;
		font-size: 22px;
		min-width: 20px;
		text-align: center;
		padding-bottom: 9px;
		transform: translateY(-50%);
		color: #333;
	}
	body > div.row.my_ranking > div.rank_list_top >
	ol > li > div.col-md-2.text-right > ul > li > a
	{
	color: #ccc;
	font-size: 15pt;
	}
	
	.activeList {
		color: #ff8237 !important; border: solid 1px #ff8237; font-weight: bold; background-color: #ffffff; 
	}
	
	.cart_icon:hover {
		color: #FF7E32;
	}
	
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$('input#save').val("${requestScope.listType}");
		
		if ( $('input#save').val() == ""){
			$('a#sales').addClass("activeList");
			$('a#live').removeClass("activeList");
		}
		else if (  $('input#save').val() == "average_rating"  ){
			$('a#live').addClass("activeList");
			$('a#sales').removeClass("activeList");
		}
		else if (  $('input#save').val() == "product_sales" ) {
			$('a#sales').addClass("activeList");
			$('a#live').removeClass("activeList");
		}
		
		setEventHandling();	
		$('a#live').on('click',function(){
			$('input#save').val('average_rating');	
			goRedirect();
		});
		$('a#sales').on('click',function(){
			$('input#save').val('product_sales');
			goRedirect();
		});
		
		
	});
	function goRedirect(){
		const frm = document.listfrm;
		listfrm.action = "rankingList.dak";
		listfrm.method = "get";
		listfrm.submit();
		
		
	}
	// Function Declaration
	function setEventHandling() {
	
		$("a.ranking").addClass("ranking");
		
		$("span#totalHITCount").hide();
		$("span#countHIT").hide();
		displayHIT("1");
		
		$("button#btnMoreHIT").click(function(){
			
			if($(this).text() == "처음으로") {
				$("div#displayHIT").empty();
				$("span#end").empty();
				displayHIT("1");
				$(this).text("더보기");
			}
			else {
				displayHIT($(this).val());
			}
		});// end of $("button#btnMoreHIT").click()--------------------------------------
	}
	
	let lenHIT = 10;
	function displayHIT(start) {	
		$.ajax({
			url:"<%= request.getContextPath()%>/product/rankDisplayJSON.dak",
  			type:"get",
			data:{"listType":"${requestScope.listType}",
				  "start":start,		
				  "len":lenHIT},	
			dataType:"json",
			success:function(json){
				
				let html ="";
			    
			    if(start == "1" && json.length == 0 ) {
			    	
			    	html += "현재 상품 준비중....";
			    	
			    	$("div#displayHIT").html(html);
			    }
			    
			    else if (json.length > 0) {
			    	console.log()
			    	$.each(json, function(index, item) {
			    		html +=  "<ol>" +
									"<li class='row'style='list-style: none; margin-top: 30px; display:flex; border-bottom: solid 1px #ccc; padding-bottom:20px'>"+
										"<div style='display:inline; padding-top:20px;'>"+
											"<span class='prod_number'style='margin-top:20px;'>"+item.rno+"</span>"+
										"</div>"+
										"<div id='div_img' class='col-md-1'style='margin-left:10px;display:inline;'>"+
											"<a href='<%= ctxPath%>/product/productDetail.dak?prodNum="+item.product_id+"'><img src='/FiveDak/images/"+item.product_image_url+"' style='height:90px'/></a>"+
										"</div>"+
										"<div class='col-md-5' style='display:inline;  padding-left:50px;'>"+
											"<a href='<%= ctxPath%>/product/productDetail.dak?prodNum="+item.product_id+"' style='vertical-align: top; text-decoration: none; color:#333333;' >["+item.brand_name+"]"+item.product_name+" </a>"+
											"<div style='margin-top:30px;'>"+
												"<span><i class='fa-solid fa-star' style='color:#FF7E32;'></i>"+item.average_rating+"</span>"+
											"</div>"+
										"</div>"+
										"<div class='col-md-2 text-center' style='margin-top:30px;'>"+
											"<span class='price'style='font-size: 18px;color: #333;font-weight: 700;'>"+(item.product_discount).toLocaleString('en')+" 원</span>"+
										"</div>"+
										"<div class='col-md-1' style='margin-top:30px;'>"+
											"<img src='/FiveDak/images/특급배송.png' />"+
										"</div>"+
										"<div class='col-md-2 text-right' style='margin-top:30px;'>"+
											"<ul style='list-style-type: none; margin-right: 30px;'>"+
												"<li><a href='#'><i class='fa-solid fa-cart-shopping cart_icon'></i></a> &nbsp;|&nbsp; <a href='#'><i class='fa-regular fa-heart'></i></a></li>"+
											"</ul>"+
										"</div>"+
									"</li>"+				
								"</ol>";
						    	});//end of $.each(json, function(index, item)-------------------------------------
						    			
			    	$("div#displayHIT").append(html);			
						    			
					$("button#btnMoreHIT").val( Number(start)+lenHIT );
					
					
					$("span#countHIT").text( Number( $("span#countHIT").text() ) + json.length);
					
					
					if($(""))
					if( $("span#countHIT").text() == $("span#totalHITCount").text()) {
						$("span#end").html("더이상 조회할 제품이 없습니다.");
						$("button#btnMoreHIT").text("처음으로");
						$("span#countHIT").text("0");
					}	    	
						    	
			    }// end of else if ()------------------------------------------
			
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		});					        
	}// end of function displayHIT() -----------------------------------------------------------
	

</script>

		<div class="row my_ranking" >
			<div style="width: 100%;">
				<h2>랭킹</h2>
			</div>
			<div class="row-12" style="margin-top: 50px; width:100%; height: 70px;">
				<h4 style="display:inline;">오늘의 전체 랭킹 순위!</h4>
				<ul style="float:right;">
					<li class="orderby"><a id="live" href="#" style="color: #666666;background-color: #F8F8F8;">별점순</a></li>
					<li class="orderby"><a id="sales" href="#" style= "color: #666666;background-color: #F8F8F8;">판매순</a></li>
					<form name="listfrm">
						<input type="hidden" name="listType" id="save"   value="" />
					</form>
				</ul>
			</div>
			<div id= "displayHIT" class="rank_list_top " style="width:100%;"></div>
				
			<div style="width:100%">
		         <p class="text-center">
		            <span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span> 
		            <button type="button" class="btn  btn-lg text-center" id="btnMoreHIT" value="" style="color: #ff8237; border: solid 1px #ff8237; font-weight: bold; background-color: #ffffff; ">더보기</button>
		            <span id="totalHITCount">${requestScope.totalHITCount}</span>
	            	<span id="countHIT">0</span>
		         </p>
	        </div>
		
		</div>































<jsp:include page="../footer.jsp"/>