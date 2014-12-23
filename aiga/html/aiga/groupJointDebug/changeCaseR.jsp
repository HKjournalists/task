<!DOCTYPE html>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/aiga/common/common.jsp" %>
<%
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
%>
<html>
    
<head>
	<title>集团联调用例库</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/aiga/workflow/testTask/ajaxFileUpload/ajaxfileupload.js"></script>
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
</head>

<body></body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;

Ext.onReady(function () {
	Ext.QuickTips.init();
    Ext.tip.QuickTipManager.init();

    /**
     * 联调用例状态
     */
    var isDeleteStore = new Ext.data.Store({
        id: 'isDeleteStore',
        fields: ['value', 'show'],
        proxy: {
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getComBoxForGroupCase.do?query=isDelete',
            reader: {
            	type: 'json',
           		root: 'data'
           	}
        }
    });
    isDeleteStore.load();
    
	var groupCaseStore = Ext.create('Ext.data.Store', {
		storeId: 'groupCaseStore',
        fields: [
        	{
                name: 'caseId',
                type: 'string'
            }, {
                name: 'caseName',
                type: 'string'
            }, {
                name: 'caseDesc',
                type: 'string'
            }, {
                name: 'testPurpose',
                type: 'string'
            }, {
                name: 'preCondition',
                type: 'string'
            }, {
                name: 'testDataDesc',
                type: 'string'
            }, {
                name: 'testStep',
                type: 'string'
            }, {
                name: 'remark',
                type: 'string'
            }, {
                name: 'preResult',
                type: 'string'
            }, {
                name: 'isDelete',
                type: 'string'
            }, {
                name: 'createTime',
                type: 'string'
            }, {
                name: 'creatorId',
                type: 'string'
            }, {
                name: 'creatorName',
                type: 'string'
            },{
                name: 'isNeedMessage',
                type: 'string'
            }
        ],
        proxy: {
            type: 'ajax',
            url: "<%=request.getContextPath()%>/getGroupCaseListBySubTaskTag.do?subTaskTag=<%=request.getParameter("subTaskTag")%>",
            reader: {
                root: "data",
                type: "json"
            }
        }
	});
	groupCaseStore.load();
	var caseCollectionGrid = new Ext.grid.Panel({
        id: 'caseCollectionGrid',
        cls: 'ui-formPanel',
        width: screenWidth * 0.989,
        height: screenHeight * 0.93,
        renderTo: Ext.getBody(),
        title: '用例列表',
        store: groupCaseStore,
        tbar:[
        	{xtype: 'button',text: '保存',handler: function () {
				var deleteItems = Ext.getCmp("caseCollectionGrid").getSelectionModel().getSelection();
				if(deleteItems.length == 0){
					Ext.Msg.alert("操作提示","请选择已经变更的用例!");
					return;
				}
				Ext.MessageBox.confirm('操作提示','确定已经选择的用例?',function(optional){
					if(optional=='yes'){
						var Ids = [];
	                    Ext.each(deleteItems, function (item) {
	                        Ids.push(item.data.caseId);
	                    })
	                    MaskLoading();
						Ext.Ajax.request({
							async:false,
							url:"<%=request.getContextPath()%>/saveRChangeCase.do?caseIds="+Ids+"&changeId="+<%=request.getParameter("changeId")%>,
							success:function(response,config){
								MaskOver();
								Ext.Msg.alert('提示','关联成功',function(){
									top.Ext.getCmp("choiceGroupCaseWin").close(); 
								});
							},
							failure:function(response,config){
								MaskOver();
								Ext.Msg.alert('操作','数据请求失败');
							}
						});
					}
				});
			}}
        ],
        selModel: Ext.create("Ext.selection.CheckboxModel",{id : 'checkBoxForChoiceCount',mode:"SIMPLE"}),
        columns: [
            {xtype: 'rownumberer'}, 
            {header: "用例Id",width: 100,sortable: false,dataIndex: 'caseId',hidden: true},
        	{header: "用例名称",width: 100,sortable: false,dataIndex: 'caseName'},
        	{header: "用例描述",width: 100,sortable: false,dataIndex: 'caseDesc'},
        	{header: "测试目的",width: 100,sortable: false,dataIndex: 'testPurpose'},
        	{header: "前置条件",width: 100,sortable: false,dataIndex: 'preCondition'},
        	{header: "测试数据描述",width: 100,sortable: false,dataIndex: 'testDataDesc'},
        	{header: "测试步骤",width: 100,sortable: false,dataIndex: 'testStep'},
        	{header: "预测结果",width: 100,sortable: false,dataIndex: 'preResult'},
        	{header: "是否需要造报文",width: 100,sortable: false,dataIndex: 'isNeedMessage',
                renderer: function (value, cellmeta, record) {
                    if (value == 'on'||value==1) return "是";
                    else return "否";
            }},
        	{header: "描述",width: 100,sortable: false,dataIndex: 'remark'},
        	{header: "用例状态",width: 100,sortable: false,dataIndex: 'isDelete',renderer: function(value, cellmeta, record) {
  	        	try{
  	        		var store=Ext.data.StoreManager.lookup("isDeleteStore");
 	        		store.clearFilter(true);
 	        		return store.findRecord("value",value).getData().show+"";
  	        	}catch(e){return "未指定"};
  	        }},
        	{header: "创建日期",width: 100,sortable: false,dataIndex: 'createTime',renderer: function(value, cellmeta, record) {
  	        	return value.substring(0,10)+"";
  	        }},
        	{header: "创建人",width: 100,sortable: false,dataIndex: 'creatorName'},
        	{header: "测试人ID",width: 100,sortable: false,dataIndex: 'creatorId',hidden: true}
      	]
    });
});
</script>
</html>