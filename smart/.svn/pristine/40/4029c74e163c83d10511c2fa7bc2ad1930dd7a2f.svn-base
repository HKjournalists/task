Ext.define('SmartApp.view.Case.ModuleView', {
	extend : 'Ext.tab.Panel',
	alias : 'widget.moduleview',

	initComponent : function() {
		var me = this;
		Ext.apply(this, {
			layout : "border",
			title : "module",
			items : [{
				id: "KeywordView",
				title: "关键字",
				xtype: "keywordview"
			},{
				id: "scriptView",
				title: "脚本",
				xtype: "scriptview"
			},{
				id: "testcaseView",
				title: "测试用例",
				xtype: "testcaseview"
			}]
		});

		me.callParent();
	}

});