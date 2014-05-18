package com.GDT.Model;

/*
 * 课题阶段指导信息类
 * @author zero
 */
public class ProjectStageGuide {
	private int id;					//团队阶段提问编号
	private int teamId;				//团队编号
	private int stageId;			//阶段编号
	private int requestId;			//提问人员编号
	private String requestName;		//提问人员姓名
	private String requestHead;		//提问人员头像
	private String requestContent;	//问题内容
	private String requestTime;		//提问时间
	private int answerId;			//教师编号
	private String answerName;		//教师姓名
	private String answerContent;	//教师回复内容
	private String answerTime;		//回复时间
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
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
	public int getRequestId() {
		return requestId;
	}
	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}
	public String getRequestContent() {
		return requestContent;
	}
	public void setRequestContent(String requestContent) {
		this.requestContent = requestContent;
	}
	public String getRequestTime() {
		return requestTime;
	}
	public void setRequestTime(String requestTime) {
		this.requestTime = requestTime;
	}
	public String getAnswerContent() {
		return answerContent;
	}
	public void setAnswerContent(String answerContent) {
		this.answerContent = answerContent;
	}
	public String getAnswerTime() {
		return answerTime;
	}
	public void setAnswerTime(String answerTime) {
		this.answerTime = answerTime;
	}
	public String getRequestName() {
		return requestName;
	}
	public void setRequestName(String requestName) {
		this.requestName = requestName;
	}
	public int getAnswerId() {
		return answerId;
	}
	public void setAnswerId(int answerId) {
		this.answerId = answerId;
	}
	public String getAnswerName() {
		return answerName;
	}
	public void setAnswerName(String answerName) {
		this.answerName = answerName;
	}
	public String getRequestHead() {
		return requestHead;
	}
	public void setRequestHead(String requestHead) {
		this.requestHead = requestHead;
	}
}
