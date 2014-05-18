package com.GDT.ModelCL;

import java.io.OutputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import com.GDT.Factory.NewsFactory;
import com.GDT.Interface.CommonSUserInterface;
import com.GDT.Interface.NewsFactoryInterface;
import com.GDT.Interface.STNewsInterface;
import com.GDT.Interface.SchoolNewInterface;
import com.GDT.Model.NewInfor;
import com.GDT.Model.ProjectInfor;
import com.GDT.Model.ProjectStageGuide;
import com.GDT.Model.ProjectStageInfor;
import com.GDT.Model.Student;
import com.GDT.util.DBConnection;
import com.GDT.util.DBConnectionInterface;

/**
 * 学校普通对象用户的处理类
 * @author zero
 */
public class CommonSUserCL implements CommonSUserInterface{
	private DBConnectionInterface connectObj = null;
	private PreparedStatement sta = null;
	private ResultSet res = null;
	
	public OutputStream displayStageFile(int fileId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/*
	 * @see com.GDT.Interface.UserInterface#queryTrueName(int)
	 * 获取用户的真实姓名
	 * @author zero
	 */
	public String queryTrueName(int userId){
		String userName = null;
		String sql = "select case when 用户类型 = 'S' then (select 真实姓名 from 学生详细信息 where Id = ?) "
					+"when 用户类型 = 'T' then (select 真实姓名 from 教师详细信息 where Id = ?) "
					+"end as 真实姓名 "
					+"from 学生教师账号 where Id = ?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1 , userId);
			sta.setInt(2 , userId);
			sta.setInt(3 , userId);
			
			res = connectObj.getQueryResultSet();
			if(res.next()){
				userName = res.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return userName;
	}
	
	/*
	 * @see com.GDT.Interface.CommonSUserInterface#doLogin(int, java.lang.String, java.lang.String)
	 * @author zero
	 */
	public int doLogin(int schoolId, String name, String password) {
		int userId = 0;
		String sql = "select Id from 学生教师账号 where 学校Id=? and 用户名=? and 密码=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1 , schoolId);
			sta.setString(2 , name);
			sta.setString(3 , password);
			
			res = connectObj.getQueryResultSet();
			if(res.next()){
				userId = res.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return userId;
	}

	/*
	 * @see com.GDT.Interface.CommonSUserInterface#queryUserType(int)
	 * @author zero
	 */
	public String queryUserType(int userId) {
		String type = null;
		String sql = "select 用户类型 from 学生教师账号 where Id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, userId);
			
			res = connectObj.getQueryResultSet();
			if(res.next()){
				type = res.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return type;
	}
	
	/*
	 * @see com.GDT.Interface.CommonSUserInterface#queryNewInfors(int, java.lang.String)
	 * 普通学校用户的最新信息查询操作
	 * @author zero
	 * @param userId
	 * 用户编号
	 * @param type
	 * 信息类型
	 */
	public String queryNewInfors(int userId, int type) {
		String newsInfor = null;
		NewsFactoryInterface factory = new NewsFactory();
		STNewsInterface newcl = factory.createNewInforCL();
		
		if(type == NEW_UNTREATED){//未处理过的信息
			newsInfor = newcl.queryUntreatedNews(userId);
		}else if(type == NEW_TREATED){//已处理过的信息
			newsInfor = newcl.queryNews(userId);
		}else if(type == NEW_ALL){//全部信息
			newsInfor = newcl.queryNews(userId);
		}
		
		return newsInfor;
	}

	public List<NewInfor> queryNews(int userId, int type) {
		// TODO Auto-generated method stub
		return null;
	}

	public ProjectInfor queryProject(int projectId) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<ProjectStageInfor> queryProjectAllStageName(int teamId) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<ProjectStageGuide> queryProjectStageGuides(int teamId,
			int stageId) {
		// TODO Auto-generated method stub
		return null;
	}

	public ProjectStageInfor queryProjectStageInfor(int teamId, int stageId) {
		// TODO Auto-generated method stub
		return null;
	}

	public String queryProjectStageNames(int teamId) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<ProjectStageGuide> queryStageAllFiles(int teamId, int stageId) {
		// TODO Auto-generated method stub
		return null;
	}

	public String queryStageFiles(int teamId, int stageId) {
		// TODO Auto-generated method stub
		return null;
	}

	public String queryStageGuides(int teamId, int stageId) {
		// TODO Auto-generated method stub
		return null;
	}

	public ProjectInfor queryTeamProject(int teamId) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Student> queryTeamStudentInfors(int teamId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean alterHead(int id, String head) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean alterPassword(int id, String password) {
		Boolean alterResult = false;
		String sql = "update 学生教师账号 set 密码=? where id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			
			sta = connectObj.getStatement(sql);
			sta.setString(1, password);
			sta.setInt(2, id);
			
			alterResult = sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return alterResult;
	}

	public Boolean checkPassword(int id, String password) {
		Boolean checkResult = false;
		String sql = "select * from 学生教师账号 where id=? and 密码=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			
			sta = connectObj.getStatement(sql);
			sta.setInt(1, id);
			sta.setString(2, password);
			
			res = connectObj.getQueryResultSet();
			checkResult = res.next();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return checkResult;
	}

	public Boolean doDelete(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean ifUseName(String name) {
		// TODO Auto-generated method stub
		return null;
	}

	public String queryUserInfor(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	/*
	 * @see com.GDT.Interface.CommonSUserInterface#querySchoolNews(int)
	 * 查询学校的最新通知信息操作
	 */
	public String querySchoolNews(int schoolId) {
		NewsFactoryInterface factory = new NewsFactory();
		SchoolNewInterface newcl = factory.createSchoolNewCL();
		
		String json = newcl.queryNews(schoolId);//返回json数据
		
		return json;
	}
	
	/*
	 * @see com.GDT.Interface.UserInterface#ifDetail(int)
	 * 用于检索用户详细信息是否已经输入
	 */
	public Boolean ifDetail(int userId) {
		Boolean detail = false;
		String sql = "select case when 用户类型 = 'S' then (select 信息是否已填写 from 学生详细信息 where Id = ?) "
					+"when 用户类型 = 'T' then (select 信息是否已填写 from 教师详细信息 where Id = ?) "
					+"end as 信息是否已填写 "
					+"from 学生教师账号 where Id = ?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1 , userId);
			sta.setInt(2 , userId);
			sta.setInt(3 , userId);
			
			res = connectObj.getQueryResultSet();
			
			if(res.next()){
				if(res.getString(1) != null && res.getString(1).equals("T")){
					detail = true;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return detail;
	}
}
