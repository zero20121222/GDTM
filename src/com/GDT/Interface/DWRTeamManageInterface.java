package com.GDT.Interface;

import java.util.List;

import com.GDT.Model.Student;
import com.GDT.Model.Teacher;
import com.GDT.Model.TeamInfor;
import com.GDT.Model.TeamRelation;

/**
 * 团队管理DWR接口实现
 * @author zero
 */
public interface DWRTeamManageInterface {
	/**
	 * 通过团队人员的名称查询是否存符合要求的团队人员信息
	 * @param adderName
	 * 用户名
	 * @param schoolId
	 * 学校编号
	 * @return List<Student>
	 * 返回一个团队人员信息列表
	 */
	public List<Student> findTeamStudents(String adderName , int schoolId);
	
	/**
	 * 通过团队指导教师名称查询是否存在符合要求的指导教师信息
	 * @param adderName
	 * 用户名
	 * @param schoolId
	 * 学校编号
	 * @return List<Teacher>
	 * 返回一个指导教师信息列表
	 */
	public List<Teacher> findTeamTeacher(String adderName , int schoolId);
	
	/**
	 * 通过输入的团队信息以及团队人员信息创建一个课题团队信息
	 * @param teamInfor
	 * 团队创建信息
	 * @param teamerList
	 * 团队用户信息
	 * @return String
	 * 返回处理信息结果
	 */
	public int createTeam(TeamInfor teamInfor , List<TeamRelation> teamerList);
	
	/**
	 * 添加团队人员信息内容
	 * @param teamerList
	 * 需要添加的团队人员信息
	 * @return Boolean
	 * 返回添加结果
	 */
	public Boolean addTeamers(int userId , List<TeamRelation> teamerList);
	
	/**
	 * 通过用户编号查询用户是否已参加团队
	 * @param userId
	 * 用户编号
	 * @return Boolean
	 * 返回参加团队情况
	 */
	public Boolean ifAttendTeam(int userId);
	
	/**
	 * 通过队长编号查询团队详细信息（指团队人员之间是否已经达成合作关系）
	 * @param managerId
	 * 队长编号
	 * @return List<TeamRelation>
	 * 返回团队详细信息内容
	 */
	public List<TeamRelation> queryTeamerStatus(int managerId);
	
	/**
	 * 通过当前用户信息查询团队详细信息内容
	 * @param userId
	 * 用户编号
	 * @return List<TeamRelation>
	 * 返回团队详细信息内容
	 */
	public List<TeamRelation> queryTeamerStatusByUserId(int userId);
	
	/**
	 * 通过团队管理员编号&用户编号查询团队信息内容
	 * @param managerId
	 * 团队管理员编号
	 * @param userId
	 * 用户信息编号
	 * @return TeamRelation
	 * 返回团队关系信息
	 */
	public TeamRelation queryTeamerRelation(int managerId , int userId);
	
	/**
	 * 回复同学发送的团队请求
	 * @param relationId
	 * 团队关系编号
	 * @param answer
	 * 回复结果
	 * @param answerInfor
	 * 回复信息内容
	 * @return int
	 * 回复信息(0:已加入其他团队，-1：已达团队人数上限，1：可以加入,2:加入成功,3:加入失败)
	 */
	public int answerTeamRequest(int relationId, String answer, String answerInfor, int newId);
	
	/**
	 * 回复同学发送的团队请求(教师)
	 * @param relationId
	 * 团队关系编号
	 * @param answer
	 * 回复结果
	 * @param answerInfor
	 * 回复信息内容
	 * @return int
	 * 回复信息(0:团队已有教师，-1：教师已达指导上限，1：可以指导,2:加入成功,3:加入失败)
	 */
	public int answerTeamRequestT(int relationId, String answer, String answerInfor, int newId);
	
	/**
	 * 回复同学发送的团队请求
	 * @param newId
	 * 信息编号
	 * @return Boolean
	 * 回复信息是否保存成功
	 */
	public Boolean answerNewRequest(int newId);
	
	/**
	 * 重新提交创建团队申请操作处理
	 * @param relationId
	 * 团队关系编号
	 * @return int
	 * 返回创建操作结果(0:已加入其他团队，-1：已达团队人数上限，1：可以加入，2:提交失败)
	 */
	public int repeatCommitTeam(int relationId);
	
	/**
	 * 重新提交指导教师团队申请操作处理
	 * @param relationId
	 * 团队关系编号
	 * @return int
	 * 返回创建操作结果-1：已有指导教师，0:已达指导数目已达上限，1:提交团队请求成功，2:提交失败
	 */
	public int repeatCommitTeacher(int relationId);
	
	/**
	 * 通过关系编号查询全部团队请求信息内容
	 * @param relationId
	 * 关系编号
	 * @return List<TeamRelation>
	 * 返回团队关系信息内容
	 */
	public List<TeamRelation> queryTeamRelations(int relationId);
}
