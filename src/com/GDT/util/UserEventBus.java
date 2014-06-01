package com.GDT.util;

import com.google.common.eventbus.AsyncEventBus;
import com.google.common.eventbus.EventBus;

import java.util.concurrent.Executors;

/**
 * Desc:事件注册处理
 * Mail:v@terminus.io
 * author:Michael Zhao
 * Date:2014-05-09.
 */
public class UserEventBus {

    private final AsyncEventBus asyncEventBus;

    public UserEventBus() {
        //初始化线程池
        this.asyncEventBus = new AsyncEventBus(Executors.newFixedThreadPool(3));
    }


    public void register(UserEvents eventObj) {
        asyncEventBus.register(eventObj);
    }


    public void post(Object object) {
        asyncEventBus.post(object);
    }


    public void unregister(UserEvents eventObj) {
        asyncEventBus.unregister(eventObj);
    }
}
