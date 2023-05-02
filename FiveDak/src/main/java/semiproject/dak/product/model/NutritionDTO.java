package semiproject.dak.product.model;

public class NutritionDTO {

	private int nutrition_id;
    private double product_cal;
    private double product_protein;
    private double product_sodium;
    private double product_kal;
    private double product_fat;
    private double product_transfat;
    private double product_satfat;
    private double product_col;
    private double product_sug;
    
    private ProductDTO prodDTO;
	
	
	public NutritionDTO() { }
	
	public NutritionDTO(int nutrition_id, double product_cal, double product_protein, double product_sodium, double product_kal, double product_fat, double product_transfat, double product_satfat, double product_col, double product_sug) {
		this.nutrition_id = nutrition_id;
		this.product_cal = product_cal;
		this.product_protein = product_protein;
		this.product_sodium = product_sodium;
		this.product_kal = product_kal;
		this.product_fat = product_fat;
		this.product_transfat = product_transfat;
		this.product_satfat = product_satfat;
		this.product_col = product_col;
		this.product_sug = product_sug;
	}
	public int getNutrition_id() {
		return nutrition_id;
	}

	public void setNutrition_id(int nutrition_id) {
		this.nutrition_id = nutrition_id;
	}

	public double getProduct_cal() {
		return product_cal;
	}

	public void setProduct_cal(double product_cal) {
		this.product_cal = product_cal;
	}

	public double getProduct_protein() {
		return product_protein;
	}

	public void setProduct_protein(double product_protein) {
		this.product_protein = product_protein;
	}

	public double getProduct_sodium() {
		return product_sodium;
	}

	public void setProduct_sodium(double product_sodium) {
		this.product_sodium = product_sodium;
	}

	public double getProduct_kal() {
		return product_kal;
	}

	public void setProduct_kal(double product_kal) {
		this.product_kal = product_kal;
	}

	public double getProduct_fat() {
		return product_fat;
	}

	public void setProduct_fat(double product_fat) {
		this.product_fat = product_fat;
	}

	public double getProduct_transfat() {
		return product_transfat;
	}

	public void setProduct_transfat(double product_transfat) {
		this.product_transfat = product_transfat;
	}

	public double getProduct_satfat() {
		return product_satfat;
	}

	public void setProduct_satfat(double product_satfat) {
		this.product_satfat = product_satfat;
	}

	public double getProduct_col() {
		return product_col;
	}

	public void setProduct_col(double product_col) {
		this.product_col = product_col;
	}

	public double getProduct_sug() {
		return product_sug;
	}

	public void setProduct_sug(double product_sug) {
		this.product_sug = product_sug;
	}

	public ProductDTO getprodDTO() {
		return prodDTO;
	}

	public void setbrandDTO(ProductDTO prodDTO) {
		this.prodDTO = prodDTO;
	}
	
}
