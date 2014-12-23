/**
 * Created by renzq on 2014/12/2.
 */
Ext.define("SmartApp.store.TestcaseDetailStore", {
    extend: "Ext.data.Store",
    model: "SmartApp.model.TestcaseDetail",
    proxy: {
        type: 'direct',
        extraParams: {
            testcaseid: ''
        },
        api: {
            read: testcaseDetailAction.load,
            create: testcaseDetailAction.saveOrUpdate,
            update: testcaseDetailAction.saveOrUpdate,
            destroy: testcaseDetailAction.destroy
        }
    }
});