package com.GDT.Interface;

/**
 * 分页处理对象类工厂接口
 * @author zero
 */
public interface PagingManageFactoryInterface {
	/**
	 * 创建一个课题分页操作处理对象
	 * @author zero
	 * @return ProjectPagingInterface
	 * 返回一个处理对象接口
	 */
	public ProjectPagingInterface createProjectPaging();
	
	/**
	 * 创建一个课题分页操作处理对象
	 * @param pageNow
	 * 构造一个需要跳转的页面编号
	 * @author zero
	 * @return ProjectPagingInterface
	 * 返回一个处理对象接口
	 */
	public ProjectPagingInterface createProjectPaging(int pageNow);
}
