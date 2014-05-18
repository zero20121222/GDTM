package com.GDT.Interface;

/**
 * 用于管理全部信息处理类创建的管理接口
 * @author zero
 */
public interface NewsFactoryInterface {
	/**
	 * 创建一个操作学校最新通知信息的处理类对象
	 * @return SchoolNewInterface
	 * 返回学校最新通知信息处理接口
	 */
	public SchoolNewInterface createSchoolNewCL();
	
	/**
	 * 创建一个操作学生或者教师最新信息的处理类对象
	 * @return STNewsInterface
	 * 返回学生或者教师信息处理接口
	 */
	public STNewsInterface createNewInforCL();
}
