package com.GDT.ModelCL;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import com.GDT.Interface.SchoolCollegeInterface;
import com.GDT.Model.SchoolCollege;
import com.GDT.util.DBConnection;
import com.GDT.util.DBConnectionInterface;
import com.google.common.collect.Lists;

/**
 * 学校院系信息处理类
 * @author zero
 */
public class SchoolCollegeCL implements SchoolCollegeInterface{
	private DBConnectionInterface connectObj = null;
	private PreparedStatement sta = null;
	private ResultSet res = null;

    @Override
	public Boolean alterSchoolCollege(SchoolCollege college) {
        Boolean update = false;
        String sql = "update 学校院系信息 set ";

        if(college.getMajor1() != null){
            sql += "专业名称1='"+college.getMajor1()+"',";
        }
        if(college.getMajor2() != null){
            sql += "专业名称2='"+college.getMajor2()+"',";
        }
        if(college.getMajor3() != null){
            sql += "专业名称3='"+college.getMajor3()+"',";
        }
        if(college.getMajor4() != null){
            sql += "专业名称4='"+college.getMajor4()+"',";
        }
        if(college.getMajor5() != null){
            sql += "专业名称5='"+college.getMajor5()+"',";
        }
        if(college.getMajor6() != null){
            sql += "专业名称6='"+college.getMajor6()+"',";
        }
        if(college.getMajor7() != null){
            sql += "专业名称7='"+college.getMajor7()+"',";
        }
        if(college.getMajor8() != null){
            sql += "专业名称8='"+college.getMajor8()+"',";
        }
        if(college.getMajor9() != null){
            sql += "专业名称9='"+college.getMajor9()+"',";
        }
        if(college.getMajor10() != null){
            sql += "专业名称10='"+college.getMajor10()+"',";
        }

        sql = sql.substring(0 , sql.lastIndexOf(","));
        sql += " where 学校Id="+college.getSchoolId()+" and 院系名称='"+college.getCollegeName()+"';";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql);

            update = sta.executeUpdate() > 0;
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return update;
	}

	public Boolean deleteSchoolCollege(int SchoolId, String collegeName) {
		// TODO Auto-generated method stub
		return null;
	}

    @Override
	public List<SchoolCollege> queryAllSchoolCollege(int schoolId) {
        List<SchoolCollege> collegeList = Lists.newArrayList();
        String sql = "select 院系名称,专业名称1,专业名称2,专业名称3,专业名称4,专业名称5,专业名称6,专业名称7,专业名称8,专业名称9,专业名称10 from 学校院系信息 where 学校Id = ?;";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql);
            sta.setInt(1, schoolId);

            res = connectObj.getQueryResultSet();

            SchoolCollege schoolCollege;
            while(res.next()){
                schoolCollege = new SchoolCollege();

                schoolCollege.setCollegeName(res.getString(1));
                schoolCollege.setMajor1(res.getString(2));
                schoolCollege.setMajor2(res.getString(3));
                schoolCollege.setMajor3(res.getString(4));
                schoolCollege.setMajor4(res.getString(5));
                schoolCollege.setMajor5(res.getString(6));
                schoolCollege.setMajor6(res.getString(7));
                schoolCollege.setMajor7(res.getString(8));
                schoolCollege.setMajor8(res.getString(9));
                schoolCollege.setMajor9(res.getString(10));
                schoolCollege.setMajor10(res.getString(11));
                collegeList.add(schoolCollege);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return collegeList;
	}

    @Override
	public SchoolCollege querySchoolCollege(int schoolId, String collegeName) {
        SchoolCollege schoolCollege = null;
        String sql = "select 院系名称,专业名称1,专业名称2,专业名称3,专业名称4,专业名称5,专业名称6,专业名称7,专业名称8,专业名称9,专业名称10 from 学校院系信息 where 学校Id=? and 院系名称=?;";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql);
            sta.setInt(1, schoolId);
            sta.setString(2 , collegeName);

            res = connectObj.getQueryResultSet();
            if(res.next()){
                schoolCollege = new SchoolCollege();

                schoolCollege.setCollegeName(res.getString(1));
                schoolCollege.setMajor1(res.getString(2));
                schoolCollege.setMajor2(res.getString(3));
                schoolCollege.setMajor3(res.getString(4));
                schoolCollege.setMajor4(res.getString(5));
                schoolCollege.setMajor5(res.getString(6));
                schoolCollege.setMajor6(res.getString(7));
                schoolCollege.setMajor7(res.getString(8));
                schoolCollege.setMajor8(res.getString(9));
                schoolCollege.setMajor9(res.getString(10));
                schoolCollege.setMajor10(res.getString(11));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return schoolCollege;
	}
	
	/*
	 * @see com.GDT.Interface.SchoolCollegeInterface#querySchoolColleges(int)
	 * 通过学校编号查询全部的学校院系信息是否用JSON数据格式返回
	 * @author zero
	 */
	public String querySchoolColleges(int schoolId) {
		StringBuffer json = new StringBuffer("[");//使用StringBuffer提高效率(在这不使用JSON原因是JSONObject使用的是Map是无序的)
		String sql = "select 院系名称,专业名称1,专业名称2,专业名称3,专业名称4,专业名称5,专业名称6,专业名称7,专业名称8,专业名称9,专业名称10 from 学校院系信息 where 学校Id = ?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, schoolId);
			
			res = connectObj.getQueryResultSet();
			
			while(res.next()){
				json.append("{");
				
				json.append("collegeName:'"+res.getString(1)+"',");
				json.append("major1:'"+res.getString(2)+"',");
				json.append("major2:'"+res.getString(3)+"',");
				json.append("major3:'"+res.getString(4)+"',");
				json.append("major4:'"+res.getString(5)+"',");
				json.append("major5:'"+res.getString(6)+"',");
				json.append("major6:'"+res.getString(7)+"',");
				json.append("major7:'"+res.getString(8)+"',");
				json.append("major8:'"+res.getString(9)+"',");
				json.append("major9:'"+res.getString(10)+"',");
				json.append("major10:'"+res.getString(11)+"'");
				
				json.append(res.isLast() ? "}" : "},");
			}
			json.append("]");
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return json.toString();
	}

	public Boolean saveSchoolCollege(SchoolCollege college) {
		// TODO Auto-generated method stub
		return null;
	}

}
