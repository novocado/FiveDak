package semiproject.dak.product.model;

public class CategoryDTO {
	private int cateId ;
	private String cateName ;
	
	public CategoryDTO() { }
	
	public CategoryDTO(int cateId, String cateName) {
		this.cateId = cateId;
		this.cateName = cateName;
	}
	
	public int getCateId() {
		return cateId;
	}
	public void setCateId(int cateId) {
		this.cateId = cateId;
	}
	public String getCateName() {
		return cateName;
	}
	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	
}
