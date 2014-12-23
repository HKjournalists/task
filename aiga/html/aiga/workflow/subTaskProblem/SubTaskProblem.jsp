<!DOCTYPE html>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.asiainfo.aiga.common.WorkflowParam"%>
<%@page import="com.asiainfo.aiga.common.security.user.bo.AigaUser,java.util.Date,java.text.SimpleDateFormat"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/aiga/common/common.jsp"%>

<%
	String startInfo = "将问题发送测试人员，启动问题跟踪流程";
	String saveInfo = "保存问题";
	String flag = request.getParameter("flag");
	String subTaskId = request.getParameter("subTaskId");
	String objId = request.getParameter("objId");
	String subTaskTag = request.getParameter("subTaskTag");
	String subTaskName = "";
	if(request.getParameter("subTaskName")!=null)
		subTaskName = new String(request.getParameter("subTaskName").getBytes("ISO-8859-1"),"UTF-8").toString();
	String subTaskType = request.getParameter("subTaskType");	
	AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
	Date date = new Date();
 
	SimpleDateFormat ms = new SimpleDateFormat("MM");
 	SimpleDateFormat ds = new SimpleDateFormat("yyyy-MM-dd");
%>
<html>
  <head>
    <title>评审信息</title>
  </head>
  
  <body>
    <div id="fileTrans" style="display:none;"><jsp:include page="/aiga/attach/fileTrans.jsp"></jsp:include></div>
    <!-- 操作区域浮动层 -->
			<!-- btmFixed -->
			<div class="btmFixed">
				<div class="btmFixedInner"></div>
				<div class="btmFixed_left" id="putongliucheng">
					<ul>
						<li title="<%=startInfo %>" id = "startBtn" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="startProblem()">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/turn.gif" /></span>
							<p>启动</p>
						</li>
						<li title="<%=saveInfo %>" onmouseover="this.className='hover'" onmouseout="this.className=''" onclick="saveProblem()">
							<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/btm_save.gif" /></span>
							<p>保存</p>
						</li>
					</ul>	
				</div>
				<div class="btmFixed_right">
					<div class="processRight">
						<span><img src="<%=request.getContextPath()%>/aiga/images/opera_area/btm_process.gif"/></span>
						<p>查看流程</p>
					</div>
				</div>
			</div>
  </body>
<script type="text/javascript">
$(function(){
	$('#fileTrans').hide();
});
var screenWidth = document.documentElement.clientWidth*0.99;
var screenHeight = document.documentElement.clientHeight*0.99;
var id ='<%=subTaskId%>';
var objId = '<%=objId%>';
var flag ='<%=flag%>';

var probmTag = '';
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
	var taskTagTitle="评审信息";
	var datenow = '<%=ds.format(date)%>';

	var dateFormat = Ext.Date.format(new Date, 'YmdHisu');
    probmTag = 'STP' + dateFormat;
	var stpIntoStore=new Ext.data.Store({
		autoLoad: true,
		id: 'stpIntoStore',
		fields: ['value','show'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getComBox.do?query=stpIntoStore',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	stpIntoStore.load();
	
	var stpStatusStore=new  Ext.data.Store({
		id: 'workflowParamStore',
		fields: ['linkId','phaseId','phaseName','vmTaskName'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getWorkflowParam.do?query=80000',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	stpStatusStore.load();
	
	
	var stpMainClassStore=new Ext.data.Store({
		autoLoad: true,
		id: 'stpMainClassStore',
		fields: ['value','show'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getComBox.do?query=stpMainClassStore',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	stpMainClassStore.load();
	
	
	var stpSubClassStore=new Ext.data.Store({
		
		id: 'stpSubClassStore',
		fields: ['value','show'],
		proxy: {
			type: 'ajax',
			url: '<%=request.getContextPath()%>/getComBoxLink.do',
			reader: {
				type: 'json',
				root: 'data'
			}
		}
	});
	stpSubClassStore.load();
	
	var btn = new Ext.Button({
    	id: 'viewBtn',
    	text: '查看子任务信息',
    	width: 100,
    	margin: '0 0 0 50px',
    	handler: function(){
    		openSubTaskPage();
    	}
    });
	
	var stpMainClassComboBox = new Ext.form.ComboBox({
    	width: 250,
        store: stpMainClassStore,
        name: "stpMainClass",
        fieldLabel: "问题主类型",
        labelAlign: 'right', 
        mode: 'local',
        valueField: 'value',
        displayField: 'show',
        editable:true,
        	listConfig: {
        },
        listeners: {
        	select :function(combo,records, eOpts ){
        		Ext.getCmp('subTaskProblemForm').getForm().findField('stpSubClass').setValue('');
        		stpSubClassStore.proxy.url="<%=request.getContextPath()%>/getComBoxLink.do?query=spSubClassStore&other2="+records[0].data.value;
            	stpSubClassStore.load();
            },
            beforequery: function (queryEvent, eOpts) {
            }
        }
    });
    
    var stpSubClassCombox = new Ext.form.ComboBox({
    	width: 250,
        store: stpSubClassStore,
        name: "stpSubClass",
        labelAlign: 'right', 
        mode: 'local',//
        fieldLabel: "问题子类型",
        valueField: 'value',
        displayField: 'show'
    });
    
    var stpIntoCombox = new Ext.form.ComboBox({
    	width: 250,
        store: stpIntoStore,
        name: "stpInto",
        labelAlign: 'right', 
        fieldLabel: "问题引入阶段",
        valueField: 'value',
        displayField: 'show'
    });
    
    var stpStatusCombox = new Ext.form.ComboBox({
    	width: 250,
        store: stpStatusStore,
        name: "stpStatus",
        labelAlign: 'right', 
        fieldLabel: "跟踪状态",
        valueField: 'linkId',
        displayField: 'vmTaskName',
        value:1101,
        readOnly:true
    });
    
    
    var subTaskProblemForm = Ext.widget('form', {
		id:'subTaskProblemForm',
		minWidth:  1100,
		minHeight: 100,
		width: screenWidth,
		height:screenHeight*0.17,
		title:''+taskTagTitle, 
		listeners:{
			render : function(render,eOpts){

			}
		},
		layout: {
			type: 'vbox'
		}, 
		bodyBorder: 0, 
		fieldDefaults: { 
			labelAlign: 'right', 
			labelWidth: 60, 
			labelStyle: 'font-weight:bold' 
		}, 
		defaults: { 
			margins: '5 0 0 0' 
		}, 

		items: [
				{ 
					xtype: 'fieldcontainer', 
				    labelStyle: 'font-weight:bold;padding:0', 
				    layout: 'hbox', 
				    defaultType: 'textfield', 
				    items: [{
						width:1000,
						labelAlign: 'right', 
						name: 'stpName',
						value: "【"+'<%=URLDecoder.decode(URLDecoder.decode(subTaskName,"UTF-8"))%>'+"】"+taskTagTitle,
						fieldLabel: '任务问题名称'
					},{
				  		xtype:'hidden', 
						name: 'startMark',
						fieldLabel: '启动标签',
						hidden:true
					},{
				  		xtype:'hidden', 
						name: 'id',
						fieldLabel: '问题id',
						hidden:true
					}]
				},
			    { 
					xtype: 'fieldcontainer', 
					labelStyle: 'font-weight:bold;padding:0', 
					layout: 'hbox', 
					defaultType: 'textfield', 
					items: [
						{
							width:250,
							labelAlign: 'right', 
							name: 'stpTag',
							value: probmTag,
							readOnly:true,
							fieldLabel: '评审编号'
						},
						stpStatusCombox,
						{	
							xtype:'hidden', 
							name: 'createStaffName',
						},
						{
							xtype:'hidden',
							labelAlign: 'right', 
							value: '<%=user.getUserId()%>',
							name: 'createStaffId'
						},{
							xtype:'hidden',
							labelAlign: 'right', 
							value: '<%=subTaskId%>',
							name: 'subTaskId'
						},{
							xtype:'hidden',
							labelAlign: 'right', 
							value: '<%=subTaskTag%>',
							name: 'subTaskTag'
						},{
							xtype:'hidden',
							labelAlign: 'right', 
							value: '<%=subTaskName%>',
							name: 'subTaskName'
						},{
							xtype:'hidden',
							labelAlign: 'right', 
							value: '1',
							name: 'stpPhsse'
						},{
							xtype:'hidden',
							labelAlign: 'right', 
							value: '0',
							name: 'startMark'
						},{
							xtype:'hidden',
							labelAlign: 'right', 
							value: '<%=subTaskType%>',
							name: 'subTaskType'
						},{
							labelAlign: 'right', 
							xtype:'hidden',
							name: 'createTime',
							format: 'Y-m-d',
							value:datenow,
							fieldLabel: '创建时间',
							
						},
						btn
					]}
				]
		});
		if(flag == '0')
		{//使用subTaskId刷新
			subTaskProblemForm.load({
				params:{id :id},
				url:'<%=request.getContextPath()%>/getSubTaskProblemForm.do',
				method:'POST',  
				success:function(form,action){
					stpSubClassStore.proxy.url="<%=request.getContextPath()%>/getComBoxForSubClass.do?query=spSubClassStore";
				    stpSubClassStore.load();

            		problemStore.proxy.url="<%=request.getContextPath()%>/getQuestionByReviewTag.do?reviewTag="+Ext.getCmp('subTaskProblemForm').getForm().findField('stpTag').getValue();
            		problemStore.load();
            		
            		var startMark = Ext.getCmp('subTaskProblemForm').getForm().findField('startMark').getValue();
            		var target=document.getElementById("startBtn");
            		if (startMark=="" || startMark==null || startMark=="0" || startMark=="null"){
		                target.style.display="block";
		            } else if(startMark=="1") {
		                target.style.display="none";
		            }
            		tabPanel.add({
                        title: "附件列表",
                        contentEl:'fileTrans',
                        listeners:{
                        	render:function( Component, eOpts ){
                        		$('#fileTrans').show();
                        		initPackList(subTaskProblemForm.getForm().findField('stpTag').getValue(), '8', '<%=WorkflowParam.getWorkflow("createProblemFollow").getLinkNo()%>','0','0',false);
                        	}
                        }
					}).show();
				},  
				failure:function(form,action){  
					Ext.Msg.alert('提示',"失败原因是: "+action.result.errorMessage);  
				}
			});
		}
		else if(flag == '1')
		{
			subTaskProblemForm.load({
				params:{id :objId},
				url:'<%=request.getContextPath()%>/getSubTaskProblemFormById.do',
				method:'POST',  
				success:function(form,action){
					stpSubClassStore.proxy.url="<%=request.getContextPath()%>/getComBoxForSubClass.do?query=spSubClassStore";
				    stpSubClassStore.load();
				    
					problemStore.proxy.url="<%=request.getContextPath()%>/getQuestionByReviewTag.do?reviewTag="+Ext.getCmp('subTaskProblemForm').getForm().findField('stpTag').getValue();
            		problemStore.load();
	            	
	            	var fields = subTaskProblemForm.getForm().getFields().items;
					for(var i=0,n=fields.length;i<n;i++){
						fields[i].setReadOnly(true);							
					}
					tabPanel.add({
						closable:false,
				   		title: '历史轨迹',
				   		autoScroll:true,
				   		width:screenWidth* 0.90,
				   		height:screenHeight* 0.3,
				   		html:'<iframe id="f_1" scrolling="auto" frameborder="0" width="99%" height="95%" src="<%=request.getContextPath()%>/aiga/workflow/common/HistoryTrack.jsp?objId='+Ext.getCmp("subTaskProblemForm").getForm().findField('id').getValue()+'&objType=8"></iframe>'
					}).show();
					tabPanel.add({
                        title: "附件列表",
                        contentEl:'fileTrans',
                        listeners:{
                        	render:function( Component, eOpts ){
                        		$('#fileTrans').show();
                        		initPackList(subTaskProblemForm.getForm().findField('stpTag').getValue(), '8', current_linkNo,'0','0',false);
                        	}
                        }
					});
				},  
				failure:function(form,action){
					Ext.Msg.alert('提示',"失败原因是: "+action.result.errorMessage);  
				}
			});
		}
		
		var aqState = new Ext.data.Store({
		 	autoLoad: true,
		 	id: 'aqState',
		    fields: ['value','show'],
		    proxy: {
		    	type: 'ajax',
		        url: '<%=request.getContextPath()%>/getSysParam.do?category=aqState'+'&_='+(new Date()).getTime(),
		        reader: {
		        	type: 'json',
		        	root: 'data'
		        }
		    }
		});
		
		var problemModel = Ext.regModel("problemModel",{
			fields:[
				{name:'aqId',type:'string'},
				{name:'aqReviewTag',type:'string'},
				{name:'aqState',type:'string'},
				{name:'aqInto',type:'string'},
				{name:'aqStpMainClass',type:'string'},
				{name:'aqStpSubClass',type:'string'},
				{name:'aqName',type:'string'},
				{name:'aqSubmitStaff',type:'string'},
				{name:'aqSubTime',type:'string'},
				{name:'defectDscr',type:'string'},
				{name:'stpDscr',type:'string'}
			]
		});
		
		var problemProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			model: problemModel,
			url:'<%=request.getContextPath()%>/getQuestionByReviewTag.do?reviewTag='+probmTag,
			reader:{
				root:"data",
				type:"json"
			}
		});
		var problemStore = Ext.create('Ext.data.Store',{
			autoLoad: true,
			mode: 'remote',
			model: problemModel,
			proxy: problemProxy,
			listeners:{
			}
		});
		
		problemGridEdit = Ext.create('Ext.grid.plugin.CellEditing', {
			clicksToEdit: 1
		});
		var problemGrid = Ext.create('Ext.grid.Panel', {
			title: '评审问题列表',
			id: 'problemGrid',
			store: problemStore,
			width: screenWidth*0.9,
			height: screenHeight*0.1,
			columns: [
				{xtype:'rownumberer'},
				{dataIndex: 'aqId', hidden: true},
				{dataIndex: 'aqReviewTag', hidden: true},
				{dataIndex: 'aqSubTime', hidden: true},
				{header: '问题名称', dataIndex: 'aqName', field: 'textarea' ,height: 20,allowBlank:false, width:200},
				{header: '提出人', dataIndex: 'aqSubmitStaff', width:100, field: 'textarea' },
				{header: '问题状态', dataIndex:'aqState', editor:{xtype:'combo',displayField:'show', valueField:'value', store:'aqState',allowBlank:false},
					renderer:function(value){
						var rec = Ext.StoreMgr.get('aqState').find('value',value);
						if(rec == -1) {
							return '';
						}
						return Ext.StoreMgr.get('aqState').getAt(rec).raw.show;
					}
				},
				
				{header: '问题引入阶段', dataIndex:'aqInto', editor:{xtype:'combo',displayField:'show', valueField:'value', store:'stpIntoStore',allowBlank:false},
					renderer:function(value){
						var rec = Ext.StoreMgr.get('stpIntoStore').find('value',value);
						if(rec == -1) {
							return '';
						}
						return Ext.StoreMgr.get('stpIntoStore').getAt(rec).raw.show;
					}
				},
				{header: '问题主类型', dataIndex:'aqStpMainClass', width:150,
					editor:{
						xtype:'combo',
						displayField:'show', 
						valueField:'value', 
						store:'stpMainClassStore',
						allowBlank:false,
						listeners: {
				        	select :function(combo,records, eOpts ){
				        		var curSel = Ext.getCmp('problemGrid').getSelectionModel().getSelection();
								curSel[0].set('aqStpSubClass','');
				        		stpSubClassStore.proxy.url="<%=request.getContextPath()%>/getComBoxLink.do?query=spSubClassStore&other2="+records[0].data.value;
				            	stpSubClassStore.load();
				            },
				            beforequery: function (queryEvent, eOpts) {
				            }
				        }
					},
					renderer:function(value){
						var rec = Ext.StoreMgr.get('stpMainClassStore').find('value',value);
						if(rec == -1) {
							return '';
						}
						return Ext.StoreMgr.get('stpMainClassStore').getAt(rec).raw.show;
					}
				},
				{header: '问题子类型', dataIndex:'aqStpSubClass', width:150,
					editor:{
						xtype:'combo',
						displayField:'show', 
						valueField:'value', 
						store:'stpSubClassStore',
						allowBlank:false,
						listeners: {
				        	focus :function(combo,records, eOpts ){
				        		var curSel = Ext.getCmp('problemGrid').getSelectionModel().getSelection();
				        		var aqStpMainClass = curSel[0].get('aqStpMainClass');
				        		stpSubClassStore.proxy.url="<%=request.getContextPath()%>/getComBoxLink.do?query=spSubClassStore&other2="+aqStpMainClass;
				            	stpSubClassStore.load();
				            },
				            beforequery: function (queryEvent, eOpts) {
				            }
				        }
					},
					renderer:function(value){
						var rec = Ext.StoreMgr.get('stpSubClassStore').find('value',value);
						if(rec == -1) {
							return '';
						}
						return Ext.StoreMgr.get('stpSubClassStore').getAt(rec).raw.show;
					}
				},
				{header: '缺陷描述', dataIndex: 'defectDscr', field: 'textarea' ,height: 20,allowBlank:false, width:200},
				{header: '问题备注', dataIndex: 'stpDscr', field: 'textarea' ,height: 20, width:200}
			],
			listeners:{
  				beforeedit : function(editor, e) {
  					<%if(flag==null||!flag.equals("1")){%>
  						return true;
  					<%}if(flag.equals("1")){%>
				        if(e.field== "aqState"){
				            return true;
				        }else{
				            return false;
				        }
				    <%}%>
			    }
   			},
			
			selType: 'cellmodel',
			plugins: [
				problemGridEdit
			],
			height: screenHeight*0.7,
			width: screenWidth*0.98
			<%if(flag==null||!flag.equals("1")){%>
			,
			tbar: [
			{
				text: '新增',
				height: 20,
				width: 40,
				handler: function() {
					var r = Ext.create('problemModel');
					r.set('aqState',0);
					r.set('aqReviewTag',Ext.getCmp('subTaskProblemForm').getForm().findField('stpTag').getValue());
					var index = problemStore.data.length;
					problemStore.insert(index,r);
					//Ext.getCmp('problemGrid').getView().refresh();
				}
			},
			{
				text: '删除',
				height: 20,
				width: 40,
				handler: function() {
					confirmDelProblem();
				}
			},
			{
				text: '保存',
				height: 20,
				width: 40,
				handler: function() {
					saveQuestion();
				}
			}]
			<%}%>
		});
		
		function confirmDelProblem() {
			var curSel = Ext.getCmp('problemGrid').getSelectionModel().getSelection();
			if(curSel.length == 0) {
				return;
			}
			Ext.MessageBox.confirm('提示','确定要删除该条问题吗？',function(btn){
				if(btn == 'yes') {
					delProblem();
				} else {
					return;
				}
			});
		}
		
		
		function delProblem() {
			var curSel = Ext.getCmp('problemGrid').getSelectionModel().getSelection();
			var aqId = curSel[0].get('aqId');
			if(!aqId) {
				Ext.getCmp('problemGrid').getStore().remove(curSel);
    			Ext.getCmp('problemGrid').getView().refresh();
    			return;
			}
	  		MaskLoading();
			$.ajax({
	    		async: false,
    			type: 'POST',
    			url: '<%=request.getContextPath()%>/deleteAigaQuestion.do',
    			data: 'aqId='+aqId+'&_='+(new Date()).getTime(),
    			success: function(data) {
    				Ext.getCmp('problemGrid').getStore().remove(curSel);
    				Ext.getCmp('problemGrid').getView().refresh();
    			}
    		});
	    	MaskOver();
		}
		
		

		var tabPanel = Ext.create("Ext.tab.Panel", {
		    frame: true,
		    cls: 'ui-formPanel',
		    width: screenWidth * 0.98,
		    height: screenHeight * 0.5,
		    id: 'tabPanel',
		    activeTab: 0, // 默认激活第1个tab页
		    items: [ 
		    ]
		});
        
        Ext.create('Ext.Panel', {
			renderTo: Ext.getBody(),
	        cls: 'ui-formPanel',
			width: screenWidth*0.98,
			height: screenHeight,
			minHeight: 740,
			margin:'0 0 60 0',
			layout: {
				margin:'0 0 0 0 ',
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
				items:[subTaskProblemForm,problemGrid,tabPanel]
			},
		       	{region: 'south',
					xtype: "panel",
			        html: "<div>2</div>",
			        width: 1000,
			        height: 357
			     }
			       
			]
	    });
	
});

function saveProblem()
{
	if(!saveQuestion())
		return;
	var form = Ext.getCmp('subTaskProblemForm').getForm();
    MaskLoading();
    form.submit({
        clientValidation: true,
        url: "<%=request.getContextPath()%>/saveSubTaskProblem.do",
        method: 'POST',
        success: function (response, config) {
    		MaskOver();
			top.Ext.Msg.alert("提示","保存成功!");
			top.Ext.getCmp("openWin").close();
		}
	});
}

function openSubTaskPage()
{
	var form = Ext.getCmp("subTaskProblemForm")
    var subTaskId = form.getForm().findField('subTaskId').value;
    var subTaskTag = form.getForm().findField('subTaskTag').value;
    var subTaskName = form.getForm().findField('subTaskName').value;
    var subTaskType = form.getForm().findField('subTaskType').value;
	var subTaskWin = new top.Ext.window.Window({
		title: '',
		layout: 'fit',
		width: screenWidth*0.95*0.95,
		height: screenHeight*0.95*0.95,
		modal: true,
		constrain:true,
		resizable:false,
		id: 'openWin_subtask_win',
		listeners: {},
		html: "<iframe src='<%=request.getContextPath()%>/aiga/workflow/subTestTask/subTestTaskManage.jsp?subTaskType="+subTaskType+"&objId="+subTaskId+"' frameborder=0 scrolling=yes width='100%' height='100%'></iframe>"
		
	});
	subTaskWin.show();
}


function saveQuestion() {
	var vRecords = Ext.getCmp('problemGrid').getStore().data.items; // 获取需要校验的数据数据   
	for(var row = 0;row<vRecords.length;row++){
	    var record = vRecords[row].data;
	    var aqInto = record["aqInto"];
	    var aqStpMainClass = record["aqStpMainClass"];
	    var aqStpSubClass = record["aqStpSubClass"];
	    var aqName = record["aqName"];
	    var aqSubmitStaff = record["aqSubmitStaff"];
	    var defectDscr = record["defectDscr"];
	    
	    if(aqName==null||aqName==""){
	      	alert('请填写问题名称');return false;
	    }
	    if(aqSubmitStaff==null||aqSubmitStaff==""){
	      	alert('请填写提出人');return false;
	    }
	    if(aqInto==null||aqInto==""){
	      	alert('请选择问题引入阶段');return false;
	    }
	    if(aqStpMainClass==null||aqStpMainClass==""){
	      	alert('请选择问题主类型');return false;
	    }
	    if(aqStpSubClass==null||aqStpSubClass==""){
	      	alert('请选择问题子类型');return false;
	    }
	    if(defectDscr==null||defectDscr==""){
	      	alert('请填写缺陷描述');return false;
	    }
	}
	
	problemGridEdit.completeEdit();
	
	var resStore = Ext.getCmp('problemGrid').getStore();
	var resources = new Array();
	resStore.each(function(rec){
		resources.push(Ext.encode(rec.data));
	});
	resources = "[" + resources + "]";
	$.ajax({
   		async: false,
		type: 'POST',
		dataType: "json",
		url: '<%=request.getContextPath()%>/saveAigaQuestion.do',
		data: 'table='+resources+"&_=" + (new Date()).getTime(),
		success: function(data) {
			resStore.reload();
		}
	});
	return true;
}

function startProblem()
{
	var vRecords = Ext.getCmp('problemGrid').getStore().data.items; // 获取需要校验的数据数据   
  	if(vRecords.length < 1)
  	{
  		alert('问题条目必须大于一条');
  		return;
  	}
	if(!saveQuestion())
		return;
 	var submitJson = {};
	submitJson.subTaskProblemForm={};
    var fields = Ext.getCmp('subTaskProblemForm').getForm().getFields().items;
	for(var i=0,n=fields.length;i<n;i++){
		var field = fields[i].name;
		submitJson.subTaskProblemForm[field]= Ext.getCmp('subTaskProblemForm').getForm().findField(field).getValue();
	}

	var problemInfo = {problemStaffId:'<%=user.getUserId()%>',
		problemStaffName:'<%=user.getUserName()%>',
		subTask:Ext.getCmp('subTaskProblemForm').getForm().findField('subTaskId').getValue(),
		problemTag:Ext.getCmp('subTaskProblemForm').getForm().findField('stpTag').getValue()
	};

	submitJson.problemInfo = problemInfo;
	MaskLoading();
	Ext.Ajax.request({ 
		async:false, 
		method:'POST',
		url:"<%=request.getContextPath()%>/getDomainJsonData.do?urlJava=/business/com.asiainfo.aiga.web.TestPlanAction&action=startProblemWF&jsonInfo="+Ext.encode(submitJson)
			+"&uid=<%=user.getUserAccount()%>" + "&",  
		success:function(response,config){ 
			MaskOver();
			top.Ext.Msg.alert("提示","启动成功!");
            top.Ext.getCmp("openWin").close();
            
            var json =  Ext.JSON.decode(response.responseText);
			if(json.flag=="success"){
				MaskOver();
				top.Ext.Msg.alert("提示","启动成功!");
            	top.Ext.getCmp("openWin").close();
			}else{
				MaskOver();
				Ext.Msg.alert('提示','保存失败:'+json.flag);
			}
		},
		failure:function(response,config){
			MaskOver();
			Ext.Msg.alert('提示','启动失败');
		}
	});
}

</script>
</html>
