package com.GDT.Interface;

import java.util.List;

import com.GDT.Model.ProjectStageGuide;
import com.GDT.Model.ProjectStageInfor;
import com.GDT.Model.ProjectStageManage;
import com.GDT.Model.TeamStageFile;

/**
 * 课题的阶段操作在客户端的DWR实现方法接口
 * @author zero
 */
public interface DWRProjectStageInterface {
	/**
	 * 获取课题某个课题编号的阶段详细信息
	 * @param projectId
	 * 根据课题编号获取课题阶段的详细信息
	 * @return List<ProjectStageInfor>
	 * 返回一个课题的阶段详细数据信息链表
	 */
	public List<ProjectStageInfor> queryProjectStages(int projectId);
	
	/**
	 * 通过阶段编号获取该团队的阶段文档信息内容
	 * @param stageId
	 * 阶段编号
	 * @return List<TeamStageFile>
	 * 阶段文档信息内容链表
	 */
	public List<TeamStageFile> queryStageFiles(int stageId);
	
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
	 * 通过用户编号查询用户的全部阶段操作管理信息内容
	 * @param userId
	 * 用户编号
	 * @return List<ProjectStageManage>
	 * 返回阶段管理详细信息
	 */
	public List<ProjectStageManage> queryStageManages(int userId);
	
	/**
	 * 通过用户编号查询用户的全部阶段操作管理信息内容
	 * @param teamId
	 * 用户编号
	 * @return List<ProjectStageManage>
	 * 返回阶段管理详细信息
	 */
	public List<ProjectStageManage> queryStageMSByTeamId(int teamId);
	
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
	 * 通过阶段编号查询全部未处理的请求信息
	 * @param stageId
	 * 阶段编号
	 * @return List<ProjectStageGuide>
	 * 阶段指导信息
	 */
	public List<ProjectStageGuide> queryStageGuidesNoDeal(int stageId);
	
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
