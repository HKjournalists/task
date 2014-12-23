<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.WorkflowParam,com.asiainfo.aiga.common.IStakeholderType,com.asiainfo.aiga.common.ConstDefine,com.asiainfo.aiga.common.IObjectType"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");%>
<%@ include file="/aiga/common/common.jsp" %>
<%
 %>
<html>
<head>
	<title>版本测试任务搜索</title>
</head>
	<body >
		<div id="searchParam"></div>
		<div>
			<jsp:include page="/aiga/workflow/testPlan/TestSolidTaskList.jsp">
			<jsp:param value="search" name="flag"/>
			</jsp:include>
		</div>
		
     </body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function(){
	var StaffRoleViewModel = Ext.define('StaffRoleViewModel', {
        extend: 'Ext.data.Model',
        fields: [{
                name: 'staffId',
                type: 'string'
            },{
                name: 'staffCode',
                type: 'string'
            }, {
                name: 'staffName',
                type: 'string'
            }, {
                name: 'roleCode',
                type: 'string'
            }, {
                name: 'organizeId',
                type: 'string'
            }, {
                name: 'organizeName',
                type: 'string'
            }, {
                name: 'parentOrganizeId',
                type: 'string'
            }, {
                name: 'staffWorkdayCoefficient',
                type: 'int'
            }
        ]
    });
    Ext.define('subTaskStaffsModel', {
        extend: 'Ext.data.Model',
        fields: ['taskId', 'staffNames','staffIds']
    });
    var subTaskStaffsStore= new Ext.data.Store({
        id: 'subTaskStaffsStore',
        model:subTaskStaffsModel
        
    });
	
    var StaffRoleViewStore = new Ext.data.Store({
        id: 'StaffRoleViewStore',
        model: StaffRoleViewModel,
        proxy: {
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getStaffRoleViews.do?staffId=<%=user.getUserId()%>&roleCode=WF_NTEST_MGR',
            reader: {
                type: 'json',
                root: 'data'
            }
        },
		listeners:{
            load : function(store, records, options ){
        	       StaffRoleViewStore.each(function(record){
				   record.set('displayName',record.get('staffCode')+':'+record.get('staffName'));
			       });
            	var rs = Ext.create("EmptyStaff");
                store.insert(0,rs);  
                return true;
            }
		}
    });
    StaffRoleViewStore.load({params:{staffId:'<%=user.getUserId()%>',roleCode:'WF_NTEST_MGR'}});
    var StaffRoleViewComboBox = new Ext.form.ComboBox({
        width: 220,
        store: StaffRoleViewStore,
        name: "submitStaffId",
        triggerAction: 'all',
        queryMode:"local",
		forceSelection:true,
        typeAhead:true,
       	minChars:1,
       	selectOnFocus: true,
        fieldLabel: "计划提交人",
        valueField: 'staffId',
        displayField: 'displayName',
        editable:true,
        	listConfig: {
        },
        listeners: {
        	select :function(combo,records, eOpts ){
        		/*var currentGridRowModels=Ext.getCmp('taskGrid').getSelectionModel().getSelection();
        		if(currentGridRowModels.length==1){
        			currentGridRowModels[0].set('staffIds',records[0].raw.staffId);
        			currentGridRowModels[0].set('staffNames',records[0].raw.staffName);
        		}*/
        		//console.log(records);
        	},
            beforequery: function (queryEvent, eOpts) {
            }
        }
    });
	var sysContentModel= Ext.define('sysContentModel', {
	    extend: 'Ext.data.Model',
	    fields: [
	        {name: 'constantId',  type: 'string'},
	        {name: 'categoryName', type: 'string'},
	        {name: 'category', type: 'string'},
	        {name: 'show', type: 'string'},
	        {name: 'value', type: 'int'},
	        {name: 'other1', type: 'string'},
	        {name: 'other2', type: 'string'},
	        {name: 'memo', type: 'string'}
	    ]
	});
	var solidTaskTypeStore=new  Ext.data.Store({
		id: 'solidTaskTypeStore',
		model: sysContentModel,
		groupField: 'categoryName',
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getMultipleSysConstant.do?categorys=SOLID_TASK_TYPE',
			reader: {
				type: 'json',
				root: 'data'
			}
		},
		listeners:{
            load : function(store, records, options ){
            	var rs = Ext.create("EmptyVal");
                store.insert(0,rs);  
                return true;
            }
		}
	});
	solidTaskTypeStore.load({params:{}});
	var btns = new Ext.Button({
		text: '查询',
		width: 60,
		margin: '0 0 0 50px',
		handler: function(){
			/*var planName = Ext.getCmp('qryForm').getForm().findField('planName').getValue();
			var planTag = Ext.getCmp('qryForm').getForm().findField('planTag').getValue();
			var taskType = Ext.getCmp('qryForm').getForm().findField('taskType').getValue();
			var submitStaffName = Ext.getCmp('qryForm').getForm().findField('submitStaffName').getValue();
			var codeCommitDate = Ext.getCmp('qryForm').getForm().findField('codeCommitDate').getValue();
			var factCompleteTime = Ext.getCmp('qryForm').getForm().findField('factCompleteTime').getValue();
			var reqTime = Ext.getCmp('qryForm').getForm().findField('reqTime').getValue();*/
			//Ext.data.StoreMgr.lookup('solidTaskStore').reload({params:{planName:encodeURI(encodeURI(planName)),planTag:planTag,taskType:encodeURI(encodeURI(taskType)),submitStaffName:encodeURI(encodeURI(submitStaffName)),codeCommitDate:codeCommitDate,factCompleteTime:factCompleteTime,reqTime:reqTime}});
			Ext.data.StoreMgr.lookup('solidTaskStore').loadPage(1);
		}
	});
	 var bigTypeStore = new Ext.data.Store({
                id: 'bigTypeStore',
                fields: ['value', 'show'],
                proxy: {
                    type: 'ajax',
                    url: '<%=request.getContextPath()%>/getComBox.do?query=bigTypeStore',
                    reader: {
                        type: 'json',
                        root: 'data'
                    }
                },
                listeners:{
        	    	load:function(store,records,successful, eOpts ){
        	    		store.insert(0,{value:'',show:'--全部--'});
        	    	}
                }
            });
            bigTypeStore.load();
     var bigTypeCombox = new Ext.form.ComboBox({
                width: 250,
                store: bigTypeStore,
                name: "bigType",
                fieldLabel: "系统大类",
                valueField: 'value',
                displayField: 'show'
            });
	var qryForm = new Ext.form.FormPanel({
		id:'qryForm',
		title:'查询区域',
		cls:'ui-formPanel',
		defaults: { 
			margins: '5 0 5 0' 
		},
		renderTo: Ext.get("searchParam"),
		width: screenWidth*0.98,
		height: screenHeight*0.22*0.99,
		minHeight: 120,
		minWidth: 800,
		layout: 'vbox',
		bodyBorder: 0, 
		items: [
			{
				xtype: 'fieldcontainer', 
		    	labelStyle: 'font-weight:bold;padding:0', 
	  			fieldDefaults: { 
				labelAlign: 'right', 
				labelWidth: 80
				},
			    layout: 'hbox', 
			    defaultType: 'textfield',
			    items: [
			    	{name:'planName',fieldLabel:'测试计划名称',width:237},
			    	/* {xtype:'datefield',name:'reqTime',fieldLabel:'需求定稿时间'}, */
			    	{name:'planTag',fieldLabel:'测试计划编号'},bigTypeCombox
			    ]
			},
			{
 				xtype: 'fieldcontainer',
		    	labelStyle: 'font-weight:bold;padding:0',
   				fieldDefaults: {
				labelAlign: 'right',
				labelWidth: 80
			},
			    layout: 'hbox',
			    items: [
			    	/*{xtype:'datefield',name:'codeCommitDate',fieldLabel:'代码截止提交日'},*/
			    	{xtype:'datefield',name:'factCompleteTime',fieldLabel:'计划上线时间'},
			    	{xtype:'combo',name:'taskType',fieldLabel:'任务类型',displayField:'show',valueField:'value',store: solidTaskTypeStore,
			        },
			    	StaffRoleViewComboBox,
			    	{
                        xtype: "checkbox",
                        boxLabel: '查询未关闭的数据',
                        name: 'isClose',
                        inputValue: '2',
                        id: "isClose"
                    },
			    	btns
			    ]
			}
		]
	});
});
</script>
</html>