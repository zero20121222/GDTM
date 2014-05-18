package com.GDT.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * 用于分装GDT中的java.sql.Date与java.util.date之间的转化操作
 * (原因在sql语句中只能使用java.sql.Date而不能使用java.util.date)
 * @author zero
 */
public class GDTDate {
	public static final int DATE_YEAR = 1;		//时间年份
	public static final int DATE_MONTH = 2;		//时间月份
	public static final int DATE_DAY = 3;		//时间天
	private String dateTime;
	
	public GDTDate(){}
	
	public GDTDate(String dateTime){
		this.dateTime = dateTime;
	}

	public String getDateTime() {
		return dateTime;
	}

	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}
	
	/**
	 * 得到一个当前的系统时间
	 * @return java.sql.Date
	 * 返回sql类型的时间
	 */
	public static java.sql.Date getSqlDate(){
		java.util.Date nowTime = new java.util.Date();
		
		return new java.sql.Date(nowTime.getTime());
	}
	
	/**
	 * 得到一个当前的系统时间
	 * @return java.util.Date
	 * 返回util类型的时间
	 */
	public static java.util.Date getUtilDate(){
		return new java.util.Date();
	}
	
	/**
	 * 将输入的时间转换成对应的yyyy-MM-dd的格式
	 * @param dateTime
	 * 需要转换的java.util.Date时间
	 * @return String
	 * 转换成字符串格式
	 */
	public static String formatDateTimeString(java.util.Date dateTime){
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		return formatter.format(dateTime);
	}
	
	/**
	 * 将输入的时间转换成对应的yyyy-MM-dd的格式
	 * @param dateTime
	 * 需要转换的java.sql.Date时间
	 * @return String
	 * 转换成字符串格式
	 */
	public static String formatDateTimeString(java.sql.Date dateTime){
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		return formatter.format(dateTime);
	}
	
	/**
	 * 实现将字符串的时间格式更改为yyyy-MM-dd的形式
	 * @param dateTime
	 * 需要转化的字符串
	 * @return java.util.Date
	 * 返回一个时间对象
	 */
	public static java.util.Date formatUtilDate(String dateTime){
		java.util.Date formatDate = null;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		try {
			formatDate = formatter.parse(dateTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return formatDate;
	}
	
	/**
	 * 实现将字符串的时间格式更改为yyyy-MM-dd的形式
	 * @param dateTime
	 * 需要转化的字符串
	 * @return java.sql.Date
	 * 返回一个时间对象
	 */
	public static java.sql.Date formatSqlDate(String dateTime){
		java.sql.Date formatDate = null;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		try {
			formatDate = new java.sql.Date(formatter.parse(dateTime).getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return formatDate;
	}
	
	/**
	 * 根据不同的查询类型得到相对应的查询数据信息内容
	 * @param type
	 * 查询类型(DATE_YEAR,DATE_MONTH,DATE_DAY)
	 * @param dateTime
	 * 需要查询的时间对象
	 * @return int
	 * 返回需要查询的信息
	 */
	public static int getUtilDateInfor(int type , java.util.Date dateTime){
		int time = 0;
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dateTime);
		
		switch(type){
			case DATE_YEAR:{
				time = calendar.get(DATE_YEAR);
				break;
			}
			case DATE_MONTH:{
				time = calendar.get(DATE_MONTH);
				break;
			}
			case DATE_DAY:{
				time = calendar.get(DATE_DAY);
				break;
			}
		}
		
		return time;
	}
	
	/**
	 * 根据不同的查询类型得到相对应的查询数据信息内容
	 * @param type
	 * 查询类型(DATE_YEAR,DATE_MONTH,DATE_DAY)
	 * @param dateTime
	 * 需要查询的时间对象
	 * @return int
	 * 返回需要查询的信息
	 */
	public static int getSqlDateInfor(int type , java.sql.Date dateTime){
		int time = 0;
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dateTime);
		
		switch(type){
			case DATE_YEAR:{
				time = calendar.get(DATE_YEAR);
				break;
			}
			case DATE_MONTH:{
				time = calendar.get(DATE_MONTH);
				break;
			}
			case DATE_DAY:{
				time = calendar.get(DATE_DAY);
				break;
			}
		}
		
		return time;
	}
}
