package com.GDT.ModelCL;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import com.GDT.Factory.NewsFactory;
import com.GDT.Interface.ManageSUserInterface;
import com.GDT.Interface.NewsFactoryInterface;
import com.GDT.Interface.SchoolNewInterface;
import com.GDT.Model.AdminRequestInfor;
import com.GDT.Model.ProjectAuditInfor;
import com.GDT.Model.ProjectInfor;
import com.GDT.util.DBConnection;
import com.GDT.util.DBConnectionInterface;

/**
 * 学校管理人员对象基本用户处理类
 * @author zero
 */
public class ManageSUserCL implements ManageSUserInterface{
	private DBConnectionInterface connectObj = null;
	private PreparedStatement sta = null;
	private ResultSet res = null;
	
	/**
	 * 获取当前用户的真实姓名信息内容
	 * @see com.GDT.Interface.UserInterface#queryTrueName(int)
	 * @author zero
	 */
	public String queryTrueName(int userId){
		String userName = null;
		String sql = "select 真实姓名 from 管理员审核人员详细信息 where Id = ?;";
		
		try{
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, userId);
			
			this.res = this.connectObj.getQueryResultSet();
			userName = this.res.next() ? this.res.getString(1) : null;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return userName;
	}
	
	public Boolean auditProject(int projectId, int userId, String audit,
			String comment) {
		// TODO Auto-generated method stub
		return null;
	}

	public int doLogin(int schoolId, String name, String password) {
		int userId = 0;
		String sql = "select id from 管理员审核人员账号 where 学校Id=? and 用户名=? and 密码=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, schoolId);
			sta.setString(2, name);
			sta.setString(3, password);
			
			res = connectObj.getQueryResultSet();
			if(res.next()){
				userId = res.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return userId;
	}

	public List<ProjectAuditInfor> queryAllAuditInfor(int projectId) {
		// TODO Auto-generated method stub
		return null;
	}

	public String queryAuditInfors(int projectId) {
		// TODO Auto-generated method stub
		return null;
	}

	public String queryNewInfors(int userId, String type) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<AdminRequestInfor> queryNews(int userId, String type) {
		// TODO Auto-generated method stub
		return null;
	}

	public ProjectInfor queryProjectInfor(int projectId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean alterHead(int id, String head) {
		// TODO Auto-generated method stub
		return null;
	}

	/*
	 * 通过用户名以及用户编号更改用户密码
	 * @see com.GDT.Interface.UserInterface#alterPassword(int, java.lang.String)
	 * @author zero
	 */
	public Boolean alterPassword(int id, String password) {
		Boolean alterResult = false;
		String sql = "update 管理员审核人员账号 set 密码=? where id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			
			sta = connectObj.getStatement(sql);
			sta.setString(1, password);
			sta.setInt(2, id);
			
			alterResult = sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return alterResult;
	}

	/*
	 * 通过输入的密码以及用户编号查询用户的密码是否正确
	 * @see com.GDT.Interface.UserInterface#checkPassword(int, java.lang.String)
	 * @author zero
	 */
	public Boolean checkPassword(int id, String password) {
		Boolean checkResult = false;
		String sql = "select * from 管理员审核人员账号 where id=? and 密码=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			
			sta = connectObj.getStatement(sql);
			sta.setInt(1, id);
			sta.setString(2, password);
			
			res = connectObj.getQueryResultSet();
			checkResult = res.next();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return checkResult;
	}

	public Boolean doDelete(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean ifUseName(String name) {
		// TODO Auto-generated method stub
		return null;
	}

	public String queryUserInfor(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	/*
	 * @see com.GDT.Interface.ManageSUserInterface#queryUserType(int)
	 * @author zero
	 * 获取用户的类型
	 */
	public String queryUserType(int userId) {
		String user_type = null;
		String sql = "select 用户类型 from 管理员审核人员账号 where Id=?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, userId);
			
			res = connectObj.getQueryResultSet();
			if(res.next()){
				user_type = res.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return user_type;
	}

	/*
	 * @see com.GDT.Interface.ManageSUserInterface#querySchoolNews(int)
	 * 查询学校的最新通知信息操作
	 */
	public String querySchoolNews(int schoolId) {
		NewsFactoryInterface factory = new NewsFactory();
		SchoolNewInterface newcl = factory.createSchoolNewCL();
		
		String json = newcl.queryNews(schoolId);//返回json数据
		
		return json;
	}

	public Boolean ifDetail(int userId) {
		// TODO Auto-generated method stub
		return null;
	}
}
