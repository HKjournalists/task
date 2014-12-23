<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	String funId = request.getParameter("funId");
	String relaId = request.getParameter("relaId");
	String subTaskTag = request.getParameter("subTaskTag");
	String selectCaseIds = request.getParameter("caseIds");
	if(selectCaseIds==null||selectCaseIds.equals(""))
		selectCaseIds = "0";
%>
<html>
<head>
	<title>用例关联</title>
</head>
<body id="subTaskCaseRela">
</body>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
Ext.onReady(function(){
	var mapModel = Ext.define('mapModel', {
        extend: 'Ext.data.Model',
        fields: [{
                name: 'constantId',
                type: 'string'
            }, {
                name: 'categoryName',
                type: 'string'
            }, {
                name: 'category',
                type: 'string'
            }, {
                name: 'show',
                type: 'string'
            }, {
                name: 'value',
                type: 'int'
            }, {
                name: 'other1',
                type: 'string'
            }, {
                name: 'other2',
                type: 'string'
            }, {
                name: 'memo',
                type: 'string'
            }
        ]
    });
    var mapStore = new Ext.data.Store({
        id: 'mapStore',
        model: mapModel,
        groupField: 'categoryName',
        proxy: {
        	async:false,
            type: 'ajax',
            url: '<%=request.getContextPath()%>/getMultipleSysConstant.do?categorys=IS_GLOBAL',
            reader: {
                type: 'json',
                root: 'data'
            }
        },
        listeners:{
			load:function(){
				Ext.Ajax.request({
					async:false,
					url:'<%=request.getContextPath()%>/getSeceneShow.do?funId=<%=relaId%>',
					success:function(response,config){
						var json=Ext.JSON.decode(response.responseText);
						if(json!=null){
							json = json.data;
							mapStore.add(json);
						}
						else
							return;
					},
					failure:function(response,config){
						Ext.Msg.alert('操作','数据请求失败');
					}
				});
			}
		}
    });
    mapStore.load();
    
	var testSeceneRModel = Ext.regModel("testSeceneRModel",{
		fields:[
			{name:'caseId',type:'string'},
			{name:'caseName',type:'string'},
			{name:'secId',type:'string'},
			{name:'casePreCond',type:'string'},
			{name:'caseOperateInst',type:'string'},
			{name:'preResult',type:'string'},
			{name:'operationType',type:'string'},
			{name:'isOwer',type:'string'},
			{name:'relaType',type:'string'}
		]
	});
	
	var testSeceneRProxy = new Ext.data.proxy.Ajax({
		type:"ajax",
		model:testSeceneRModel,
		url:'<%=request.getContextPath()%>/getRSeceneCaseTable.do',
		reader:{
			root:"data",
			type:"json"
		}
	});
	
	var testSeceneRStore = Ext.create('Ext.data.Store',{
		model:testSeceneRModel,
		proxy:testSeceneRProxy,
		listeners:{
			load:function(store, records, successful, operation, eOpts){
				var selectCaseId = '<%=selectCaseIds%>'.split(",");
				if(records==null)
					return;
				for(var i=0,n=records.length;i<n;i++){
					for(var j=0,k=selectCaseId.length;j<k;j++){
						if(records[i].raw.caseId==selectCaseId[j]){
							testSeceneRGrid.getSelectionModel().select(records[i],true,true);
							break;
						}
					}
				}
			}
		}
	});
	
	testSeceneRStore.load({params:{funId:'<%=relaId%>',subTaskTag:'<%=subTaskTag%>',isQueryAll:'1',}});
	
	var testSeceneRGrid = Ext.create('Ext.grid.Panel',{
		tbar:Ext.create('Ext.Toolbar',{
			items:[{
				text:'关联',
				handler:function(){
					var selects = testSeceneRGrid.getSelectionModel().getSelection();
					var relaCaseId = new Array();
					for(var i=0,n=selects.length;i<n;i++)
					{
						relaCaseId.push(selects[i].raw.caseId);
					}
					Ext.Ajax.request({
						url:'<%=request.getContextPath()%>/saveFunCaseRela.do?caseIds='+relaCaseId.join(",")+'&funId=<%=funId%>',
						success:function(response,config){
							testSeceneRGrid.getSelectionModel().deselectAll(true);
							//window.parent.closeCaseWindow();
							top.Ext.Msg.alert("提示","关联用例成功");
							top.Ext.getCmp('relaCaseWindow').close();
						},
						failure:function(response,config){
							Ext.Msg.alert("提示","关联用例失败");
						}
					});
				}
			}]
		}),
		id:'testSeceneRGrid',
        cls: 'ui-formPanel',
		title:'测试用例列表',
		border:1,
		renderTo:Ext.get('subTaskCaseRela'),
		width: screenWidth*0.996,
        height: screenHeight*0.99,
		viewConfig:{
			forctFit:true,
			stripeRows:true
		},
		store:testSeceneRStore,
		selModel:Ext.create("Ext.selection.CheckboxModel",{checkOnly : true,ignoreRightMouseSelection : true}),
		columns:[
			new Ext.grid.RowNumberer(),
			{header:"主键",width:100,dataIndex:"caseId",sortable:true,hidden:true},
			{header:"测式场景",width:100,dataIndex:"secId",sortable:true,renderer: function (value,cellmeta,record){
                try {
                    var store = Ext.data.StoreManager.lookup("mapStore");
                    store.clearFilter(true);
                    store.filter("categoryName", "secene_show");
                    return store.findRecord("value", value).getData().show + "";
                } catch (e) {
                    return ""+value;
                };
            }},
			{header:"用例名称",width:100,dataIndex:"caseName",sortable:true},
			{header:"用例前置条件",width:100,dataIndex:"casePreCond",sortable:true},
			{header:"用例操作说明",width:100,dataIndex:"caseOperateInst",sortable:true},
			{header:"预期结果",width:100,dataIndex:"preResult",sortable:true},
			{header:"操作类型",width:100,dataIndex:"operationType",sortable:true},
			{header:"用例是否引用",width:100,dataIndex:"relaType",sortable:true},
			{header:"用例归属",width:100,dataIndex:"isOwer",sortable:true}
		]
	});
});
</script>
</html>