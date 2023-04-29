<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String ctxPath = request.getContextPath();
%>


<jsp:include page="/WEB-INF/views/header-final.jsp"/>



<style type="text/css"> 
	li {
		list-style: none;
	}

	#cart_option button {
	background:#fff; color:#333; border:1px solid #ccc;
	}
	
	
	ul#cart_firstul {
		padding: 0;
	}

    
    /* Checkbox Customizing */
    .custom-checkbox input[type="checkbox"]:checked+.custom-control-label::before {
      background-color: #fd6f06;
      border-color: #fd6f06;
    }

    .custom-checkbox input[type="checkbox"]:checked+.custom-control-label::after {
      color: white;
    }
    
    /* X shape button */
    .cross-button {
      cursor: pointer;
      color: #000;
      font-size: 18px;
      margin-left: 10px;
    }
    
    
    /* prod box area */
    
	.product-info-container{border-top:solid 1px #E0E0E0;}
	
    .product-info-box {
    	margin:0;
		padding-top: 20px;
 		
 		border-bottom: solid 1px #E0E0E0;
 		border-left: solid 1px #E0E0E0;
 		border-right: solid 1px #E0E0E0;
	}
	
    
    .prod-bottom-box {
    	margin:0;
	    text-align: center;
		height: 40px;
    	background-color: #F8F8F8;
    	
    }
    .prod-bottom-box .price-txt .num{font-size:14px;}
	.prod-bottom-box .price-txt .num-total{font-weight:700; font-size:16px}
    .prod-bottom-box .price-txt{margin-top: 8px; color:#333; font-size:13px;}
	.prod-bottom-box .price-txt .txt{color:#666}
    .prod-top-box {margin: 0; padding-bottom: 20px;}
    
    .prod-cart-img {
		width: 110px;
		height: 110px;
		position: relative;
	}
	
	/* quantity input element */
    .quantity-input-container {
      display: flex;
      border: 1px solid #ccc;
      border-radius: 4px;
      padding: 2px;
      
      width: 80px;
      height: 30px; 
    }

    .quantity-minus {
      cursor: pointer;
      padding: 2px;
    }

    .quantity-plus {
      cursor: pointer;
      padding: 2px;
    }

    .quantity-input {
      width: 100%;
      flex: 1;
      text-align: center;
      border: none;
    } /* quantity input element */
	
	.prod-info-description {margin-left: 20px;}
	.prod-info-description .text {color:#333;} 
	.prod-total-price {padding-left: 50px; text-align: right;}   /* prod box area */
    
	.deleteUserCart {border: 0; outline: 0; background-color: transparent;}
	
	.order-button {
      display: block;
      width: 100%;
      padding: 10px 20px;
      margin: 20px 0;
      background-color: #FF7E32;
      color: #fff;
      font-size: 24px;
      font-weight: 700;
      text-align: center;
      border-radius: 5px;
      transition: background-color 0.3s ease-in-out;
      border: solid 1px #ff7e32;
    }

    .order-button:hover {
      background-color: #e35f0a;
    }
    
    /* total box */
    .cart-total-box dl {margin: 0; padding: 0;}
    .cart-total-box dt, .cart-total-box dd {color:#333;}
    .cart-total-box { border: 1px solid #000;}
    .no-spacing > div {padding-right: 0; padding-left: 0;}
    .price-info {border-right: 1px solid #000;}
	
	.price-info:after {
    position: absolute;
    top: 36px;
    right: -16px;
    content: '';
    width: 32px;
    height: 32px;
    background: url(https://www.rankingdak.com/resources/pc/images/icon/ico_bullet.png) 0 -60px;
	}
	.cart-total-box .col-sm-3:nth-child(1) .price-info:after{background-position:-190px -60px}
	.cart-total-box .col-sm-3:nth-child(3) .price-info:after{background-position:-50px -60px}
	.cart-total-box .col-sm-3 span{font-size: 20pt; font-weight: 700;}
	.cart-total-box .col-sm-3 .price-total-info span{color:#ff7e32;}
	
	
	.checkbox-col{margin-left: 20px;}
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		setCartListEvent();
		calculateProductPrice();
		calculateTotalOrderPrice();
	});
	
	
	function setCartListEvent() {
		$('#checkAll').on('click', checkAll);
		$('.checkbox').on('click', checkboxFunc);
		$('.btn-qty').on('click', updateProductQty);
		$('#deleteUserCartList').on('click', deleteUserCartList);
		$('.deleteUserCart').on('click', deleteUserCart);
		$('#orderButton').on('click',order);
	}
	
	
	function checkAll(e) {
	    const checked = $('#checkAll').is(':checked');
	    if (checked) {
	        $('.cart-list-area .checkbox:not(:disabled)').prop('checked', true)
	        $(this).next('label').text('전체해제')
	    } else {
	        $('.cart-list-area .checkbox').prop('checked', false);
	        $(this).next('label').text('전체선택')
	    }
	    calculateTotalOrderPrice();
	}
	
	function checkboxFunc(e) {
		const checkboxLength = $('.cart-list-area input[type=checkbox]:not(:disabled)').length
	    const checkedLength = $('.cart-list-area input[type=checkbox]:checked:not(:disabled)').length;

	    if (checkedLength < checkboxLength){
	        $('#checkAll').prop('checked', false);
	        $('#checkAll').next('label').text('전체선택');
	    } else if (checkedLength == checkboxLength){
	        $('#checkAll').prop('checked', true);
	        $('#checkAll').next('label').text('전체해제');
	    }

	    calculateTotalOrderPrice();
	}
	

	function updateProductQty(e) {
		
		
		const dataSet = this.dataset;
		
		const cartId = dataSet.cartid;
		const productId = dataSet.productid;
		const productPrice = dataSet.productprice;
		const discountPrice = dataSet.productdiscount;
		const productStock = dataSet.productstock
		const calculate = dataSet.calculate;
		const outOfStock = dataSet.outofstock
		
		if (outOfStock == 'Y') {
	        return;
	    }

	    if (!$(this).parents('div.product-info-box').find('input[type=checkbox]').is(':checked')) {
	        alert('상품 선택 후 수량을 변경할 수 있습니다.');
	        return;
	    }


		
	    const oriQty = Number($("input.quantity-input.qty-product-" + cartId + "-" + productId).val());
	    
	    
			    
	    let nQty = oriQty;
	    
	    const nMaxQty = productStock;

	    
	    if (calculate == 'ADD') {
	        nQty = oriQty + 1;
	        $("input.quantity-input.qty-product-" + cartId + "-" + productId).val(nQty);
	        if (nMaxQty > 0 && nQty > nMaxQty) {
	        	$("input.quantity-input.qty-product-" + cartId + "-" + productId).val(oriQty);
	        	alert("제품의 재고 이상으로 수량을 선택할 수 없습니다.");
	        	nQty = nMaxQty;
	        }
	        
	    } else if (calculate == 'SUBTRACT') {
	        if (nQty > 1) {
	            nQty = oriQty - 1;
	            if (nMaxQty > 0 && nQty > nMaxQty) {
	                nQty = nMaxQty;
	            }
	            $("input.quantity-input.qty-product-" + cartId + "-" + productId).val(nQty);
	        } else {
	            return;
	        }
	    } else {
	        return;
	    }
	    

	    

	    $.ajax({
	        url: '/FiveDak/cart/updateProductQtyAjax.dak'
	        , type: "post"
	        , data:{"cartid":cartId,
                "nqty":nQty}
	        , dataType: "json"
	        , success: function (data) {
	            if (data.status == 'succ') {
	                const prodCode = "-" + cartId + "-" + productId;
	                
	                
	        		const cartTotal = discountPrice * nQty;
	        		const prodTotal = productPrice * nQty;
	        		const discountTotal = (productPrice - discountPrice) * nQty ;
	        		const point = Math.floor(cartTotal / 100 * 1);
	                
	        		
	                $("span#cart-price" + prodCode).text(cartTotal.toLocaleString());
	                $("span#cart-point" + prodCode).text(point.toLocaleString());
	                $("span#prod-bottom-price" + prodCode).text(prodTotal.toLocaleString());
	                $("span#prod-bottom-discount" + prodCode).text(discountTotal.toLocaleString());
	                $("span#prod-bottom-total" + prodCode).text(cartTotal.toLocaleString());
	                calculateTotalOrderPrice();

	                
	            } else {
	                alert(data.message);
	                // 수량복구
	                $("input.quantity-input.qty-product-" + cartId + "-" + productId).val(oriQty);

	            }
	        }
	        , error: function (e) {
	            console.log(e);
	        }
	    });

	}
	
	
	
	function calculateTotalOrderPrice() {
		let totalProductPrice = 0;
        let totalDiscountPrice = 0;
        let totalDeliveryPrice = 0;
        let totalOrderPrice = 0;
		
		$('.productCheckbox:checked').each(function (i, v) {
			const $checkbox = $(this);
			const dataSet = $checkbox.data();
			const productPrice = dataSet.productprice;
			const discountPrice = dataSet.productdiscount;
			const productId = dataSet.productid;
			const cartId = dataSet.cartid
            const qty = $("input.quantity-input.qty-product-" + cartId + "-" + productId).val();
            
			
			const sumOfPrice = qty * productPrice;
			const sumOfDiscount = qty * (productPrice - discountPrice);
			const sumOfTotalPrice = qty * discountPrice;
			
			
			totalProductPrice += sumOfPrice;
			totalDiscountPrice += sumOfDiscount;
			totalOrderPrice += sumOfTotalPrice;
	        
     
        });
		
		if (totalOrderPrice > 0 && totalOrderPrice < 30000) {
			totalDeliveryPrice = 3000; 
		} 
		
		totalOrderPrice += totalDeliveryPrice;
		
		$("#totalProductPrice").text(totalProductPrice.toLocaleString());
		$("#totalDiscountPrice").text(totalDiscountPrice.toLocaleString());
		$("#totalDeliveryPrice").text(totalDeliveryPrice.toLocaleString());
		$("#totalOrderPrice").text(totalOrderPrice.toLocaleString());
		$("#orderButtonPrice").text(totalOrderPrice.toLocaleString());
	     

	}
	
	function calculateProductPrice() {
		$('.productCheckbox:checked').each(function (i, v) {
			const $checkbox = $(this);
			const dataSet = $checkbox.data();
			const productPrice = dataSet.productprice;
			const discountPrice = dataSet.productdiscount;
			const productId = dataSet.productid;
			const cartId = dataSet.cartid
			
			const prodCode = "-" + cartId + "-" + productId;
            const qty = $("input.quantity-input.qty-product" + prodCode).val();
			
    		const cartTotal = discountPrice * qty;
    		const prodTotal = productPrice * qty;
    		const discountTotal = (productPrice - discountPrice) * qty ;
    		const point = Math.floor(cartTotal / 100 * 1);
            
    		
            $("span#cart-price" + prodCode).text(cartTotal.toLocaleString());
            $("span#cart-point" + prodCode).text(point.toLocaleString());
            $("span#prod-bottom-price" + prodCode).text(prodTotal.toLocaleString());
            $("span#prod-bottom-discount" + prodCode).text(discountTotal.toLocaleString());
            $("span#prod-bottom-total" + prodCode).text(cartTotal.toLocaleString());
            
	        
     
        });
	}
	

	function deleteUserCart(e) {
		 
	    const deleteUserCartList = [];
	    const $checkbox = $(this);
		const dataSet = $checkbox.data();
		
		const data = {
				cartid:dataSet.cartid
		}
		deleteUserCartList.push(data);
	    callAjax('/FiveDak/cart/deleteUserCartAjax.dak', deleteUserCartList);
	}

	function deleteUserCartList(e) {

	    const deleteUserCartList = [];
	    
	    $('.deleteUserCartList:checked').each(function (i, v) {
			const $checkbox = $(this);
			const dataSet = $checkbox.data();
			const data = {
					cartid:dataSet.cartid
			}
			deleteUserCartList.push(data);
        });
		
	    if (deleteUserCartList.length === 0) {
	        alert('삭제할 상품을 선택해주세요.');
	        return;
	    }

	    if (confirm('선택한 상품을 장바구니에서 삭제하시겠습니까?')) {
	        callAjax('/FiveDak/cart/deleteUserCartAjax.dak', deleteUserCartList);
	    }

	}

	function callAjax(url, obj) {
		
		$.ajax({
	        url: url
	        , type: 'POST'
	        , data: {
	        	dataList: JSON.stringify(obj)
	        }
	        , dataType: "json"
	        , success: function (data) {
	            if (data.status == 'succ') {
	                window.location.href = '/FiveDak/cart/cartlist.dak'
	            } else {
	                if (data.status == 'fail' && !isEmpty(data.message)) {
	                    alert(data.message);
	                }
	        	}
	        }
            , error: function (e) {
	            console.log(e);
	        }
	    });
	}
	
	function order(e) {
		
		
		if ($('.checkbox:checked:not("#checkAll")').length == 0) {
	        alert('구매할 상품을 하나 이상 선택해주세요.');
	        return;
	    }
		
		let selectedProducts = [];
		
		$('.productCheckbox:checked').each(function (i, v) {
			const $checkbox = $(this);
			const dataSet = $checkbox.data();
			
			const productId = dataSet.productid;
			const cartId = dataSet.cartid
			const prodCode = "-" + cartId + "-" + productId;
            const qty = $("input.quantity-input.qty-product" + prodCode).val();
            
            selectedProducts.push({
                productid: productId,
                cartid: cartId,
                qty: qty
             });
        });
		
		
		const selectedProductsJson = JSON.stringify(selectedProducts);
		
		$("#frm input[name='SelectedProductArr']").val(selectedProductsJson);
		$('#frm').submit();
		
		
	}




</script>


<form id="frm" name="frm" action="/FiveDak/order/order.dak" method="post">
        <input type="hidden" name="SelectedProductArr"/>
        <input type="hidden" name="ordertype" value="CART"/>
    </form>
    
	<div class="container">
		<div id="cart_title_page" class="mt-4 mb-4">
			<h3 class="font-weight-bold">장바구니</h3>
		</div> 
		
		<div id="cart_option" class="row">
			<div class="col-2">
				<div class="custom-control custom-checkbox">
			      <input type="checkbox" class="custom-control-input" id="checkAll" checked>
			      <label class="custom-control-label" for="checkAll">전체해제</label>
			      
			    </div>
			</div>
			<div class="offset-9">
				<button type="button" id="deleteUserCartList" class="btn">
					<span>선택삭제</span>
				</button>
			</div>
		</div><!-- cart option -->
	
		
		
		<div id="cart_main" class="cart-list-area">
					
					
					<!-- 제품 개별 박스 -->
					
					
					
					<c:forEach var="cart" items="${cartlist}">
					<div class="product-info-container mt-4">
						<div class="product-info-box row">
							<div class="col-12 prod-top-box row"> 
								<div class="align-self-center checkbox-col">
									<div class="custom-control custom-checkbox">
								      <input type="checkbox"
								      		 class="custom-control-input productCheckbox checkbox deleteUserCartList"
								      		 id="cart-item-${cart.cart_product_id }"
								      		 checked
								      		 data-cartid="${cart.cart_id}"
								      		 data-productid="${cart.cart_product_id }"
								      		 data-productname="${cart.prod.prodName }"
								      		 data-brandname="${cart.prod.brandDTO.brandName }"
								      		 data-productprice="${cart.prod.prodPrice }"
								      		 data-productstock="${cart.prod.prodStock }"
								      		 data-productdiscount="${cart.prod.prodDiscount }"
								      		 >
								      <label class="custom-control-label" for="cart-item-${cart.cart_product_id }"></label>
									</div>
								</div>
								
								<div>
								    <img class="prod-cart-img" src="${cart.prod.prodImage1 }">
								</div>
								
								<div class="col-5 prod-info-description mr-4">
									<a href="#" class="text">[${cart.prod.brandDTO.brandName }] ${cart.prod.prodName}</a>
									<p class="tit text">오븐구이 혼합 10팩 ★한입소스 3팩증정★</p>
									<ul style="padding: 0" class="h6">
										<li>
											<span class="text"><fmt:formatNumber type="number" value="${cart.prod.prodPrice}"  pattern="#,###"/></span>원
										</li>
									</ul>
								</div>
								
								<div class="quantity-input-container align-self-center ml-4">
							   		 <span class="quantity-minus btn-qty"
							   		 	   data-cartid="${cart.cart_id}"
								      	   data-productid="${cart.cart_product_id }"
								      	   data-productprice="${cart.prod.prodPrice }"
								      	   data-productstock="${cart.prod.prodStock }"
								      	   data-productdiscount="${cart.prod.prodDiscount }"
								      	   data-calculate="SUBTRACT"
                                           data-outofstock="N"
							   		 >		<!-- &&&&&&&품절여부 나중에 수정&&&&&&&&&&&&&& -->
							   		 <i class="fa-solid fa-minus"></i></span>
							   		 
							    	 <input type="text" class="quantity-input qty-product-${cart.cart_id}-${cart.cart_product_id }" value="9" readonly>
							    	 
							    	 <span class="quantity-plus btn-qty"
							    	       data-cartid="${cart.cart_id}"
								      	   data-productid="${cart.cart_product_id }"
								      	   data-productprice="${cart.prod.prodPrice }"
								      	   data-productstock="${cart.prod.prodStock }"
								      	   data-productdiscount="${cart.prod.prodDiscount }"
								      	   data-calculate="ADD"
                                           data-outofstock="N"
							   		 >
							    	 <i class="fa-solid fa-plus"></i></span>
							    </div>
								
								
								<div class="align-self-center prod-total-price">
									<span class="h6" id= "cart-price-${cart.cart_id}-${cart.cart_product_id }"></span>원	
								</div>
								
								<div id="cart_main_point" class="align-self-center mx-4">
									<span id= "cart-point-${cart.cart_id}-${cart.cart_product_id }"></span>p
								</div>
								<div class="align-self-center ml-4">
									<button type="button"
											class="deleteUserCart"
											data-cartid="${cart.cart_id}"
								      	    data-productid="${cart.cart_product_id }"
											>
											<i class="fa fa-times cross-button align-self-center"></i>
									</button>
								</div>
							</div><!-- prod top box -->
							<div class="col-sm-12 prod-bottom-box">
								<p class="price-txt">
	                               <span class="txt">상품</span>
	                               <span class="num" id="prod-bottom-price-${cart.cart_id}-${cart.cart_product_id }"></span>원
	                               - <span class="txt">할인</span>
	                               <span class="num discount" id="prod-bottom-discount-${cart.cart_id}-${cart.cart_product_id }"></span>원
	                               = <span class="num-total" id="prod-bottom-total-${cart.cart_id}-${cart.cart_product_id }"></span>원
	                               
	                           </p>
							</div><!-- prod bottom box -->
						</div><!-- product info box -->
					</div>
					
					</c:forEach>
					
					<!-- product info container -->
						
						
						
						
			
			<div class="container mt-5 cart-total-box">
			  <div class="row no-spacing">
			    <div class="col-sm-3">
			      <div class="text-center p-3 price-info">
			        <dl>
			          <dt>상품 금액</dt>
			          <dd><span id="totalProductPrice">0</span>원</dd>
			        </dl>
			      </div>
			    </div>
			    <div class="col-sm-3">
			      <div class="text-center p-3 price-info">
			        <dl>
			          <dt>할인금액</dt>
			          <dd><span id="totalDiscountPrice">0</span>원</dd>
			        </dl>
			      </div>
			    </div>
			    <div class="col-sm-3">
			      <div class="text-center p-3 price-info">
			        <dl>
			          <dt>배송비</dt>
			          <dd><span id="totalDeliveryPrice">0</span>원</dd>
			        </dl>
			      </div>
			    </div>
			    <div class="col-sm-3">
			      <div class="text-center p-3 price-total-info">
			        <dl>
			          <dt>총 결제금액</dt>
			          <dd><span id="totalOrderPrice">0</span>원</dd>
			        </dl>
			      </div>
			    </div>
			  </div>
			</div><!-- cart total box -->
			
			<div id="order" style="margin-bottom: 200px;">
			<button class="order-button" id="orderButton">
		      <span><span id="orderButtonPrice">0</span>원 주문하기</span>
		    </button>
			</div><!-- order button -->
			
		</div><!-- cart main -->
	
	</div><!-- cart container -->

<jsp:include page="/WEB-INF/views/footer.jsp"/>