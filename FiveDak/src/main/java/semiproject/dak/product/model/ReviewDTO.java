
package semiproject.dak.product.model;

import java.util.Date;

public class ReviewDTO {

	private int review_id;
	private String review_member_id;
	private int review_product_id;
	private double review_score;
	private String review_title;
	private String review_content;
	private Date review_date;
	private int review_cnt;  //리뷰 개수
	
	public ReviewDTO() { }
	
	public ReviewDTO(int review_id, String review_member_id, int review_product_id, double review_score, 
				     String review_title, String review_content, Date review_date, int review_cnt) {
		this.review_id = review_id;
		this.review_member_id = review_member_id;
		this.review_product_id = review_product_id;
		this.review_score = review_score;
		this.review_title = review_title;
		this.review_content = review_content;
		this.review_date = review_date;
		this.review_cnt = review_cnt;
	}
	
	
	//private int review_id;
	public int getReview_id() {
		return review_id;
	}
	public void setReview_id(int review_id) {
		this.review_id = review_id;
	}
	
	
	
	//private String review_member_id;
	public String getReview_member_id() {
		return review_member_id;
	}
	public void setReview_member_id(String review_member_id) {
		this.review_member_id = review_member_id;
	}
	
	
	
	//private int review_product_id;
	public int getReview_product_id() {
		return review_product_id;
	}
	public void setReview_product_id(int review_product_id) {
		this.review_product_id = review_product_id;
	}
	
	
	
	//private double review_score;
	public double getReview_score() {
		return review_score;
	}
	public void setReview_score(double review_score) {
		this.review_score = review_score;
	}
	
	
	
	//private String review_title;
	public String getReview_title() {
		return review_title;
	}
	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}
	
	
	
	//private String review_content;
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	
	
	
	//private Date review_date;
	public Date getReview_date() {
		return review_date;
	}
	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}
	
	
	//private int review_cnt;
	public int getReview_cnt() {
		return review_cnt;
	}
	public void setReview_cnt(int review_cnt) {
		this.review_cnt = review_cnt;
	}
	
}

