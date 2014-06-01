package com.GDT.Servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.GDT.Factory.NewsFactory;
import com.GDT.Factory.UserFactory;
import com.GDT.Interface.*;
import com.GDT.Model.SchoolManageUser;
import com.GDT.Model.SchoolNew;
import com.GDT.Model.SchoolUsersFile;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException;

import com.GDT.Exception.FileFormatException;
import com.GDT.Factory.ProjectManageFactory;
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
        	int newId = Integer.parseInt(request.getParameter("newId"));

            String path = getServletConfig().getServletContext().getRealPath("/")+"Schoolinfor/";
        	
        	BufferedOutputStream output = null;
        	BufferedInputStream input = null;
            try{
                NewsFactoryInterface newsFactory = new NewsFactory();
                SchoolNewInterface newCL = newsFactory.createSchoolNewCL();
                SchoolNew schoolNew = newCL.querySchoolNew(newId);

                String fileName = null;
                if(request.getParameter("downloadWay") != null){
                    //下载模式
                    fileName = schoolNew.getContentFile();
                    //浏览器传输的时候识别的事iso-8859-1编码需要将文件名转码
                    response.addHeader("Content-Disposition","attachment;filename=" + new String(fileName.getBytes("UTF-8"),"iso-8859-1"));
                }else{
                    //显示模式
                    if(schoolNew.getContentFile().indexOf(".doc") != -1){
                        fileName = schoolNew.getContentFile().replace(".doc" , ".html");
                    }else{
                        fileName = schoolNew.getContentFile();
                    }
                }



                String filePath = path+schoolId+"/News/"+fileName;
	        	ServletOutputStream servletout = response.getOutputStream();//得到response的输出流对象
	        	output = new BufferedOutputStream(servletout);
	        	
	        	input = new BufferedInputStream(new FileInputStream(filePath));
	        	
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
			String savePath = FileUploadCL.queryFilePath(path , "ProjectInfor", school_id+"", user_id+"");
        	
        	FileUploadInterface fileUpload = new FileUploadCL();
        	try {
        		//删除已上传的阶段文件
        		if(!oldFileName.equals("null")){
        			fileUpload.deleteUploadFile(FileUploadCL.queryFilePath(savePath , oldFileName));
        		}
        		
				String result = fileUpload.uploadPicture(savePath, FileUploadCL.PICTURE_TYPE, 1024*1024, 120, 150, request);
				
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
			String savePath = FileUploadCL.queryFilePath(path , "ProjectInfor", school_id+"", user_id+"");
        	
        	FileUploadInterface fileUpload = new FileUploadCL();
        	try {
        		//删除已上传的阶段文件
        		if(!oldFileName.equals("null")){
        			fileUpload.deleteUploadFile(FileUploadCL.queryFilePath(savePath , oldFileName));
        		}
        		
				fileUpload.uploadFile(savePath, request);
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
			String savePath = FileUploadCL.queryFilePath(path , "ProjectInfor", school_id+"", user_id+"", project_id+"");
			
        	FileUploadInterface fileUpload = new FileUploadCL();
        	try {
        		//删除已上传的阶段文件
        		if(!oldFileName.equals("null")){
        			fileUpload.deleteUploadFile(FileUploadCL.queryFilePath(savePath , oldFileName));
        		}
        		
				fileUpload.uploadFile(savePath, request);
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
			String savePath = FileUploadCL.queryFilePath(path , "StageFiles", team_id+"", stage_id+"");
        	
        	FileUploadInterface fileUpload = new FileUploadCL();
        	try {
        		//删除已上传的阶段文件
        		if(!oldFileName.equals("null")){
        			fileUpload.deleteUploadFile(FileUploadCL.queryFilePath(savePath , oldFileName));
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
					stageFile.setFileUrl(FileUploadCL.queryFilePath("StageFiles", team_id+"", stage_id+""));//文档保存相对路径
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
        	String filename = URLDecoder.decode(request.getParameter("filename"), "UTF-8");
        	response.addHeader("Content-Disposition","attachment;filename=" + new String(filename.getBytes("UTF-8"),"iso-8859-1"));
        	
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
        }else if(type.equals("userFilesUpLoad")){//学校数据源上传操作
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            int user_id = Integer.parseInt((String)session.getAttribute("user_id"));
            String fileType = request.getParameter("fileType");
            Boolean autoLoad = Boolean.parseBoolean(request.getParameter("autoLoad"));
            String oldFileName = URLDecoder.decode(request.getParameter("oldFileName"), "UTF-8");//用于删除的文件名称

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(user_id);

            String path = getServletConfig().getServletContext().getRealPath("/");//得到系统根目录
            String savePath = FileUploadCL.queryFilePath(path , "Schoolinfor", user.getSchoolId()+"", "UserFiles");

            FileUploadInterface fileUpload = new FileUploadCL();
            try {
                if(!oldFileName.equals("null")){
                    fileUpload.deleteUploadFile(FileUploadCL.queryFilePath(savePath , oldFileName));
                }

                String[] allowType = {"xls", "xlsx"};
                //最多上传10MB的文件
                String fileName = fileUpload.uploadFile(savePath, allowType, 10*1024*1024, request);

                if(!fileName.equals("")){
                    //记录上传文件数据信息内容
                    SchoolUsersFile usersFile = new SchoolUsersFile();
                    usersFile.setSchoolId(user.getSchoolId());
                    usersFile.setName(fileName);
                    usersFile.setPath(FileUploadCL.queryFilePath("Schoolinfor", user.getSchoolId()+"", "UserFiles"));
                    usersFile.setType(fileType);

                    //保存学校数据文档信息
                    SchoolAdminInterface adminCL = factory.createSchoolAdminCL();
                    adminCL.saveSchoolUsersFile(usersFile , autoLoad, FileUploadCL.queryFilePath(savePath, fileName));
                }

                out.print("<script>parent.upfileObj.successUpload('文件上传成功!');</script>");
            } catch (SizeLimitExceededException e) {
                out.print("<script>parent.upfileObj.errorView('文件最大上传大小为10Mb...');</script>");
            } catch (FileFormatException e) {
                out.print("<script>parent.upfileObj.errorView('文件格式不正确只允许xls&xlsx...');</script>");
            } catch (FileUploadException e) {
                out.print("<script>parent.upfileObj.errorView('文件上传异常请确认...');</script>");
            }finally{
                out.close();
            }
        }else if(type.equals("school_new_file")){//学校通告文件上传
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            int user_id = Integer.parseInt((String)session.getAttribute("user_id"));
            String oldFileName = URLDecoder.decode(request.getParameter("oldFileName"), "UTF-8");//用于删除的文件名称

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(user_id);

            String path = getServletConfig().getServletContext().getRealPath("/");//得到系统根目录
            String savePath = FileUploadCL.queryFilePath(path , "Schoolinfor", user.getSchoolId()+"", "News");

            FileUploadInterface fileUpload = new FileUploadCL();
            try {
                if(!oldFileName.equals("null")){
                    fileUpload.deleteUploadFile(FileUploadCL.queryFilePath(savePath , oldFileName));
                }

                //最多上传10MB的文件
                String fileName = fileUpload.uploadFile(savePath, FileUploadCL.FILE_TYPE, 10*1024*1024, request);

                out.print("<script>parent.upfileObj.successUpload('文件上传成功!');</script>");
            } catch (SizeLimitExceededException e) {
                out.print("<script>parent.upfileObj.errorView('文件最大上传大小为10Mb...');</script>");
            } catch (FileFormatException e) {
                out.print("<script>parent.upfileObj.errorView('文件格式不正确...');</script>");
            } catch (FileUploadException e) {
                out.print("<script>parent.upfileObj.errorView('文件上传异常请确认...');</script>");
            }finally{
                out.close();
            }
        }else if(type.equals("school_picture_file")){//学校通告图片上传
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            int user_id = Integer.parseInt((String)session.getAttribute("user_id"));
            String oldFileName = URLDecoder.decode(request.getParameter("oldFileName"), "UTF-8");//用于删除的文件名称

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(user_id);

            String path = getServletConfig().getServletContext().getRealPath("/");//得到系统根目录
            String savePath = FileUploadCL.queryFilePath(path , "Schoolinfor", user.getSchoolId()+"", "News");

            FileUploadInterface fileUpload = new FileUploadCL();
            try {
                if(!oldFileName.equals("null")){
                    fileUpload.deleteUploadFile(FileUploadCL.queryFilePath(savePath , oldFileName));
                }

                //最多上传1MB的图片
                String fileName = fileUpload.uploadPicture(savePath, FileUploadCL.PICTURE_TYPE, 1024*1024, 410, 200, request);

                out.print("<script>parent.upPictureObj.successUpload('图片上传成功!');</script>");
            } catch (SizeLimitExceededException e) {
                out.print("<script>parent.upPictureObj.errorView('图片最大上传大小为1Mb...');</script>");
            } catch (FileFormatException e) {
                out.print("<script>parent.upPictureObj.errorView('图片格式不正确...');</script>");
            } catch (FileUploadException e) {
                out.print("<script>parent.upPictureObj.errorView('图片上传异常请确认...');</script>");
            }finally{
                out.close();
            }
        }
	}
}
