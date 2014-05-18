package com.GDT.Interface;

import java.util.List;

import com.GDT.Model.ProjectInfor;
import com.GDT.Model.ProjectStageGuide;
import com.GDT.Model.Student;
import com.GDT.Model.Teacher;
import com.GDT.Model.TeamInfor;
import com.GDT.Model.TeamRelation;

/**
 * 学生用户类接口
 * @author zero
 */
public interface StudentInterface{
	////////////////////////////////////////		学生用户基本处理功能函数			/////////////////////////////////////////
	/**
	 * 保存学生用户的基本信息当开始登入时
	 * @param student
	 * 学生用户对象的详细信息
	 * @return Boolean
	 * 返回学生信息是否保存成功
	 */
	public Boolean saveStudentInfor(Student student);
	
	/**
	 * 查询是否允许更改学生详细信息
	 * @param schoolId
	 * 学校编号
	 * @return Boolean
	 * 返回是否允许更改学生信息
	 */
	public Boolean ifAllowUpdate(int schoolId);
	
	/**
	 * 用户信息更改
	 * @param student
	 * 用户的更改信息
	 * @return Boolean
	 * 返回数据用户信息更改是否成功 true:成功,false:失败
	 */
	public Boolean doAlter(Student student);
	
	/**
	 * 查询用户信息
	 * @param id
	 * 作为查询用户的编号输入信息
	 * @return Student
	 * 返回学生用户的详细信息
	 */
	public Student doSelect(int id);
	
	////////////////////////////////////////		学生用户对于团队的操作处理接口设计			///////////////////////////////////////////////////
	/**
	 * 创建团队
	 * @param team
	 * 这个是用于保存需要创建的团队详细信息
	 * @param teamerList
	 * 团队人员关系信息
	 * @return Boolean
	 * 返回团队创建是否成功(true:成功,false:失败)
	 */
	public int createTeam(TeamInfor team , List<TeamRelation> teamerList);
	
	/**
	 * 添加团队人员信息内容
	 * @param teamId
	 * 团队编号
	 * @param teamerList
	 * 需要添加的团队人员信息
	 * @return Boolean
	 * 返回添加结果
	 */
	public Boolean addTeamers(int teamId , List<TeamRelation> teamerList);
	
	/**
	 * 创建团队信息内容
	 * @param teamInfor
	 * 团队信息内容
	 * @return int
	 * 返回团队编号
	 */
	public int createTeamInfor(TeamInfor teamInfor);
	
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
	 * 查询请求学生对象是否存在
	 * @param name
	 * 学生用户名称
	 * @param schoolId
	 * 学校编号
	 * @return int
	 * 返回如果用户存在返回用户编号（否则返回-1）
	 */
	public int ifExistStudent(String name ,int schoolId);
	
	/**
	 * 查询是还能参加其他团队
	 * @param userId
	 * 用户的id编号
	 * @return Boolean
	 * 判断用户是否已经参加团队(true:已参加 , false:未参加)
	 */
	public Boolean ifAttendTeam(int userId);
	
	/**
	 * 通过用户编号查询用户是否参加其他团队以及是否是队长权限
	 * @param userId
	 * 用户编号
	 * @return int
	 * 返回团队类型(-1:还未参加团队,0:队长,1:队员)
	 */
	public int queryTeamerType(int userId);
	
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
	 * 查询全部可以作为团队指导教师的全部教师名称
	 * @param schoolId
	 * 学校编号
	 * @param college
	 * 学院编号(这个是由课题限定的可以是null)
	 * @return String
	 * 返回一个以JSON格式表示的全部教师名称&教师用户名编号数据
	 */
	public String queryGuideTheacer(int schoolId , String college);
	
	/**
	 * 对学生用户发送创建团队的请求
	 * @param fromId
	 * 发送信息人员的Id编号
	 * @param toId
	 * 接收信息人员的Id编号
	 * @return Boolean
	 * 返回请求信息是否发送成功
	 */
	public Boolean sendTeamRequestS(int fromId, int toId);
	
	/**
	 * 对教师用户发送创建团队的请求
	 * @param fromId
	 * 发送信息人员的Id编号
	 * @param toId
	 * 接收信息人员的Id编号
	 * @return Boolean
	 * 返回请求信息是否发送成功
	 */
	public Boolean sendTeamRequestT(int fromId, int toId);
	
	/**
	 * 回复同学发送的团队请求
	 * @param relationId
	 * 团队关系编号
	 * @param answer
	 * 回复结果
	 * @param answerInfor
	 * 回复信息内容
	 * @param newId
	 * 请求信息编号
	 * @return Boolean
	 * 回复信息是否保存成功
	 */
	public Boolean answerTeamRequest(int relationId, String answer, String answerInfor, int newId);
	
	/**
	 * 回复同学发送的团队请求
	 * @param newId
	 * 信息编号
	 * @return Boolean
	 * 回复信息是否保存成功
	 */
	public Boolean answerNewRequest(int newId);
	
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
	 * 查询团队的指导教师的用户信息
	 * @param teamId
	 * 团队编号用户检索团队信息
	 * @return Teacher
	 * 返回一个教师的详细信息对象
	 */
	public Teacher queryTeamTeacherInfor(int teamId);
	
	/**
	 * 通过用户编号查询该用户团队所选的课题信息内容
	 * @param userId
	 * 用户编号
	 * @return ProjectInfor
	 * 返回课题详细信息内容
	 */
	public ProjectInfor queryProjectByTeamerId(int userId);
	
	/**
	 * 通过用户编号查询团队学生信息内容
	 * @param userId
	 * 用户编号
	 * @return List<Student>
	 * 团队学生信息内容
	 */
	public List<Student> queryTeamerStus(int userId);
	
	/**
	 * 通过管理员编号查询团队人员详细信息
	 * @param managerId
	 * 管理员编号
	 * @return List<Student>
	 * 返回学生详细信息内容
	 */
	public List<Student> queryAllTeamerStus(int managerId);
	
	/**
	 * 通过用户编号查询团队的指导教师信息内容
	 * @param userId
	 * 用户编号
	 * @return Teacher
	 * 指导教师信息内容
	 */
	public Teacher queryTeamerTea(int userId);
	
	/**
	 * 通过用户编号获取团队编号
	 * @param userId
	 * 用户编号
	 * @return int
	 * 返回团队编号
	 */
	public int queryTeamId(int userId);
	
	/**
	 * 通过管理员编号查询教师详细信息
	 * @param managerId
	 * 管理员编号
	 * @return List<Teacher>
	 * 返回请求教师详细信息内容
	 */
	public List<Teacher> queryAllTeamerTea(int managerId);
	
	/**
	 * 通过关系编号查询学生详细信息
	 * @param relationId
	 * 关系编号
	 * @return Student
	 * 返回学生信息
	 */
	public Student queryStuByRelation(int relationId);
	
	/**
	 * 通过关系编号查询教师详细信息
	 * @param relationId
	 * 关系编号
	 * @return Teacher
	 * 返回教师信息
	 */
	public Teacher queryTeaByRelation(int relationId);
	
	/**
	 * 通过关系编号查询队员的关系操作
	 * @param relationId
	 * 关系编号
	 * @return TeamRelation
	 * 团队关系信息
	 */
	public TeamRelation queryTeamRelation(int relationId);
	
	/**
	 * 通过团队关系编号查询是否还可以在添加用户
	 * @param relationId
	 * 关系编号
	 * @return Boolean
	 * 返回是否还可以在添加用户(0:已加入其他团队，-1：已达团队人数上限，1：可以加入)
	 */
	public int ifrepeatTeamer(int relationId);
	
	/**
	 * 通过团队编号查询是否还可以再次提交团队请求
	 * @param relationId
	 * 关系编号
	 * @return Boolean
	 * 返回添加是否成功
	 */
	public Boolean repeatTeamer(int relationId);
	
	/**
	 * 通过团队关系编号查询该教师是否还可以提交申请
	 * @param relationId
	 * 关系编号
	 * @return int
	 * 返回是否还可以在添加用户(0:团队已有教师，-1：教师已达指导上限，1：可以指导)
	 */
	public int ifRepeatTeacher(int relationId);
	
	/**
	 * 通过关系编号查询全部团队请求信息内容
	 * @param relationId
	 * 关系编号
	 * @return List<TeamRelation>
	 * 返回团队关系信息内容
	 */
	public List<TeamRelation> queryTeamRelations(int relationId);
	
	////////////////////////////////////			学生对于团队的阶段管理的操作接口设计				////////////////////////////////////
	/**
	 * 开始阶段管理模式（及开始课题阶段管理模式时间统计）
	 * @param teamId
	 * 团队编号
	 * @param stageId
	 * 需要开始统计的阶段编号
	 * @return Boolean
	 * 阶段管理模式是否开启
	 */
	public Boolean createTeamStageManager(int teamId , int stageId);
	
	/**
	 * 发送一个课题阶段请求信息给教师
	 * @param stagerequest
	 * 阶段请求信息
	 * @return Boolean
	 * 返回阶段请求发送是否成功
	 */
	public Boolean sendStageRequest(ProjectStageGuide stagerequest);
}
