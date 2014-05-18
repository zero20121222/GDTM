package com.GDT.Interface;


/**
 * 学校管理操作接口实现对象
 * @author zero
 */
public interface SchoolManageFactoryInterface {
	
	/**
	 * 创建一个SchoolCollegeInterface学校院系管理操作接口
	 */
	public SchoolCollegeInterface createSchoolCollegeCL();
	
	/**
	 * 创建一个SchoolParamsInterface用于学校的参数设置管理接口
	 */
	public SchoolParamsInterface createSchoolParamsCL();
}
