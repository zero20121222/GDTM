package com.GDT.Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.GDT.Factory.ProjectManageFactory;
import com.GDT.Factory.UserFactory;
import com.GDT.Interface.CommonSUserInterface;
import com.GDT.Interface.ManageSUserInterface;
import com.GDT.Interface.ProjectInterface;
import com.GDT.Interface.ProjectManageFactoryInterface;
import com.GDT.Interface.SchoolAdminInterface;
import com.GDT.Interface.SchoolAuditInterface;
import com.GDT.Interface.StudentInterface;
import com.GDT.Interface.TeacherInterface;
import com.GDT.Interface.UserFactoryInterface;
import com.GDT.Model.SchoolAdminer;
import com.GDT.Model.SchoolAuditer;
import com.GDT.Model.Student;
import com.GDT.Model.Teacher;
import com.GDT.util.UserEventBus;

/*
 * 用户管理servlet类
 * @author zero
 */
public class UserManageServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request , response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		PrintWriter out = null;
		
		String type = request.getParameter("type");
		if(type.equals("student_user_infor")){
			int student_id = Integer.parseInt((String)session.getAttribute("user_id"));
			
			UserFactoryInterface userFactory = new UserFactory();
			StudentInterface studentCL = userFactory.createStudentCL();
			Student infor = studentCL.doSelect(student_id);
			
			request.setAttribute("studentInfor", infor);
			request.getRequestDispatcher("SchoolUser/studentUserInfor.jsp").forward(request, response);
		}else if(type.equals("come_update_student")){//学生信息更改
			int student_id = Integer.parseInt((String)session.getAttribute("user_id"));
			
			UserFactoryInterface userFactory = new UserFactory();
			StudentInterface studentCL = userFactory.createStudentCL();
			Student infor = studentCL.doSelect(student_id);
			
			request.setAttribute("studentInfor", infor);
			request.getRequestDispatcher("SchoolUser/studentInforUpdate.jsp").forward(request, response);
		}else if(type.equals("update_student_infor")){//更改学生信息
			Student student = new Student();
			student.setId(Integer.parseInt((String)session.getAttribute("user_id")));
			student.setAge(request.getParameter("user_age"));
			student.setSex(request.getParameter("user_sex"));
			student.setIdCard(request.getParameter("user_card"));
			student.setAddress(request.getParameter("user_address"));
			student.setPhone(request.getParameter("user_phone"));
			student.setEmail(request.getParameter("user_email"));
			student.setQq(request.getParameter("user_qq"));
			student.setResume(request.getParameter("user_resume"));
			
			UserFactoryInterface userFactory = new UserFactory();
			StudentInterface studentCL = userFactory.createStudentCL();
			Boolean result = studentCL.doAlter(student);
			
			request.setAttribute("update_result", result+"");
			request.getRequestDispatcher("UserManageServlet?type=student_user_infor").forward(request, response);
		}else if(type.equals("teacher_user_infor")){
			int teacher_id = Integer.parseInt((String)session.getAttribute("user_id"));
			
			UserFactoryInterface userFactory = new UserFactory();
			TeacherInterface teacherCL = userFactory.createTeacherCL();
			Teacher infor = teacherCL.doSelect(teacher_id);
			
			request.setAttribute("teacherInfor", infor);
			request.getRequestDispatcher("SchoolUser/teacherUserInfor.jsp").forward(request, response);
		}else if(type.equals("come_update_teacher")){//教师信息更改
			int teacher_id = Integer.parseInt((String)session.getAttribute("user_id"));
			
			UserFactoryInterface userFactory = new UserFactory();
			TeacherInterface teacherCL = userFactory.createTeacherCL();
			Teacher infor = teacherCL.doSelect(teacher_id);
			
			request.setAttribute("teacherInfor", infor);
			request.getRequestDispatcher("SchoolUser/teacherInforUpdate.jsp").forward(request, response);
		}else if(type.equals("update_teacher_infor")){//更改教师信息
			Teacher teacher = new Teacher();
			teacher.setId(Integer.parseInt((String)session.getAttribute("user_id")));
			teacher.setOffice(request.getParameter("user_office"));
			teacher.setAge(request.getParameter("user_age"));
			teacher.setSex(request.getParameter("user_sex"));
			teacher.setIdCard(request.getParameter("user_card"));
			teacher.setAddress(request.getParameter("user_address"));
			teacher.setPhone(request.getParameter("user_phone"));
			teacher.setEmail(request.getParameter("user_email"));
			teacher.setQq(request.getParameter("user_qq"));
			teacher.setResume(request.getParameter("user_resume"));
			
			UserFactoryInterface userFactory = new UserFactory();
			TeacherInterface teacherCL = userFactory.createTeacherCL();
			Boolean result = teacherCL.doAlter(teacher);
			
			request.setAttribute("update_result", result+"");
			request.getRequestDispatcher("UserManageServlet?type=teacher_user_infor").forward(request, response);
		}else if(type.equals("auditer_user_infor")){//获取审核人员信息
			int auditer_id = Integer.parseInt((String)session.getAttribute("user_id"));
			
			UserFactoryInterface userFactory = new UserFactory();
			SchoolAuditInterface auditCL = userFactory.createSchoolAuditCL();
			SchoolAuditer infor = auditCL.doSelect(auditer_id);
			
			request.setAttribute("auditerInfor", infor);
			request.getRequestDispatcher("SchoolAdmin/auditerUserInfor.jsp").forward(request, response);
		}else if(type.equals("come_update_auditer")){//审核人员信息更改
			int auditer_id = Integer.parseInt((String)session.getAttribute("user_id"));
			
			UserFactoryInterface userFactory = new UserFactory();
			SchoolAuditInterface auditCL = userFactory.createSchoolAuditCL();
			SchoolAuditer infor = auditCL.doSelect(auditer_id);
			
			request.setAttribute("auditerInfor", infor);
			request.getRequestDispatcher("SchoolAdmin/auditerInforUpdate.jsp").forward(request, response);
		}else if(type.equals("update_auditer_infor")){//更改审核人员信息
			/*
			 * 后期更改成为使用ajax控制-》》需要对于email验证操作然后再提交保存更改操作
			 */
			SchoolAuditer auditer = new SchoolAuditer();
			auditer.setId(Integer.parseInt((String)session.getAttribute("user_id")));
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
			Boolean result = auditCL.doAlter(auditer);
			
			request.setAttribute("update_result", result+"");
			request.getRequestDispatcher("UserManageServlet?type=auditer_user_infor").forward(request, response);
		}else if(type.equals("adminer_user_infor")){
			int adminer_id = Integer.parseInt((String)session.getAttribute("user_id"));

			UserFactoryInterface userFactory = new UserFactory();
			SchoolAdminInterface adminCL = userFactory.createSchoolAdminCL();
			SchoolAdminer infor = adminCL.doSelect(adminer_id);
			
			request.setAttribute("adminInfor", infor);
			request.getRequestDispatcher("SchoolAdmin/adminerUserInfor.jsp").forward(request, response);
		}else if(type.equals("come_update_adminer")){//审核人员信息更改
			int adminer_id = Integer.parseInt((String)session.getAttribute("user_id"));
			
			UserFactoryInterface userFactory = new UserFactory();
			SchoolAdminInterface adminCL = userFactory.createSchoolAdminCL();
			SchoolAdminer infor = adminCL.doSelect(adminer_id);
			
			request.setAttribute("adminInfor", infor);
			request.getRequestDispatcher("SchoolAdmin/adminerInforUpdate.jsp").forward(request, response);
		}else if(type.equals("update_adminer_infor")){//更改管理人员信息
            SchoolAdminer admin = new SchoolAdminer();
            admin.setId(Integer.parseInt((String)session.getAttribute("user_id")));
            admin.setOffice(request.getParameter("user_office"));
            admin.setAge(request.getParameter("user_age"));
            admin.setSex(request.getParameter("user_sex"));
            admin.setIdCard(request.getParameter("user_card"));
            admin.setAddress(request.getParameter("user_address"));
            admin.setPhone(request.getParameter("user_phone"));
            admin.setEmail(request.getParameter("user_email"));
            admin.setQq(request.getParameter("user_qq"));
            admin.setResume(request.getParameter("user_resume"));

            UserFactoryInterface factory = new UserFactory();
            SchoolAdminInterface adminCL = factory.createSchoolAdminCL();
            Boolean result = adminCL.doAlter(admin);

            request.setAttribute("update_result", result+"");
            request.getRequestDispatcher("UserManageServlet?type=adminer_user_infor").forward(request, response);
        }else if(type.equals("check_manager_password")){//检验用户输入的密码是否正确
			int managerId = Integer.parseInt((String)session.getAttribute("user_id"));
			String oldPassword = (String)request.getParameter("old_password");
			
			UserFactoryInterface userFactory = new UserFactory();
			ManageSUserInterface managerCL = userFactory.createManageSUserCL();
			
			//验证输入密码是否正确
			out = response.getWriter();
			out.print(managerCL.checkPassword(managerId, oldPassword));
			out.close();
		}else if(type.equals("update_manager_passowrd")){//管理员&审核人员的密码更改操作
			/*
			 * 后期对于密码需要使用DES加密算法||RSA加密算法
			 */
			int managerId = Integer.parseInt((String)session.getAttribute("user_id"));
			String oldPassword = (String)request.getParameter("old_password");
			String newPassword = (String)request.getParameter("new_password");
			
			UserFactoryInterface userFactory = new UserFactory();
			ManageSUserInterface managerCL = userFactory.createManageSUserCL();
			
			out = response.getWriter();
			//验证输入密码是否正确
			if(managerCL.checkPassword(managerId, oldPassword)){
				//更改为新的密码
				out.print(managerCL.alterPassword(managerId, newPassword));
			}else{
				//表示输入的密码不正确
				out.print("badPW");
			}
			out.close();
		}else if(type.equals("check_scuser_password")){//检验学生或教师输入的密码是否正确
			int managerId = Integer.parseInt((String)session.getAttribute("user_id"));
			String oldPassword = (String)request.getParameter("old_password");
			
			UserFactoryInterface userFactory = new UserFactory();
			CommonSUserInterface commonCL = userFactory.createCommonSUserCL();
			
			//验证输入密码是否正确
			out = response.getWriter();
			out.print(commonCL.checkPassword(managerId, oldPassword));
			out.close();
		}else if(type.equals("update_scuser_passowrd")){//学生&教师的密码更改操作
			/*
			 * 后期对于密码需要使用DES加密算法||RSA加密算法
			 */
			int managerId = Integer.parseInt((String)session.getAttribute("user_id"));
			String oldPassword = (String)request.getParameter("old_password");
			String newPassword = (String)request.getParameter("new_password");
			
			UserFactoryInterface userFactory = new UserFactory();
			CommonSUserInterface commonCL = userFactory.createCommonSUserCL();
			
			out = response.getWriter();
			//验证输入密码是否正确
			if(commonCL.checkPassword(managerId, oldPassword)){
				//更改为新的密码
				out.print(commonCL.alterPassword(managerId, newPassword));
			}else{
				//表示输入的密码不正确
				out.print("badPW");
			}
			out.close();
		}else if(type.equals("query_student_infor")){//获取学生人员的详细信息
			int student_id = Integer.parseInt(request.getParameter("user_id"));
			
			UserFactoryInterface userFactory = new UserFactory();
			StudentInterface studentCL = userFactory.createStudentCL();
			Student infor = studentCL.doSelect(student_id);
			
			request.setAttribute("studentInfor", infor);
			request.getRequestDispatcher("SchoolUser/studentUserInfor.jsp").forward(request, response);
		}else if(type.equals("query_teacher_infor")){//获取教师人员的详细信息
			int teacher_id = Integer.parseInt(request.getParameter("user_id"));
			
			UserFactoryInterface userFactory = new UserFactory();
			TeacherInterface teacherCL = userFactory.createTeacherCL();
			Teacher infor = teacherCL.doSelect(teacher_id);
			
			request.setAttribute("teacherInfor", infor);
			request.getRequestDispatcher("SchoolUser/teacherUserInfor.jsp").forward(request, response);
		}
	}
}
