package com.GDT.util;

import com.GDT.Model.SchoolNew;
import com.GDT.Model.SchoolUsersFile;

/**
 * Desc:需求eventBus处理事件
 * Mail:v@terminus.io
 * author:Michael Zhao
 * Date:2014-05-23.
 */
public interface UserEvents {
    /**
     * 通过订阅文件导入操作事件，当创建成功时会回调解析excel。并且将数据导入DB
     * @param usersFile 学校数据源文件对象
     */
    public void analyzeEvent(SchoolUsersFile usersFile);

    /**
     * 对学校上传的公告信息进行解析处理
     * @param schoolNew 公告信息对象
     */
    public void transformWord(SchoolNew schoolNew);
}
