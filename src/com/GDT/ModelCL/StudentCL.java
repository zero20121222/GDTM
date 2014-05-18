package com.GDT.ModelCL;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.GDT.Interface.StudentInterface;
import com.GDT.Model.CommonSchoolUser;
import com.GDT.Model.ProjectInfor;
import com.GDT.Model.ProjectStageGuide;
import com.GDT.Model.Student;
import com.GDT.Model.Teacher;
import com.GDT.Model.TeamInfor;
import com.GDT.Model.TeamRelation;
import com.GDT.util.DBConnection;
import com.GDT.util.DBConnectionInterface;
import com.GDT.util.GDTDate;


/**
 * 学生用户对象处理类
 * @author 
 */
public class StudentCL extends CommonSUserCL implements StudentInterface {
	private DBConnectionInterface connectObj = null;
	private PreparedStatement sta = null;
	private ResultSet res = null;
	
	public Boolean answerTeamRequest(int relationId, String answer, String answerInfor, int newId) {
		Boolean result = false;
		
		try{
			String sql = "update 团队人员关系 set 回复=?,回复信息=?,回复时间=? where Id=?";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setString(1, answer);
			this.sta.setString(2, answerInfor);
			this.sta.setDate(3, GDTDate.getSqlDate());
			this.sta.setInt(4, relationId);
			
			//同时更改回复信息状态为回复成功
			if(this.sta.executeUpdate() == 1){
				sql = "update 学生教师最新消息处理 set 信息状态='D' where id=?";
				this.sta = this.connectObj.getStatement(sql);
				this.sta.setInt(1, newId);
				
				result = this.sta.executeUpdate() == 1 ? true : false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}
	
	public Boolean answerNewRequest(int newId){
		Boolean result = false;
		
		try{
			String sql = "update 学生教师最新消息处理 set 信息状态='D' where id=?";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, newId);
			
			result = this.sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}
	
	public TeamRelation queryTeamerRelation(int managerId , int userId){
		TeamRelation relation = null;
		
		try{
			String sql = "select CASE "
						+"when `队员类型`='s' THEN (select 真实姓名 from `学生详细信息` where 学生详细信息.Id=队员编号) "
						+"when `队员类型`='T' THEN (select 真实姓名 from `教师详细信息` where 教师详细信息.Id=队员编号) "
						+"end as teamerName,队员类型,队员编号,回复,回复信息,回复时间,团队人员关系.Id "
						+"from `团队人员关系`,`团队信息` where 团队信息.Id=团队编号 and 回复='W' and `队长编号`=? and 队员编号=?;";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, managerId);
			this.sta.setInt(2, userId);
			
			this.res = this.connectObj.getQueryResultSet();
			if(this.res.next()){
				relation = new TeamRelation();
				
				relation.setTeamerName(this.res.getString(1));
				relation.setTeamerType(this.res.getString(2));
				relation.setTeamId(this.res.getInt(3));
				relation.setAnswer(this.res.getString(4));
				relation.setAnswerInfor(this.res.getString(5));
				relation.setAnswerTime(this.res.getDate(6));
				relation.setId(this.res.getInt(7));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return relation;
	}

	public int createTeam(TeamInfor teamInfor , List<TeamRelation> teamerList) {
		int createStyle = 0;
		
		int teamId = this.createTeamInfor(teamInfor);
		if(teamId != 0){//表示课题创建成功（之后添加团队人员）
			try{
				this.connectObj = new DBConnection();
				this.connectObj.getConnection();
				
				//开启处理事务
				this.connectObj.beginTransaction();
				
				//创建团队信息
				String sql = "insert into 团队人员关系(团队编号,队员类型,队员编号) values(?,?,?);";
				
				this.sta = this.connectObj.getStatement(sql);
				for(TeamRelation relation : teamerList){
					this.sta.setInt(1, teamId);
					this.sta.setString(2, relation.getTeamerType());
					this.sta.setInt(3, relation.getTeamerId());
					
					this.sta.addBatch();
				}
				
				//执行批量处理(1：表示人员添加成功,2:表示人员添加失败)
				createStyle = this.sta.executeBatch().length > 0 ? 1 : 2;
				this.connectObj.commitTransaction();
			}catch(Exception e){
				this.connectObj.rollBackTransaction();//当有异常时回滚数据
				e.printStackTrace();
			}finally{
				this.connectObj.close();
			}
		}
		
		return createStyle;
	}
	
	public Boolean addTeamers(int teamId , List<TeamRelation> teamerList){
		Boolean createStyle = false;
		
		try{
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			//开启处理事务
			this.connectObj.beginTransaction();
			
			//创建团队信息
			String sql = "insert into 团队人员关系(团队编号,队员类型,队员编号) values(?,?,?);";
			
			this.sta = this.connectObj.getStatement(sql);
			for(TeamRelation relation : teamerList){
				this.sta.setInt(1, teamId);
				this.sta.setString(2, relation.getTeamerType());
				this.sta.setInt(3, relation.getTeamerId());
				
				this.sta.addBatch();
			}
			
			createStyle = this.sta.executeBatch().length > 0;
			this.connectObj.commitTransaction();
		}catch(Exception e){
			this.connectObj.rollBackTransaction();//当有异常时回滚数据
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return createStyle;
	}
	
	//这里为了不产生同时操作一个课题情况使用单例时的存储过程
	public int createTeamInfor(TeamInfor teamInfor){
		int teamNum = 0;
		
		try{
			String sql = "{call create_teamInfor(?,?,?)}";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			//使用存储结构处理事务
			CallableStatement callState = this.connectObj.getCallableStatement(sql);
			callState.setInt(1, teamInfor.getManagerId());
			callState.setInt(2, teamInfor.getProjectId());
			callState.registerOutParameter(3, Types.INTEGER);
			
			callState.execute();

			teamNum = callState.getInt(3);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return teamNum;
	}

	public Boolean createTeamStageManager(int teamId, int stageId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean doAlter(Student student) {
		Boolean update = false;
		String sql = "update 学生详细信息 set 年龄=?,性别=?,身份证号码=?,地址=?,手机=?,email=?,qq=?,个人简介=? where id=?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setString(1, student.getAge());
			sta.setString(2, student.getSex());
			sta.setString(3, student.getIdCard());
			sta.setString(4, student.getAddress());
			sta.setString(5, student.getPhone());
			sta.setString(6, student.getEmail());
			sta.setString(7, student.getQq());
			sta.setString(8, student.getResume());
			sta.setInt(9, student.getId());
			
			update = sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return update;
	}
	
	/**
	 * 查询学生的详细信息
	 * @see com.GDT.Interface.StudentInterface#doSelect(int)
	 * @author zero
	 */
	public Student doSelect(int id) {
		Student student = null;
		
		try{
			String sql = "select 真实姓名,院系类别,专业类别,年龄,性别,身份证号码,地址,手机,email,qq,个人简介 from 学生详细信息 where Id=?;";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, id);
			
			this.res = this.connectObj.getQueryResultSet();
			if(this.res.next()){
				student = new Student();
				
				student.setRealName(res.getString(1));
				student.setCollege(res.getString(2));
				student.setMajor(res.getString(3));
				student.setAge(res.getString(4));
				student.setSex(res.getString(5));
				student.setIdCard(res.getString(6));
				student.setAddress(res.getString(7));
				student.setPhone(res.getString(8));
				student.setEmail(res.getString(9));
				student.setQq(res.getString(10));
				student.setResume(res.getString(11));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return student;
	}

	public Boolean ifAllowUpdate(int schoolId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean ifAttendTeam(int userId) {
		Boolean result = false;
		
		try{
			String sql = "select 团队编号 from 学生详细信息 where Id=?;";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, userId);
			
			this.res = this.connectObj.getQueryResultSet();
			result = this.res.next() ? (this.res.getInt(1)==0 ? false : true) : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}
	
	public int queryTeamerType(int userId){
		int result = 0;
		
		try{
			String sql = "select CASE when (select 团队信息.Id from `团队信息` where 队长编号=学生详细信息.id) is not null THEN 0 "
						+"when 团队编号 != 0 THEN 1 ELSE -1 END as teamerType from 学生详细信息 where Id=?";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, userId);
			
			this.res = this.connectObj.getQueryResultSet();
			if(this.res.next()){
				result = this.res.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}
	
	public List<TeamRelation> queryTeamerStatus(int managerId){
		List<TeamRelation> teamerList = new ArrayList<TeamRelation>();
		
		try{
			String sql = "select * from(select CASE "
						+"when `队员类型`='s' THEN (select 真实姓名 from `学生详细信息` where 学生详细信息.Id=队员编号) "
						+"when `队员类型`='T' THEN (select 真实姓名 from `教师详细信息` where 教师详细信息.Id=队员编号) "
						+"end as teamerName,队员类型,队员编号,回复,回复信息,回复时间,团队人员关系.团队编号 "
						+"from `团队人员关系`,`团队信息` where 团队信息.Id=团队编号 and `队长编号`=? order by 团队人员关系.id desc) as teamersInformation "
						+"GROUP BY 团队编号,队员编号 ORDER BY 队员类型 desc;";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, managerId);
			
			this.res = this.connectObj.getQueryResultSet();
			TeamRelation relation = null;
			while(this.res.next()){
				relation = new TeamRelation();
				
				relation.setTeamerName(this.res.getString(1));
				relation.setTeamerType(this.res.getString(2));
				relation.setTeamId(this.res.getInt(3));
				relation.setAnswer(this.res.getString(4));
				relation.setAnswerInfor(this.res.getString(5));
				relation.setAnswerTime(this.res.getDate(6));
				teamerList.add(relation);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return teamerList;
	}

	public List<TeamRelation> queryTeamerStatusByUserId(int userId){
		List<TeamRelation> teamerList = new ArrayList<TeamRelation>();
		
		try{
			String sql = "select * from(select CASE "
						+"when 队员类型='s' THEN (select 真实姓名 from 学生详细信息 where 学生详细信息.Id=队员编号) " 
						+"when 队员类型='T' THEN (select 真实姓名 from 教师详细信息 where 教师详细信息.Id=队员编号) "
						+"end as teamerName,队员类型,队员编号,回复,回复信息,回复时间,团队人员关系.团队编号 "
						+"FROM 团队人员关系,学生详细信息 where 学生详细信息.团队编号=团队人员关系.团队编号 and 学生详细信息.Id=? order by 团队人员关系.id desc) as teamersInfor "
						+"GROUP BY 团队编号,队员编号 ORDER BY 队员类型 desc;";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, userId);
			
			this.res = this.connectObj.getQueryResultSet();
			TeamRelation relation = null;
			while(this.res.next()){
				relation = new TeamRelation();
				
				relation.setTeamerName(this.res.getString(1));
				relation.setTeamerType(this.res.getString(2));
				relation.setTeamId(this.res.getInt(3));
				relation.setAnswer(this.res.getString(4));
				relation.setAnswerInfor(this.res.getString(5));
				relation.setAnswerTime(this.res.getDate(6));
				teamerList.add(relation);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return teamerList;
	}
	
	public int ifExistStudent(String name, int schoolId) {
		// TODO Auto-generated method stub
		return 0;
	}

	public String queryGuideTheacer(int schoolId, String college) {
		// TODO Auto-generated method stub
		return null;
	}

	public Teacher queryTeamTeacherInfor(int teamId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean sendStageRequest(ProjectStageGuide stagerequest) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean sendTeamRequestS(int fromId, int toId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean sendTeamRequestT(int fromId, int toId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * @see com.GDT.Interface.StudentInterface#saveStudentInfor(com.GDT.Model.Student)
	 * 当用户第一次登入时会跳出学生用户详细信息输入页面输入详细信息
	 * @author zero
	 */
	public Boolean saveStudentInfor(Student student) {
		Boolean save = false;
		String sql = "insert into 学生详细信息(Id,真实姓名,院系类别,专业类别,年龄,性别,身份证号码,地址,手机,email,qq,个人简介,信息是否已填写) value(?,?,?,?,?,?,?,?,?,?,?,?,?);";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, student.getId());
			sta.setString(2, student.getRealName());
			sta.setString(3, student.getCollege());
			sta.setString(4, student.getMajor());
			sta.setString(5, student.getAge());
			sta.setString(6, student.getSex());
			sta.setString(7, student.getIdCard());
			sta.setString(8, student.getAddress());
			sta.setString(9, student.getPhone());
			sta.setString(10, student.getEmail());
			sta.setString(11, student.getQq());
			sta.setString(12, student.getResume());
			sta.setString(13, "T");
			
			int result = sta.executeUpdate();
			save = result == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return save;
	}

	public List<Student> findTeamStudents(String adderName, int schoolId) {
		List<Student> teamerList = new ArrayList<Student>();
		
		try{
			String sql = "select 学生详细信息.Id,真实姓名,院系类别,专业类别,年龄,性别,身份证号码,地址,手机,email,qq,个人简介,团队编号,用户名 from 学生详细信息,学生教师账号 "
						+"where 学生教师账号.Id=学生详细信息.Id and 学校Id=? and 真实姓名 like '%"+adderName+"%' limit 6;";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, schoolId);

			Student student = null;
			this.res = this.connectObj.getQueryResultSet();
			while(this.res.next()){
				student = new Student();
				
				student.setId(res.getInt(1));
				student.setRealName(res.getString(2));
				student.setCollege(res.getString(3));
				student.setMajor(res.getString(4));
				student.setAge(res.getString(5));
				student.setSex(res.getString(6));
				student.setIdCard(res.getString(7));
				student.setAddress(res.getString(8));
				student.setPhone(res.getString(9));
				student.setEmail(res.getString(10));
				student.setQq(res.getString(11));
				student.setResume(res.getString(12));
				student.setTeamId(res.getInt(13));
				student.setUserName(res.getString(14));	//这个对于学生和教师而言是编号（学号&教师编号）
				teamerList.add(student);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return teamerList;
	}

	public List<Teacher> findTeamTeacher(String adderName, int schoolId) {
		List<Teacher> teacherList = new ArrayList<Teacher>();
		
		try{
			//默认只显示6个数据
			String sql = "select 教师详细信息.Id,真实姓名,院系类别,职位,学位,办公室,年龄,性别,身份证号码,地址,手机,email,qq,个人简介,已指导团队数目<指导团队上限 as auditRes,用户名 "
						+"from 教师详细信息,学生教师账号,学校界面的系统参数设置 where 学生教师账号.Id=教师详细信息.Id and 学校界面的系统参数设置.学校Id=学生教师账号.学校Id " 
						+"and 学生教师账号.学校Id=? and 真实姓名 like '%"+adderName+"%' limit 6;";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			this.sta = connectObj.getStatement(sql);
			this.sta.setInt(1, schoolId);
			
			this.res = connectObj.getQueryResultSet();
			Teacher teacher = null;
			if(res.next()){
				teacher = new Teacher();
				
				teacher.setId(res.getInt(1));
				teacher.setRealName(res.getString(2));
				teacher.setCollege(res.getString(3));
				teacher.setPosition(res.getString(4));
				teacher.setDegree(res.getString(5));
				teacher.setOffice(res.getString(6));
				teacher.setAge(res.getString(7));
				teacher.setSex(res.getString(8));
				teacher.setIdCard(res.getString(9));
				teacher.setAddress(res.getString(10));
				teacher.setPhone(res.getString(11));
				teacher.setEmail(res.getString(12));
				teacher.setQq(res.getString(13));
				teacher.setResume(res.getString(14));
				teacher.setAduitNumber(res.getInt(15));	//用于判断教师是否还可以再指导团队（1:还可以,2:不能）
				teacher.setUserName(res.getString(16));
				
				teacherList.add(teacher);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return teacherList;
	}
	
	public ProjectInfor queryProjectByTeamerId(int userId){
		ProjectInfor project = null;
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,教师详细信息.真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,课题目的,主要内容,图片信息,课题文件下载,创建时间,课题被选择次数,题目状态 "
					+"from 毕业课题详细信息,教师详细信息,学生详细信息,团队信息 where 教师详细信息.Id = 出题人Id and 学生详细信息.团队编号=团队信息.Id "
					+"and 团队信息.题目编号=毕业课题详细信息.Id and 学生详细信息.Id = ?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, userId);
			
			res = connectObj.getQueryResultSet();
			if(res.next()){
				project = new ProjectInfor();
				
				project.setId(res.getInt(1));
				project.setSchoolId(res.getInt(2));
				project.setProjectName(res.getString(3));
				project.setCreaterId(res.getInt(4));
				project.setCreaterName(res.getString(5));
				project.setPartNum(res.getInt(6));
				project.setWorkload(res.getString(7));
				project.setCollege(res.getString(8));
				project.setHardNum(res.getInt(9));
				project.setPurpose(res.getString(10));
				project.setMainContent(res.getString(11));
				project.setPicture(res.getString(12));
				project.setProjectFile(res.getString(13));
				project.setCreateDate(res.getDate(14));
				project.setSelectNum(res.getInt(15));
				project.setStage(res.getString(16));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return project;
	}
	
	public List<Student> queryTeamerStus(int userId){
		List<Student> teamerList = new ArrayList<Student>();
		
		try{
			String sql = "select 学生详细信息.Id,用户名,头像,真实姓名,院系类别,专业类别,年龄,性别,身份证号码,地址,手机,email,qq,个人简介 "
						+"from 学生详细信息 LEFT JOIN 团队信息 on 学生详细信息.Id = 队长编号,学生教师账号 "
						+"where 学生教师账号.Id=学生详细信息.Id and 学生详细信息.团队编号=(select `团队编号` from 学生详细信息 where id=?) ORDER BY 队长编号 desc;";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, userId);

			Student student = null;
			this.res = this.connectObj.getQueryResultSet();
			while(this.res.next()){
				student = new Student();
				CommonSchoolUser commonUser = new CommonSchoolUser();//普通对象用户信息内容
				commonUser.setUserName(res.getString(2));
				commonUser.setUserHead(res.getString(3));
				
				student.setId(res.getInt(1));
				student.setRealName(res.getString(4));
				student.setCollege(res.getString(5));
				student.setMajor(res.getString(6));
				student.setAge(res.getString(7));
				student.setSex(res.getString(8));
				student.setIdCard(res.getString(9));
				student.setAddress(res.getString(10));
				student.setPhone(res.getString(11));
				student.setEmail(res.getString(12));
				student.setQq(res.getString(13));
				student.setResume(res.getString(14));
				student.setCommonUser(commonUser);
				teamerList.add(student);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return teamerList;
	}
	
	public Teacher queryTeamerTea(int userId){
		Teacher teacher = null;
		
		try{
			String sql = "select 教师详细信息.Id,用户名,头像,真实姓名,院系类别,职位,学位,办公室,年龄,性别,身份证号码,地址,手机,email,qq,个人简介 from 教师详细信息,学生教师账号 "
						+"where 学生教师账号.Id=教师详细信息.Id and 教师详细信息.Id=(select 队员编号 from 学生详细信息,团队人员关系 where 学生详细信息.团队编号=团队人员关系.团队编号 and 队员类型='T' and 回复='T' and 学生详细信息.id=?);";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, userId);
			
			this.res = this.connectObj.getQueryResultSet();
			if(this.res.next()){
				teacher = new Teacher();
				CommonSchoolUser commonUser = new CommonSchoolUser();//普通对象用户信息内容
				commonUser.setUserName(res.getString(2));
				commonUser.setUserHead(res.getString(3));
				
				teacher.setId(res.getInt(1));
				teacher.setRealName(res.getString(4));
				teacher.setCollege(res.getString(5));
				teacher.setPosition(res.getString(6));
				teacher.setDegree(res.getString(7));
				teacher.setOffice(res.getString(8));
				teacher.setAge(res.getString(9));
				teacher.setSex(res.getString(10));
				teacher.setIdCard(res.getString(11));
				teacher.setAddress(res.getString(12));
				teacher.setPhone(res.getString(13));
				teacher.setEmail(res.getString(14));
				teacher.setQq(res.getString(15));
				teacher.setResume(res.getString(16));
				teacher.setCommonUser(commonUser);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return teacher;
	}

	public List<Student> queryAllTeamerStus(int managerId) {
		List<Student> teamerList = new ArrayList<Student>();
		
		try{
			String sql = "select * from (select 学生详细信息.Id,用户名,头像,真实姓名,院系类别,专业类别,性别,团队人员关系.id as relactionId,回复,团队人员关系.团队编号 "
						+"from 学生详细信息,学生教师账号,团队人员关系 where 学生教师账号.Id=学生详细信息.Id and 团队人员关系.队员编号=学生详细信息.Id "
						+"and 团队人员关系.团队编号=(select id from `团队信息` where 队长编号=?) ORDER BY 团队人员关系.id desc) as onlyTeamerInfor GROUP BY 团队编号,id";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, managerId);

			Student student = null;
			this.res = this.connectObj.getQueryResultSet();
			while(this.res.next()){
				student = new Student();
				CommonSchoolUser commonUser = new CommonSchoolUser();//普通对象用户信息内容
				commonUser.setUserName(res.getString(2));
				commonUser.setUserHead(res.getString(3));
				
				student.setId(res.getInt(1));
				student.setRealName(res.getString(4));
				student.setCollege(res.getString(5));
				student.setMajor(res.getString(6));
				student.setSex(res.getString(7));
				student.setRelationId(res.getInt(8));
				student.setReplyResult(res.getString(9));
				
				student.setCommonUser(commonUser);
				teamerList.add(student);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return teamerList;
	}

	public List<Teacher> queryAllTeamerTea(int managerId) {
		List<Teacher> teaList = new ArrayList<Teacher>();
		
		try{
			String sql = "select * from(select 教师详细信息.Id,用户名,头像,真实姓名,院系类别,职位,性别,团队人员关系.id as relactionId,回复,团队编号 from 教师详细信息,学生教师账号,团队人员关系 "
						+"where 学生教师账号.Id=教师详细信息.Id and 团队人员关系.队员编号=教师详细信息.Id "
						+"and 团队人员关系.团队编号=(select id from `团队信息` where 队长编号=?) ORDER BY 团队人员关系.id desc) as onlyTeacherInfor GROUP BY 团队编号,id;";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, managerId);
			
			this.res = this.connectObj.getQueryResultSet();
			Teacher teacher = null;
			if(this.res.next()){
				teacher = new Teacher();
				CommonSchoolUser commonUser = new CommonSchoolUser();//普通对象用户信息内容
				commonUser.setUserName(res.getString(2));
				commonUser.setUserHead(res.getString(3));
				
				teacher.setId(res.getInt(1));
				teacher.setRealName(res.getString(4));
				teacher.setCollege(res.getString(5));
				teacher.setPosition(res.getString(6));
				teacher.setSex(res.getString(7));
				teacher.setRelationId(res.getInt(8));
				teacher.setReplyResult(res.getString(9));
				teacher.setCommonUser(commonUser);
				
				teaList.add(teacher);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return teaList;
	}

	public Student queryStuByRelation(int relationId) {
		Student student = null;
		
		try{
			String sql = "select 真实姓名,院系类别,专业类别,年龄,性别,身份证号码,地址,手机,email,qq,个人简介 from 学生详细信息,团队人员关系 where 学生详细信息.id=团队人员关系.队员编号 and 团队人员关系.Id=?;";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, relationId);
			
			this.res = this.connectObj.getQueryResultSet();
			if(this.res.next()){
				student = new Student();
				
				student.setRealName(res.getString(1));
				student.setCollege(res.getString(2));
				student.setMajor(res.getString(3));
				student.setAge(res.getString(4));
				student.setSex(res.getString(5));
				student.setIdCard(res.getString(6));
				student.setAddress(res.getString(7));
				student.setPhone(res.getString(8));
				student.setEmail(res.getString(9));
				student.setQq(res.getString(10));
				student.setResume(res.getString(11));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return student;
	}

	public Teacher queryTeaByRelation(int relationId) {
		Teacher teacher = null;
		String sql = "select 真实姓名,院系类别,职位,学位,办公室,年龄,性别,身份证号码,地址,手机,email,qq,个人简介 from 教师详细信息,团队人员关系 where 教师详细信息.id=团队人员关系.队员编号 and 团队人员关系.Id=?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			sta.setInt(1, relationId);
			
			res = connectObj.getQueryResultSet();
			if(res.next()){
				teacher = new Teacher();
				
				teacher.setRealName(res.getString(1));
				teacher.setCollege(res.getString(2));
				teacher.setPosition(res.getString(3));
				teacher.setDegree(res.getString(4));
				teacher.setOffice(res.getString(5));
				teacher.setAge(res.getString(6));
				teacher.setSex(res.getString(7));
				teacher.setIdCard(res.getString(8));
				teacher.setAddress(res.getString(9));
				teacher.setPhone(res.getString(10));
				teacher.setEmail(res.getString(11));
				teacher.setQq(res.getString(12));
				teacher.setResume(res.getString(13));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return teacher;
	}
	
	public TeamRelation queryTeamRelation(int relationId){
		TeamRelation relation = null;
		
		try{
			String sql = "select CASE "
						+"when `队员类型`='S' THEN (select 真实姓名 from `学生详细信息` where 学生详细信息.Id=队员编号) "
						+"when `队员类型`='T' THEN (select 真实姓名 from `教师详细信息` where 教师详细信息.Id=队员编号) "
						+"end as teamerName,队员类型,队员编号,回复,回复信息,回复时间,Id from 团队人员关系 where id=?;";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, relationId);
			
			this.res = this.connectObj.getQueryResultSet();
			if(this.res.next()){
				relation = new TeamRelation();
				
				relation.setTeamerName(this.res.getString(1));
				relation.setTeamerType(this.res.getString(2));
				relation.setTeamerId(this.res.getInt(3));
				relation.setAnswer(this.res.getString(4));
				relation.setAnswerInfor(this.res.getString(5));
				relation.setAnswerTime(this.res.getDate(6));
				relation.setId(this.res.getInt(7));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return relation;
	}

	public int ifrepeatTeamer(int relationId) {
		int result = 0;
		
		try{
			//是否已达最大上限
			String sql = "select count(团队人员关系.Id)+1<毕业课题详细信息.`参与人数限定` from `毕业课题详细信息`,`团队信息`,`团队人员关系` where 团队信息.Id=团队人员关系.团队编号 "
						+"and 毕业课题详细信息.Id=团队信息.`题目编号` and 团队人员关系.`回复`='T' and `团队人员关系`.`队员类型`='S' and "
						+"团队人员关系.团队编号=(select 团队编号 from 团队人员关系 where id=?)";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, relationId);
			
			this.res = this.connectObj.getQueryResultSet();
			
			if(this.res.next()){
				result = this.res.getInt(1)==1 ? 1 : -1;
				if(result == 1){
					//检测是否已加入其他团队
					sql = "select 学生详细信息.团队编号 from `团队人员关系`,`学生详细信息` where 团队人员关系.`队员编号`=学生详细信息.id and 团队人员关系.Id=?";
					
					this.sta = this.connectObj.getStatement(sql);
					this.sta.setInt(1, relationId);
					
					this.res = this.connectObj.getQueryResultSet();
					//判断是否已加入其他团队
					result = this.res.next() ? (this.res.getInt(1)==0 ? 1 : 0) : 1;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}

	public Boolean repeatTeamer(int relationId) {
		Boolean result = false;
		
		try{
			String sql = "insert into `团队人员关系`(团队编号,队员类型,队员编号) "
						+"select 团队编号,队员类型,队员编号 from 团队人员关系 where id=?;";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, relationId);
			
			result = this.sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}
	
	public int ifRepeatTeacher(int relationId){
		int result = 0;
		
		try{
			String sql = "select CASE WHEN 教师详细信息.`已指导团队数目` >= 学校界面的系统参数设置.`指导团队上限` THEN -1 "
						+"WHEN (select count(队员编号) from 团队人员关系 where 团队编号=(select 团队编号 from `团队人员关系` where id=?) and 回复='T' and 队员类型='T') > 0 THEN 0 "
						+"ELSE 1 END from `教师详细信息`,`学校界面的系统参数设置` where 教师详细信息.Id=(select 队员编号 from `团队人员关系` where id=?)";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, relationId);
			this.sta.setInt(2, relationId);
			
			this.res = this.connectObj.getQueryResultSet();
			
			if(this.res.next()){
				result = this.res.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}
	
	public List<TeamRelation> queryTeamRelations(int relationId){
		List<TeamRelation> teamerList = new ArrayList<TeamRelation>();
		
		try{
			String sql = "select CASE "
						+"when `队员类型`='s' THEN (select 真实姓名 from `学生详细信息` where 学生详细信息.Id=队员编号) "
						+"when `队员类型`='T' THEN (select 真实姓名 from `教师详细信息` where 教师详细信息.Id=队员编号) "
						+"end as teamerName,队员类型,队员编号,回复,回复信息,回复时间 "
						+"from `团队人员关系` where 团队人员关系.`队员编号`=(select 队员编号 from 团队人员关系 where id=?) "
						+"and 团队人员关系.`团队编号`=(select 团队编号 from 团队人员关系 where id=?) "
						+"order by 团队人员关系.Id desc;";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, relationId);
			this.sta.setInt(2, relationId);
			
			this.res = this.connectObj.getQueryResultSet();
			TeamRelation relation = null;
			while(this.res.next()){
				relation = new TeamRelation();
				
				relation.setTeamerName(this.res.getString(1));
				relation.setTeamerType(this.res.getString(2));
				relation.setTeamId(this.res.getInt(3));
				relation.setAnswer(this.res.getString(4));
				relation.setAnswerInfor(this.res.getString(5));
				relation.setAnswerTime(this.res.getDate(6));
				teamerList.add(relation);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return teamerList;
	}
	
	public int queryTeamId(int userId){
		int teamId = 0;
		
		try{
			String sql = "select 团队编号 from 学生详细信息 where Id=?";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, userId);
			
			this.res = this.connectObj.getQueryResultSet();
			if(this.res.next()){
				teamId = this.res.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return teamId;
	}
}
