
function rescure_check(node, state){
	
	if (node.hasChildNodes()){
		for (i = 0; i < node.childNodes.length; i++) {
			node.childNodes[i].set("checked", state);
			if(node.childNodes[i].hasChildNodes()){
				rescure_check(node.childNodes[i], state);
			}
		}
	}
}

Ext.define('SmartApp.view.Batch.ScriptSelectView', {
	extend : 'Ext.tree.Panel',
	alias : 'widget.scriptselectview',

	
	initComponent : function() {
		  var me = this;
	        Ext.applyIf(me, {
	            itemId: 'mainmenuTree',
	            title: '',
	            store: "ScriptTreeStore",
	            listeners:{
		            "checkchange": function(node, state) {
		            	rescure_check(node, state);
	                }
	            }

	        });
	        me.callParent(arguments);
	}

});