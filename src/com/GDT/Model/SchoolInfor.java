package com.GDT.Model;

/*
 * 学校的详细信息类
 * @author zero
 */
public class SchoolInfor {
	private int id;				//学校编号用于检索学校信息
	private String name;		//学校名称
	private String province;	//学校所在省份
	private String address;		//学校详细地址
	private double size;		//学校大小
	private String foundTime;	//学校创建时间
	private String schoolId;	//学校的全国统一的学校编号
	private String headmaster;	//学校校长名称
	private String phone;		//校长电话号码
	private String eamil;		//学校email
	private String labInfor;	//学校实验室信息
	private String teacherInfor;//学校师资力量
	private int collegeNumber;	//学校院系数目
	private int studentNumber;	//学生数目
	private int teacherNumber;	//教师数目
	private String schoolLevel;	//学校等级
	private String schoolFile;	//学校资料文档
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public double getSize() {
		return size;
	}
	public void setSize(double size) {
		this.size = size;
	}
	public String getFoundTime() {
		return foundTime;
	}
	public void setFoundTime(String foundTime) {
		this.foundTime = foundTime;
	}
	public String getSchoolId() {
		return schoolId;
	}
	public void setSchoolId(String schoolId) {
		this.schoolId = schoolId;
	}
	public String getHeadmaster() {
		return headmaster;
	}
	public void setHeadmaster(String headmaster) {
		this.headmaster = headmaster;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEamil() {
		return eamil;
	}
	public void setEamil(String eamil) {
		this.eamil = eamil;
	}
	public String getLabInfor() {
		return labInfor;
	}
	public void setLabInfor(String labInfor) {
		this.labInfor = labInfor;
	}
	public String getTeacherInfor() {
		return teacherInfor;
	}
	public void setTeacherInfor(String teacherInfor) {
		this.teacherInfor = teacherInfor;
	}
	public int getCollegeNumber() {
		return collegeNumber;
	}
	public void setCollegeNumber(int collegeNumber) {
		this.collegeNumber = collegeNumber;
	}
	public int getStudentNumber() {
		return studentNumber;
	}
	public void setStudentNumber(int studentNumber) {
		this.studentNumber = studentNumber;
	}
	public int getTeacherNumber() {
		return teacherNumber;
	}
	public void setTeacherNumber(int teacherNumber) {
		this.teacherNumber = teacherNumber;
	}
	public String getSchoolLevel() {
		return schoolLevel;
	}
	public void setSchoolLevel(String schoolLevel) {
		this.schoolLevel = schoolLevel;
	}
	public String getSchoolFile() {
		return schoolFile;
	}
	public void setSchoolFile(String schoolFile) {
		this.schoolFile = schoolFile;
	}
}
