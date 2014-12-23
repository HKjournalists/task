Ext.define('SmartApp.view.Case.ModuleTreeView', {
	extend : 'Ext.tree.Panel',
	alias : 'widget.moduletreeview',

	initComponent : function() {
		var me = this;
		var module_tree = Ext.create("SmartApp.store.ModuleTreeStore");
		Ext.apply(this, {
			border : false,
			store : module_tree,
			tbar : [ {
				xtype : 'trigger',
				triggerCls : 'x-form-clear-trigger',
				width : 100,
				onTriggerClick : function() {
					this.reset();
					this.focus();
				},
				listeners : {
					change : function(field, newVal) {
						var tree = field.up('treepanel');
						tree.filter(newVal);
					},
					buffer : 250
				}
			}, {
				tooltip : "增加模块",
				iconCls : "Packageadd",
				action : "addModule"
			}, {
				tooltip : "增加子模块",
				iconCls : "Noteadd",
				action : "addSubModule"
			}, {
				tooltip : "编辑",
				iconCls : "Noteedit",
				action : "edit"
			}, {
				tooltip : "删除",
				iconCls : "Notedelete",
				action : "delete"
			}, {
				tooltip : "刷新",
				iconCls : "Databaserefresh",
				action : "refresh"
			} ],
			plugins : [ {
				ptype : 'treefilter',
				allowParentFolders : true
			} ]

		});
		me.callParent();
	}

});