package com.GDT.Interface;

import java.util.List;

import com.GDT.Model.*;

/**
 * 课题阶段管理接口设定
 * @author zero
 */
public interface ProjectStageInterface {
	/**
	 * 一个课题阶段的保存操作
	 * @param projectId
	 * 课题的编号
	 * @param stageInfor
	 * 课题的阶段信息
	 * @return Boolean
	 * 返回是否保存成功（true:成功，false:保存失败）
	 */
	public Boolean saveProjectStage(ProjectStageInfor stageInfor);
	
	/**
	 * 一个课题阶段的更改操作
	 * @param stageInfor
	 * 课题的阶段信息
	 * @return Boolean
	 * 返回是否更改成功（true:成功，false:保存失败）
	 */
	public Boolean updateProjectStage(ProjectStageInfor stageInfor);
	
	/**
	 * 对于一个课题阶段进行阶段管理操作
	 * @param stageId
	 * 阶段编号
	 * @param userId
	 * 团队用户编号
	 * @return Boolean
	 * 返回阶段开始是否成功
	 */
	public Boolean startProjectStage(int stageId , int userId);
	
	/**
	 * 通过阶段编号判断该阶段是否已启动
	 * @param stageId
	 * 阶段编号
	 * @return Boolean
	 * 返回阶段是否一开始（true:已开启, false:未开启）
	 */
	public Boolean existStartStage(int stageId);
	
	/**
	 * 一个课题阶段的删除操作
	 * @param stageId
	 * 课题的阶段编号
	 * @return Boolean
	 * 返回是否删除成功（true:成功，false:保存失败）
	 */
	public Boolean deleteProjectStage(int stageId);
	
	/**
	 * 多个课题阶段的保存操作
	 * @param stageList
	 * 课题的阶段链表信息
	 * @return Boolean
	 * 返回是否保存成功（true:成功，false:保存失败）
	 */
	public Boolean saveProjectStages(List<ProjectStageInfor> stageList);
	
	/**
	 * 多个课题阶段的更改操作
	 * @param stageList
	 * 课题的阶段链表信息
	 * @return Boolean
	 * 返回是否更改成功（true:成功，false:保存失败）
	 */
	public Boolean updateProjectStages(List<ProjectStageInfor> stageList);
	
	/**
	 * 多个课题阶段的删除操作
	 * @param stageIds
	 * 需要删除的课题阶段编号数组
	 * @return Boolean
	 * 返回是否删除成功（true:成功，false:保存失败）
	 */
	public Boolean deleteProjectStages(int[] stageIds);
	
	/**
	 * 查询某个课题阶段信息
	 * @param stageId
	 * 课题的编号
	 * @return ProjectStageInfor
	 * 返回该课题的某个阶段的详细信息
	 */
	public ProjectStageInfor queryProjectStage(int stageId);
	
	/**
	 * 查询全部的课题阶段信息
	 * @param projectId
	 * 课题的编号
	 * @return List<ProjectStageInfor>
	 * 返回该课题的全部阶段的详细信息
	 */
	public List<ProjectStageInfor> queryProjectStages(int projectId);
	
	/**
	 * 根据阶段编号得到课题阶段文档路径
	 * @param stageId
	 * 课题的阶段编号
	 * @return String
	 * 返回一个课题阶段文档路径
	 */
	public String queryStageFilePath(int stageId);
	
	/**
	 * 通过用户的编号查询课题阶段详细名称
	 * @param userId
	 * 用户编号
	 * @return String
	 * 返回封装好的JSON阶段名称
	 */
	public String queryStageNames(int userId);
	
	/**
	 * 通过教师用户编号查询阶段名称信息
	 * @param userId
	 * 教师编号
	 * @return String
	 * 返回封装好的JSON阶段名称
	 */
	public String queryStageNamesByTea(int userId);
	
	/**
	 * 通过阶段编号查询详细课题信息
	 * @param stageId
	 * 阶段编号
	 * @return ProjectInfor
	 * 课题详细信息
	 */
	public ProjectInfor queryProjectInfor(int stageId);
	
	/**
	 * 通过团队编号获取最早阶段开始时间
	 * @param teamId
	 * 团队编号
	 * @return String
	 * 返回阶段开始时间
	 */
	public String querySTByTeamId(int teamId);
	
	/**
	 * 通过用户查询课题的最早阶段开始时间
	 * @param userId
	 * 用户编号
	 * @return String
	 * 返回阶段开始时间
	 */
	public String queryStartTime(int userId);
	
	/**
	 * 创建阶段问题信息
	 * @param stageId
	 * 阶段编号
	 * @param userId
	 * 用户编号
	 * @param request
	 * 阶段请求信息内容
	 * @return Boolean
	 * 返回阶段创建结果
	 */
	public Boolean createStageGuide(int stageId , int userId, String request);
	
	/**
	 * 通过指导信息编号以及回复信息回答学生请求内容
	 * @param guideId
	 * 指导编号
	 * @param answerInfor
	 * 回复信息内容
	 * @return Boolean
	 * 回复信息信息是否成功
	 */
	public Boolean answerStageGuide(int guideId , String answerInfor);
	
	/**
	 * 通过阶段编号查询详细阶段指导信息
	 * @param stageId
	 * 阶段编号
	 * @param pageNum
	 * 页面编号
	 * @return List<ProjectStageGuide>
	 * 阶段指导信息
	 */
	public List<ProjectStageGuide> queryStageGuides(int stageId , int pageNum);
	
	/**
	 * 获取已处理过得阶段指导信息内容
	 * @param stageId
	 * 阶段编号
	 * @param pageNum
	 * 页面编号
	 * @return List<ProjectStageGuide>
	 * 阶段指导信息
	 */
	public List<ProjectStageGuide> queryDealGuides(int stageId , int pageNum);
	
	/**
	 * 通过阶段编号查询全部未处理的请求信息
	 * @param stageId
	 * 阶段编号
	 * @return List<ProjectStageGuide>
	 * 阶段指导信息
	 */
	public List<ProjectStageGuide> queryStageGuides(int stageId);
	
	/**
	 * 通过阶段编号查询该阶段的指导信息条数
	 * @param stageId
	 * 阶段编号
	 * @return int
	 * 返回阶段指导信息条数
	 */
	public int queryStageGuideNum(int stageId);
	
	/**
	 * 通过阶段编号查询该阶段的已处理的指导信息条数
	 * @param stageId
	 * 阶段编号
	 * @return int
	 * 返回阶段指导信息条数
	 */
	public int queryDealGuideNum(int stageId);
	
	/**
	 * 通过阶段编号获取教师对于该团队的阶段的审核情况
	 * @param stageId
	 * 阶段编号
	 * @return ProjectStageManage
	 * 返回阶段审核情况信息内容
	 */
	public ProjectStageManage queryStageManage(int stageId);
	
	/**
	 * 通过用户编号查询用户的全部阶段操作管理信息内容
	 * @param userId
	 * 用户编号
	 * @return List<ProjectStageManage>
	 * 返回阶段管理详细信息
	 */
	public List<ProjectStageManage> queryStageManages(int userId);
	
	/**
	 * 通过团队编号查询阶段管理信息内容
	 * @param teamId
	 * 团队编号
	 * @return List<ProjectStageManage>
	 * 阶段管理信息内容
	 */
	public List<ProjectStageManage> queryStageMSByTeamId(int teamId);
	
	/**
	 * 创建阶段文档信息
	 * @param stageFile
	 * 阶段文档信息
	 * @return Boolean
	 * 返回成功或者失败
	 */
	public Boolean createStageFile(TeamStageFile stageFile);
	
	/**
	 * 通过阶段编号获取该团队的阶段文档信息内容
	 * @param stageId
	 * 阶段编号
	 * @return List<TeamStageFile>
	 * 阶段文档信息内容链表
	 */
	public List<TeamStageFile> queryStageFiles(int stageId);
	
	/**
	 * 通过团队编号阶段编号以及文件名称查询阶段文档信息
	 * @param teamId
	 * 团队编号
	 * @param stageId
	 * 阶段编号
	 * @param fileName
	 * 文件名称
	 * @return TeamStageFile
	 * 返回阶段文档信息
	 */
	public TeamStageFile queryStageFile(int teamId , int stageId, String fileName);
	
	/**
	 * 通过团队编号以及阶段编号锁定阶段审核信息内容
	 * @param teamId
	 * 团队编号
	 * @param stageId
	 * 阶段编号
	 * @return boolean
	 * 是否成功开始
	 */
	public Boolean startStageAudit(int teamId , int stageId);
	
	/**
	 * 提交阶段审核处理信息
	 * @param teamId
	 * 团队编号
	 * @param stageId
	 * 阶段编号
	 * @param auditRes
	 * 审核结果
	 * @param auditInfor
	 * 审核评语信息内容
	 * @return Boolean
	 * 返回一个阶段审核处理结果
	 */
	public Boolean commitStageAudit(int teamId , int stageId, String auditRes, String auditInfor);
}
