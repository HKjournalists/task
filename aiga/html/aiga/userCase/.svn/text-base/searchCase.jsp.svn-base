<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/aiga/common/common.jsp" %>
<%
	String subTaskId = request.getParameter("subTaskId");
	String elemTag = request.getParameter("elemTag");
%>
<html>
<head>
	<title>用例搜索</title>
</head>
<body>
</body>
<style>
.highlight{color:red;};
.my-panel-no-border{border-style:none}
.labelOverCls{border:1px solid #fad649 !important}
.labelTypeOverCls{border:1px solid #fad649 !important}
.labelBaseCls{border:1px solid #000000;}
</style>
<script type="text/javascript">
var copyCaseId = '';
var subTaskId = '${param.subTaskId}';
var elemTag = '${param.elemTag}';
var extjsFolderPath='<%=request.getContextPath()%>/extJs';
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
var labelArray=new Array();
var caseIds = new Array();

caseIds.push(0);
function checkSelect(caseId){
	var isSelect = false;
	for(var i=0;i<caseIds.length;i++){
		if(caseId==caseIds[i]){
			isSelect=true;
			break;
		}
	}
	return isSelect;
}
function deleteSelect(caseId){
	for(var i=0,n=caseIds.length;i<n;i++){
		if(caseIds[i]==caseId)
			caseIds.splice(i,1);
	}
}
function removeHTMLTag(str) {
    str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
    str = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
    //str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
    str=str.replace(/&nbsp;/ig,'');//去掉&nbsp;
    return str;
}
function checkSelect(caseId){
	var isSelect = false;
	for(var i=0;i<caseIds.length;i++){
		if(caseId==caseIds[i]){
			isSelect=true;
			break;
		}
	}
	return isSelect;
}
Ext.MessageBox.buttonText = {
		yes:'是',
		ok:'好的',
		no:'否',
		cancle:'取消'
};


Ext.onReady(function() {
MaskLoading();
Ext.Ajax.request({
    url: '<%=request.getContextPath()%>/getLabels.do',
    params: {},
    success: function(response){
    	MaskOver();
    //console.log(eval(response.responseText));
     var data=eval(response.responseText);
      for(var i=0,n=3;i<n;i++){
         var comp=Ext.getCmp('label'+i);
         if(data[i]==undefined){
        	 comp.hide();
        	 continue;
         }
         if(comp==undefined)break;
     		comp.setText(data[i]);
        }
      
    }
});
Ext.QuickTips.init();
//tooltip初始化
Ext.tip.QuickTipManager.init();
var searchField = Ext.create('Ext.data.Store', {
    fields: ['abbr', 'name'],
    data : [
        {"abbr":"caseName", "name":"用例名称"},
        {"abbr":"caseDesc", "name":"用例描述"}
    ]
});
	var caseFieldCombox = new Ext.form.ComboBox({
		width: 200,
	  	store: searchField,
    	queryMode: 'local',
    	displayField: 'name',
    	valueField: 'abbr',
    	value:"caseName",
		fieldLabel : "查找条件",
		 listeners:{
			 select:function( combo, records, eOpts ){
				 var combox=Ext.getCmp("searchComBox");
				 combox.displayField="caseName";
				 //console.log(Ext.getCmp("searchComBox"));
			 }
         }
		});
	/*******搜索框*****/
		Ext.regModel('searchModel', {
	    fields: [
	        {type: 'string',name:'caseName',mapping:'caseName'},
	        {type: 'string',name:'caseDesc',mapping:'caseDesc'},
	        {type: 'string',name:'caseId',mapping:'caseId'}
	    ]
	});
	    searchStore = Ext.create('Ext.data.Store', {
			storeId:'searchStore',
			model:"searchModel",
		    proxy: {
		        type: 'ajax',
	        	url : '<%=request.getContextPath()%>/searchCaseByMoreInfo.do',
		        reader: {
					type:"json"
		        }
		    }
		});
 var condPanel=Ext.create('Ext.form.Panel', {
      border:0,
      bodyPadding:"10 0 0 10",
    items: [
        {
        	id:"caseType",
            xtype: 'radiogroup',
            fieldLabel: '用例类型',
            layout:'column',
            items: [
                {
                	xtype: 'label',
                	text: '手工',
                    name      : 'caseType',
                    margin: '3 3 3 10',
                    baseCls:'labelBaseCls',
                    listeners:{
                        click: {
                           element: 'el', 
                           fn: function(){
                           var comp=Ext.getCmp(this.id);
                           if(!comp.hasCls("labelTypeOverCls")){
                           	comp.addCls("labelTypeOverCls");
                           }else{
                           comp.removeCls("labelTypeOverCls");
                           }
                           
                             }
                       },
                       }
                }, {
                	xtype: 'label',
                	text: '自动化',
                    name      : 'caseType',
                    margin: '3 3 3 10',
                    baseCls:'labelBaseCls',
                    listeners:{
                        click: {
                           element: 'el', 
                           fn: function(){
                           var comp=Ext.getCmp(this.id);
                           if(!comp.hasCls("labelTypeOverCls")){
                           	comp.addCls("labelTypeOverCls");
                           }else{
                           comp.removeCls("labelTypeOverCls");
                           }
                           
                             }
                       },
                       }
                }
            ]
        },
        {
        xtype: 'label',
        id:"label0",
        border:"1 1 1 1",
        baseCls:'labelBaseCls',
        text: '标签1',
        margin: '3 3 3 10',
        listeners:{
         click: {
            element: 'el', 
            fn: function(){
            var comp=Ext.getCmp(this.id);
            if(!comp.hasCls("labelOverCls")){
            	comp.addCls("labelOverCls");
            }else{
            comp.removeCls("labelOverCls");
            }
            
              }
        },
        }
    }
     , {
         xtype: 'label',
         id:"label1",
        border:"1 1 1 1",
        baseCls:'labelBaseCls',
        text: '标签2',
       margin: '1 1 1 10',
        listeners:{
         click: {
            element: 'el', 
            fn: function(){
            var comp=Ext.getCmp(this.id);
            if(!comp.hasCls("labelOverCls")){
            	comp.addCls("labelOverCls");
            }else{
            comp.removeCls("labelOverCls");
            }
            
              }
        },
        }
    }
      ,{
         xtype: 'label',
        border:"1 1 1 1",
        id:"label2",
        baseCls:'labelBaseCls',
        forId: 'myFieldId',
         text: '标签3',
        margin: '1 1 1 10',
        listeners:{
         click: {
            element: 'el', 
            fn: function(){
            var comp=Ext.getCmp(this.id);
            if(!comp.hasCls("labelOverCls")){
            	comp.addCls("labelOverCls");
            }else{
            comp.removeCls("labelOverCls");
            }
            
              }
        },
        }
    }
    ],
    renderTo: Ext.getBody()
});
	var searchForm=null;
	searchForm = Ext.widget({
        xtype: 'form',
        layout: 'column',
       // frame: true,
        collapsible: true,
        id: 'searchForm',
        title: '搜索',
        bodyPadding: '30 5 5 200',
       	width: 1000,   
		height: 200, 
        fieldDefaults: {
           // msgTarget: 'side',
           // labelWidth: 50,
            width:400
        },
        items: [caseFieldCombox,{
        	/**输入comBox配置*****/
            xtype: 'combo',
            id:"searchComBox",
            minChars:1,
            store: searchStore,
            queryCaching :true,
            queryParam : 'kw',
            displayField: 'caseName',
            typeAhead: true,
            typeAheadDelay : 800,
            hideLabel: true,
            hideTrigger:true,
            anchor: '100%',
            listeners:{
            	beforequery: function( queryEvent,  eOpts ){
            	var queryData={caseField:"",caseValue:""};
            	var caseField=caseFieldCombox.getValue();
            	var searchComBox=Ext.getCmp("searchComBox");
            	if(caseField!=""&&searchComBox.getValue()!=null&&searchComBox.getValue()!="null"){
            	queryData.caseField=caseField;
            	queryData.caseValue=searchComBox.getValue();
            	queryEvent.query="{"+caseField+":\""+searchComBox.getValue()+"\"}";
            	}else return;
            	},
            	select: function(comp, The, eOpts){
            		//console.log(The);
            		comp.setValue(removeHTMLTag(The[0].raw.caseName));
					return;  
            	},
            	change:function(combo,newValue,oldValue,eOpts ){
            		if(newValue==''){
            			Ext.data.StoreManager.lookup('caseTreeStore').load();
            			return;
            		}
            	}
            },
            listConfig: {
                loadingText: 'Searching...',
                emptyText: '没有搜索到结果',
                // Custom rendering template for each item
                getInnerTpl: function(displayField) {
                	
                    return "<div style='border:1px solid #a6a6a6;'><span>{[values.caseName]}</span><div style='border-bottom:1px dashed #000000;'></div><span>{[values.caseDesc]}</span></div>";
                }
            }
        },{
        margin:'0 0 0 5',
      	// columnWidth: .23,
        xtype:'button',
        text: '搜索',
            handler: function() {
            var caseField,caseValue,kw,label="",caseType="";
            $("label.labelOverCls").each(function(){
            	label+=$(this).html()+",";
            });
            $("label.labelTypeOverCls").each(function(){
            	if($(this).html()=="自动化")
            	caseType+=1+",";
            	else
            	caseType+=2+",";
            	
                });
            
            	var caseField=caseFieldCombox.getValue();
            	var searchComBox=Ext.getCmp("searchComBox");
            	if(caseField!=""&&searchComBox.getValue()!=null&&searchComBox.getValue()!="null"){
            	var kw="{"+caseField+":\""+searchComBox.getValue()+"+"+"\"}";
            	}
            	//console.log(kw);
            	label=label.substring(0,label.length-1);
            	caseType=caseType.substring(0,caseType.length-1);
               gridStore.reload({params:{kw: kw,label:label,caseType:caseType}});
            }
            },condPanel]
    });

var caseModel = Ext.regModel("compModel",{
	fields:[
		{name:'caseId',type:'string'},
		{name:'caseName',type:'string'},
		{name:'parentId',type:'string'},
		{name:'caseDesc',type:'string'},
		{name:'createTime',type:'string'},
		{name:'updateTime',type:'string'},
		{name:'author',type:'string'},
		{name:'latestOperator',type:'string'},
		{name:'elemId',type:'string'},
		{name:'caseType',type:'string'}
		]
	});
var caseModel = Ext.regModel("compModel",{
	fields:[
		{name:'caseId',type:'string'},
		{name:'caseName',type:'string'},
		{name:'parentId',type:'string'},
		{name:'caseDesc',type:'string'},
		{name:'createTime',type:'string'},
		{name:'updateTime',type:'string'},
		{name:'author',type:'string'},
		{name:'latestOperator',type:'string'},
		{name:'sysLabel',type:'string'},
		{name:'elemId',type:'string'},
		{name:'caseType',type:'string'}
		]
	});
	gridStore = Ext.create('Ext.data.Store', {
		storeId:'caseStore',
	  	model: caseModel,
	    proxy: {
	    	url : '<%=request.getContextPath()%>/searchCaseMoreInfo.do',
	        type: 'ajax',
	        reader: {
	            type: 'json',
	            root: 'data'
	        }
	    }
	});
	gridStore.load();
		var caseGrid = Ext.create('Ext.grid.Panel',{
		id:'caseGrid',
		title:'选择用例',
        margins : '0 0 0 3',
        height:300,
        width:1000,
       //tbar:tbar,
        autoScroll : true,
		forctFit:true,
        stripeRows:true,//斑马线效果   
        loadMask:true,
		listeners:{
			itemdblclick:function(grid,record,item,index,e,eOpts){
				var url = '';
				if(record.raw.caseType=='1')
					url= '<%=request.getContextPath()%>/aiga/userCase/comp.jsp?caseId='+record.raw.caseId+'&parentId=';
				else if(record.raw.caseType=='2')
					url= '<%=request.getContextPath()%>/aiga/manualTask/manualTask.jsp?caseId='+record.raw.caseId+'&parentId=';
				else{
					Ext.Msg.alert('提示','用例类型错误');
					return;
				}
	        	var editWin = new top.Ext.window.Window({
				    id:'editWin',
				    title : '编辑用例',
				    width : '950',
				    height : '600',
				    modal : true,
				    constrain:true,
				    closeAction : 'destroy',
				    html:'<iframe id="frame" name="frame" src="'+url+'" width="950" height="600"/>'
			   });
			   editWin.show();
			}
		},
		store:Ext.data.StoreManager.lookup('caseStore'),
		selType:'rowmodel',
		columnLines: true, 
		selModel:Ext.create("Ext.selection.CheckboxModel"),
		columns:[new Ext.grid.RowNumberer(),
				{header: "用例ID", width:100, sortable: true, dataIndex: 'caseId',hidden:true},
				{header: "用例名称", width:200, sortable: true, dataIndex: 'caseName'},
				{header: "父ID", width:100, sortable: true, dataIndex: 'parentId',hidden:true},
				{header: "用例描述", width:300, sortable: true, dataIndex: 'caseDesc'},
				{header: "公有标签", width:300, sortable: true, dataIndex: 'sysLabel'},
        		{header: "创建时间", width:100,sortable: true, dataIndex: 'createTime',hidden:true},
        		{header: "修改时间", width:100, sortable: true, dataIndex: 'updateTime',hidden:true},
        		{header: "作者", width:100, sortable: true, dataIndex: 'author',hidden:true},
        		{header: "最后修改人", width:100, sortable: true, dataIndex: 'latestOperator',hidden:true},
        		{header: "要素ID", width:100, sortable: true, dataIndex: 'elemId',hidden:true,hidden:true},
        		{header: "用例类型", width:100, sortable: true, dataIndex: 'caseType',renderer:function(value){if(value=='1')return '自动化'; else if(value=='2')return '手工';}},
        		{header: "操作", width:50,menuDisabled: true,xtype:'actioncolumn',sortable:false,items: [{
        				icon:"<%=request.getContextPath()%>/aiga/label/image/del.gif",
        				id:'delVal',
        				tooltip:'删除',
        				handler:function(grid, rowIndex, colIndex){
        					var selectCase = caseGrid.getStore().getAt(rowIndex);
		                    if(checkSelect(selectCase.raw.caseId)==true){
			                    deleteSelect(selectCase.raw.caseId);
			                    var caseTreeStore = Ext.data.StoreManager.lookup('caseTreeStore');
			                    var selectNode = caseTreeStore.getNodeById(selectCase.raw.caseId);
			                    if(typeof selectNode != 'undefined')
			                    	selectNode.set('checked',false);
		                    }
		                    if(elemTag==''){
		                		Ext.Msg.alert('提示','未找到测试元素tag');
		                		return;
		                	}
		                    gridStore.reload({params:{caseIds:caseIds.join(",")}});
		        		}
		        	}]
		        }
        ],
        dockedItems: [{ 
            dock: 'top',
            xtype: 'toolbar',  
            items: [{ 
                id: 'save',
                text:'添加用例',
                tooltip:'保存要素与用例关联',
                icon:'<%=request.getContextPath()%>/aiga/userCase/image/add.gif',
                handler:function(){
                	  var grid=Ext.getCmp("caseGrid");
                      var records = grid.getSelectionModel().getSelection();
                     // console.log(records);
                  	var arr = new Array();
                   	for(var i=0;i<records.length;i++){
                   		arr[i]=records[i].data.caseId;
                   	}
                	if(elemTag==''){
                		Ext.Msg.alert('提示','未找到测试元素tag');
                		return;
                	}
                	MaskLoading();
                    Ext.Ajax.request({  
						url:"<%=request.getContextPath()%>/addRElemCase.do?elemTag="+elemTag+"&caseIds="+arr.join(','),  
						success:function(response,config){ 
							MaskOver();
						},
						failure:function(response,config){
							MaskOver();
							Ext.Msg.alert('提示','保存要素与用例关联失败');
						}
					});
                } 
            }] 
		}] 
	}); 
	
	Ext.create('Ext.form.Panel', {
			renderTo : Ext.getBody(),
			width : screenWidth,
			height : screenHeight * 0.99,
			layout : 'border',
			layout : {
				type : 'hbox',
				align : 'stretch',
				padding : 0
			},
			defaults : {
				split : true,
				collapsible : false,
				bodyStyle : 'padding:0px'
			},
			items : [ {
				region : 'center',
				items : [searchForm,caseGrid]
			} ]
		});
	});
	</script>
</html>