package com.GDT.Factory;

import com.GDT.Interface.ProjectAuditInterface;
import com.GDT.Interface.ProjectInterface;
import com.GDT.Interface.ProjectManageFactoryInterface;
import com.GDT.Interface.ProjectStageInterface;
import com.GDT.ModelCL.ProjectInforCL;
import com.GDT.ModelCL.ProjectStageCL;
import com.GDT.ModelCL.SchoolAuditCL;

/**
 * 用于创建课题管理对象类的工厂
 * @author zero
 */
public class ProjectManageFactory implements ProjectManageFactoryInterface{
	/**
	 * @see com.GDT.Interface.ProjectManageFactoryInterface#createProjectCL()
	 * 返回一个课题对象处理接口ProjectInterface
	 * @author zero
	 */
	public ProjectInterface createProjectCL() {
		return new ProjectInforCL();
	}
	
	/**
	 * @see com.GDT.Interface.ProjectManageFactoryInterface#createProjectStageCL()
	 * 返回一个课题阶段对象处理接口ProjectStageInterface
	 * @author zero
	 */
	public ProjectStageInterface createProjectStageCL() {
		return new ProjectStageCL();
	}
	
	/**
	 * @see com.GDT.Interface.ProjectManageFactoryInterface#createProjectAuditCL()
	 * 返回一个课题审核处理接口ProjectAuditInterface
	 * @author zero
	 */
	public ProjectAuditInterface createProjectAuditCL(){
		return new SchoolAuditCL();
	}
	
	/**
	 * @see com.GDT.Interface.ProjectManageFactoryInterface#createProjectAuditCL(int)
	 * 返回一个课题审核处理接口ProjectAuditInterface
	 * @author zero
	 */
	public ProjectAuditInterface createProjectAuditCL(int auditerId){
		return new SchoolAuditCL(auditerId);
	}
}
