/**
 * Created by renzq on 2014/12/2.
 */
Ext.define("SmartApp.store.ScriptDetailStore", {
    extend: "Ext.data.Store",
    model: "SmartApp.model.ScriptDetail",
    proxy: {
        type: 'direct',
        extraParams: {
            scriptid: ''
        },
        api: {
            read: scriptDetailAction.load,
            create: scriptDetailAction.saveOrUpdate,
            update: scriptDetailAction.saveOrUpdate,
            destroy: scriptDetailAction.destroy
        }
    }
});