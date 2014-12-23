<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/aiga/common/common.jsp" %>
    <% 
        String planId=request.getParameter( "planId");
    	String taskId=request.getParameter( "taskId");
    	String planTag=request.getParameter( "planTag"); 
        //0 创建 1查看 2 编辑 3关联 4导入excel 5 有工具栏的搜索 6 根据planId来搜索  7 任务排期页面
        String flag=request.getParameter( "flag"); 
        boolean isShowTask=(taskId!=null&& !taskId.equals( "")); 
        boolean isFlag=(flag!=null&& !flag.equals( "")); 
        boolean isShowPlan=(planId!=null&& !planId.equals( ""));
        AigaUser user=( AigaUser)request.getSession().getAttribute( "aigaUser"); 
        %>
<html>
    
    <head>
        <title>任务单查询</title>
        <style type="text/css">
            #uploadForm-body table {
                float: left;
            }
            #uploadForm-body div {
                float: left;
            }
            .red {
                color:red;
            }
        </style>
        <script type="text/javascript" src="<%=request.getContextPath()%>/extJs/ux/data/PagingMemoryProxy.js"></script>
    </head>
    
    <body>
        <jsp:include page="/aiga/workflow/common/SelectStaff.jsp"></jsp:include>
    </body>
    <script type="text/javascript">
    var staffSelect="";
    var optionHtml="<option value=''></option>";
        var planId = "${param.planId}";
        var taskId = "${param.taskId}";
        var planTag = "${param.planTag}";
        var extjsFolderPath = '<%=request.getContextPath()%>/extJs';
        var screenWidth = document.documentElement.clientWidth;
        var screenHeight = document.documentElement.clientHeight;
        var afterSelect = function (staffs, option) {
        	Ext.getCmp("tbarDistributeStaffname").setValue(staffs.employeeName);
        }
            function removeHTMLTag(str) {
                str = str.replace(/<\/?[^>]*>/g, ''); //去除HTML tag
                str = str.replace(/[ | ]*\n/g, '\n'); //去除行尾空白
                str = str.replace(/&nbsp;/ig, ''); //去掉&nbsp;
                return str;
            }

            function getArrayBycategoryName(categoryName) {
                var records = new Array();
                $.getJSON("<%=request.getContextPath()%>/getComBoxMap.do", {}, function (data) {
                    records = data.data;
                    var bigArray = new Array();
                    for (var i = 0, n = records.length; i < n; i++) {
                        if (records[i].categoryName == categoryName) {
                            var subArray = new Array();
                            subArray.push(records[i].value);
                            subArray.push(records[i].show);
                            bigArray.push(subArray);
                        }
                    }
                    return bigArray;
                });

            }
            
            function rightClickTargetFn(view,record,item,index,e,eOpts){   
             	e.preventDefault();   
            	rightTargetReportMenu.showAt(e.getXY());
            }
            var rightTargetReportMenu = new Ext.menu.Menu({
            items: [
            {
            	id:'editTask',
                text: '清除所选计划排期',
                handler: function(){
                 	var currentGridRowModels=Ext.getCmp('taskGrid').getSelectionModel().getSelection();
                	if(currentGridRowModels.length!=1){
                		Ext.Msg.alert("提示","选择错误!");
                	}else{
                		currentGridRowModels[0].set('planId',null);
            			currentGridRowModels[0].set('planTag',null);
            			currentGridRowModels[0].set('planName',null);
            			currentGridRowModels[0].set('factCompleteTime',null);
                	}
                	
                }
                }]
            });
        Ext.onReady(function () {
            Ext.QuickTips.init();
            Ext.tip.QuickTipManager.init();
            var dateFormat = Ext.Date.format(new Date, 'YmdHisu');
            taskTag = "TT" + dateFormat;
            var taskStore = Ext.create('Ext.data.Store', {
                storeId: 'taskStore',
                pageSize: 2, // 指定每页显示2条记录  
                // 使用proxy指定加载本地数据  
                proxy: {  
                    type: 'ajax', // 指定使用PagingMemoryProxy控制读取内存数据  
                    url: '<%=request.getContextPath()%>/getTestTaskList.do',
                    data: null,  
                    reader: {  
                        type: 'json',  
                        root: 'data', // 直接读取users数据  
                        totalProperty: 'total' // total属性值代表了总记录条数  
                    }  
                }, 
                fields: [
                         {
                        name: 'taskName',
                        type: 'string'
                    },{
                        name: 'taskId',
                        type: 'string'
                    }
                ]
            });
            MaskLoading();
        	Ext.Ajax.request({ 
        		method:'POST',
        		url:"<%=request.getContextPath()%>/getTestTaskList.do?taskFlag=7",
        		success:function(response,config){
        		MaskOver();
        			var obj= Ext.decode(response.responseText);//obj储存响应的数据 
            		//console.log(obj);
            		var data = {  
            		        data: [],
            		        total:'' 
            		    };
            		data.data=obj;
            		data.total=obj.length;
            	
            		var proxy = Ext.create('Ext.ux.data.PagingMemoryProxy', {
       				 	type: 'pagingmemory', // 指定使用PagingMemoryProxy控制读取内存数据  
       		            data: data,  
       		            reader: {  
       		                type: 'json',  
       		                root: 'data', // 直接读取users数据  
       		                totalProperty: 'total' // total属性值代表了总记录条数  
       		            }  
       				 });
            		taskStore.setProxy(proxy);
            		//taskStore.proxy.data=data;
            		//console.log(taskStore.getProxy() );
            		taskStore.load({params:{start:0,limit:5}});//按5条记录分布 
        			
        		},
        		failure:function(response,config){
        			MaskOver();
        			Ext.Msg.alert('提示','保存失败');
        		}
        	});
            var taskGrid = Ext.create('Ext.grid.Panel', {
                id: 'taskGrid',
                cls: 'ui-formPanel',
                title: '任务单列表',
                margins: '0 0 0 3',
                height: screenHeight*0.99*0.89,
                width: screenWidth*0.998,
                
                /**
        		**编辑插件
        		**/
        		plugins:[
        			Ext.create('Ext.grid.plugin.CellEditing', {
                    triggerEvent:'cellclick'
                })],
                forctFit: true,
                stripeRows: true,
                loadMask: true,
                store: taskStore,
                selType: 'rowmodel',
                bbar:new Ext.PagingToolbar({//工具栏 
                	pageSize:5, 
                	store:  taskStore, 
                	displayInfo:true, 
                	displayMsg:'From {0} To {1} records,all records are {2} ', 
                	emptyMsg:"no records" 
                	}), 
                listeners:{
                	itemcontextmenu: rightClickTargetFn
                } ,
                columns: [
                        new Ext.grid.RowNumberer(), 
                        {
                            header: "测试任务名称",
                            width: 300,
                            sortable: true,
                            dataIndex: 'taskName'
                        },
                        {
                            header: "测试组长",
                            width: 100,
                            sortable: true,
                            dataIndex: 'distributeStaffname'
                        }
                       
               
               
                ]
            });
            Ext.create('Ext.Panel', {
                renderTo: Ext.getBody(),
                cls: 'ui-formPanel',
                width: screenWidth * 0.99,
                height: screenHeight * 0.99,
                layout: {
                    type: 'hbox',
                    align: 'stretch',
                    padding: 0
                },
                defaults: {
                    split: true,
                    collapsible: false,
                    bodyStyle: 'padding:0px'
                },
                items: [{
                        region: 'center',
                        items:[taskGrid]
                        
                    }
                ]
            })
            });
    </script>
<script type="text/javascript">

</script>
</html>