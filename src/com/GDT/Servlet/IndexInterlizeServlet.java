package com.GDT.Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.GDT.Factory.SchoolManageFactory;
import com.GDT.Factory.UserFactory;
import com.GDT.Interface.*;
import com.GDT.Model.CommonSchoolUser;
import com.GDT.Model.SchoolManageUser;

/*
 * 用户登入后初始化Index页面操作
 * @author zero
 */
public class IndexInterlizeServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/* 先对response返回数据流进行编码等信息的设置 */
		
		HttpSession session = request.getSession();
		
		String type = request.getParameter("type");
		
		if(type.equals("commonSNews")){//获取学生教师学校最新通知信息操作处理实现
            int userId = Integer.parseInt((String)session.getAttribute("user_id"));
			PrintWriter out = response.getWriter();
			
			int schoolId = 1;//学校编号后面使用传参获取
			UserFactoryInterface factory = new UserFactory();
            CommonSUserInterface userCL = factory.createCommonSUserCL();
            CommonSchoolUser user = userCL.queryUserInfo(userId);
			CommonSUserInterface commoncl = factory.createCommonSUserCL();

			String news = commoncl.querySchoolNews(user.getSchoolId());
			
			out.print(news);
			
			out.close();
		}else if(type.equals("adminSNews")){//获取管理员学校最新通知信息操作处理实现
            int adminId = Integer.parseInt((String)session.getAttribute("user_id"));

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            PrintWriter out = response.getWriter();
            ManageSUserInterface commonSUserCL = factory.createManageSUserCL();
            String news = commonSUserCL.querySchoolNews(user.getSchoolId());

            out.print(news);

            out.close();
		}else if(type.equals("commonSUserNews")){//普通学校用户的最新信息查询
			PrintWriter out = response.getWriter();
			int userId = Integer.parseInt((String)session.getAttribute("user_id"));
			
			UserFactoryInterface factory = new UserFactory();
			CommonSUserInterface commoncl = factory.createCommonSUserCL();
			
			String news = commoncl.queryNewInfors(userId, CommonSUserInterface.NEW_UNTREATED);//查询未处理的全部信息
			out.print(news);
			
			out.close();
		}else if(type.equals("ManageSUserNews")){//学校管理员用户的最新信息查询
			
		}else if(type.equals("ManageGUserNews")){//GDT后台用户的最新信息查询
			
		}else if(type.equals("querySchoolCollege")){//获取学校院系以及专业详细信息
			PrintWriter out = response.getWriter();
			
			int schoolId = Integer.parseInt((String)session.getAttribute("school_id"));
			
			SchoolManageFactoryInterface manageFactory = new SchoolManageFactory();
			SchoolCollegeInterface collegeCL = manageFactory.createSchoolCollegeCL();
			
			String json = collegeCL.querySchoolColleges(schoolId);
			out.print(json);
			
			out.close();
		}
	}

}
