/**
 * Created by renzq on 2014/12/9.
 */
Ext.define('SmartApp.model.BatchDetail', {
	extend : 'Ext.data.Model',
	fields : [{
		name : 'batchdetailid',
		type : 'string'
	}, {
		name : 'batchid',
		type : 'string'
	},{
		name : 'scriptid',
		type : 'string'
	},{
		name : 'scriptname',
		type : 'string'
	},{
		name : 'submodulename',
		type : 'string'
	},{
		name : 'modulename',
		type : 'string'
	}
	]

});