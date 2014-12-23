<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@page import="com.asiainfo.aiga.common.CommonUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="UTF-8"%>

    <%String planId=request.getParameter("planId"); 
    String taskId=request.getParameter("taskId");
    boolean isShowTask=(taskId!=null&& !taskId.equals(""));
    boolean isShowPlan=(planId!=null&& !planId.equals(""));
    AigaUser user=CommonUtil.getSessionUser(request);
    %>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/extJs/resources/css/ext-all.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/ext-all.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/plugin/DateTimePicker.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/plugin/DateTime.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/ext.bug.fix.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/base/jquery-1.8.0.js" ></script>
	<title>日报</title>
	<style type="text/css">
		#uploadForm-body table {
			float: left;
		}
		
		#uploadForm-body div {
			float: left;
		}
	</style>
</head>
<body>
</body>

<script type="text/javascript">
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	var win;  
	var winElm;  
	namespace('com.dfe.iss.jmsg');  
	com.dfe.iss.jmsg.moveWin = Ext.extend(Ext.Window, {  
	            border : false,  
	            shadow : false,  
	            closeAction : 'hide',  
	            title : '消息内容',  
	            id : 'MsgWin',  
	            x : 0,  
	            y : 0,  
	            // 以下自定义属性，可以在外部定义  
	            moveSpeed : 12, // 移动速度(越大越慢),想改变，可是不行，  
	            winStep : 2, // 移动变量(像素),想改变，可是不行，  
	            stopTime : 60,//1为一秒          
	            // 以下自定义属性，请不要在外部定义  
	            winYtop : 0,  
	            winYbom : 0,  
	            winYtmp : 0,  
	            stopT : 0,  
	            initComponent : function() {  
	                var self = this;  
	                this.listeners = {  
	                    'afterrender' : {  
	                        fn : function() {  
	                            win = Ext.getCmp(this.id);  
	                            winElm = Ext.get(this.id);  
	                            Ext.TaskMgr.start({  
	                                run : function(){  
	                                    if(self.winYtmp>=self.winYtop){  
	                                        if(self.hidden == true)  
	                                            self.show();  
	                                        Ext.TaskMgr.start(self.upTask);  
	                                    }else{  
	                                        Ext.TaskMgr.start(self.downTask);  
	                                    }  
	                                },  
	                                interval : self.stopT  
	                            });  
	                        },  
	                        scope : self  
	                    }  
	                };  
	                if (this.width) {  
	                    this.x = document.body.clientWidth-this.width;  
	                }  
	                if (this.height) {  
	                    this.y = document.body.clientHeight;  
	                    this.winYtop = document.body.clientHeight - this.height;  
	                    this.winYbom = document.body.clientHeight;  
	                    this.winYtmp = document.body.clientHeight;  
	                }  
	                if(this.stopTime){  
	                    this.stopT = this.stopTime*1000;  
	                }  
	                com.dfe.iss.jmsg.moveWin.superclass.initComponent.call(this);  
	            },  
	            upTask : {  
	                run: function(){  
	                    if(win.winYtmp>=win.winYtop){  
	                        winElm.moveTo(win.x,win.winYtmp);  
	                        win.winYtmp = win.winYtmp - win.winStep;                  
	                    }else{  
	                        winElm.moveTo(win.x,win.winYtop);  
	                        Ext.TaskMgr.stop(this);  
	                    }  
	                },  
	                interval : 12  
	            },  
	            downTask :{  
	                run : function(){  
	                    if(win.winYtmp<=win.winYbom){  
	                        winElm.moveTo(win.x,win.winYtmp);  
	                        win.winYtmp = win.winYtmp + win.winStep;  
	                    }else{  
	                        winElm.moveTo(win.x,win.winYbom);  
	                        Ext.TaskMgr.stop(this);  
	                        win.hide();  
	                    }  
	                },  
	                interval : 12  
	            },  
	            winResize : function(){  
	                var yChange = win.winYbom - document.body.clientHeight;  
	                win.x = document.body.clientWidth-win.width;  
	                win.winYtop = win.winYtop - yChange;  
	                win.winYbom = win.winYbom - yChange;  
	                win.winYtmp = win.winYtmp - yChange;  
	                winElm.moveTo(win.x,win.winYtmp);  
	            }  
	        }); 
});
</script>
</html>