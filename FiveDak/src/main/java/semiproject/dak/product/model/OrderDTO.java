package semiproject.dak.product.model;

public class OrderDTO {
	private int orderId ; // 주문 번호
	private String fk_orderMbrId; // 주문자 아이디
	private String orderDate ; // 주문 날짜
	private int orderTotalPrice ; // 주문 총 금액
	private int orderPoint ; // 주문 포인트
	private String orderPostcode ; // 우편번호
	private String orderAddress ; // 배송주소 
	private String orderDetailAddress ; // 배송주소 상세주소
	private String recipName ;	// 수령인 이름
	private String recipMobile ; // 수령인 연락처
	private String orderMessage ; // 배송 요청사항
	private String orderTrackNo ; // 운송장 번호
	private int orderStatus ;  // 배송 상태 여부
	private int reviewStatus ; // 리뷰 여부
	private String orderStatus_name ; // 배송 상태 여부 이름 ( 원래는 dto 가 필요하지만 굳이 안만들고 여기에다가 함) 
	


	// 기본 생성자 
	public OrderDTO () {}
	
	public OrderDTO(int orderId, String fk_orderMbrId, String orderDate, int orderTotalPrice, int orderPoint,
			String orderPostcode, String orderAddress, String orderDetailAddress, String recipName, String recipMobile,
			String orderMessage, String orderTrackNo, int orderStatus, int reviewStatus,String orderStatus_name) {
		super();
		this.orderId = orderId;
		this.fk_orderMbrId = fk_orderMbrId;
		this.orderDate = orderDate;
		this.orderTotalPrice = orderTotalPrice;
		this.orderPoint = orderPoint;
		this.orderPostcode = orderPostcode;
		this.orderAddress = orderAddress;
		this.orderDetailAddress = orderDetailAddress;
		this.recipName = recipName;
		this.recipMobile = recipMobile;
		this.orderMessage = orderMessage;
		this.orderTrackNo = orderTrackNo;
		this.orderStatus = orderStatus;
		this.reviewStatus = reviewStatus;
		this.orderStatus_name = orderStatus_name;
		
	}
	public String getOrderStatus_name() {
		return orderStatus_name;
	}

	public void setOrderStatus_name(String orderStatus_name) {
		this.orderStatus_name = orderStatus_name;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getFk_orderMbrId() {
		return fk_orderMbrId;
	}
	public void setFk_orderMbrId(String fk_orderMbrId) {
		this.fk_orderMbrId = fk_orderMbrId;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public int getOrderTotalPrice() {
		return orderTotalPrice;
	}
	public void setOrderTotalPrice(int orderTotalPrice) {
		this.orderTotalPrice = orderTotalPrice;
	}
	public int getOrderPoint() {
		return orderPoint;
	}
	public void setOrderPoint(int orderPoint) {
		this.orderPoint = orderPoint;
	}
	public String getOrderPostcode() {
		return orderPostcode;
	}
	public void setOrderPostcode(String orderPostcode) {
		this.orderPostcode = orderPostcode;
	}
	public String getOrderAddress() {
		return orderAddress;
	}
	public void setOrderAddress(String orderAddress) {
		this.orderAddress = orderAddress;
	}
	public String getOrderDetailAddress() {
		return orderDetailAddress;
	}
	public void setOrderDetailAddress(String orderDetailAddress) {
		this.orderDetailAddress = orderDetailAddress;
	}
	public String getRecipName() {
		return recipName;
	}
	public void setRecipName(String recipName) {
		this.recipName = recipName;
	}
	public String getRecipMobile() {
		return recipMobile;
	}
	public void setRecipMobile(String recipMobile) {
		this.recipMobile = recipMobile;
	}
	public String getOrderMessage() {
		return orderMessage;
	}
	public void setOrderMessage(String orderMessage) {
		this.orderMessage = orderMessage;
	}
	public String getOrderTrackNo() {
		return orderTrackNo;
	}
	public void setOrderTrackNo(String orderTrackNo) {
		this.orderTrackNo = orderTrackNo;
	}
	public int getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}
	public int getReviewStatus() {
		return reviewStatus;
	}
	public void setReviewStatus(int reviewStatus) {
		this.reviewStatus = reviewStatus;
	}
	
	
}
