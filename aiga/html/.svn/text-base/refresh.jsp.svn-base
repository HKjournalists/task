<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>刷新</title>
</head>
<body>
	<jsp:include page="/aiga/common/common.jsp"></jsp:include>
<div id="elId"></div>
</body>
<style>
.textRed{color:red;}
.textGreen{color:green;}
.textYellow{color: yellow;}
</style>
<script type="text/javascript">
var screenWidth = document.documentElement.clientWidth;
var screenHeight = document.documentElement.clientHeight;
function removeHTMLTag(str) {
    str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
    str = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
    //str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
    str=str.replace(/&nbsp;/ig,'');//去掉&nbsp;
    return str;
}
try{
Ext.onReady(function(){
	Ext.QuickTips.init();
	Ext.tip.QuickTipManager.init();
    	var sysContentModel= Ext.define('sysContentModel', {
    	    extend: 'Ext.data.Model',
    	    fields: [
    	        {name: 'constantId',  type: 'string'},
    	        {name: 'categoryName', type: 'string'},
    	        {name: 'category', type: 'string'},
    	        {name: 'show', type: 'string'},
    	        {name: 'value', type: 'string'},
    	        {name: 'other1', type: 'string'},
    	        {name: 'other2', type: 'string'},
    	        {name: 'memo', type: 'string'}
    	    ]
    	});
    	var sysContentStore=new  Ext.data.Store({
    		id: 'sysContentStore',
    		model: sysContentModel,
    		proxy: {
    			type: 'ajax',
    			url: '<%=request.getContextPath()%>/getSysConstantStore.do?category=AIGA_REFRESH_CACHE',
    			reader: {
    				type: 'json',
    				root: 'data'
    			}
    		},
    		filters: [
    		          //过滤掉不合格的Record
    		          {filterFn: function(item) { return item.raw.other2!='';}}
    		      ],
    		listeners:{
    			beforeload:function( store, operation,  eOpts ){
    			},
    			load:function( store, records, successful, eOpts ){
    			}
    		}
    	});
    	sysContentStore.load({params:{category:'AIGA_REFRESH_CACHE'}});
	var combo=new Ext.create('Ext.form.ComboBox', {
	    fieldLabel: '刷新',
	    id:'refreshCombo',
	    store: sysContentStore,
	    displayField: 'show',
	    valueField: 'value',
	    listeners:{
	    	select:function( combo, records, eOpts ){
	    		combo.setRawValue(removeHTMLTag(combo.getRawValue()));
	    	}
	
	    }
	});
	Ext.create('Ext.Panel', {
		title:'刷新页面',
	    renderTo: Ext.getBody(),
	    cls: 'ui-formPanel',
	    width: screenWidth * 0.98,
	    height: screenHeight*0.98,
	    layout: {
	        type: 'vbox',
	        align: 'stretch',
	        padding: '100 0 0 0'
	    },
	    defaults: {
	        split: true,
	        collapsible: false,
	        bodyStyle: 'padding:0px'
	    },
	    items: [{
	            region: 'center',
	            items: [{
	                xtype: 'fieldcontainer',
	                labelStyle: 'font-weight:bold;padding:0',
	                layout: 'hbox',
	                bodyPadding: '30 5 5 500',
	               	width: screenWidth*0.8*0.985,   
	        		height: screenHeight*0.2, 
	                defaultType: 'textarea',
	                fieldDefaults: {
	                    labelAlign: 'right'
	                },
	                items: [
	                        combo,
	                        {xtype: 'button',text: '刷新',handler: function () {
	                        	try{
	                        	
		                        	var combo=Ext.getCmp("refreshCombo");
		                        	var sysContentStore=combo.getStore();
		                            var myMask = new Ext.LoadMask(Ext.getBody(), {
		                                msg: '正在刷新，请稍后！',
		                                removeMask: true //完成后移除
		                            });
		                        	myMask.show();
		                        	 var resultLabel=Ext.getCmp("resultLabel");
		                        	 resultLabel.removeCls('textGreen','textRed' );
		                        	  resultLabel.addCls('textYellow') ;
	                  	    	   resultLabel.setText("等待刷新结果...");
		                        	var url='<%=request.getContextPath()%>'+sysContentStore.findRecord('value',combo.getValue()).data.other2;
		                        	Ext.Ajax.request({
		                        	    url: url,
		                        	    params: {},
		                        	    success: function(response){
		                        	        var text = response.responseText;
		                        	       var resultJSON=Ext.JSON.decode(text,true );
		                        	       if(resultJSON.success){
		                        	    	   var resultLabel=Ext.getCmp("resultLabel");
		                        	    	   resultLabel.setText(resultJSON.message);
		                        	    	   resultLabel.removeCls('textYellow');
		                        	    	   resultLabel.addCls('textGreen' ) ;
		                        	       }else{
		                        	    	   var resultLabel=Ext.getCmp("resultLabel");
		                        	    	   resultLabel.setText(resultJSON.message);
		                        	    	   resultLabel.removeCls('textYellow','textGreen');
		                        	    	   resultLabel.addCls('textRed' ) ;
		                        	    	   Ext.Msg.alert("提示",resultJSON.message);
		                        	       }
		                        	        myMask.hide();
		                        	    }
		                        	});
	                        	
	                        	}catch(e){
	                        		Ext.Msg.alert("提示",e.message);
	                        	}
	                        }}
	                ]
	            }]
	        },
	        {
	            region: 'center',
	            items: [{
	                xtype: 'fieldcontainer',
	                labelStyle: 'font-weight:bold;padding:0',
	                layout: 'hbox',
	                bodyPadding: '30 5 5 500',
	               	width: screenWidth*0.8*0.985,   
	        		height: screenHeight*0.2, 
	                defaultType: 'textarea',
	                fieldDefaults: {
	                    labelAlign: 'right'
	                },
	                items: [{
	                    xtype: 'label',
	                    id:'resultLabel',
	                    name: 'message',
	                    html: '<font class="textRed">未刷新</font>',
	                    bodyPadding: '30 5 5 500',
	                    readOnly:true
	                } ]
	            }]
	        }
	    ]
	});
});
}catch(e){
	document.write("未登录异常");
}
</script>

</html>