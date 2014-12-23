/**
 * Created by renzq on 2014/12/2.
 */
Ext.define("SmartApp.store.ActionStore", {
    extend: "Ext.data.Store",
    model: "SmartApp.model.Action",
    autoLoad: true,
    proxy: {
        type: 'direct',
        extraParams: {
            name: ''
        },
        api: {
            read: actionAction.load,
            create: actionAction.saveOrUpdate,
            update: actionAction.saveOrUpdate,
            destroy: actionAction.destroy
        }
    }
});