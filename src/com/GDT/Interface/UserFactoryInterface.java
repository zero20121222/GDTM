package com.GDT.Interface;

/**
 * 用户对象创建工厂接口对象
 * @author zero
 */
public interface UserFactoryInterface {
	/**
	 * 创建一个普通学校用户对象处理类
	 * @return CommonSUserInterface
	 * 返回一个普通学校用户处理类接口
	 */
	public CommonSUserInterface createCommonSUserCL();
	
	/**
	 * 创建一个学校管理用户对象处理类
	 * @return ManageSUserInterface
	 * 返回一个学校管理用户处理类接口
	 */
	public ManageSUserInterface createManageSUserCL();
	
	/**
	 * 创建一个GDT管理用户对象处理类
	 * @return ManageGUserInterface
	 * 返回一个GDT管理用户处理类接口
	 */
	public ManageGUserInterface createManageGUserCL();
	
	/**
	 * 创建一个学生对象
	 * @return StudentInterface
	 * 返回一个学生用户处理类接口
	 */
	public StudentInterface createStudentCL();
	
	/**
	 * 创建一个教师对象
	 * @return TeacherInterface
	 * 返回一个教师用户处理类接口
	 */
	public TeacherInterface createTeacherCL();
	
	/**
	 * 创建一个学校管理人员对象
	 * @return SchoolAdminInterface
	 * 返回一个学校管理员用户处理接口
	 */
	public SchoolAdminInterface createSchoolAdminCL();
	
	/**
	 * 创建一个学校课题审核人员对象
	 * @return SchoolAuditInterface
	 * 返回一个学校课题审核操作人员接口
	 */
	public SchoolAuditInterface createSchoolAuditCL();
	
	/**
	 * 创建一个GDT后台管理人员对象
	 * @return GDTAdminInterface
	 * 返回一个GDT后台管理人员处理接口
	 */
	public GDTAdminInterface createGDTAdminCL();
	
	/**
	 * 创建一个GDT后台学校信息审核人员对象
	 * @return GDTAuditInterface
	 * 返回一个GDT后台学校信息审核人员处理接口
	 */
	public GDTAuditInterface createGDTAuditCL();
}
