/**
 * Created by renzq on 2014/12/2.
 */
Ext.define("SmartApp.store.UserStore", {
    extend: "Ext.data.Store",
    model: "SmartApp.model.User",
	proxy: {
	    type: 'direct',
	    extraParams: {
	        username: '',
	        realname: '',
	        department: '',
	        manager: ''
	    },
	    api: {
	        read: userAction.load,
	        create: userAction.createOrUpdate,
	        update: userAction.createOrUpdate,
	        destroy: userAction.destroy
	    }
	}
});