package com.GDT.Interface;

import java.util.List;

import com.GDT.Model.AdminRequestInfor;
import com.GDT.Model.SchoolAuditInfor;
import com.GDT.Model.SchoolInfor;

/**
 * GDT后台人员用户接口对象
 * @author zero
 */
public interface ManageGUserInterface extends UserInterface{
	
	/**
	 * 用户登入操作处理
	 * @param name
	 * 登入用户名
	 * @param password
	 * 登入用户密码
	 * @return int
	 * 返回一个课题GDT后台人员的用户编号
	 */
	public int doLogin(String name, String password);
	
	/**
	 * 获取用户的类型
	 * @param userId
	 * 用户的编号用于检索用户的类型
	 * @return String
	 * 返回用户的类型信息
	 */
	public String queryUserType(int userId);
	
	/**
	 * GDT后台人员用户查看最新信息
	 * @param type
	 * 需要查询的最新信息的状态类型(已处理信息 ，未处理信息)
	 * @return List<AdminRequestInfor>
	 * 返回的数据类型是一个链表数据类型
	 */
	public List<AdminRequestInfor> queryNews(String type);
	
	/**
	 * GDT后台人员用户查看最新信息
	 * @param type
	 * 需要查询的最新信息的状态类型(已处理信息 ，未处理信息)
	 * @return String
	 * 返回一个最新信息的String的JSON类型的字符串
	 */
	public String queryNewInfors(String type);
	
	
	////////////////////////////////////////////		GDT后台人员对于学校信息审核处理操作		//////////////////////////////////////////
	/**
	 * 查看学校的注册信息操作
	 * @param schoolId
	 * 学校编号用于检索学校的详细信息
	 * @return SchoolInfor
	 * 返回一个学校的详细信息对象
	 */
	public SchoolInfor querySchoolInfor(int schoolId);
	
	/**
	 * 对学校信息进行审核操作
	 * @param schoolId
	 * 学校的编号对象
	 * @param userId
	 * GDT后台管理员编号
	 * @param audit
	 * 审核操作处理
	 * @param comment
	 * 审核操作的评语
	 */
	public Boolean auditSchoolInfor(int schoolId , int userId, String audit, String comment);
	
	/**
	 * 查看学校的信息审核状态
	 * @param schoolId
	 * 学校的编号对象
	 * @return String
	 * 返回一个学校信息的审核状态(w:等待审核,t:审核成功,f:审核失败);
	 */
	public String queryAuditStyle(int schoolId);
	
	/**
	 * 查看学校的审核信息
	 * @param schoolId
	 * 学校编号对象
	 * @return SchoolAuditInfor
	 * 返回一个学校的审核状态信息类
	 */
	public SchoolAuditInfor queryAllAuditInfor(int schoolId);
	
	/**
	 * 查看学校的审核信息
	 * @param schoolId
	 * 学校编号对象
	 * @return String
	 * 返回一个学校的审核状态字符串已JSON格式返回
	 */
	public String queryAuditInfors(int schoolId);
}
