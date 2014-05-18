package com.GDT.dwrTools;

import java.util.List;
import java.util.Map;

import com.GDT.Factory.PagingManageFactory;
import com.GDT.Interface.DWRProjectPagingInterface;
import com.GDT.Interface.PagingManageFactoryInterface;
import com.GDT.Interface.ProjectPagingInterface;
import com.GDT.Model.ProjectInfor;

/**
 * 课题分页操作处理的操作处理对象
 * @author zero
 */
public class DWRProjectPageing implements DWRProjectPagingInterface{
	/**
	 * 返回分页数据信息(根据用户名编号->这里指的是教师编号)
	 * @see com.GDT.Interface.DWRProjectPagingInterface#pagingByCreateId(int, int, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByCreateId(int pageNow, int createrId, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging(pageNow);
		
		return projectPaging.pagingByCreateId(createrId, pagingType, graduateYear);
	}

	public String pagingByCreatIdJSON(int pageNow, int createrId, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging(pageNow);
		
		return projectPaging.pagingByCreatIdJSON(createrId, pagingType, graduateYear);
	}

	public Map<String, Integer> getPageNumberByCreateId(int createrId, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging();
		
		return projectPaging.getPageNumberByCreateId(createrId, pagingType, graduateYear);
	}

	
	/**
	 * 返回分页数据信息(根据学校编号)
	 * @see com.GDT.Interface.DWRProjectPagingInterface#pagingBySchoolId(int, int, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingBySchoolId(int pageNow, int schoolId,
			String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging(pageNow);
		
		return projectPaging.pagingBySchoolId(schoolId, pagingType, graduateYear);
	}

	public String pagingBySchoolIdJSON(int pageNow, int schoolId,
			String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging(pageNow);
		
		return projectPaging.pagingBySchoolIdJSON(schoolId, pagingType, graduateYear);
	}

	public Map<String, Integer> getPageNumberBySchoolId(int schoolId,
			String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging();
		
		return projectPaging.getPageNumberBySchoolId(schoolId, pagingType, graduateYear);
	}
	
	/**
	 * 返回分页数据信息(根据出题人)
	 * @see com.GDT.Interface.DWRProjectPagingInterface#pagingByCreateName(int, int, java.lang.String, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByCreateName(int pageNow, int schoolId,
			String createrName, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging(pageNow);
		
		return projectPaging.pagingByCreateName(schoolId, createrName, pagingType, graduateYear);
	}

	public String pagingByCreateNameJSON(int pageNow, int schoolId,
			String createrName, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging(pageNow);
		
		return projectPaging.pagingByCreateNameJSON(schoolId, createrName, pagingType, graduateYear);
	}

	public Map<String, Integer> getPageNumberByCreateName(int schoolId,
			String createrName, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging();
		
		return projectPaging.getPageNumberByCreateName(schoolId, createrName, pagingType, graduateYear);
	}

	
	/**
	 * 返回分页数据信息(根据学院名称)
	 * @see com.GDT.Interface.DWRProjectPagingInterface#pagingByCollege(int, int, java.lang.String, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByCollege(int pageNow, int schoolId,
			String collegeName, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging(pageNow);
		
		return projectPaging.pagingByCollege(schoolId, collegeName, pagingType, graduateYear);
	}

	public String pagingByCollegeJSON(int pageNow, int schoolId,
			String collegeName, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging(pageNow);
		
		return projectPaging.pagingByCollegeJSON(schoolId, collegeName, pagingType, graduateYear);
	}

	public Map<String, Integer> getPageNumberByCollege(int schoolId,
			String collegeName, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging();
		
		return projectPaging.getPageNumberByCollege(schoolId, collegeName, pagingType, graduateYear);
	}
	
	
	/**
	 * 返回分页数据信息(根据课题名称)
	 * @see com.GDT.Interface.DWRProjectPagingInterface#pagingByProjectName(int, int, java.lang.String, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByProjectName(int pageNow, int schoolId,
			String projectName, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging(pageNow);
		
		return projectPaging.pagingByProjectName(schoolId, projectName, pagingType, graduateYear);
	}

	public String pagingByProjectNameJSON(int pageNow, int schoolId,
			String projectName, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging(pageNow);
		
		return projectPaging.pagingByProjectNameJSON(schoolId, projectName, pagingType, graduateYear);
	}

	public Map<String, Integer> getPageNumberByProjectName(int schoolId,
			String projectName, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging();
		
		return projectPaging.getPageNumberByProjectName(schoolId, projectName, pagingType, graduateYear);
	}

	
	/**
	 * 返回分页数据信息(根据参与人数)
	 * @see com.GDT.Interface.DWRProjectPagingInterface#pagingByPartNum(int, int, int, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByPartNum(int pageNow, int schoolId,
			int partNum, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging(pageNow);
		
		return projectPaging.pagingByPartNum(schoolId, partNum, pagingType, graduateYear);
	}

	public String pagingByPartNumJSON(int pageNow, int schoolId, int partNum,
			String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging(pageNow);
		
		return projectPaging.pagingByPartNumJSON(schoolId, partNum, pagingType, graduateYear);
	}

	public Map<String, Integer> getPageNumberByPartNum(int schoolId,
			int partNum, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging();
		
		return projectPaging.getPageNumberByPartNum(schoolId, partNum, pagingType, graduateYear);
	}

	
	/**
	 * 返回分页数据信息(根据难易程度)
	 * @see com.GDT.Interface.DWRProjectPagingInterface#pagingByHardNum(int, int, int, java.lang.String)
	 * @author zero
	 */
	public List<ProjectInfor> pagingByHardNum(int pageNow, int schoolId,
			int hardNum, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging(pageNow);
		
		return projectPaging.pagingByHardNum(schoolId, hardNum, pagingType, graduateYear);
	}

	public String pagingByHardNumJSON(int pageNow, int schoolId, int hardNum,
			String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging(pageNow);
		
		return projectPaging.pagingByHardNumJSON(schoolId, hardNum, pagingType, graduateYear);
	}

	public Map<String, Integer> getPageNumberByHardNum(int schoolId,
			int hardNum, String pagingType, int graduateYear) {
		PagingManageFactoryInterface factory = new PagingManageFactory();
		ProjectPagingInterface projectPaging = factory.createProjectPaging();
		
		return projectPaging.getPageNumberByHardNum(schoolId, hardNum, pagingType, graduateYear);
	}

}
