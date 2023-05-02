package semiproject.dak.member.model;

public class NoticeBoardDTO {

	private int Note_id;
	private String Note_title;
	private String Note_content;
	private String Note_created_at;
	
	
	//기본 생성자
	public NoticeBoardDTO() {
			
	}
		
	public NoticeBoardDTO(int nid, String ntitle, String ncontent, String ncreate) {
		this.Note_id = nid;
		this.Note_title = ntitle;
		this.Note_content = ncontent;
		this.Note_created_at = ncreate;
	}

	public int getNote_id() {
		return Note_id;
	}

	public void setNote_id(int note_id) {
		this.Note_id = note_id;
	}

	public String getNote_title() {
		return Note_title;
	}

	public void setNote_title(String note_title) {
		this.Note_title = note_title;
	}

	public String getNote_content() {
		return Note_content;
	}

	public void setNote_content(String note_content) {
		this.Note_content = note_content;
	}

	public String getNote_created_at() {
		return Note_created_at;
	}

	public void setNote_created_at(String note_created_at) {
		this.Note_created_at = note_created_at;
	}
	
	
	
	
	
	
	
}
