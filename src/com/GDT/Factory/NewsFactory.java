package com.GDT.Factory;

import com.GDT.Interface.NewsFactoryInterface;
import com.GDT.Interface.STNewsInterface;
import com.GDT.Interface.SchoolNewInterface;
import com.GDT.ModelCL.NewInforCL;
import com.GDT.ModelCL.SchoolNewCL;

/**
 * 信息处理类创建工厂
 * @author zero
 */
public class NewsFactory implements NewsFactoryInterface{
	
	/**
	 * @see com.GDT.Interface.NewsFactoryInterface#createSchoolNewCL()
	 * 创建一个SchoolNewCL对象类用于学校信息处理
	 */
	public SchoolNewInterface createSchoolNewCL() {
		return new SchoolNewCL();
	}
	
	/**
	 * @see com.GDT.Interface.NewsFactoryInterface#createNewInforCL()
	 * 创建一个NewInforCL对象类用于个人的最新信息的处理操作
	 */
	public STNewsInterface createNewInforCL() {
		return new NewInforCL();
	}

}
