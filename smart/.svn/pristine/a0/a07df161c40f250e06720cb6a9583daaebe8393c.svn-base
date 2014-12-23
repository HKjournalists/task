/**
 * Created by renzq on 2014/12/2.
 */

Ext.define('SmartApp.view.User.RoleManage', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.rolemanageview',
    requires: ['SmartApp.store.RoleStore'],
    initComponent: function (){

        var me = this;
        var role_store = Ext.create("SmartApp.store.RoleStore");

        Ext.apply(this, {

            border: false,
            layout: "border",
            items: [
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
                           name: 'search_name',
                           fieldLabel: '角色名称'
                       },{
                            xtype: 'button',
                            iconCls: 'Magnifier',
                            text: '查询',
                            action: 'search'
                       }
                    ]
                }, {
                    xtype: 'gridpanel',
                    region: 'center',
                    title: '查询结果',
                    store: role_store,
                    columns: [
                        Ext.create('Ext.grid.RowNumberer'),
                        {
                            header : "角色名称",
                            dataIndex : "name",
                            sortable : true,
                            editor: new Ext.form.TextField({
                                allowBlank: false
                            })
                        }, {
                            header : "角色描述",
                            dataIndex : "memo",
                            editor: new Ext.form.TextField()
                        }
                    ],
                    plugins: [Ext.create('Ext.grid.plugin.CellEditing', {
                        clicksToEdit: 1
                    })],
                    tbar: [ {
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