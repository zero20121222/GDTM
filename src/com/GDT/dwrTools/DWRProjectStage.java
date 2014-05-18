package com.GDT.dwrTools;

import java.util.List;

import com.GDT.Factory.ProjectManageFactory;
import com.GDT.Interface.DWRProjectStageInterface;
import com.GDT.Interface.ProjectManageFactoryInterface;
import com.GDT.Interface.ProjectStageInterface;
import com.GDT.Model.ProjectStageGuide;
import com.GDT.Model.ProjectStageInfor;
import com.GDT.Model.ProjectStageManage;
import com.GDT.Model.TeamStageFile;

/**
 * 课题的阶段操作在客户端的DWR实现方法
 * @author zero
 */
public class DWRProjectStage implements DWRProjectStageInterface{
	
	/*
	 * 获取某个课题的课题阶段详细信息
	 * @see com.GDT.Interface.DWRProjectStageInterface#queryProjectStages(int)
	 * @author zero
	 */
	public List<ProjectStageInfor> queryProjectStages(int projectId) {
		ProjectManageFactoryInterface factory = new ProjectManageFactory();
		ProjectStageInterface stageCL = factory.createProjectStageCL();
		
		return stageCL.queryProjectStages(projectId);
	}

	public List<TeamStageFile> queryStageFiles(int stageId){
		ProjectManageFactoryInterface factory = new ProjectManageFactory();
		ProjectStageInterface stageCL = factory.createProjectStageCL();
		
		return stageCL.queryStageFiles(stageId);
	}
	
	public Boolean startProjectStage(int stageId , int userId){
		ProjectManageFactoryInterface factory = new ProjectManageFactory();
		ProjectStageInterface stageCL = factory.createProjectStageCL();
		
		Boolean startRes = false;
		if(!stageCL.existStartStage(stageId)){
			startRes = stageCL.startProjectStage(stageId, userId);
		}
		
		return startRes;
	}
	
	public List<ProjectStageManage> queryStageManages(int userId){
		ProjectManageFactoryInterface factory = new ProjectManageFactory();
		ProjectStageInterface stageCL = factory.createProjectStageCL();
		
		return stageCL.queryStageManages(userId);
	}
	
	public List<ProjectStageManage> queryStageMSByTeamId(int teamId){
		ProjectManageFactoryInterface factory = new ProjectManageFactory();
		ProjectStageInterface stageCL = factory.createProjectStageCL();
		
		return stageCL.queryStageMSByTeamId(teamId);
	}
	
	public Boolean createStageGuide(int stageId , int userId, String request){
		ProjectManageFactoryInterface factory = new ProjectManageFactory();
		ProjectStageInterface stageCL = factory.createProjectStageCL();
		
		return stageCL.createStageGuide(stageId, userId, request);
	}
	
	public Boolean answerStageGuide(int guideId , String answerInfor){
		ProjectManageFactoryInterface factory = new ProjectManageFactory();
		ProjectStageInterface stageCL = factory.createProjectStageCL();
		
		return stageCL.answerStageGuide(guideId, answerInfor);
	}
	
	public List<ProjectStageGuide> queryDealGuides(int stageId , int pageNum){
		ProjectManageFactoryInterface factory = new ProjectManageFactory();
		ProjectStageInterface stageCL = factory.createProjectStageCL();
		
		return stageCL.queryDealGuides(stageId, pageNum);
	}
	
	public List<ProjectStageGuide> queryStageGuides(int stageId , int pageNum){
		ProjectManageFactoryInterface factory = new ProjectManageFactory();
		ProjectStageInterface stageCL = factory.createProjectStageCL();
		
		return stageCL.queryStageGuides(stageId, pageNum);
	}
	
	public List<ProjectStageGuide> queryStageGuidesNoDeal(int stageId){
		ProjectManageFactoryInterface factory = new ProjectManageFactory();
		ProjectStageInterface stageCL = factory.createProjectStageCL();
		
		return stageCL.queryStageGuides(stageId);
	}
	
	public Boolean commitStageAudit(int teamId , int stageId, String auditRes, String auditInfor){
		ProjectManageFactoryInterface factory = new ProjectManageFactory();
		ProjectStageInterface stageCL = factory.createProjectStageCL();
		
		return stageCL.commitStageAudit(teamId, stageId, auditRes, auditInfor);
	}
}
