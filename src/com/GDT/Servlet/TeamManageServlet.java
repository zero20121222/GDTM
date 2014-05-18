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
import com.GDT.Factory.UserFactory;
import com.GDT.Interface.ProjectInterface;
import com.GDT.Interface.ProjectManageFactoryInterface;
import com.GDT.Interface.StudentInterface;
import com.GDT.Interface.TeacherInterface;
import com.GDT.Interface.UserFactoryInterface;
import com.GDT.Model.ProjectInfor;
import com.GDT.Model.Student;
import com.GDT.Model.Teacher;
import com.GDT.Model.TeamRelation;

/*
 * 团队信息管理servlet类
 * @author zero
 */
public class TeamManageServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request , response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		PrintWriter out = null;
		
		String type = request.getParameter("type");
		if(type.equals("enter_select_project")){//获取课题详细信息显示在学校课题显示页面（包括阶段信息）
			int project_id = Integer.parseInt((String)request.getParameter("project_id"));//课题编号
			
			ProjectManageFactoryInterface factory = new ProjectManageFactory();
			ProjectInterface projectCL = factory.createProjectCL();
			ProjectInfor projectInfor = projectCL.queryProjectInfor(project_id);//获取特定课题编号的课题详细信息
			
			request.setAttribute("projectInfor", projectInfor);
			request.getRequestDispatcher("SchoolUser/projectSelectShow.jsp").forward(request, response);
		}else if(type.equals("check_enter_team")){//查询用户是否已有属于的团队
			int user_id = Integer.parseInt((String)session.getAttribute("user_id"));
			
			StudentInterface studentCL = new UserFactory().createStudentCL();
			
			out = response.getWriter();
			out.print(studentCL.queryTeamerType(user_id));
			out.close();
		}else if(type.equals("query_guide_teams")){//获取教师指导的学生团队信息内容
			int user_id = Integer.parseInt((String)session.getAttribute("user_id"));
			
			TeacherInterface teacherCL = new UserFactory().createTeacherCL();
			
			out = response.getWriter();
			out.print(teacherCL.queryGuideTeams(user_id));;
			out.close();
		}else if(type.equals("query_guide_teamInfor")){//通过队长编号查询团队详细信息内容
			int user_id = Integer.parseInt((String)request.getParameter("teamerId"));
			
			StudentInterface studentCL = new UserFactory().createStudentCL();
			List<Student> studentList = studentCL.queryTeamerStus(user_id);//通过用户编号查询团队人员信息
			
			Teacher teacherInfor = studentCL.queryTeamerTea(user_id);//通过用户编号查询团队教师信息
			
			ProjectInfor projectInfor = studentCL.queryProjectByTeamerId(user_id);
			
			request.setAttribute("studentList", studentList);
			request.setAttribute("teacherInfor", teacherInfor);
			request.setAttribute("projectInfor", projectInfor);
			
			request.getRequestDispatcher("SchoolUser/guideTeamerInfor.jsp").forward(request, response);
		}else if(type.equals("query_teamers_infor")){//查询显示团队人员信息内容
			int user_id = Integer.parseInt((String)session.getAttribute("user_id"));
			
			StudentInterface studentCL = new UserFactory().createStudentCL();
			List<Student> studentList = studentCL.queryTeamerStus(user_id);//通过用户编号查询团队人员信息
			
			Teacher teacherInfor = studentCL.queryTeamerTea(user_id);//通过用户编号查询团队教师信息
			
			request.setAttribute("studentList", studentList);
			request.setAttribute("teaInfor", teacherInfor);
			
			request.getRequestDispatcher("SchoolUser/teamersInfor.jsp").forward(request, response);
		}else if(type.equals("team_project_infor")){//查询显示团队课题信息内容
			int user_id = Integer.parseInt((String)session.getAttribute("user_id"));
			
			StudentInterface studentCL = new UserFactory().createStudentCL();
			ProjectInfor projectInfor = studentCL.queryProjectByTeamerId(user_id);//获取特定课题编号的课题详细信息
			
			request.setAttribute("projectInfor", projectInfor);
			//这个有后期再处理到底需要在界面显示哪些数据信息内容
			request.getRequestDispatcher("SchoolUser/teamProjectInfor.jsp").forward(request, response);
		}else if(type.equals("manage_teamers_infor")){//团队人员信息管理
			int user_id = Integer.parseInt((String)session.getAttribute("user_id"));
			
			StudentInterface studentCL = new UserFactory().createStudentCL();
			List<Student> studentList = studentCL.queryAllTeamerStus(user_id);
			
			List<Teacher> teacherList = studentCL.queryAllTeamerTea(user_id);
			
			ProjectInfor projectInfor = studentCL.queryProjectByTeamerId(user_id);
			
			request.setAttribute("studentList", studentList);
			request.setAttribute("teacherList", teacherList);
			request.setAttribute("projectInfor", projectInfor);
			
			request.getRequestDispatcher("SchoolUser/teamersManage.jsp").forward(request, response);
		}else if(type.equals("manage_studentTeamer")){//管理团队学生
			int rel_id = Integer.parseInt(request.getParameter("rel_id"));//得到用户关系编号
			
			UserFactoryInterface userFactory = new UserFactory();
			StudentInterface studentCL = userFactory.createStudentCL();
			Student infor = studentCL.queryStuByRelation(rel_id);
			
			//获取用户的最近一次对于学生的团队请求信息内容
			TeamRelation relation = studentCL.queryTeamRelation(rel_id);
			
			request.setAttribute("studentInfor", infor);
			request.setAttribute("teamRelation", relation);
			request.getRequestDispatcher("SchoolUser/updateStudentTeamer.jsp").forward(request, response);
		}else if(type.equals("manage_teacherTeamer")){//管理团队指导教师
			int rel_id = Integer.parseInt(request.getParameter("rel_id"));
			
			UserFactoryInterface userFactory = new UserFactory();
			StudentInterface studentCL = userFactory.createStudentCL();
			Teacher infor = studentCL.queryTeaByRelation(rel_id);
			
			TeamRelation relation = studentCL.queryTeamRelation(rel_id);
			
			request.setAttribute("teacherInfor", infor);
			request.setAttribute("teamRelation", relation);
			request.getRequestDispatcher("SchoolUser/updateTeacherTeamer.jsp").forward(request, response);
		}
	}

}
