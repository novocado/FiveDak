package semiproject.dak.member.model;

public class MemberPointDTO {

	private int point_history_id;
	private String point_user_id;
	private int point_before;
	private int point_change;
	private int point_after;
	private String point_reason;
	private String point_date;
	private int point_change_type;
	
	//기본 생성자
	public MemberPointDTO() {
		
	}
	
	
	public MemberPointDTO(int point_history_id, String point_user_id, int point_before,
			              int point_change, int point_after, String point_reason,
			              String point_date, int point_change_type) {
		this.point_history_id = point_history_id;
		this.point_user_id = point_user_id;
		this.point_before = point_before;
		this.point_change = point_change;
		this.point_after = point_after;
		this.point_reason = point_reason;
		this.point_date = point_date;
		this.point_change_type = point_change_type;
		
	}


	public int getPoint_history_id() {
		return point_history_id;
	}


	public void setPoint_history_id(int point_history_id) {
		this.point_history_id = point_history_id;
	}


	public String getPoint_user_id() {
		return point_user_id;
	}


	public void setPoint_user_id(String point_user_id) {
		this.point_user_id = point_user_id;
	}


	public int getPoint_before() {
		return point_before;
	}


	public void setPoint_before(int point_before) {
		this.point_before = point_before;
	}


	public int getPoint_change() {
		return point_change;
	}


	public void setPoint_change(int point_change) {
		this.point_change = point_change;
	}


	public int getPoint_after() {
		return point_after;
	}


	public void setPoint_after(int point_after) {
		this.point_after = point_after;
	}


	public String getPoint_reason() {
		return point_reason;
	}


	public void setPoint_reason(String point_reason) {
		this.point_reason = point_reason;
	}


	public String getPoint_date() {
		return point_date;
	}


	public void setPoint_date(String point_date) {
		this.point_date = point_date;
	}


	public int getPoint_change_type() {
		return point_change_type;
	}


	public void setPoint_change_type(int point_change_type) {
		this.point_change_type = point_change_type;
	}
}
