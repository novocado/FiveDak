package semiproject.dak.member.model;

public class AdminQNADTO {

	private int ANSWER_ID;
	private int QNA_ID;
	private String ANSWER_MEMBER_ID;
	private String ANSWER_CONTENT;
	private String ANSWER_CREATED_AT;
	
	//기본 생성자
	public AdminQNADTO() {
		
	}
	
	public AdminQNADTO(int ANSWER_ID, int QNA_ID, String ANSWER_MEMBER_ID,
				String ANSWER_CONTENT, String ANSWER_CREATED_AT) {
	this.QNA_ID = QNA_ID;
	this.ANSWER_ID = ANSWER_ID;
	this.ANSWER_MEMBER_ID = ANSWER_MEMBER_ID;
	this.ANSWER_CONTENT = ANSWER_CONTENT;
	this.ANSWER_CREATED_AT = ANSWER_CREATED_AT;
	
	}

	public int getANSWER_ID() {
		return ANSWER_ID;
	}

	public void setANSWER_ID(int aNSWER_ID) {
		ANSWER_ID = aNSWER_ID;
	}

	public int getQNA_ID() {
		return QNA_ID;
	}

	public void setQNA_ID(int qNA_ID) {
		QNA_ID = qNA_ID;
	}

	public String getANSWER_MEMBER_ID() {
		return ANSWER_MEMBER_ID;
	}

	public void setANSWER_MEMBER_ID(String aNSWER_MEMBER_ID) {
		ANSWER_MEMBER_ID = aNSWER_MEMBER_ID;
	}

	public String getANSWER_CONTENT() {
		return ANSWER_CONTENT;
	}

	public void setANSWER_CONTENT(String aNSWER_CONTENT) {
		ANSWER_CONTENT = aNSWER_CONTENT;
	}

	public String getANSWER_CREATED_AT() {
		return ANSWER_CREATED_AT;
	}

	public void setANSWER_CREATED_AT(String aNSWER_CREATED_AT) {
		ANSWER_CREATED_AT = aNSWER_CREATED_AT;
	}
		
	
	
	
	
}
