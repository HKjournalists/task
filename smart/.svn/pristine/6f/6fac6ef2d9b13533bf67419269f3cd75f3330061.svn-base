Ext.define('SmartApp.controller.RuleCtrl', {
    extend: 'Ext.app.Controller',
    views: ['Rule.RuleManage'],
    models: ['Rule'],
    stores: ['RuleStore'],

    init: function () {
        this.control(
            {
            
            	'rulemanageview button[action=search]':{
            		click: this.searchRole
            	},
                'rulemanageview button[action=append]':{
                    click: this.appendRole
                },
                'rulemanageview button[action=delete]':{
                    click: this.deleteRole
                },
                'rulemanageview button[action=save]':{
                    click: this.saveRole
                }
            }
        );


        
    },
    appendRole: function(btn){
        var store = btn.up('gridpanel').getStore();
        var r = Ext.create('SmartApp.model.Rule',{
            operaion: "",
            value: "",
            version: ""
        });
        store.insert(0,r);
        var rowEditing = btn.up('gridpanel').editingPlugin;
        rowEditing.startEdit(0, 0);
    },
    deleteRole: function(btn){
        var store = btn.up('gridpanel').getStore();
        var grid = btn.up('gridpanel');
        var sm = grid.getSelectionModel();
        store.remove(sm.getSelection());
        
       
        if (store.getCount() > 0) {
            sm.select(0);
        };
    },
    saveRole: function(btn){
        var store = btn.up('gridpanel').getStore();
        store.sync({
            callback : function(result){
            	if(result.type && result.type == "exception")
            		Ext.Msg.alert('错误', result.message);
            	else
            		Ext.Msg.alert('提示', '保存完毕');
            }
        });
    },
    searchRole: function(btn){
    	var store = btn.up("panel").up("panel").down("gridpanel").getStore();
    	var search_name = btn.up("panel").down("textfield[name=search_name]").getValue();
    	store.load({params:{name: search_name}});
    
    }





});