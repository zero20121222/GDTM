package com.GDT.Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.GDT.Factory.UserFactory;
import com.GDT.Interface.CommonSUserInterface;
import com.GDT.Interface.ManageSUserInterface;
import com.GDT.Interface.UserFactoryInterface;

/* 
 * 学校用户登入检索Servlet类
 * 
 *
 */
public class SchoolLoginServlet extends HttpServlet {
	private final static String NOR_FILLED = "F";//未填写详细信息
	private final static String FILLED = "T";//已填写详细信息
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request , response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String type = request.getParameter("type");
		if(type.equals("Login_Check")){//教师或者学生登入
			//关于登入的检索验证
			int schoolId = 1;// Integer.parseInt(request.getParameter("schoolId"));
			String username = request.getParameter("user_name");
			String password = request.getParameter("user_password");
			String myCode = request.getParameter("user_code");
			String varifycode = (String)session.getAttribute("verifycode");
			
			PrintWriter out = response.getWriter();
			if(myCode.toLowerCase().equals(varifycode.toLowerCase())){
				UserFactoryInterface factory = new UserFactory();
				//学校普通用户登入操作类接口
				CommonSUserInterface commonCL = factory.createCommonSUserCL();
				int userId = commonCL.doLogin(schoolId, username, password);
				out.print(userId);
				
				session.setAttribute("user_id" , userId+"");
				session.setAttribute("school_id", schoolId+"");
				session.removeAttribute("verifycode");//去除session中的验证码数据
			}else{
				out.print("-1");
			}
			
			out.close();//关闭输出流
			
		}else if(type.equals("Login_main")){//当登入成功后登入到主页面
			int user_id = Integer.parseInt((String)session.getAttribute("user_id"));//获取用户编号
			
			UserFactoryInterface factory = new UserFactory();
			CommonSUserInterface commonCL = factory.createCommonSUserCL();
			String user_type = commonCL.queryUserType(user_id);
			
			/* 获取关于用户是否已经输入详细信息(这个可以通过是否存在真实姓名来判断) */
			String trueName = commonCL.queryTrueName(user_id);
			if(trueName == null){
				request.setAttribute("ifDetail" , NOR_FILLED);
			}else{
				request.setAttribute("ifDetail" , FILLED);
				request.setAttribute("user_trueName", trueName);
			}
			
			if(user_type.equals("S")){//跳转到学生页面
				request.getRequestDispatcher("/SchoolUser/studentIndex.jsp").forward(request , response);
			}else if(user_type.equals("T")){//跳转到教师页面
				request.getRequestDispatcher("/SchoolUser/teacherIndex.jsp").forward(request , response);
			}
			
		}else if(type.equals("Admin_Login")){//学校管理员登入
			int schoolId = 1;// Integer.parseInt(request.getParameter("schoolId"));
			String username = request.getParameter("user_name");
			String password = request.getParameter("user_password");
			String myCode = request.getParameter("user_code");
			String varifycode = (String)session.getAttribute("verifycode");

			PrintWriter out = response.getWriter();
			if(myCode.toLowerCase().equals(varifycode.toLowerCase())){
				UserFactoryInterface factory = new UserFactory();
				ManageSUserInterface manageCL = factory.createManageSUserCL();
				int userId = manageCL.doLogin(schoolId, username, password);
				out.print(userId);
				
				session.setAttribute("user_id" , userId+"");
				session.setAttribute("school_id", schoolId+"");
				session.removeAttribute("verifycode");
			}else{
				out.print("-1");
			}
			
			out.close();//关闭输出流
		}else if(type.equals("Login_amdinIndex")){//登入管理用户主页面
			int user_Id = Integer.parseInt((String)session.getAttribute("user_id"));//学校管理人员Id编号
			
			UserFactoryInterface factory = new UserFactory();
			ManageSUserInterface manageCL = factory.createManageSUserCL();
			String user_type = manageCL.queryUserType(user_Id);
			
			/* 获取关于用户是否已经输入详细信息(这个可以通过是否存在真实姓名来判断) */
			String trueName = manageCL.queryTrueName(user_Id);
			if(trueName == null){
				request.setAttribute("ifDetail" , NOR_FILLED);
			}else{
				request.setAttribute("ifDetail" , FILLED);
				request.setAttribute("user_trueName", trueName);
			}
			
			if(user_type.equals("A")){//管理员类型
				request.getRequestDispatcher("/SchoolAdmin/adminerIndex.jsp").forward(request , response);
			}else if(user_type.equals("E")){//审核人员类型
				request.getRequestDispatcher("/SchoolAdmin/auditerIndex.jsp").forward(request , response);
			}
		}
	}

}
