package com.GDT.Model;

/*
 * 学校课题审核人员对象模型
 * @author zero
 */
public class SchoolAuditer extends SchoolManageUser{
	private String realName;	//真实姓名
	private String college;		//院系类别
	private String position;	//职位
	private String degree;		//学位
	private String office;		//办公室
	private String age;			//年龄
	private String sex;			//性别
	private String idCard;		//身份证号码
	private String address;		//地址
	private String phone;		//手机
	private String email;		//email
	private String qq;			//qq号码
	private String resume;		//个人简介
	private String saveresult;	//信息是否已填写
	
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
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getDegree() {
		return degree;
	}
	public void setDegree(String degree) {
		this.degree = degree;
	}
	public String getOffice() {
		return office;
	}
	public void setOffice(String office) {
		this.office = office;
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
	public String getSaveresult() {
		return saveresult;
	}
	public void setSaveresult(String saveresult) {
		this.saveresult = saveresult;
	}
}
