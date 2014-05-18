package com.GDT.Interface;

import com.GDT.Model.GDTAuditer;

/**
 * GDT后台审核人员功能接口
 * @author zero
 */
public interface GDTAuditInterface{
	/**
	 * 用户信息更改
	 * @param adminer
	 * 用户的更改信息
	 * @return Boolean
	 * 返回数据用户信息更改是否成功 true:成功,false:失败
	 */
	public Boolean doAlter(GDTAuditer adminer);
	
	/**
	 * 查询用户信息
	 * @param id
	 * 作为查询用户的编号输入信息
	 * @return GDTAuditer
	 * 返回用户的详细信息
	 */
	public GDTAuditer doSelect(int id);
}
