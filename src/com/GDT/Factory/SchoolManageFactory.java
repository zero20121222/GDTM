package com.GDT.Factory;

import com.GDT.Interface.SchoolCollegeInterface;
import com.GDT.Interface.SchoolManageFactoryInterface;
import com.GDT.Interface.SchoolParamsInterface;
import com.GDT.ModelCL.SchoolCollegeCL;
import com.GDT.ModelCL.SchoolParamsCL;

/**
 * 学校信息操作管理对象创建工厂类
 * @author zero
 */
public class SchoolManageFactory implements SchoolManageFactoryInterface{
	
	/**
	 * @see com.GDT.Interface.SchoolManageFactoryInterface#createSchoolCollegeCL()
	 * 创建一个SchoolCollegeInterface学校院系管理操作接口
	 * @author zero
	 */
	public SchoolCollegeInterface createSchoolCollegeCL() {
		return new SchoolCollegeCL();
	}

	/**
	 * @see com.GDT.Interface.SchoolManageFactoryInterface#createSchoolParamsCL()
	 * @author zero
	 */
	public SchoolParamsInterface createSchoolParamsCL() {
		return new SchoolParamsCL();
	}
}
