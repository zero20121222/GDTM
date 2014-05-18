package com.GDT.Interface;

import java.io.OutputStream;

import com.GDT.Model.GDTAdminer;
import com.GDT.Model.GDTManageUser;
import com.GDT.Model.SchoolAdminer;


/**
 * GDT后台管理员用户对象
 * @author zero
 */
public interface GDTAdminInterface{
	
	/**
	 * 用户信息更改
	 * @param adminer
	 * 用户的更改信息
	 * @return Boolean
	 * 返回数据用户信息更改是否成功 true:成功,false:失败
	 */
	public Boolean doAlter(GDTAdminer adminer);
	
	/**
	 * 查询用户信息
	 * @param id
	 * 作为查询用户的编号输入信息
	 * @return GDTAdminer
	 * 返回用户的详细信息
	 */
	public GDTAdminer doSelect(int id);
	
	/**
	 * 判断用户名是否已被使用
	 * @param username
	 * GDT后台用户名
	 * @return Boolean
	 * 返回用户名是否已存在(true:已存在,false:未存在)
	 */
	public Boolean ifExistGDTUser(String username);
	
	/**
	 * 创建GDT后台管理员对象功能
	 * @param admininfor
	 * GDT后台管理员对象
	 * @return Boolean
	 * 返回对象创建是否成功
	 */
	public Boolean createGDTAdminer(GDTManageUser amininfor);
	
	/**
	 * 创建GDT后台审核人员对象功能
	 * @param auditinfor
	 * GDT后台审核人员详细信息
	 * @return Boolean
	 * 返回GDT审核人员用户创建是否成功(true:成功,false:失败)
	 */
	public Boolean createGDTAuditer(GDTManageUser auditinfor);
	
	
	////////////////////////////////////		GDT后台管理员对于学校注册信息的处理操作		///////////////////////////
	/**
	 * 判断学校管理员的用户名是否已被使用
	 * @param username
	 * 学校管理对象用户名
	 * @param schoolId
	 * 学校编号
	 * @return Boolean
	 * 返回用户名是否已存在(true:已存在,false:未存在)
	 */
	public Boolean ifExistSchoolUser(String username , int schoolId);
	
	/**
	 * 为审核通过的学校注册一个管理员账号
	 * @param schooladmin
	 * 需要创建的学校管理员对象信息
	 * @return Boolean
	 * 返回创建用户是否成功(true:成功 ,false:失败)
	 */
	public Boolean createSchoolAdmin(SchoolAdminer schooladmin);
	
	
	//////////////////////////////////			GDT后台管理对于学校的学生及教师数据源文件|数据库连接导入到GDT数据库中			////////////////////////////////
	/**
	 * 验证数据源文件格式是否正确
	 * @param fileId
	 * 学校数据源文件编号
	 * @return int
	 * 返回验证的结果(0:格式正确,-1:数据源文件不存在,1:连接正常)
	 */
	public int checkFileStage(int fileId);
	
	/**
	 * 验证学校数据库连接是否正确以及可用
	 * @param linkId
	 * 学校数据库连接编号
	 * @return int
	 * 返回验证的结果(0:格式正确,-1:连接不存在,1:连接正常)
	 */
	public int checkLinkStage(int linkId);
	
	/**
	 * 获取查询学校的学生数据源文件
	 * @param schoolId
	 * 学校编号
	 * @return String
	 * 返回一个包含数据源文件名称，文件编号，文件路径的JSON数据对象
	 */
	public String getStudentsFile(int schoolId);
	
	/**
	 * 获取一个学校的学生数据源文件流对象
	 * @param schoolId
	 * 学校编号 
	 * @return OutputStream
	 * 返回一个学校数据源文件流对象
	 */
	public OutputStream getStudentsFileIO(int schoolId);
	
	/**
	 * 获取查询学校的教师数据源文件
	 * @param schoolId
	 * 学校编号
	 * @return String
	 * 返回一个包含数据源文件名称，文件编号，文件路径的JSON数据对象
	 */
	public String getTeachersFile(int schoolId);
	
	/**
	 * 获取一个学校的教师数据源文件流对象
	 * @param schoolId
	 * 学校编号 
	 * @return OutputStream
	 * 返回一个学校数据源文件流对象
	 */
	public OutputStream getTeachersFileIO(int schoolId);
	
	/**
	 * 将学校的数据源文件的数据导入到数据库
	 * @param fileId
	 * 数据源文件编号
	 * @return Boolean
	 * 返回数据源文件导入是否成功
	 */
	public Boolean leadSchoolUsersFile(int fileId);
	
	/**
	 * 将学校的数据库人员信息导入到数据库
	 * @param linkId
	 * 数据源文件编号
	 * @return Boolean
	 * 返回学校数据库人员信息导入到GDT数据库是否成功
	 */
	public Boolean leadSchoolUsersLink(int linkId);
}
