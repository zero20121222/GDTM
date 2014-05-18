package com.GDT.Model;

import java.sql.Date;

/*
 * 团队关系信息
 * @author zero
 */
public class TeamRelation {
	private int id;			
	private int teamId;			//团队编号
	private String teamerType;	//队员类型
	private int teamerId;		//队员编号
	private String teamerName;	//队员真实姓名
	private String answer;		//回复结果
	private String answerInfor;	//回复信息
	private Date answerTime;	//回复时间
	
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
	public int getTeamerId() {
		return teamerId;
	}
	public void setTeamerId(int teamerId) {
		this.teamerId = teamerId;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getTeamerType() {
		return teamerType;
	}
	public void setTeamerType(String teamerType) {
		this.teamerType = teamerType;
	}
	public String getAnswerInfor() {
		return answerInfor;
	}
	public void setAnswerInfor(String answerInfor) {
		this.answerInfor = answerInfor;
	}
	public Date getAnswerTime() {
		return answerTime;
	}
	public void setAnswerTime(Date answerTime) {
		this.answerTime = answerTime;
	}
	public String getTeamerName() {
		return teamerName;
	}
	public void setTeamerName(String teamerName) {
		this.teamerName = teamerName;
	}
}
