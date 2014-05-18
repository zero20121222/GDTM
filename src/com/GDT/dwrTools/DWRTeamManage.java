package com.GDT.dwrTools;

import java.util.List;

import com.GDT.Factory.UserFactory;
import com.GDT.Interface.DWRTeamManageInterface;
import com.GDT.Interface.StudentInterface;
import com.GDT.Model.Student;
import com.GDT.Model.Teacher;
import com.GDT.Model.TeamInfor;
import com.GDT.Model.TeamRelation;

/**
 * 团队人员管理对象实现
 * @author zero
 */
public class DWRTeamManage implements DWRTeamManageInterface {

	public List<Student> findTeamStudents(String adderName , int schoolId) {
		StudentInterface studentCL = new UserFactory().createStudentCL();
		return studentCL.findTeamStudents(adderName, schoolId);
	}

	public List<Teacher> findTeamTeacher(String adderName , int schoolId) {
		StudentInterface studentCL = new UserFactory().createStudentCL();
		return studentCL.findTeamTeacher(adderName, schoolId);
	}

	public int createTeam(TeamInfor teamInfor, List<TeamRelation> teamerList) {
		StudentInterface studentCL = new UserFactory().createStudentCL();
		return studentCL.createTeam(teamInfor, teamerList);
	}
	
	public Boolean addTeamers(int userId , List<TeamRelation> teamerList){
		StudentInterface studentCL = new UserFactory().createStudentCL();
		return studentCL.addTeamers(studentCL.queryTeamId(userId), teamerList);
	}
	
	public Boolean ifAttendTeam(int userId){
		StudentInterface studentCL = new UserFactory().createStudentCL();
		return studentCL.ifAttendTeam(userId);
	}
	
	public List<TeamRelation> queryTeamerStatus(int managerId){
		StudentInterface studentCL = new UserFactory().createStudentCL();
		return studentCL.queryTeamerStatus(managerId);
	}
	
	public List<TeamRelation> queryTeamerStatusByUserId(int userId){
		StudentInterface studentCL = new UserFactory().createStudentCL();
		return studentCL.queryTeamerStatusByUserId(userId);
	}
	
	public TeamRelation queryTeamerRelation(int managerId , int userId){
		StudentInterface studentCL = new UserFactory().createStudentCL();
		return studentCL.queryTeamerRelation(managerId , userId);
	}
	
	public int answerTeamRequest(int relationId, String answer, String answerInfor, int newId){
		StudentInterface studentCL = new UserFactory().createStudentCL();
		
		int result = 0;
		if(answer.equals("T")){//可加入团队
			result = studentCL.ifrepeatTeamer(relationId);
			if(result == 1){
				result = studentCL.answerTeamRequest(relationId , answer, answerInfor, newId) ? 2 : 3;
			}
		}else{
			result = 2;
			studentCL.answerTeamRequest(relationId , answer, answerInfor, newId);
		}
		return result;
	}
	
	public int answerTeamRequestT(int relationId, String answer, String answerInfor, int newId){
		StudentInterface studentCL = new UserFactory().createStudentCL();
		
		int result = 0;
		if(answer.equals("T")){//可加入团队
			result = studentCL.ifRepeatTeacher(relationId);
			if(result == 1){
				result = studentCL.answerTeamRequest(relationId , answer, answerInfor, newId) ? 2 : 3;
			}
		}else{
			result = 2;
			studentCL.answerTeamRequest(relationId , answer, answerInfor, newId);
		}
		return result;
	}
	
	public Boolean answerNewRequest(int newId){
		StudentInterface studentCL = new UserFactory().createStudentCL();
		return studentCL.answerNewRequest(newId);
	}
	
	public int repeatCommitTeam(int relationId){
		StudentInterface studentCL = new UserFactory().createStudentCL();
		int repeatResult = 0;
		repeatResult = studentCL.ifrepeatTeamer(relationId);
		if(repeatResult == 1){
			repeatResult = studentCL.repeatTeamer(relationId) ? 1 : 2;
		}
		
		return repeatResult;
	}
	
	public int repeatCommitTeacher(int relationId){
		StudentInterface studentCL = new UserFactory().createStudentCL();
		int result = studentCL.ifRepeatTeacher(relationId);
		
		if(result == 1){
			result = studentCL.repeatTeamer(relationId) ? 1 : 2;
		}
		
		return result;
	}
	
	public List<TeamRelation> queryTeamRelations(int relationId){
		StudentInterface studentCL = new UserFactory().createStudentCL();
		return studentCL.queryTeamRelations(relationId);
	}
}
