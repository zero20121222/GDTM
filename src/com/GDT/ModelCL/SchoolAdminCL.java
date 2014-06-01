package com.GDT.ModelCL;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

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
import com.GDT.util.UserEventBus;
import com.GDT.util.UserEventHandler;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.mysql.jdbc.Statement;

/**
 * 学校管理人员处理对象类
 * @author 
 */
public class SchoolAdminCL extends ManageSUserCL implements SchoolAdminInterface{
    private final UserEventBus userEventBus = new UserEventBus();

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

    @Override
	public Boolean createSchoolAuditor(SchoolManageUser schoolAuditor) {
        Boolean save = false;
        String sql = "insert into 管理员审核人员账号(学校Id,用户名,密码,头像,用户类型) values(?,?,?,?,?);";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql);

            sta.setInt(1, schoolAuditor.getSchoolId());
            sta.setString(2, schoolAuditor.getUserName());
            sta.setString(3, schoolAuditor.getUserPassword());
            sta.setString(4, schoolAuditor.getUserHead());
            sta.setString(5, "E");

            save = sta.executeUpdate() == 1 ? true : false;
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return save;
	}

	public Boolean createStudentUser(CommonSchoolUser studentUser) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean createTeacherUser(CommonSchoolUser teacherUser) {
		// TODO Auto-generated method stub
		return null;
	}

    /*
        更改管理员用户信息
     */
	public Boolean doAlter(SchoolAdminer adminer) {
        Boolean updateResult = false;

        try{
            String sql = "update 管理员审核人员详细信息 set 办公室=?,年龄=?,性别=?,身份证号码=?,地址=?,手机=?,email=?,qq=?,个人简介=? where id=?;";
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql);

            sta.setString(1, adminer.getOffice());
            sta.setString(2, adminer.getAge());
            sta.setString(3, adminer.getSex());
            sta.setString(4, adminer.getIdCard());
            sta.setString(5, adminer.getAddress());
            sta.setString(6, adminer.getPhone());
            sta.setString(7, adminer.getEmail());
            sta.setString(8, adminer.getQq());
            sta.setString(9, adminer.getResume());
            sta.setInt(10, adminer.getId());

            updateResult = sta.executeUpdate() == 1 ? true : false;
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return updateResult;
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

    @Override
	public SchoolInfor querySchoolInfor(int schoolId) {
		SchoolInfor schoolInfor = null;

        String sql = "select * from 学校详细信息 where id=?";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();

            sta = connectObj.getStatement(sql);
            sta.setInt(1 , schoolId);

            res = connectObj.getQueryResultSet();

            if(res.next()){
                schoolInfor = new SchoolInfor();
                schoolInfor.setId(res.getInt(1));
                schoolInfor.setName(res.getString(2));
                schoolInfor.setProvince(res.getString(3));
                schoolInfor.setAddress(res.getString(4));
                schoolInfor.setSize(res.getDouble(5));
                schoolInfor.setFoundTime(res.getString(6));
                schoolInfor.setSchoolId(res.getString(7));
                schoolInfor.setHeadmaster(res.getString(8));
                schoolInfor.setPhone(res.getString(9));
                schoolInfor.setEamil(res.getString(10));
                schoolInfor.setLabInfor(res.getString(11));
                schoolInfor.setTeacherInfor(res.getString(12));
                schoolInfor.setCollegeNumber(res.getInt(13));
                schoolInfor.setStudentNumber(res.getInt(14));
                schoolInfor.setTeacherNumber(res.getInt(15));
                schoolInfor.setSchoolLevel(res.getString(16));
                schoolInfor.setSchoolFile(res.getString(17));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

		return schoolInfor;
	}

	public Boolean saveSchoolCollege(SchoolCollege college) {
		// TODO Auto-generated method stub
		return null;
	}

	public Boolean saveSchoolInfor(SchoolInfor schoolinfor) {
		// TODO Auto-generated method stub
		return null;
	}

    /*
        实现根据excel文件进行用户信息的导入操作
     */
	public Boolean saveSchoolUsersFile(SchoolUsersFile userfile , Boolean autoLoad, String filePath) {
        Boolean save = false;
        String sql = "insert into 学校数据源文件(学校编号,数据源文件名称,数据源文件路径,数据源类型,创建时间) value(?,?,?,?,now());";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql , Statement.RETURN_GENERATED_KEYS);

            sta.setInt(1, userfile.getSchoolId());
            sta.setString(2, userfile.getName());
            sta.setString(3, userfile.getPath());
            sta.setString(4, userfile.getType());

            save = sta.executeUpdate() == 1 ? true : false;

            //获取自动生成的主健编号
            res = sta.getGeneratedKeys();
            userfile.setId(res.next() ? res.getInt(1) : 0);

            //excel文件的解析处理（这个是后台异步调用处理的，是否自动启动导入事件）
            if(save && autoLoad){
                userfile.setFilePath(filePath);
                userEventBus.register(new UserEventHandler());
                userEventBus.post(userfile);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

		return save;
	}

    @Override
    public List<SchoolUsersFile> querySchoolUsersFiles(int schoolId) {
        List<SchoolUsersFile> fileList = Lists.newArrayList();

        String sql = "select * from 学校数据源文件 where 学校编号=?";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();

            sta = connectObj.getStatement(sql);
            sta.setInt(1 , schoolId);

            res = connectObj.getQueryResultSet();

            SchoolUsersFile usersFile = null;
            while(res.next()){
                usersFile = new SchoolUsersFile();
                usersFile.setId(res.getInt(1));
                usersFile.setSchoolId(res.getInt(2));
                usersFile.setName(res.getString(3));
                usersFile.setPath(res.getString(4));
                usersFile.setType(res.getString(5));
                usersFile.setIfLoad(res.getString(6));
                usersFile.setLoadCount(res.getInt(7));
                usersFile.setCreatedAt(res.getString(8));

                fileList.add(usersFile);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return fileList;
    }

    public Boolean saveSchoolUsersLink(SchoolUsersLink userlink) {
		// TODO Auto-generated method stub
		return null;
	}

    @Override
    public List<CommonSchoolUser> querySchoolUsers(int schoolId, int pageNo, int pageSize, Map<String, String> params) {
        List<CommonSchoolUser> userList = Lists.newArrayList();

        //当前页码
        pageNo = pageNo > 0 ? pageNo : 1;
        pageSize = pageSize > 0 ? pageSize : 12;
        int from = (pageNo-1)*pageSize;

        String sql = "select * from 学生教师账号 where 学校Id="+schoolId+" and 用户名 like '%"
                    + (params.get("userName") == null ? "" : params.get("userName"))+"%' order by 用户名 limit "+from+","+pageSize;

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();

            sta = connectObj.getStatement(sql);
            res = connectObj.getQueryResultSet();

            CommonSchoolUser user = null;
            while(res.next()){
                user = new CommonSchoolUser();
                user.setId(res.getInt(1));
                user.setSchoolId(res.getInt(2));
                user.setUserName(res.getString(3));
                user.setUserPassword(res.getString(4));
                user.setUserHead(res.getString(5));
                user.setUserType(res.getString(6));

                userList.add(user);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return userList;
    }

    @Override
    public Map<String , String> querySchoolUserCount(int schoolId, int pageNo, int pageSize, Map<String, String> params) {
        Map<String , String> countParam = Maps.newHashMap();

        //当前页码
        pageNo = pageNo > 0 ? pageNo : 1;
        pageSize = pageSize > 0 ? pageSize : 12;
        int from = (pageNo-1)*pageSize;

        String sql = "select count(*) from 学生教师账号 where 学校Id="+schoolId+" and 用户名 like '%"
                + (params.get("userName") == null ? "" : params.get("userName"))+"%'";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();

            sta = connectObj.getStatement(sql);
            res = connectObj.getQueryResultSet();

            int count = 0;
            if(res.next()){
                count = res.getInt(1);
            }
            countParam.put("countNum" , count+"");
            countParam.put("pageNo" , pageNo+"");
            countParam.put("pageSize" , pageSize+"");
            countParam.put("countPage" , (count%pageSize == 0 ? count/pageSize : count/pageSize+1)+"");
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return countParam;
    }

    @Override
    public List<SchoolManageUser> querySchoolAuditors(int schoolId, int pageNo, int pageSize, Map<String, String> params) {
        List<SchoolManageUser> userList = Lists.newArrayList();

        //当前页码
        pageNo = pageNo > 0 ? pageNo : 1;
        pageSize = pageSize > 0 ? pageSize : 12;
        int from = (pageNo-1)*pageSize;

        String sql = "select * from 管理员审核人员账号 where 用户类型='E' and 学校Id="+schoolId+" and 用户名 like '%"
                + (params.get("userName") == null ? "" : params.get("userName"))+"%' order by 用户名 limit "+from+","+pageSize;

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();

            sta = connectObj.getStatement(sql);
            res = connectObj.getQueryResultSet();

            SchoolManageUser user = null;
            while(res.next()){
                user = new SchoolManageUser();
                user.setId(res.getInt(1));
                user.setSchoolId(res.getInt(2));
                user.setUserName(res.getString(3));
                user.setUserPassword(res.getString(4));
                user.setUserHead(res.getString(5));
                user.setUserType(res.getString(6));

                userList.add(user);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return userList;
    }

    @Override
    public Map<String, String> querySchoolAuditorCount(int schoolId, int pageNo, int pageSize, Map<String, String> params) {
        Map<String , String> countParam = Maps.newHashMap();

        //当前页码
        pageNo = pageNo > 0 ? pageNo : 1;
        pageSize = pageSize > 0 ? pageSize : 12;
        int from = (pageNo-1)*pageSize;

        String sql = "select count(*) from 管理员审核人员账号 where 用户类型='E' and 学校Id="+schoolId+" and 用户名 like '%"
                + (params.get("userName") == null ? "" : params.get("userName"))+"%'";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();

            sta = connectObj.getStatement(sql);
            res = connectObj.getQueryResultSet();

            int count = 0;
            if(res.next()){
                count = res.getInt(1);
            }
            countParam.put("countNum" , count+"");
            countParam.put("pageNo" , pageNo+"");
            countParam.put("pageSize" , pageSize+"");
            countParam.put("countPage" , (count%pageSize == 0 ? count/pageSize : count/pageSize+1)+"");
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return countParam;
    }

    @Override
    public Boolean existAuditorName(int schoolId, String userName) {
        Boolean exist = false;

        String sql = "select * from 管理员审核人员账号 where 学校Id=? and 用户名=? ";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();

            sta = connectObj.getStatement(sql);
            sta.setInt(1 , schoolId);
            sta.setString(2 , userName);

            res = connectObj.getQueryResultSet();
            exist = res.next();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return exist;
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
