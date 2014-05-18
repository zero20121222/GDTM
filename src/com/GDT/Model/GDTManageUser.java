package com.GDT.Model;

/*
 * GDT后台人员账号
 * @author zero
 */
public class GDTManageUser {
	private int id;//用户编号
	private String userName;//用户名
	private String userPassword;//用户密码
	private String userHead;//用户头像
	private String userType;//用户类型
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserHead() {
		return userHead;
	}
	public void setUserHead(String userHead) {
		this.userHead = userHead;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
}
