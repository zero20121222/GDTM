package com.GDT.util;

import com.GDT.Model.CommonSchoolUser;
import com.GDT.Model.SchoolNew;
import com.GDT.Model.SchoolUsersFile;
import com.GDT.ModelCL.BatchEvent;
import com.google.common.base.Strings;
import com.google.common.eventbus.Subscribe;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.annotation.PostConstruct;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;
import java.io.IOException;
import java.util.List;

/**
 * Desc:需求事件处理
 * Mail:v@terminus.io
 * author:Michael Zhao
 * Date:2014-05-09.
 */
public class UserEventHandler implements UserEvents {
    private final Log log = LogFactory.getLog(this.getClass());

    private final AnalyzeExcel analyzeExcel = new AnalyzeExcel();

    private final BatchEvent batchEvent = new BatchEvent();

    private final TransformWord transformWord = new TransformWord();

    @Subscribe
    @Override
    public void analyzeEvent(final SchoolUsersFile usersFile){

        log.debug("analyze requirement module excel file.");
        //解析excel信息到对象中
        List<CommonSchoolUser> commonSchoolUsers = analyzeExcel.analyzePath(usersFile.getFilePath() , 1, new AnalyzeExcel.AnalyzeAction<CommonSchoolUser>() {
            @Override
            public CommonSchoolUser transform(String[] info) {
                CommonSchoolUser userInfo = new CommonSchoolUser();
                try{
                    //学校编号
                    userInfo.setSchoolId(usersFile.getSchoolId());
                    for (int i = 0; i < info.length; i++) {
                        //信息不能为空有一个为空就返回一个null
                        if(Strings.isNullOrEmpty(info[i])){
                            return null;
                        }

                        switch (i){
                            case 0:

                                userInfo.setUserName(info[i].split("\\.")[0]); break;
                            case 1:
                                userInfo.setUserPassword(info[i].split("\\.")[0]); break;
                            case 2:
                                userInfo.setUserHead(info[i]); break;
                            case 3:
                                userInfo.setUserType(info[i]); break;
                        }
                    }
                }catch(NumberFormatException e){
                    log.error("transform excel info to object failed, error code={}", e);
                }catch(Exception e){
                    log.error("transform excel info to object failed, error code={}", e);
                }

                return userInfo;
            }
        });
        log.debug("transform school user excel success.");

        //将用户信息批量保存到数据库
        int batchNum = batchEvent.batchCreate(commonSchoolUsers);
        log.debug("create school user success.");

        //导入数据的信息记录
        batchEvent.updateUserFile(usersFile , batchNum);

        //创建通知信息
    }

    @Subscribe
    @Override
    public void transformWord(SchoolNew schoolNew) {
        log.debug("transform word file to html.");
        String schoolPath = FileUploadCL.queryFilePath(schoolNew.getRealPath() , "Schoolinfor", schoolNew.getSchoolId()+"", "News");
        String wordFile = FileUploadCL.queryFilePath(schoolPath , schoolNew.getContentFile());

        //保存的html的文档路径
        String saveFileName = null;
        if(schoolNew.getContentFile().indexOf(".doc") != -1){
            saveFileName = schoolNew.getContentFile().replace(".doc" , ".html");
            //saveFileName = FileUploadCL.stringASCII(saveFileName) + ".html";
        }

        String saveFile = FileUploadCL.queryFilePath(schoolPath , saveFileName);

        try {
            //转换文件
            transformWord.convertHtml(wordFile , saveFile, schoolPath);
        } catch (TransformerException e) {
            log.error("transform word to html failed, error code={}", e);
        } catch (IOException e) {
            log.error("transform word to html failed, error code={}", e);
        } catch (ParserConfigurationException e) {
            log.error("transform word to html failed, error code={}", e);
        }
    }
}
