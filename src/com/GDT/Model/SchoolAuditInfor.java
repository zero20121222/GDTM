package com.GDT.Model;

/*
 * 学校信息审核信息类
 * @author zero
 */
public class SchoolAuditInfor {
	private int schoolId;		//学校编号用于检索学校对象信息
	private String operate1;	//审核操作处理1
	private int auditerId1;		//审核人员编号1
	private	String remark1;		//审核评价处理1
	private String time1;		//审核时间1
	private String operate2;	//审核操作处理2
	private int auditerId2;		//审核人员编号2
	private	String remark2;		//审核评价处理2
	private String time2;		//审核时间2
	private String operate3;	//审核操作处理3
	private int auditerId3;		//审核人员编号3
	private	String remark3;		//审核评价处理3
	private String time3;		//审核时间3
	private String auditResult;	//审核结果（W:待审核,T:审核通过,F:审核失败）
	
	public int getSchoolId() {
		return schoolId;
	}
	public void setSchoolId(int schoolId) {
		this.schoolId = schoolId;
	}
	public String getOperate1() {
		return operate1;
	}
	public void setOperate1(String operate1) {
		this.operate1 = operate1;
	}
	public int getAuditerId1() {
		return auditerId1;
	}
	public void setAuditerId1(int auditerId1) {
		this.auditerId1 = auditerId1;
	}
	public String getRemark1() {
		return remark1;
	}
	public void setRemark1(String remark1) {
		this.remark1 = remark1;
	}
	public String getTime1() {
		return time1;
	}
	public void setTime1(String time1) {
		this.time1 = time1;
	}
	public String getOperate2() {
		return operate2;
	}
	public void setOperate2(String operate2) {
		this.operate2 = operate2;
	}
	public int getAuditerId2() {
		return auditerId2;
	}
	public void setAuditerId2(int auditerId2) {
		this.auditerId2 = auditerId2;
	}
	public String getRemark2() {
		return remark2;
	}
	public void setRemark2(String remark2) {
		this.remark2 = remark2;
	}
	public String getTime2() {
		return time2;
	}
	public void setTime2(String time2) {
		this.time2 = time2;
	}
	public String getOperate3() {
		return operate3;
	}
	public void setOperate3(String operate3) {
		this.operate3 = operate3;
	}
	public int getAuditerId3() {
		return auditerId3;
	}
	public void setAuditerId3(int auditerId3) {
		this.auditerId3 = auditerId3;
	}
	public String getRemark3() {
		return remark3;
	}
	public void setRemark3(String remark3) {
		this.remark3 = remark3;
	}
	public String getTime3() {
		return time3;
	}
	public void setTime3(String time3) {
		this.time3 = time3;
	}
	public String getAuditResult() {
		return auditResult;
	}
	public void setAuditResult(String auditResult) {
		this.auditResult = auditResult;
	}
}
