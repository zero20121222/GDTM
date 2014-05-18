package com.GDT.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.GDT.Factory.ProjectManageFactory;
import com.GDT.Factory.SchoolManageFactory;
import com.GDT.Factory.UserFactory;
import com.GDT.Interface.ProjectInterface;
import com.GDT.Interface.ProjectManageFactoryInterface;
import com.GDT.Interface.SchoolManageFactoryInterface;
import com.GDT.Interface.SchoolParamsInterface;
import com.GDT.Interface.TeacherInterface;
import com.GDT.Interface.UserFactoryInterface;
import com.GDT.Model.ProjectAuditInfor;
import com.GDT.Model.ProjectInfor;
import com.GDT.Model.ProjectStageInfor;
import com.GDT.Model.Teacher;
import com.GDT.util.GDTDate;

/*
 * 课题的阶段管理servlet类
 * @author zero
 */
public class ProjectManagerServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request , response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		PrintWriter out = null;
		
		String type = request.getParameter("type");
		if(type.equals("prostage_title")){
			out = response.getWriter();
			String stage_titles = "[{stage_name:'开题报告',stage_id:''},{stage_name:'阶段2',stage_id:''},"+
								  "{stage_name:'阶段3',stage_id:''},{stage_name:'阶段4',stage_id:''},"+
								  "{stage_name:'阶段5',stage_id:''},{stage_name:'学生实习',stage_id:''},"+
								  "{stage_name:'阶段7',stage_id:''},{stage_name:'项目答辩',stage_id:''}]";
			
			out.write(stage_titles);
			out.close();
		}else if(type.equals("enter_projectPage")){//进入创建毕业课题信息
			int school_id = Integer.parseInt((String)session.getAttribute("school_id"));
			
			/* 获取学校的课题参与人数上限值 */
			SchoolManageFactoryInterface manageFactory = new SchoolManageFactory();
			SchoolParamsInterface paramsCL = manageFactory.createSchoolParamsCL();
			int parterUps = paramsCL.parterUps(school_id);
			
			request.setAttribute("school_parterUps", parterUps+"");
			request.getRequestDispatcher("SchoolUser/projectCreate.jsp").forward(request, response);
		}else if(type.equals("projectName_ifExist")){//判断课题名称是否存在
			out = response.getWriter();
			int school_id = Integer.parseInt((String)session.getAttribute("school_id"));
			//对于javascript传递过来的数据通过客户端的16位数据转换后需要在servlet端使用URLDecoder对象的decode方法对数据进行16位转换后显示
			String project_name = URLDecoder.decode(request.getParameter("project_name"), "UTF-8");
			
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectInterface projectCL = factory.createProjectCL();
			
			Boolean result = projectCL.ifExistName(school_id, project_name);
			
			out.print(result);
			out.close();
		}else if(type.equals("create_Project")){//实现毕业课题保存
			out = response.getWriter();
			int school_id = Integer.parseInt((String)session.getAttribute("school_id"));
			int user_id = Integer.parseInt((String)session.getAttribute("user_id"));
			
			ProjectInfor project = new ProjectInfor();
			
			project.setSchoolId(school_id);
			project.setCreaterId(user_id);
			//将上传过来的javascript中文数据转换由16位编码格式转换(对于javascript传递过来的数据进行编码转换)
			project.setProjectName(URLDecoder.decode(request.getParameter("project_name"), "UTF-8"));
			project.setProjectFile(URLDecoder.decode(request.getParameter("upfile_name"), "UTF-8"));
			project.setPicture(URLDecoder.decode(request.getParameter("picture_name"), "UTF-8"));
			project.setPartNum(Integer.parseInt((String)request.getParameter("partNum")));
			project.setHardNum(Integer.parseInt((String)request.getParameter("hardNum")));
			project.setWorkload(URLDecoder.decode(request.getParameter("workload"), "UTF-8"));
			project.setCollege(URLDecoder.decode(request.getParameter("college"), "UTF-8"));
			project.setPurpose(URLDecoder.decode(request.getParameter("purpose"), "UTF-8"));
			project.setMainContent(URLDecoder.decode(request.getParameter("main_content"), "UTF-8"));
			project.setCreateDate(GDTDate.getSqlDate());
			
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectInterface projectCL = factory.createProjectCL();
			
			if(projectCL.saveProjectInfor(project)){
				int projectId = projectCL.queryProjectId(school_id, project.getProjectName());	
				out.print(projectId);//返回毕业课题编号
			}else{
				out.print(-1);
			}
			
			out.close();
		}else if(type.equals("query_stage_params")){
			out = response.getWriter();
			int school_id = Integer.parseInt((String)session.getAttribute("school_id"));
			
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectInterface projectCL = factory.createProjectCL();
			
			//返回课题的阶段参数信息内容
			String JSON = projectCL.queryStageParams(school_id);
			
			out.print(JSON);
			out.close();
		}else if(type.equals("create_ProjectStage")){//保存阶段信息
			int project_id = Integer.parseInt((String)request.getParameter("project_id"));//课题编号
			String stageJSON = URLDecoder.decode(request.getParameter("stageJSON") , "UTF-8");
			
			List<ProjectStageInfor> stageList = new ArrayList<ProjectStageInfor>();
			
			try {
				JSONArray jsonArray = new JSONArray(stageJSON);
				JSONObject json = null;
				ProjectStageInfor stageInfor = null;
				//将阶段信息封装到类中(解析JSON信息)
				for(int i=0;i<jsonArray.length();i++){
					stageInfor = new ProjectStageInfor();
					json = jsonArray.getJSONObject(i);
					
					stageInfor.setStageId(i+1);
					stageInfor.setProjectId(project_id);
					stageInfor.setStageName(json.getString("stage_name"));
					stageInfor.setTimeLimit(Integer.parseInt(json.getString("stage_timeLimit")));
					stageInfor.setStageDemand(json.getString("stage_demand"));
					stageInfor.setStageFiles(json.getString("stage_filed"));
					stageList.add(stageInfor);
				}
				
				UserFactoryInterface factory = new UserFactory();
				TeacherInterface teacherCL = factory.createTeacherCL();
				
				out = response.getWriter();
				out.print(teacherCL.saveProjectStages(stageList));
				
			} catch (JSONException e) {
				e.printStackTrace();
			}
			
			out.close();
		}else if(type.equals("come_update_project")){//进入课题信息更改页面
			int school_id = Integer.parseInt((String)session.getAttribute("school_id"));//学校编号
			int project_id = Integer.parseInt((String)request.getParameter("project_id"));//课题编号
			
			/* 获取学校的课题参与人数上限值 */
			SchoolManageFactoryInterface manageFactory = new SchoolManageFactory();
			SchoolParamsInterface paramsCL = manageFactory.createSchoolParamsCL();
			int parterUps = paramsCL.parterUps(school_id);
			
			/* 获取课题的详细信息内容 */
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectInterface projectCL = factory.createProjectCL();
			ProjectInfor projectInfor = projectCL.queryProjectInfor(project_id);//获取特定课题编号的课题详细信息

			request.setAttribute("school_parterUps", parterUps+"");
			request.setAttribute("projectInfor", projectInfor);
			request.getRequestDispatcher("SchoolUser/teaUpdateProject.jsp").forward(request, response);
		}else if(type.equals("come_update_prostage")){//进入课题阶段信息更改页面
			int school_id = Integer.parseInt((String)session.getAttribute("school_id"));//学校编号
			int project_id = Integer.parseInt((String)request.getParameter("project_id"));//课题编号
			
			/* 获取学校关于课题创建时的参数限制 */
			SchoolManageFactoryInterface manageFactory = new SchoolManageFactory();
			SchoolParamsInterface paramsCL = manageFactory.createSchoolParamsCL();
			int[] proStageParams = paramsCL.projectStageParams(school_id);
			
			request.setAttribute("proStageParams" , proStageParams);
			request.setAttribute("project_id" , project_id+"");
			request.getRequestDispatcher("SchoolUser/projectStageUpdate.jsp").forward(request, response);
		}else if(type.equals("update_project")){//实现毕业课题信息的更改操作
			int school_id = Integer.parseInt((String)session.getAttribute("school_id"));
			int user_id = Integer.parseInt((String)session.getAttribute("user_id"));
			int project_id = Integer.parseInt(request.getParameter("project_id"));
			
			ProjectInfor project = new ProjectInfor();
			
			project.setId(project_id);
			project.setSchoolId(school_id);
			project.setCreaterId(user_id);
			//将上传过来的javascript中文数据转换由16位编码格式转换(对于javascript传递过来的数据进行编码转换)
			project.setProjectName(URLDecoder.decode(request.getParameter("project_name"), "UTF-8"));
			project.setProjectFile(URLDecoder.decode(request.getParameter("upfile_name"), "UTF-8"));
			project.setPicture(URLDecoder.decode(request.getParameter("picture_name"), "UTF-8"));
			project.setPartNum(Integer.parseInt((String)request.getParameter("partNum")));
			project.setHardNum(Integer.parseInt((String)request.getParameter("hardNum")));
			project.setWorkload(URLDecoder.decode(request.getParameter("workload"), "UTF-8"));
			project.setCollege(URLDecoder.decode(request.getParameter("college"), "UTF-8"));
			project.setPurpose(URLDecoder.decode(request.getParameter("purpose"), "UTF-8"));
			project.setMainContent(URLDecoder.decode(request.getParameter("main_content"), "UTF-8"));
			
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectInterface projectCL = factory.createProjectCL();
			
			out = response.getWriter();
			if(projectCL.alterProjectInfor(project)){
				if(projectCL.ifExistProjectStages(project_id)){
					//再在这里添加一个关于对于该课题是否以创建课题阶段的判断(课题已存在)
					out.print(1);
				}else{
					//还未创建课题
					out.print(0);
				}
			}else{
				out.print(-1);//课题更改失败
			}
			
			out.close();
		}else if(type.equals("update_fail_project")){//进入课题审核失败后的更改操作页面
			int school_id = Integer.parseInt((String)session.getAttribute("school_id"));//学校编号
			int project_id = Integer.parseInt((String)request.getParameter("project_id"));//课题编号
			
			/* 获取学校的课题参与人数上限值 */
			SchoolManageFactoryInterface manageFactory = new SchoolManageFactory();
			SchoolParamsInterface paramsCL = manageFactory.createSchoolParamsCL();
			int parterUps = paramsCL.parterUps(school_id);
			
			/* 获取课题的详细信息内容 */
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectInterface projectCL = factory.createProjectCL();
			ProjectInfor projectInfor = projectCL.queryProjectInfor(project_id);//获取特定课题编号的课题详细信息

			request.setAttribute("school_parterUps", parterUps+"");
			request.setAttribute("projectInfor", projectInfor);
			request.getRequestDispatcher("SchoolUser/failProjectUpdate.jsp").forward(request, response);
		}else if(type.equals("project_audit_again")){//课题更改后的再次审核操作
			//课题更改后的再次审核操作
			int project_id = Integer.parseInt((String)request.getParameter("project_id"));//课题编号
			
			/* 毕业课题再次提交审核 */
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectInterface projectCL = factory.createProjectCL();
			
			if(projectCL.commitAuditAgain(project_id)){
				ProjectInfor projectInfor = projectCL.queryProjectInfor(project_id);//获取特定课题编号的课题详细信息
				ProjectAuditInfor auditInfor = projectCL.queryAuditInfor(project_id);//查询审核信息
				
				request.setAttribute("projectInfor", projectInfor);
				request.setAttribute("auditInfor", auditInfor);
				request.getRequestDispatcher("SchoolUser/detailProjectShow.jsp").forward(request, response);
			}else{
				request.getRequestDispatcher("ProjectManagerServlet?type=enter_schoolPros").forward(request, response);
			}
		}else if(type.equals("update_ProjectStage")){//课题阶段信息更改操作处理
			int project_id = Integer.parseInt((String)request.getParameter("project_id"));//课题编号
			String stageJSON = URLDecoder.decode(request.getParameter("stageJSON") , "UTF-8");
			
			List<ProjectStageInfor> stageList = new ArrayList<ProjectStageInfor>();
			
			try {
				JSONArray jsonArray = new JSONArray(stageJSON);
				JSONObject json = null;
				ProjectStageInfor stageInfor = null;
				//将阶段信息封装到类中(解析JSON信息)
				for(int i=0;i<jsonArray.length();i++){
					stageInfor = new ProjectStageInfor();
					json = jsonArray.getJSONObject(i);
					
					stageInfor.setStageId(i+1);
					stageInfor.setProjectId(project_id);
					stageInfor.setStageName(json.getString("stage_name"));
					stageInfor.setTimeLimit(Integer.parseInt(json.getString("stage_timeLimit")));
					stageInfor.setStageDemand(json.getString("stage_demand"));
					stageInfor.setStageFiles(json.getString("stage_filed"));
					stageList.add(stageInfor);
				}
				
				ProjectManageFactoryInterface factory = new ProjectManageFactory();
				ProjectInterface projectCL = factory.createProjectCL();
				
				out = response.getWriter();
				out.print(projectCL.updateProjectStages(stageList));
				
			} catch (JSONException e) {
				e.printStackTrace();
			}
			
			out.close();
		}else if(type.equals("query_detail_project")){//获取课题详细信息（包括阶段信息）
			int project_id = Integer.parseInt((String)request.getParameter("project_id"));//课题编号
			
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectInterface projectCL = factory.createProjectCL();
			ProjectInfor projectInfor = projectCL.queryProjectInfor(project_id);//获取特定课题编号的课题详细信息
			
			request.setAttribute("projectInfor", projectInfor);
			request.getRequestDispatcher("SchoolUser/teaProjectShow.jsp").forward(request, response);
		}else if(type.equals("query_project_inforshow")){//获取课题详细信息显示在学校课题显示页面（包括阶段信息）
			int project_id = Integer.parseInt((String)request.getParameter("project_id"));//课题编号
			
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectInterface projectCL = factory.createProjectCL();
			ProjectInfor projectInfor = projectCL.queryProjectInfor(project_id);//获取特定课题编号的课题详细信息
			
			request.setAttribute("projectInfor", projectInfor);
			request.getRequestDispatcher("SchoolUser/projectInforShow.jsp").forward(request, response);
		}else if(type.equals("query_project_audit")){//显示审核详细信息
			int project_id = Integer.parseInt((String)request.getParameter("project_id"));//课题编号
			
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectInterface projectCL = factory.createProjectCL();
			ProjectInfor projectInfor = projectCL.queryProjectInfor(project_id);//获取特定课题编号的课题详细信息
			ProjectAuditInfor auditInfor = projectCL.queryAuditInfor(project_id);//查询审核信息
			
			request.setAttribute("projectInfor", projectInfor);
			request.setAttribute("auditInfor", auditInfor);
			request.getRequestDispatcher("SchoolUser/detailProjectShow.jsp").forward(request, response);
		}else if(type.equals("query_creater_infor")){//获取课题创建者的详细信息(这里只有教师作为创建者)
			int creater_id = Integer.parseInt((String)request.getParameter("creater_id"));//课题创建者编号
			
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectInterface projectCL = factory.createProjectCL();
			Teacher creater = projectCL.queryProjectCreaterInfor(creater_id);
			
			request.setAttribute("creater_information", creater);
			request.getRequestDispatcher("SchoolUser/projectCreaterInfor.jsp").forward(request, response);
		}else if(type.equals("send_project_audit")){//提交课题审核操作
			//需要处理的操作
			out = response.getWriter();
			int project_id = Integer.parseInt((String)request.getParameter("project_id"));//课题编号
			
			ProjectManageFactory factory = new ProjectManageFactory();
			ProjectInterface projectCL = factory.createProjectCL();
			
			int checkResult = projectCL.checkProjectCompleted(project_id);
			if(checkResult == ProjectInterface.INFORCOMPLETE){//数据完整
				Boolean sendAudit = projectCL.submitProjectInfor(project_id);
				out.print(sendAudit);
			}else if(checkResult == ProjectInterface.INFORNOSTAGE){//没有数据库阶段信息
				out.print("INFORNOSTAGE");
			}else if(checkResult == ProjectInterface.STAGENODETAIL){//课题阶段数据不详细
				out.print("STAGENODETAIL");
			}else{//课题内容不存在
				out.print("INFORNOPROJECT");
			}
			
			out.close();
		}else if(type.equals("enter_schoolPros")){
			//获取显示学校课题详细的页面访问
			int schoolId = Integer.parseInt((String)session.getAttribute("school_id"));
			int proYear = request.getParameter("proYear") == null ? 0 : Integer.parseInt((String)request.getParameter("proYear"));
			
			ProjectInterface projectCL = new ProjectManageFactory().createProjectCL();
			int minYear = projectCL.queryMinProjectYear(schoolId);
			
			request.setAttribute("proYear", proYear+"");
			request.setAttribute("minYear", minYear+"");
			request.getRequestDispatcher("SchoolUser/schoolProjects.jsp").forward(request, response);
		}else if(type.equals("enter_teacherPros")){
			//获取教师个人的课题信息内容
			int teacherId = Integer.parseInt((String)session.getAttribute("user_id"));
			int proYear = request.getParameter("proYear") == null ? 0 : Integer.parseInt((String)request.getParameter("proYear"));
			
			ProjectInterface projectCL = new ProjectManageFactory().createProjectCL();
			int minYear = projectCL.queryTeacherMinYear(teacherId);
			
			request.setAttribute("proYear", proYear+"");
			request.setAttribute("minYear", minYear+"");
			request.getRequestDispatcher("SchoolUser/teacherProjects.jsp").forward(request, response);
		}else if(type.equals("project_recycle")){
			//获取课题编号
			int projectId = Integer.parseInt(request.getParameter("project_id"));
			
			ProjectInterface projectCL = new ProjectManageFactory().createProjectCL();
			out = response.getWriter();
			
			out.print(projectCL.deleteProjectInfor(projectId));
			out.close();
		}else if(type.equals("delete_totally")){
			//完全删除课题信息内容
			int projectId = Integer.parseInt((String)request.getParameter("project_id"));
			
			ProjectInterface projectCL = new ProjectManageFactory().createProjectCL();
			out = response.getWriter();
			
			//返回删除结果信息
			out.print(projectCL.deleteProjectTotally(projectId));
			out.close();
		}else if(type.equals("recover_project")){
			//恢复处于删除状态的课题信息
			int projectId = Integer.parseInt((String)request.getParameter("project_id"));
			
			ProjectInterface projectCL = new ProjectManageFactory().createProjectCL();
			projectCL.recoverProject(projectId);
			
			request.getRequestDispatcher("SchoolUser/recycleProjects.jsp").forward(request, response);
		}else if(type.equals("enter_auditedPros")){
			//显示通过审核的课题信息
			int schoolId = Integer.parseInt((String)session.getAttribute("school_id"));
			int proYear = request.getParameter("proYear") == null ? 0 : Integer.parseInt((String)request.getParameter("proYear"));
			
			ProjectInterface projectCL = new ProjectManageFactory().createProjectCL();
			int minYear = projectCL.queryMinAuditedYear(schoolId);
			
			request.setAttribute("proYear", proYear+"");
			request.setAttribute("minYear", minYear+"");
			request.getRequestDispatcher("SchoolUser/auditedProjects.jsp").forward(request, response);
		}
	}

}
