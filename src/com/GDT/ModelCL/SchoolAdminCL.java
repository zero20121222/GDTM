package com.GDT.ModelCL;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import com.GDT.Interface.SchoolAdminInterface;
import com.GDT.Model.AdminRequestInfor;
import com.GDT.Model.CommonSchoolUser;
import com.GDT.Model.ProjectAuditInfor;
import com.GDT.Model.ProjectInfor;
import com.GDT.Model.SchoolAdminer;
import com.GDT.Model.SchoolCollege;
import com.GDT.Model.SchoolInfor;
import com.GDT.Model.SchoolManageUser;
import com.GDT.Model.SchoolParams;
import com.GDT.Model.SchoolUsersFile;
import com.GDT.Model.SchoolUsersLink;
import com.GDT.util.DBConnection;
import com.GDT.util.DBConnectionInterface;

/**
 * 学校管理人员处理对象类
 * @author 
 */
public class SchoolAdminCL extends ManageSUserCL implements SchoolAdminInterface{
	DBConnectionInterface connectObj = null;
	PreparedStatement sta = null;
	ResultSet res = null;
	
	/*
	 * @see com.GDT.Interface.SchoolAdminInterface#saveAdminerInfor(com.GDT.Model.SchoolAdminer)
	 * 学校管理员信息保存
	 * @author zero
	 */
	public Boolean saveAdminerInfor(SchoolAdminer adminer){
		Boolean save = false;
		String sql = "insert into 管理员审核人员详细信息(Id,真实姓名,院系类别,职位,学位,办公室,年龄,性别,身份证号码,地址,手机,email,qq,个人简介,信息是否已填写) value(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, adminer.getId());
			sta.setString(2, adminer.getRealName());
			sta.setString(3, adminer.getCollege());
			sta.setString(4, adminer.getPosition());
			sta.setString(5, adminer.getDegree());
			sta.setString(6, adminer.getOffice());
			sta.setString(7, adminer.getAge());
			sta.setString(8, adminer.getSex());
			sta.setString(9, adminer.getIdCard());
			sta.setString(10, adminer.getAddress());
			sta.setString(11, adminer.getPhone());
			sta.setString(12, adminer.getEmail());
			sta.setString(13, adminer.getQq());
			sta.setString(14, adminer.getResume());
			sta.setString(15, "T");
			
			save = sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return save;
	}
	
	public Boolean alterSchoolInfor(SchoolInfor schoolinfor) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean createSchoolAdminer(SchoolManageUser schooladmin) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean createSchoolAuditer(SchoolManageUser shcoolaudit) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean createStudentUser(CommonSchoolUser studentUser) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean createTeacherUser(CommonSchoolUser teacherUser) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean doAlter(SchoolAdminer adminer) {
		// TODO Auto-generated method stub
		return null;
	}

	public SchoolAdminer doSelect(int id) {
		SchoolAdminer adminer = null;
		
		try{
			String sql = "select 真实姓名,院系类别,职位,学位,办公室,年龄,性别,身份证号码,地址,手机,email,qq,个人简介 from 管理员审核人员详细信息 where Id=?;";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, id);
			
			this.res = this.connectObj.getQueryResultSet();
			if(this.res.next()){
				adminer = new SchoolAdminer();
				
				adminer.setRealName(res.getString(1));
				adminer.setCollege(res.getString(2));
				adminer.setPosition(res.getString(3));
				adminer.setDegree(res.getString(4));
				adminer.setOffice(res.getString(5));
				adminer.setAge(res.getString(6));
				adminer.setSex(res.getString(7));
				adminer.setIdCard(res.getString(8));
				adminer.setAddress(res.getString(9));
				adminer.setPhone(res.getString(10));
				adminer.setEmail(res.getString(11));
				adminer.setQq(res.getString(12));
				adminer.setResume(res.getString(13));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return adminer;
	}

	public Boolean ifAllowUpdate(int schoolId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean ifExistManageUser(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	public String querySchoolAudit(int SchoolId) {
		// TODO Auto-generated method stub
		return null;
	}

	public SchoolInfor querySchoolInfor(int schoolId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean saveSchoolCollege(SchoolCollege college) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean saveSchoolInfor(SchoolInfor schoolinfor) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean saveSchoolUsersFile(SchoolUsersFile userfile) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean saveSchoolUsersLink(SchoolUsersLink userlink) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean setSchoolParams(SchoolParams params) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<ProjectAuditInfor> queryAllAuditInfor(int projectId) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<AdminRequestInfor> queryNews(int userId, String type) {
		// TODO Auto-generated method stub
		return null;
	}

	public ProjectInfor queryProjectInfor(int projectId) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
