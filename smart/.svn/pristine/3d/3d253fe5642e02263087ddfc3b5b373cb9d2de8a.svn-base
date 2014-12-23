Ext.define('SmartApp.controller.BatchManageCtrl', {
    extend: 'Ext.app.Controller',
    views: ['Batch.BatchView', 'Batch.ScriptSelectView', 'Batch.BatchExecView'],
    models: ['Batch'],
    stores: ['BatchStore'],
    
    init: function () {
        this.control({

        	'batchview button[action=search]':{
        		click: this.searchBatch
        	},
            'batchview button[action=append]':{
                click: this.appendBatch
            },
            'batchview button[action=delete]':{
                click: this.deleteBatch
            },
            'batchview button[action=save]':{
                click: this.saveBatch
            },
            'batchview button[action=addscripts]':{
            	click: this.addScripts
            },
            'batchexecview button[action=search]':{
        		click: this.searchBatch
        	},
            'batchexecview button[action=saveexecconfig]':{
            	click: this.saveExecConfig
            }
        });
    },
    appendBatch: function(btn){
        var store = btn.up('gridpanel').getStore();
        var r = Ext.create('SmartApp.model.Batch',{
            batchname: "",
            comments: ""
        });
        store.insert(0,r);
        var rowEditing = btn.up('gridpanel').editingPlugin;
        rowEditing.startEdit(0, 0);
    },
    deleteBatch: function(btn){
        var store = btn.up('gridpanel').getStore();
        var grid = btn.up('gridpanel');
        var sm = grid.getSelectionModel();
        store.remove(sm.getSelection());
        
       
        if (store.getCount() > 0) {
            sm.select(0);
        };
    },
    saveBatch: function(btn){
        var store = btn.up('gridpanel').getStore();
        store.sync({
            callback : function(e){
            	if(!e.hasException)
            		Ext.Msg.alert('提示', '保存完毕');
            }
        });
    },
    searchBatch: function(btn){
    	var store = btn.up("panel").up("panel").down("gridpanel").getStore();
    	var search_name = btn.up("panel").down("textfield[name=search_name]").getValue();
    	store.load({params:{name: search_name}});
    
    },
    addScripts: function(btn){
    	var store = btn.up('gridpanel').getStore();
        var grid = btn.up('gridpanel');
        var sm = grid.getSelectionModel();
        if(sm.getSelection().length<=0){
        	Ext.Msg.alert("提示", "请选择一个计划");
        	return;
        }
        if(sm.getSelection()[0].data.batchid == undefined || sm.getSelection()[0].data.batchid == ""){
        	Ext.Msg.alert("提示", "请先保存该计划");
        	return;
        }
        
        
        var tree_store = Ext.create('Ext.data.TreeStore', {
            root: {
                text: '系统',
                checked: false,
        		expanded: true
        	},
        	nodeParam: 'id',
        	proxy: {
        	  type: 'direct',
        	  directFn: batchManageAction.getTree,
        	  extraParams: {
        		  batchid: sm.getSelection()[0].data.batchid
        	  }
        	}
          });
        
        
        Ext.create('Ext.window.Window', {
            title: '选择脚本',
            height: 400,
            width: 260,
            layout: 'fit',
            autoScript: true,
            items: {
                xtype: 'scriptselectview',
                store: tree_store
               
            },
            buttons:[
                    {
                    	text:"保存",
                    	handler:function(btn){
                    		var tree = btn.up("window").down("treepanel");
                    		var nodes = tree.getChecked();
                    		var ids = [];
                    		for(i = 0; i < nodes.length; i++){
                    			var cs = nodes[i];
                    			var node_id = nodes[i].data.id;
                    			if(node_id.substring(0,3) == "SCR")
                    				ids.push(node_id);
                    		}
                    		batchManageAction.saveBatchScript({
                    					batchid: sm.getSelection()[0].data.batchid, 
                    					scriptids: ids.join(",")
                    				}, function(result, e){
                    					 if(!(e.type && e.type == "exception")){
                        				    	Ext.Msg.alert('提示', '保存完毕');
                        				    	btn.up("window").close();
                        				    }
                    				});
                    		
                    	}
                    },{
                    	text:"取消",
                    	handler:function(btn){
                    		btn.up("window").close();
                    	}
                    }
            ]
        }).show();
    },
    saveExecConfig: function(btn){
    	var store = btn.up('gridpanel').getStore();
        var grid = btn.up('gridpanel');
        var sm = grid.getSelectionModel();
        if(sm.getSelection().length<=0){
        	Ext.Msg.alert("提示", "请选择一个计划");
        	return;
        }
        if(sm.getSelection()[0].data.batchid == undefined || sm.getSelection()[0].data.batchid == ""){
        	Ext.Msg.alert("提示", "请先保存该计划");
        	return;
        }
        
        
        var win = new Ext.Window({  
            width: 220,  
            height: 100,  
            resizable: true,  
            modal: true,  
            closable: true,  
            //maximizable: true,  
            //minimizable: true,
            iconCls: "Packageedit",
            title: "新增模块",
            layout: "fit",
            items:[{
	           	 xtype: "form",
	           	 bodyPadding: "7",
	           	 items:[{
	           		 name: "name",
	           		 xtype: "textfield",
	           		 fieldLabel: "执行ID"
	           	 }]
            }],
            buttons: [{
           	 text: '保存',
           	 handler: function(btn){
           		 
           		 if(btn.up("window").down("form").getForm().isValid()){
           			var platformid = btn.up("window").down("form").down("textfield").getValue();
           	    	batchManageAction.saveExecConfig({
           				batchid: sm.getSelection()[0].data.batchid, 
           				platformid: platformid
           			}, function(result, e){
           				    if(!(e.type && e.type == "exception")){
           				    	Ext.Msg.alert('提示', '保存完毕');
           				    	win.close();
           				    }
           			});
           			 
           		 }else{
           			 Ext.MessageBox.alert("错误", "请验证表单正确后保存");
           		 }
           		 
           		 //btn.up("window").close();
           	 } 
           	 }]
        });  
   	 	win.show();
   	 	
    }
});