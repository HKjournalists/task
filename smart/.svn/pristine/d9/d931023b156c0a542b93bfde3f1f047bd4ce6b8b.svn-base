/**
 * Created by renzq on 2014/12/2.
 */

Ext.define('SmartApp.view.Action.ActionManage', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.actionmanageview',
    initComponent: function (){

        var me = this;
        var action_store = Ext.create("SmartApp.store.ActionStore");

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
                           fieldLabel: '操作名称'
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
                    store: action_store,
                    columns: [
                        Ext.create('Ext.grid.RowNumberer'),
                        {
                            header : "操作名称",
                            dataIndex : "actionname",
                            sortable : true,
                            editor: new Ext.form.TextField({
                                allowBlank: false
                            })
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