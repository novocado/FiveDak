package semiproject.dak.member.model;

public class MemberDTO {
	
	private int mbrNum;
	private String mbrId;
	private String mbrPwd;
	private String mbrName;
	private String mbrMobile;
	private String mbrEmail;
	private int mbrPoint;
	private String mbrGender;
	private String mbrBirth;
	private String mbrPostcode;
	private String mbrAddress;
	private String mbrDetailAddress;
	private int mbrTierId; // 나중에 수정 MembershipDTO 만들거나 조인으로 그냥 바로 받아오거나?
	private MembershipTierDTO mbrTier;
	
	private int mbrPurchaseAmount;
	private String mbrRegDate;
	private int mbrStatus;
	private int mbrIdle;
	private String mbrLastPwdChanged;
	private int mbrOrderCount;
	
	




	///
	private boolean requirePwdChange = false;
	
	//기본 생성자
	public MemberDTO() {
		
	}
	
	public MemberDTO(String userid, String pwd) {
		this.mbrId = userid;
		this.mbrPwd = pwd;
	}
	
	
	public MemberDTO(String userid, String pwd, String name, String email, String mobile, String postcode,
			String address, String detailAddress, String gender, String birth) {
		this.mbrId = userid;
		this.mbrPwd = pwd;
		this.mbrName = name;
		this.mbrEmail = email;
		this.mbrMobile = mobile;
		this.mbrPostcode = postcode;
		this.mbrAddress = address;
		this.mbrDetailAddress = detailAddress;
		this.mbrGender = gender;
		this.mbrBirth = birth;
		
	}


	public MemberDTO(String userid, String password, String email, String mobile, String postcode, String address,
			String detailAddress, String gender, String birthday) {
		this.mbrId = userid;
		this.mbrPwd = password;
		this.mbrEmail = email;
		this.mbrMobile = mobile;
		this.mbrPostcode = postcode;
		this.mbrAddress = address;
		this.mbrDetailAddress = detailAddress;
		this.mbrGender = gender;
		this.mbrBirth = birthday;
	}



	public int getMbrNum() {
		return mbrNum;
	}
	public void setMbrNum(int mbrNum) {
		this.mbrNum = mbrNum;
	}
	public String getMbrId() {
		return mbrId;
	}
	public void setMbrId(String mbrId) {
		this.mbrId = mbrId;
	}
	public String getMbrPwd() {
		return mbrPwd;
	}
	public void setMbrPwd(String mbrPwd) {
		this.mbrPwd = mbrPwd;
	}
	public String getMbrName() {
		return mbrName;
	}
	public void setMbrName(String mbrName) {
		this.mbrName = mbrName;
	}
	
	public String getMbrEmail() {
		return mbrEmail;
	}
	public void setMbrEmail(String mbrEmail) {
		this.mbrEmail = mbrEmail;
	}
	public int getMbrPoint() {
		return mbrPoint;
	}
	public void setMbrPoint(int mbrPoint) {
		this.mbrPoint = mbrPoint;
	}
	public String getMbrGender() {
		return mbrGender;
	}
	public void setMbrGender(String mbrGender) {
		this.mbrGender = mbrGender;
	}
	public String getMbrBirth() {
		return mbrBirth;
	}
	public void setMbrBirth(String mbrBirth) {
		this.mbrBirth = mbrBirth;
	}
	
	public String getMbrAddress() {
		return mbrAddress;
	}
	public void setMbrAddress(String mbrAddress) {
		this.mbrAddress = mbrAddress;
	}
	public String getMbrDetailAddress() {
		return mbrDetailAddress;
	}
	public void setMbrDetailAddress(String mbrDetailAddress) {
		this.mbrDetailAddress = mbrDetailAddress;
	}
	
	public String getMbrRegDate() {
		return mbrRegDate;
	}
	public void setMbrRegDate(String mbrRegDate) {
		this.mbrRegDate = mbrRegDate;
	}
	public int getMbrStatus() {
		return mbrStatus;
	}
	public void setMbrStatus(int mbrStatus) {
		this.mbrStatus = mbrStatus;
	}
	public int getMbrIdle() {
		return mbrIdle;
	}
	public void setMbrIdle(int mbrIdle) {
		this.mbrIdle = mbrIdle;
	}
	public String getMbrLastPwdChanged() {
		return mbrLastPwdChanged;
	}
	public void setMbrLastPwdChanged(String mbrLastPwdChanged) {
		this.mbrLastPwdChanged = mbrLastPwdChanged;
	}
	
	public String getMbrMobile() {
		return mbrMobile;
	}
	public void setMbrMobile(String mbrMobile) {
		this.mbrMobile = mbrMobile;
	}

	public String getMbrPostcode() {
		return mbrPostcode;
	}
	public void setMbrPostcode(String mbrPostcode) {
		this.mbrPostcode = mbrPostcode;
	}
	
	public int getMbrTierId() {
		return mbrTierId;
	}


	public void setMbrTierId(int mbrTierId) {
		this.mbrTierId = mbrTierId;
	}


	public int getMbrPurchaseAmount() {
		return mbrPurchaseAmount;
	}


	public void setMbrPurchaseAmount(int mbrPurchaseAmount) {
		this.mbrPurchaseAmount = mbrPurchaseAmount;
	}
	
	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}
	
	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}



	public MembershipTierDTO getMbrTier() {
		return mbrTier;
	}




	public void setMbrTier(MembershipTierDTO mbrTier) {
		this.mbrTier = mbrTier;
	}
	
	public int getMbrOrderCount() {
		return mbrOrderCount;
	}

	public void setMbrOrderCount(int mbrOrderCount) {
		this.mbrOrderCount = mbrOrderCount;
	}

	
	
}
