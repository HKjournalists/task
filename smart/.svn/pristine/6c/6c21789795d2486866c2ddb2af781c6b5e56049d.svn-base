/**
 * Created by renzq on 2014/12/2.
 */
Ext.define("SmartApp.store.RuleStore", {
    extend: "Ext.data.Store",
    model: "SmartApp.model.Rule",
    autoLoad: true,
    proxy: {
        type: 'direct',
        extraParams: {
            name: ''
        },
        api: {
            read: ruleAction.load,
            create: ruleAction.saveOrUpdate,
            update: ruleAction.saveOrUpdate,
            destroy: ruleAction.destroy
        }
    }
});