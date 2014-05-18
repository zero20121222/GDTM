package com.GDT.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.GDT.Exception.FileFormatException;

public class FileUploadCL implements FileUploadInterface{
	public static int SIZETHRESHOLD = 1024*1024;//文件硬盘缓冲大小
	public static String ENCODING = "UTF-8";//默认上传文件处理编码为UTF-8
	public static int BUFFSIZE = 1024;//上传文件缓冲大小
	public static int PICTURE_MAX_SIZE = 512*1024;//最大图片上传大小
	public static int FILE_MAX_SIZE = 1024*1024;//最大文件上传大小
	public static String[] PICTURE_TYPE = {"jpg", "jpeg", "gif","pbg","png","bmp"};//允许的图片类型
	public static String[] FILE_TYPE = {"jpg", "jpeg", "gif","pbg","png","bmp","doc","docx","txt","xls","ppt","pptx","fem","vsd","tgz","tar","gz","zip","rar"};//允许的文件类型
	
	/*
	 * 配置初始化上传处理对象信息
	 * @param sizeShold
	 * 文件硬盘缓冲大小
	 * @param encoding
	 * 上传文件处理编码
	 * @param buffsize
	 * 上传文件缓冲大小
	 */
	public static void initFileUpload(int sizeShold, String encoding, int buffSize, int pictureMaxSize, int fileMaxSize, String[] pictureTypes, String[] fileTypes){
		SIZETHRESHOLD = sizeShold;
		ENCODING = encoding;
		BUFFSIZE = buffSize;
		PICTURE_MAX_SIZE = pictureMaxSize;
		FILE_MAX_SIZE = fileMaxSize;
		PICTURE_TYPE = pictureTypes == null ? PICTURE_TYPE : pictureTypes;
		FILE_TYPE = fileTypes == null ? FILE_TYPE : fileTypes;
	}
	
	/*
	 * @see com.GDT.util.FileUploadInterface#uploadFile(java.lang.String, javax.servlet.http.HttpServletRequest)
	 * 文件上传处理
	 */
	public String uploadFile(String savePath, HttpServletRequest request) throws SizeLimitExceededException, FileUploadException, FileFormatException{
		String uploadResult = "";
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		FileUpload fileUpload = new FileUpload(factory);
    	fileUpload.setHeaderEncoding(ENCODING);//解决中文路径乱码问题

		//设置 缓存的大小，当上传文件的容量超过该缓存时，直接放到 暂时存储室
    	File filepath = new File(savePath);
    	if(!filepath.exists()){
    		filepath.mkdirs();
    	}
    	
		factory.setRepository(filepath);
		factory.setSizeThreshold(SIZETHRESHOLD);
		
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(FILE_MAX_SIZE);//设置最大上传大小
		
		OutputStream output = null;
		InputStream input = null;
		
		//返回一个文件上传链表对象
		List<FileItem> fileitems = (List<FileItem>)upload.parseRequest(request);
		
		for(FileItem fileItem : fileitems){
			
			//判断是否是简单的表单信息
			if(!fileItem.isFormField()){
				//返回在客户端的文件系统的原始文件(上传文件的文件名)
				String value = fileItem.getName();
				
				if(allowUpload(value.substring(value.lastIndexOf(".")+1).toLowerCase() , FILE_TYPE)){//判断是文件后缀名是否符合
					String filename = value.substring(value.lastIndexOf("\\")+1);
					
					try{
						//在这里还需要添加一个对于文件夹是否存在以及文件夹创建的操作
						output = new BufferedOutputStream(new FileOutputStream(new File(filepath , filename)));
						input = fileItem.getInputStream();
						
						int length = 0;
						byte[] buffer = new byte[BUFFSIZE];
						
						while((length = input.read(buffer)) != -1){
							output.write(buffer , 0, length);
						}
					}catch(Exception e){
						e.printStackTrace();
					}finally{
						try{
							if(input != null){
								input.close();
							}
							if(output != null){
								output.close();
							}
						}catch(Exception e){
							e.printStackTrace();
						}
					}
					
					uploadResult = filename;
				}else{
					throw new FileFormatException("文件格式不正确...");//抛出图片格式不正确的异常
				}
			}
		}
		
		return uploadResult;
	}
	
	/*
	 * @see com.GDT.util.FileUploadInterface#uploadFile(java.lang.String, java.lang.String[], int, javax.servlet.http.HttpServletRequest)
	 * 已规定的大小以及允许格式上传文件
	 */
	public String uploadFile(String savePath, String[] allowType, int maxSize, HttpServletRequest request) throws SizeLimitExceededException, FileUploadException, FileFormatException{
		String uploadResult = "";
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		FileUpload fileUpload = new FileUpload(factory);
    	fileUpload.setHeaderEncoding(ENCODING);//解决中文路径乱码问题

    	File filepath = new File(savePath);
    	if(!filepath.exists()){
    		filepath.mkdirs();
    	}
		//设置 缓存的大小，当上传文件的容量超过该缓存时，直接放到 暂时存储室
		factory.setRepository(filepath);
		factory.setSizeThreshold(SIZETHRESHOLD);
		
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(maxSize);//设置最大上传大小
		
		OutputStream output = null;
		InputStream input = null;
		
		//返回一个文件上传链表对象
		List<FileItem> fileitems = (List<FileItem>)upload.parseRequest(request);
		
		for(FileItem fileItem : fileitems){
			
			//判断是否是简单的表单信息
			if(!fileItem.isFormField()){
				//返回在客户端的文件系统的原始文件(上传文件的文件名)
				String value = fileItem.getName();
				
				if(allowUpload(value.substring(value.lastIndexOf(".")+1).toLowerCase() , allowType)){//判断是文件后缀名是否符合
					String filename = value.substring(value.lastIndexOf("\\")+1);
					
					try{
						output = new BufferedOutputStream(new FileOutputStream(new File(filepath , filename)));
						input = fileItem.getInputStream();
						
						int length = 0;
						byte[] buffer = new byte[BUFFSIZE];
						
						while((length = input.read(buffer)) != -1){
							output.write(buffer , 0, length);
						}
					}catch(Exception e){
						e.printStackTrace();
					}finally{
						try{
							if(input != null){
								input.close();
							}
							if(output != null){
								output.close();
							}
						}catch(Exception e){
							e.printStackTrace();
						}
					}
					
					uploadResult = filename;
				}else{
					throw new FileFormatException("文件格式不正确...");//抛出图片格式不正确的异常
				}
			}
		}
		
		return uploadResult;
	}

	/*
	 * @see com.GDT.util.FileUploadInterface#uploadPicture(java.lang.String, javax.servlet.http.HttpServletRequest)
	 * 图片上传
	 */
	public String uploadPicture(String savePath, HttpServletRequest request) throws SizeLimitExceededException, FileUploadException, FileFormatException{
		String uploadResult = "";
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		FileUpload fileUpload = new FileUpload(factory);
    	fileUpload.setHeaderEncoding(ENCODING);//解决中文路径乱码问题

    	File filepath = new File(savePath);
    	if(!filepath.exists()){
    		filepath.mkdirs();
    	}
		//设置 缓存的大小，当上传文件的容量超过该缓存时，直接放到 暂时存储室
		factory.setRepository(filepath);
		factory.setSizeThreshold(SIZETHRESHOLD);
		
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(PICTURE_MAX_SIZE);//设置最大上传大小
		
		OutputStream output = null;
		InputStream input = null;
		
		//返回一个文件上传链表对象
		List<FileItem> fileitems = (List<FileItem>)upload.parseRequest(request);
		
		for(FileItem fileItem : fileitems){
			
			//判断是否是简单的表单信息
			if(!fileItem.isFormField()){
				//返回在客户端的文件系统的原始文件(上传文件的文件名)
				String value = fileItem.getName();
				
				if(allowUpload(value.substring(value.lastIndexOf(".")+1).toLowerCase() , PICTURE_TYPE)){//判断是文件后缀名是否符合
					String filename = value.substring(value.lastIndexOf("\\")+1);
					
					try{
						output = new BufferedOutputStream(new FileOutputStream(new File(filepath , filename)));
						input = fileItem.getInputStream();
						
						int length = 0;
						byte[] buffer = new byte[BUFFSIZE];
						
						while((length = input.read(buffer)) != -1){
							output.write(buffer , 0, length);
						}
					}catch(Exception e){
						e.printStackTrace();
					}finally{
						try{
							if(input != null){
								input.close();
							}
							if(output != null){
								output.close();
							}
						}catch(Exception e){
							e.printStackTrace();
						}
					}
					
					uploadResult = filename;
				}else{
					throw new FileFormatException("图片格式不正确...");//抛出图片格式不正确的异常
				}
			}
		}
		
		return uploadResult;
	}

	/*
	 * @see com.GDT.util.FileUploadInterface#uploadPicture(java.lang.String, java.lang.String[], int, javax.servlet.http.HttpServletRequest)
	 * 已规定的格式和大小上传图片
	 */
	public String uploadPicture(String savePath, String[] allowType, int maxSize, HttpServletRequest request) throws SizeLimitExceededException, FileUploadException, FileFormatException{
		String uploadResult = "";
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		FileUpload fileUpload = new FileUpload(factory);
    	fileUpload.setHeaderEncoding(ENCODING);//解决中文路径乱码问题

    	File filepath = new File(savePath);
    	if(!filepath.exists()){
    		filepath.mkdirs();
    	}
		//设置 缓存的大小，当上传文件的容量超过该缓存时，直接放到 暂时存储室
		factory.setRepository(filepath);
		factory.setSizeThreshold(SIZETHRESHOLD);
		
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(maxSize);//设置最大上传大小
		
		OutputStream output = null;
		InputStream input = null;
		
		//返回一个文件上传链表对象
		List<FileItem> fileitems = (List<FileItem>)upload.parseRequest(request);
		
		for(FileItem fileItem : fileitems){
			
			//判断是否是简单的表单信息
			if(!fileItem.isFormField()){
				//返回在客户端的文件系统的原始文件(上传文件的文件名)
				String value = fileItem.getName();
				
				if(allowUpload(value.substring(value.lastIndexOf(".")+1).toLowerCase() , allowType)){//判断是文件后缀名是否符合
					String filename = value.substring(value.lastIndexOf("\\")+1);
					
					try{
						output = new BufferedOutputStream(new FileOutputStream(new File(filepath , filename)));
						input = fileItem.getInputStream();
						
						int length = 0;
						byte[] buffer = new byte[BUFFSIZE];
						
						while((length = input.read(buffer)) != -1){
							output.write(buffer , 0, length);
						}
					}catch(Exception e){
						e.printStackTrace();
					}finally{
						try{
							if(input != null){
								input.close();
							}
							if(output != null){
								output.close();
							}
						}catch(Exception e){
							e.printStackTrace();
						}
					}
					
					uploadResult = filename;
				}else{
					throw new FileFormatException("图片格式不正确...");//抛出图片格式不正确的异常
				}
			}
		}
		
		return uploadResult;
	}
	
	/*
	 * 判断上传文件类型是否符合规定
	 * @author zero
	 */
	private Boolean allowUpload(String fileType, String[] limitTypes){
		Boolean allow = false;
		
		for(String limitType : limitTypes){
			if(fileType.equals(limitType)){
				allow = true;
				break;
			}
		}
		
		return allow;
	}
	
	/*
	 * @see com.GDT.util.FileUploadInterface#deleteUploadFile(java.lang.String)
	 * 文件的删除操作
	 * @author zero
	 */
	public Boolean deleteUploadFile(String deletePath) {
		Boolean delete = false;
		File file = new File(deletePath);
		
		if(file.exists()){
			delete = file.delete();
		}
		
		return delete;
	}
}
