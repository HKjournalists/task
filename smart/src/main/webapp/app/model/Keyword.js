/**
 * Created by renzq on 2014/12/9.
 */
Ext.define('SmartApp.model.Keyword', {
	extend : 'Ext.data.Model',
	fields : [{
		name : 'keywordid',
		type : 'string'
	}, {
		name : 'submodule_id',
		type : 'string'
	}, {
		name : 'keywordname',
		type : 'string'
	}, {
		name : 'version',
		type : 'string'
	}
	]

});