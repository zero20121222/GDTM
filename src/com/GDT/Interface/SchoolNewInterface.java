package com.GDT.Interface;

import java.io.InputStream;
import java.util.List;

import com.GDT.Model.SchoolNew;

/**
 * 这个为学校最新通知信息的调用接口对象
 * @author zero
 */
public interface SchoolNewInterface {
	/**
	 * 创建学校通知信息
	 * @param schoolNew
	 * 学校最新通知信息
	 * @return Boolean
	 * 返回最新信息创建是否成功
	 */
	public Boolean doCreate(SchoolNew schoolNew);
	
	/**
	 * 更改学校通知信息
	 * @param schoolNew
	 * 学校最新通知信息
	 * @return Boolean
	 * 返回最新信息更改是否成功
	 */
	public Boolean doAlter(SchoolNew schoolNew);
	
	/**
	 * 删除学校通知信息
	 * @param newId
	 * 学校最新通知信息编号
	 * @return Boolean
	 * 返回最新信息删除是否成功
	 */
	public Boolean doDelete(int newId);
	
	/**
	 * 获取学校通知信息
	 * @param schoolId
	 * 学校编号（用于检索学校最新通知信息）
	 * @return List<SchoolNew>
	 * 返回一个学校最新通知信息链表对象
	 */
	public List<SchoolNew> queryAllNews(int schoolId);
	
	/**
	 * 获取学校通知信息
	 * @param schoolId
	 * 学校编号（用于检索学校最新通知信息）
	 * @return String
	 * 返回一个学校最新通知信息JSON格式的字符串对象
	 */
	public String queryNews(int schoolId);
	
	/**
	 * 获取学校通知信息的详细内容文件流对象
	 * @param newId
	 * 学校最新通知信息编号
	 * @return InputStream
	 * 返回一个文件输入流对象
	 */
	public InputStream queryNewFile(int newId);
	
	/**
	 * 获取学校通知信息的详细内容文件流对象
	 * @param newId
	 * 学校最新通知信息编号
	 * @return String
	 * 返回一个文件信息部分数据内容用字符串返回
	 */
	public String queryNewFileInfor(int newId);
}
