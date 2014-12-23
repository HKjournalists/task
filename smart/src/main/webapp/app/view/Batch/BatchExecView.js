Ext.define('SmartApp.view.Batch.BatchExecView', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.batchexecview',
    initComponent: function (){

        var me = this;
        var batch_store = Ext.create("SmartApp.store.BatchStore");

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
                           fieldLabel: '计划号'
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
                    store: batch_store,
                    columns: [
                        Ext.create('Ext.grid.RowNumberer'),
                        {
                            header : "计划号",
                            dataIndex : "batchname",
                            sortable : true,
                            editor: new Ext.form.TextField({
                                allowBlank: false
                            })
                        },{
                        	header: "计划名称",
                        	dataIndex: "comments",
                        	editor: new Ext.form.TextField()
                        }
                    ],
                    plugins: [Ext.create('Ext.grid.plugin.CellEditing', {
                        clicksToEdit: 1
                    })],
                    tbar: [{
                    	xtype: 'button',
                    	text: '执行',
                    	iconCls: "Scriptstart",
                    	action: "saveexecconfig"
                    }]
                }
            ]
        });
        me.callParent();
    }
});