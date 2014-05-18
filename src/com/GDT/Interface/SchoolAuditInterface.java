package com.GDT.Interface;

import com.GDT.Model.SchoolAuditer;

/**
 * 关于学校审核人员的功能接口设计
 * @author zero
 */
public interface SchoolAuditInterface{
	////////////////////////////////////////		学校审核人员用户基本处理功能函数			/////////////////////////////////////////
	/**
	 * 保存审核用户的基本信息当开始登入时
	 * @param aduiter
	 * 审核用户对象的详细信息
	 * @return Boolean
	 * 返回审核人员信息是否保存成功
	 */
	public Boolean saveAuditerInfor(SchoolAuditer aduiter);
	
	/**
	 * 查询是否允许更改详细信息
	 * @param schoolId
	 * 学校编号
	 * @return Boolean
	 * 返回是否允许更改用户信息
	 */
	public Boolean ifAllowUpdate(int schoolId);
	
	/**
	 * 用户信息更改
	 * @param auditer
	 * 用户的更改信息
	 * @return Boolean
	 * 返回数据用户信息更改是否成功 true:成功,false:失败
	 */
	public Boolean doAlter(SchoolAuditer auditer);
	
	/**
	 * 查询用户信息
	 * @param id
	 * 作为查询用户的编号输入信息
	 * @return SchoolAuditer
	 * 返回用户的详细信息
	 */
	public SchoolAuditer doSelect(int id);
}
