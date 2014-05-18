package com.GDT.Interface;

import java.util.List;

import com.GDT.Model.SchoolCollege;

/**
 * 学校院系管理接口
 * @author zero
 */
public interface SchoolCollegeInterface {
	/**
	 * 设置学校院系以及专业类别信息
	 * @param college
	 * 学校院系信息类
	 * @return Boolean
	 * 返回学校院系信息是否保存成功(true:更改成功,false:更改失败)
	 */
	public Boolean saveSchoolCollege(SchoolCollege college);
	
	/**
	 * 更改学校院系以及专业类别信息
	 * @param college
	 * 学校院系信息类
	 * @return Boolean
	 * 返回学校院系信息更改是否保存成功(true:更改成功,false:更改失败)
	 */
	public Boolean alterSchoolCollege(SchoolCollege college);
	
	/**
	 * 删除学校院系以及专业类别信息
	 * @param schoolId
	 * 学校编号用于学校的检索
	 * @param collegeName
	 * 学校院系的名称用于专业的检索
	 * @return Boolean
	 * 返回学校院系信息删除是否保存成功(true:更改成功,false:更改失败)
	 */
	public Boolean deleteSchoolCollege(int SchoolId , String collegeName);
	
	/**
	 * 查询院系的全部专业名称
	 * @param schoolId
	 * 学校编号用于学校的检索
	 * @param collegeName
	 * 学校院系的名称用于专业的检索
	 * @return String
	 * 返回一个学校的学院的专业详细信息的JSON字符串
	 */
	public String querySchoolCollege(int SchoolId , String collegeName);
	
	/**
	 * 查询学校的全部院系信息
	 * @param schoolId
	 * 学校编号用于学校的检索
	 * @return String
	 * 返回一个学校的全部学院的专业详细信息的JSON字符串
	 */
	public String querySchoolColleges(int SchoolId);
	
	/**
	 * 查询学校的全部院系信息
	 * @param schoolId
	 * 学校编号用于学校的检索
	 * @return String
	 * 返回一个学校的全部学院的专业详细信息的JSON字符串
	 */
	public List<SchoolCollege> queryAllSchoolCollege(int schoolId);
}
