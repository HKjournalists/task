/**
 * Created by renzq on 2014/12/2.
 */
Ext.define("SmartApp.store.BatchDetailStore", {
    extend: "Ext.data.Store",
    model: "SmartApp.model.BatchDetail",
    autoLoad: true,
    proxy: {
        type: 'direct',
        extraParams: {
            batchid: ''
        },
        api: {
            read: batchDetailAction.load,
            create: batchDetailAction.saveOrUpdate,
            update: batchDetailAction.saveOrUpdate,
            destroy: batchDetailAction.destroy
        }
    }
});