package com.GDT.ModelCL;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.GDT.Factory.SchoolManageFactory;
import com.GDT.Factory.UserFactory;
import com.GDT.Interface.ProjectInterface;
import com.GDT.Interface.SchoolManageFactoryInterface;
import com.GDT.Interface.SchoolParamsInterface;
import com.GDT.Interface.TeacherInterface;
import com.GDT.Interface.UserFactoryInterface;
import com.GDT.Model.ProjectAuditInfor;
import com.GDT.Model.ProjectInfor;
import com.GDT.Model.Teacher;
import com.GDT.util.*;

/**
 * 课题信息处理类对象
 * @author zero
 */
public class ProjectInforCL extends ProjectStageCL implements ProjectInterface{
	private DBConnectionInterface connectObj = null;
	private PreparedStatement sta = null;
	private ResultSet res = null;
	private int pageNow = 0;
	
	public ProjectInforCL(){}
	
	/**
	 * 设定该对象为页面分页操作对象构造方法
	 * @param pageNow
	 * 需要显示的页面编号
	 */
	public ProjectInforCL(int pageNow){
		this.pageNow = pageNow;
	}
	
	public int getPageNow(){
		return this.pageNow;
	}
	
	public void setPageNow(int pageNow){
		this.pageNow = pageNow;
	}
	
	
	/**
	 * 实现课题信息内容的更改操作
	 * @see com.GDT.Interface.ProjectInterface#alterProjectInfor(com.GDT.Model.ProjectInfor)
	 * @author zero
	 */
	public Boolean alterProjectInfor(ProjectInfor project) {
		Boolean result = false;
		String sql = "update 毕业课题详细信息 set 学校Id=?,毕业课题名称=?,出题人Id=?,参与人数限定=?,工作量大小=?,院系限定=?,难易程度=?,课题目的=?,主要内容=?,图片信息=?,课题文件下载=? where Id=?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, project.getSchoolId());
			sta.setString(2, project.getProjectName());
			sta.setInt(3, project.getCreaterId());
			sta.setInt(4, project.getPartNum());
			sta.setString(5, project.getWorkload());
			sta.setString(6, project.getCollege());
			sta.setInt(7, project.getHardNum());
			sta.setString(8, project.getPurpose());
			sta.setString(9, project.getMainContent());
			sta.setString(10, project.getPicture());
			sta.setString(11, project.getProjectFile());
			sta.setInt(12, project.getId());
			
			result = sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return result;
	}
	
	/**
	 * @see com.GDT.Interface.ProjectInterface#queryMinProjectYear(int)
	 * 返回最早创建时间
	 * @author zero
	 */
	public int queryMinProjectYear(int schoolId){
		int year = 0;
		String sql = "select 创建时间 from 毕业课题详细信息 where 学校Id=? order by 创建时间 limit 1;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, schoolId);
			
			res = connectObj.getQueryResultSet();
			java.sql.Date createDate = res.next() ? res.getDate(1) : null;
			
			if(createDate != null){
				int dateMonth = GDTDate.getSqlDateInfor(GDTDate.DATE_MONTH, createDate)+1;
				int dateYear = GDTDate.getSqlDateInfor(GDTDate.DATE_YEAR, createDate);
				
				year = dateMonth > 7 ? dateYear+1 : dateYear;
			}else{
				java.util.Date nowTime = GDTDate.getUtilDate();
				int dateMonth = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, nowTime)+1;
				int dateYear = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, nowTime);
				
				year = dateMonth > 7 ? dateYear+1 : dateYear;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return year;
	}
	
	/*
	 * 通过学校编号获取最早通过审核的课题时间
	 * @see com.GDT.Interface.ProjectInterface#queryMinAuditedYear(int)
	 * @author zero
	 */
	public int queryMinAuditedYear(int schoolId){
		int year = 0;
		String sql = "select 创建时间 from 毕业课题详细信息 where 学校Id=? and 题目状态='T' order by 创建时间 limit 1;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, schoolId);
			
			res = connectObj.getQueryResultSet();
			java.sql.Date createDate = res.next() ? res.getDate(1) : null;
			
			if(createDate != null){
				int dateMonth = GDTDate.getSqlDateInfor(GDTDate.DATE_MONTH, createDate)+1;
				int dateYear = GDTDate.getSqlDateInfor(GDTDate.DATE_YEAR, createDate);
				
				year = dateMonth > 7 ? dateYear+1 : dateYear;
			}else{
				java.util.Date nowTime = GDTDate.getUtilDate();
				int dateMonth = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, nowTime)+1;
				int dateYear = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, nowTime);
				
				year = dateMonth > 7 ? dateYear+1 : dateYear;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return year;
	}
	
	/**
	 * @see com.GDT.Interface.ProjectInterface#queryTeacherMinYear(int)
	 * 通过用户编号查询该用户的最早课题创建时间
	 * @author zero
	 */
	public int queryTeacherMinYear(int teacherId){
		int year = 0;
		String sql = "select 创建时间 from 毕业课题详细信息 where 出题人Id=? order by 创建时间 limit 1;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, teacherId);
			
			res = connectObj.getQueryResultSet();
			java.sql.Date createDate = res.next() ? res.getDate(1) : null;
			
			if(createDate != null){
				int dateMonth = GDTDate.getSqlDateInfor(GDTDate.DATE_MONTH, createDate)+1;
				int dateYear = GDTDate.getSqlDateInfor(GDTDate.DATE_YEAR, createDate);
				
				year = dateMonth > 7 ? dateYear+1 : dateYear;
			}else{
				year = 2012;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return year;
	}
	
	/**
	 * @see com.GDT.Interface.ProjectInterface#deleteProjectInfor(int)
	 * 用于删除课题将课题存放到回收站
	 * @author zero
	 * true:已存在,false:未存在
	 */
	public Boolean deleteProjectInfor(int projectId) {
		Boolean deleteResult = false;
		String sql = "update 毕业课题详细信息 set 题目状态='D' where id=?";
		
		try{
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			this.sta = this.connectObj.getStatement(sql);
			
			this.sta.setInt(1, projectId);
			deleteResult = this.sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return deleteResult;
	}
	
	/**
	 * @see com.GDT.Interface.ProjectInterface#deleteProjectTotally(int)
	 * 用于完全删除课题编号指定的课题
	 * @author zero
	 */
	public Boolean deleteProjectTotally(int projectId){
		Boolean result = false;
		String sql = "delete from 毕业课题详细信息 where id=?";
		
		try{
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			this.sta = this.connectObj.getStatement(sql);
			
			this.sta.setInt(1, projectId);
			result = this.sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}
	
	/**
	 * @see com.GDT.Interface.ProjectInterface#recoverProject(int)
	 * 从回收站中恢复课题信息
	 * @author zero
	 */
	public Boolean recoverProject(int projectId){
		Boolean result = false;
		String sql = "update 毕业课题详细信息 set 题目状态='S' where id=? ";
		
		try{
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, projectId);
			
			result = this.sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}
	
	/**
	 * @see com.GDT.Interface.ProjectInterface#ifExistName(int, java.lang.String)
	 * 用于检查课题名称是否在该学校已被使用
	 * @author zero
	 * true:已存在,false:未存在
	 */
	public Boolean ifExistName(int schoolId, String name) {
		Boolean save = false;
		String sql = "select Id from 毕业课题详细信息 where 学校Id=? and 毕业课题名称=?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, schoolId);
			sta.setString(2, name);
			
			res = connectObj.getQueryResultSet();
			if(res.next()){
				save = true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return save;
	}
	
	/**
	 * 查询毕业课题的详细信息
	 * @see com.GDT.Interface.ProjectInterface#queryProjectInfor(int)
	 * @author zero
	 */
	public ProjectInfor queryProjectInfor(int projectId){
		ProjectInfor project = null;
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,课题目的,主要内容,图片信息,课题文件下载,创建时间,课题被选择次数,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id where 毕业课题详细信息.Id = ?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, projectId);
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
	
	/**
	 * 获取课题创建者的详细个人信息
	 * @see com.GDT.Interface.ProjectInterface#queryProjectCreaterInfor(int)
	 * @author zero
	 */
	public Teacher queryProjectCreaterInfor(int createrId){
		UserFactoryInterface factory = new UserFactory();
		TeacherInterface teacherCL = factory.createTeacherCL();
		
		return teacherCL.doSelect(createrId);
	}
	
	/**
	 * 获取学校的课题的上传文件内容信息
	 * @see com.GDT.Interface.ProjectInterface#queryProjectFilePath(int)
	 * @author zero
	 */
	public String queryProjectFilePath(int projectId){
		String filePath = "";
		String sql = "select 学校Id,出题人Id,课题文件下载 from 毕业课题详细信息 where Id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, projectId);
			res = connectObj.getQueryResultSet();
			if(res.next()){
				filePath = "ProjectInfor/"+res.getInt(1)+"/"+res.getInt(2)+"/"+res.getString(3);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return filePath;
	}
	
	/*
	 * 查询课题阶段内容是否已存在
	 * @see com.GDT.Interface.ProjectInterface#ifExistProjectStages(int)
	 * @author zero
	 */
	public Boolean ifExistProjectStages(int projectId){
		Boolean result = false;
		String sql = "select count(Id) from 毕业课题阶段信息 where 课题编号=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, projectId);
			res = connectObj.getQueryResultSet();
			if(res.next()){
				result = res.getInt(1) > 0 ? true : false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return result;
	}
	
	/**
	 * 查询毕业课题的详细信息返回JSON数据格式
	 * @see com.GDT.Interface.ProjectInterface#queryProjectInforJSON(int)
	 * @author zero
	 */
	public String queryProjectInforJSON(int projectId){
		JSONArray jsonArray = new JSONArray();
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,课题目的,主要内容,图片信息,课题文件下载,创建时间,课题被选择次数,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id where 毕业课题详细信息.Id = ?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, projectId);
			res = connectObj.getQueryResultSet();
			JSONObject json = null;
			if(res.next()){
				json = new JSONObject();
				
				json.put("id", res.getInt(1));
				json.put("schoolId", res.getInt(2));
				json.put("projectName", res.getString(3));
				json.put("createrId", res.getInt(4));
				json.put("createrName", res.getString(5));
				json.put("partNum", res.getInt(6));
				json.put("workload", res.getString(7));
				json.put("college", res.getString(8));
				json.put("hardNum", res.getInt(9));
				json.put("purpose" , res.getString(10));
				json.put("mainContent" , res.getString(11));
				json.put("picture", res.getString(12));
				json.put("projectFile", res.getString(13));
				json.put("createTime", res.getDate(14));
				json.put("selectNum", res.getInt(15));
				json.put("stage", res.getString(16));
				jsonArray.put(json);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return jsonArray.toString();
	}
	
	public List<ProjectInfor> queryAllProjectInfor(int userId, String type) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 当前课题审核情况
	 * @see com.GDT.Interface.ProjectInterface#queryAuditInfor(int)
	 * @author zero
	 */
	public ProjectAuditInfor queryAuditInfor(int projectId){
		ProjectAuditInfor auditInfor = null;
		String sql = "select * from audit_project_infor where 审核状态='N' and 课题Id=?";
		
		try{
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, projectId);
			
			this.res = this.connectObj.getQueryResultSet();
			if(res.next()){
				auditInfor = new ProjectAuditInfor();
				
				auditInfor.setAuditId(this.res.getInt(1));
				auditInfor.setProjectId(this.res.getInt(2));
				auditInfor.setAuditerId1(this.res.getInt(3));
				auditInfor.setAuditerName1(this.res.getString(4));
				auditInfor.setTime1(this.res.getDate(5));
				auditInfor.setDeal1(this.res.getString(6));
				auditInfor.setRemark1(this.res.getString(7));
				auditInfor.setAuditerId2(this.res.getInt(8));
				auditInfor.setAuditerName2(this.res.getString(9));
				auditInfor.setTime2(this.res.getDate(10));
				auditInfor.setDeal2(this.res.getString(11));
				auditInfor.setRemark2(this.res.getString(12));
				auditInfor.setAuditerId3(this.res.getInt(13));
				auditInfor.setAuditerName3(this.res.getString(14));
				auditInfor.setTime3(this.res.getDate(15));
				auditInfor.setDeal3(this.res.getString(16));
				auditInfor.setRemark3(this.res.getString(17));
				auditInfor.setAuditStage(this.res.getString(18));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return auditInfor;
	}
	
	/**
	 * 查询全部审核信息
	 * @see com.GDT.Interface.ProjectInterface#queryAllAuditInfor(int)
	 * @author zero
	 */
	public List<ProjectAuditInfor> queryAllAuditInfor(int projectId){
		List<ProjectAuditInfor> auditList = new ArrayList<ProjectAuditInfor>();
		
		try{
			String sql = "select * from audit_project_infor where 课题Id=? order by 审核状态";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, projectId);
			
			this.res = this.connectObj.getQueryResultSet();
			ProjectAuditInfor auditInfor = null;
			while(this.res.next()){
				auditInfor = new ProjectAuditInfor();
				
				auditInfor.setAuditId(this.res.getInt(1));
				auditInfor.setProjectId(this.res.getInt(2));
				auditInfor.setAuditerId1(this.res.getInt(3));
				auditInfor.setAuditerName1(this.res.getString(4));
				auditInfor.setTime1(this.res.getDate(5));
				auditInfor.setDeal1(this.res.getString(6));
				auditInfor.setRemark1(this.res.getString(7));
				auditInfor.setAuditerId2(this.res.getInt(8));
				auditInfor.setAuditerName2(this.res.getString(9));
				auditInfor.setTime2(this.res.getDate(10));
				auditInfor.setDeal2(this.res.getString(11));
				auditInfor.setRemark2(this.res.getString(12));
				auditInfor.setAuditerId3(this.res.getInt(13));
				auditInfor.setAuditerName3(this.res.getString(14));
				auditInfor.setTime3(this.res.getDate(15));
				auditInfor.setDeal3(this.res.getString(16));
				auditInfor.setRemark3(this.res.getString(17));
				auditInfor.setAuditStage(this.res.getString(18));
				
				auditList.add(auditInfor);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return auditList;
	}

	public String queryProjectInfors(int userId, String type) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * @see com.GDT.Interface.ProjectInterface#saveProjectInfor(com.GDT.Model.ProjectInfor)
	 * 保存用户输入的详细课题信息
	 */
	public Boolean saveProjectInfor(ProjectInfor project) {
		Boolean save = false;
		String sql = "insert into 毕业课题详细信息(学校Id,毕业课题名称,出题人Id,参与人数限定,工作量大小,院系限定,难易程度,课题目的,主要内容,图片信息,课题文件下载,创建时间,题目状态) value(?,?,?,?,?,?,?,?,?,?,?,?,?);";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, project.getSchoolId());
			sta.setString(2, project.getProjectName());
			sta.setInt(3, project.getCreaterId());
			sta.setInt(4, project.getPartNum());
			sta.setString(5, project.getWorkload());
			sta.setString(6, project.getCollege());
			sta.setInt(7, project.getHardNum());
			sta.setString(8, project.getPurpose());
			sta.setString(9, project.getMainContent());
			sta.setString(10, project.getPicture());
			sta.setString(11, project.getProjectFile());
			sta.setDate(12, project.getCreateDate());
			sta.setString(13, "S");//将课题对象定义为保存状态
			
			int result = sta.executeUpdate();
			save = result == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return save;
	}

	/**
	 * @see com.GDT.Interface.ProjectInterface#queryProjectId(int, java.lang.String)
	 * 获取课题编号信息
	 */
	public int queryProjectId(int schoolId , String projectName){
		int projectId = 0;
		String sql = "select Id from 毕业课题详细信息 where 学校Id=? and 毕业课题名称=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, schoolId);
			sta.setString(2, projectName);
			
			res = connectObj.getQueryResultSet();
			if(res.next()){
				projectId = res.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return projectId;
	}
	
	/**
	 * 将课题再次提交审核
	 * @see com.GDT.Interface.ProjectInterface#commitAuditAgain(int)
	 * @author zero
	 */
	public Boolean commitAuditAgain(int projectId){
		Boolean result = false;
		
		try{
			String sql = "update 毕业课题详细信息 set 题目状态='W' where id=?";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, projectId);
			
			result = this.sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}
	
	/**
	 * 判断用户准备提交的课题信息是否完整
	 * @see com.GDT.Interface.ProjectInterface#checkProjectCompleted(int)
	 * @author zero
	 */
	public int checkProjectCompleted(int projectId){
		int result = ProjectInterface.INFORNOPROJECT;
		String sql = "select count(*),课题阶段上限,课题阶段下限 from 毕业课题阶段信息,毕业课题详细信息,学校界面的系统参数设置 "
					+" where 毕业课题阶段信息.课题编号 = 毕业课题详细信息.Id and 毕业课题详细信息.学校Id = 学校界面的系统参数设置.学校Id and 课题编号 = ?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, projectId);
			
			res = connectObj.getQueryResultSet();
			if(res.next()){
				int stageNum = res.getInt(1);
				int stageUp = res.getInt(2);
				int stageDown = res.getInt(3);
				
				if(stageNum == 0){
					result = ProjectInterface.INFORNOSTAGE;//没有阶段信息
				}else if(stageNum < stageDown || stageNum > stageUp){
					result = ProjectInterface.STAGENODETAIL;//阶段信息不详细
				}else{
					result = ProjectInterface.INFORCOMPLETE;//数据完整
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return result;
	}
	
	/**
	 * 提交课题审核操作(这个处理使用的是trigger在数据库端是自动的对于数据更改操作->>添加一条待审核操作)
	 * @see com.GDT.Interface.ProjectInterface#submitProjectInfor(int)
	 * @author zero
	 */
	public Boolean submitProjectInfor(int projectId) {
		Boolean submit = false;
		String sql = "update 毕业课题详细信息 set 题目状态='W' where Id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, projectId);
			
			submit = sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return submit;
	}

	/**
	 * @see com.GDT.Interface.ProjectInterface#queryStageParams(int)
	 * 获取学校的课题阶段参数学校系统设定值
	 * @author zero
	 */
	public String queryStageParams(int schoolId) {
		JSONArray jsonArray = new JSONArray();
		SchoolManageFactoryInterface factory = new SchoolManageFactory();
		SchoolParamsInterface paramCL = factory.createSchoolParamsCL();
		
		int[] params = paramCL.projectStageParams(schoolId);
		
		try {
			JSONObject json = new JSONObject();
			json.put("stageUpperTime", params[0]);
			json.put("stageUpperLimit", params[1]);
			json.put("stageFloorLimit", params[2]);
			
			jsonArray.put(json);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		return jsonArray.toString();
	}
	

	/**
	 * 通过课题创建人名来索引分页数据信息
	 * @see com.GDT.Interface.ProjectPagingInterface#pagingByCreateName(int, java.lang.String, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByCreateName(int schoolId,
			String createrName, String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")+" and 真实姓名 like '%"+createrName+"%'"
					+" order by 毕业课题详细信息.Id limit "+this.pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;

		return this.queryProjectPaging(sql);
	}

	public String pagingByCreateNameJSON(int schoolId, String createrName,
			String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")+" and 真实姓名 like '%"+createrName+"%'"
					+" order by 毕业课题详细信息.Id limit "+this.pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;

		return this.queryProjectPagingJSON(sql);
	}

	public Map<String, Integer> getPageNumberByCreateName(int schoolId,
			String createrName, String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select count(毕业课题详细信息.Id) from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")+" and 真实姓名 like '%"+createrName+"%'";
		
		return this.getPageNumbers(sql, PAGINGCOUNTS);
	}

	/**
	 * 根据限定的学院名称
	 * @see com.GDT.Interface.ProjectPagingInterface#pagingByCollege(int, java.lang.String, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByCollege(int schoolId, String collegeName,
			String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")+" and 院系限定 like '%"+collegeName+"%'"
					+" order by 毕业课题详细信息.Id limit "+this.pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;

		return this.queryProjectPaging(sql);
	}

	public String pagingByCollegeJSON(int schoolId, String collegeName,
			String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")+" and 院系限定 like '%"+collegeName+"%'"
					+" order by 毕业课题详细信息.Id limit "+this.pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPagingJSON(sql);
	}

	public Map<String, Integer> getPageNumberByCollege(int schoolId,
			String collegeName, String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select count(毕业课题详细信息.Id) from 毕业课题详细信息 "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")+" and 院系限定 like '%"+collegeName+"%'";

		return this.getPageNumbers(sql, PAGINGCOUNTS);
	}

	/**
	 * 通过课题名称查询分页数据信息
	 * @see com.GDT.Interface.ProjectPagingInterface#pagingByProjectName(int, java.lang.String, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByProjectName(int schoolId,
			String projectName, String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")+" and 毕业课题名称 like '%"+projectName+"%'"
					+" order by 毕业课题详细信息.Id limit "+this.pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;

		return this.queryProjectPaging(sql);
	}

	public String pagingByProjectNameJSON(int schoolId, String projectName,
			String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")+" and 毕业课题名称 like '%"+projectName+"%'"
					+" order by 毕业课题详细信息.Id limit "+this.pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPagingJSON(sql);
	}

	public Map<String, Integer> getPageNumberByProjectName(int schoolId,
			String projectName, String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select count(毕业课题详细信息.Id) from 毕业课题详细信息 "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")+" and 毕业课题名称 like '%"+projectName+"%'";

		return this.getPageNumbers(sql, PAGINGCOUNTS);
	}

	
	/**
	 * 根据课题的限定人数索引分页数据
	 * @see com.GDT.Interface.ProjectPagingInterface#pagingByPartNum(int, int, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByPartNum(int schoolId, int partNum,
			String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")+( partNum == 0 ? " " : " and 参与人数限定="+partNum)
					+" order by 毕业课题详细信息.Id limit "+this.pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPaging(sql);
	}

	public String pagingByPartNumJSON(int schoolId, int partNum,
			String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,,图片信息,课题文件下载,创建时间,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")+( partNum == 0 ? " " : " and 参与人数限定="+partNum)
					+" order by 毕业课题详细信息.Id limit "+this.pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPagingJSON(sql);
	}

	public Map<String, Integer> getPageNumberByPartNum(int schoolId,
			int partNum, String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select count(毕业课题详细信息.Id) from 毕业课题详细信息 "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")+( partNum == 0 ? " " : " and 参与人数限定="+partNum);

		return this.getPageNumbers(sql, PAGINGCOUNTS);
	}

	
	/**
	 * 根据课题的难易程度索引分页数据
	 * @see com.GDT.Interface.ProjectPagingInterface#pagingByHardNum(int, int, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByHardNum(int schoolId, int hardNum,
			String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'" )+( hardNum == 0 ? "" : "and 难易程度="+hardNum)
					+" order by 毕业课题详细信息.Id limit "+this.pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPaging(sql);
	}

	public String pagingByHardNumJSON(int schoolId, int hardNum,
			String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")+( hardNum == 0 ? "" : "and 难易程度="+hardNum)
					+" order by 毕业课题详细信息.Id limit "+this.pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPagingJSON(sql);
	}

	public Map<String, Integer> getPageNumberByHardNum(int schoolId,
			int hardNum, String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select count(毕业课题详细信息.Id) from 毕业课题详细信息 "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")+( hardNum == 0 ? "" : "and 难易程度="+hardNum);

		return this.getPageNumbers(sql, PAGINGCOUNTS);
	}

	
	/**
	 * 获取教师用户的创建的课题分页信息
	 * @see com.GDT.Interface.ProjectPagingInterface#pagingByCreateId(int, java.lang.String)
	 * @author zero
	 * 这个方法后期还需要再添加一个对于delete状态课题的删除在状态外面的操作
	 */
	public List<ProjectInfor> pagingByCreateId(int createrId, String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id "
					+"where 出题人Id="+createrId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='D'")
					+" order by 题目状态 limit "+this.pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPaging(sql);
	}
	
	/**
	 * 获取教师用户的创建的课题分页信息
	 * @see com.GDT.Interface.ProjectPagingInterface#pagingByCreatIdJSON(int, java.lang.String)
	 * @author zero
	 */
	public String pagingByCreatIdJSON(int createrId, String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id "
					+"where 出题人Id="+createrId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='D'")
					+" order by 题目状态 limit "+this.pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
	
		return this.queryProjectPagingJSON(sql);
	}

	/**
	 * 获取课题分页的页面数以及对象数目
	 * @see com.GDT.Interface.ProjectPagingInterface#getPageNumberByCreateId(int, java.lang.String)
	 * @author zero
	 */
	public Map<String, Integer> getPageNumberByCreateId(int createrId, String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select count(Id) from 毕业课题详细信息 where 出题人Id="+createrId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='D'");
		
		return this.getPageNumbers(sql, PAGINGCOUNTS);
	}
	
	/**
	 * 根据学校编号获取分页信息内容
	 * @see com.GDT.Interface.ProjectPagingInterface#pagingBySchoolId(int, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingBySchoolId(int schoolId, String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")
					+" order by 毕业课题详细信息.Id limit "+this.pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPaging(sql);
	}

	public String pagingBySchoolIdJSON(int schoolId, String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id "
					+"where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'")
					+" order by 毕业课题详细信息.Id limit "+this.pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPagingJSON(sql);
	}

	public Map<String, Integer> getPageNumberBySchoolId(int schoolId, String pagingType, int graduateYear) {
		String startTime = (graduateYear-1)+"-08-01";
		String endTime = graduateYear+"-07-31";
		String sql = "select count(Id) from 毕业课题详细信息 where 学校Id="+schoolId+(graduateYear == 0 ? "" : " and 创建时间 between '"+startTime+"' and '"+endTime+"'")
					+(pagingType != null ? " and 题目状态='"+pagingType+"'" : " and 题目状态!='S' and 题目状态!='D'");
		
		System.out.println(sql);
		return this.getPageNumbers(sql, PAGINGCOUNTS);
	}
	
	/**
	 * 创建一个private的sql查询语句操作处理
	 * @param sql
	 * 需要执行的sql语句对象
	 * @return List<ProjectInfor>
	 * 返回一个课题的链表信息对象
	 */
	private List<ProjectInfor> queryProjectPaging(String sql){
		List<ProjectInfor> list = new ArrayList<ProjectInfor>();
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			res = connectObj.getQueryResultSet();
			ProjectInfor project = null;
			while(res.next()){
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
				project.setPicture(res.getString(10));
				project.setProjectFile(res.getString(11));
				project.setCreateDate(res.getDate(12));
				project.setStage(res.getString(13));
				
				list.add(project);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return list;
	}
	
	/**
	 * 创建一个private的sql查询语句操作处理
	 * @param sql
	 * 需要执行的sql语句对象
	 * @return String
	 * 返回一个课题的JSON格式的数据信息对象
	 */
	private String queryProjectPagingJSON(String sql){
		JSONArray jsonArray = new JSONArray();
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			res = connectObj.getQueryResultSet();
			JSONObject json = null;
			while(res.next()){
				json = new JSONObject();
				
				json.put("id", res.getInt(1));
				json.put("schoolId", res.getInt(2));
				json.put("projectName", res.getString(3));
				json.put("createrId", res.getInt(4));
				json.put("createrName", res.getString(5));
				json.put("partNum", res.getInt(6));
				json.put("workload", res.getString(7));
				json.put("college", res.getString(8));
				json.put("hardNum", res.getInt(9));
				json.put("picture", res.getString(10));
				json.put("projectFile", res.getString(11));
				json.put("createTime", res.getDate(12));
				json.put("stage", res.getString(13));
				
				jsonArray.put(json);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return jsonArray.toString();
	}
	
	/**
	 * 获取课题的页面数目&页面对象数目
	 * @param sql
	 * 需要查询的sql语句操作
	 * @param pageCounts
	 * 需要分页的分页数目
	 * @return Map<String , Integer>
	 * 返回一个键值对的操作处理
	 */
	private Map<String , Integer> getPageNumbers(String sql, int pageCounts) {
		Map<String , Integer> params = new HashMap<String , Integer>();
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			res = connectObj.getQueryResultSet();
			if(res.next()){
				int objNumber = res.getInt(1);
				params.put(PAGINGOBJNUMBERS, objNumber);
				params.put(PAGINGPAGENUMBERS, objNumber%PAGINGCOUNTS == 0 ? objNumber/PAGINGCOUNTS : objNumber/PAGINGCOUNTS + 1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return params;
	}
}
