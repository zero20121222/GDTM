package com.GDT.ModelCL;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.GDT.Interface.ProjectStageInterface;
import com.GDT.Model.ProjectInfor;
import com.GDT.Model.ProjectStageGuide;
import com.GDT.Model.ProjectStageInfor;
import com.GDT.Model.ProjectStageManage;
import com.GDT.Model.TeamStageFile;
import com.GDT.util.DBConnection;
import com.GDT.util.DBConnectionInterface;

/**
 * 课题阶段处理类对象
 * @author zero
 */
public class ProjectStageCL implements ProjectStageInterface{
	private DBConnectionInterface connectObj = null;
	private PreparedStatement sta = null;
	private ResultSet res = null;
	
	public Boolean deleteProjectStage(int stageId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean deleteProjectStages(int[] stageIds) {
		// TODO Auto-generated method stub
		return null;
	}

	public ProjectStageInfor queryProjectStage(int stageId) {
		ProjectStageInfor stage = null;
		String sql = "select Id,课题编号,阶段编号,阶段名称,阶段要求,阶段资料,时间限定 from 毕业课题阶段信息 where id=?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, stageId);
			
			res = connectObj.getQueryResultSet();
			if(res.next()){
				stage = new ProjectStageInfor();
				stage.setId(res.getInt(1));
				stage.setProjectId(2);
				stage.setStageId(res.getInt(3));
				stage.setStageName(res.getString(4));
				stage.setStageDemand(res.getString(5));
				stage.setStageFiles(res.getString(6));
				stage.setTimeLimit(res.getInt(7));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return stage;
	}

	public List<ProjectStageInfor> queryProjectStages(int projectId) {
		List<ProjectStageInfor> stages = new ArrayList<ProjectStageInfor>();
		String sql = "select Id,阶段编号,阶段名称,阶段要求,阶段资料,时间限定 from 毕业课题阶段信息 where 课题编号=?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, projectId);
			
			res = connectObj.getQueryResultSet();
			ProjectStageInfor stage = null;
			while(res.next()){
				stage = new ProjectStageInfor();
				stage.setId(res.getInt(1));
				stage.setStageId(res.getInt(2));
				stage.setStageName(res.getString(3));
				stage.setStageDemand(res.getString(4));
				stage.setStageFiles(res.getString(5));
				stage.setTimeLimit(res.getInt(6));
				
				stages.add(stage);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return stages;
	}

	public Boolean saveProjectStage(ProjectStageInfor stageInfor) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * @see com.GDT.Interface.ProjectStageInterface#saveProjectStages(int, java.util.List)
	 * 实现课题阶段的保存操作
	 */
	public Boolean saveProjectStages(List<ProjectStageInfor> stageList) {
		Boolean saveStage = false;
		String sql = "insert into 毕业课题阶段信息(课题编号,阶段编号,阶段名称,阶段要求,阶段资料,时间限定) values";
		for(int i=0;i<stageList.size();i++){
			sql += i != (stageList.size()-1) ? "(?,?,?,?,?,?)," : "(?,?,?,?,?,?);";
		}
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			ProjectStageInfor stageInfor = null;
			for(int i=0;i<stageList.size();i++){
				stageInfor = stageList.get(i);
				
				sta.setInt((i*6+1), stageInfor.getProjectId());
				sta.setInt((i*6+2), stageInfor.getStageId());
				sta.setString((i*6+3), stageInfor.getStageName());
				sta.setString((i*6+4), stageInfor.getStageDemand());
				sta.setString((i*6+5), stageInfor.getStageFiles());
				sta.setInt((i*6+6), stageInfor.getTimeLimit());
			}
			
			int result = sta.executeUpdate();
			saveStage = result >= 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return saveStage;
	}

	public Boolean updateProjectStage(ProjectStageInfor stageInfor) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * 实现课题阶段数据的更改操作(操作-》1.先实现删除原来的课题信息2.再装载当前更改后的信息到数据库)为此使用批量处理操作
	 * @see com.GDT.Interface.ProjectStageInterface#updateProjectStages(java.util.List)
	 * @author zero
	 */
	public Boolean updateProjectStages(List<ProjectStageInfor> stageList) {
		Boolean updateStage = false;
		
		//删除原有的课题阶段信息内容
		String deleteSql = "delete from 毕业课题阶段信息 where 课题编号 = ?";
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(deleteSql);
			sta.setInt(1, stageList.get(1).getProjectId());
			sta.executeUpdate();
			
			//处理新的更改数据导入导数据库中
			String sql = "insert into 毕业课题阶段信息(课题编号,阶段编号,阶段名称,阶段要求,阶段资料,时间限定) values";
			for(int i=0;i<stageList.size();i++){
				sql += i != (stageList.size()-1) ? "(?,?,?,?,?,?)," : "(?,?,?,?,?,?);";
			}
			sta = connectObj.getStatement(sql);
			
			ProjectStageInfor stageInfor = null;
			for(int i=0;i<stageList.size();i++){
				stageInfor = stageList.get(i);
				
				sta.setInt((i*6+1), stageInfor.getProjectId());
				sta.setInt((i*6+2), stageInfor.getStageId());
				sta.setString((i*6+3), stageInfor.getStageName());
				sta.setString((i*6+4), stageInfor.getStageDemand());
				sta.setString((i*6+5), stageInfor.getStageFiles());
				sta.setInt((i*6+6), stageInfor.getTimeLimit());
			}
			
			updateStage = sta.executeUpdate() >= 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return updateStage;
	}

	/**
	 * 根据课题阶段编号获取阶段文件
	 * @see com.GDT.Interface.ProjectStageInterface#queryStageFilePath(int)
	 * @author zero
	 */
	public String queryStageFilePath(int stageId){
		String filePath = "";
		String sql = "select 学校Id,出题人Id,课题编号,阶段资料 from 毕业课题详细信息 left join 毕业课题阶段信息 on 毕业课题详细信息.Id = 毕业课题阶段信息.课题编号 where 毕业课题阶段信息.Id = ?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, stageId);
			
			res = connectObj.getQueryResultSet();
			if(res.next()){
				filePath = "ProjectInfor/"+res.getInt(1)+"/"+res.getInt(2)+"/"+res.getInt(3)+"/"+res.getString(4);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return filePath;
	}
	
	public String queryStageNames(int userId){
		JSONArray jsonArray = new JSONArray();
		String sql = "select 毕业课题阶段信息.Id,阶段编号,阶段名称,毕业课题阶段信息.课题编号 from 毕业课题阶段信息,学生详细信息,团队信息 "
					+"where 毕业课题阶段信息.课题编号=团队信息.题目编号 and 学生详细信息.团队编号=团队信息.Id and 学生详细信息.Id=? order by 阶段编号;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, userId);
			
			res = connectObj.getQueryResultSet();
			JSONObject newInfor = null;
			while(res.next()){
				newInfor = new JSONObject();
				newInfor.put("stageId", res.getInt(1));
				newInfor.put("stageNum", res.getInt(2));
				newInfor.put("stageName", res.getString(3));
				newInfor.put("proId", res.getInt(4));
				
				jsonArray.put(newInfor);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return jsonArray.toString();
	}
	
	public String queryStageNamesByTea(int userId){
		JSONArray jsonArray = new JSONArray();
		String sql = "select 毕业课题阶段信息.Id,阶段编号,CONCAT(阶段名称,'(',学生详细信息.真实姓名,')') as 阶段名称,毕业课题阶段信息.课题编号,团队信息.Id "
					+"from 毕业课题阶段信息,团队人员关系,团队信息,学生详细信息,团队进度管理 "
					+"where 毕业课题阶段信息.课题编号=团队信息.题目编号 and 团队信息.Id=团队人员关系.团队编号 and 团队进度管理.团队Id=团队信息.Id "
					+"and 团队进度管理.阶段Id=毕业课题阶段信息.Id and 团队信息.队长编号=学生详细信息.Id "
					+"and 团队人员关系.队员编号=? and 团队人员关系.回复='T' order by 团队信息.Id,阶段编号;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, userId);
			
			res = connectObj.getQueryResultSet();
			JSONObject newInfor = null;
			while(res.next()){
				newInfor = new JSONObject();
				newInfor.put("stageId", res.getInt(1));
				newInfor.put("stageNum", res.getInt(2));
				newInfor.put("stageName", res.getString(3));
				newInfor.put("proId", res.getInt(4));
				newInfor.put("teamId", res.getInt(5));
				
				jsonArray.put(newInfor);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return jsonArray.toString();
	}
	
	public ProjectInfor queryProjectInfor(int stageId){
		ProjectInfor project = null;
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,课题目的,主要内容,图片信息,课题文件下载,创建时间,课题被选择次数,题目状态 "
					+"from 毕业课题详细信息,教师详细信息,毕业课题阶段信息 where 教师详细信息.Id=出题人Id and 毕业课题详细信息.Id=课题编号 and " 
					+"毕业课题阶段信息.id=?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, stageId);
			res = connectObj.getQueryResultSet();
			if(res.next()){
				project = new ProjectInfor();
				
				project.setId(res.getInt(1));
				project.setSchoolId(res.getInt(2));
				project.setProjectName(res.getString(3));
				project.setCreaterId(res.getInt(4));
				project.setCreaterName(res.getString(5));
				project.setPartNum(res.getInt(6));
				project.setWorkload(res.getString(7));
				project.setCollege(res.getString(8));
				project.setHardNum(res.getInt(9));
				project.setPurpose(res.getString(10));
				project.setMainContent(res.getString(11));
				project.setPicture(res.getString(12));
				project.setProjectFile(res.getString(13));
				project.setCreateDate(res.getDate(14));
				project.setSelectNum(res.getInt(15));
				project.setStage(res.getString(16));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return project;
	}
	
	public Boolean createStageGuide(int stageId , int userId, String request){
		Boolean createRes = false;
		
		try{
			String sql = "insert into 团队阶段性指导信息(团队Id,阶段Id,提问人员Id,问题内容,提问时间) value((select 团队编号 from 学生详细信息 where Id=?),?,?,?,NOW());";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, userId);
			this.sta.setInt(2, stageId);
			this.sta.setInt(3, userId);
			this.sta.setString(4, request);
			
			createRes = this.sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return createRes; 
	}
	
	public Boolean answerStageGuide(int guideId , String answerInfor){
		Boolean updateRes = false;
		
		try{
			String sql = "update 团队阶段性指导信息 set 教师回复信息=?,回复时间=Now() where Id=?;";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setString(1, answerInfor);
			this.sta.setInt(2, guideId);
			
			updateRes = this.sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return updateRes; 
	}
	
	public List<ProjectStageGuide> queryStageGuides(int stageId , int pageNum){
		List<ProjectStageGuide> stageList = new ArrayList<ProjectStageGuide>();
		
		//默认显示3条记录
		String sql = "select 团队阶段性指导信息.Id,团队Id,阶段Id,提问人员Id,头像,学生详细信息.真实姓名,问题内容,提问时间,教师详细信息.Id,教师详细信息.真实姓名,教师回复信息,团队阶段性指导信息.回复时间 "
					+"from 团队阶段性指导信息,学生详细信息,教师详细信息,学生教师账号,团队人员关系 where 提问人员Id=学生详细信息.Id and 团队人员关系.团队编号=团队Id and 回复='T' and 队员类型='T' "
					+"and 队员编号=教师详细信息.Id and 学生教师账号.Id=学生详细信息.Id and 阶段Id=? order by 团队阶段性指导信息.回复时间 desc,团队阶段性指导信息.id desc limit ?,?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, stageId);
			sta.setInt(2, pageNum*3);
			sta.setInt(3, 3);
			res = connectObj.getQueryResultSet();
			ProjectStageGuide stageGuide = null;
			while(res.next()){
				stageGuide = new ProjectStageGuide();
				
				stageGuide.setId(res.getInt(1));
				stageGuide.setTeamId(res.getInt(2));
				stageGuide.setStageId(res.getInt(3));
				stageGuide.setRequestId(res.getInt(4));
				stageGuide.setRequestHead(res.getString(5));
				stageGuide.setRequestName(res.getString(6));
				stageGuide.setRequestContent(res.getString(7));
				stageGuide.setRequestTime(res.getString(8));
				stageGuide.setAnswerId(res.getInt(9));
				stageGuide.setAnswerName(res.getString(10));
				stageGuide.setAnswerContent(res.getString(11));
				stageGuide.setAnswerTime(res.getString(12));
				
				stageList.add(stageGuide);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return stageList;
	}
	
	public List<ProjectStageGuide> queryDealGuides(int stageId , int pageNum){
		List<ProjectStageGuide> stageList = new ArrayList<ProjectStageGuide>();
		
		//默认显示3条记录
		String sql = "select 团队阶段性指导信息.Id,团队Id,阶段Id,提问人员Id,头像,学生详细信息.真实姓名,问题内容,提问时间,教师详细信息.Id,教师详细信息.真实姓名,教师回复信息,团队阶段性指导信息.回复时间 "
					+"from 团队阶段性指导信息,学生详细信息,教师详细信息,学生教师账号,团队人员关系 where 提问人员Id=学生详细信息.Id and 团队人员关系.团队编号=团队Id and 回复='T' and 队员类型='T' "
					+"and 队员编号=教师详细信息.Id and 学生教师账号.Id=学生详细信息.Id and 团队阶段性指导信息.回复时间 is not null and 阶段Id=? order by 团队阶段性指导信息.回复时间 desc,团队阶段性指导信息.id desc limit ?,?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, stageId);
			sta.setInt(2, pageNum*3);
			sta.setInt(3, 3);
			res = connectObj.getQueryResultSet();
			ProjectStageGuide stageGuide = null;
			while(res.next()){
				stageGuide = new ProjectStageGuide();
				
				stageGuide.setId(res.getInt(1));
				stageGuide.setTeamId(res.getInt(2));
				stageGuide.setStageId(res.getInt(3));
				stageGuide.setRequestId(res.getInt(4));
				stageGuide.setRequestHead(res.getString(5));
				stageGuide.setRequestName(res.getString(6));
				stageGuide.setRequestContent(res.getString(7));
				stageGuide.setRequestTime(res.getString(8));
				stageGuide.setAnswerId(res.getInt(9));
				stageGuide.setAnswerName(res.getString(10));
				stageGuide.setAnswerContent(res.getString(11));
				stageGuide.setAnswerTime(res.getString(12));
				
				stageList.add(stageGuide);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return stageList;
	}
	
	public List<ProjectStageGuide> queryStageGuides(int stageId){
		List<ProjectStageGuide> stageList = new ArrayList<ProjectStageGuide>();
		
		//默认显示3条记录
		String sql = "select 团队阶段性指导信息.Id,团队Id,阶段Id,提问人员Id,头像,学生详细信息.真实姓名,问题内容,提问时间,教师详细信息.Id,教师详细信息.真实姓名,教师回复信息,团队阶段性指导信息.回复时间 "
					+"from 团队阶段性指导信息,学生详细信息,教师详细信息,学生教师账号,团队人员关系 where 提问人员Id=学生详细信息.Id and 团队人员关系.团队编号=团队Id and 回复='T' and 队员类型='T' "
					+"and 队员编号=教师详细信息.Id and 学生教师账号.Id=学生详细信息.Id and 阶段Id=? and 团队阶段性指导信息.回复时间 is null order by 团队阶段性指导信息.id desc;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, stageId);
			res = connectObj.getQueryResultSet();
			ProjectStageGuide stageGuide = null;
			while(res.next()){
				stageGuide = new ProjectStageGuide();
				
				stageGuide.setId(res.getInt(1));
				stageGuide.setTeamId(res.getInt(2));
				stageGuide.setStageId(res.getInt(3));
				stageGuide.setRequestId(res.getInt(4));
				stageGuide.setRequestHead(res.getString(5));
				stageGuide.setRequestName(res.getString(6));
				stageGuide.setRequestContent(res.getString(7));
				stageGuide.setRequestTime(res.getString(8));
				stageGuide.setAnswerId(res.getInt(9));
				stageGuide.setAnswerName(res.getString(10));
				stageGuide.setAnswerContent(res.getString(11));
				stageGuide.setAnswerTime(res.getString(12));
				
				stageList.add(stageGuide);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return stageList;
	}
	
	public int queryStageGuideNum(int stageId){
		int guideNum = 0;
		
		try{
			String sql = "select count(*) from 团队阶段性指导信息 where 阶段Id=?";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, stageId);
			
			this.res = this.connectObj.getQueryResultSet();
			if(this.res.next()){
				guideNum = this.res.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return guideNum;
	}
	
	public int queryDealGuideNum(int stageId){
		int guideNum = 0;
		
		try{
			String sql = "select count(*) from 团队阶段性指导信息 where 回复时间 is not null and 阶段Id=?";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, stageId);
			
			this.res = this.connectObj.getQueryResultSet();
			if(this.res.next()){
				guideNum = this.res.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return guideNum;
	}
	
	public ProjectStageManage queryStageManage(int stageId){
		ProjectStageManage stageManage = null;
		
		try{
			String sql = "select * from 团队进度管理 where 阶段Id=?";
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, stageId);
			res = connectObj.getQueryResultSet();
			if(res.next()){
				stageManage = new ProjectStageManage();
				
				stageManage.setTeamId(res.getInt(1));
				stageManage.setStageId(res.getInt(2));
				stageManage.setStartTime(res.getString(3));
				stageManage.setEndTime(res.getString(4));
				stageManage.setAuditResult(res.getString(5));
				stageManage.setAuditScore(res.getDouble(6));
				stageManage.setAuditInfor(res.getString(7));
				stageManage.setAuditTime(res.getString(8));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return stageManage;
	}
	
	public Boolean createStageFile(TeamStageFile stageFile){
		Boolean result = false;
		
		try{
			String sql = "insert into 团队阶段文档信息(团队Id,阶段Id,上传文件名称,上传人员Id,上传文件路径,上传文件时间) value(?,?,?,?,?,NOW());";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			this.sta = this.connectObj.getStatement(sql);
			
			this.sta.setInt(1 , stageFile.getTeamId());
			this.sta.setInt(2 , stageFile.getStageId());
			this.sta.setString(3 , stageFile.getFileName());
			this.sta.setInt(4 , stageFile.getSenderId());
			this.sta.setString(5 , stageFile.getFileUrl());
			
			result = this.sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}
	
	public List<TeamStageFile> queryStageFiles(int stageId){
		List<TeamStageFile> fileList = new ArrayList<TeamStageFile>();
		
		String sql = "select 团队Id,阶段Id,上传文件名称,上传人员Id,真实姓名,上传文件路径,上传文件时间 "
					+"from 团队阶段文档信息,学生详细信息 where 上传人员Id=Id and 阶段Id=? order by 上传文件时间 desc";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, stageId);
			res = connectObj.getQueryResultSet();
			TeamStageFile stageFile = null;
			while(res.next()){
				stageFile = new TeamStageFile();
				
				stageFile.setTeamId(res.getInt(1));
				stageFile.setStageId(res.getInt(2));
				stageFile.setFileName(res.getString(3));
				stageFile.setSenderId(res.getInt(4));
				stageFile.setSenderName(res.getString(5));
				stageFile.setFileUrl(res.getString(6));
				stageFile.setSendTime(res.getString(7));
				
				fileList.add(stageFile);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return fileList;
	}
	
	public TeamStageFile queryStageFile(int teamId , int stageId, String fileName){
		TeamStageFile stageFile = null;
		String sql = "select 团队Id,阶段Id,上传文件名称,上传人员Id,上传文件路径,上传文件时间 "
			+"from 团队阶段文档信息 where 团队Id=? and 阶段Id=? and 上传文件名称=?";

		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, teamId);
			sta.setInt(2, stageId);
			sta.setString(3, fileName);
			res = connectObj.getQueryResultSet();
			if(res.next()){
				stageFile = new TeamStageFile();
				
				stageFile.setTeamId(res.getInt(1));
				stageFile.setStageId(res.getInt(2));
				stageFile.setFileName(res.getString(3));
				stageFile.setSenderId(res.getInt(4));
				stageFile.setFileUrl(res.getString(5));
				stageFile.setSendTime(res.getString(6));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return stageFile;
	}

	public Boolean existStartStage(int stageId) {
		Boolean exist = false;
		
		try{
			String sql = "select 阶段Id from 团队进度管理 where 阶段Id=?";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1 , stageId);
			
			this.res = this.connectObj.getQueryResultSet();
			exist = this.res.next();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return exist;
	}

	public Boolean startProjectStage(int stageId , int userId) {
		Boolean result = false;
		
		try{
			String sql = "insert into 团队进度管理(团队Id,阶段Id,阶段开始时间) value((select 团队编号 from 学生详细信息 where Id=?),?,NOW());";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1 , userId);
			this.sta.setInt(2 , stageId);
			
			result = this.sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}
	
	public String querySTByTeamId(int teamId){
		String startTime = null;
		
		try{
			String sql = "select MIN(阶段开始时间) from 团队进度管理 where 团队Id=?";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1 , teamId);
			
			this.res = this.connectObj.getQueryResultSet();
			if(this.res.next()){
				startTime = this.res.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return startTime;
	}
	
	public String queryStartTime(int userId){
		String startTime = null;
		
		try{
			String sql = "select MIN(阶段开始时间) from 团队进度管理 where 团队Id=(select 团队编号 from 学生详细信息 where id=?)";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1 , userId);
			
			this.res = this.connectObj.getQueryResultSet();
			if(this.res.next()){
				startTime = this.res.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return startTime;
	}
	
	public List<ProjectStageManage> queryStageManages(int userId){
		List<ProjectStageManage> manageList = new ArrayList<ProjectStageManage>();

		try{
			String sql = "select 团队Id,阶段Id,阶段开始时间,阶段结束时间 from 团队进度管理 where 团队Id=(select 团队编号 from 学生详细信息 where Id=?);";
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, userId);
			res = connectObj.getQueryResultSet();
			ProjectStageManage stageManage = null;
			while(res.next()){
				stageManage = new ProjectStageManage();
				
				stageManage.setTeamId(res.getInt(1));
				stageManage.setStageId(res.getInt(2));
				stageManage.setStartTime(res.getString(3));
				stageManage.setEndTime(res.getString(4));
				
				manageList.add(stageManage);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return manageList;
	}
	
	public List<ProjectStageManage> queryStageMSByTeamId(int teamId){
		List<ProjectStageManage> manageList = new ArrayList<ProjectStageManage>();

		try{
			String sql = "select 团队Id,阶段Id,阶段开始时间,阶段结束时间 from 团队进度管理 where 团队Id=?;";
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, teamId);
			res = connectObj.getQueryResultSet();
			ProjectStageManage stageManage = null;
			while(res.next()){
				stageManage = new ProjectStageManage();
				
				stageManage.setTeamId(res.getInt(1));
				stageManage.setStageId(res.getInt(2));
				stageManage.setStartTime(res.getString(3));
				stageManage.setEndTime(res.getString(4));
				
				manageList.add(stageManage);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return manageList;
	}
	
	public Boolean startStageAudit(int teamId , int stageId){
		Boolean result = false;
		
		try{
			String sql = "select 阶段Id from 团队进度管理 where 阶段审核结果='S' and 团队Id=? and 阶段Id=?;";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			this.sta = this.connectObj.getStatement(sql);
			
			this.sta.setInt(1 , teamId);
			this.sta.setInt(2 , stageId);
			this.res = this.connectObj.getQueryResultSet();
			if(this.res.next()){//当前审核状态是否是已开始
				sql = "update 团队进度管理 set 阶段结束时间=Now(),阶段审核结果='W' where 团队Id=? and 阶段Id=?;";
				
				this.sta = this.connectObj.getStatement(sql);
				
				this.sta.setInt(1 , teamId);
				this.sta.setInt(2 , stageId);
				
				result = this.sta.executeUpdate() == 1 ? true : false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}
	
	public Boolean commitStageAudit(int teamId , int stageId, String auditRes, String auditInfor){
		Boolean result = false;
		
		try{
			String sql = "update 团队进度管理 set 阶段审核结果=?,阶段审核评语=?,阶段审核时间=Now() where 团队Id=? and 阶段Id=?;";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			this.sta = this.connectObj.getStatement(sql);
			
			this.sta.setString(1 , auditRes);
			this.sta.setString(2 , auditInfor);
			this.sta.setInt(3 , teamId);
			this.sta.setInt(4 , stageId);
			
			result = this.sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}
}