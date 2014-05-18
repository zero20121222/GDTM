package com.GDT.Interface;

import java.util.List;
import java.util.Map;

import com.GDT.Model.ProjectInfor;

/**
 * 课题对象分页操作的接口对象
 * @author zero
 */
public interface DWRProjectPagingInterface {
	/**
	 * 根据创建者编号查找信息
	 * @param pageNow
	 * 需要跳转到的页面
	 * @param creatId
	 * 根据课题创建人编号查询数据
	 * @param pagingType
	 * 课题状态类型
	 * @return List<ProjectInfor>
	 * 返回一个全部需要查询信息的内容对象链表
	 */
	public List<ProjectInfor> pagingByCreateId(int pageNow, int createrId, String pagingType, int graduateYear);
	
	/**
	 * 根据创建者编号查找信息
	 * @param creatId
	 * 根据课题创建人编号查询数据
	 * @param pagingType
	 * 课题状态类型
	 * @return String
	 * 返回一个全部需要查询信息的内容的JSON数据类型的数据
	 */
	public String pagingByCreatIdJSON(int pageNow, int createrId, String pagingType, int graduateYear);
	
	/**
	 * 根据创建者编号获取页面数目
	 * @param creatId
	 * 根据课题创建人编号查询数据
	 * @param pagingType
	 * 课题状态类型(null:显示全部数据除了已删除的课题信息)
	 * @return Map<String , Integer>
	 * 返回一个键值对的操作处理
	 */
	public Map<String , Integer> getPageNumberByCreateId(int createrId, String pagingType, int graduateYear);
	
	
	
	/**
	 * 根据学校编号查找信息
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param pagingType
	 * 课题状态类型
	 * @return List<ProjectInfor>
	 * 返回一个全部需要查询信息的内容对象链表
	 */
	public List<ProjectInfor> pagingBySchoolId(int pageNow, int schoolId, String pagingType, int graduateYear);
	
	/**
	 * 根据学校编号查找信息
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param pagingType
	 * 课题状态类型
	 * @return String
	 * 返回一个全部需要查询信息的内容的JSON数据类型的数据
	 */
	public String pagingBySchoolIdJSON(int pageNow, int schoolId, String pagingType, int graduateYear);
	
	/**
	 * 获取按照学校编号获取页面数目
	 * @param schoolId
	 * 根据学校编号为基准索引课题信息
	 * @param pagingType
	 * 课题状态类型
	 * @return Map<String , Integer>
	 * 返回一个键值对的操作处理
	 */
	public Map<String , Integer> getPageNumberBySchoolId(int schoolId, String pagingType, int graduateYear);
	
	
	
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
	public List<ProjectInfor> pagingByCreateName(int pageNow, int schoolId, String createrName, String pagingType, int graduateYear);
	
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
	public String pagingByCreateNameJSON(int pageNow, int schoolId, String createrName, String pagingType, int graduateYear);
	
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
	public Map<String , Integer> getPageNumberByCreateName(int schoolId, String createrName, String pagingType, int graduateYear);
	
	
	
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
	public List<ProjectInfor> pagingByCollege(int pageNow, int schoolId, String collegeName, String pagingType, int graduateYear);
	
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
	public String pagingByCollegeJSON(int pageNow, int schoolId, String collegeName, String pagingType, int graduateYear);
	
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
	public Map<String , Integer> getPageNumberByCollege(int schoolId, String collegeName, String pagingType, int graduateYear);
	
	
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
	public List<ProjectInfor> pagingByProjectName(int pageNow, int schoolId, String projectName, String pagingType, int graduateYear);
	
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
	public String pagingByProjectNameJSON(int pageNow, int schoolId, String projectName, String pagingType, int graduateYear);
	
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
	public Map<String , Integer> getPageNumberByProjectName(int schoolId, String projectName, String pagingType, int graduateYear);
	
	
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
	public List<ProjectInfor> pagingByPartNum(int pageNow, int schoolId, int partNum, String pagingType, int graduateYear);
	
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
	public String pagingByPartNumJSON(int pageNow, int schoolId, int partNum, String pagingType, int graduateYear);
	
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
	public Map<String , Integer> getPageNumberByPartNum(int schoolId, int partNum, String pagingType, int graduateYear);
	
	
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
	public List<ProjectInfor> pagingByHardNum(int pageNow, int schoolId, int hardNum, String pagingType, int graduateYear);
	
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
	public String pagingByHardNumJSON(int pageNow, int schoolId, int hardNum, String pagingType, int graduateYear);
	
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
	public Map<String , Integer> getPageNumberByHardNum(int schoolId, int hardNum, String pagingType, int graduateYear);
}
