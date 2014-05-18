package com.GDT.Interface;

import java.util.List;

import com.GDT.Model.ProjectInfor;
import com.GDT.Model.ProjectStageInfor;
import com.GDT.Model.Teacher;
import com.GDT.Model.TeamInfor;

/**
 * 教师用户类接口
 * @author zero
 */
public interface TeacherInterface{
	////////////////////////////////////////		教师用户基本处理功能函数			/////////////////////////////////////////
	/**
	 * 保存教师用户的基本信息当开始登入时
	 * @param teacher
	 * 教师用户对象的详细信息
	 * @return Boolean
	 * 返回教师信息是否保存成功
	 */
	public Boolean saveTeacherInfor(Teacher teacher);
	
	/**
	 * 查询是否允许更改教师详细信息
	 * @param schoolId
	 * 学校编号
	 * @return Boolean
	 * 返回是否允许更改教师信息
	 */
	public Boolean ifAllowUpdate(int schoolId);
	
	/**
	 * 用户信息更改
	 * @param teacher
	 * 用户的更改信息
	 * @return Boolean
	 * 返回数据用户信息更改是否成功 true:成功,false:失败
	 */
	public Boolean doAlter(Teacher teacher);
	
	/**
	 * 查询用户信息
	 * @param id
	 * 作为查询用户的编号输入信息
	 * @return Teacher
	 * 返回教师用户的详细信息
	 */
	public Teacher doSelect(int id);
	
	////////////////////////////////////////		教师用户对于对于毕业课题的管理接口设计		///////////////////////////////////////////////////
	/**
	 * 查询毕业课题名称在学校中是否已被使用
	 * @param schoolId
	 * 学校编号
	 * @param name
	 * 课题名称
	 * @return Boolean
	 * 课题名称是否已被使用
	 */
	public Boolean ifExistProjectName(int schoolId , String name);
	
	/**
	 * 教师设计毕业课题
	 * @param project
	 * 需要保存的课题详细信息
	 * @return Boolean
	 * 返回是否保存成功（true:成功，false:保存失败）
	 */
	public Boolean saveProject(ProjectInfor project);
	
	/**
	 * 教师对于毕业课题的阶段设计
	 * @param projectId
	 * 课题的编号
	 * @param stageList
	 * 课题的阶段链表信息
	 * @return Boolean
	 * 返回是否保存成功（true:成功，false:保存失败）
	 */
	public Boolean saveProjectStages(List<ProjectStageInfor> stageList);
	
	/**
	 * 提交课题审核操作
	 * @param projectId
	 * 毕业课题编号
	 * @return Boolean
	 * 返回是否成功提交课题审核（true:成功，false:保存失败）
	 */
	public Boolean submitProject(int projectId);
	
	/**
	 * 更改毕业课题详细
	 * @param project
	 * 更改后的毕业课题信息
	 * @return Boolean
	 * 返回毕业课题信息更改是否成功（true:成功，false:保存失败）
	 */
	public Boolean alterProject(ProjectInfor project);
	
	/**
	 * 删除毕业课题信息操作
	 * @param projectId
	 * 需要删除的毕业课题编号
	 * @return Boolean
	 * 返回毕业课题信息删除是否成功（true:成功，false:删除失败）
	 */
	public Boolean deleteProject(int projectId);
	
	/**
	 * 显示全部的毕业课题
	 * @param userId
	 * 教师用户编号
	 * @param type
	 * 需要显示的毕业课题类型（w:待审核的,t:通过审核,f:审核未通过,d:删除的,null:显示全部课题）
	 * @return List<ProjectInfor>
	 * 返回一个全部教师的毕业课题信息链表对象
	 */
	public List<ProjectInfor> queryProjects(int userId , String type);
	
	
	
	////////////////////////////////////////		教师用户对于团队的操作处理接口设计			///////////////////////////////////////////////////
	/**
	 * 查询是还能参加其他团队
	 * @param userId
	 * 用户的id编号
	 * @return Boolean
	 * 判断用户是否已经参加团队(true:已参加 , false:未参加)
	 */
	public Boolean ifAttendTeam(int userId);
		
	/**
	 * 回复学生发送的团队请求
	 * @param newId
	 * 最新信息的id编号
	 * @param answer
	 * 回复信息内容
	 * @return Boolean
	 * 回复信息是否保存成功
	 */
	public Boolean answerTeamRequest(int newId, String answer);
	
	/**
	 * 查询教师已经指导了对少团队
	 * @param userId
	 * 教师用户id编号
	 * @return int
	 * 返回一个教师用户已经指导的全部团队数目
	 */
	public int guideTeamNums(int userId);
	
	/**
	 * 显示全部指导团队的名称以及团队编号信息
	 * @param userId
	 * 教师用户id编号
	 * @return List<TeamInfor>
	 * 返回教师指导的全部团队团队名称以及团队编号链表对象
	 */
	public List<TeamInfor> queryTeamNames(int userId);
	
	/**
	 * 通过用户编号查询用户指导的团队信息内容
	 * @param userId
	 * 用户编号
	 * @return String
	 * 返回指导团队的JSON数据信息
	 */
	public String queryGuideTeams(int userId);
	
	
	////////////////////////////////////			教师对于团队的阶段管理的操作接口设计				////////////////////////////////////
	
	
	/**
	 * 回复学生发送的阶段请求问题
	 * @param requestId
	 * 阶段请求编号
	 * @param answer
	 * 回复阶段信息内容
	 * @return Boolean
	 * 返回阶段请求信息保存是否成功(true:成功，false:失败)
	 */
	public Boolean answerStageRequest(int requestId , String answer);
	
	/**
	 * 对指导团队的阶段信息做评定的操作
	 * @param teamId
	 * 团队编号
	 * @param stageId
	 * 阶段编号
	 * @param result
	 * 阶段审核结果
	 * @param score
	 * 团队阶段成绩
	 * @return Boolean 
	 * 返回教师对于团队阶段评分是否保存成功(true:保存成功，false:保存失败)
	 */
	public Boolean manageTeamStage(int teamId, int stageId, String result, double score);
}
