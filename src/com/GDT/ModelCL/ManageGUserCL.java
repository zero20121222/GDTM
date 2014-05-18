package com.GDT.ModelCL;

import java.util.List;

import com.GDT.Interface.ManageGUserInterface;
import com.GDT.Model.AdminRequestInfor;
import com.GDT.Model.SchoolAuditInfor;
import com.GDT.Model.SchoolInfor;

/**
 * GDT后台管理用户基本处理类
 * @author 
 */
public class ManageGUserCL implements ManageGUserInterface{

	public Boolean auditSchoolInfor(int schoolId, int userId, String audit,
			String comment) {
		// TODO Auto-generated method stub
		return null;
	}

	public int doLogin(String name, String password) {
		// TODO Auto-generated method stub
		return 0;
	}

	public SchoolAuditInfor queryAllAuditInfor(int schoolId) {
		// TODO Auto-generated method stub
		return null;
	}

	public String queryAuditInfors(int schoolId) {
		// TODO Auto-generated method stub
		return null;
	}

	public String queryAuditStyle(int schoolId) {
		// TODO Auto-generated method stub
		return null;
	}

	public String queryNewInfors(String type) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<AdminRequestInfor> queryNews(String type) {
		// TODO Auto-generated method stub
		return null;
	}

	public SchoolInfor querySchoolInfor(int schoolId) {
		// TODO Auto-generated method stub
		return null;
	}

	public String queryUserType(int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean alterHead(int id, String head) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean alterPassword(int id, String password) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean checkPassword(int id, String password) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean doDelete(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean ifDetail(int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean ifUseName(String name) {
		// TODO Auto-generated method stub
		return null;
	}

	public String queryTrueName(int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	public String queryUserInfor(int id) {
		// TODO Auto-generated method stub
		return null;
	}

}
