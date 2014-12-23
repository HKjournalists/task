/**
 * Created by renzq on 2014/12/2.
 */
Ext.define("SmartApp.store.ScriptStore", {
    extend: "Ext.data.Store",
    model: "SmartApp.model.Script",
    proxy: {
        type: 'direct',
        extraParams: {
            submoduleid: ''
        },
        api: {
            read: scriptAction.load,
            create: scriptAction.saveOrUpdate,
            update: scriptAction.saveOrUpdate,
            destroy: scriptAction.destroy
        }
    }
});