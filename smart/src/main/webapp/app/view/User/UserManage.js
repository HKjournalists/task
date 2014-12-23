/**
 * Created by renzq on 2014/12/2.
 */

Ext.define('SmartApp.view.User.UserManage', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.usermanageview',


    initComponent: function (){
        var me = this;

        var role_store = Ext.create("SmartApp.store.RoleStore");
        role_store.load();
        var user_store = Ext.create("SmartApp.store.UserStore");
        
        
        Ext.apply(this, {

            border: false,
            layout: "border",
            items:[
                {
                    xtype: 'form',
                    region: 'north',
                    title: '查询条件',
                    bodyPadding: 7,
                    layout: 'table',
                    defaults: {
                        margin: "0 30 0 10"
                    },
                    layoutConfig: {
                        columns: 3
                    },
                    items: [
                        {
                            xtype: 'textfield',
                            fieldLabel: '用户名',
                            name: 'username'
                        }, {
                            xtype: 'textfield',
                            fieldLabel: '真实姓名',
                            name: 'realname'
                        },{
                            xtype: 'button',
                            iconCls: 'Magnifier',
                            text: '查询',
                            action: 'search'
                        }

                    ]
                },{
                    xtype: 'gridpanel',
                    id: 'userGrid',
                    region: 'center',
                    title: '查询结果',
                    store: user_store,
                    columns: [
                        Ext.create('Ext.grid.RowNumberer'),
                        {
                            header : "用户名",
                            dataIndex : "username",
                            sortable : true
                        }, {

                            header: "Email",
                            dataIndex : "email",
                            editor: new Ext.form.TextField()
                        }, {
                            header: "手机号码",
                            dataIndex : "mobile",
                            editor: new Ext.form.TextField()
                        }, {
                            header: "真实姓名",
                            dataIndex : "realname",
                            editor: new Ext.form.TextField()
                        }, {
                            header: "部门",
                            dataIndex: "department",
                            editor: new Ext.form.TextField()
                        }, {
                            header: "经理",
                            dataIndex: "manager",
                            editor: new Ext.form.TextField()
                        }, {
                            header: "所属角色",
                            dataIndex: "roleids",
                            width: 200,
                            editor: new Ext.form.ComboBox({
                                multiSelect: true,
                                displayField: 'name',
                                valueField: 'roleid',
                                editable : false,
                                store: role_store,
                                queryMode: 'local'
                            }),
                            renderer: function(value, metadata, record) {
                                if(value!=undefined && value!=""){

                                    var ids = value.split(",")
                                    //var role_store = this.down("combobox").getStore();
                                    //var role_store = Ext.data.StoreManager.lookup('RoleStore');
                                    
                                    var new_value = [];
                                    for(var i in ids){
                                        var id = ids[i];
                                        var index = role_store.find("roleid", id);
                                        if(index != -1)
                                            new_value.push(role_store.getAt(index).data.name);
                                    }
                                    return new_value.join(",");
                                }
                                return "";
                            }

                        }
                    ],
                    plugins: [Ext.create('Ext.grid.plugin.CellEditing', {
                        clicksToEdit: 1
                    })],
                    tbar: [{
                        xtype : 'button',
                        text : '新增',
                        iconCls: "Tablerowinsert",
                        action : "append"
                    }, {
                        xtype : 'button',
                        text : '删除',
                        iconCls: "Tablerowdelete",
                        action: "delete"
                    },{
                        xtype : 'button',
                        text : '保存',
                        iconCls: "Tablesave",
                        action: "save"
                    }]
                }
            ]
        });

        me.callParent();

    }
});