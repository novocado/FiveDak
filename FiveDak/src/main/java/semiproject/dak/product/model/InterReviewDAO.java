package semiproject.dak.product.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterReviewDAO {

	public List<HashMap<String, String>> getReview() throws SQLException;
	
	public int getReviewCnt(int review_product_id) throws SQLException;

	public Map<String, String> getreviewDate(String userid) throws SQLException;
	
	
	
}
