package com.GDT.Model;

/*
 * 团队课题阶段管理对象
 * @author zero
 */
public class ProjectStageManage {
	private int teamId;			//团队编号
	private int stageId;		//阶段编号
	private String startTime;	//阶段开始时间
	private String endTime;		//阶段结束时间
	private String auditResult;	//阶段审核处理
	private double auditScore;	//阶段成绩
	private String auditInfor;	//审核评语
	private String auditTime;	//阶段审核时间
	
	public int getTeamId() {
		return teamId;
	}
	public void setTeamId(int teamId) {
		this.teamId = teamId;
	}
	public int getStageId() {
		return stageId;
	}
	public void setStageId(int stageId) {
		this.stageId = stageId;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getAuditResult() {
		return auditResult;
	}
	public void setAuditResult(String auditResult) {
		this.auditResult = auditResult;
	}
	public double getAuditScore() {
		return auditScore;
	}
	public void setAuditScore(double auditScore) {
		this.auditScore = auditScore;
	}
	public String getAuditTime() {
		return auditTime;
	}
	public void setAuditTime(String auditTime) {
		this.auditTime = auditTime;
	}
	public String getAuditInfor() {
		return auditInfor;
	}
	public void setAuditInfor(String auditInfor) {
		this.auditInfor = auditInfor;
	}
}
