package com.GDT.Interface;

import java.util.List;
import java.util.Map;

import com.GDT.Model.ProjectInfor;

/**
 * 课题对象分页操作的接口对象
 * @author zero
 */
public interface DWRPagingInterface {
	/**
	 * @see PAGINGPAGENUMBERS
	 * 用于标记页面对象数目
	 */
	public static final String PAGINGPAGENUMBERS = "pagingNumbers";
	
	/**
	 * @see PAGINGOBJNUMBERS
	 * 用于标记对象数目
	 */
	public static final String PAGINGOBJNUMBERS = "pagingObjNumbers";

	/**
	 * @see PAGINGCOUNTS
	 * 页面显示课题数目为6个
	 */
	public static final int PAGINGCOUNTS = 6;
	
	/**
	 * @see QUERYSAVE
	 * 标志毕业课题状态为保存状态
	 */
	public static final String QUERYSAVE = "S";
	/**
	 * @see QUERYWAIT
	 * 标志毕业课题状态为等待学校审核状态
	 */
	public static final String QUERYWAIT = "W";
	/**
	 * @see QUERYAUDTITRUE
	 * 标志毕业课题状态为审核通过状态
	 */
	public static final String QUERYAUDTITRUE = "T";
	/**
	 * @see QUERYAUDITFALSE
	 * 标志毕业课题状态为审核失败状态
	 */
	public static final String QUERYAUDITFALSE = "F";
	/**
	 * @see QUERYDELETE
	 * 标志毕业课题状态为课题删除状态（存放到回收站）
	 */
	public static final String QUERYDELETE = "D";
	
	/**
	 * 根据学校编号查找信息
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param pagingType
	 * 课题状态类型
	 * @return List<ProjectInfor>
	 * 返回一个全部需要查询信息的内容对象链表
	 */
	public List<ProjectInfor> pagingBySchoolId(int pageNow, int userId, int schoolId, String pagingType);
	
	/**
	 * 根据学校编号查找信息
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param pagingType
	 * 课题状态类型
	 * @return String
	 * 返回一个全部需要查询信息的内容的JSON数据类型的数据
	 */
	public String pagingBySchoolIdJSON(int pageNow, int userId, int schoolId, String pagingType);
	
	/**
	 * 获取按照学校编号获取页面数目
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param pagingType
	 * 课题状态类型
	 * @return Map<String , Integer>
	 * 返回一个键值对的操作处理
	 */
	public Map<String , Integer> getPageNumberBySchoolId(int userId, int schoolId, String pagingType);
	
	
	
	/**
	 * 根据课题设计人员查找信息
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param createrName
	 * 课题设计者名称来查询用户信息
	 * @param pagingType
	 * 课题状态类型
	 * @return List<ProjectInfor>
	 * 返回一个全部需要查询信息的内容对象链表
	 */
	public List<ProjectInfor> pagingByCreateName(int pageNow, int userId, int schoolId, String createrName, String pagingType);
	
	/**
	 * 根据课题设计人员查找信息
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param createrName
	 * 课题设计者名称来查询用户信息
	 * @param pagingType
	 * 课题状态类型
	 * @return String
	 * 返回一个全部需要查询信息的内容的JSON数据类型的数据
	 */
	public String pagingByCreateNameJSON(int pageNow, int userId, int schoolId, String createrName, String pagingType);
	
	/**
	 * 获取按照创建人名获取页面数目
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param createrName
	 * 课题设计者名称来查询用户信息
	 * @param pagingType
	 * 课题状态类型
	 * @return Map<String , Integer>
	 * 返回一个键值对的操作处理
	 */
	public Map<String , Integer> getPageNumberByCreateName(int userId, int schoolId, String createrName, String pagingType);
	
	
	
	/**
	 * 根据课题限定学院查找信息
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param collegeName
	 * 课题限定学院名称
	 * @param pagingType
	 * 课题状态类型
	 * @return List<ProjectInfor>
	 * 返回一个全部需要查询信息的内容对象链表
	 */
	public List<ProjectInfor> pagingByCollege(int pageNow, int userId, int schoolId, String collegeName, String pagingType);
	
	/**
	 * 根据课题限定学院查找信息
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param collegeName
	 * 课题限定学院名称
	 * @param pagingType
	 * 课题状态类型
	 * @return String
	 * 返回一个全部需要查询信息的内容的JSON数据类型的数据
	 */
	public String pagingByCollegeJSON(int pageNow, int userId, int schoolId, String collegeName, String pagingType);
	
	/**
	 * 获取按照课题限定学院获取页面数目
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param collegeName
	 * 课题限定学院名称
	 * @param pagingType
	 * 课题状态类型
	 * @return Map<String , Integer>
	 * 返回一个键值对的操作处理
	 */
	public Map<String , Integer> getPageNumberByCollege(int userId, int schoolId, String collegeName, String pagingType);
	
	
	/**
	 * 根据课题名称查找信息
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param projectName
	 * 课题名称
	 * @param pagingType
	 * 课题状态类型
	 * @return List<ProjectInfor>
	 * 返回一个全部需要查询信息的内容对象链表
	 */
	public List<ProjectInfor> pagingByProjectName(int pageNow, int userId, int schoolId, String projectName, String pagingType);
	
	/**
	 * 根据课题名称查找信息
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param projectName
	 * 课题名称
	 * @param pagingType
	 * 课题状态类型
	 * @return String
	 * 返回一个全部需要查询信息的内容的JSON数据类型的数据
	 */
	public String pagingByProjectNameJSON(int pageNow, int userId, int schoolId, String projectName, String pagingType);
	
	/**
	 * 获取按照课题名称获取页面数目
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param projectName
	 * 课题名称
	 * @param pagingType
	 * 课题状态类型
	 * @return Map<String , Integer>
	 * 返回一个键值对的操作处理
	 */
	public Map<String , Integer> getPageNumberByProjectName(int userId, int schoolId, String projectName, String pagingType);
	
	
	/**
	 * 根据参与人数限定范围查找信息
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param partNum
	 * 参与人数限定范围
	 * @param pagingType
	 * 课题状态类型
	 * @return List<ProjectInfor>
	 * 返回一个全部需要查询信息的内容对象链表
	 */
	public List<ProjectInfor> pagingByPartNum(int pageNow, int userId, int schoolId, int partNum, String pagingType);
	
	/**
	 * 根据参与人数限定范围查找信息
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param partNum
	 * 参与人数限定范围
	 * @param pagingType
	 * 课题状态类型
	 * @return String
	 * 返回一个全部需要查询信息的内容的JSON数据类型的数据
	 */
	public String pagingByPartNumJSON(int pageNow, int userId, int schoolId, int partNum, String pagingType);
	
	/**
	 * 获取按照参与人数限定范围获取页面数目
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param partNum
	 * 参与人数限定范围
	 * @param pagingType
	 * 课题状态类型
	 * @return Map<String , Integer>
	 * 返回一个键值对的操作处理
	 */
	public Map<String , Integer> getPageNumberByPartNum(int userId, int schoolId, int partNum, String pagingType);
	
	
	/**
	 * 根据课题的难易程度查找信息
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param hardNum
	 * 课题难易程度
	 * @param pagingType
	 * 课题状态类型
	 * @return List<ProjectInfor>
	 * 返回一个全部需要查询信息的内容对象链表
	 */
	public List<ProjectInfor> pagingByHardNum(int pageNow, int userId, int schoolId, int hardNum, String pagingType);
	
	/**
	 * 根据课题的难易程度查找信息
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param hardNum
	 * 课题难易程度
	 * @param pagingType
	 * 课题状态类型
	 * @return String
	 * 返回一个全部需要查询信息的内容的JSON数据类型的数据
	 */
	public String pagingByHardNumJSON(int pageNow, int userId, int schoolId, int hardNum, String pagingType);
	
	/**
	 * 获取按照难易程度获取页面数目
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param hardNum
	 * 课题难易程度
	 * @param pagingType
	 * 课题状态类型
	 * @return Map<String , Integer>
	 * 返回一个键值对的操作处理
	 */
	public Map<String , Integer> getPageNumberByHardNum(int userId, int schoolId, int hardNum, String pagingType);
}
