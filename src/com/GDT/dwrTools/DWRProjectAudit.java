package com.GDT.dwrTools;

import java.util.List;

import com.GDT.Factory.ProjectManageFactory;
import com.GDT.Interface.ProjectInterface;
import com.GDT.Interface.ProjectManageFactoryInterface;
import com.GDT.Model.ProjectAuditInfor;

/**
 * 课题的审核在客户端的DWR实现方法
 * @author zero
 */
public class DWRProjectAudit{
	
	/**
	 * 通过课题编号获取课题的全部审核信息
	 * @param projectId
	 * 课题编号
	 * @return List<ProjectAuditInfor>
	 * 返回详细审核链表
	 */
	public List<ProjectAuditInfor> queryProjectAudits(int projectId) {
		ProjectManageFactoryInterface factory = new ProjectManageFactory();
		ProjectInterface projectCL = factory.createProjectCL();
		
		return projectCL.queryAllAuditInfor(projectId);
	}

}
