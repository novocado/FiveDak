package semiproject.dak.product.model;

public class BrandDTO {
	private int brandId ;
	private String brandName ;
	
	
	public BrandDTO() { }
	
	public BrandDTO(int brandId, String brandName) {
		this.brandId = brandId;
		this.brandName = brandName;
	}
	public int getBrandId() {
		return brandId;
	}
	public void setBrandId(int brandId) {
		this.brandId = brandId;
	}
	public String getBrandName() {
		return brandName;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	
}
