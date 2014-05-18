package com.GDT.Factory;

import com.GDT.Interface.CommonSUserInterface;
import com.GDT.Interface.GDTAdminInterface;
import com.GDT.Interface.GDTAuditInterface;
import com.GDT.Interface.ManageGUserInterface;
import com.GDT.Interface.ManageSUserInterface;
import com.GDT.Interface.SchoolAdminInterface;
import com.GDT.Interface.SchoolAuditInterface;
import com.GDT.Interface.StudentInterface;
import com.GDT.Interface.TeacherInterface;
import com.GDT.Interface.UserFactoryInterface;
import com.GDT.ModelCL.CommonSUserCL;
import com.GDT.ModelCL.GDTAdminCL;
import com.GDT.ModelCL.GDTAuditCL;
import com.GDT.ModelCL.ManageGUserCL;
import com.GDT.ModelCL.ManageSUserCL;
import com.GDT.ModelCL.SchoolAdminCL;
import com.GDT.ModelCL.SchoolAuditCL;
import com.GDT.ModelCL.StudentCL;
import com.GDT.ModelCL.TeacherCL;

/**
 * 用户创建工程对象
 * @author zero
 */
public class UserFactory implements UserFactoryInterface{
	
	public CommonSUserInterface createCommonSUserCL() {
		return new CommonSUserCL();
	}

	public GDTAdminInterface createGDTAdminCL() {
		return new GDTAdminCL();
	}

	public GDTAuditInterface createGDTAuditCL() {
		return new GDTAuditCL();
	}

	public ManageGUserInterface createManageGUserCL() {
		return new ManageGUserCL();
	}

	public ManageSUserInterface createManageSUserCL() {
		return new ManageSUserCL();
	}

	public SchoolAdminInterface createSchoolAdminCL() {
		return new SchoolAdminCL();
	}

	public SchoolAuditInterface createSchoolAuditCL() {
		return new SchoolAuditCL();
	}

	public StudentInterface createStudentCL() {
		return new StudentCL();
	}

	public TeacherInterface createTeacherCL() {
		return new TeacherCL();
	}
	
}
