/**
 * Created by renzq on 2014/12/9.
 */
Ext.define('SmartApp.model.Script', {
	extend : 'Ext.data.Model',
	fields : [{
		name : 'scriptid',
		type : 'string'
	}, {
		name : 'submoduleid',
		type : 'string'
	}, {
		name : 'scriptname',
		type : 'string'
	}
	]

});