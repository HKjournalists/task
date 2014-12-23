Ext.define('SmartApp.controller.UserCtrl', {
    extend: 'Ext.app.Controller',
    models: ['User'],
    stores: ['UserStore', 'RoleStore'],
    views: ['User.UserManage', 'User.UserForm'],
    requires: ['Ext.form.ComboBox', 'SmartApp.store.RoleStore'],
    init: function () {

        this.control({
            'usermanageview button[action=search]': {
                click: this.searchUser
            },
            'usermanageview button[action=append]':{
                click: this.appendUser
            },
            'usermanageview button[action=delete]':{
                click: this.deleteUser
            },
            'usermanageview button[action=save]':{
                click: this.saveUser
            },
            'userformview button[action=save]':{
                click: this.submitUser
            }
        });
    },

    searchUser: function(btn){
    	var store = btn.up("panel").up("panel").down("gridpanel").getStore();
    	var username = btn.up("panel").down("textfield[name=username]").getValue();
    	var realname = btn.up("panel").down("textfield[name=realname]").getValue();
    	store.load({params:{
    		username: username,
    		realname: realname,
    		manager: '',
    		department: ''
    	}});
    },
    
    appendUser: function(btn){

        var store = btn.up('gridpanel').getStore();
        var new_usr = Ext.create('SmartApp.model.User',{
            username: '',
            password: '',
            confirm: '',
            realname: '',
            department: "无",
            manager: "无"
        });


        var view = Ext.widget('userformview');

        view.down("form").loadRecord(new_usr);
    },



    submitUser: function(button){
        var win = button.up("window");
        var win_form = win.down("form");
        grids = Ext.ComponentQuery.query("usermanageview gridpanel");
        var store;
        if(grids.length == 1)
            store = grids[0].getStore();
        else{
            Ext.MessageBox.alert("错误", "查找到多个用户视图");
            return;
        }



        if (win_form.getForm().isValid()){
           

            Ext.MessageBox.alert("提醒", "增加了一个用户，需要点击[保存]存储新增的用户。");

            record = win_form.getRecord();
            values = win_form.getValues();
            record.set(values);

            win.close();
            store.insert(0,record);
            //var rowEditing = btn.up('gridpanel').editingPlugin;
            //rowEditing.startEdit(0, 0);
        }

        //this.searchUser();

    },

    deleteUser: function(btn){

        var store = btn.up('gridpanel').getStore();
        var grid = btn.up('gridpanel');
        var sm = grid.getSelectionModel();
        store.remove(sm.getSelection());
        if (store.getCount() > 0) {
            sm.select(0);
        };
    },
    
    saveUser: function(btn){
        var store = btn.up('gridpanel').getStore();
        store.sync({
            callback : function(store){
                Ext.Msg.alert('提示', '保存完毕');
            }
        });
    }


});