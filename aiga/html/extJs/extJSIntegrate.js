/*
 * 1.1 extGrid(url,params,boModel,gridRendto,gridId,gridTitle,gridWidth,gridHeigh,gridColumn,onDBclick,onRightClick)
 * 创建grid插件,返回:Ext.grid.Panel对象
 * url:请求地址
 * params:传递参数
 * boModel:数据模型
 * 
 * 示例：var testDataModel = Ext.regModel("testDataModel",{
		fields:[
			{name:'a',type:'string'},
			{name:'b',type:'string'},
			{name:'c',type:'string'},
			{name:'d',type:'string'}]
	});
 * 
 * gridRendto:将控件布局到页面   如页面<div id='test'></div>，则gridRendto的参数值应为'test'
 * gridId:设置grid的唯一标识id
 * gridTitle:设置grid标题
 * gridWidth:设置grid宽度
 * gridHeigh:设置grid高度
 * gridColumn:grid列配置
 * 
 * 示例:var gridColumn = [{header:"a",width:100,dataIndex:"a",sortable:true},
		{header:"b",width:100,dataIndex:"b",sortable:true},
		{header:"c",width:100,dataIndex:"c",sortable:true},
		{header:"d",width:100,dataIndex:"d",sortable:true}];
 * header:标题  dataIndex:对应数据模型name  sortable:可否排序
 * 
 * onDBclick:设置双击事件  双击事件函数:function(grid,record,option)
 * onRightClick:设置鼠标右键时间   右键事件函数:function(view,record,item,index,e,eOpts)
 * */
 
/*
 * 1.2 extAutoGrid(url,params,gridRendto,gridId,gridTitle,gridWidth,gridHeigh,onDBclick,onRightClick)
 * 创建grid插件,该插件不能返回grid插件对象，请用getExtControl(controlId)函数获取
 * 
 * url:请求地址
 * params:传递参数
 * gridRendto:将控件布局到页面   如页面<div id='test'></div>，则gridRendto的参数值应为'test'
 * gridId:设置grid的唯一标识id
 * gridTitle:设置grid标题
 * gridWidth:设置grid宽度
 * gridHeigh:设置grid高度
 * 
 * onDBclick:设置双击事件   双击事件函数:function(grid,record,option)
 * onRightClick:设置鼠标右键时间   右键事件函数:function(view,record,item,index,e,eOpts)
 * */
 
/*
 * 2.extCommbo(condValueField,condDisplayField,condTable,condString,commboRendto,commboId,commboLabel,isMutilSelect,width,labelWidth)
 * 创建commbo插件,返回:Ext.form.field.ComboBox对象
 * 
 * condValueField:值字段
 * condDisplayField:显示字段
 * condTable:数据库表
 * condString:sql后的条件语句
 * commboRendto:将控件布局到页面的标签中
 * commboId:唯一标示符
 * commboLabel:commbo的字段标签
 * isMutilSelect:commbo是否可多选
 * width:commbo的宽度
 * labelWidth:label的宽度
 * */

/*
 * 3.extRadio(radioId,radioName,radioLabel,inputValue,isChecked,onChange)
 * 创建radio插件,该插件需要在radioPanel中展示,可调用5中的函数进行展示
 * 
 * radioId:radio的唯一标识
 * radioName:radio的name,该name关系到分组，如同一组的radio的name应该是相同的
 * radioLable:radio的字段标签
 * inputValue:radio对应的value值
 * isChecked:是否选中
 * onChange:onChange事件，函数为function(group, newValue, oldValue) newValue为新选中的值，oldValue为旧的值，使用的时候需要判断if(newValue==true)
 * */
 
 
/*
 * 4.radioItem(id,boxLabel,name,inputValue)
 * 创建radioGroup的item配置
 * 
 * id:radio的唯一标识
 * boxLabel:radio的字段标签
 * name:该name关系到分组，如同一组的radio的name应该是相同的
 * inputValue:radio对应的value值
 * */
 
/*
 * 5.extRadioGroup(label,radioItem,columnNum,onchange)
 * 创建radioGroup插件,该插件需要放入radioPanel中展示
 * 
 * label:radioGroup的字段标签
 * radioItem:
 * columnNum:radio个数
 * onchange事件，函数为function(group, newValue, oldValue) newValue为新选中的值，oldValue为旧的值，使用的时候需要判断if(typeof newValue.radiogroup == 'string')
 * */
 
/*
 * 6.extPanel(panelRendto,title,width,heigh,items,buttons)
 * 创建面板
 * 
 * panelRendto：将控件布局到页面的标签中
 * title:面板标题
 * width:宽度
 * heigh:高度
 * items:控件数组
 * buttons:配置面板按钮,可用extButton(text,onclick)函数进行配置，详情请查看该函数的使用
 * */

/*
 * 7.extWindow(title,heigh,width,items,closable)
 * 创建window窗口
 * 
 * title:窗口标题
 * heigh:窗口高度
 * width:窗口宽度
 * items:放入窗口的控件，可放入panel控件
 * closable:是否隐藏关闭按钮
 * */
 
/*
 * 8.extButton(text,onclick)
 * 配置panel中的button按钮
 * 
 * text:按钮的文字
 * onclick:按钮单击事件
 * */
 
/*
 * 9.getExtControl(controlId)
 * 获取控件对象
 * 
 * controlId:控件id
 * */
 
/*
 * 10.getGridColnumNum(grid)
 * 获取grid所选中的列
 * 
 * grid:grid控件对象
 * */
 
/*
 * 11.getGridRowNum(grid)
 * 获取grid所选中的行数
 * 
 * grid:grid控件对象
 * */
 
/*
 * 12.extAlert(title,message)
 * 弹出alert对话框
 * 
 * title:标题
 * message:显示的信息
 * */
 
/*
 * 13.extDateFormat(date,format)
 * 设置日期格式
 * 
 * date:日期，Date对象
 * format:日期格式,如'Y-m-d h:m:s'
 * */
 
/*
 * 14.getLastYearOrMonth(temp)
 * 获取上一年或上一月
 * 
 * temp:只可传入'month'或'year'
 * */
 
/*
 * 15.getCurrentYearOrMonth(temp)
 * 获取当前年或月
 * 
 * temp:只可传入'month'或'year'
 * */
 
/*
 * 16.getCommboValue(commbo)
 * 获取commbo的Value值
 * 
 * commbo：commbo插件对象
 * */
 
/*
 * 17.getGridRow(grid)
 * 获取行数据
 * 
 * grid:grid插件对象
 * */
 
/*
 * 18.refreshGrid(grid)
 * 刷新grid
 * 
 * grid:grid插件对象
 * */
 
/*
 * 19.getInString(condString)
 * 将字符串数组转化为以逗号为间隔的字符串
 * 
 * condString:字符串数组
 * */
 
/*
 * 20.extMenuConfig(text,handle)
 * 配置菜单项
 * 
 * text:菜单文字描述
 * handle:响应函数
 * */
 
/*
 * 21.extMenu(menuItem)
 * 创建Menu控件对象
 * 
 * menuItem:菜单配置数组
 * */
 
/*
 * 22.messageBox(title,msg,width,closable,isUsePrompt,fn,buttons,icon)
 * 创建对话框,返回messageBox对象,调用hide()可对其关闭
 * 
 * title:标题
 * msg:对话框内容
 * width:对话框宽度
 * closable:是否隐藏右上角关闭按钮
 * value:对话框文本值
 * fn:按钮触发事件函数    function(id,msg)
 * buttons:按钮类型  包括(NO,OK,YES,YESNO)
 * icon:图标类型  包括(ERROR,INFO,QUESTION,WARNING)
 * */
 
/*
 * 23.progressBox(title,msg,width,closable,isWaitProgress,progressText,icon)
 * 创建滚动条对话框,返回messageBox对象,调用hide()可对其关闭
 * 调用updateProgress(percentage,progressText,msg)函数可以更新进度条
 * 
 * title:标题
 * msg:对话框内容
 * width:对话框宽度
 * closable:是否隐藏右上角关闭按钮
 * isWaitProgress:true时使用的是自动模式滚动条,该滚动条需要使用hide()方法进行隐藏;false时使用的是手动模式,进度条的进度需要人工进行控制
 * progressText:滚动条上的文字
 * icon:滚动条使用的图标
 * */

/*
 * 24.startTaskManager(interval,fn)
 * 创建taskManager，返回Ext.TaskManager
 * 
 * interval:时间间隔
 * fn:运行的函数
 * */

/*
 * 25.stopTaskManager(task)
 * 停止taskManager运行
 * 
 * task:Ext.TaskManager对象
 * */
 
/*
 * 26.extProgressBar(width,renderTo,useWaitProgress,progressText,duration,interval,increment,fn)
 * 创建progressBar插件，返回progressBar对象
 * 
 * width:进度条宽度
 * renderTo:将控件布局到页面
 * useWaitProgress:是否使用自动模式
 * 
 * 下面参数只有在useWaitProgress为true的时候有效
 * duration:进度条运行时间
 * interval:时间间隔
 * increment:进度条更新次数
 * fn:更新完成后调用的回调函数
 * */
 
/*
 * 27.extTextField(id,fieldLabel,allowBlank,blankText,inputType,vType)
 * 创建text控件,该控件需要传入panel中展示
 * 
 * id:控件唯一id
 * fieldLabel:字段标签
 * allowBlank:是否为空
 * blankText:当字段不可为空的时候提示信息
 * inputType:字段类型,如‘password’
 * vType:验证类型，如'alpha,alphanum,email,url'
 * */


Ext.MessageBox.buttonText = {
		yes:'是',
		ok:'好的',
		no:'否',
		cancle:'取消'
};
//grid
function extGrid(url,params,boModel,gridRendto,gridId,gridTitle,gridWidth,gridHeigh,gridColumn,onDBclick,onRightClick){
	
	if(onDBclick==null)
		onDBclick = function(){};
		
	if(onRightClick==null)
		onRightClick = function(){};
	
	var gridProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			model:boModel,
			url:url,
			reader:{
				root:"data",
				type:"json"
			}
		});
	var gridStore = Ext.create('Ext.data.Store',{
		model:boModel,
		proxy:gridProxy
	});
	
	gridStore.load({
		params: params
	});
	
	var grid = Ext.create('Ext.grid.Panel',{
		id:gridId,
		title:gridTitle,
		renderTo:gridRendto,
		height:gridHeigh,
		width:gridWidth,
		frame:true,
		viewConfig:{
			forctFit:true,
			stripeRows:true
		},
		store:gridStore,
		listeners:{
			itemdblclick:onDBclick,
			itemcontextmenu:onRightClick
		},
		selType:'cellmodel',
		columns:gridColumn,
		dockedItems: [{
			xtype: 'toolbar',
			dock: 'top',
			items: [{
				xtype: 'exporterbutton',
				store: gridStore,
                downloadName:'需求信息导出'
            }]
		}]
	});
	
	return grid;
}

function extAutoGrid(url,params,gridRendto,gridId,gridTitle,gridWidth,gridHeigh,onDBclick,onRightClick){
	
	if(onDBclick==null)
		onDBclick = function(){};
		
	if(onRightClick==null)
		onRightClick = function(){};
	
	Ext.Ajax.request({   
		url:url,  
		params:params,
		success:function(response,config){ 
					var json=Ext.JSON.decode(response.responseText);
					var cm = json.columnModel;
					var store = new Ext.data.JsonStore({  
                    	data:json.data,   
                        fields:json.fieldsNames   
                    }); 
					var autoGrid = new Ext.grid.Panel({
	 						id:gridId,
	                    	title:gridTitle,   
	                        renderTo:gridRendto,   
	                        height:gridHeigh,   
	                        width: gridWidth,  
							frame:true,
							viewConfig:{
								forctFit:true,
								stripeRows:true
							},
							listeners:{
								itemdblclick:onDBclick,
								itemcontextmenu:onRightClick
							},
							selType:'cellmodel',
	                        columns:cm,   
	                        store:store
			        }); 
		}, 
        failure:function(){   
                	extAlert('提示','数据加载出错');
                }   
    });  
}

//commbo
function extCommbo(condValueField,condDisplayField,condTable,condString,commboRendto,commboId,commboLabel,isMutilSelect,width,labelWidth){
	Ext.regModel('extCommboModel', {
	    fields: [
	        {type: 'string', name: 'value'},
	        {type: 'string', name: 'text'}
	    ]
	});
	
	var condProxy = new Ext.data.proxy.Ajax({
			type:"ajax",
			model:"extCommboModel",
			url:ctx+'/getReportCond',
			reader:{
				root:"data",
				type:"json"
			}
		});
	var condStore = Ext.create('Ext.data.JsonStore',{
		model:"extCommboModel",
		proxy:condProxy
	});
	
	condStore.load({
		params: {
			condValueField:condValueField,
		    condDisplayField:condDisplayField,
			condTable:condTable,
			condString:condString
		}
	});
	var extCommbo = Ext.create('Ext.form.field.ComboBox', {
		id:commboId,
		renderTo:commboRendto,
	    fieldLabel: commboLabel,
	    multiSelect: isMutilSelect,
	    displayField: 'text',
	    valueField:'value',
	    width: width,
	    labelWidth: labelWidth,
	    store: condStore,
	    queryMode: 'local'
	});
	
	return extCommbo;
}

//radio
function extRadio(radioId,radioName,radioLabel,inputValue,isChecked,onChange){
	
	if(onChange == null)
		onChange = function(){};
		
	var radioConfig = {
			xtype:'radio',
			id:radioId,
			name:radioName,
			inputValue : inputValue,
			boxLabel:radioLabel,
			checked : isChecked,
			listeners:{
				change:onChange}
		};
	return radioConfig;
}

//radioGroup
function extRadioGroup(label,radioItem,columnNum,onchange){
	
	if(onchange == null)
		onchange = function(){};
	
	var extRadioGroup = {
					xtype:'radiogroup',
					fieldLabel:label,
					columns:columnNum,
					items:radioItem,
					listeners:{
						change:onchange
					}
				};
	return extRadioGroup;
}

function radioItem(id,boxLabel,name,inputValue){
	var radioItem = {
		boxLabel:boxLabel , name:name,inputValue:inputValue , id:id
	}
	
	return radioItem;
}

function extPanel(panelRendto,title,width,heigh,labelWidth,items,buttons){
	var panel = Ext.create('Ext.form.Panel',{
		title:title,
		renderTo:panelRendto,
		width: width,
		height:heigh,
		bodyPadding:5,
		frame:true,
		defaults:{
			labelSeparator:':',
			labelAlign:'left',
			labelWidth:labelWidth
		},
		items:items,
		buttons:buttons
	});
	
	return panel;
}

//menu
function extMenuConfig(text,handle){
	var menuConfig = {
        text: text,
        handler:handle};
    return menuConfig;
}

function extMenu(menuItems){
	var extMenu = Ext.create('Ext.menu.Menu',{items: menuItems});
	return extMenu;
}

//window
function extWindow(title,heigh,width,items,closable){
	var extWindow = new Ext.window.Window({
		title:title,
		layout:'fit',
		closeAction:'hide',
		resizable:false,
		height:heigh,
		width:width,
		shadow:true,
		modal:true,
		closable:closable,
		items:items
	});
	
	return extWindow;
}

//button
function extButton(text,onclick){
	var extButton = {
			text:text,
			handler:onclick
		}
	return extButton;
}

//messageBox
function messageBox(title,msg,width,closable,isUsePrompt,fn,buttons,icon){
	var button;
	var ic;
	
	if(buttons=='NO')
		button = Ext.Msg.NO;
	else if(buttons=='OK')
		button = Ext.Msg.OK;
	else if(buttons=='YES')
		button = Ext.Msg.YES;
	else if(buttons=='YESNO')
		button = Ext.Msg.YESNO;
		
	if(icon=='ERROR')
		ic = Ext.Msg.ERROR;
	else if(icon=='INFO')
		ic = Ext.Msg.INFO;
	else if(icon=='QUESTION')
		ic = Ext.Msg.QUESTION;
	else if(icon=='WARNING')
		ic = Ext.Msg.WARNING;
	
	var config = {
		title:title,
		msg:msg,
		width:width,
		modal:true,
		fn:fn,
		buttons:button,
		icon:ic,
		closable:closable
	};
	
	if(isUsePrompt==true){
		config.prompt = true;
		config.value = '';
	}
	
	return Ext.MessageBox.show(config);
}

function progressBox(title,msg,width,closable,isWaitProgress,progressText,icon){
	var ic;
	
	if(icon=='ERROR')
		ic = Ext.Msg.ERROR;
	else if(icon=='INFO')
		ic = Ext.Msg.INFO;
	else if(icon=='QUESTION')
		ic = Ext.Msg.QUESTION;
	else if(icon=='WARNING')
		ic = Ext.Msg.WARNING;
		
	var config = {
		title:title,
		msg:msg,
		modal:true,
		width:width,
		icon:ic,
		closable:closable
	};
	
	if(isWaitProgress==true){
		config.wait=true;
		config.waitConfig={text:progressText};
	}else{
		config.progress = true;
		config.progressText = progressText;
	}
	
	return Ext.MessageBox.show(config);
}

//tools
function getCommboValue(commbo){
	return commbo.getValue();
}

function getExtControl(controlId){
	return Ext.getCmp(controlId);
}

function getGridColnumNum(grid){
	var cell = grid.getSelectionModel().getCurrentPosition();
	return cell.column;
}

function getGridRowNum(grid){
	var cell = grid.getSelectionModel().getCurrentPosition();
	return cell.row;
}

function getGridRow(grid){
	var row = grid.getSelectionModel().getSelection();
	if(row.length!=0)
		return row[0];
	else
		return null;
}

function refreshGrid(grid,params){
	var store = grid.getStore();
	store.reload({
		params: params
	});
}

function refreshAutoGrid(grid,url,params){
	Ext.Ajax.request({   
		url:url,  
		params:params,
		success:function(response,config){ 
				var json=Ext.JSON.decode(response.responseText); 
				
				var store = new Ext.data.JsonStore({  
                    	data:json.data,   
                        fields:json.fieldsNames   
                });
    			grid.reconfigure(store,json.columnModel); 
                },   
        failure:function(){   
                	extAlert('提示','数据加载出错');
                }   
    });
}

function extAlert(title,message){
	Ext.Msg.alert(title,message,function(id){return;});
}

function extDateFormat(date,format){
	return Ext.util.Format.date(date,format);
}

function getLastYearOrMonth(temp){
	if(temp=='month'){
		var fisrtDate = Ext.Date.getFirstDateOfMonth(new Date());
		var lastMonth = Ext.util.Format.date(new Date(new Date(fisrtDate).getTime()-86400000),'m');
		var timeYear = Ext.util.Format.date(new Date(new Date(fisrtDate).getTime()-86400000),'Y');
		return timeYear+lastMonth;
	}
	if(temp=='year'){
		var beforeYear = Ext.util.Format.date(new Date(),'Y')-1;
		return beforeYear;
	}
	return '';
}

function getCurrentYearOrMonth(temp){
	if(temp=='month'){
		var month = Ext.util.Format.date(new Date(),'m');
		var timeYear = Ext.util.Format.date(new Date(),'Y');
		return timeYear+month;
	}
	if(temp=='year'){
		var currentYear = Ext.util.Format.date(new Date(),'Y');
		return currentYear;
	}
	return '';
}

function getInString(condString){
	var returnString = '';
	if(condString!=undefined&&condString!=''){
		for(var i=0;i<condString.length;i++){
			if(condString.length==1||i==condString.length-1)
				returnString = returnString+"'"+condString[i]+"'";
			else
				returnString = returnString+"'"+condString[i]+"'"+",";
		}
	}
	return returnString;
}

function startTaskManager(interval,fn){
	return Ext.TaskManager.start({
		run:fn,
		interval:interval
	});
}

function stopTaskManager(task){
	Ext.TaskManager.stop(task);
}

function extProgressBar(width,renderTo,useWaitProgress,progressText,duration,interval,increment,fn){
	
	var config = {
		width:width,
		renderTo:renderTo
	};
	
	var progressBar = new Ext.ProgressBar(config);
	
	var waitProgressConfig = {
		text:progressText
	};
	
	if(useWaitProgress==true){
		if(duration!=''&&duration!=null)
			waitProgressConfig.duration = duration;
		if(interval!=''&&interval!=null)
			waitProgressConfig.interval = interval;
		if(increment!=''&&increment!=null)
			waitProgressConfig.increment = increment;
			
		waitProgressConfig.scope = this;
		
		if(fn!=null)
			waitProgressConfig.fn = fn;
		else
			waitProgressConfig.fn = function(){};
		
		progressBar.wait(waitProgressConfig);
	}
	
	return progressBar;
}

function extTextField(id,fieldLabel,allowBlank,blankText,inputType,vType){
	var textFieldConfig = {
		id:id,
		xtype:'textfield',
		fieldLabel:fieldLabel,
		allowBlank:allowBlank
	};
	
	if(allowBlank == false)
		textFieldConfig.blankText = blankText;
	
	if(inputType!=null&&inputType!="")
		textFieldConfig.inputType = inputType;
		
	if(vType!=null&&vType!="")
		textFieldConfig.vtype = vType;
		
	return textFieldConfig;
}