package com.GDT.util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * 数据库连接操作接口对象
 * @author zero
 */
public interface DBConnectionInterface {
	/**
	 * 获取数据库连接对象Connection
	 * @return Connection
	 * 返回一个数据库连接对象
	 */
	public Connection getConnection();
	
	/**
	 * 开启事务处理
	 */
	public void beginTransaction();
	
	/**
	 * 提交事务处理
	 */
	public void commitTransaction();

	/**
	 * 回滚事务处理
	 */
	public void rollBackTransaction();
	
	/**
	 * 返回一个数据库函数调用对象
	 * @param sql
	 * 设置一个sql调用语句
	 * @return CallableStatement
	 * 返回一个数据库函数调用对象
	 */
	public CallableStatement getCallableStatement(String sql);
	
	/**
	 * 返回一个数据库语句调用对象
	 * @param sql
	 * 设置一个sql调用语句
	 * @return PreparedStatement
	 * 返回一个数据库语句调用对象
	 */
	public PreparedStatement getStatement(String sql);
	
	/**
	 * 通过设置statement用于返回得到自动增长的编号
	 * @param sql
	 * sql语句信息
	 * @param stateType
	 * 状态类型
	 * @return PreparedStatement
	 * 返回一个数据库语句调用对象
	 */
	public PreparedStatement getStatement(String sql , int stateType);
	
	/**
	 * 返回一个数据库查询结果语句
	 * @return ResultSet
	 * 返回一个数据库查询结果
	 */
	public ResultSet getQueryResultSet();
	
	/**
	 * 关闭数据库连接接口等对象
	 */
	public void close();
}
