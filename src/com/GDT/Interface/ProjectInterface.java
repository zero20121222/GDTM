package com.GDT.Interface;

import java.util.List;

import com.GDT.Model.ProjectAuditInfor;
import com.GDT.Model.ProjectInfor;
import com.GDT.Model.Teacher;

/**
 * 课题处理接口设定
 * @author zero
 */
public interface ProjectInterface extends ProjectStageInterface , ProjectPagingInterface{
	public static final int INFORCOMPLETE = 1;		//信息完整
	public static final int INFORNOPROJECT = 2;		//课题内容不完整
	public static final int INFORNOSTAGE = 3;		//没有课题阶段内容
	public static final int STAGENODETAIL = 4;		//课题阶段内容不完整
	
	
	/**
	 * 查询毕业课题名称在学校中是否已被使用
	 * @param schoolId
	 * 学校编号
	 * @param name
	 * 课题名称
	 * @return Boolean
	 * 课题名称是否已被使用
	 */
	public Boolean ifExistName(int schoolId , String name);

	/**
	 * 教师设计毕业课题
	 * @param project
	 * 需要保存的课题详细信息(需要保存的课题基本信息不包括阶段信息)
	 * @return Boolean
	 * 返回是否保存成功（true:成功，false:保存失败）
	 */
	public Boolean saveProjectInfor(ProjectInfor project);
	
	/**
	 * 获取毕业课题的编号
	 * @schoolId
	 * 学校编号
	 * @projectName
	 * 毕业课题名称
	 * @return int
	 * 返回一个课题编号
	 */
	public int queryProjectId(int schoolId , String projectName);
	
	/**
	 * 更改毕业课题详细
	 * @param project
	 * 更改后的毕业课题信息
	 * @return Boolean
	 * 返回毕业课题信息更改是否成功（true:成功，false:保存失败）
	 */
	public Boolean alterProjectInfor(ProjectInfor project);
	
	/**
	 * 删除毕业课题信息操作(存放到回收站中)
	 * @param projectId
	 * 需要删除的毕业课题编号
	 * @return Boolean
	 * 返回毕业课题信息删除是否成功（true:成功，false:删除失败）
	 */
	public Boolean deleteProjectInfor(int projectId);
	
	/**
	 * 完全删除毕业课题信息操作(从回收站中去除)
	 * @param projectId
	 * 需要删除的毕业课题编号
	 * @return Boolean
	 * 返回毕业课题信息删除是否成功（true:成功，false:删除失败）
	 */
	public Boolean deleteProjectTotally(int projectId);
	
	/**
	 * 将已处于删除状态的毕业课题信息操作(从回收站中恢复)
	 * @param projectId
	 * 需要删除的毕业课题编号
	 * @return Boolean
	 * 返回毕业课题信息恢复是否成功（true:成功，false:恢复失败）
	 */
	public Boolean recoverProject(int projectId);
	
	/**
	 * 获取毕业课题创建者的详细个人信息
	 * @param createrId
	 * 课题创建者编号
	 * @return Teacher
	 * 返回课题创建者（教师）的详细信息
	 */
	public Teacher queryProjectCreaterInfor(int createrId);
	
	/**
	 * 显示毕业课题详细信息
	 * @param projectId
	 * 需要显示的毕业课题编号
	 * ProjectInfor
	 * 显示一个毕业课题详细信息
	 */
	public ProjectInfor queryProjectInfor(int projectId);
	
	/**
	 * 显示毕业课题详细信息
	 * @param projectId
	 * 需要显示的毕业课题编号
	 * String
	 * 显示一个毕业课题详细信息的JSON数据类型
	 */
	public String queryProjectInforJSON(int projectId);
	
	/**
	 * 显示全部的毕业课题
	 * @param userId
	 * 教师用户编号
	 * @param type
	 * 需要显示的毕业课题类型（s:保存状态,w:待审核的,t:通过审核,f:审核未通过,d:删除的,null:显示全部课题）
	 * @return List<ProjectInfor>
	 * 返回一个全部教师的毕业课题信息链表对象
	 */
	public List<ProjectInfor> queryAllProjectInfor(int userId , String type);
	
	/**
	 * 查询当前毕业课题审核情况
	 * @param projectId
	 * 课题编号
	 * @return ProjectAuditInfor
	 * 返回当前审核情况
	 */
	public ProjectAuditInfor queryAuditInfor(int projectId);
	
	/**
	 * 通过课题编号查询课题的全部审核信息
	 * @param projectId
	 * 课题编号
	 * @return List<ProjectAuditInfor>
	 * 返回一个课题的全部审核结果
	 */
	public List<ProjectAuditInfor> queryAllAuditInfor(int projectId);
	
	/**
	 * 显示全部的毕业课题
	 * @param userId
	 * 教师用户编号
	 * @param type
	 * 需要显示的毕业课题类型（s:保存状态,w:待审核的,t:通过审核,f:审核未通过,d:删除的,null:显示全部课题）
	 * @return String
	 * 返回一个全部毕业课题信息的JSON字符串对象
	 */
	public String queryProjectInfors(int userId , String type);
	
	/**
	 * 判断用户准备提交的课题信息是否完整
	 * @param projectId
	 * 提交的课题编号
	 * @return int
	 * 返回课题是否完整的操作(1:课题内容完整,2:课题内容不完整,3:课题阶段未填写,-1:课题内容错误)
	 */
	public int checkProjectCompleted(int projectId);
	
	/**
	 * 提交课题审核操作
	 * @param projectId
	 * 毕业课题编号
	 * @return Boolean
	 * 返回是否成功提交课题审核（true:成功，false:保存失败）
	 */
	public Boolean submitProjectInfor(int projectId);
	
	/**
	 * 获取学校的课题阶段参数学校系统设定值
	 * @param schoolId
	 * 学校编号用于检索学校的参数信息
	 * @return String
	 * 返回学校对于课题参数的JSON数据格式
	 */
	public String queryStageParams(int schoolId);
	
	/**
	 * 获取学校的课题的上传文件内容信息
	 * @param projectId
	 * 需要显示的毕业课题编号
	 * @return String
	 * 返回课题文件的路径信息
	 */
	public String queryProjectFilePath(int projectId);
	
	/**
	 * 通过课题编号查询课题阶段是否以创建
	 * @param projectId
	 * 需要查询的课题的课题编号
	 * @return Boolean
	 * 返回课题阶段内容是否以创建
	 */
	public Boolean ifExistProjectStages(int projectId);
	
	/**
	 * 通过学校编号获取最早创建课题时间
	 * @param schoolId
	 * 学校编号
	 * @return int
	 * 返回一个年
	 */
	public int queryMinProjectYear(int schoolId);
	
	/**
	 * 通过学校编号获取最早通过审核的课题时间
	 * @param schoolId
	 * 学校编号
	 * @return int
	 * 返回一个年
	 */
	public int queryMinAuditedYear(int schoolId);
	
	/**
	 * 通过教师编号获取最早创建课题时间
	 * @param teacherId
	 * 教师编号
	 * @return int
	 * 返回一个年分信息
	 */
	public int queryTeacherMinYear(int teacherId);
	
	/**
	 * 再次提交课题审核操作处理
	 * @param projectId
	 * 需要再次提交审核的课题编号
	 * @return Boolean
	 * 提交操作返回结果
	 */
	public Boolean commitAuditAgain(int projectId);
}
