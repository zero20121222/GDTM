package com.GDT.ModelCL;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.GDT.Factory.ProjectManageFactory;
import com.GDT.Interface.ProjectInterface;
import com.GDT.Interface.ProjectManageFactoryInterface;
import com.GDT.Interface.ProjectStageInterface;
import com.GDT.Interface.TeacherInterface;
import com.GDT.Model.ProjectInfor;
import com.GDT.Model.ProjectStageInfor;
import com.GDT.Model.Teacher;
import com.GDT.Model.TeamInfor;
import com.GDT.util.DBConnection;
import com.GDT.util.DBConnectionInterface;


/**
 * 教师用户对象处理类
 * @author 
 */
public class TeacherCL extends CommonSUserCL implements TeacherInterface {
	private DBConnectionInterface connectObj = null;
	private PreparedStatement sta = null;
	private ResultSet res = null;
	
	public Boolean alterProject(ProjectInfor project) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean answerStageRequest(int requestId, String answer) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean answerTeamRequest(int newId, String answer) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean deleteProject(int projectId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean doAlter(Teacher teacher) {
		Boolean update = false;
		String sql = "update 教师详细信息 set 办公室=?,年龄=?,性别=?,身份证号码=?,地址=?,手机=?,email=?,qq=?,个人简介=? where id=?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setString(1, teacher.getOffice());
			sta.setString(2, teacher.getAge());
			sta.setString(3, teacher.getSex());
			sta.setString(4, teacher.getIdCard());
			sta.setString(5, teacher.getAddress());
			sta.setString(6, teacher.getPhone());
			sta.setString(7, teacher.getEmail());
			sta.setString(8, teacher.getQq());
			sta.setString(9, teacher.getResume());
			sta.setInt(10, teacher.getId());
			
			update = sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return update;
	}

	public Teacher doSelect(int id) {
		Teacher teacher = null;
		String sql = "select 真实姓名,院系类别,职位,学位,办公室,年龄,性别,身份证号码,地址,手机,email,qq,个人简介 from 教师详细信息 where Id=?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, id);
			
			res = connectObj.getQueryResultSet();
			if(res.next()){
				teacher = new Teacher();
				
				teacher.setRealName(res.getString(1));
				teacher.setCollege(res.getString(2));
				teacher.setPosition(res.getString(3));
				teacher.setDegree(res.getString(4));
				teacher.setOffice(res.getString(5));
				teacher.setAge(res.getString(6));
				teacher.setSex(res.getString(7));
				teacher.setIdCard(res.getString(8));
				teacher.setAddress(res.getString(9));
				teacher.setPhone(res.getString(10));
				teacher.setEmail(res.getString(11));
				teacher.setQq(res.getString(12));
				teacher.setResume(res.getString(13));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return teacher;
	}

	public int guideTeamNums(int userId) {
		// TODO Auto-generated method stub
		return 0;
	}

	public Boolean ifAllowUpdate(int schoolId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean ifAttendTeam(int userId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/*
	 * @see com.GDT.Interface.TeacherInterface#ifExistProjectName(int, java.lang.String)
	 * 用于检查教师编写的课题名称是否在该学校存在了
	 * @author zero
	 * true:已存在,false:未存在
	 */
	public Boolean ifExistProjectName(int schoolId , String name) {
		ProjectManageFactoryInterface factory = new ProjectManageFactory();
		ProjectInterface projectCL = factory.createProjectCL();
		
		Boolean result = projectCL.ifExistName(schoolId, name);//判断是否存在该课题名称
		
		return result;
	}
	
	public Boolean manageTeamStage(int teamId, int stageId, String result,
			double score) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<ProjectInfor> queryProjects(int userId, String type) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<TeamInfor> queryTeamNames(int userId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public String queryGuideTeams(int userId){
		JSONArray jsonArray = new JSONArray();
		
		String sql = "select  学生详细信息.Id,学生详细信息.`真实姓名` from 团队信息,学生详细信息 "
					+"where 团队信息.`队长编号`=学生详细信息.id and 团队信息.id in (select 团队人员关系.`团队编号` from 学生教师账号,团队人员关系 "
					+"where 回复='T' and 团队人员关系.`队员编号`=学生教师账号.id and 学生教师账号.id=?)";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1 , userId);
			
			res = connectObj.getQueryResultSet();
			JSONObject newInfor = null;
			while(res.next()){
				newInfor = new JSONObject();
				newInfor.put("teamId", res.getInt(1));
				newInfor.put("teamName", res.getString(2)+"团队");
				
				jsonArray.put(newInfor);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return jsonArray.toString();
	}
	
	/*
	 * @see com.GDT.Interface.TeacherInterface#saveProject(com.GDT.Model.ProjectInfor)
	 * 保存教师用户输入的课题详细信息
	 */
	public Boolean saveProject(ProjectInfor project) {
		ProjectManageFactoryInterface factory = new ProjectManageFactory();
		ProjectInterface projectCL = factory.createProjectCL();
		
		Boolean result = projectCL.saveProjectInfor(project);
		
		return result;
	}

	public Boolean submitProject(int projectId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean saveTeacherInfor(Teacher teacher) {
		Boolean save = false;
		String sql = "insert into 教师详细信息(Id,真实姓名,院系类别,职位,学位,办公室,年龄,性别,身份证号码,地址,手机,email,qq,个人简介,信息是否已填写) value(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, teacher.getId());
			sta.setString(2, teacher.getRealName());
			sta.setString(3, teacher.getCollege());
			sta.setString(4, teacher.getPosition());
			sta.setString(5, teacher.getDegree());
			sta.setString(6, teacher.getOffice());
			sta.setString(7, teacher.getAge());
			sta.setString(8, teacher.getSex());
			sta.setString(9, teacher.getIdCard());
			sta.setString(10, teacher.getAddress());
			sta.setString(11, teacher.getPhone());
			sta.setString(12, teacher.getEmail());
			sta.setString(13, teacher.getQq());
			sta.setString(14, teacher.getResume());
			sta.setString(15, "T");
			
			int result = sta.executeUpdate();
			save = result == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return save;
	}

	public Boolean saveProjectStages(List<ProjectStageInfor> stageList) {
		ProjectManageFactoryInterface factory = new ProjectManageFactory();
		ProjectStageInterface stageCL = factory.createProjectStageCL();
		
		Boolean saveResult = stageCL.saveProjectStages(stageList);
		
		return saveResult;
	}
	
}
