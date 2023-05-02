package semiproject.dak.product.model;

import semiproject.dak.member.model.MembershipTierDTO;

public class ProductDTO {
	private int prodNum ; // 제품번호
	private String prodName ; // 제품명
	private int fk_prodCateNum ; // 제품 카데고리 코드(번호)
	private int fk_prodBrandNum ; // 제품 브랜드 코드(번호)
	private int prodPrice ; // 정가
	private int prodStock ; // 재고 
	private int prodSales ; // 판매량
	private int prodDiscount ; // 판매가
	private double prodAvgRating ; // 평균 별점
	private String prodImage1 ; // 제품 이미지
	private int prodRno; // 제품 순위
	
	///////////////////////////////////////////////
	private int orderNo ; // 주문 상세 테이블의 특정 제품의 주문수
	
	// 추후에 추가해야할 사항 : JOIN 을 하기 위해서 무조건 필요하다.
	private CategoryDTO cateDTO ; // 카테고리 DTO 
	private ReviewDTO reviewDTO;
	private BrandDTO brandDTO ; // 브랜드 DTO 
	private NutritionDTO nutriDTO;
	
	
	public ReviewDTO getReviewDTO() {
		return reviewDTO;
	}


	public void setReviewDTO(ReviewDTO reviewDTO) {
		this.reviewDTO = reviewDTO;
	}


	// 기본 생성자 
	public ProductDTO () {}


	public ProductDTO(int prodNum, String prodName, int fk_prodCateNum, int fk_prodBrandNum, int prodPrice,
			int prodStock, int prodSales, int prodDiscount, double prodAvgRating, String prodImage1, int prodRno) {
		this.prodNum = prodNum;
		this.prodName = prodName;
		this.fk_prodCateNum = fk_prodCateNum;
		this.fk_prodBrandNum = fk_prodBrandNum;
		this.prodPrice = prodPrice;
		this.prodStock = prodStock;
		this.prodSales = prodSales;
		this.prodDiscount = prodDiscount;
		this.prodAvgRating = prodAvgRating;
		this.prodImage1 = prodImage1;
		this.prodRno = prodRno;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////
	
	public int getProdRno() {
		return prodRno;
	}


	public void setProdRno(int prodRno) {
		this.prodRno = prodRno;
	}


	public int getProdNum() {
		return prodNum;
	}

	public void setProdNum(int prodNum) {
		this.prodNum = prodNum;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public int getFk_prodCateNum() {
		return fk_prodCateNum;
	}

	public void setFk_prodCateNum(int fk_prodCateNum) {
		this.fk_prodCateNum = fk_prodCateNum;
	}

	public int getFk_prodBrandNum() {
		return fk_prodBrandNum;
	}

	public void setFk_prodBrandNum(int fk_prodBrandNum) {
		this.fk_prodBrandNum = fk_prodBrandNum;
	}

	public int getProdPrice() {
		return prodPrice;
	}

	public void setProdPrice(int prodPrice) {
		this.prodPrice = prodPrice;
	}

	public int getProdStock() {
		return prodStock;
	}

	public void setProdStock(int prodStock) {
		this.prodStock = prodStock;
	}

	public int getProdSales() {
		return prodSales;
	}

	public void setProdSales(int prodSales) {
		this.prodSales = prodSales;
	}

	public int getProdDiscount() {
		return prodDiscount;
	}

	public void setProdDiscount(int prodDiscount) {
		this.prodDiscount = prodDiscount;
	}

	public double getProdAvgRating() {
		return prodAvgRating;
	}

	public void setProdAvgRating(double prodAvgRating) {
		this.prodAvgRating = prodAvgRating;
	}

	public String getProdImage1() {
		return prodImage1;
	}

	public void setProdImage1(String prodImage1) {
		this.prodImage1 = prodImage1;
	}
	public CategoryDTO getCateDTO() {
		return cateDTO;
	}
	public void setCateDTO(CategoryDTO cateDTO) {
		this.cateDTO = cateDTO;
	}
	public BrandDTO getBrandDTO() {
		return brandDTO;
	}
	public int getOrderNo() {
		return orderNo;
	}


	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}


	public void setBrandDTO(BrandDTO brandDTO) {
		this.brandDTO = brandDTO;
	}
	
	///////////////////////////////////////////////
	// *** 제품의 할인률 ***
	public int getDiscountPercent() {
		// 정가   :  판매가 = 100 : x
		
		// 5000 : 3800 = 100 : x
		// x = (3800*100)/5000 
		// x = 76
		// 100 - 76 ==> 24% 할인
		
		// 할인률 = 100 - (판매가 * 100) / 정가
		return 100 - (prodDiscount * 100)/prodPrice;
	}
	

}
