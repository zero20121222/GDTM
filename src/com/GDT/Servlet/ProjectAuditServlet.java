package com.GDT.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.GDT.Factory.ProjectManageFactory;
import com.GDT.Interface.ProjectAuditInterface;
import com.GDT.Interface.ProjectInterface;
import com.GDT.Interface.ProjectManageFactoryInterface;
import com.GDT.Model.ProjectAuditInfor;
import com.GDT.Model.ProjectInfor;

/*
 * 课题的审核管理servlet类
 * @author zero
 */
public class ProjectAuditServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request , response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		PrintWriter out = null;
		
		String type = request.getParameter("type");
		if(type.equals("enter_schoolPros")){
			//获取显示学校课题详细的页面访问
			int schoolId = Integer.parseInt((String)session.getAttribute("school_id"));
			int proYear = request.getParameter("proYear") == null ? 0 : Integer.parseInt((String)request.getParameter("proYear"));
			
			ProjectInterface projectCL = new ProjectManageFactory().createProjectCL();
			int minYear = projectCL.queryMinProjectYear(schoolId);
			
			request.setAttribute("proYear", proYear+"");
			request.setAttribute("minYear", minYear+"");
			request.getRequestDispatcher("SchoolAdmin/schoolProjects.jsp").forward(request, response);
		}else if(type.equals("enter_project_audit")){
			//跳转进入课题审核页面
			int project_id = Integer.parseInt((String)request.getParameter("project_id"));//课题编号
			
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectAuditInterface auditCL = factory.createProjectAuditCL();
			//获取课题详细信息
			ProjectInfor projectInfor = auditCL.queryProject(project_id);
			//获取课题审核情况
			ProjectAuditInfor auditInfor = auditCL.queryProjectAudits(project_id);
			
			request.setAttribute("projectInfor", projectInfor);
			request.setAttribute("auditInfor", auditInfor);
			request.getRequestDispatcher("SchoolAdmin/auditProject.jsp").forward(request, response);
		}else if(type.equals("check_audit")){
			//通过异步查询当前课题的审核情况
			int project_id = Integer.parseInt((String)request.getParameter("project_id"));//课题编号
			int auditerId = Integer.parseInt((String)session.getAttribute("user_id"));//审核人员编号
			
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectAuditInterface auditerCL = factory.createProjectAuditCL(auditerId);
			
			out = response.getWriter();
			out.print(auditerCL.ifNeedAudit(project_id));
		}else if(type.equals("commit_auditInfor")){
			//通过异步查询当前课题的审核情况
			int project_id = Integer.parseInt((String)request.getParameter("project_id"));				//课题编号
			String audit_result = request.getParameter("audit_result");									//审核结果
			String audit_remark = URLDecoder.decode(request.getParameter("audit_remark") , "UTF-8");	//(进行解码操作)审核评语
			int auditerId = Integer.parseInt((String)session.getAttribute("user_id"));					//审核人员编号
			
			System.out.println("audit_remark->"+audit_remark);
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectAuditInterface auditerCL = factory.createProjectAuditCL(auditerId);
			
			int result = auditerCL.ifNeedAudit(project_id);
			if(result == 0){
				//3：审核成功,4:审核失败
				result = auditerCL.auditProject(project_id, audit_result, audit_remark) ? 3 : 4;
			}
			
			out = response.getWriter();
			out.print(result);
			out.close();
		}else if(type.equals("project_audit_infor")){
			//显示课题的详细信息以及审核情况
			int project_id = Integer.parseInt((String)request.getParameter("project_id"));//课题编号
			
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectAuditInterface auditCL = factory.createProjectAuditCL();
			//获取课题详细信息
			ProjectInfor projectInfor = auditCL.queryProject(project_id);
			//获取课题审核情况
			ProjectAuditInfor auditInfor = auditCL.queryProjectAudits(project_id);
			
			request.setAttribute("projectInfor", projectInfor);
			request.setAttribute("auditInfor", auditInfor);
			request.getRequestDispatcher("SchoolAdmin/auditInforShow.jsp").forward(request, response);
		}
	}
}
