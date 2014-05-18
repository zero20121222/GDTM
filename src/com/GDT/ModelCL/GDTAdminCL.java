package com.GDT.ModelCL;

import java.io.OutputStream;
import java.util.List;

import com.GDT.Interface.GDTAdminInterface;
import com.GDT.Model.AdminRequestInfor;
import com.GDT.Model.GDTAdminer;
import com.GDT.Model.GDTManageUser;
import com.GDT.Model.SchoolAdminer;
import com.GDT.Model.SchoolAuditInfor;
import com.GDT.Model.SchoolInfor;

/**
 * GDT后台管理人员处理类
 * @author 
 */
public class GDTAdminCL extends ManageGUserCL implements GDTAdminInterface {

	public int checkFileStage(int fileId) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int checkLinkStage(int linkId) {
		// TODO Auto-generated method stub
		return 0;
	}

	public Boolean createGDTAdminer(GDTManageUser amininfor) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean createGDTAuditer(GDTManageUser auditinfor) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean createSchoolAdmin(SchoolAdminer schooladmin) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean doAlter(GDTAdminer adminer) {
		// TODO Auto-generated method stub
		return null;
	}

	public GDTAdminer doSelect(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	public String getStudentsFile(int schoolId) {
		// TODO Auto-generated method stub
		return null;
	}

	public OutputStream getStudentsFileIO(int schoolId) {
		// TODO Auto-generated method stub
		return null;
	}

	public String getTeachersFile(int schoolId) {
		// TODO Auto-generated method stub
		return null;
	}

	public OutputStream getTeachersFileIO(int schoolId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean ifExistGDTUser(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean ifExistSchoolUser(String username, int schoolId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean leadSchoolUsersFile(int fileId) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean leadSchoolUsersLink(int linkId) {
		// TODO Auto-generated method stub
		return null;
	}

	public SchoolAuditInfor queryAllAuditInfor(int schoolId) {
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
	
}
