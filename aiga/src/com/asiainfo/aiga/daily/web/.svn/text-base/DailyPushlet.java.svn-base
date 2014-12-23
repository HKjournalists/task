package com.asiainfo.aiga.daily.web;

import java.io.Serializable;
import java.sql.Date;

import javax.annotation.Resource;

import nl.justobjects.pushlet.core.Event;
import nl.justobjects.pushlet.core.EventPullSource;

import com.asiainfo.aiga.gui.service.IAigaGuiSV;

@SuppressWarnings("serial")
public class DailyPushlet extends EventPullSource implements Serializable {
	@Resource(name="aigaGuiSV")
	private IAigaGuiSV aigaGuiSV;
    /**
     * 设置休眠时间
     */
    @Override
    protected long getSleepTime() {
        return 5000;
    }

    /**
     * 创建事件
     * 
     * 业务部分写在pullEvent()方法中，这个方法会被定时调用。
     */
    @Override
    protected Event pullEvent() {
//    	System.out.println("---------------->"+new Date(System.currentTimeMillis()).toGMTString());
        Event event = Event.createDataEvent("/linjiqin/hw");
        event.setField("hw", "---------------->"+new Date(System.currentTimeMillis()).toGMTString());
        return event;
    }

}