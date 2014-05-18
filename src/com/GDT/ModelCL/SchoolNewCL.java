package com.GDT.ModelCL;

import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.GDT.Interface.SchoolNewInterface;
import com.GDT.Model.SchoolNew;
import com.GDT.util.DBConnection;
import com.GDT.util.DBConnectionInterface;

/*
 * 学校最新通知信息处理类
 * @author zero
 */
public class SchoolNewCL implements SchoolNewInterface{
	private DBConnectionInterface connectObj = null;
	private PreparedStatement sta = null;
	private ResultSet res = null;

	public Boolean doAlter(SchoolNew schoolNew) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean doCreate(SchoolNew schoolNew) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean doDelete(int newId) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<SchoolNew> queryAllNews(int schoolId) {
		// TODO Auto-generated method stub
		return null;
	}

	/*
	 * @see com.GDT.Interface.SchoolNewInterface#queryNewFile(int)
	 * @author zero
	 * 根据信息编号得到一个详细信息的文件输出流对象
	 */
	public InputStream queryNewFile(int newId) {
		return null;
	}

	public String queryNewFileInfor(int newId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/*
	 * @see com.GDT.Interface.SchoolNewInterface#queryNews(int)
	 * @author zero
	 * 查询得打全部学校的最新通知信息内容
	 * 本来想使用反射机制自动装载JSON数据（但是那样效率比较低还是手写吧）
	 */
	public String queryNews(int schoolId) {
		JSONArray jsonArray = new JSONArray();
		String sql = "select id,发布人员Id,信息标题,内容信息,详细内容,图片信息,发布时间 from 学校最新通知信息 where 学校Id=? order by 发布时间";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, schoolId);
			
			res = connectObj.getQueryResultSet();
			
			JSONObject json = null;
			while(res.next()){
				json = new JSONObject();
				json.put("id", res.getInt(1));
				json.put("senderId", res.getInt(2));
				json.put("title", res.getString(3));
				json.put("content", res.getString(4));
				json.put("contentfile", res.getString(5));
				json.put("picture", res.getString(6));
				json.put("time", res.getString(7));
				
				jsonArray.put(json);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return jsonArray.toString();
	}

}
