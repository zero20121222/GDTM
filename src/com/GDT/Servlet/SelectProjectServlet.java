package com.GDT.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SelectProjectServlet extends HttpServlet {

	/*
	 * 这个是一个关于课题选择的Servlet对象
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request , response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		/*对于课题信息搜索的显示操作*/
		String type = request.getParameter("type");
		if(type.equals("stu_select_pro")){
			/*这样比较复杂还不如使用DWR框架进行分页处理来得方便*/
			/*这个还需要处理一个关于将java对象，或者List|Map对象转换成为JSON数据格式的一个算法*/
			 String result = "[{pro_title:'计算机开发技术更新',pro_id:'1',pro_picture:'../images/school_admin.png',"+
							 "pro_username:'赵宇',pro_userid:'1',pro_num:'5',pro_collage:'信息工程系',pro_work:'大',"+
							 "pro_level:'5',pro_download:'../images/'},"+
							 "[{pro_title:'计算机开发技术更新',pro_id:'1',pro_picture:'../images/school_admin.png',"+
							 "pro_username:'赵宇',pro_userid:'1',pro_num:'5',pro_collage:'信息工程系',pro_work:'大',"+
							 "pro_level:'5',pro_download:'../images/'},"+
							 "[{pro_title:'计算机开发技术更新',pro_id:'1',pro_picture:'../images/school_admin.png',"+
							 "pro_username:'赵宇',pro_userid:'1',pro_num:'5',pro_collage:'信息工程系',pro_work:'大',"+
							 "pro_level:'5',pro_download:'../images/'}]";
			 
		}
	}

}
