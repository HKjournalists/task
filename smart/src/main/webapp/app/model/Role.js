/**
 * Created by renzq on 2014/12/2.
 */
Ext.define('SmartApp.model.Role', {
    extend: 'Ext.data.Model',
    fields: [
        { name: 'roleid', type: 'int' },
        { name: 'name', type: 'string' },
        { name: 'memo', type: 'string' }

    ]
    
});