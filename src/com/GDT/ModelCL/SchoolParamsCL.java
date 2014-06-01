package com.GDT.ModelCL;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.GDT.Interface.SchoolParamsInterface;
import com.GDT.Model.SchoolParams;
import com.GDT.util.DBConnection;
import com.GDT.util.DBConnectionInterface;

/**
 * 学校参数操作处理类
 * @author zero
 */
public class SchoolParamsCL implements SchoolParamsInterface {
	private DBConnectionInterface connectObj = null;
	private PreparedStatement sta = null;
	private ResultSet res = null;
	
	/*
	 * @see com.GDT.Interface.SchoolParamsInterface#ifDisclosureInfor(int)
	 * 判断学校信息是否允许公开
	 * @author zero
	 */
	public Boolean ifDisclosureInfor(int schoolId) {
		Boolean disclosure = false;
		String sql = "select 学校信息公开 from 学校界面的系统参数设置 where 学校Id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, schoolId);
			res = connectObj.getQueryResultSet();
			
			if(res.next()){
				disclosure = res.getString(1).equals("T") ? true : false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return disclosure;
	}
	
	/*
	 * @see com.GDT.Interface.SchoolParamsInterface#parterUps(int)
	 * 获取学校的课题最多参加人数上限
	 * @author zero
	 */
	public int parterUps(int schoolId){
		int parters = 0;
		String sql = "select 课题参与人数上限 from 学校界面的系统参数设置 where 学校Id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, schoolId);
			res = connectObj.getQueryResultSet();
			
			if(res.next()){
				parters = res.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return parters;
	}
	
	/*
	 * @see com.GDT.Interface.SchoolParamsInterface#auditerNumers(int)
	 * 审核课题人数限定规定多少人审核课题
	 * @author zero
	 */
	public int auditerNumers(int schoolId) {
		int audters = 0;
		String sql = "select 审核课题人数 from 学校界面的系统参数设置 where 学校Id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, schoolId);
			res = connectObj.getQueryResultSet();
			
			if(res.next()){
				audters = res.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return audters;
	}

	/*
	 * @see com.GDT.Interface.SchoolParamsInterface#auditerAdopt(int)
	 * 多少审核人员审核通过该课题才算通过
	 * @author zero
	 */
	public int auditerAdopt(int schoolId) {
		int adopters = 0;
		String sql = "select 审核课题通过数 from 学校界面的系统参数设置 where 学校Id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, schoolId);
			res = connectObj.getQueryResultSet();
			
			if(res.next()){
				adopters = res.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return adopters;
	}
	
	/*
	 * @see com.GDT.Interface.SchoolParamsInterface#projectStageUps(int)
	 * 课题阶段上限
	 * @author zero
	 */
	public int projectStageUps(int schoolId) {
		int stageups = 0;
		String sql = "select 课题阶段上限 from 学校界面的系统参数设置 where 学校Id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, schoolId);
			res = connectObj.getQueryResultSet();
			
			if(res.next()){
				stageups = res.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return stageups;
	}

	/*
	 * @see com.GDT.Interface.SchoolParamsInterface#projectStageDowns(int)
	 * 课题阶段下限
	 * @author zero
	 */
	public int projectStageDowns(int schoolId) {
		int stagedowns = 0;
		String sql = "select 课题阶段下限 from 学校界面的系统参数设置 where 学校Id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, schoolId);
			res = connectObj.getQueryResultSet();
			
			if(res.next()){
				stagedowns = res.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return stagedowns;
	}
	
	/*
	 * @see com.GDT.Interface.SchoolParamsInterface#projectSelectUps(int)
	 * 课题所选次数上限
	 * @author zero
	 */
	public int projectSelectUps(int schoolId) {
		int selectups = 0;
		String sql = "select 课题所选次数上限 from 学校界面的系统参数设置 where 学校Id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, schoolId);
			res = connectObj.getQueryResultSet();
			
			if(res.next()){
				selectups = res.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return selectups;
	}
	
	/*
	 * @see com.GDT.Interface.SchoolParamsInterface#auditTeamUps(int)
	 * 指导团队上限
	 * @author zero
	 */
	public int auditTeamUps(int schoolId) {
		int teamups = 0;
		String sql = "select 指导团队上限 from 学校界面的系统参数设置 where 学校Id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, schoolId);
			res = connectObj.getQueryResultSet();
			
			if(res.next()){
				teamups = res.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return teamups;
	}
	
	/*
	 * @see com.GDT.Interface.SchoolParamsInterface#ifAllowUpdatePassword(int)
	 * 是否可更改账户
	 * @author zero
	 */
	public Boolean ifAllowUpdatePassword(int schoolId) {
		Boolean allow = false;
		String sql = "select 是否可更改账户 from 学校界面的系统参数设置 where 学校Id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, schoolId);
			res = connectObj.getQueryResultSet();
			
			if(res.next()){
				allow = res.getString(1).equals("T") ? true : false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return allow;
	}
	
	/*
	 * @see com.GDT.Interface.SchoolParamsInterface#ifAllowCoverInfor(int)
	 * 是否需要覆盖用户数据源
	 * @author zero
	 */
	public Boolean ifAllowCoverInfor(int schoolId) {
		Boolean allow = false;
		String sql = "select 覆盖用户数据源 from 学校界面的系统参数设置 where 学校Id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, schoolId);
			res = connectObj.getQueryResultSet();
			
			if(res.next()){
				allow = res.getString(1).equals("T") ? true : false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return allow;
	}
	
	/*
	 * @see com.GDT.Interface.SchoolParamsInterface#projectStageParams(int)
	 * 获取课题阶段设定的学校参数信息
	 * @author zero
	 */
	public int[] projectStageParams(int schoolId) {
		int[] params = new int[3];
		
		String sql = "select 课题阶段总时间上限,课题阶段上限,课题阶段下限 from 学校界面的系统参数设置 where 学校Id=?";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, schoolId);
			res = connectObj.getQueryResultSet();
			
			if(res.next()){
				params[0] = res.getInt(1);
				params[1] = res.getInt(2);
				params[2] = res.getInt(3);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return params;
	}

    /*
        查询学校系统参数
     */
	public SchoolParams querySchoolParams(int schoolId) {
        SchoolParams schoolParams = null;

        String sql = "select 学校Id,学校信息公开,课题参与人数上限,课题阶段总时间上限,审核课题人数,审核课题通过数,课题阶段上限,课题阶段下限," +
                "课题所选次数上限,指导团队上限,是否可更改账户,覆盖用户数据源,通告显示条数 from 学校界面的系统参数设置 where 学校Id=?";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql);

            sta.setInt(1, schoolId);
            res = connectObj.getQueryResultSet();

            if(res.next()){
                schoolParams = new SchoolParams();
                schoolParams.setSchoolId(res.getInt(1));
                schoolParams.setInforOvert(res.getString(2));
                schoolParams.setParterUpperLimit(res.getInt(3));
                schoolParams.setStageUpperTime(res.getInt(4));
                schoolParams.setAuditNumber(res.getInt(5));
                schoolParams.setAdoptNumber(res.getInt(6));
                schoolParams.setStageUpperLimit(res.getInt(7));
                schoolParams.setStageFloorLimit(res.getInt(8));
                schoolParams.setProSelectLimit(res.getInt(9));
                schoolParams.setGuideTeamLimit(res.getInt(10));
                schoolParams.setUpdateAccount(res.getString(11));
                schoolParams.setCoverFiles(res.getString(12));
                schoolParams.setNoticeNum(res.getInt(13));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

		return schoolParams;
	}

    /*
        更新学校参数
     */
	public Boolean updateSchoolParams(SchoolParams schoolParams) {
        Boolean updateRes = false;
        String sql = "update 学校界面的系统参数设置 set 学校信息公开=?,课题参与人数上限=?,课题阶段总时间上限=?,审核课题人数=?,审核课题通过数=?,课题阶段上限=?,课题阶段下限=?," +
                "课题所选次数上限=?,指导团队上限=?,是否可更改账户=?,覆盖用户数据源=?,通告显示条数=? where 学校Id=?";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql);

            sta.setString(1, schoolParams.getInforOvert());
            sta.setInt(2, schoolParams.getParterUpperLimit());
            sta.setInt(3, schoolParams.getStageUpperTime());
            sta.setInt(4, schoolParams.getAuditNumber());
            sta.setInt(5, schoolParams.getAdoptNumber());
            sta.setInt(6, schoolParams.getStageUpperLimit());
            sta.setInt(7, schoolParams.getStageFloorLimit());
            sta.setInt(8, schoolParams.getProSelectLimit());
            sta.setInt(9, schoolParams.getGuideTeamLimit());
            sta.setString(10, schoolParams.getUpdateAccount());
            sta.setString(11, schoolParams.getCoverFiles());
            sta.setInt(12, schoolParams.getNoticeNum());
            sta.setInt(13, schoolParams.getSchoolId());

            updateRes = sta.executeUpdate() > 0;

        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return updateRes;
	}

}
