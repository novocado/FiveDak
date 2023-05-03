
package semiproject.dak.product.model;

public class OrderDetailDTO {
    
     private int orderDetailId;
     private String orderSerial; 
     private ProductDTO orderDetailProd;
     private int orderQuantity;           // 제품에 대한 주문수량
     private int pricePerUnit;         //  개당가격
     
     private String reviewedDate;
     private String orderedDate;
     
     
     
     public String getReviewedDate() {
		return reviewedDate;
	}

	public void setReviewedDate(String reviewedDate) {
		this.reviewedDate = reviewedDate;
	}

	public String getOrderedDate() {
		return orderedDate;
	}

	public void setOrderedDate(String orderedDate) {
		this.orderedDate = orderedDate;
	}

	public OrderDetailDTO() {} // 기본생성자 

	public int getOrderDetailId() {
		return orderDetailId;
	}

	public void setOrderDetailId(int orderDetailId) {
		this.orderDetailId = orderDetailId;
	}

	public String getOrderSerial() {
		return orderSerial;
	}

	public void setOrderSerial(String orderSerial) {
		this.orderSerial = orderSerial;
	}

	public ProductDTO getOrderDetailProd() {
		return orderDetailProd;
	}

	public void setOrderDetailProd(ProductDTO orderDetailProd) {
		this.orderDetailProd = orderDetailProd;
	}

	public int getOrderQuantity() {
		return orderQuantity;
	}

	public void setOrderQuantity(int orderQuantity) {
		this.orderQuantity = orderQuantity;
	}

	public int getPricePerUnit() {
		return pricePerUnit;
	}

	public void setPricePerUnit(int pricePerUnit) {
		this.pricePerUnit = pricePerUnit;
	}

   
   
}
