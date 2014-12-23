/**
 * Created by renzq on 2014/12/2.
 */
Ext.define("SmartApp.store.TestcaseStore", {
    extend: "Ext.data.Store",
    model: "SmartApp.model.Testcase",
    proxy: {
        type: 'direct',
        extraParams: {
            submoduleid: ''
        },
        api: {
            read: testcaseAction.load,
            create: testcaseAction.saveOrUpdate,
            update: testcaseAction.saveOrUpdate,
            destroy: testcaseAction.destroy
        }
    }
});