package com.GDT.Servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import com.GDT.util.DBConnection;
import com.GDT.util.FileConvert;
import com.GDT.util.FileUploadCL;
import com.GDT.util.UserEventHandler;

/*
 * GDT后台程序初始化信息对象
 * @author zero
 *
 *
 */
public class GDTInitializeServlet extends HttpServlet {
		
	public void init() throws ServletException{
		/* 初始化数据库配置参数 */
		String driver = this.getInitParameter("DRIVER");
		String url = this.getInitParameter("URL");
		String user = this.getInitParameter("USER");
		String password = this.getInitParameter("PASSWORD");
		
		DBConnection.Init(driver, url, user, password);
		
		/* 初始化文件转换配置参数 */
		String serPath = this.getServletConfig().getServletContext().getRealPath("/");//获取服务器配置路径
		FileConvert.initConvert(serPath+"Schoolinfor\\", serPath+"Projectinfor\\", serPath+"Teaminfor\\");
		
		/* 初始化上传控件的配置信息 */
		int sizeShold = this.getInitParameter("SIZETHRESHOLD") == null ? 1024*1024 : Integer.parseInt(this.getInitParameter("SIZETHRESHOLD"));
		String encoding = this.getInitParameter("ENCODING") == null ? "UTF-8" : this.getInitParameter("ENCODING");
		int buffSize = this.getInitParameter("BUFFSIZE") == null ? 1024 : Integer.parseInt(this.getInitParameter("BUFFSIZE"));
		int pictureMaxSize = this.getInitParameter("PICTURE_MAX_SIZE") == null ? 512*1024 : Integer.parseInt(this.getInitParameter("PICTURE_MAX_SIZE"));
		int fileMaxSize = this.getInitParameter("FILE_MAX_SIZE") == null ? 1024*1024 : Integer.parseInt(this.getInitParameter("FILE_MAX_SIZE"));
		String[] pictureTypes = this.getInitParameter("PICTURE_TYPE").split(",");
		String[] fileTypes = this.getInitParameter("FILE_TYPE").split(",");
		
		FileUploadCL.initFileUpload(sizeShold, encoding, buffSize, pictureMaxSize, fileMaxSize, pictureTypes, fileTypes);
		
		/*文件格式有word更改为html
		FileConvertInterface inter = new FileConvert();
		inter.convertSchoolNew(1, 4, "zero3.doc", FileConvertInterface.WORDTYPE);
		*/
	}
}
