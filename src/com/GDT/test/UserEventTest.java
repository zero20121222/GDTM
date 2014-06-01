package com.GDT.test;

import com.GDT.Model.SchoolUsersFile;
import com.GDT.util.FileUploadCL;
import com.GDT.util.UserEventBus;
import com.GDT.util.UserEventHandler;

/**
 * Desc:
 * Mail:v@terminus.io
 * author:Michael Zhao
 * Date:2014-05-24.
 */
public class UserEventTest {
    public static void main(String[] args){
        String filePath = "savePath/Users/MichaelZhao/Documents/SchoolProject/GDTM/WebRoot/";
        if(filePath.lastIndexOf("/") == filePath.length()-1){
            System.out.println(filePath.substring(0 , filePath.length()-1));
        }

        String info = "zero0";
        System.out.println(info.split("\\.")[0]);

        String test = "word.doc";
        String saveFileName = test.replaceAll("\\.doc", "\\.html");
        System.out.print(test.indexOf(".doc"));

        System.out.println(FileUploadCL.stringASCII("201002105130（赵宇－毕业设计指导与管理平台--指导与进度管理的分析与设计）4"));
    }
}
