package com.GDT.util;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException;

import com.GDT.Exception.FileFormatException;

/*
 * 文件上传接口
 * @author zero
 */
public interface FileUploadInterface {
	
	/*
	 * 上传图片文件
	 * @param savePath
	 * 文件保存对象路径
	 * @param request
	 * 请求对象
	 * @throws SizeLimitExceededException
	 * 抛出上传文件过大异常
	 * @throws FileUploadException
	 * 抛出上传文件异常
	 * @throws FileFormatException
	 * 抛出上传文件格式不正确异常
	 * @return String
	 * 返回文件上传处理结果
	 */
	public String uploadPicture(String savePath , HttpServletRequest request) throws  SizeLimitExceededException, FileUploadException, FileFormatException;
	
	/*
	 * 上传图片文件
	 * @param savePath
	 * 文件保存对象路径
	 * @param allowType
	 * 允许的文件类型
	 * @param maxSize
	 * 最大上传文件大小
	 * @param width
	 * 图片宽度
	 * @param height
	 * 图片高度
	 * @param request
	 * 请求对象
	 * @throws SizeLimitExceededException
	 * 抛出上传文件过大异常
	 * @throws FileUploadException
	 * 抛出上传文件异常
	 * @throws FileFormatException
	 * 抛出上传文件格式不正确异常
	 * @return String
	 * 返回文件上传处理结果
	 */
	public String uploadPicture(String savePath , String[] allowType , int maxSize, double width, double height, HttpServletRequest request)
            throws SizeLimitExceededException, FileUploadException, FileFormatException;
	
	/*
	 * 上传文件
	 * @param savePath
	 * 文件保存对象路径
	 * @param request
	 * 请求对象
	 * @throws SizeLimitExceededException
	 * 抛出上传文件过大异常
	 * @throws FileUploadException
	 * 抛出上传文件异常
	 * @throws FileFormatException
	 * 抛出上传文件格式不正确异常
	 * @return String
	 * 返回文件上传处理结果
	 */
	public String uploadFile(String savePath , HttpServletRequest request) throws SizeLimitExceededException, FileUploadException, FileFormatException;
	
	/*
	 * 上传图片文件
	 * @param savePath
	 * 文件保存对象路径
	 * @param allowType
	 * 允许的文件类型
	 * @param maxSize
	 * 最大上传文件大小
	 * @param request
	 * 请求对象
	 * @throws SizeLimitExceededException
	 * 抛出上传文件过大异常
	 * @throws FileUploadException
	 * 抛出上传文件异常
	 * @throws FileFormatException
	 * 抛出上传文件格式不正确异常
	 * @return String
	 * 返回文件上传处理结果
	 */
	public String uploadFile(String savePath , String[] allowType , int maxSize, HttpServletRequest request) throws SizeLimitExceededException, FileUploadException, FileFormatException;

	/*
	 * 用于删除已上传的文件
	 * @param deletePath
	 * 文件的删除对象的路径
	 * @return Boolean
	 * 返回文件删除是否成功
	 */
	public Boolean deleteUploadFile(String deletePath);
}
