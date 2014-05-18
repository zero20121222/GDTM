package com.GDT.Factory;

import com.GDT.Interface.PagingManageFactoryInterface;
import com.GDT.Interface.ProjectPagingInterface;
import com.GDT.ModelCL.ProjectInforCL;

public class PagingManageFactory implements PagingManageFactoryInterface{
	/**
	 * 创建一个课题分页操作处理对象
	 * @author zero
	 */
	public ProjectPagingInterface createProjectPaging(){
		return new ProjectInforCL();
	}
	
	/**
	 * 创建一个课题分页操作处理对象
	 * @author zero
	 */
	public ProjectPagingInterface createProjectPaging(int pageNow) {
		return new ProjectInforCL(pageNow);
	}
}
