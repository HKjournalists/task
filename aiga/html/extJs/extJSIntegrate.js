/*
 * 1.1 extGrid(url,params,boModel,gridRendto,gridId,gridTitle,gridWidth,gridHeigh,gridColumn,onDBclick,onRightClick)
 * ����grid���,����:Ext.grid.Panel����
 * url:�����ַ
 * params:���ݲ���
 * boModel:����ģ��
 * 
 * ʾ����var testDataModel = Ext.regModel("testDataModel",{
		fields:[
			{name:'a',type:'string'},
			{name:'b',type:'string'},
			{name:'c',type:'string'},
			{name:'d',type:'string'}]
	});
 * 
 * gridRendto:���ؼ����ֵ�ҳ��   ��ҳ��<div id='test'></div>����gridRendto�Ĳ���ֵӦΪ'test'
 * gridId:����grid��Ψһ��ʶid
 * gridTitle:����grid����
 * gridWidth:����grid���
 * gridHeigh:����grid�߶�
 * gridColumn:grid������
 * 
 * ʾ��:var gridColumn = [{header:"a",width:100,dataIndex:"a",sortable:true},
		{header:"b",width:100,dataIndex:"b",sortable:true},
		{header:"c",width:100,dataIndex:"c",sortable:true},
		{header:"d",width:100,dataIndex:"d",sortable:true}];
 * header:����  dataIndex:��Ӧ����ģ��name  sortable:�ɷ�����
 * 
 * onDBclick:����˫���¼�  ˫���¼�����:function(grid,record,option)
 * onRightClick:��������Ҽ�ʱ��   �Ҽ��¼�����:function(view,record,item,index,e,eOpts)
 * */
 
/*
 * 1.2 extAutoGrid(url,params,gridRendto,gridId,gridTitle,gridWidth,gridHeigh,onDBclick,onRightClick)
 * ����grid���,�ò�����ܷ���grid�����������getExtControl(controlId)������ȡ
 * 
 * url:�����ַ
 * params:���ݲ���
 * gridRendto:���ؼ����ֵ�ҳ��   ��ҳ��<div id='test'></div>����gridRendto�Ĳ���ֵӦΪ'test'
 * gridId:����grid��Ψһ��ʶid
 * gridTitle:����grid����
 * gridWidth:����grid���
 * gridHeigh:����grid�߶�
 * 
 * onDBclick:����˫���¼�   ˫���¼�����:function(grid,record,option)
 * onRightClick:��������Ҽ�ʱ��   �Ҽ��¼�����:function(view,record,item,index,e,eOpts)
 * */
 
/*
 * 2.extCommbo(condValueField,condDisplayField,condTable,condString,commboRendto,commboId,commboLabel,isMutilSelect,width,labelWidth)
 * ����commbo���,����:Ext.form.field.ComboBox����
 * 
 * condValueField:ֵ�ֶ�
 * condDisplayField:��ʾ�ֶ�
 * condTable:���ݿ��
 * condString:sql����������
 * commboRendto:���ؼ����ֵ�ҳ��ı�ǩ��
 * commboId:Ψһ��ʾ��
 * commboLabel:commbo���ֶα�ǩ
 * isMutilSelect:commbo�Ƿ�ɶ�ѡ
 * width:commbo�Ŀ��
 * labelWidth:label�Ŀ��
 * */

/*
 * 3.extRadio(radioId,radioName,radioLabel,inputValue,isChecked,onChange)
 * ����radio���,�ò����Ҫ��radioPanel��չʾ,�ɵ���5�еĺ�������չʾ
 * 
 * radioId:radio��Ψһ��ʶ
 * radioName:radio��name,��name��ϵ�����飬��ͬһ���radio��nameӦ������ͬ��
 * radioLable:radio���ֶα�ǩ
 * inputValue:radio��Ӧ��valueֵ
 * isChecked:�Ƿ�ѡ��
 * onChange:onChange�¼�������Ϊfunction(group, newValue, oldValue) newValueΪ��ѡ�е�ֵ��oldValueΪ�ɵ�ֵ��ʹ�õ�ʱ����Ҫ�ж�if(newValue==true)
 * */
 
 
/*
 * 4.radioItem(id,boxLabel,name,inputValue)
 * ����radioGroup��item����
 * 
 * id:radio��Ψһ��ʶ
 * boxLabel:radio���ֶα�ǩ
 * name:��name��ϵ�����飬��ͬһ���radio��nameӦ������ͬ��
 * inputValue:radio��Ӧ��valueֵ
 * */
 
/*
 * 5.extRadioGroup(label,radioItem,columnNum,onchange)
 * ����radioGroup���,�ò����Ҫ����radioPanel��չʾ
 * 
 * label:radioGroup���ֶα�ǩ
 * radioItem:
 * columnNum:radio����
 * onchange�¼�������Ϊfunction(group, newValue, oldValue) newValueΪ��ѡ�е�ֵ��oldValueΪ�ɵ�ֵ��ʹ�õ�ʱ����Ҫ�ж�if(typeof newValue.radiogroup == 'string')
 * */
 
/*
 * 6.extPanel(panelRendto,title,width,heigh,items,buttons)
 * �������
 * 
 * panelRendto�����ؼ����ֵ�ҳ��ı�ǩ��
 * title:������
 * width:���
 * heigh:�߶�
 * items:�ؼ�����
 * buttons:������尴ť,����extButton(text,onclick)�����������ã�������鿴�ú�����ʹ��
 * */

/*
 * 7.extWindow(title,heigh,width,items,closable)
 * ����window����
 * 
 * title:���ڱ���
 * heigh:���ڸ߶�
 * width:���ڿ��
 * items:���봰�ڵĿؼ����ɷ���panel�ؼ�
 * closable:�Ƿ����عرհ�ť
 * */
 
/*
 * 8.extButton(text,onclick)
 * ����panel�е�button��ť
 * 
 * text:��ť������
 * onclick:��ť�����¼�
 * */
 
/*
 * 9.getExtControl(controlId)
 * ��ȡ�ؼ�����
 * 
 * controlId:�ؼ�id
 * */
 
/*
 * 10.getGridColnumNum(grid)
 * ��ȡgrid��ѡ�е���
 * 
 * grid:grid�ؼ�����
 * */
 
/*
 * 11.getGridRowNum(grid)
 * ��ȡgrid��ѡ�е�����
 * 
 * grid:grid�ؼ�����
 * */
 
/*
 * 12.extAlert(title,message)
 * ����alert�Ի���
 * 
 * title:����
 * message:��ʾ����Ϣ
 * */
 
/*
 * 13.extDateFormat(date,format)
 * �������ڸ�ʽ
 * 
 * date:���ڣ�Date����
 * format:���ڸ�ʽ,��'Y-m-d h:m:s'
 * */
 
/*
 * 14.getLastYearOrMonth(temp)
 * ��ȡ��һ�����һ��
 * 
 * temp:ֻ�ɴ���'month'��'year'
 * */
 
/*
 * 15.getCurrentYearOrMonth(temp)
 * ��ȡ��ǰ�����
 * 
 * temp:ֻ�ɴ���'month'��'year'
 * */
 
/*
 * 16.getCommboValue(commbo)
 * ��ȡcommbo��Valueֵ
 * 
 * commbo��commbo�������
 * */
 
/*
 * 17.getGridRow(grid)
 * ��ȡ������
 * 
 * grid:grid�������
 * */
 
/*
 * 18.refreshGrid(grid)
 * ˢ��grid
 * 
 * grid:grid�������
 * */
 
/*
 * 19.getInString(condString)
 * ���ַ�������ת��Ϊ�Զ���Ϊ������ַ���
 * 
 * condString:�ַ�������
 * */
 
/*
 * 20.extMenuConfig(text,handle)
 * ���ò˵���
 * 
 * text:�˵���������
 * handle:��Ӧ����
 * */
 
/*
 * 21.extMenu(menuItem)
 * ����Menu�ؼ�����
 * 
 * menuItem:�˵���������
 * */
 
/*
 * 22.messageBox(title,msg,width,closable,isUsePrompt,fn,buttons,icon)
 * �����Ի���,����messageBox����,����hide()�ɶ���ر�
 * 
 * title:����
 * msg:�Ի�������
 * width:�Ի�����
 * closable:�Ƿ��������Ͻǹرհ�ť
 * value:�Ի����ı�ֵ
 * fn:��ť�����¼�����    function(id,msg)
 * buttons:��ť����  ����(NO,OK,YES,YESNO)
 * icon:ͼ������  ����(ERROR,INFO,QUESTION,WARNING)
 * */
 
/*
 * 23.progressBox(title,msg,width,closable,isWaitProgress,progressText,icon)
 * �����������Ի���,����messageBox����,����hide()�ɶ���ر�
 * ����updateProgress(percentage,progressText,msg)�������Ը��½�����
 * 
 * title:����
 * msg:�Ի�������
 * width:�Ի�����
 * closable:�Ƿ��������Ͻǹرհ�ť
 * isWaitProgress:trueʱʹ�õ����Զ�ģʽ������,�ù�������Ҫʹ��hide()������������;falseʱʹ�õ����ֶ�ģʽ,�������Ľ�����Ҫ�˹����п���
 * progressText:�������ϵ�����
 * icon:������ʹ�õ�ͼ��
 * */

/*
 * 24.startTaskManager(interval,fn)
 * ����taskManager������Ext.TaskManager
 * 
 * interval:ʱ����
 * fn:���еĺ���
 * */

/*
 * 25.stopTaskManager(task)
 * ֹͣtaskManager����
 * 
 * task:Ext.TaskManager����
 * */
 
/*
 * 26.extProgressBar(width,renderTo,useWaitProgress,progressText,duration,interval,increment,fn)
 * ����progressBar���������progressBar����
 * 
 * width:���������
 * renderTo:���ؼ����ֵ�ҳ��
 * useWaitProgress:�Ƿ�ʹ���Զ�ģʽ
 * 
 * �������ֻ����useWaitProgressΪtrue��ʱ����Ч
 * duration:����������ʱ��
 * interval:ʱ����
 * increment:���������´���
 * fn:������ɺ���õĻص�����
 * */
 
/*
 * 27.extTextField(id,fieldLabel,allowBlank,blankText,inputType,vType)
 * ����text�ؼ�,�ÿؼ���Ҫ����panel��չʾ
 * 
 * id:�ؼ�Ψһid
 * fieldLabel:�ֶα�ǩ
 * allowBlank:�Ƿ�Ϊ��
 * blankText:���ֶβ���Ϊ�յ�ʱ����ʾ��Ϣ
 * inputType:�ֶ�����,�确password��
 * vType:��֤���ͣ���'alpha,alphanum,email,url'
 * */


Ext.MessageBox.buttonText = {
		yes:'��',
		ok:'�õ�',
		no:'��',
		cancle:'ȡ��'
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
                downloadName:'������Ϣ����'
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
                	extAlert('��ʾ','���ݼ��س���');
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
                	extAlert('��ʾ','���ݼ��س���');
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