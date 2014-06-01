package com.GDT.Interface;

import java.util.List;

import com.GDT.Model.AdminRequestInfor;
import com.GDT.Model.ProjectAuditInfor;
import com.GDT.Model.ProjectInfor;
import com.GDT.Model.SchoolManageUser;

/**
 * 学校管理人员用户接口对象
 * @author zero
 */
public interface ManageSUserInterface extends UserInterface{

	/**
	 * 用户登入操作处理
	 * @param schoolId
	 * 学校编号
	 * @param name
	 * 登入用户名
	 * @param password
	 * 登入用户密码
	 * @return int
	 * 返回一个人员的用户编号
	 */
	public int doLogin(int schoolId , String name, String password);
	
	/**
	 * 获取用户的类型
	 * @param userId
	 * 用户的编号用于检索用户的类型
	 * @return String
	 * 返回用户的类型信息
	 */
	public String queryUserType(int userId);

    /**
     * 通过用户编号获取用户信息
     * @param userId    用户编号
     * @return  SchoolManageUser
     * 返回管理员信息
     */
    public SchoolManageUser queryUserInfo(int userId);
	
	/**
	 * 学校管理用户查看最新信息
	 * @param userId
	 * 用户编号
	 * @param type
	 * 需要查询的最新信息的状态类型(已处理信息 ，未处理信息)
	 * @return List<AdminRequestInfor>
	 * 返回的数据类型是一个链表数据类型
	 */
	public List<AdminRequestInfor> queryNews(int userId , String type);
	
	/**
	 * 学校管理用户查看最新信息
	 * @param userId
	 * 用户编号
	 * @param type
	 * 需要查询的最新信息的状态类型(已处理信息 ，未处理信息)
	 * @return String
	 * 返回一个最新信息的String的JSON类型的字符串
	 */
	public String queryNewInfors(int userId , String type);
	
	/**
	 * 获取学校最新通知信息操作
	 * @param schoolId
	 * 学校编号用于检索学校最新通知信息
	 * @return String
	 * 返回一个JSON数据格式的字符串信息
	 */
	public String querySchoolNews(int schoolId);
	
	////////////////////////////////////////		学校课题管理人员对于课题的审核操作处理			///////////////////////////////////////////
	/**
	 * 查询课题的详细信息操作
	 * @param projectId
	 * 得到课题编号用于检索课题详细信息
	 * @return ProjectInfor
	 * 返回一个课题的详细信息对象
	 */
	public ProjectInfor queryProjectInfor(int projectId);
	
	/**
	 * 对于课题进行审核操作处理
	 * @param projectId
	 * 课题编号
	 * @param userId
	 * 学校管理用户编号
	 * @param audit
	 * 审核处理操作结果
	 * @param comment
	 * 审核评语信息
	 */
	public Boolean auditProject(int projectId , int userId, String audit, String comment);
	
	/**
	 * 获取当前课题的审核情况
	 * @param projectId
	 * 需要查看的课题编号
	 * @return List<ProjectAuditInfor>
	 * 返回一个审核情况信息的链表对象
	 */
	public List<ProjectAuditInfor> queryAllAuditInfor(int projectId);
	
	/**
	 * 获取当前课题的审核情况
	 * @param projectId
	 * 需要查看的课题编号
	 * @return String
	 * 返回一个JSON格式的审核情况信息字符串
	 */
	public String queryAuditInfors(int projectId);
}
