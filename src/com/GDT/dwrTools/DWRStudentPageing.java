package com.GDT.dwrTools;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import com.GDT.Interface.DWRPagingInterface;
import com.GDT.Model.ProjectInfor;
import com.GDT.util.*;

/**
 * 学生课题查询分页操作处理的操作处理对象
 * @author zero
 */
public class DWRStudentPageing implements DWRPagingInterface{
	private DBConnectionInterface connectObj = null;
	private PreparedStatement sta = null;
	private ResultSet res = null;

	/**
	 * 通过课题创建人名来索引分页数据信息
	 * @see com.GDT.Interface.ProjectPagingInterface#pagingByCreateName(int, java.lang.String, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByCreateName(int pageNow, int userId, int schoolId,
			String createrName, String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";
		
		String sql = "select 毕业课题详细信息.Id,毕业课题详细信息.学校Id,毕业课题名称,出题人Id,教师详细信息.真实姓名,参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
			+"from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
			+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
			+" and 题目状态='"+pagingType+"'"+" and 教师详细信息.真实姓名 like '%"+createrName+"%'"
			+" order by 毕业课题详细信息.Id limit "+pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;

		return this.queryProjectPaging(sql);
	}
	
	public String pagingByCreateNameJSON(int pageNow, int userId, int schoolId, String createrName,
			String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";
		
		String sql = "select 毕业课题详细信息.Id,毕业课题详细信息.学校Id,毕业课题名称,出题人Id,教师详细信息.真实姓名,参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
				+"from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"'"+" and 教师详细信息.真实姓名 like '%"+createrName+"%'"
				+" order by 毕业课题详细信息.Id limit "+pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;

		return this.queryProjectPagingJSON(sql);
	}

	public Map<String, Integer> getPageNumberByCreateName(int userId, int schoolId, 
			String createrName, String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";
		
		String sql = "select count(毕业课题详细信息.Id) from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 " 
				+"where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"'"+" and 教师详细信息.真实姓名 like '%"+createrName+"%'";
		
		return this.getPageNumbers(sql, PAGINGCOUNTS);
	}

	/**
	 * 根据限定的学院名称
	 * @see com.GDT.Interface.ProjectPagingInterface#pagingByCollege(int, java.lang.String, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByCollege(int pageNow, int userId, int schoolId, String collegeName,
			String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";
		
		String sql = "select 毕业课题详细信息.Id,毕业课题详细信息.学校Id,毕业课题名称,出题人Id,教师详细信息.真实姓名,参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
				+"from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"'"+" and 院系限定 like '%"+collegeName+"%'"
				+" order by 毕业课题详细信息.Id limit "+pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;

		return this.queryProjectPaging(sql);
	}

	public String pagingByCollegeJSON(int pageNow, int userId, int schoolId, String collegeName,
			String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";

		String sql = "select 毕业课题详细信息.Id,毕业课题详细信息.学校Id,毕业课题名称,出题人Id,教师详细信息.真实姓名,参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
				+"from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"'"+" and 院系限定 like '%"+collegeName+"%'"
				+" order by 毕业课题详细信息.Id limit "+pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPagingJSON(sql);
	}

	public Map<String, Integer> getPageNumberByCollege(int userId, int schoolId,
			String collegeName, String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";

		String sql = "select count(毕业课题详细信息.Id) from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"'"+" and 院系限定 like '%"+collegeName+"%'";

		return this.getPageNumbers(sql, PAGINGCOUNTS);
	}

	/**
	 * 通过课题名称查询分页数据信息
	 * @see com.GDT.Interface.ProjectPagingInterface#pagingByProjectName(int, java.lang.String, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByProjectName(int pageNow, int userId, int schoolId,
			String projectName, String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";
		
		String sql = "select 毕业课题详细信息.Id,毕业课题详细信息.学校Id,毕业课题名称,出题人Id,教师详细信息.真实姓名,参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
				+"from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"'"+" and 毕业课题名称 like '%"+projectName+"%'"
				+" order by 毕业课题详细信息.Id limit "+pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS; 

		return this.queryProjectPaging(sql);
	}

	public String pagingByProjectNameJSON(int pageNow, int userId, int schoolId, String projectName,
			String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";
		
		String sql = "select 毕业课题详细信息.Id,毕业课题详细信息.学校Id,毕业课题名称,出题人Id,教师详细信息.真实姓名,参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
				+"from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"'"+" and 毕业课题名称 like '%"+projectName+"%'"
				+" order by 毕业课题详细信息.Id limit "+pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;

		return this.queryProjectPagingJSON(sql);
	}

	public Map<String, Integer> getPageNumberByProjectName(int userId, int schoolId,
			String projectName, String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";
		
		String sql = "select count(毕业课题详细信息.Id) from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"'"+" and 毕业课题名称 like '%"+projectName+"%'";
		
		return this.getPageNumbers(sql, PAGINGCOUNTS);
	}

	
	/**
	 * 根据课题的限定人数索引分页数据
	 * @see com.GDT.Interface.ProjectPagingInterface#pagingByPartNum(int, int, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByPartNum(int pageNow, int userId, int schoolId, int partNum,
			String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";
		
		String sql = "select 毕业课题详细信息.Id,毕业课题详细信息.学校Id,毕业课题名称,出题人Id,教师详细信息.真实姓名,参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
				+"from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"'"+( partNum == 0 ? " " : " and 参与人数限定="+partNum)
				+" order by 毕业课题详细信息.Id limit "+pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPaging(sql);
	}

	public String pagingByPartNumJSON(int pageNow, int userId, int schoolId, int partNum,
			String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";
		
		String sql = "select 毕业课题详细信息.Id,毕业课题详细信息.学校Id,毕业课题名称,出题人Id,教师详细信息.真实姓名,参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
				+"from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"'"+( partNum == 0 ? " " : " and 参与人数限定="+partNum)
				+" order by 毕业课题详细信息.Id limit "+pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPagingJSON(sql);
	}

	public Map<String, Integer> getPageNumberByPartNum(int userId, int schoolId,
			int partNum, String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";
		
		String sql = "select count(毕业课题详细信息.Id) from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"'"+( partNum == 0 ? " " : " and 参与人数限定="+partNum);

		return this.getPageNumbers(sql, PAGINGCOUNTS);
	}

	
	/**
	 * 根据课题的难易程度索引分页数据
	 * @see com.GDT.Interface.ProjectPagingInterface#pagingByHardNum(int, int, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByHardNum(int pageNow, int userId, int schoolId, int hardNum,
			String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";
		
		String sql = "select 毕业课题详细信息.Id,毕业课题详细信息.学校Id,毕业课题名称,出题人Id,教师详细信息.真实姓名,参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
				+"from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"'"+( hardNum == 0 ? "" : " and 难易程度="+hardNum)
				+" order by 毕业课题详细信息.Id limit "+pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPaging(sql);
	}

	public String pagingByHardNumJSON(int pageNow, int userId, int schoolId, int hardNum,
			String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";
		
		String sql = "select 毕业课题详细信息.Id,毕业课题详细信息.学校Id,毕业课题名称,出题人Id,教师详细信息.真实姓名,参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
				+"from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"'"+( hardNum == 0 ? "" : " and 难易程度="+hardNum)
				+" order by 毕业课题详细信息.Id limit "+pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPagingJSON(sql);
	}

	public Map<String, Integer> getPageNumberByHardNum(int userId, int schoolId,
			int hardNum, String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";
		
		String sql = "select count(毕业课题详细信息.Id) from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"'"+( hardNum == 0 ? "" : " and 难易程度="+hardNum);

		return this.getPageNumbers(sql, PAGINGCOUNTS);
	}
	
	/**
	 * 根据学校编号获取分页信息内容
	 * @see com.GDT.Interface.ProjectPagingInterface#pagingBySchoolId(int, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingBySchoolId(int pageNow, int userId, int schoolId, String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";
		
		String sql = "select 毕业课题详细信息.Id,毕业课题详细信息.学校Id,毕业课题名称,出题人Id,教师详细信息.真实姓名,参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
				+"from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"' order by 毕业课题详细信息.Id limit "+pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPaging(sql);
	}

	public String pagingBySchoolIdJSON(int pageNow, int userId, int schoolId, String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";

		String sql = "select 毕业课题详细信息.Id,毕业课题详细信息.学校Id,毕业课题名称,出题人Id,教师详细信息.真实姓名,参与人数限定,工作量大小,院系限定,难易程度,图片信息,课题文件下载,创建时间,题目状态 "
				+"from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"' order by 毕业课题详细信息.Id limit "+pageNow*PAGINGCOUNTS+","+PAGINGCOUNTS;
		
		return this.queryProjectPagingJSON(sql);
	}

	public Map<String, Integer> getPageNumberBySchoolId(int userId, int schoolId, String pagingType) {
		java.util.Date dateTime = GDTDate.getUtilDate();
		int year = GDTDate.getUtilDateInfor(GDTDate.DATE_YEAR, dateTime);
		year = GDTDate.getUtilDateInfor(GDTDate.DATE_MONTH, dateTime)+1 > 7 ? year+1 : year;
		String startTime = (year-1)+"-08-01";
		String endTime = year+"-07-31";
		
		String sql = "select count(毕业课题详细信息.Id) from 毕业课题详细信息,教师详细信息,学生详细信息,学校界面的系统参数设置 where 教师详细信息.Id=出题人Id and 课题所选次数上限>课题被选择次数 and 学生详细信息.Id="+userId
				+" and (学生详细信息.院系类别=院系限定 or 院系限定='null') and 毕业课题详细信息.学校Id="+schoolId+" and 创建时间 between '"+startTime+"' and '"+endTime+"'"
				+" and 题目状态='"+pagingType+"'";
		
		return this.getPageNumbers(sql, PAGINGCOUNTS);
	}
	
	/**
	 * 创建一个private的sql查询语句操作处理
	 * @param sql
	 * 需要执行的sql语句对象
	 * @return List<ProjectInfor>
	 * 返回一个课题的链表信息对象
	 */
	private List<ProjectInfor> queryProjectPaging(String sql){
		List<ProjectInfor> list = new ArrayList<ProjectInfor>();
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			res = connectObj.getQueryResultSet();
			ProjectInfor project = null;
			while(res.next()){
				project = new ProjectInfor();
				
				project.setId(res.getInt(1));
				project.setSchoolId(res.getInt(2));
				project.setProjectName(res.getString(3));
				project.setCreaterId(res.getInt(4));
				project.setCreaterName(res.getString(5));
				project.setPartNum(res.getInt(6));
				project.setWorkload(res.getString(7));
				project.setCollege(res.getString(8));
				project.setHardNum(res.getInt(9));
				project.setPicture(res.getString(10));
				project.setProjectFile(res.getString(11));
				project.setCreateDate(res.getDate(12));
				project.setStage(res.getString(13));
				
				list.add(project);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return list;
	}
	
	/**
	 * 创建一个private的sql查询语句操作处理
	 * @param sql
	 * 需要执行的sql语句对象
	 * @return String
	 * 返回一个课题的JSON格式的数据信息对象
	 */
	private String queryProjectPagingJSON(String sql){
		JSONArray jsonArray = new JSONArray();
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			res = connectObj.getQueryResultSet();
			JSONObject json = null;
			while(res.next()){
				json = new JSONObject();
				
				json.put("id", res.getInt(1));
				json.put("schoolId", res.getInt(2));
				json.put("projectName", res.getString(3));
				json.put("createrId", res.getInt(4));
				json.put("createrName", res.getString(5));
				json.put("partNum", res.getInt(6));
				json.put("workload", res.getString(7));
				json.put("college", res.getString(8));
				json.put("hardNum", res.getInt(9));
				json.put("picture", res.getString(10));
				json.put("projectFile", res.getString(11));
				json.put("createTime", res.getDate(12));
				json.put("stage", res.getString(13));
				
				jsonArray.put(json);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return jsonArray.toString();
	}
	
	/**
	 * 获取课题的页面数目&页面对象数目
	 * @param sql
	 * 需要查询的sql语句操作
	 * @param pageCounts
	 * 需要分页的分页数目
	 * @return Map<String , Integer>
	 * 返回一个键值对的操作处理
	 */
	private Map<String , Integer> getPageNumbers(String sql, int pageCounts) {
		Map<String , Integer> params = new HashMap<String , Integer>();
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			res = connectObj.getQueryResultSet();
			if(res.next()){
				int objNumber = res.getInt(1);
				params.put(PAGINGOBJNUMBERS, objNumber);
				params.put(PAGINGPAGENUMBERS, objNumber%PAGINGCOUNTS == 0 ? objNumber/PAGINGCOUNTS : objNumber/PAGINGCOUNTS + 1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return params;
	}
}
