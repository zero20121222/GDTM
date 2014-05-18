package com.GDT.Interface;

import com.GDT.Model.ProjectAuditInfor;
import com.GDT.Model.ProjectInfor;

/**
 * 课题审核处理接口设定
 * @author zero
 */
public interface ProjectAuditInterface {
	/**
	 * 通过用户编号和课题编号判断是否存在需要审核操作
	 * @param projectId	
	 * 需要审核的课题编号
	 * @return int
	 * 返回判断结果(0:还可以审核, 1:您已审核过了, 2:已不存在审核次数)
	 */
	public int ifNeedAudit(int projectId);
	
	/**
	 * 对课题编号的课题进行审核
	 * @param projectId	
	 * 需要审核的课题编号
	 * @param auditResult	
	 * 审核结果信息
	 * @param auditRemark	
	 * 课题审核评语
	 * @return Boolean
	 * 返回审核结果
	 * true:成功, false:失败
	 */
	public Boolean auditProject(int projectId , String auditResult, String auditRemark);
	
	/**
	 * 通过课题编号获取课题的审核情况信息
	 * @param projectId
	 * 课题编号
	 * @return Project
	 * 返回课题详细信息
	 */
	public ProjectInfor queryProject(int projectId);
	
	/**
	 * 获取课题的当前审核情况信息
	 * @param projectId
	 * 课题编号
	 * @return ProjectAuditInfor
	 * 返回审核状态信息内容
	 */
	public ProjectAuditInfor queryProjectAudits(int projectId);
}
