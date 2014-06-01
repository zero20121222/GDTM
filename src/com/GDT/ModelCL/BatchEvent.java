package com.GDT.ModelCL;

import com.GDT.Interface.BatchEventInterface;
import com.GDT.Model.CommonSchoolUser;
import com.GDT.Model.SchoolUsersFile;
import com.GDT.util.DBConnection;
import com.GDT.util.DBConnectionInterface;
import com.google.common.base.Objects;
import com.google.common.collect.Lists;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

/**
 * Desc:批量处理操作
 * Mail:v@terminus.io
 * author:Michael Zhao
 * Date:2014-05-23.
 */
public class BatchEvent implements BatchEventInterface {
    private DBConnectionInterface connectObj = null;
    private PreparedStatement sta = null;
    private ResultSet res = null;

    @Override
    public int batchCreate(List<CommonSchoolUser> userList) {
        int batchNum = 0;
        String sql = "insert into 学生教师账号(学校Id,用户名,密码,头像,用户类型) values(?,?,?,?,?);";

        //过滤账号信息
        List<CommonSchoolUser> filterUser = Lists.newArrayList();
        if(userList == null || userList.isEmpty()){
            return batchNum;
        }

        //数据本身自查询过滤
        List<CommonSchoolUser> firstFilter = Lists.newArrayList();
        for(CommonSchoolUser user : userList){
            if(firstFilter.isEmpty()){
                firstFilter.add(user);
            }else{
                Boolean exist = false;
                for(CommonSchoolUser user1 : firstFilter){
                    if(Objects.equal(user.getUserName() , user1.getUserName())){
                        exist = true;
                        break;
                    }
                }
                if(!exist){
                    firstFilter.add(user);
                }
            }
        }


        //数据库查询过滤
        for(CommonSchoolUser user : firstFilter){
            if(!checkExisted(user)){
                filterUser.add(user);
            }
        }

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql);

            for(CommonSchoolUser user : filterUser){
                sta.setInt(1, user.getSchoolId());
                sta.setString(2, user.getUserName());
                sta.setString(3, user.getUserPassword());
                sta.setString(4, user.getUserHead());
                sta.setString(5, user.getUserType());

                //批量插入操作
                sta.addBatch();
            }

            sta.executeBatch();
            batchNum = filterUser.size();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return batchNum;
    }

    @Override
    public Boolean updateUserFile(SchoolUsersFile usersFile, int batchNum) {
        Boolean update = false;
        String sql = "update 学校数据源文件 set 是否已导入=?,成功导入数量=? where id=?;";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql);

            sta.setString(1, "T");
            sta.setInt(2, batchNum);
            sta.setInt(3, usersFile.getId());

            update = sta.executeUpdate() == 1 ? true : false;
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return update;
    }

    /**
     * 过滤操作，判断用户名是否已存在
     * @param commonSchoolUser  用户信息
     * @return  Boolean
     * 返回用户名是否已存在
     */
    private Boolean checkExisted(CommonSchoolUser commonSchoolUser){
        Boolean existed = false;

        String sql = "select Id from 学生教师账号 where 学校Id=? and 用户名=?";

        try{
            connectObj = new DBConnection();
            connectObj.getConnection();
            sta = connectObj.getStatement(sql);
            sta.setInt(1, commonSchoolUser.getSchoolId());
            sta.setString(2 , commonSchoolUser.getUserName());

            res = connectObj.getQueryResultSet();

            existed = res.next();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            connectObj.close();
        }

        return existed;
    }
}
