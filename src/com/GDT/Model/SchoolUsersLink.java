package com.GDT.Model;

/*
 * 学校数据库连接对象
 * @author zero
 */
public class SchoolUsersLink {
	private int id;				//数据源文件编号
	private int schoolId;		//学校编号
	private String linkPath;	//数据源链接路径
	private String name;		//用户名字段
	private String password;	//密码字段
	private String type;		//数据源类型（学生|教师）
	private String ifLoad;		//是否已导入数据到数据库
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSchoolId() {
		return schoolId;
	}
	public void setSchoolId(int schoolId) {
		this.schoolId = schoolId;
	}
	public String getLinkPath() {
		return linkPath;
	}
	public void setLinkPath(String linkPath) {
		this.linkPath = linkPath;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getIfLoad() {
		return ifLoad;
	}
	public void setIfLoad(String ifLoad) {
		this.ifLoad = ifLoad;
	}
}
