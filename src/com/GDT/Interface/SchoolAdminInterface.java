package com.GDT.Interface;

import com.GDT.Model.CommonSchoolUser;
import com.GDT.Model.SchoolAdminer;
import com.GDT.Model.SchoolCollege;
import com.GDT.Model.SchoolInfor;
import com.GDT.Model.SchoolManageUser;
import com.GDT.Model.SchoolParams;
import com.GDT.Model.SchoolUsersFile;
import com.GDT.Model.SchoolUsersLink;

import java.util.List;
import java.util.Map;

/**
 * 学校管理人员对象处理接口
 * @author zero
 */
public interface SchoolAdminInterface{
	////////////////////////////////////////		学校管理员用户基本处理功能函数			/////////////////////////////////////////
	/**
	 * 保存学校管理员的基本信息当开始登入时
	 * @param adminer
	 * 学校管理员对象的详细信息
	 * @return Boolean
	 * 返回学校管理员信息是否保存成功
	 */
	public Boolean saveAdminerInfor(SchoolAdminer adminer);
	
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
	 * @param adminer
	 * 用户的更改信息
	 * @return Boolean
	 * 返回数据用户信息更改是否成功 true:成功,false:失败
	 */
	public Boolean doAlter(SchoolAdminer adminer);
	
	/**
	 * 查询用户信息
	 * @param id
	 * 作为查询用户的编号输入信息
	 * @return SchoolAdminer
	 * 返回用户的详细信息
	 */
	public SchoolAdminer doSelect(int id);
	
	/**
	 * 判断学校管理用户名是否已被使用
	 * @param username
	 * 学校管理人员用户名
	 * @return Boolean
	 * 返回用户名是否已存在(true:已存在,false:未存在)
	 */
	public Boolean ifExistManageUser(String username);
	
	/**
	 * 分配学校管理人员账号
	 * @param schooladmin
	 * 学校课题管理员账号信息
	 * @return Boolean
	 * 返回学校管理员账号创建是否成功
	 */
	public Boolean createSchoolAdminer(SchoolManageUser schooladmin);
	
	/**
	 * 分配审核人员账号的功能权限
	 * @param schoolAuditor
	 * 学校课题审核人员账号信息
	 * @return Boolean
	 * 返回学校课题审核人员账号创建是否成功
	 */
	public Boolean createSchoolAuditor(SchoolManageUser schoolAuditor);
	
	
	/////////////////////////////////////////		学校管理员对于学校信息的处理控制		////////////////////////////////////////////////////
	/**
	 * 学校基本信息的填写操作
	 * @param schoolinfor
	 * 学校详细信息类
	 * @return Boolean
	 * 表示学校详细信息保存是否成功
	 */
	public Boolean saveSchoolInfor(SchoolInfor schoolinfor);
	
	/**
	 * 根据学校编号查询学校的全部详细信息
	 * @param schoolId
	 * 学校编号（用于检索学校详细信息）
	 * @return SchoolInfor
	 * 返回一个检索得到的全部学校信息
	 */
	public SchoolInfor querySchoolInfor(int schoolId);
	
	/**
	 * 保存更改后的学校信息（假如已经在审核的学校信息是无法更改的）
	 * @param schoolinfor
	 * 更改后的学校详细信息
	 * @return Boolean
	 * 返回学校信息是否更改成功(true:更改成功,false:更改失败)
	 */
	public Boolean alterSchoolInfor(SchoolInfor schoolinfor);
	
	/**
	 * 查看学校的信息审核是否通过
	 * @param SchoolId
	 * 学校编号
	 * @return String
	 * 返回学校信息审核的当前状态（w:待审核,t:审核通过,f:审核不通过）
	 */
	public String querySchoolAudit(int SchoolId);
	
	/**
	 * 设置学校院系以及专业类别信息
	 * @param college
	 * 学校院系信息类
	 * @return Boolean
	 * 返回学校院系信息是否保存成功(true:更改成功,false:更改失败)
	 */
	public Boolean saveSchoolCollege(SchoolCollege college);
	
	/**
	 * 设置学校的参数信息
	 * @param params
	 * 学校控制参数对象信息
	 * @return Boolean
	 * 返回学校信息是否保存成功(true:保存成功,false:保存失败)
	 */
	public Boolean setSchoolParams(SchoolParams params);
	
	
	////////////////////////////////////////		学校管理员对于学生以及教师账号信息文件|数据源链接操作		//////////////////////////////////////////
	/**
	 * 手动的创建学生用户账号
	 * @param studentUser
	 * 学生用户账号信息
	 * @return Boolean
	 * 学生用户创建是否成功(true:成功,false:失败)
	 */
	public Boolean createStudentUser(CommonSchoolUser studentUser);
	
	/**
	 * 手动的创建教师用户账号
	 * @param teacherUser
	 * 教师用户账号信息
	 * @return Boolean
	 * 教师用户创建是否成功(true:成功,false:失败)
	 */
	public Boolean createTeacherUser(CommonSchoolUser teacherUser);
	
	/**
	 * 提供数据源文件保存操作
	 * @param userfile
	 * 学校用户数据源文件对象
     * @param autoLoad
     * 是否自动导入数据到数据库
     * @param filePath
     * 文件路径
	 * @return Boolean
	 * 返回数据源文件对象保存是否成功(true:成功,false:失败)
	 */
	public Boolean saveSchoolUsersFile(SchoolUsersFile userfile , Boolean autoLoad, String filePath);

    /**
     * 通过学校编号查询上传的资源文件
     * @param schoolId  学校编号
     * @return  List
     * 返回学校资源文件信息列表
     */
    public List<SchoolUsersFile> querySchoolUsersFiles(int schoolId);
	
	/**
	 * 提供数据库连接保存操作
	 * @param userlink
	 * 学校用户数据库连接对象
	 * @return Boolean
	 * 返回数据库连接对象保存是否成功(true:成功,false:失败)
	 */
	public Boolean saveSchoolUsersLink(SchoolUsersLink userlink);

    /**
     * 实现查询学校基本学生和教师用户信息
     * @param schoolId  学校编号
     * @param pageNo    当前页码
     * @param pageSize  每页显示数量
     * @param params    查询参数信息
     * @return  List
     * 返回查询到的用户信息
     */
    public List<CommonSchoolUser> querySchoolUsers(int schoolId , int pageNo, int pageSize, Map<String , String> params);

    /**
     * 实现查询学校基本学生和教师用户统计数据
     * @param schoolId  学校编号
     * @param pageNo    当前页码
     * @param pageSize  每页显示数量
     * @param params    查询参数信息
     * @return  Map
     * 返回查询到的用户统计数据
     */
    public Map<String , String> querySchoolUserCount(int schoolId, int pageNo, int pageSize, Map<String, String> params);

    /**
     * 实现查询学校审核人员用户信息
     * @param schoolId  学校编号
     * @param pageNo    当前页码
     * @param pageSize  每页显示数量
     * @param params    查询参数信息
     * @return  List
     * 返回查询到的用户信息
     */
    public List<SchoolManageUser> querySchoolAuditors(int schoolId , int pageNo, int pageSize, Map<String , String> params);

    /**
     * 实现查询学校审核人员的统计数据
     * @param schoolId  学校编号
     * @param pageNo    当前页码
     * @param pageSize  每页显示数量
     * @param params    查询参数信息
     * @return  Map
     * 返回查询到的用户统计数据
     */
    public Map<String , String> querySchoolAuditorCount(int schoolId, int pageNo, int pageSize, Map<String, String> params);

    public Boolean existAuditorName(int schoolId , String userName);
}
