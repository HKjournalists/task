/**
 * Created by renzq on 2014/12/2.
 */
Ext.define("SmartApp.store.KeywordStore", {
    extend: "Ext.data.Store",
    model: "SmartApp.model.Keyword",
    proxy: {
        type: 'direct',
        extraParams: {
            submodule_id: ''
        },
        api: {
            read: keywordAction.loadKeywords,
            create: keywordAction.saveOrUpdateKeywords,
            update: keywordAction.saveOrUpdateKeywords,
            destroy: keywordAction.destroyKeywords
        }
    }
});