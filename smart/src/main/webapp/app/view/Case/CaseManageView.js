Ext.define('SmartApp.view.Case.CaseManageView', {
	extend : 'Ext.panel.Panel',
	alias : 'widget.casemanageview',

	initComponent : function() {
		var me = this;
		var module_tree = Ext.create("SmartApp.store.ModuleTreeStore");
		Ext.apply(this, {
			border : false,
			layout : "border",
			items : [ {
				xtype : "panel",
				title : "模块",
				autoScroll : true,
				width : 230,
				layout : 'fit',
				region : "west",
				split : true,
				collapsible : true,
				items : [ {
					xtype : "moduletreeview"
				} ]

			}, {
				xtype : "panel",
				layout : 'fit',
				border: false,
				id: "ModuleViewPanel",
				region : "center"
			} ]
		});
		me.callParent();

	}
});