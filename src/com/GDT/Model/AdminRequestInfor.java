package com.GDT.Model;

/*
 * 学校管理人员对于系统问题提交的问题信息类
 * @author zero
 */
public class AdminRequestInfor {
	private int id;					//请求问题编号
	private int requestId;			//请求发送人
	private String requestContent;	//问题内容
	private String requestTime;		//发送时间
	private int answerId;			//回复人员编号
	private String answerContent;	//回复问题内容
	private String answerTime;		//回复时间
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public int getAnswerId() {
		return answerId;
	}
	public void setAnswerId(int answerId) {
		this.answerId = answerId;
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
}
