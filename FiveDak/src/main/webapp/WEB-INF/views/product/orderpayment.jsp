<%@page import="semiproject.dak.member.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/header-final.jsp" />




<style type="text/css">
.title-page {
	font-size: 25px;
	font-weight: 700;
	color: #333333
}

.page-title-area {
	margin-top: 60px;
}
a{background:transparent; text-decoration:none; color:inherit;}
a:hover, a:active{text-decoration:none; outline:0;}

div, span, iframe, h1, h2, h3, h4, h5, h6, p, dl, dt, dd, ol, ul, li,
	fieldset, form, label, table, caption, tbody, tfoot, thead, tr, th, td
	{
	margin: 0;
	padding: 0;
	border: 0;
	vertical-align: baseline;
	-webkit-font-smoothing: antialiased;
	box-sizing: border-box;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
}
caption{position:absolute; left:-99999px; display:block; width:1px; height:1px; overflow:hidden; text-indent:-99999px; clip:rect(0,0,0,0); *display:none;}

table{border-collapse:collapse; border-spacing:0;}
table td,table th{word-break: keep-all; word-wrap: break-word;}
table tbody td.vt-top{vertical-align:top;}
table tbody td.vt-mid{vertical-align:middle;}

.payment-container{padding-bottom:130px;}
.order-info .list-head-sub {
	position: relative;
	padding: 30px 0 5px;
	border-top: 1px solid #ccc;
	margin: 30px 0 15px
}

.order-info .list-head {
	position: relative;
	padding: 30px 0 20px;
	border-top: 1px solid #666
}

.title-list {
	font-size: 18px;
	font-weight: 500;
	line-height: 32px;
	color: #333333
}

.order-info ul, li {
	list-style: none;
}


.order-info .info-txt {
	display: inline-block;
	overflow: hidden;
	vertical-align: top;
	margin-right: 15px;
}

.order-info .info-txt li {
	float: left;
}

.order-info .info-txt li:after {
	display: inline-block;
	content: '/';
	margin: 0 3px;
	vertical-align: top;
}

.order-info .info-txt li:last-child:after {
	content: none
}

.lineless-table table {
	width: 100%;
	table-layout: fixed;
	border-collapse: collapse;
}

.lineless-table th {
	text-align: left;
	font-weight: normal;
	padding: 10px 0;
	font-size: 13px;
	vertical-align: middle;
}

.lineless-table td {
	text-align: left;
	font-weight: normal;
	padding: 10px 0;
	font-size: 15px;
	vertical-align: middle;
}


.btn-default{background:#fff; color:#333; border:1px solid #ccc;}
.btn-basic-sm2{min-width:67px; height:32px; padding:5px 10px; position:absolute; top:22px; right:0; border:1px solid #666; border-radius:0;}
.btn-basic-sm2 > span{font-size:13px; line-height:1.6}
.btn-basic-sm2 > i + span{margin-left:5px; font-weight:400; vertical-align:top;margin-top:4px}
button{background:none;font-family:'Pretendard', sans-serif; cursor:pointer; outline:none; border:0; margin:0; padding:0;}
button:focus,
button:active{
    padding: 0;
}
button span {position:relative}
button:active span, button:focus span {position:relative;top:0;left:0}
button:active::before {
    transform: translate(0, 0);
}
button.btn-x-xs:focus,
button.btn-x-xs:active{
    padding: 11px;
}
button, input, optgroup, select, textarea{font:inherit; color:inherit; margin:0; padding:0; box-sizing:border-box; -webkit-appearance:none; appearance:none; }
button, input{overflow:visible;}
button,[type="button"],[type="reset"],[type="submit"]{-webkit-appearance:none; appearance:none; cursor:pointer;/* border:0;*/ padding:0; background-image:none;}

button, select{text-transform:none;}
.btn-x-xs{padding:11px;}
.btn-x-xs [class^="ico-x-"]{width:8px; height:8px}

.order-price{width: 100%}
.order-price .total-price{border-top:2px solid #999; padding:10px 0;}
.order-price .list-inner{overflow:hidden}
.order-price .list-inner .tit{float:left; display:block; padding:5px 0; font-size:14px;}
.order-price .list-inner .price{float:right; font-size:18px; text-align:right;}
.order-price .list-inner .price .num{font-size:26px; font-weight:700;}
.order-price .list-inner .price .text-guide-sm{display:block; margin-top:2px}
.order-price .div-price > li{padding:20px 0}
.order-price .div-price > li:last-child{padding:0 0 20px}
.order-price:not(.type2) .div-price > li + li:not(:last-child){border-top:1px solid #ccc}




.payment-info-box{width:300px; border:1px solid #ccc; padding:30px 25px; background: #FFF;}
.payment-info-box > .tit{font-size:20px; font-weight:400;}
.payment-info-box .btn-basic-xlg{width:100%}
.div-price .list-sub-inner{display:table; width:100%; table-layout:fixed; padding-left:10px;}
.div-price .list-sub-inner > li{display:table-row;}
.div-price .list-sub-inner > li > span{display:table-cell; color:#666;  padding:3px 0;}
.div-price .list-sub-inner > li > .txt{text-align:right; font-size:16px;}
.point-container-box{width:250px;padding:20px;box-sizing: border-box;background-color:#F8F8F8;border-radius:8px;margin-bottom: 30px;}
.point-container-box ul li{margin-bottom: 12px;}
.point-container-box ul li:first-child:nth-child(1){margin-top:0;margin-top:0;}
.point-container-box ul li:last-child{margin-bottom: 0;}
.point-container-box ul li span{color:#666666;font-size: 14px;}
.point-container-box ul li:last-child span{color:#333333;font-size: 14px;}
.point-container-box ul li:last-child span:last-child{font-size: 18px;font-weight: 600;}
.point-container-box ul li{display:flex;justify-content: space-between;align-items: center;}
.text-primary{color:#FF6001 !important;}

.payment-info-box .terms-view{padding:25px 0; border-top:1px solid #ccc;}
.payment-info-box .terms-view li + li{margin-top:10px;}
.payment-info-box .terms-view li > a{position:relative; display:block; width:100%;}
.payment-info-box .terms-view li .txt{color:#333; font-size:14px;}
.payment-info-box .terms-view li .view{color:#666; font-size:13px; position:absolute; top:0; right:0;}
.payment-info-box .terms-view li .view .fas{margin-left:3px;}
.payment-info-box .terms-view li .view .fas:after{border-width:5px 0 5px 6px;}
.total-area .regular-check-area{margin-top:15px;padding-top:18px;border-top:1px solid #eee;text-align:left;}
.total-area .regular-check-area .custom-checkbox input[type="checkbox"] + label{color:#333;font-size:14px;line-height:18px; font-weight: 500;}
.total-area .regular-check-area .custom-checkbox .checkbox + label:before{top:1px;}
.custom-checkbox input[type="checkbox"]:checked+.custom-control-label::before {background-color: #fd6f06; border-color: #fd6f06; }
.custom-checkbox input[type="checkbox"]:checked+.custom-control-label::after { color: white;}
.custom-control-label{font-size: 14px;}
	

.order-point .input-group-wrap{display:inline-block; width:340px; vertical-align: middle;}
.order-point .btn-ex-grey{width:100px; height:100%; border-left:1px solid #ddd;}
.order-point .point-guide{display:inline-block; margin-left:10px; color:#FF6001;}


.input-group-wrap{border:1px solid transparent;}
.input-group-wrap .input-group .input-text{border:0;}
.input-group-wrap .input-group > .input-group-btn:last-child{padding:0}
.input-group-wrap.inline-type{display:inline-block}


.input-group-wrap.box-type{border:1px solid #ccc;}
.input-text{height:40px; padding:5px 15px; background:#fff; color:#333; border:1px solid #ccc; box-sizing:border-box; font-size:13px; border-radius:0;}
.input-text::placeholder{color:#bbb; opacity: 1;}
.input-group > .input-text{position:relative; display:table-cell; float:left; width:100%;}
label, select, input, textarea {
    vertical-align: middle;
}

.input-group-wrap .input-group > .input-text + .input-group-btn:last-child{padding:0; height:100%}
.input-group > .input-group-btn{display:table-cell; position:relative; white-space:nowrap; width:1%; vertical-align:middle; border:0; padding:0 5px;}
.input-group > .input-group-btn .btn-input-del{vertical-align:middle;margin-right:7px; display:none}
.input-group > .input-group-btn .btn-input-del:focus, .input-group > .input-group-btn .btn-input-del:active {padding:0}
.btn-ex-grey{display:inline-block; background-color:#F7F7F7; font-size:13px; min-width:100px; height:40px; line-height:42px; text-align:center;}

/* ㅇㅇㅇ */


.input-group {
    position: relative;
    display: table;
    border-collapse: collapse;
    /* width: 100%; */
}
.lineless-table table {
    width: 100%;
    table-layout: fixed;
    border-collapse: collapse;
}
table {
    border-collapse: collapse;
    border-spacing: 0;
}



.order-item-box {padding-top: 11px;}
.delivery-state { position: relative; padding: 4px 30px; background: #93a0b5;}
.delivery-state .tit {color: #fff; font-size: 15px; font-weight: normal;}
h4 { display: block; margin-block-start: 1.33em; margin-block-end: 1.33em; margin-inline-start: 0px; margin-inline-end: 0px;}
.delivery-state .right-dlv-info {position: absolute; top: 22px; right: 30px;}

.delivery-state .right-dlv-info .txt { color: #fff; }
.right-dlv-info .txt {display: inline-block; vertical-align: middle; }
.right-dlv-info .txt > span { font-weight: 500;}
.delivery-guide.type02 { border-top: none; border-bottom: none; padding-bottom: 0; background: none; }
.delivery-guide { position: relative; overflow: hidden; padding: 15px 25px; background: #F7F7F7; border-bottom: 1px solid #EBEBEB; border-left: 1px solid #ccc; border-right: 1px solid #ccc;}
.delivery-guide.type02 .type02-inner { position: relative; overflow: hidden; padding: 11px 15px; border-radius: 4px; background: #f5f5f5;}
.delivery-guide .left-item {float: left; }
.delivery-guide .right-item { float: right; }
.delivery-guide .txt { font-size: 13px; }
.delivery-guide.type02 .txt { color: #666;}
.order-item-box .cart-list { padding: 0; }
.cart-list {border-left: 1px solid #ccc; border-right: 1px solid #ccc; border-bottom: 1px solid #ccc;}
.order-item-box .cart-list > li { padding: 20px 0; }
.cart-list > li { position: relative; border-top: 0; padding: 30px 0 0 0;}
.cart-list > li .prd-info-area:not(.option-line) { padding: 0 25px; }
.prd-info-area { position: relative;}
.prd-info-area .inner { display: table; table-layout: auto; width: 100%;}
.prd-info-area .column.img { width: 80px; height: 80px; overflow: hidden; position: relative;}
.prd-info-area .column.tit { padding: 0 10px 0 15px; text-align: left;}
.prd-info-area .column.tit .tit { font-size: 15px; color: #333; margin-bottom: 3px; }
.prd-info-area .column.tit .desc { font-size: 14px; color: #666; margin-bottom: 15px;}
.prd-info-area .column.tit .price-item > li { font-size: 14px; color: #333; display: inline-block; vertical-align: middle; margin-right: 4px;}
.prd-info-area .column.tit .price-item > li:first-child .num { font-size: 16px; }
.prd-info-area .column.tit .price-item > li:not(:first-child):before { display: block; content: ''; width: 2px; height: 2px; position: absolute; top: 50%; left: 0; background: #666; transform: translateY(-50%); }
.prd-info-area .column.w70 { width: 70px; vertical-align: middle; }
.prd-info-area .column.price { width: 130px; vertical-align: middle; text-align: right; word-break: keep-all;}
.prd-info-area .column { display: table-cell; vertical-align: top; text-align: center;}
.prd-info-area .column.price .num { font-size: 18px; color: #333; font-weight: 700; }



.dlv-request-box { border: 1px solid #ccc; border-top: 0; height:120px; background-color: #f7f7f7; margin-bottom: 50px;}
.dlv-request-box .inner-div { padding: 25px; height: 100%; }
.inner-div .request-tit { float: left; width: 160px;}
.inner-div .request-tit h5 { font-size: 14px; font-weight: normal;}
.inner-div .request-detail { float: right; width: 540px; height: 40px;}
.div-request-box .select-box { display: inline-block; min-width: 120px; position: relative; height: 40px; vertical-align: top; text-align: left; max-width: 100%;}
.w-full{width: 100% !important;}
.select-box{display:inline-block; min-width:120px; position:relative; height:40px; vertical-align:top; text-align:left; max-width:100%}
.select-box .select-value{display:block; position:relative; height:100%; padding:0 36px 0 15px;  border: 1px solid #ccc; font-size:14px; color:#333;  box-sizing:border-box; background:#fff;}
.select-box .select-value:after{content:''; display:block; position:absolute; right:20px; top:50%; width:7px; height:7px; border-top:1px solid #555; border-left:1px solid #555; transform:rotate(225deg) translateY(100%);-webkit-transform:rotate(225deg) translateY(100%); -ms-transform:rotate(225deg) translateY(100%)}
.select-box .select-value.placeholder{color:#999}
.select-box .select-value.disabled{background:#f4f4f4}
.select-box .select-value > span{position:relative; top:50%; left:0; transform: translateY(-50%); -webkit-transform: translateY(-50%); display:block; max-width:100%; text-overflow:ellipsis; white-space:nowrap; overflow:hidden; word-break: break-all;color:#999;}
.select-box .select-list{display:none;overflow-y:auto;position:absolute; top:calc(100% - 1px); width:100%;max-height:300px;padding:0;border:1px solid #ddd;background:#fff;z-index:1}
.select-box .select-list li + li{border-top:1px solid #ddd}
.select-box .select-list li:first-child{margin-top:0}
.select-box .select-list a{display:block;width:100%;height:100%;padding:10px 17px 10px;background:#fff;box-sizing:border-box;font-size:14px}
.select-box .select-list li.first > a,
.select-box .select-list a:hover{background: #f8f8f8;}
.select-box.on{z-index:4}
.select-box.on .select-value{border-color:#333;}
.select-box.on .select-value:after{top:23px;transform:rotate(45deg) translateY(-100%);-webkit-transform:rotate(45deg) translateY(-100%);-ms-transform:rotate(45deg) translateY(-100%);}
.select-box.on .select-list{display:block; border:1px solid #333; border-top:1px solid #ddd}

.payment-btn {margin-top: 20px; height: 50px; text-align: center;}
.payment-btn .btn{width:66%; height: 100%; background-color: #FF8533; border-color: #FF8533; color:#fff;}
.payment-btn .btn:hover {background-color: #FF6001; border-color: #FF6001;}

.hide {
    display: none !important;
}



.inner-div .request-detail .select-box ~ .ui-direct-input {
    margin-top: 5px;
}

.original-price{
	color: #666;
	text-decoration: line-through;
}

div.approval-container {
	color: #666666;
}





div.approval-sidebar {
	position: sticky;
	top: 7%;
	width: 300px;
	height: 100%;
	padding: 20px;
}





/* 모달 스타일 */
.approval-modal {
	display: none; /* 모달 창은 처음에 안 보이도록 설정 */
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.4);
}
</style>



<script type="text/javascript">

$(document).ready(function(){
    
	setEventHandling();
	//setDatepicker();
	setModal();

});
	
	function setEventHandling() {
		if ($('.ui-select').length > 0) { selectBox(); }
		$("#textUsePoint").on('keyup',allowOnlyNumbers);
		$("#textUsePoint").on('blur', inputUsePoint);
		$("#deliveryChange").on('click', function() {
			$(".delivery-modal").attr('src', 'orderdeliverypopup.dak');
		});
		$("#paymentButton").on('click',clickPayment);
		$("#paymentButton2").on('click',clickPayment2);
		
		
	 }
	
	function inputUsePoint(e) {
		var usePoint = parseInt($(this).val());
	    var currentPoint = parseInt($('#currentPoint').val());

	    if (isNaN(usePoint) || usePoint < 0) {
	      alert('0 이상의 숫자만 입력해주세요.');
	      $(this).val('0');
	    } else if (usePoint > currentPoint) {
	      alert('보유하신 포인트보다 많은 포인트를 입력할 수 없습니다.');
	      $(this).val('0');
	    } else if (usePoint < 100 && usePoint > 0) {
	      alert('100 포인트부터 사용가능합니다.');
	      $(this).val('0');
	    } else {
	      $('#usePoint').val(usePoint);
	    }
	}
	
	function UseAllPoint() {
		  var currentPoint = Number($('#currentPoint').val());
		  var totAmountPrice = Number($('#totAmountPrice').val());

		  if (currentPoint < 1000) {
		    alert('1000포인트부터 사용 가능합니다.');
		    return;
		  }

		  if (currentPoint > totAmountPrice) {
		    $('#usePoint').val(totAmountPrice);
		    $('#textUsePoint').val(totAmountPrice);
			 
		  } else {
		    $('#usePoint').val(currentPoint);
		    $('#textUsePoint').val(currentPoint);
		  }
		}
	
	function allowOnlyNumbers(event) {
		  const input = event.target;
		  input.value = input.value.replace(/[^0-9]/g, '');
	}
 
	
 
 
	// 모달을 실행하는 함수이다.
	 function setModal() {
		  // 모달 버튼 클릭 이벤트
		  const modalButtons = $("[data-modal-target]");       // 모달 버튼 누를시 (어떤 것인지 설정 )

		  modalButtons.on("click", function () {				// 버튼을 클릭시 
		    const modalTarget = $(this).attr("data-modal-target");  // modalTarger 을 이벤트가 발생한 것의 data-modal-target 속성값 반환
		    const modal = $(modalTarget);								// modalTarget 변수에 저장된 문자열을 jQuery 객체로 변환
		    modal.show();												// 모달 보여주기

		    
		    // 모달이 나타날 때 네비게이션 바를 가리지 않도록 z-index 조정
		    const navbar = $(".sticky-top");							// sticky-top  부분에 대하여 z-index 비교 하기 위해 z-index 클수록 위에 뜬다.
		    navbar.css("z-index", 0);
		    navbar.css("position", "static");
		    modal.css("z-index", 99999999);
		    
		  });
		  
		}
	
	function clickPayment() {
		if (!$('#checkTerms').is(':checked')) {
		      alert('결제약관에 동의해주세요.');
		      return;
		}
		
		$.ajax({
	        url: '/FiveDak/order/checkSession.dak',
	        method: 'POST',
	        dataType: 'json',
	        async: false,
	        success: function(response) {
	            if (response.sessionEmpty) {
	                alert('로그인 세션이 만료되었습니다. 다시 로그인해주세요.');
	            } else {
	            	
	            	if(response.userid != $("#orderUserid").val()) {
	            		alert("로그인 세션이 변경되었습니다. 접속정보를 다시 확인해주세요.");
	            	} else {
	            		loadPaymentPopup();
	            	}
	            }
	            
	        },
	        error: function() {
	            alert('세션검사중 문제가 발생했습니다.');

	        }
	    });
		
	}
	
	function loadPaymentPopup() {
		const totAmountPrice = $('#totAmountPrice').val();
		const usePoint = $('#usePoint').val();

		if(!confirm("총 상품금액 : " + totAmountPrice + "\n총 사용포인트 : " + usePoint + "\n총 결제금액 : " + (totAmountPrice - usePoint) + "\n상품을 주문하시겠습니까?")) {
			return;
		}
		
		$('.payment-modal').attr('src','orderpayment.dak');
		
		$("#payment-popup").show();
		const navbar = $(".sticky-top");
	    navbar.css("z-index", 0);
	    navbar.css("position", "static");
	    $("#payment-popup").css("z-index", 99999999);
	}
	
	
		
		
		/****** SelectBox ******/
		function selectBox (e) {
		    $(document).on('click','.select-value',function(e){
		        if ( !$(this).hasClass('disabled') ) {
		            if ( $(this).parent('.ui-select').hasClass('on')) {    
		                selectBoxClose ();
		            } else {
		                selectBoxClose ();
		                $(this).parent('.ui-select').addClass('on');
		            }
		        
		            $('body').on('click',function(e){
		                if($(e.target).closest('.ui-select').length === 0 && $('.ui-select').hasClass('on')){
		                   selectBoxClose ()
		                }
		            }) 
		        } 
		    });

		    $(document).on('click','.select-list a',function(){
		        selectBoxAction(this);
		    })
		}

		function selectBoxAction (el) {
		    var listValue = $(el).children('span').text();
		    
		    $(el).parents('.select-list').find('ul li a').removeClass('selected');
		    $(el).addClass('selected');
		    if(!$(el).parent('li').hasClass('ui-direct-select')) {
		    	$('div.ui-direct-input').removeClass('hide');
		    	$('div.ui-direct-input').addClass('hide');
		    	$('#requestMsg').val(listValue);
		    } else {
		    	$('div.ui-direct-input').removeClass('hide');
		    	$('#requestMsg').val($('input.deliveryComment').val());
		    	$('input.deliveryComment').on('input', function() {
		    		$('#requestMsg').val($(this).val());
		    	});
		    }
		    $(el).parents('.ui-select').find('.select-value span').text(listValue);

		    var selectedValue = $(el).parent('li').data('name');
		    $(el).parents('.ui-select').data('value',selectedValue);

		    if ($(el).hasClass('selected') ) {
		        if ( !$(el).parent('li').hasClass('first') ) {
		            $(el).parents('.select-list').prev('.select-value').removeClass('placeholder');
		        } else if ( $(el).parent('li').hasClass('first') ) {
		            $(el).parents('.select-list').prev('.select-value').addClass('placeholder');
		            $(el).parents('.ui-select').attr('data-value','');
		        }
		    }

		    selectBoxClose ();
		}

		function selectBoxClose () {
		    $('.ui-select').removeClass('on');
		   // return false;
		}
		
		function insertOrderInfo() {
			let cartIds = [];
			$('.prd-info-area').each(function() {
				  
				  cartIds.push($(this).data('cartid'));
			});
			
			const recipientName = $('#recipientName').val();
			const recipientPostcode = $('#recipientPostcode').val();
			const recipientAddress = $('#recipientAddress').val();
			const recipientDetailAddress = $('#recipientDetailAddress').val();
			const recipientMobile = $('#recipientMobile').val();
			const requestMsg = $('#requestMsg').val();
			const usePoint = $('#usePoint').val();
			const totAmountPrice = $('#totAmountPrice').val();
			const totPoint = $('#totPoint').val();
			

			
			var data = {
					recipientName: recipientName,
					recipientPostcode: recipientPostcode,
					recipientAddress: recipientAddress,
					recipientDetailAddress: recipientDetailAddress,
					recipientMobile: recipientMobile,
					requestMsg: requestMsg,
					usePoint: usePoint,
					totAmountPrice: totAmountPrice,
					totPoint: totPoint,
					cartIds: cartIds
					};
			
			const dataJSON = JSON.stringify(data);
			$("#frm input[name='paymentData']").val(dataJSON);
			$('#frm').submit();
		}
		
		
		
		
		//////////////////////////////////////////////////테스트 결제 위한 메소드들*****************************************************
		function clickPayment2() {
			if (!$('#checkTerms').is(':checked')) {
			      alert('결제약관에 동의해주세요.');
			      return;
			}
			
			$.ajax({
		        url: '/FiveDak/order/checkSession.dak',
		        method: 'POST',
		        dataType: 'json',
		        async: false,
		        success: function(response) {
		            if (response.sessionEmpty) {
		                alert('로그인 세션이 만료되었습니다. 다시 로그인해주세요.');
		            } else {
		            	
		            	if(response.userid != $("#orderUserid").val()) {
		            		alert("로그인 세션이 변경되었습니다. 접속정보를 다시 확인해주세요.");
		            	} else {
		            		loadPaymentPopup2();
		            	}
		            }
		            
		        },
		        error: function() {
		            alert('세션검사중 문제가 발생했습니다.');

		        }
		    });
			
		}
		
		function loadPaymentPopup2() {
			const totAmountPrice = $('#totAmountPrice').val();
			const usePoint = $('#usePoint').val();

			if(!confirm("총 상품금액 : " + totAmountPrice + "\n총 사용포인트 : " + usePoint + "\n총 결제금액 : " + (totAmountPrice - usePoint) + "\n상품을 주문하시겠습니까?")) {
				return;
			}
			
			$('.payment-modal').attr('src','orderpayment2.dak');
			
			$("#payment-popup").show();
			const navbar = $(".sticky-top");
		    navbar.css("z-index", 0);
		    navbar.css("position", "static");
		    $("#payment-popup").css("z-index", 99999999);
		}
		//********************************************************************************
		
	    
	    

</script>




<div class="approval-container container" style="display: flex; margin-bottom: 5%;">
	
	<div class="col-9">
		<form id="frm" name="paymentFrm" action="/FiveDak/order/orderend.dak" method="post">
			<input type="hidden" name="paymentData" />
		</form>
		<div class="page-title-area">
			<h2 class="title-page">주문/결제</h2>
		</div>
		<!--// page-title-area -->
		
		<div class="order-info" id="orderUserInfo">
		
			<div class="list-head">
				<h3 class="title-list">주문자 정보</h3>
			</div>
			<!--// list-head -->


			<div class="order-address">
				<ul class="info-txt">
					<li>${sessionScope.loginuser.mbrName }</li>
					<li>${sessionScope.loginuser.mbrMobile }</li>
					<li>${sessionScope.loginuser.mbrEmail }</li>
				</ul>
				<input type="hidden" id="orderUserid" name="orderUserid" value="${sessionScope.loginuser.mbrId }">
				<input type="hidden" name="orderName" value="${sessionScope.loginuser.mbrName }">
                <input type="hidden" name="orderCell" value="${sessionScope.loginuser.mbrMobile }">
                <input type="hidden" name="orderEmail" value="${sessionScope.loginuser.mbrEmail }">
			</div>
			<div class="list-head-sub">
				<h3 class="title-list">배송지 정보</h3>
				<button type="button" id="deliveryChange" class="btn-basic-sm2 btn-default"  data-modal-target="#deliver-popup"><span>배송지변경</span></button>
			</div>
			<div class="lineless-table type1">
				<input type="hidden" id="recipientName" name="recipientName" value="${sessionScope.loginuser.mbrName }"/>
                <input type="hidden" id="recipientPostcode" name="recipientPostcode" value="${sessionScope.loginuser.mbrPostcode }"/>
                <input type="hidden" id="recipientAddress" name="recipientAddress" value="${sessionScope.loginuser.mbrAddress }"/>
                <input type="hidden" id="recipientDetailAddress" name="recipientDetailAddress" value="${sessionScope.loginuser.mbrDetailAddress }"/>
                <input type="hidden" id="recipientMobile" name="recipientMobile" value="${sessionScope.loginuser.mbrMobile}"/>
				<table>
					<colgroup>
						<col style="width: 115px">
						<col />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">받는분</th>
							<td class="recipientNameText">${sessionScope.loginuser.mbrName }</td>
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td class="recipientAddressText">(${sessionScope.loginuser.mbrPostcode })${sessionScope.loginuser.mbrAddress } ${sessionScope.loginuser.mbrDetailAddress }
							</td>
						</tr>
						<tr>
							<th scope="row">휴대전화</th>
							<c:set var="mobile" value="${sessionScope.loginuser.mbrMobile}" />
							<c:set var="part1" value="${fn:substring(mobile, 0, 3)}" />
							<c:set var="part2" value="${fn:substring(mobile, 3, 7)}" />
							<c:set var="part3" value="${fn:substring(mobile, 7, 11)}" />
							<td class="recipientMobileText">${part1}-${part2 }-${part3 }</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>


		<div class="order-item-box">

		    <div id="userOrderList">
				<div class="delivery-state normal">
            		<h4 class="tit">주문상품 <c:out value="${fn:length(requestScope.checkout.cartDtoList)}"/>개</h4>
                	<div class="right-dlv-info">
                		<i class='fas fa-shipping-fast' style='font-size:16px; color:#fff;'></i>
                		<p class="txt">
                    		<span id="dlvPrice"><fmt:formatNumber value="${checkout.shippingCost}" pattern="#,###" />원</span>
                		</p>
            		</div>
        		</div>
		
        		<div class="delivery-guide type02" id="delivery-guide-1600">
        			<c:if test="${checkout.shippingCost > 0}">
        			<div class="type02-inner">
        				<p class="txt left-item">배송비 <strong><fmt:formatNumber value="${checkout.shippingCost}" pattern="#,###" />원</strong></p>
        				<p class="txt right-item"><fmt:formatNumber value="${30000 - (checkout.totalAmount - checkout.shippingCost) }" pattern="#,###" />원 더 구매시 무료배송</p>
        			</div>
        			</c:if>
        		</div>
            	<ul class="cart-list" data-dlv-cd="1600" data-delivery-state="normal" data-n-dlv-price="3000">
            	
            	
            		<c:forEach items="${checkout.cartDtoList}" var="cartDto">
                	<li>
                    	<div class="prd-info-area"
                    	
                    		 data-cartid="${cartDto.cart_id}"
				      		 data-productid="${cartDto.cart_product_id }"
				      		 data-productname="${cartDto.prod.prodName }"
				      		 data-brandname="${cartDto.prod.brandDTO.brandName }"
				      		 data-productprice="${cartDto.prod.prodPrice }"
				      		 data-productstock="${cartDto.prod.prodStock }"
				      		 data-productdiscount="${cartDto.prod.prodDiscount }">
							<input type="hidden" class="vProductCd" value="25900"/>
								<div class="inner">
                                	<div class="column img"><a href="javascript:void(0);"><img src="<%=request.getContextPath()%>/images/${cartDto.prod.prodImage1 }" alt="상품이미지"/></a></div>
                                	<div class="column tit">
										<p class="tit">[${cartDto.prod.brandDTO.brandName}] ${cartDto.prod.prodName}</p>
	                                    <!-- <p class="desc">제품설명(안넣을수도있음)</p> -->
										<ul class="price-item">
                                        	<li><span class="num"><fmt:formatNumber value="${cartDto.prod.prodDiscount}" pattern="#,###" /></span>원</li>
                                        	<li><span class="num original-price"><fmt:formatNumber value="${cartDto.prod.prodPrice}" pattern="#,###" />원</span></li>
                                        	<li><span class="num">${cartDto.cart_quantity}</span>개</li>
										</ul>

                                	</div>
									<div class="column price w70">
                                    	<span class="num"><fmt:formatNumber value="${cartDto.totalAmount}" pattern="#,###" /></span>원
                                	</div>
								</div>
							</div>
					</li>
					
					</c:forEach>
                 </ul>
    		</div>

		</div>


		<div class="dlv-request-box" id="norReqBox" style="display: block">
			 <!-- 배송 요청사항 -->
             <div class="inner-div">
                 <div class="request-tit"><h5>배송 요청사항</h5></div>
                 <div class="request-detail">
                     <div class="ui-select select-box w-full" data-value="" id="div_normal_comment">
                         <a href="#none" title="" class="select-value placeholder" onclick="return false;"><span>메시지를 선택해 주세요</span></a>
                         <div class="select-list">
                             <ul>
                                     <li data-name="01" class="ui-direct-select"><a href="#direct-item-nor" onclick="return false;"><span>직접입력</span></a></li>
                                 <li data-name="02" class=""><a href="#none" onclick="return false;"><span>배송전, 연락 부탁드립니다.</span></a></li>
                                 <li data-name="03" class=""><a href="#none" onclick="return false;"><span>부재시, 전화 또는 문자 주세요.</span></a></li>
                                 <li data-name="04" class=""><a href="#none" onclick="return false;"><span>부재시, 경비(관리)실에 맡겨주세요.</span></a></li>
                                 </ul>
                         </div>
                     </div><!--// select-box-->

                     <!-- 직접입력 선택시 -->
                     <div id="direct-item-nor" class="ui-direct-input hide">
                         <input type="text" class="input-text w-full deliveryComment removeEmoji" name="dlv_memo" placeholder="배송 요청 사항을 입력하세요"/>
                     </div><!--// 직접입력 선택시 -->
                     
                     <input type="hidden" id="requestMsg" name="requestMsg" value="">
                     
				</div><!--// request-detail -->
             </div><!--// inner-div -->
        </div>
		
		
		
        <div class="order-info">
	        <div class="list-head">
	             <h3 class="title-list">포인트</h3>
	        </div><!--// list-head -->
			
			<div class="lineless-table type1">
	            <table>
	                <caption>쿠폰/할인 사용</caption>
	                <colgroup>
	                    <col style="width:190px">
	                    <col/>
	                </colgroup>
	                <tbody>
	                <tr>
	                    <th scope="row"><span class="tit">포인트 사용</span></th>
	                    <td>
	                        <div class="order-point">
	                            <div class="input-group-wrap box-type">
	                                <div class="input-group">
	                                    <!-- 현재 보유 포인트 -->
	                                    <input type="hidden" id="currentPoint" name="currentPoint" value="${sessionScope.loginuser.mbrPoint }">
	                                    <input type="hidden" id="usePoint" name="usePoint" value="0">
	                                    <input type="text" title="" class="input-text ui-point-input" id="textUsePoint" name="textUsePoint" placeholder="100p부터 사용가능">
	                                    <span class="input-group-btn">
	                                        <button type="button" class="btn-x-xs btn-input-del" title=""><i class="ico-x-normal"></i><span class="blind">삭제</span></button>
	                                        <button type="button" class="btn-ex-grey" onclick="UseAllPoint()"><span>전액사용</span></button>
	                                    </span>
	                                </div><!--// input-group -->
	                            </div><!--// input-group-wrap -->
	                            <p class="point-guide">사용 가능 포인트 <span style="font-weight: bold;">${sessionScope.loginuser.mbrPoint }</span>P</p>
	                        </div><!--// order-point -->
	                    </td>
	                </tr>
	                </tbody>
	            </table>
	        </div><!--// lineless-table -->
		</div><!-- order info -->
						<input type="hidden" id="totPrice" name="totPrice" class="resetOrderPaySide" value="${checkout.totalPrice }">
                        <input type="hidden" id="totDiscountPrice" name="totDiscountPrice" class="resetOrderPaySide" value="${checkout.totalDiscount }">
                        <input type="hidden" id="totShippingCost" name="totShippingCost" class="resetOrderPaySide" value="${checkout.shippingCost }">
                        <input type="hidden" id="totAmountPrice" name="totAmountPrice" class="resetOrderPaySide" value="${checkout.totalAmount + checkout.shippingCost }"/>
                        <input type="hidden" id="totPoint" name="totPoint" class="resetOrderPaySide" value="${checkout.pointsEarned }"/>
		<!-- 결제하기 버튼  -->
		<div class="payment-btn">
			<button type="button" id="paymentButton" class="btn">결제하기</button>
		</div>
		<div class="payment-btn">
			<button type="button" id="paymentButton2" class="btn">결제하기(100원)</button>
		</div>
		<div class="payment-btn">
			<button type="button" id="paymentButton3" class="btn" onclick="insertOrderInfo()">결제하기(바로 insert)</button>
		</div>
		
	</div>


	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 사이드 바 시작 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<div class="col-3 approval-sidebar">
		<!--  사이드 바 입니다. -->
		
		<div class="payment-info-box sidebar__inner row">
			<h3 class="tit">주문결제 금액</h3>
			<div class="order-price">
            <ul class="div-price">
                <li>
                    <div class="list-inner">
                        <span class="tit">상품금액</span>
                        <p class="price"><strong class="num resetOrderPaySide" id="txt_tot_price"><fmt:formatNumber type="number" value="${checkout.totalPrice }"  pattern="#,###"/></strong> 원
                        </p>
                        
                        </div>
                </li>
                <li style="display: ">
                    <div class="list-inner">
                        <span class="tit">할인금액</span>
                        <p class="price"><strong class="num resetOrderPaySide" id="totalDiscountPrice"><fmt:formatNumber type="number" value="${checkout.totalDiscount }"  pattern="#,###"/></strong> 원</p>
                        
                    </div>
                </li>
                <li>
                    <div class="list-inner">
                        <span class="tit">배송비</span>
                        <p class="price">
                            <strong class="num resetOrderPaySide" id="txt_tot_dlv_price"><fmt:formatNumber type="number" value="${checkout.shippingCost }"  pattern="#,###"/></strong> 원
                        </p>
                        
                    </div>
                </li>
            </ul>
            <div class="total-price" style="padding:20px 0;">
                <div class="list-inner">
                    <span class="tit">총 결제금액</span>
                    <div class="price">
                        <strong class="num text-primary resetOrderPaySide" id="txt_tot_pg_price"><fmt:formatNumber type="number" value="${checkout.totalAmount + checkout.shippingCost }"  pattern="#,###"/></strong> 원
                    </div>
                </div>
            </div>
        </div><!-- order price -->
        
        <div class="point-container-box">
            <ul class="list-sub-inner">
                <li ><span class="tit">적립예정 포인트</span><span class="txt"><span id="totalSavePointTot"><fmt:formatNumber type="number" value="${checkout.pointsEarned }"  pattern="#,###"/></span>P</span></li>
                
            </ul>
        </div><!-- point 보여주기 -->

			
		<ul class="terms-view" style="width: 100%">
            <li>
                <a href="javascript:void(0)" data-modal-target="#provision1-modal">
                    <span class="txt">처리위탁 및 3자 제공 동의</span>
                    <span class="view">내용보기<i class="fas fa-caret-right"></i></span>
                </a>
            </li>
                        
            
            <li>
                <a href="javascript:void(0)" data-modal-target="#provision2-modal">
                    <span class="txt">결제대행서비스 이용 동의</span>
                    <span class="view">내용보기<i class="fas fa-caret-right"></i></span>
                </a>
            </li>

            <li>
                <a href="javascript:void(0)" data-modal-target="#provision3-modal">
                    <span class="txt">개인정보 수집 및 이용 동의</span>
                    <span class="view">내용보기<i class="fas fa-caret-right"></i></span>
                </a>
            </li>
        </ul><!--// terms-view -->
        
        <!-- 모달창 -->
		<div id="provision1-modal" class="modal approval-modal">
			<div class="modal-content approval-modal-content" style="width: 80%; margin :5% auto;">
				<iframe id="iframe-approval-modal" style="border: none; width: 100%; height: 630px;" src="openpopupone.dak" allow-same-origin>  
	            </iframe>
			</div>
		</div>
		<div id="provision2-modal" class="modal approval-modal">
			  <div class="modal-content approval-modal-content" style="width: 80%; margin :5% auto;">
			    <iframe id="iframe-approval-modal" style="border: none; width: 100%; height: 630px;" src="openpopuptwo.dak" allow-same-origin>  
	           	</iframe>
			  </div>
		</div>
		<div id="provision3-modal" class="modal approval-modal">
			<div class="modal-content approval-modal-content" style="width: 80%; margin :5% auto;">
				 <iframe id="iframe-approval-modal" style="border: none; width: 100%; height: 630px;" src="openpopupthree.dak" allow-same-origin>  
            	 </iframe>		    
			</div>
		</div>
		
		<div id="deliver-popup" class="modal approval-modal">
			<div class="modal-content approval-modal-content" style="width: 40%; margin :5% auto;">
				 <iframe id="iframe-approval-modal" class="delivery-modal" style="border: none; width: 100%; height: 630px;" src="orderdeliverypopup.dak" allow-same-origin>  
            	 </iframe>		    
			</div>
		</div>
		
		<div id="payment-popup" class="modal approval-modal">
			<div class="modal-content approval-modal-content" style="width: 55%; margin :5% auto;">
				 <iframe id="iframe-approval-modal" class="payment-modal" style="border: none; width: 100%; height: 630px;" src="orderpayment.dak" allow-same-origin>  
            	 </iframe>		    
			</div>
		</div>
		
		<div id="payment-popup2" class="modal approval-modal">
			<div class="modal-content approval-modal-content" style="width: 55%; margin :5% auto;">
				 <iframe id="iframe-approval-modal" class="payment-modal" style="border: none; width: 100%; height: 630px;" src="orderpayment2.dak" allow-same-origin>  
            	 </iframe>		    
			</div>
		</div>
		
		
		<!-- 모달창끝 -->
		 
		<div class="check-area">
            <div class="custom-control custom-checkbox">
			      <input type="checkbox" class="custom-control-input" id="checkTerms" name="check_terms">
			      <label class="custom-control-label" for="checkTerms">상기 필수약관을 확인하였으며<br/>결제에 동의합니다.</label>
			      
			</div>
        </div>

		</div>
	</div>
	
</div>



<jsp:include page="/WEB-INF/views/footer.jsp" /><!-- footer 불러오기-->