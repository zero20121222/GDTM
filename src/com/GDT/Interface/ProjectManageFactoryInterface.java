package com.GDT.Interface;

/**
 * 课题管理类对象创建工厂接口
 * @author zero
 */
public interface ProjectManageFactoryInterface {
	/**
	 * 创建一个课题对象处理类
	 * @return ProjectInterface
	 * 返回一个课题对象处理接口ProjectInterface
	 */
	public ProjectInterface createProjectCL();
	
	/**
	 * 创建一个课题阶段对象处理类
	 * @return ProjectStageInterface
	 * 返回一个课题阶段对象处理接口ProjectStageInterface
	 */
	public ProjectStageInterface createProjectStageCL();
	
	/**
	 * 创建一个课题审核处理对象
	 * @return ProjectAuditInterface
	 * 返回一个课题审核处理接口ProjectAuditInterface
	 */
	public ProjectAuditInterface createProjectAuditCL();
	
	/**
	 * 创建一个课题审核处理对象
	 * @param auditerId
	 * 审核人员编号
	 * @return ProjectAuditInterface
	 * 返回一个课题审核处理接口ProjectAuditInterface
	 */
	public ProjectAuditInterface createProjectAuditCL(int auditerId); 
}
