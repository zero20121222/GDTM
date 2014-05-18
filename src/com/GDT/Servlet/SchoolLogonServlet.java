package com.GDT.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.GDT.Factory.UserFactory;
import com.GDT.Interface.SchoolAdminInterface;
import com.GDT.Interface.SchoolAuditInterface;
import com.GDT.Interface.StudentInterface;
import com.GDT.Interface.TeacherInterface;
import com.GDT.Interface.UserFactoryInterface;
import com.GDT.Model.SchoolAdminer;
import com.GDT.Model.SchoolAuditer;
import com.GDT.Model.Student;
import com.GDT.Model.Teacher;

/*
 * 用于处理学校用户详细信息注册的servlet
 */
public class SchoolLogonServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String type = request.getParameter("type");
		if(type.equals("StudentLogon")){//学生详细信息注册
			Student student = new Student();
			student.setId(Integer.parseInt((String)session.getAttribute("user_id")));
			student.setRealName(request.getParameter("true_name"));
			student.setCollege(request.getParameter("user_college"));
			student.setMajor(request.getParameter("user_major"));
			student.setAge(request.getParameter("user_age"));
			student.setSex(request.getParameter("user_sex"));
			student.setIdCard(request.getParameter("user_card"));
			student.setAddress(request.getParameter("user_address"));
			student.setPhone(request.getParameter("user_phone"));
			student.setEmail(request.getParameter("user_email"));
			student.setQq(request.getParameter("user_qq"));
			student.setResume(request.getParameter("user_resume"));
			
			UserFactoryInterface factory = new UserFactory();
			StudentInterface studentCL = factory.createStudentCL();
			Boolean result = studentCL.saveStudentInfor(student);
			
			request.setAttribute("save_result", result+"");
			request.getRequestDispatcher("SchoolUser/studentLogon.jsp").forward(request, response);
		}else if(type.equals("TeacherLogon")){//教师详细信息注册
			Teacher teacher = new Teacher();
			teacher.setId(Integer.parseInt((String)session.getAttribute("user_id")));
			teacher.setRealName(request.getParameter("true_name"));
			teacher.setCollege(request.getParameter("user_college"));
			teacher.setPosition(request.getParameter("user_position"));
			teacher.setDegree(request.getParameter("user_degree"));
			teacher.setOffice(request.getParameter("user_office"));
			teacher.setAge(request.getParameter("user_age"));
			teacher.setSex(request.getParameter("user_sex"));
			teacher.setIdCard(request.getParameter("user_card"));
			teacher.setAddress(request.getParameter("user_address"));
			teacher.setPhone(request.getParameter("user_phone"));
			teacher.setEmail(request.getParameter("user_email"));
			teacher.setQq(request.getParameter("user_qq"));
			teacher.setResume(request.getParameter("user_resume"));
			
			UserFactoryInterface factory = new UserFactory();
			TeacherInterface teacherCL = factory.createTeacherCL();
			Boolean result = teacherCL.saveTeacherInfor(teacher);
			
			request.setAttribute("save_result", result+"");
			request.getRequestDispatcher("SchoolUser/teacherLogon.jsp").forward(request, response);
		}else if(type.equals("AuditerLogon")){//审核人员信息注册
			SchoolAuditer auditer = new SchoolAuditer();
			auditer.setId(Integer.parseInt((String)session.getAttribute("user_id")));
			auditer.setRealName(request.getParameter("true_name"));
			auditer.setCollege(request.getParameter("user_college"));
			auditer.setPosition(request.getParameter("user_position"));
			auditer.setDegree(request.getParameter("user_degree"));
			auditer.setOffice(request.getParameter("user_office"));
			auditer.setAge(request.getParameter("user_age"));
			auditer.setSex(request.getParameter("user_sex"));
			auditer.setIdCard(request.getParameter("user_card"));
			auditer.setAddress(request.getParameter("user_address"));
			auditer.setPhone(request.getParameter("user_phone"));
			auditer.setEmail(request.getParameter("user_email"));
			auditer.setQq(request.getParameter("user_qq"));
			auditer.setResume(request.getParameter("user_resume"));
			
			UserFactoryInterface factory = new UserFactory();
			SchoolAuditInterface auditCL = factory.createSchoolAuditCL();
			Boolean result = auditCL.saveAuditerInfor(auditer);
			
			request.setAttribute("save_result", result+"");
			request.getRequestDispatcher("SchoolAdmin/auditerLogon.jsp").forward(request, response);
		}else if(type.equals("AdminerLogon")){//管理人员信息注册
			SchoolAdminer adminer = new SchoolAdminer();
			adminer.setId(Integer.parseInt((String)session.getAttribute("user_id")));
			adminer.setRealName(request.getParameter("true_name"));
			adminer.setCollege(request.getParameter("user_college"));
			adminer.setPosition(request.getParameter("user_position"));
			adminer.setDegree(request.getParameter("user_degree"));
			adminer.setOffice(request.getParameter("user_office"));
			adminer.setAge(request.getParameter("user_age"));
			adminer.setSex(request.getParameter("user_sex"));
			adminer.setIdCard(request.getParameter("user_card"));
			adminer.setAddress(request.getParameter("user_address"));
			adminer.setPhone(request.getParameter("user_phone"));
			adminer.setEmail(request.getParameter("user_email"));
			adminer.setQq(request.getParameter("user_qq"));
			adminer.setResume(request.getParameter("user_resume"));
			
			UserFactoryInterface factory = new UserFactory();
			SchoolAdminInterface adminCL = factory.createSchoolAdminCL();
			Boolean result = adminCL.saveAdminerInfor(adminer);
			
			request.setAttribute("save_result", result+"");
			request.getRequestDispatcher("SchoolAdmin/adminerLogon.jsp").forward(request, response);
		}
	}
}
