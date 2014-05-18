package com.GDT.util;

import java.io.IOException;

/*
 * 将文件转换成其他格式
 * @author zero
 */
public interface FileConvertInterface {
	/*
	 * 转换样式类型
	 */
	public final static int WORDTYPE = 1;
	public final static int EXCELTYPE = 2;
	
	/*
	 * 实现将word文档转换成html文档格式
	 * @param filename
	 * word文件名称路径
	 * @param htmlpath
	 * 转换后的文件名路径
	 */
	public void wordConvertHtml(String filepath, String htmlpath);
	
	/*
	 * 实现将excel文档转换成html文档格式
	 * @param filename
	 * excel文件名称路径
	 * @param htmlname
	 * 转换后的文件名路径
	 */
	public void excelConvertHtml(String filepath, String htmlpath);
	
	/*
	 * 实现将学校的通知信息文件转换格式
	 * @param schoolId
	 * 学校编号
	 * @param newId
	 * 最新通知信息编号
	 * @param filename
	 * 文件名称
	 * @param convertType
	 * 转换类型
	 */
	public void convertSchoolNew(int schoolId , int newId, String filename, int convertType);
	
	/*
	 * 实现将课题信息转化文件格式
	 * @param schoolId
	 * 学校编号
	 * @param userId
	 * 用户编号
	 * @param filename
	 * 文件名称
	 * @param convertType
	 * 转换类型
	 */
	public void convertProjectInfor(int schoolId , int userId, String filename, int convertType);
	
	/*
	 * 实现将课题信息转化文件格式
	 * @param projectId
	 * 课题编号
	 * @param stageId
	 * 课题阶段编号
	 * @param filename
	 * 文件名称
	 * @param convertType
	 * 转换类型
	 */
	public void convertProjectStageInfor(int schoolId , int userId, int projectId, String filename, int convertType);
	
	/*
	 * 实现将团队阶段的文档信息格式转换
	 * @param teamId
	 * 团队编号
	 * @param stageId
	 * 课题阶段编号
	 * @param filename
	 * 文件名称
	 * @param convertType
	 * 转换类型
	 */
	public void convertTeamStageInfor(int teamId, String stageId, String filename, int convertType);
	
	/*
	 * 将文件的格式更改成某种编码方式
	 * @param filepath
	 * 需要更改的文件路径
	 * @param convertCode
	 * 转换编码类型
	 * @return Boolean
	 * 返回文件更改是否成功
	 */
	public Boolean convertFileCode(String filepath , String convertCode) throws IOException;
	
	/*
	 * 将文件写入到文件中
	 * @param filePath
	 * 需要写入的文件路径
	 * @param encoding
	 * 文件些人编码方式
	 * @return StringBuffer
	 * 返回一个文件的内容的缓冲对象
	 */
	public StringBuffer fileRead(String filePath , String encoding);
	
	/*
	 * 将文件写入到文件中
	 * @param filePath
	 * 需要写入的文件路径
	 * @param encoding
	 * 文件些人编码方式
	 * @param buffer
	 * 需要写入的文件内容使用StringBuffer缓冲保存内容
	 * @return Boolean
	 * 返回一个文件是否保存成功
	 */
	public Boolean fileWrite(String filePath , String encoding, StringBuffer buffer);
	
	/*
	 * 用于判断文件的编码方式
	 * @param filePath
	 * 文件对象路径
	 * @param String
	 * 返回文件对象的编码格式
	 */
	public String getFileEncoding(String filePath);
	
}
