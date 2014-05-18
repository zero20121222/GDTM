package com.GDT.Model;

/*
 * 课题阶段阶段性信息
 * @author 
 */
public class ProjectStageInfor {
	private int id;				//阶段编号（用于方便检索课题阶段对象）
	private int projectId;		//课题编号
	private int stageId;		//课题的第几个阶段
	private String stageName;	//阶段名称
	private String stageDemand;	//阶段要求
	private String stageFiles;	//阶段资料
	private int timeLimit;		//时间限定
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}
	public int getStageId() {
		return stageId;
	}
	public void setStageId(int stageId) {
		this.stageId = stageId;
	}
	public String getStageName() {
		return stageName;
	}
	public void setStageName(String stageName) {
		this.stageName = stageName;
	}
	public String getStageDemand() {
		return stageDemand;
	}
	public void setStageDemand(String stageDemand) {
		this.stageDemand = stageDemand;
	}
	public String getStageFiles() {
		return stageFiles;
	}
	public void setStageFiles(String stageFiles) {
		this.stageFiles = stageFiles;
	}
	public int getTimeLimit() {
		return timeLimit;
	}
	public void setTimeLimit(int timeLimit) {
		this.timeLimit = timeLimit;
	}
}
