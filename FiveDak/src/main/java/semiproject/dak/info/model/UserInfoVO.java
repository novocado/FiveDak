package semiproject.dak.info.model;

import java.util.Date;

public class UserInfoVO {

	//데이터 insert 용도
	private int instruction_id;
	private String instruction_title;
	private String instruction_content;
	private Date instruction_created_at;
	
	public UserInfoVO() {}
	
	public UserInfoVO(int instruction_id, String instruction_title, String instruction_content, Date instruction_created_at) {
		this.instruction_id = instruction_id;
		this.instruction_title = instruction_title;
		this.instruction_content = instruction_content;
		this.instruction_created_at = instruction_created_at;
	}
	
	public int getInstruction_id() {
		return instruction_id;
	}
	
	public void setInstruction_id(int instruction_id) {
		this.instruction_id = instruction_id;
	}
	
	public String getInstruction_title() {
		return instruction_title;
	}
	
	public void setInstruction_title(String instruction_title) {
		this.instruction_title = instruction_title;
	}
	
	public String getInstruction_content() {
		return instruction_content;
	}
	
	public void setInstruction_content(String instruction_content) {
		this.instruction_content = instruction_content;
	}
	
	public Date getInstruction_created_at() {
		return instruction_created_at;
	}
	
	public void setInstruction_created_at(Date instruction_created_at) {
		this.instruction_created_at = instruction_created_at;
	}
	
}
