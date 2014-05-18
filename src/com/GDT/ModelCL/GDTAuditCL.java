package com.GDT.ModelCL;

import java.util.List;

import com.GDT.Interface.GDTAuditInterface;
import com.GDT.Model.AdminRequestInfor;
import com.GDT.Model.GDTAuditer;
import com.GDT.Model.SchoolAuditInfor;
import com.GDT.Model.SchoolInfor;


/**
 * GDT后台学校信息审核人员处理类
 * @author 
 */
public class GDTAuditCL extends ManageGUserCL implements GDTAuditInterface{

	public Boolean doAlter(GDTAuditer adminer) {
		// TODO Auto-generated method stub
		return null;
	}

	public GDTAuditer doSelect(int id) {
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
