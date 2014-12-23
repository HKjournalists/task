/**
 * Created by renzq on 2014/12/2.
 */
Ext.define("SmartApp.store.KeywordDetailStore", {
    extend: "Ext.data.Store",
    model: "SmartApp.model.KeywordDetail",
    proxy: {
        type: 'direct',
        extraParams: {
            keywordid: ''
        },
        api: {
            read: keywordDetailAction.loadKeywordDetails,
            create: keywordDetailAction.saveOrUpdateKeywordDetails,
            update: keywordDetailAction.saveOrUpdateKeywordDetails,
            destroy: keywordDetailAction.destroyKeywordDetails
        }
    }
});