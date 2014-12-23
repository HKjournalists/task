/**
 * Created by renzq on 2014/12/2.
 */
Ext.define("SmartApp.store.KeywordDetailFScriptStore", {
    extend: "Ext.data.Store",
    model: "SmartApp.model.KeywordDetail",
    proxy: {
        type: 'direct',
        extraParams: {
            scriptid: ''
        },
        api: {
            read: keywordDetailAction.loadKeywordDetailsByScriptid,
            create: keywordDetailAction.saveOrUpdateKeywordDetails,
            update: keywordDetailAction.saveOrUpdateKeywordDetails,
            destroy: keywordDetailAction.destroyKeywordDetails
        }
    }
});