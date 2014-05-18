package com.GDT.Model;

import java.sql.Date;

/*
 * 课题详细审核信息
 * @author zero
 */
public class ProjectAuditInfor {
	private int auditId;		//审核编号
	private int projectId;		//需要审核的课题编号
	private int auditerId1;		//课题审核人员1的id
	private String auditerName1;//审核人姓名
	private Date time1;			//审核时间
	private String deal1;		//审核处理
	private String remark1;		//审核评语
	private int auditerId2;		//课题审核人员2的id
	private String auditerName2;
	private Date time2;			//审核时间
	private String deal2;		//审核处理
	private String remark2;		//审核评语
	private int auditerId3;		//课题审核人员3的id
	private String auditerName3;
	private Date time3;			//审核时间
	private String deal3;		//审核处理
	private String remark3;		//审核评语
	private String auditStage;	//审核状态
	
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}
	public int getAuditerId1() {
		return auditerId1;
	}
	public void setAuditerId1(int auditerId1) {
		this.auditerId1 = auditerId1;
	}
	public String getDeal1() {
		return deal1;
	}
	public void setDeal1(String deal1) {
		this.deal1 = deal1;
	}
	public String getRemark1() {
		return remark1;
	}
	public void setRemark1(String remark1) {
		this.remark1 = remark1;
	}
	public int getAuditerId2() {
		return auditerId2;
	}
	public void setAuditerId2(int auditerId2) {
		this.auditerId2 = auditerId2;
	}
	public String getDeal2() {
		return deal2;
	}
	public void setDeal2(String deal2) {
		this.deal2 = deal2;
	}
	public String getRemark2() {
		return remark2;
	}
	public void setRemark2(String remark2) {
		this.remark2 = remark2;
	}
	public int getAuditerId3() {
		return auditerId3;
	}
	public void setAuditerId3(int auditerId3) {
		this.auditerId3 = auditerId3;
	}
	public String getDeal3() {
		return deal3;
	}
	public void setDeal3(String deal3) {
		this.deal3 = deal3;
	}
	public String getRemark3() {
		return remark3;
	}
	public void setRemark3(String remark3) {
		this.remark3 = remark3;
	}
	public String getAuditerName1() {
		return auditerName1;
	}
	public void setAuditerName1(String auditerName1) {
		this.auditerName1 = auditerName1;
	}
	public String getAuditerName2() {
		return auditerName2;
	}
	public void setAuditerName2(String auditerName2) {
		this.auditerName2 = auditerName2;
	}
	public String getAuditerName3() {
		return auditerName3;
	}
	public void setAuditerName3(String auditerName3) {
		this.auditerName3 = auditerName3;
	}
	public int getAuditId() {
		return auditId;
	}
	public void setAuditId(int auditId) {
		this.auditId = auditId;
	}
	public String getAuditStage() {
		return auditStage;
	}
	public void setAuditStage(String auditStage) {
		this.auditStage = auditStage;
	}
	public Date getTime1() {
		return time1;
	}
	public void setTime1(Date time1) {
		this.time1 = time1;
	}
	public Date getTime2() {
		return time2;
	}
	public void setTime2(Date time2) {
		this.time2 = time2;
	}
	public Date getTime3() {
		return time3;
	}
	public void setTime3(Date time3) {
		this.time3 = time3;
	}
}
