package com.GDT.ModelCL;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.GDT.Interface.STNewsInterface;
import com.GDT.Model.NewInfor;
import com.GDT.util.DBConnection;
import com.GDT.util.DBConnectionInterface;

/*
 * 学生教师请求信息处理类
 * @author zero
 */
public class NewInforCL implements STNewsInterface{
	private DBConnectionInterface connectObj = null;
	private PreparedStatement sta = null;
	private ResultSet res = null;
	
	public Boolean doAlter(NewInfor newinfor) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean doCreate(NewInfor newinfor) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean doDelete(int newId) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<NewInfor> queryAllNews(int userId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/*
	 * @see com.GDT.Interface.STNewsInterface#queryNews(int)
	 * 获取个人的最新信息
	 * @param userId
	 * 用户编号用于检索用户的个人最新信息
	 */
	public String queryNews(int userId) {
		JSONArray jsonArray = new JSONArray();
		
		String sql = "select 学生教师最新消息处理.Id,发送者Id,内容,发送时间,信息类型,"
					+"case when 用户类型 = 'S' then (select 真实姓名 from 学生详细信息 where 发送者Id = 学生详细信息.Id) "
					+"when 用户类型 = 'T' then (select 真实姓名 from 教师详细信息 where 发送者Id = 教师详细信息.Id) "
					+"end as 真实姓名 "
					+"from 学生教师最新消息处理,学生教师账号 where 接收者Id=? and 发送者Id = 学生教师账号.Id and 信息状态 = 'W';";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1 , userId);
			
			res = connectObj.getQueryResultSet();
			JSONObject newInfor = null;
			while(res.next()){
				newInfor = new JSONObject();
				newInfor.put("id", res.getInt(1));
				newInfor.put("senderId", res.getInt(2));
				newInfor.put("senderName", res.getString(6));
				newInfor.put("newContent", res.getString(3));
				newInfor.put("sendTime", res.getString(4));
				newInfor.put("newType", res.getString(5));
				
				jsonArray.put(newInfor);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return jsonArray.toString();
	}
	
	/*
	 * @see com.GDT.Interface.STNewsInterface#queryNews(int)
	 * 获取个人的未处理的信息
	 * @param userId
	 * 用户编号用于检索用户的个人最新信息
	 */
	public String queryUntreatedNews(int userId) {
		JSONArray jsonArray = new JSONArray();//这个是使用了JSON包实现的效果
		
		String sql = "select 学生教师最新消息处理.Id,发送者Id,内容,发送时间,信息类型,"
					+"case when 用户类型 = 'S' then (select 真实姓名 from 学生详细信息 where 发送者Id = 学生详细信息.Id) "
					+"when 用户类型 = 'T' then (select 真实姓名 from 教师详细信息 where 发送者Id = 教师详细信息.Id) "
					+"end as 真实姓名 "
					+"from 学生教师最新消息处理,学生教师账号 where 接收者Id=? and 发送者Id = 学生教师账号.Id and 信息状态 = 'W';";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1 , userId);
			
			res = connectObj.getQueryResultSet();
			
			JSONObject newInfor = null;
			while(res.next()){
				newInfor = new JSONObject();
				newInfor.put("id", res.getInt(1));
				newInfor.put("senderId", res.getInt(2));
				newInfor.put("senderName", res.getString(6));
				newInfor.put("newContent", res.getString(3));
				newInfor.put("sendTime", res.getString(4));
				newInfor.put("newType", res.getString(5));
				
				jsonArray.put(newInfor);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return jsonArray.toString();
	}
	
	/*
	 * @see com.GDT.Interface.STNewsInterface#queryTreatedNews(int)
	 * @param userId
	 * 用户编号用于检索用户的个人最新信息
	 * @return String
	 * 返回一个学生与教师之间的请求信息JSON格式的字符串对象
	 */
	public String queryTreatedNews(int userId) {
		JSONArray jsonArray = new JSONArray();
		
		String sql = "select 学生教师最新消息处理.Id,发送者Id,内容,发送时间,信息类型,"
					+"case when 用户类型 = 'S' then (select 真实姓名 from 学生详细信息 where 发送者Id = 学生详细信息.Id) "
					+"when 用户类型 = 'T' then (select 真实姓名 from 教师详细信息 where 发送者Id = 教师详细信息.Id) "
					+"end as 真实姓名 "
					+"from 学生教师最新消息处理,学生教师账号 where 接收者Id=? and 发送者Id = 学生教师账号.Id and 信息状态 = 'W';";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1 , userId);
			
			res = connectObj.getQueryResultSet();
			JSONObject newInfor = null;
			while(res.next()){
				newInfor = new JSONObject();
				newInfor.put("id", res.getInt(1));
				newInfor.put("senderId", res.getInt(2));
				newInfor.put("senderName", res.getString(6));
				newInfor.put("newContent", res.getString(3));
				newInfor.put("sendTime", res.getString(4));
				newInfor.put("newType", res.getString(5));
				
				jsonArray.put(newInfor);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return jsonArray.toString();
	}
}
