package com.GDT.Interface;

import java.io.OutputStream;
import java.util.List;

import com.GDT.Model.*;

/**
 * 普通学校用户接口对象
 * @author zero
 */
public interface CommonSUserInterface extends UserInterface{
	public final static int NEW_UNTREATED = 0;//信息未处理状态
	public final static int NEW_TREATED = 1;//信息已处理过的状态
	public final static int NEW_ALL = 2;//全部信息

	/**
	 * 用户登入操作处理
	 * @param schoolId
	 * 学校编号
	 * @param name
	 * 登入用户名
	 * @param password
	 * 登入用户密码
	 * @return int
	 * 返回一个用户的用户编号作为身份编号
	 */
	public int doLogin(int schoolId , String name, String password);

    /**
     * 通过用户编号获取用户信息
     * @param userId    用户编号
     * @return  SchoolManageUser
     * 返回管理员信息
     */
    public CommonSchoolUser queryUserInfo(int userId);
	
	/**
	 * 获取用户的类型
	 * @param userId
	 * 用户的编号用于检索用户的类型
	 * @return String
	 * 返回用户的类型信息
	 */
	public String queryUserType(int userId);
	
	/**
	 * 获取学校最新通知信息操作
	 * @param schoolId
	 * 学校编号用于检索学校最新通知信息
	 * @return String
	 * 返回一个JSON数据格式的字符串信息
	 */
	public String querySchoolNews(int schoolId);
	////////////////////////////////////			用户对于团队的管理				///////////////////////////////////////////
	/**
	 * 用户查看最新信息
	 * @param userId
	 * 用户编号
	 * @param type
	 * 需要查询的最新信息的状态类型
	 * @return List<NewInfor>
	 * 返回的数据类型是一个链表数据类型
	 */
	public List<NewInfor> queryNews(int userId , int type);
	
	/**
	 * 用户查看最新信息
	 * @param userId
	 * 用户编号
	 * @param type
	 * 需要查询的最新信息的状态类型(已处理信息 ，未处理信息)
	 * @return String
	 * 返回一个最新信息的String的JSON类型的字符串
	 */
	public String queryNewInfors(int userId , int type);
	
	/**
	 * 返回毕业课题详细信息
	 * @param projectId
	 * 毕业课题编号
	 * @return ProjectInfor
	 * 返回一个根据毕业课题编号查找到的毕业课题详细信息对象
	 */
	public ProjectInfor queryProject(int projectId);
	
	/**
	 * 查询团队全部学生用户信息
	 * @param teamId
	 * 团队编号用户检索团队信息
	 * @return List<Student>
	 * 返回一个团队学生对象链表
	 */
	public List<Student> queryTeamStudentInfors(int teamId);
	
	/**
	 * 查询团队的课题详细信息
	 * @param teamId
	 * 团队编号
	 * @return ProjectInfor
	 * 返回一个团队所选课题的详细信息
	 */
	public ProjectInfor queryTeamProject(int teamId);
	
	
	
	/////////////////////////////////////////			用户对于课题阶段的控制操作			////////////////////////////////////////////
	/**
	 * 查询团队全部阶段名称
	 * @param teamId
	 * 团队编号
	 * @return String
	 * 返回一个课题阶段名称以及阶段编号信息JSON格式的字符串（用户后期的Ajax调用）
	 */
	public String queryProjectStageNames(int teamId);
	
	/**
	 * 查询团队全部阶段名称
	 * @param teamId
	 * 团队编号
	 * @return List<ProjectStageInfor>
	 * 返回一个课题阶段名称以及阶段编号（使用ProjectStageInfor封装）的链表对象
	 */
	public List<ProjectStageInfor> queryProjectAllStageName(int teamId);
	
	/**
	 * 查询团队阶段详细信息
	 * @param teamId
	 * 团队编号
	 * @param stageId
	 * 团队课题阶段编号
	 * @return ProkectStageInfor
	 * 返回一个团队某一个阶段的详细信息
	 */
	public ProjectStageInfor queryProjectStageInfor(int teamId, int stageId);
	
	/**
	 * 得到学生在该阶段上传的全部文档
	 * @param teamId
	 * 团队编号
	 * @param stageId
	 * 阶段编号
	 * @return String
	 * 返回的是一个已JSON格式表示的文件名称以及路径&文件编号对象
	 */
	public String queryStageFiles(int teamId , int stageId);
	
	/**
	 * 得到学生在该阶段上传的全部文档
	 * @param teamId
	 * 团队编号
	 * @param stageId
	 * 阶段编号
	 * @return List<ProjectStageGuide>
	 * 返回的是一个以List对象封转的ProjectStageGuide对象链表
	 */
	public List<ProjectStageGuide> queryStageAllFiles(int teamId , int stageId);
	
	/**
	 * 显示摸个阶段的详细阶段文档内容信息
	 * @param fileId
	 * 阶段文档编号
	 * @return OutputStream
	 * 返回一个文件输出流对象
	 */
	public OutputStream displayStageFile(int fileId);
	
	/**
	 * 查看课题全部阶段指导信息
	 * @param teamId
	 * 团队编号
	 * @param stageId
	 * 阶段编号
	 * @return List<ProjectStageGuide>
	 * 返回全部阶段指导详细信息的链表对象
	 */
	public List<ProjectStageGuide> queryProjectStageGuides(int teamId, int stageId);
	
	/**
	 * 查看课题全部阶段指导信息
	 * @param teamId
	 * 团队编号
	 * @param stageId
	 * 阶段编号
	 * @return String
	 * 返回全部阶段指导详细信息的JSON格式（方便后期Ajax异步调用查询数据）
	 */
	public String queryStageGuides(int teamId, int stageId);
}
