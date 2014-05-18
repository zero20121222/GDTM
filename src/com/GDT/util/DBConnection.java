package com.GDT.util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/* 数据库连接类对象 */
public class DBConnection implements DBConnectionInterface{
	private static String DRIVER = null;
	private static String URL = null;
	private static String USER = null;
	private static String PASSWORD = null;
	
	public Connection conn = null;
	private CallableStatement call = null;//数据库函数调用方法
	public PreparedStatement sta = null;
	public ResultSet res = null;
	
	public static void Init(String driver , String url, String user, String password){
		DRIVER = driver;
		URL = url;
		USER = user;
		PASSWORD = password;
	}
	
	public Connection getConnection(){
		
		try{
			Class.forName(DRIVER);
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return conn;
	}
	
	/**
	 * 开启事务处理
	 */
	public void beginTransaction(){
		if(this.conn != null){
			try{
				if(this.conn.getAutoCommit()){
					this.conn.setAutoCommit(false);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 提交事务处理
	 */
	public void commitTransaction(){
		if(this.conn != null){
			try{
				if(!this.conn.getAutoCommit()){
					this.conn.commit();
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	/**
	 * 回滚事务处理
	 */
	public void rollBackTransaction(){
		if(this.conn != null){
			try{
				if(!this.conn.getAutoCommit()){
					this.conn.rollback();
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	
	public CallableStatement getCallableStatement(String sql){
		
		try{
			call = conn.prepareCall(sql);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return call;
	}
	
	public PreparedStatement getStatement(String sql){
		
		try{
			sta = conn.prepareStatement(sql);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return sta;
	}
	
	public PreparedStatement getStatement(String sql , int stateType){
		
		try{
			sta = conn.prepareStatement(sql , stateType);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return sta;
	}
	
	public ResultSet getQueryResultSet(){
		
		try{
			res = sta.executeQuery();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return res;
	}
	
	public void close(){
		try{
			if(res != null){
				res.close();
			}
			if(call != null){
				call.close();
			}
			if(sta != null){
				sta.close();
			}
			if(conn != null){
				conn.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
