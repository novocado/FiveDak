package semiproject.dak.member.model;

public class MemberQNADTO {

	private int QNA_ID;
	private String QNA_MEMBER_ID;
	private String QUESTION_TITLE;
	private String QUESTION_CONTENT;
	private String QUESTION_CREATED_AT;
	
	
	//기본 생성자
	public MemberQNADTO() {
		
	}

	public MemberQNADTO(int QNA_ID, String QNA_MEMBER_ID, String QUESTION_TITLE,
            			String QUESTION_CONTENT, String QUESTION_CREATED_AT) {
		this.QNA_ID = QNA_ID;
		this.QNA_MEMBER_ID = QNA_MEMBER_ID;
		this.QUESTION_TITLE = QUESTION_TITLE;
		this.QUESTION_CONTENT = QUESTION_CONTENT;
		this.QUESTION_CREATED_AT = QUESTION_CREATED_AT;
		
	}

	public int getQNA_ID() {
		return QNA_ID;
	}

	public void setQNA_ID(int qNA_ID) {
		QNA_ID = qNA_ID;
	}

	public String getQNA_MEMBER_ID() {
		return QNA_MEMBER_ID;
	}

	public void setQNA_MEMBER_ID(String qNA_MEMBER_ID) {
		QNA_MEMBER_ID = qNA_MEMBER_ID;
	}

	public String getQUESTION_TITLE() {
		return QUESTION_TITLE;
	}

	public void setQUESTION_TITLE(String qUESTION_TITLE) {
		QUESTION_TITLE = qUESTION_TITLE;
	}

	public String getQUESTION_CONTENT() {
		return QUESTION_CONTENT;
	}

	public void setQUESTION_CONTENT(String qUESTION_CONTENT) {
		QUESTION_CONTENT = qUESTION_CONTENT;
	}

	public String getQUESTION_CREATED_AT() {
		return QUESTION_CREATED_AT;
	}

	public void setQUESTION_CREATED_AT(String qUESTION_CREATED_AT) {
		QUESTION_CREATED_AT = qUESTION_CREATED_AT;
	}
	
}
