/**
 * Created by renzq on 2014/12/9.
 */
Ext.define('SmartApp.model.Testcase', {
	extend : 'Ext.data.Model',
	fields : [{
		name : 'testcaseid',
		type : 'string'
	}, {
		name : 'scriptid',
		type : 'string'
	}, {
		name : 'testcasename',
		type : 'string'
	}, {
		name : 'testcaselevel',
		type : 'string'
	}, {
		name : 'expectedresult',
		type : 'string'
	}
	]

});