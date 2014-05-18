package com.GDT.Model;

import java.sql.Date;

/*
 * 学生团队信息类
 * @author 
 */
public class TeamInfor {
	private int id;			//团队编号
	private int managerId;	//队长编号
	private int projectId;	//课题编号
	private Date createTime;//团队创建时间
	private int stageNum;	//课题进度编号
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getManagerId() {
		return managerId;
	}
	public void setManagerId(int managerId) {
		this.managerId = managerId;
	}
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public int getStageNum() {
		return stageNum;
	}
	public void setStageNum(int stageNum) {
		this.stageNum = stageNum;
	}
}
