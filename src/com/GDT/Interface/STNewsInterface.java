package com.GDT.Interface;

import java.util.List;

import com.GDT.Model.NewInfor;

/**
 * 学生教师的最新信息处理接口
 * @author zero
 */
public interface STNewsInterface {
	/**
	 * 创建学生与教师之间的请求信息
	 * @param newinfor
	 * 学生或教师创建的请求信息
	 * @return Boolean
	 * 返回信息创建是否成功
	 */
	public Boolean doCreate(NewInfor newinfor);
	
	/**
	 * 更改学生与教师之间的请求信息
	 * @param newinfor
	 * 学生或教师创建的请求信息
	 * @return Boolean
	 * 返回信息创建是否成功
	 */
	public Boolean doAlter(NewInfor newinfor);
	
	/**
	 * 删除学生与教师之间的请求信息
	 * @param newId
	 * 学生或教师的请求信息编号
	 * @return Boolean
	 * 返回信息删除是否成功
	 */
	public Boolean doDelete(int newId);
	
	/**
	 * 获取学生与教师之间的请求信息
	 * @param userId
	 * 学生或者教师的用户编号
	 * @return List<NewInfor>
	 * 返回一个学生与教师之间的请求信息
	 */
	public List<NewInfor> queryAllNews(int userId);
	
	/**
	 * 获取学生与教师之间的请求信息
	 * @param userId
	 * 学生或者教师的用户编号
	 * @return String
	 * 返回一个学生与教师之间的请求信息JSON格式的字符串对象
	 */
	public String queryNews(int userId);
	
	/**
	 * 获取学生或者教师未处理的请求信息
	 * @param userId
	 * 用户编号用于检索用户的个人最新信息
	 * @return String
	 * 返回一个学生与教师之间的请求信息JSON格式的字符串对象
	 */
	public String queryUntreatedNews(int userId);
	
	/**
	 * 获取学生或者教师已处理的请求信息
	 * @param userId
	 * 用户编号用于检索用户的个人最新信息
	 * @return String
	 * 返回一个学生与教师之间的请求信息JSON格式的字符串对象
	 */
	public String queryTreatedNews(int userId);
}
