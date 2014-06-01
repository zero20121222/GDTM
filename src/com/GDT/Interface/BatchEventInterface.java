package com.GDT.Interface;

import com.GDT.Model.CommonSchoolUser;
import com.GDT.Model.SchoolUsersFile;

import java.util.List;

/**
 * Desc:批量处理事件
 * Mail:v@terminus.io
 * author:Michael Zhao
 * Date:2014-05-23.
 */
public interface BatchEventInterface {
    /**
     * 批量创建基本用户信息
     * @param userList  基本数据对象
     * @return int
     * 返回创建的数据条数
     */
    public int batchCreate(List<CommonSchoolUser> userList);

    /**
     * 将成功导入的用户数据保存到导入文件记录中
     * @param usersFile 用户资源文件
     * @param batchNum  一共导入的数量
     * @return  Boolean
     * 导入是否成功
     */
    public Boolean updateUserFile(SchoolUsersFile usersFile, int batchNum);
}
