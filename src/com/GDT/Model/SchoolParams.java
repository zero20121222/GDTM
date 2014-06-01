package com.GDT.Model;

/*
 * 学校控制参数设定类
 * @author zero
 */
public class SchoolParams {
	private int schoolId;			//学校编号
	private String inforOvert;		//学校信息是否公开设置
	private int parterUpperLimit;	//课题参与人数上限
	private int stageUpperTime;		//课题阶段总时间上限
	private int auditNumber;		//审核课题人数
	private int adoptNumber;		//审核通过人数
	private int stageUpperLimit;	//课题阶段上限
	private int stageFloorLimit;	//课题阶段下限
	private int proSelectLimit;		//课题所选次数上限
	private int guideTeamLimit;		//指导团队上限
	private String updateAccount;	//是否可更改账户
	private String coverFiles;		//是否覆盖用户数据源文件|数据库链接
    private int noticeNum;          //学校通告信息显示条数
	
	public int getStageUpperTime() {
		return stageUpperTime;
	}
	public void setStageUpperTime(int stageUpperTime) {
		this.stageUpperTime = stageUpperTime;
	}
	public int getSchoolId() {
		return schoolId;
	}
	public void setSchoolId(int schoolId) {
		this.schoolId = schoolId;
	}
	public String getInforOvert() {
		return inforOvert;
	}
	public void setInforOvert(String inforOvert) {
		this.inforOvert = inforOvert;
	}
	public int getAuditNumber() {
		return auditNumber;
	}
	public void setAuditNumber(int auditNumber) {
		this.auditNumber = auditNumber;
	}
	public int getAdoptNumber() {
		return adoptNumber;
	}
	public void setAdoptNumber(int adoptNumber) {
		this.adoptNumber = adoptNumber;
	}
	public int getStageUpperLimit() {
		return stageUpperLimit;
	}
	public void setStageUpperLimit(int stageUpperLimit) {
		this.stageUpperLimit = stageUpperLimit;
	}
	public int getStageFloorLimit() {
		return stageFloorLimit;
	}
	public void setStageFloorLimit(int stageFloorLimit) {
		this.stageFloorLimit = stageFloorLimit;
	}
	public int getProSelectLimit() {
		return proSelectLimit;
	}
	public void setProSelectLimit(int proSelectLimit) {
		this.proSelectLimit = proSelectLimit;
	}
	public int getGuideTeamLimit() {
		return guideTeamLimit;
	}
	public void setGuideTeamLimit(int guideTeamLimit) {
		this.guideTeamLimit = guideTeamLimit;
	}
	public String getUpdateAccount() {
		return updateAccount;
	}
	public void setUpdateAccount(String updateAccount) {
		this.updateAccount = updateAccount;
	}
	public String getCoverFiles() {
		return coverFiles;
	}
	public void setCoverFiles(String coverFiles) {
		this.coverFiles = coverFiles;
	}
	public int getParterUpperLimit() {
		return parterUpperLimit;
	}
	public void setParterUpperLimit(int parterUpperLimit) {
		this.parterUpperLimit = parterUpperLimit;
	}
    public int getNoticeNum() {
        return noticeNum;
    }
    public void setNoticeNum(int noticeNum) {
        this.noticeNum = noticeNum;
    }
}
