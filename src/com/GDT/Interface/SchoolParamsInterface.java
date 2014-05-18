package com.GDT.Interface;

import com.GDT.Model.SchoolParams;

/**
 * 学校参数处理操作接口
 * @author zero
 */
public interface SchoolParamsInterface {
	/**
	 * 获取学校信息是否公开的参数设置信息
	 * @param schoolId
	 * 学校编号用于检索学校的参数信息
	 * @return Boolean
	 * 返回学校是否允许学校信息公开的设置
	 */
	public Boolean ifDisclosureInfor(int schoolId);
	
	/**
	 * 获取学校的课题人数上限统一设定值
	 * @param schoolId
	 * 学校编号用于检索学校的参数信息
	 * @return int
	 * 返回学校对于课题的最多多少人参加的人数上限设定
	 */
	public int parterUps(int schoolId);
	
	/**
	 * 获取学校的课题阶段参数学校系统设定值
	 * @param schoolId
	 * 学校编号用于检索学校的参数信息
	 * @return int[]
	 * 返回学校对于课题参数设定值
	 */
	public int[] projectStageParams(int schoolId);
	
	/**
	 * 获取学校审核课题人数的限定设置
	 * @param schoolId
	 * 学校编号用于检索学校的参数信息
	 * @return int
	 * 审核课题人数限定规定多少人审核课题
	 */
	public int auditerNumers(int schoolId);
	
	/**
	 * 获取学校审核课题通过数限定设置
	 * @param schoolId
	 * 学校编号用于检索学校的参数信息
	 * @return int
	 * 返回多少审核人员审核通过该课题才算通过
	 */
	public int auditerAdopt(int schoolId);
	
	/**
	 * 获取学校的课题阶段上限设定值
	 * @param schoolId
	 * 学校编号用于检索学校的参数信息
	 * @return int
	 * 返回该学校的课题规范中一个课题的最多阶段数目是多少
	 */
	public int projectStageUps(int schoolId);
	
	/**
	 * 获取学校的课题阶段下限设定值
	 * @param schoolId
	 * 学校编号用于检索学校的参数信息
	 * @return int
	 * 返回该学校的课题阶段数目的下限
	 */
	public int projectStageDowns(int schoolId);
	
	/**
	 * 获取学校的课题所选次数上限
	 * @param schoolId
	 * 学校编号用于检索学校的参数信息
	 * @return int
	 * 返回该学校的课题阶段数目的下限
	 */
	public int projectSelectUps(int schoolId);
	
	/**
	 * 获取学校的指导团队上限
	 * @param schoolId
	 * 学校编号用于检索学校的参数信息
	 * @return int
	 * 返回该学校的教师指导学生团队数目的上限是多少
	 */
	public int auditTeamUps(int schoolId);
	
	/**
	 * 获取学校的是否可更改账户
	 * @param schoolId
	 * 学校编号用于检索学校的参数信息
	 * @return Boolean
	 * 返回该学校的（就是指-》对于更改用户名&密码信息,T:允许,F:不允许）
	 */
	public Boolean ifAllowUpdatePassword(int schoolId);
	
	/**
	 * 获取学校的覆盖用户数据源
	 * @param schoolId
	 * 学校编号用于检索学校的参数信息
	 * @return Boolean
	 * 返回学校每次上传数据源文件或者是数据源链接时导入数据库时是否将原有的数据覆盖
	 */
	public Boolean ifAllowCoverInfor(int schoolId);
	
	/**
	 * 查询学校的全部参数设置信息
	 * @param schoolId
	 * 学校编号用于检索学校的参数信息
	 * @return Boolean
	 * 返回学校参数设置详细信息
	 */
	public SchoolParams querySchoolParams(int schoolId);
	
	/**
	 * 为学校的设置参数信息
	 * @param schoolParams
	 * 学校的详细的参数信息
	 * @return Boolean
	 * 返回学校参数设置是否成功
	 */
	public Boolean updateSchoolParams(SchoolParams schoolParams);
}
