package com.GDT.Model;

/*
 * 学生用户对象模型
 * @author zero
 */
public class Student extends CommonSchoolUser{
	private CommonSchoolUser commonUser;//用户账号信息
	
	private String realName;	//真实姓名
	private String college;		//院系类别
	private String major;		//专业类别
	private String age;			//年龄
	private String sex;			//性别
	private String idCard;		//身份证号码
	private String address;		//地址
	private String phone;		//手机
	private String email;		//email
	private String qq;			//qq号码
	private String resume;		//个人简介
	private int teamId;			//团队编号
	private String saveresult;	//信息是否已填写
	private int relationId;		//关系编号
	private String replyResult;	//团队回复信息内容（指的是当前的关系信息对象）
	
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getCollege() {
		return college;
	}
	public void setCollege(String college) {
		this.college = college;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getResume() {
		return resume;
	}
	public void setResume(String resume) {
		this.resume = resume;
	}
	public int getTeamId() {
		return teamId;
	}
	public void setTeamId(int teamId) {
		this.teamId = teamId;
	}
	public String getSaveresult() {
		return saveresult;
	}
	public void setSaveresult(String saveresult) {
		this.saveresult = saveresult;
	}
	public CommonSchoolUser getCommonUser() {
		return commonUser;
	}
	public void setCommonUser(CommonSchoolUser commonUser) {
		this.commonUser = commonUser;
	}
	public String getReplyResult() {
		return replyResult;
	}
	public void setReplyResult(String replyResult) {
		this.replyResult = replyResult;
	}
	public int getRelationId() {
		return relationId;
	}
	public void setRelationId(int relationId) {
		this.relationId = relationId;
	}
}
