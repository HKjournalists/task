/**
 * Created by renzq on 2014/12/2.
 */
Ext.define("SmartApp.store.RoleStore", {
    extend: "Ext.data.Store",
    model: "SmartApp.model.Role",
    storeId: 'RoleStore',
    proxy: {
        type: 'direct',
        extraParams: {
            name: ''
        },
        api: {
            read: roleAction.load,
            create: roleAction.createOrUpdate,
            update: roleAction.createOrUpdate,
            destroy: roleAction.destroy
        }
    }
});