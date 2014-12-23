Ext.define('SmartApp.controller.RoleCtrl', {
    extend: 'Ext.app.Controller',
    views: ['User.RoleManage'],
    models: ['Role'],
    stores: ['RoleStore'],
    requires: ['SmartApp.store.RoleStore', 'SmartApp.model.Role'],

    init: function () {
        this.control(
            {
            
            	'rolemanageview button[action=search]':{
            		click: this.searchRole
            	},
                'rolemanageview button[action=append]':{
                    click: this.appendRole
                },
                'rolemanageview button[action=delete]':{
                    click: this.deleteRole
                },
                'rolemanageview button[action=save]':{
                    click: this.saveRole
                }
            }
        );


        
    },
    appendRole: function(btn){
        var store = btn.up('gridpanel').getStore();
        var r = Ext.create('SmartApp.model.Role',{
            name: "",
            memo: ""
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
            callback : function(store){
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