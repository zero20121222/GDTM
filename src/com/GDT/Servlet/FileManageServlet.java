package com.GDT.Servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException;

import com.GDT.Exception.FileFormatException;
import com.GDT.Factory.ProjectManageFactory;
import com.GDT.Interface.ProjectInterface;
import com.GDT.Interface.ProjectManageFactoryInterface;
import com.GDT.Interface.ProjectStageInterface;
import com.GDT.Model.TeamStageFile;
import com.GDT.util.FileUploadCL;
import com.GDT.util.FileUploadInterface;

/*
 * 用于文件管理的servlet(用于实现返回相对应的文件输出流到相对应的页面中去)
 */
public class FileManageServlet extends HttpServlet {
	private final static int BUFFER_SIZE = 2048;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//设置页面不缓存
		
        HttpSession session = request.getSession();
        
        String type = request.getParameter("type");
        if(type.equals("schoolNewFile")){//学校最新通知信息文件内容
        	String schoolId = request.getParameter("schoolId");
        	String newId = request.getParameter("newId");
        	String fileName = request.getParameter("fileName");
        	
        	String path = request.getContextPath();//得到系统根目录名称
        	//得到系统path
        	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"+"Schoolinfor/";
        	String filePath = basePath+schoolId+"/News/"+newId+"/"+fileName;
        	
        	BufferedOutputStream output = null;
        	BufferedInputStream input = null;
        	try{
	        	ServletOutputStream servletout = response.getOutputStream();//得到response的输出流对象
	        	output = new BufferedOutputStream(servletout);
	        	
	        	input = new BufferedInputStream(new URL(filePath).openStream());
	        	
	        	byte[] buffer = new byte[BUFFER_SIZE];
	        	int bytesRead = 0;
	        	
	        	while((bytesRead = input.read(buffer , 0, buffer.length)) != -1){
	        		output.write(buffer , 0, bytesRead);//向输出流写入数据到客户端
	        	}
        	}catch(Exception e){
        		e.printStackTrace();
        	}finally{
            	//关闭输入流与输出流
        		if(output != null){
        			output.close();
        		}
        		if(input != null){
        			input.close();
        		}
        	}
        }else if(type.equals("projectUploadPicture")){//课题图片上传操作
        	response.setContentType("text/html");//这个是用于解决关于IE中运行servlet返回的javascript代码乱码问题
            PrintWriter out = response.getWriter();
            
        	int school_id = Integer.parseInt((String)session.getAttribute("school_id"));
        	int user_id = Integer.parseInt((String)session.getAttribute("user_id"));
        	int uploadID = Integer.parseInt((String)request.getParameter("uploadID"));//上传组件对象编号
        	String oldFileName = URLDecoder.decode(request.getParameter("oldFileName"), "UTF-8");//用于删除的文件名称
			
        	String path = getServletConfig().getServletContext().getRealPath("/");//得到系统根目录
			String savePath = path+"ProjectInfor\\"+school_id+"\\"+user_id;
        	
        	FileUploadInterface fileUpload = new FileUploadCL();
        	try {
        		//删除已上传的阶段文件
        		if(!oldFileName.equals("null")){
        			fileUpload.deleteUploadFile(savePath+"\\"+oldFileName);
        		}
        		
				String result = fileUpload.uploadPicture(savePath, request);
				
				String showPictureUrl = "ProjectInfor/"+school_id+"/"+user_id+"/"+result;//返回图片相对路径
				out.print("<script>parent.uploadFactory.resultView("+uploadID+" , '图片上传成功!', '"+showPictureUrl+"');</script>");
			} catch (SizeLimitExceededException e) {
				out.print("<script>parent.uploadFactory.errorView("+uploadID+" , '文件最大上传大小为512kb');</script>");
			} catch (FileFormatException e) {
				out.print("<script>parent.uploadFactory.errorView("+uploadID+" , '文件格式不正确必需为图片格式');</script>");
			} catch (FileUploadException e) {
				out.print("<script>parent.uploadFactory.errorView("+uploadID+" , '文件上传异常请确认...');</script>");
			}finally{
	        	out.close();
			}
        }else if(type.equals("projectUploadFile")){//课题文件上传操作
        	response.setContentType("text/html");
        	PrintWriter out = response.getWriter();
        	
        	int school_id = Integer.parseInt((String)session.getAttribute("school_id"));
        	int user_id = Integer.parseInt((String)session.getAttribute("user_id"));
        	String oldFileName = URLDecoder.decode(request.getParameter("oldFileName"), "UTF-8");//用于删除的文件名称
			
        	String path = getServletConfig().getServletContext().getRealPath("/");//得到系统根目录
			String savePath = path+"ProjectInfor\\"+school_id+"\\"+user_id;
        	
        	FileUploadInterface fileUpload = new FileUploadCL();
        	try {
        		//删除已上传的阶段文件
        		if(!oldFileName.equals("null")){
        			fileUpload.deleteUploadFile(savePath+"\\"+oldFileName);
        		}
        		
				String result = fileUpload.uploadFile(savePath, request);
				
				String showPictureUrl = "ProjectInfor/"+school_id+"/"+user_id+"/"+result;//返回图片相对路径
				out.print("<script>parent.upfileObj.successUpload('文件上传成功!');</script>");
			} catch (SizeLimitExceededException e) {
				out.print("<script>parent.upfileObj.errorView('文件最大上传大小为1Mb...');</script>");
			} catch (FileFormatException e) {
				out.print("<script>parent.upfileObj.errorView('文件格式不正确...');</script>");
			} catch (FileUploadException e) {
				out.print("<script>parent.upfileObj.errorView('文件上传异常请确认...');</script>");
			}finally{
	        	out.close();
			}
        }else if(type.equals("projectStageUploadFile")){//课题阶段文件上传操作
        	response.setContentType("text/html");
        	PrintWriter out = response.getWriter();
        	
        	int school_id = Integer.parseInt((String)session.getAttribute("school_id"));
        	int user_id = Integer.parseInt((String)session.getAttribute("user_id"));
        	int project_id = Integer.parseInt((String)request.getParameter("project_id"));//课题编号
        	int uploadID = Integer.parseInt((String)request.getParameter("uploadID"));
        	String oldFileName = URLDecoder.decode(request.getParameter("oldFileName"), "UTF-8");//用于删除的文件名称
			
        	//为了减少后台服务器的压力将上传的旧文件删除
        	String path = getServletConfig().getServletContext().getRealPath("/");//得到系统根目录
			String savePath = path+"ProjectInfor\\"+school_id+"\\"+user_id+"\\"+project_id;
			
        	FileUploadInterface fileUpload = new FileUploadCL();
        	try {
        		//删除已上传的阶段文件
        		if(!oldFileName.equals("null")){
        			fileUpload.deleteUploadFile(savePath+"\\"+oldFileName);
        		}
        		
				String result = fileUpload.uploadFile(savePath, request);
				
				out.print("<script>parent.uploadFactory.resultView("+uploadID+" , '文件上传成功!');</script>");
			} catch (SizeLimitExceededException e) {
				out.print("<script>parent.uploadFactory.errorView("+uploadID+" , '文件最大上传大小为1Mb...');</script>");
			} catch (FileFormatException e) {
				out.print("<script>parent.uploadFactory.errorView("+uploadID+" , '文件格式不正确...');</script>");
			} catch (Exception e) {
				out.print("<script>parent.uploadFactory.errorView("+uploadID+" , '文件上传异常请确认...');</script>");
			}finally{
	        	out.close();
			}
        }else if(type.equals("stageFileUpload")){//课题阶段学生上传文件
        	response.setContentType("text/html");
        	PrintWriter out = response.getWriter();
        	
        	int user_id = Integer.parseInt((String)session.getAttribute("user_id"));
        	int team_id = Integer.parseInt((String)request.getParameter("team_id"));
        	int stage_id = Integer.parseInt((String)request.getParameter("stage_id"));
        	String oldFileName = URLDecoder.decode(request.getParameter("oldFileName"), "UTF-8");//用于删除的文件名称
			
        	String path = getServletConfig().getServletContext().getRealPath("/");//得到系统根目录
			String savePath = path+"StageFiles\\"+team_id+"\\"+stage_id;
        	
        	FileUploadInterface fileUpload = new FileUploadCL();
        	try {
        		//删除已上传的阶段文件
        		if(!oldFileName.equals("null")){
        			fileUpload.deleteUploadFile(savePath+"\\"+oldFileName);
        		}
        		
        		String[] allowType = {"jpg", "jpeg", "gif","png","doc","docx","txt","xls","ppt","pptx","vsd","tgz","tar","gz","zip","rar"};
        		//最多上传10MB的文件
				String fileName = fileUpload.uploadFile(savePath, allowType, 10*1024*1024, request);
				
				if(!fileName.equals("")){
					//记录上传文件数据信息内容
					TeamStageFile stageFile = new TeamStageFile();
					stageFile.setTeamId(team_id);
					stageFile.setStageId(stage_id);
					stageFile.setFileName(fileName);
					stageFile.setFileUrl("StageFiles\\"+team_id+"\\"+stage_id);//文档保存相对路径
					stageFile.setSenderId(user_id);
					
					ProjectStageInterface stageCL = new ProjectManageFactory().createProjectStageCL();
					stageCL.createStageFile(stageFile);
				}
				
				out.print("<script>parent.upfileObj.successUpload('文件上传成功!');parent.upfileObj.stageFileObj.loadStageFiles(parent.upfileObj.stageFileObj);</script>");
			} catch (SizeLimitExceededException e) {
				out.print("<script>parent.upfileObj.errorView('文件最大上传大小为10Mb...');</script>");
			} catch (FileFormatException e) {
				out.print("<script>parent.upfileObj.errorView('文件格式不正确...');</script>");
			} catch (FileUploadException e) {
				out.print("<script>parent.upfileObj.errorView('文件上传异常请确认...');</script>");
			}finally{
	        	out.close();
			}
        }else if(type.equals("downProjectFile")){//这个是指课题普通文件下载不设置很高的安全级别
        	int project_id = Integer.parseInt((String)request.getParameter("project_id"));
        	String filename = (String)request.getParameter("filename");
        	response.addHeader("Content-Disposition","attachment;filename=" + filename);
        	
        	BufferedOutputStream output = null;
        	BufferedInputStream input = null;
        	try{
	        	String path = getServletConfig().getServletContext().getRealPath("/");
	        	ProjectManageFactoryInterface factory = new ProjectManageFactory();
				ProjectInterface projectCL = factory.createProjectCL();
				String downPath = path + projectCL.queryProjectFilePath(project_id);//获取文件的下载路径
				
				output = new BufferedOutputStream(response.getOutputStream());
				
				input = new BufferedInputStream(new FileInputStream(downPath));
				byte[] buffer = new byte[BUFFER_SIZE];
				int bytesRead = 0;
				
				while((bytesRead = input.read(buffer , 0, buffer.length)) != -1){
					output.write(buffer , 0, bytesRead);
				}
        	}catch(Exception e){
        		e.printStackTrace();
        	}finally{
        		if(output != null){
        			output.close();
        		}
        		if(input != null){
        			input.close();
        		}
        	}
        }else if(type.equals("downProjectStageFile")){//返回一个课题阶段文件流对象（实现文件的下载功能）
        	int stage_id = Integer.parseInt((String)request.getParameter("stage_id"));
        	String filename = (String)request.getParameter("filename");
        	response.addHeader("Content-Disposition","attachment;filename=" + filename);
        	
        	BufferedOutputStream output = null;
        	BufferedInputStream input = null;
        	try{
	        	String path = getServletConfig().getServletContext().getRealPath("/");
	        	ProjectManageFactoryInterface factory = new ProjectManageFactory();
				ProjectStageInterface stageCL = factory.createProjectStageCL();
				
				String downPath = path + "/" + stageCL.queryStageFilePath(stage_id);
				
				output = new BufferedOutputStream(response.getOutputStream());
				input = new BufferedInputStream(new FileInputStream(downPath));
				
				byte[] buffer = new byte[BUFFER_SIZE];
				int bytesRead = 0;
				
				while((bytesRead = input.read(buffer , 0, buffer.length)) != -1){
					output.write(buffer , 0, bytesRead);
				}
        	}catch(Exception e){
        		e.printStackTrace();
        	}finally{
        		if(output != null){
        			output.close();
        		}
        		if(input != null){
        			input.close();
        		}
        	}
        }else if(type.equals("stageFileDownload")){//下载学生阶段文档信息
        	int team_id = Integer.parseInt((String)request.getParameter("team_id"));
        	int stage_id = Integer.parseInt((String)request.getParameter("stage_id"));
        	String filename = (String)request.getParameter("filename");
        	response.addHeader("Content-Disposition","attachment;filename=" + filename);
        	
        	BufferedOutputStream output = null;
        	BufferedInputStream input = null;
        	try{
	        	String path = getServletConfig().getServletContext().getRealPath("/");
	        	ProjectManageFactoryInterface factory = new ProjectManageFactory();
				ProjectStageInterface stageCL = factory.createProjectStageCL();
				
				TeamStageFile stageFile = stageCL.queryStageFile(team_id , stage_id, filename);
				String downPath = path + "/" + stageFile.getFileUrl() + "/" + stageFile.getFileName();
				
				output = new BufferedOutputStream(response.getOutputStream());
				input = new BufferedInputStream(new FileInputStream(downPath));
				
				byte[] buffer = new byte[BUFFER_SIZE];
				int bytesRead = 0;
				
				while((bytesRead = input.read(buffer , 0, buffer.length)) != -1){
					output.write(buffer , 0, bytesRead);
				}
        	}catch(Exception e){
        		e.printStackTrace();
        	}finally{
        		if(output != null){
        			output.close();
        		}
        		if(input != null){
        			input.close();
        		}
        	}
        }
	}
}
