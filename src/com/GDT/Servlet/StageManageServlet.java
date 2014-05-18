package com.GDT.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.GDT.Factory.ProjectManageFactory;
import com.GDT.Interface.ProjectStageInterface;
import com.GDT.Model.ProjectInfor;
import com.GDT.Model.ProjectStageGuide;
import com.GDT.Model.ProjectStageInfor;
import com.GDT.Model.ProjectStageManage;

/*
 * 团队阶段管理servlet类
 * @author zero
 */
public class StageManageServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request , response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		PrintWriter out = null;
		
		String type = request.getParameter("type");
		if(type.equals("query_team_stages")){//获取团队的课题阶段详细信息内容
			int userId = Integer.parseInt((String)session.getAttribute("user_id"));//用户编号
			
			ProjectStageInterface stageCL = new ProjectManageFactory().createProjectStageCL();
			
			out = response.getWriter();
			out.print(stageCL.queryStageNames(userId));
		}else if(type.equals("query_guide_stages")){//查询教师指导的阶段信息链表
			int userId = Integer.parseInt((String)session.getAttribute("user_id"));//用户编号
			
			ProjectStageInterface stageCL = new ProjectManageFactory().createProjectStageCL();
			
			out = response.getWriter();
			out.print(stageCL.queryStageNamesByTea(userId));
		}else if(type.equals("query_team_stage")){//获得阶段详细信息内容
			int stageId = Integer.parseInt((String)request.getParameter("stageId"));//阶段编号
			int userId = Integer.parseInt((String)session.getAttribute("user_id"));
			
			ProjectStageInterface stageCL = new ProjectManageFactory().createProjectStageCL();
			ProjectInfor projectInfor = stageCL.queryProjectInfor(stageId);			//课题详细信息内容
			ProjectStageInfor stageInfor = stageCL.queryProjectStage(stageId);		//阶段信息
			ProjectStageManage stageManage = stageCL.queryStageManage(stageId);		//课题阶段管理信息内容
			String startTime = stageCL.queryStartTime(userId);
			
			if(stageManage == null){
				//还未开启课题阶段管理
				request.setAttribute("projectInfor", projectInfor);
				request.setAttribute("stageInfor", stageInfor);
				request.setAttribute("startTime", startTime);
				request.getRequestDispatcher("SchoolUser/proStageStart.jsp").forward(request , response);
				
			}else{
				//阶段开启情况下的管理操作
				List<ProjectStageGuide> guideList = stageCL.queryStageGuides(stageId , 0);//阶段指导信息内容显示最新3条记录
				
				//阶段指导信息条数
				int guideNums = stageCL.queryStageGuideNum(stageId);
				
				request.setAttribute("projectInfor", projectInfor);
				request.setAttribute("stageInfor", stageInfor);
				request.setAttribute("stageManage", stageManage);
				request.setAttribute("startTime", startTime);
				request.setAttribute("guideList", guideList);
				request.setAttribute("guideNums", guideNums);
				request.getRequestDispatcher("SchoolUser/proStageManage.jsp").forward(request , response);
			}
		}else if(type.equals("query_stage_guide")){//获得阶段指导信息
			int teamId = Integer.parseInt((String)request.getParameter("teamId"));//团队编号
			int stageId = Integer.parseInt((String)request.getParameter("stageId"));//阶段编号
			
			ProjectStageInterface stageCL = new ProjectManageFactory().createProjectStageCL();
			ProjectInfor projectInfor = stageCL.queryProjectInfor(stageId);			//课题详细信息内容
			ProjectStageInfor stageInfor = stageCL.queryProjectStage(stageId);		//阶段信息
			ProjectStageManage stageManage = stageCL.queryStageManage(stageId);		//课题阶段管理信息内容
			String startTime = stageCL.querySTByTeamId(teamId);
			
			request.setAttribute("projectInfor", projectInfor);
			request.setAttribute("stageInfor", stageInfor);
			request.setAttribute("stageManage", stageManage);
			request.setAttribute("startTime", startTime);
			request.getRequestDispatcher("SchoolUser/proStageGuide.jsp").forward(request , response);
		}else if(type.equals("stage_start_audit")){//阶段课题审核开始
			int teamId = Integer.parseInt((String)request.getParameter("teamId"));//团队编号
			int stageId = Integer.parseInt((String)request.getParameter("stageId"));//阶段编号
			
			ProjectStageInterface stageCL = new ProjectManageFactory().createProjectStageCL();
			stageCL.startStageAudit(teamId, stageId);//本来想设置存储结构或者sql函数实现的但为了方便不采用
			
			request.getRequestDispatcher("StageManageServlet?type=query_team_stage&stageId="+stageId).forward(request , response);
		}
	}

}
