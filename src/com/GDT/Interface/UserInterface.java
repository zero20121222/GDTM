package com.GDT.Interface;

/**
 * 这个是用于表示全部用户的公共接口对象的
 * @author zero
 * 用户通用接口对象
 */
public interface UserInterface{
	/**
	 * 查询用户名是否存在(这个学生或者教师不需要处理->学生和教师账号可以重复)
	 * @param name
	 * 需要验证的用户名
	 * @return Boolean
	 * 返回验证结果 true:存在，false:不存在
	 */
	public Boolean ifUseName(String name);
	
	/**
	 * 获取用户真实姓名
	 * @param userId
	 * 用于检索用户的详细信息
	 * @return String
	 * 返回检索得到的用户真实姓名
	 */
	public String queryTrueName(int userId);
	
	/**
	 * 判断用户是否已经输入用户的详细信息
	 * @param userId
	 * 需要验证的用户编号
	 * @return Boolean
	 * 返回用户是否以输入详细信息结果
	 */
	public Boolean ifDetail(int userId);
	
	/**
	 * 删除用户
	 * @param id
	 * 需要删除的用户编号
	 * @return Boolean
	 * 返回数据用户删除是否成功 true:成功,false:失败
	 */
	public Boolean doDelete(int id);
	
	/**
	 * 查询用户信息
	 * @param id
	 * 作为查询用户的编号输入信息
	 * @return String
	 * 返回该用户的详细信息的字符串以JSON格式表示
	 */
	public String queryUserInfor(int id);
	
	/**
	 * 验证用户密码是否相同(当用户需要更改密码前)
	 * @param id
	 * 用户编号
	 * @param password
	 * 用户密码
	 * @return Boolean
	 * 返回用户密码与输入密码是否相同 true:相同,false:不相同
	 */
	public Boolean checkPassword(int id, String password);
	
	/**
	 * 将按照用户编号以及输入的密码更改用户密码信息
	 * @param id
	 * 用户编号
	 * @param password
	 * 用户重新输入的密码
	 * @return Boolean
	 * 返回用户密码更改是否成功	true:成功,false:失败
	 */
	public Boolean alterPassword(int id, String password);
	
	/**
	 * 按照用户编号以及输入的用户头像信息更改用户的头像信息
	 * @param id
	 * 用户编号
	 * @param head
	 * 用户的头像图片名称
	 * @return Boolean
	 * 返回用户头像信息更改是否成功 true:成功,false:失败
	 */
	public Boolean alterHead(int id, String head);
}
