/**
 * Created by renzq on 2014/12/2.
 */
Ext.define('SmartApp.model.User', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'userid', type: 'int' },
        {name: 'username', type: 'string' },
        {name: 'password', type: 'string' },
        {name: 'confirm', type: 'string' },
        {name: 'realname', type: 'string' },
        {name: 'email', type: 'string' },
        {name: 'mobile', type: 'string' },
        {name: 'department', type: 'string' },
        {name: 'manager', type: 'string' },
        {name: 'roleids', type: 'string'}
    ]
});