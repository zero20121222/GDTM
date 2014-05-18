package com.GDT.Model;

import java.sql.Date;
import java.util.List;

/*
 * 课题详细信息对象
 * @author zero
 */
public class ProjectInfor {
	private int id;									//课题编号
	private int schoolId;							//学校编号
	private String projectName;						//毕业课题名称
	private int createrId;							//出题人Id
	private String createrName;						//出题人真实姓名
	private int partNum;							//参与人数限定
	private String workload;						//工作量大小
	private String college;							//院系限定
	private int hardNum;							//难易程度
	private String purpose;							//课题目的
	private String mainContent;						//主要内容
	private String picture;							//图片信息
	private String projectFile;						//课题文件下载路径
	private Date createDate;						//创建时间
	private int selectNum;							//课题被选择次数
	private String stage;							//课题状态（w:待审核,t:审核通过,f:审核未通过）
	private List<ProjectStageInfor> projectStages;	//这个封装了题目的阶段信息对象链表
	
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
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public int getCreaterId() {
		return createrId;
	}
	public void setCreaterId(int createrId) {
		this.createrId = createrId;
	}
	public int getPartNum() {
		return partNum;
	}
	public void setPartNum(int partNum) {
		this.partNum = partNum;
	}
	public String getWorkload() {
		return workload;
	}
	public void setWorkload(String workload) {
		this.workload = workload;
	}
	public String getCollege() {
		return college;
	}
	public void setCollege(String college) {
		this.college = college;
	}
	public int getHardNum() {
		return hardNum;
	}
	public void setHardNum(int hardNum) {
		this.hardNum = hardNum;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getMainContent() {
		return mainContent;
	}
	public void setMainContent(String mainContent) {
		this.mainContent = mainContent;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public String getProjectFile() {
		return projectFile;
	}
	public void setProjectFile(String projectFile) {
		this.projectFile = projectFile;
	}
	public int getSelectNum() {
		return selectNum;
	}
	public void setSelectNum(int selectNum) {
		this.selectNum = selectNum;
	}
	public String getStage() {
		return stage;
	}
	public void setStage(String stage) {
		this.stage = stage;
	}
	public List<ProjectStageInfor> getProjectStages() {
		return projectStages;
	}
	public void setProjectStages(List<ProjectStageInfor> projectStages) {
		this.projectStages = projectStages;
	}
	public String getCreaterName() {
		return createrName;
	}
	public void setCreaterName(String createrName) {
		this.createrName = createrName;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
}
