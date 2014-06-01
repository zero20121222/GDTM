package com.GDT.Servlet;

import com.GDT.Factory.NewsFactory;
import com.GDT.Factory.SchoolManageFactory;
import com.GDT.Factory.UserFactory;
import com.GDT.Interface.*;
import com.GDT.Model.*;
import com.google.common.collect.Maps;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

/*
 * 用于处理学校管理处理的servlet
 */
public class SchoolManageServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String type = request.getParameter("type");
		if(type.equals("query_school_params")){//获取学校参数信息
            int adminId = Integer.parseInt((String)session.getAttribute("user_id"));

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                SchoolManageFactoryInterface manageFactory = new SchoolManageFactory();
                SchoolParamsInterface paramsCL = manageFactory.createSchoolParamsCL();

                SchoolParams schoolParams = paramsCL.querySchoolParams(user.getSchoolId());

                request.setAttribute("schoolParams", schoolParams);
                request.getRequestDispatcher("/SchoolAdmin/schoolParams.jsp").forward(request, response);
            }else{
                request.getRequestDispatcher("/SchoolAdmin/schoolAdminLogin.jsp").forward(request, response);
            }
        }else if(type.equals("update_school_params")){//更新学校参数信息
            int adminId = Integer.parseInt((String)session.getAttribute("user_id"));

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                SchoolManageFactoryInterface manageFactory = new SchoolManageFactory();
                SchoolParamsInterface paramsCL = manageFactory.createSchoolParamsCL();

                SchoolParams schoolParams = new SchoolParams();
                schoolParams.setSchoolId(user.getSchoolId());
                schoolParams.setInforOvert(request.getParameter("inforOvert"));
                schoolParams.setParterUpperLimit(Integer.parseInt(request.getParameter("parterUpperLimit")));
                schoolParams.setStageUpperTime(Integer.parseInt(request.getParameter("stageUpperTime")));
                schoolParams.setAuditNumber(Integer.parseInt(request.getParameter("auditNumber")));
                schoolParams.setAdoptNumber(Integer.parseInt(request.getParameter("adoptNumber")));
                schoolParams.setStageUpperLimit(Integer.parseInt(request.getParameter("stageUpperLimit")));
                schoolParams.setStageFloorLimit(Integer.parseInt(request.getParameter("stageFloorLimit")));
                schoolParams.setProSelectLimit(Integer.parseInt(request.getParameter("proSelectLimit")));
                schoolParams.setGuideTeamLimit(Integer.parseInt(request.getParameter("guideTeamLimit")));
                schoolParams.setUpdateAccount(request.getParameter("updateAccount"));
                schoolParams.setCoverFiles(request.getParameter("coverFiles"));
                schoolParams.setNoticeNum(Integer.parseInt(request.getParameter("noticeNum")));

                //更新学校参数信息
                paramsCL.updateSchoolParams(schoolParams);

                request.getRequestDispatcher("/SchoolAdmin/body.jsp").forward(request, response);
            }else{
                request.getRequestDispatcher("/SchoolAdmin/schoolAdminLogin.jsp").forward(request, response);
            }
        }else if(type.equals("query_school_files")){//获取学校人员配置信息
            int adminId = Integer.parseInt((String) session.getAttribute("user_id"));

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                SchoolAdminInterface adminCL = factory.createSchoolAdminCL();
                List<SchoolUsersFile> usersFileList = adminCL.querySchoolUsersFiles(user.getSchoolId());

                request.setAttribute("usersFileList", usersFileList);
                request.getRequestDispatcher("/SchoolAdmin/loadUserFiles.jsp").forward(request, response);
            }else{
                request.getRequestDispatcher("/SchoolAdmin/schoolAdminLogin.jsp").forward(request, response);
            }
        }else if(type.equals("query_school_auditors")){//获取学校审核人员
            int adminId = Integer.parseInt((String)session.getAttribute("user_id"));

            int pageNo = Integer.parseInt(request.getParameter("pageNo") == null ? "0" : request.getParameter("pageNo"));
            int pageSize = Integer.parseInt(request.getParameter("pageSize") == null ? "0" : request.getParameter("pageSize"));
            Map<String , String> params = Maps.newHashMap();
            params.put("userName", request.getParameter("userName"));

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                SchoolAdminInterface adminCL = factory.createSchoolAdminCL();
                List<SchoolManageUser> userList = adminCL.querySchoolAuditors(user.getSchoolId(), pageNo, pageSize, params);

                Map<String , String> countParams = adminCL.querySchoolAuditorCount(user.getSchoolId(), pageNo, pageSize, params);

                request.setAttribute("userList", userList);
                request.setAttribute("countNum", countParams.get("countNum"));
                request.setAttribute("pageNo", countParams.get("pageNo"));
                request.setAttribute("pageSize", countParams.get("pageSize"));
                request.setAttribute("countPage", countParams.get("countPage"));
                request.setAttribute("userName", params.get("userName"));
                request.getRequestDispatcher("/SchoolAdmin/showAuditors.jsp").forward(request, response);
            }else{
                request.getRequestDispatcher("/SchoolAdmin/schoolAdminLogin.jsp").forward(request, response);
            }
        }else if(type.equals("query_auditor_infor")){//获取审核人员用户信息
            int adminId = Integer.parseInt((String)session.getAttribute("user_id"));
            int userId = Integer.parseInt(request.getParameter("query_userId"));

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                SchoolAuditInterface auditCL = factory.createSchoolAuditCL();
                SchoolAuditer auditor = auditCL.doSelect(userId);

                request.setAttribute("auditorInfo", auditor);
                request.getRequestDispatcher("SchoolAdmin/auditorInfor.jsp").forward(request, response);
            }else{
                request.getRequestDispatcher("/SchoolAdmin/schoolAdminLogin.jsp").forward(request, response);
            }
        }else if(type.equals("userName_ifExist")){//审核人员用户是否已存在
            int adminId = Integer.parseInt((String)session.getAttribute("user_id"));
            String userName = request.getParameter("userName");

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            PrintWriter out = response.getWriter();
            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                SchoolAdminInterface adminCL = factory.createSchoolAdminCL();
                Boolean exist = adminCL.existAuditorName(user.getSchoolId() , userName);

                out.print(exist);
            }else{
                out.print(-1);
            }
            out.close();
        }else if(type.equals("save_Auditor")){//保存审核人员账号
            int adminId = Integer.parseInt((String)session.getAttribute("user_id"));

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                SchoolAdminInterface adminCL = factory.createSchoolAdminCL();

                SchoolAuditer auditor = new SchoolAuditer();
                auditor.setUserName(request.getParameter("auditorName"));
                auditor.setUserPassword(request.getParameter("userPW"));
                auditor.setSchoolId(user.getSchoolId());
                auditor.setUserHead("head1.png");
                auditor.setUserType("E");

                adminCL.createSchoolAuditor(auditor);
                request.getRequestDispatcher("SchoolManageServlet?type=query_school_auditors").forward(request, response);
            }else{
                request.getRequestDispatcher("/SchoolAdmin/schoolAdminLogin.jsp").forward(request, response);
            }
        }else if(type.equals("query_school_users")){//获取学校人员信息
            int adminId = Integer.parseInt((String)session.getAttribute("user_id"));

            int pageNo = Integer.parseInt(request.getParameter("pageNo") == null ? "0" : request.getParameter("pageNo"));
            int pageSize = Integer.parseInt(request.getParameter("pageSize") == null ? "0" : request.getParameter("pageSize"));
            Map<String , String> params = Maps.newHashMap();
            params.put("userName" , request.getParameter("userName"));

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                SchoolAdminInterface adminCL = factory.createSchoolAdminCL();
                List<CommonSchoolUser> userList = adminCL.querySchoolUsers(user.getSchoolId(), pageNo, pageSize, params);

                Map<String , String> countParams = adminCL.querySchoolUserCount(user.getSchoolId(), pageNo, pageSize, params);

                request.setAttribute("userList", userList);
                request.setAttribute("countNum", countParams.get("countNum"));
                request.setAttribute("pageNo", countParams.get("pageNo"));
                request.setAttribute("pageSize", countParams.get("pageSize"));
                request.setAttribute("countPage", countParams.get("countPage"));
                request.setAttribute("userName", params.get("userName"));
                request.getRequestDispatcher("/SchoolAdmin/showUsers.jsp").forward(request, response);
            }else{
                request.getRequestDispatcher("/SchoolAdmin/schoolAdminLogin.jsp").forward(request, response);
            }
        }else if(type.equals("query_user_infor")){//获取人员用户信息
            int adminId = Integer.parseInt((String)session.getAttribute("user_id"));
            int userId = Integer.parseInt(request.getParameter("query_userId"));

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                CommonSUserInterface commonCL = factory.createCommonSUserCL();
                String user_type = commonCL.queryUserType(userId);

                if(user_type.equals("S")){//跳转到学生页面
                    StudentInterface studentCL = factory.createStudentCL();
                    Student student = studentCL.doSelect(userId);

                    request.setAttribute("studentInfor", student);
                    request.getRequestDispatcher("SchoolAdmin/studentInfor.jsp").forward(request, response);
                }else if(user_type.equals("T")){//跳转到教师页面
                    TeacherInterface teacherCL = factory.createTeacherCL();
                    Teacher teacher = teacherCL.doSelect(userId);

                    request.setAttribute("teacherInfor", teacher);
                    request.getRequestDispatcher("SchoolAdmin/teacherInfor.jsp").forward(request, response);
                }
            }else{
                request.getRequestDispatcher("/SchoolAdmin/schoolAdminLogin.jsp").forward(request, response);
            }
        }else if(type.equals("query_school_news")){//获取学校的最新的公告信息
            int adminId = Integer.parseInt((String)session.getAttribute("user_id"));
            int pageNo = Integer.parseInt(request.getParameter("pageNo") == null ? "0" : request.getParameter("pageNo"));
            int pageSize = Integer.parseInt(request.getParameter("pageSize") == null ? "0" : request.getParameter("pageSize"));
            Map<String , String> params = Maps.newHashMap();

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                NewsFactoryInterface newsFactory = new NewsFactory();
                SchoolNewInterface newCL = newsFactory.createSchoolNewCL();

                List<SchoolNew> newList = newCL.queryAllNews(user.getSchoolId() , pageNo , pageSize, params);
                request.setAttribute("newList", newList);

                //分页数据
                Map<String , String> countParams = newCL.queryNewsCount(user.getSchoolId(), pageNo, pageSize, params);
                request.setAttribute("countNum", countParams.get("countNum"));
                request.setAttribute("pageNo", countParams.get("pageNo"));
                request.setAttribute("pageSize", countParams.get("pageSize"));
                request.setAttribute("countPage", countParams.get("countPage"));
                request.getRequestDispatcher("SchoolAdmin/schoolNews.jsp").forward(request, response);
            }else{
                request.getRequestDispatcher("/SchoolAdmin/schoolAdminLogin.jsp").forward(request, response);
            }
        }else if(type.equals("query_new_infor")){//获取学校的公告详细信息
            int newId = Integer.parseInt(request.getParameter("query_newId"));

            NewsFactoryInterface newsFactory = new NewsFactory();
            SchoolNewInterface newCL = newsFactory.createSchoolNewCL();

            SchoolNew schoolNew = newCL.querySchoolNew(newId);
            request.setAttribute("schoolNew", schoolNew);
            request.getRequestDispatcher("SchoolAdmin/detailNew.jsp").forward(request, response);
        }else if(type.equals("school_creat_News")){//创建公告详细信息
            int adminId = Integer.parseInt((String)session.getAttribute("user_id"));
            String path = getServletConfig().getServletContext().getRealPath("/");//得到系统根目录

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                NewsFactoryInterface newsFactory = new NewsFactory();
                SchoolNewInterface newCL = newsFactory.createSchoolNewCL();

                SchoolNew newInfo = new SchoolNew();
                newInfo.setSchoolId(user.getSchoolId());
                newInfo.setSenderId(adminId);
                //将上传过来的javascript中文数据转换由16位编码格式转换(对于javascript传递过来的数据进行编码转换)
                newInfo.setTitle(URLDecoder.decode(request.getParameter("title"), "UTF-8"));
                newInfo.setContentFile(URLDecoder.decode(request.getParameter("upfile_name"), "UTF-8"));
                newInfo.setPicture(URLDecoder.decode(request.getParameter("uppicture_name"), "UTF-8"));
                newInfo.setContent(URLDecoder.decode(request.getParameter("content"), "UTF-8"));

                newCL.doCreate(newInfo , path);
                request.getRequestDispatcher("SchoolManageServlet?type=query_school_news").forward(request, response);
            }else{
                request.getRequestDispatcher("/SchoolAdmin/schoolAdminLogin.jsp").forward(request, response);
            }
        }else if(type.equals("delete_school_new")){//删除公告详细信息
            int adminId = Integer.parseInt((String)session.getAttribute("user_id"));
            int newsId = Integer.parseInt(request.getParameter("newsId"));

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                NewsFactoryInterface newsFactory = new NewsFactory();
                SchoolNewInterface newCL = newsFactory.createSchoolNewCL();

                newCL.doDelete(newsId);
                request.getRequestDispatcher("SchoolManageServlet?type=query_school_news").forward(request, response);
            }else{
                request.getRequestDispatcher("/SchoolAdmin/schoolAdminLogin.jsp").forward(request, response);
            }
        }else if(type.equals("query_school_info")){//查询学校的信息
            int adminId = Integer.parseInt((String)session.getAttribute("user_id"));

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                SchoolAdminInterface adminCL = factory.createSchoolAdminCL();
                SchoolInfor schoolInfor = adminCL.querySchoolInfor(user.getSchoolId());

                request.setAttribute("schoolInfor" , schoolInfor);
                request.getRequestDispatcher("SchoolAdmin/schoolInfo.jsp").forward(request, response);
            }else{
                request.getRequestDispatcher("/SchoolAdmin/schoolAdminLogin.jsp").forward(request, response);
            }
        }else if(type.equals("query_school_colleges")){//查询学校的院系信息
            int adminId = Integer.parseInt((String) session.getAttribute("user_id"));

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                SchoolManageFactoryInterface manageFactory = new SchoolManageFactory();
                SchoolCollegeInterface collegeCL = manageFactory.createSchoolCollegeCL();

                List<SchoolCollege> collegeList = collegeCL.queryAllSchoolCollege(user.getSchoolId());

                request.setAttribute("collegeList" , collegeList);
                request.getRequestDispatcher("SchoolAdmin/schoolCollege.jsp").forward(request, response);
            }else{
                request.getRequestDispatcher("/SchoolAdmin/schoolAdminLogin.jsp").forward(request, response);
            }
        }else if(type.equals("query_detail_college")){//查询详细的院系信息
            int adminId = Integer.parseInt((String)session.getAttribute("user_id"));
            String collegeName = URLDecoder.decode(request.getParameter("collegeName"), "UTF-8");

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                SchoolManageFactoryInterface manageFactory = new SchoolManageFactory();
                SchoolCollegeInterface collegeCL = manageFactory.createSchoolCollegeCL();

                SchoolCollege schoolCollege = collegeCL.querySchoolCollege(user.getSchoolId(), collegeName);

                request.setAttribute("schoolCollege" , schoolCollege);
                request.getRequestDispatcher("SchoolAdmin/detailCollege.jsp").forward(request, response);
            }else{
                request.getRequestDispatcher("/SchoolAdmin/schoolAdminLogin.jsp").forward(request, response);
            }
        }else if(type.equals("updateColleges")){//更改院系信息
            int adminId = Integer.parseInt((String)session.getAttribute("user_id"));

            UserFactoryInterface factory = new UserFactory();
            ManageSUserInterface manageCL = factory.createManageSUserCL();
            SchoolManageUser user = manageCL.queryUserInfo(adminId);

            //是否有管理员权限
            if(user.getUserType().toUpperCase().equals("A")){
                SchoolManageFactoryInterface manageFactory = new SchoolManageFactory();
                SchoolCollegeInterface collegeCL = manageFactory.createSchoolCollegeCL();

                SchoolCollege schoolCollege = new SchoolCollege();
                schoolCollege.setSchoolId(user.getSchoolId());
                schoolCollege.setCollegeName(URLDecoder.decode(request.getParameter("collegeName"), "UTF-8"));
                schoolCollege.setMajor1(request.getParameter("major1") == null ? null : URLDecoder.decode(request.getParameter("major1"), "UTF-8"));
                schoolCollege.setMajor2(request.getParameter("major2") == null ? null : URLDecoder.decode(request.getParameter("major2"), "UTF-8"));
                schoolCollege.setMajor3(request.getParameter("major3") == null ? null : URLDecoder.decode(request.getParameter("major3"), "UTF-8"));
                schoolCollege.setMajor4(request.getParameter("major4") == null ? null : URLDecoder.decode(request.getParameter("major4"), "UTF-8"));
                schoolCollege.setMajor5(request.getParameter("major5") == null ? null : URLDecoder.decode(request.getParameter("major5"), "UTF-8"));
                schoolCollege.setMajor6(request.getParameter("major6") == null ? null : URLDecoder.decode(request.getParameter("major6"), "UTF-8"));
                schoolCollege.setMajor7(request.getParameter("major7") == null ? null : URLDecoder.decode(request.getParameter("major7"), "UTF-8"));
                schoolCollege.setMajor8(request.getParameter("major8") == null ? null : URLDecoder.decode(request.getParameter("major8"), "UTF-8"));
                schoolCollege.setMajor9(request.getParameter("major9") == null ? null : URLDecoder.decode(request.getParameter("major9"), "UTF-8"));
                schoolCollege.setMajor10(request.getParameter("major10") == null ? null : URLDecoder.decode(request.getParameter("major10"), "UTF-8"));

                collegeCL.alterSchoolCollege(schoolCollege);
                request.getRequestDispatcher("SchoolManageServlet?type=query_school_colleges").forward(request, response);
            }else{
                request.getRequestDispatcher("/SchoolAdmin/schoolAdminLogin.jsp").forward(request, response);
            }
        }
	}
}
