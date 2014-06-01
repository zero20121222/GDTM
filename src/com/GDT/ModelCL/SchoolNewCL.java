package com.GDT.ModelCL;

import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

import com.GDT.Factory.SchoolManageFactory;
import com.GDT.Interface.SchoolManageFactoryInterface;
import com.GDT.Interface.SchoolParamsInterface;
import com.GDT.util.UserEventBus;
import com.GDT.util.UserEventHandler;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
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
    private final UserEventBus userEventBus = new UserEventBus();

	private DBConnectionInterface connectObj = null;
	private PreparedStatement sta = null;
	private ResultSet res = null;

	public Boolean doAlter(SchoolNew schoolNew) {
		// TODO Auto-generated method stub
		return null;
	}

    @Override
	public Boolean doCreate(SchoolNew schoolNew , String realPath) {
        Boolean result = false;
        String sql = "insert into 学校最新通知信息(学校Id,发布人员Id,信息标题,内容信息,详细内容,图片信息,发布时间) values(?,?,?,?,?,?,now())";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql);
            sta.setInt(1 , schoolNew.getSchoolId());
            sta.setInt(2 , schoolNew.getSenderId());
            sta.setString(3 , schoolNew.getTitle());
            sta.setString(4 , schoolNew.getContent());
            sta.setString(5 , schoolNew.getContentFile());
            sta.setString(6 , schoolNew.getPicture());

            result = sta.executeUpdate() == 1;

            if(schoolNew.getContentFile().indexOf(".doc") != -1){
                //解析文档
                schoolNew.setRealPath(realPath);
                userEventBus.register(new UserEventHandler());
                userEventBus.post(schoolNew);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return result;
	}

	public Boolean doDelete(int newId) {
        Boolean result = false;
        String sql = "delete from 学校最新通知信息 where id=?";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql);
            sta.setInt(1 , newId);

            result = sta.executeUpdate() == 1;
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return result;
	}

    @Override
    public SchoolNew querySchoolNew(int newId) {
        SchoolNew schoolNew = null;
        String sql = "select 学校最新通知信息.id,发布人员Id,真实姓名,信息标题,内容信息,详细内容,图片信息,发布时间,学校Id from 学校最新通知信息,管理员审核人员详细信息 " +
                "where 发布人员Id=管理员审核人员详细信息.id and 学校最新通知信息.id=?";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql);
            sta.setInt(1, newId);

            res = connectObj.getQueryResultSet();

            if(res.next()){
                schoolNew = new SchoolNew();
                schoolNew.setId(res.getInt(1));
                schoolNew.setSenderId(res.getInt(2));
                schoolNew.setSenderName(res.getString(3));
                schoolNew.setTitle(res.getString(4));
                schoolNew.setContent(res.getString(5));
                schoolNew.setContentFile(res.getString(6));
                schoolNew.setPicture(res.getString(7));
                schoolNew.setTime(res.getString(8));
                schoolNew.setSchoolId(res.getInt(9));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return schoolNew;
    }

    @Override
    public List<SchoolNew> queryAllNews(int schoolId, int pageNo, int pageSize, Map<String, String> params) {
        List<SchoolNew> newList = Lists.newArrayList();
        //当前页码
        pageNo = pageNo > 0 ? pageNo : 1;
        pageSize = pageSize > 0 ? pageSize : 10;
        int from = (pageNo-1)*pageSize;

        String sql = "select 学校最新通知信息.id,发布人员Id,真实姓名,信息标题,内容信息,详细内容,图片信息,发布时间 from 学校最新通知信息,管理员审核人员详细信息 " +
                "where 发布人员Id=管理员审核人员详细信息.id and 学校Id=? order by 发布时间 desc limit ?,?";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql);
            sta.setInt(1, schoolId);
            sta.setInt(2 , from);
            sta.setInt(3, pageSize);

            res = connectObj.getQueryResultSet();

            SchoolNew schoolNew = null;
            while(res.next()){
                schoolNew = new SchoolNew();
                schoolNew.setId(res.getInt(1));
                schoolNew.setSenderId(res.getInt(2));
                schoolNew.setSenderName(res.getString(3));
                schoolNew.setTitle(res.getString(4));
                schoolNew.setContent(res.getString(5));
                schoolNew.setContentFile(res.getString(6));
                schoolNew.setPicture(res.getString(7));
                schoolNew.setTime(res.getString(8));

                newList.add(schoolNew);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

		return newList;
	}

    @Override
    public Map<String, String> queryNewsCount(int schoolId, int pageNo, int pageSize, Map<String, String> params) {
        Map<String , String> countParam = Maps.newHashMap();

        //当前页码
        pageNo = pageNo > 0 ? pageNo : 1;
        pageSize = pageSize > 0 ? pageSize : 10;
        int from = (pageNo-1)*pageSize;

        String sql = "select count(*) from 学校最新通知信息 where 学校Id=?";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql);
            sta.setInt(1, schoolId);
            res = connectObj.getQueryResultSet();

            int count = 0;
            if(res.next()){
                count = res.getInt(1);
            }

            countParam.put("countNum" , count+"");
            countParam.put("pageNo" , pageNo+"");
            countParam.put("pageSize" , pageSize+"");
            countParam.put("countPage" , (count%pageSize == 0 ? count/pageSize : count/pageSize+1)+"");
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return countParam;
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
	 * 本来想使用反射机制自动装载JSON数据（但是那样效率比较低还是手写吧,只显示最多5条记录）
	 */
	public String queryNews(int schoolId) {
		JSONArray jsonArray = new JSONArray();
		String sql = "select id,发布人员Id,信息标题,内容信息,详细内容,图片信息,发布时间 from 学校最新通知信息 where 学校Id=? order by 发布时间 desc limit 0,?";

        //获取学校公告显示条数
        SchoolManageFactoryInterface manageFactory = new SchoolManageFactory();
        SchoolParamsInterface paramsCL = manageFactory.createSchoolParamsCL();
        int noticeNum = paramsCL.querySchoolParams(schoolId).getNoticeNum();

		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, schoolId);
            sta.setInt(2, noticeNum);
			
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
