package com.GDT.ModelCL;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import com.GDT.Interface.ProjectAuditInterface;
import com.GDT.Interface.SchoolAuditInterface;
import com.GDT.Model.AdminRequestInfor;
import com.GDT.Model.ProjectAuditInfor;
import com.GDT.Model.ProjectInfor;
import com.GDT.Model.SchoolAuditer;
import com.GDT.util.*;

/**
 * 学校课题审核人员处理类
 * @author 
 */
public class SchoolAuditCL extends ManageSUserCL implements SchoolAuditInterface, ProjectAuditInterface {
	private int auditerId;//学校审核人员编号
	private DBConnectionInterface connectObj = null;
	private PreparedStatement sta = null;
	private ResultSet res = null;
	
	public SchoolAuditCL(){}
	
	public SchoolAuditCL(int auditerId){
		this.auditerId = auditerId;
	}
	
	public int getAuditerId() {
		return auditerId;
	}
	
	public void setAuditerId(int auditerId) {
		this.auditerId = auditerId;
	}

	public Boolean saveAuditerInfor(SchoolAuditer auditer){
		Boolean save = false;
		String sql = "insert into 管理员审核人员详细信息(Id,真实姓名,院系类别,职位,学位,办公室,年龄,性别,身份证号码,地址,手机,email,qq,个人简介,信息是否已填写) value(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, auditer.getId());
			sta.setString(2, auditer.getRealName());
			sta.setString(3, auditer.getCollege());
			sta.setString(4, auditer.getPosition());
			sta.setString(5, auditer.getDegree());
			sta.setString(6, auditer.getOffice());
			sta.setString(7, auditer.getAge());
			sta.setString(8, auditer.getSex());
			sta.setString(9, auditer.getIdCard());
			sta.setString(10, auditer.getAddress());
			sta.setString(11, auditer.getPhone());
			sta.setString(12, auditer.getEmail());
			sta.setString(13, auditer.getQq());
			sta.setString(14, auditer.getResume());
			sta.setString(15, "T");
			
			save = sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return save;
	}
	
	/*
	 * 实现用户详细信息的更改操作
	 * @see com.GDT.Interface.SchoolAuditInterface#doAlter(com.GDT.Model.SchoolAuditer)
	 * @author zero
	 */
	public Boolean doAlter(SchoolAuditer auditer) {
		Boolean updateResult = false;
		
		try{
			String sql = "update 管理员审核人员详细信息 set 办公室=?,年龄=?,性别=?,身份证号码=?,地址=?,手机=?,email=?,qq=?,个人简介=? where id=?;";
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setString(1, auditer.getOffice());
			sta.setString(2, auditer.getAge());
			sta.setString(3, auditer.getSex());
			sta.setString(4, auditer.getIdCard());
			sta.setString(5, auditer.getAddress());
			sta.setString(6, auditer.getPhone());
			sta.setString(7, auditer.getEmail());
			sta.setString(8, auditer.getQq());
			sta.setString(9, auditer.getResume());
			sta.setInt(10, auditer.getId());
			
			updateResult = sta.executeUpdate() == 1 ? true : false;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			connectObj.close();
		}
		
		return updateResult;
	}
	
	/**
	 * 查询审核人员的详细信息
	 * @see com.GDT.Interface.SchoolAuditInterface#doSelect(int)
	 * @author zero
	 */
	public SchoolAuditer doSelect(int id) {
		SchoolAuditer auditer = null;
		
		try{
			String sql = "select 真实姓名,院系类别,职位,学位,办公室,年龄,性别,身份证号码,地址,手机,email,qq,个人简介 from 管理员审核人员详细信息 where Id=?;";
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, id);
			
			this.res = this.connectObj.getQueryResultSet();
			if(this.res.next()){
				auditer = new SchoolAuditer();
				
				auditer.setRealName(res.getString(1));
				auditer.setCollege(res.getString(2));
				auditer.setPosition(res.getString(3));
				auditer.setDegree(res.getString(4));
				auditer.setOffice(res.getString(5));
				auditer.setAge(res.getString(6));
				auditer.setSex(res.getString(7));
				auditer.setIdCard(res.getString(8));
				auditer.setAddress(res.getString(9));
				auditer.setPhone(res.getString(10));
				auditer.setEmail(res.getString(11));
				auditer.setQq(res.getString(12));
				auditer.setResume(res.getString(13));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return auditer;
	}

	public Boolean ifAllowUpdate(int schoolId) {
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
	
	/**
	 * 课题审核处理
	 * @see com.GDT.Interface.ProjectAuditInterface#auditProject(int, java.lang.String, java.lang.String)
	 * @author zero
	 */
	public Boolean auditProject(int projectId , String auditResult, String auditRemark) {
		Boolean result = false;
		
		try{
			//查询课题是否存在未审核的人员
			String sql = "select case when `审核人员1` is null then 1 when `审核人员2` is null then 2 when `审核人员3` is null then 3 END as auditEmptyId "
					    +"from `课题审核情况` where 课题Id=? and 审核状态='N';";
			
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, projectId);
			
			this.res = this.connectObj.getQueryResultSet();
			int auditEmptyId = this.res.next() ? this.res.getInt(1) : 0;
			
			//对应于特定的审核处理实现
			switch(auditEmptyId){
				case 1:{
					sql = "update 课题审核情况 set 审核人员1=?,审核时间1=?,审核处理1=?,评语1=? where 课题Id=? and 审核状态='N'";
					break;
				}
				case 2:{
					sql = "update 课题审核情况 set 审核人员2=?,审核时间2=?,审核处理2=?,评语2=? where 课题Id=? and 审核状态='N'";
					break;
				}
				case 3:{
					sql = "update 课题审核情况 set 审核人员3=?,审核时间3=?,审核处理3=?,评语3=? where 课题Id=? and 审核状态='N'";
					break;
				}
			}
			
			if(auditEmptyId != 0){
				this.sta = this.connectObj.getStatement(sql);
				this.sta.setInt(1, this.auditerId);
				this.sta.setDate(2, GDTDate.getSqlDate());
				this.sta.setString(3, auditResult);
				this.sta.setString(4, auditRemark);
				this.sta.setInt(5, projectId);
				
				result = this.sta.executeUpdate() == 1 ? true : false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}

	public int ifNeedAudit(int projectId) {
		int result = 0;
		
		try{
			String sql = "select count(*) from 毕业课题详细信息 where Id=? and (题目状态='T' or 题目状态='F')";

			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, projectId);
			
			this.res = this.connectObj.getQueryResultSet();
			if(res.next()){
				if(res.getInt(1) > 0){
					//表示当前课题属于待审核状态
					result = 2;
				}else{
					//查询审核人员是否对该课题已审核过了
					sql = "select count(*) from `课题审核情况` where `课题Id`=? and 审核状态='N' and (审核人员1=? or 审核人员2=? or 审核人员3=?);";
					this.sta = this.connectObj.getStatement(sql);
					
					this.sta.setInt(1, projectId);
					this.sta.setInt(2, this.auditerId);
					this.sta.setInt(3, this.auditerId);
					this.sta.setInt(4, this.auditerId);
					this.res = this.connectObj.getQueryResultSet();
					
					if(res.next()){
						if(res.getInt(1) > 0){
							result = 1;	//用户对该课题已审核过了
						}
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return result;
	}
	
	/**
	 * @see com.GDT.Interface.ProjectAuditInterface#queryProject(int)
	 * 返回需要审核的课题的详细信息
	 * @author zero
	 */
	public ProjectInfor queryProject(int projectId) {
		ProjectInfor project = null;
		String sql = "select 毕业课题详细信息.Id,学校Id,毕业课题名称,出题人Id,真实姓名,"
					+"参与人数限定,工作量大小,院系限定,难易程度,课题目的,主要内容,图片信息,课题文件下载,创建时间,课题被选择次数,题目状态 "
					+"from 毕业课题详细信息 inner join 教师详细信息 on 教师详细信息.Id = 出题人Id where 毕业课题详细信息.Id = ?;";
		
		try{
			connectObj = new DBConnection();
			connectObj.getConnection();
			sta = connectObj.getStatement(sql);
			
			sta.setInt(1, projectId);
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

	public ProjectAuditInfor queryProjectAudits(int projectId) {
		ProjectAuditInfor auditInfor = null;
		String sql = "select * from audit_project_infor where 审核状态='N' and 课题Id=?";
		
		try{
			this.connectObj = new DBConnection();
			this.connectObj.getConnection();
			
			this.sta = this.connectObj.getStatement(sql);
			this.sta.setInt(1, projectId);
			
			this.res = this.connectObj.getQueryResultSet();
			if(res.next()){
				auditInfor = new ProjectAuditInfor();
				
				auditInfor.setAuditId(this.res.getInt(1));
				auditInfor.setProjectId(this.res.getInt(2));
				auditInfor.setAuditerId1(this.res.getInt(3));
				auditInfor.setAuditerName1(this.res.getString(4));
				auditInfor.setTime1(this.res.getDate(5));
				auditInfor.setDeal1(this.res.getString(6));
				auditInfor.setRemark1(this.res.getString(7));
				auditInfor.setAuditerId2(this.res.getInt(8));
				auditInfor.setAuditerName2(this.res.getString(9));
				auditInfor.setTime2(this.res.getDate(10));
				auditInfor.setDeal2(this.res.getString(11));
				auditInfor.setRemark2(this.res.getString(12));
				auditInfor.setAuditerId3(this.res.getInt(13));
				auditInfor.setAuditerName3(this.res.getString(14));
				auditInfor.setTime3(this.res.getDate(15));
				auditInfor.setDeal3(this.res.getString(16));
				auditInfor.setRemark3(this.res.getString(17));
				auditInfor.setAuditStage(this.res.getString(18));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.connectObj.close();
		}
		
		return auditInfor;
	}
	
}
