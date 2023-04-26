package semiproject.dak.product.model;


public class CartDTO {

	private int cart_id;				// 장바구니 번호
	private String cart_member_id;		// 회원 아이디
	private int cart_product_id; 		// 상품번호
	private int cart_quantity;			// 주문량
	private String  cart_insert_time;	// 주문 시간
	
	private ProductDTO prod;			// 상품객체

	public CartDTO() {}
	
	public CartDTO(int cart_id, String cart_member_id, int cart_product_id, int cart_quantity, String cart_insert_time,
			ProductDTO prod) {
		this.cart_id = cart_id;
		this.cart_member_id = cart_member_id;
		this.cart_product_id = cart_product_id;
		this.cart_quantity = cart_quantity;
		this.cart_insert_time = cart_insert_time;
		this.prod = prod;
	}
	
	public int getCart_id() {
		return cart_id;
	}


	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}


	public String getCart_member_id() {
		return cart_member_id;
	}


	public void setCart_member_id(String cart_member_id) {
		this.cart_member_id = cart_member_id;
	}


	public int getCart_product_id() {
		return cart_product_id;
	}


	public void setCart_product_id(int cart_product_id) {
		this.cart_product_id = cart_product_id;
	}


	public int getCart_quantity() {
		return cart_quantity;
	}


	public void setCart_quantity(int cart_quantity) {
		this.cart_quantity = cart_quantity;
	}


	public String getCart_insert_time() {
		return cart_insert_time;
	}


	public void setCart_insert_time(String cart_insert_time) {
		this.cart_insert_time = cart_insert_time;
	}


	public ProductDTO getProd() {
		return prod;
	}


	public void setProd(ProductDTO prod) {
		this.prod = prod;
	}


	
	
}
