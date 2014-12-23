/**
 * Created by renzq on 2014/12/2.
 */
Ext.define("SmartApp.store.BatchStore", {
    extend: "Ext.data.Store",
    model: "SmartApp.model.Batch",
    proxy: {
        type: 'direct',
        extraParams: {
            name: ''
        },
        api: {
            read: batchAction.load,
            create: batchAction.saveOrUpdate,
            update: batchAction.saveOrUpdate,
            destroy: batchAction.destroy
        }
    }
});