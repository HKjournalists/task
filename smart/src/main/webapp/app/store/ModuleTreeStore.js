Ext.define('SmartApp.store.ModuleTreeStore', {
    extend: 'Ext.data.TreeStore',
    root: {
        text: '系统',
		expanded: true
	},
    autoLoad: true,
	nodeParam: 'id',
	proxy: {
	  type: 'direct',
	  directFn: caseManageAction.getTree,
	  extraParams: {
		  type: "SYS"
	  }
	}
});
