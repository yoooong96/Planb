package dto.member;

import java.sql.Date;
import java.sql.Timestamp;

public class UserDto {
	private long userId;				// 회원 고유번호
	private String loginId;				// 로그인 아이디
	private String password;			// 비밀번호
	private String name;				// 이름
	private String nickname;			// 닉네임
	private String email;				// 이메일
	private String phone;				// 전화번호
	private Date birthDate;				// 생년월일
	private String profileImg;			// 프로필 이미지
	private String bio;					// 소개글
	private String role;				// 회원 역할
	private String status;				// 계정 상태
	private Timestamp lastLoginAt;		// 최근 로그인
	private Timestamp createdAt;		// 가입 일자
	private Timestamp updatedAt;		// 수정 일자
	private String profileVisibility;	// 프로필 공개범위
	private Boolean showLikedItinerary;	// 좋아요 일정 공개
	private Boolean notifyLike;			// 좋아요 알림
	private Boolean notifyComment;		// 댓글 알림
	private Boolean notifyPost;			// 게시글 알림
	private String region; 				// 사용자 지역
	private String postcode;			// 사용자 우편번호
	private String address; 			// 사용자 주소
	private String addressDetail; 		// 사용자 상세 주소
	private String provider; 			// 로그인 유형(로컬 or google)
	private String providerUserId;		// 구글 로그인 고유 아이디
	
	public UserDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public UserDto(long userId, String loginId, String password, String name, String nickName, String email,
			String phone, Date birthDate, String profileImg, String bio, String role, String status,
			Timestamp lastLoginAt, Timestamp createdAt, Timestamp updatedAt, String profileVisibility,
			Boolean showLikedItinerary, Boolean notifyLike, Boolean notifyComment, Boolean notifyPost, String region,
			String postcode, String address, String addressDetail) {
		super();
		this.userId = userId;
		this.loginId = loginId;
		this.password = password;
		this.name = name;
		this.nickname = nickName;
		this.email = email;
		this.phone = phone;
		this.birthDate = birthDate;
		this.profileImg = profileImg;
		this.bio = bio;
		this.role = role;
		this.status = status;
		this.lastLoginAt = lastLoginAt;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.profileVisibility = profileVisibility;
		this.showLikedItinerary = showLikedItinerary;
		this.notifyLike = notifyLike;
		this.notifyComment = notifyComment;
		this.notifyPost = notifyPost;
		this.region = region;
		this.postcode = postcode;
		this.address = address;
		this.addressDetail = addressDetail;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public String getBio() {
		return bio;
	}
	public void setBio(String bio) {
		this.bio = bio;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Timestamp getLastLoginAt() {
		return lastLoginAt;
	}
	public void setLastLoginAt(Timestamp lastLoginAt) {
		this.lastLoginAt = lastLoginAt;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
	public String getProfileVisibility() {
		return profileVisibility;
	}
	public void setProfileVisibility(String profileVisibility) {
		this.profileVisibility = profileVisibility;
	}
	public Boolean getShowLikedItinerary() {
		return showLikedItinerary;
	}
	public void setShowLikedItinerary(Boolean showLikedItinerary) {
		this.showLikedItinerary = showLikedItinerary;
	}
	public Boolean getNotifyLike() {
		return notifyLike;
	}
	public void setNotifyLike(Boolean notifyLike) {
		this.notifyLike = notifyLike;
	}
	public Boolean getNotifyComment() {
		return notifyComment;
	}
	public void setNotifyComment(Boolean notifyComment) {
		this.notifyComment = notifyComment;
	}
	public Boolean getNotifyPost() {
		return notifyPost;
	}
	public void setNotifyPost(Boolean notifyPost) {
		this.notifyPost = notifyPost;
	}
	
	public String getRegion() {
		return region;
	}
	
	public void setRegion(String region) {
		this.region = region;
	}
	
	public String getNickName() {
		return nickname;
	}
	public void setNickName(String nickname) {
		this.nickname = nickname;
	}
	public String getProviderUserId() {
		return providerUserId;
	}
	public void setProviderUserId(String providerUserId) {
		this.providerUserId = providerUserId;
	}
	
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddressDetail() {
		return addressDetail;
	}
	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}
	
	
	public String getProvider() {
		return provider;
	}

	public void setProvider(String provider) {
		this.provider = provider;
	}

	@Override
	public String toString() {
		return "UserDto [userId=" + userId + ", loginId=" + loginId + ", password=" + password + ", name=" + name
				+ ", NickName=" + nickname + ", email=" + email + ", phone=" + phone + ", birthDate=" + birthDate
				+ ", profileImg=" + profileImg + ", bio=" + bio + ", role=" + role + ", status=" + status
				+ ", lastLoginAt=" + lastLoginAt + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt
				+ ", profileVisibility=" + profileVisibility + ", showLikedItinerary=" + showLikedItinerary
				+ ", notifyLike=" + notifyLike + ", notifyComment=" + notifyComment + ", notifyPost=" + notifyPost
				+ ", region=" + region + ", postcode=" + postcode + ", address=" + address + ", addressDetail="
				+ addressDetail + "]";
	}
	
	
	
}
