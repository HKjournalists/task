Ext.onReady(function(){

    Ext.QuickTips.init();
    Ext.form.Field.prototype.msgTarget='side';
    Ext.Loader.setConfig({
        enabled: true,
        disableCaching: true
    });
	Ext.direct.Manager.addProvider(Ext.app.REMOTING_API);
	Ext.Direct.on("event", function(event, provider) {
		
	});
	


	Ext.Direct.on("login", function(event) {
		Ext.Msg.show({
			title : '权限错误',
			msg : "<p>" + event.message + "<\/p>",
			width : 250,
			buttons : Ext.MessageBox.OK,
			icon : Ext.MessageBox.WARN,
			fn : function(){
				window.location = "login.html";
			}
		});
	});

	Ext.Direct.on("exception", function(event) {
	    var backtrace = "";
	    if (event.where) {
	        backtrace = "<p style=\"margin-top: 20px;\">" +
	            "<strong>Backtrace:<\/strong><br \/>" +
	            event.where.replace(/#/g, "<br \/>#") +
	            "<\/p>";
	    }
	    if (!typeof console === "undefined")
	    	console.error(backtrace);
	    Ext.Msg.show({
	           title      : '后台错误',
	           msg        : "<p>" + event.message + "<\/p>",
	           width      : 300,
	           buttons    : Ext.MessageBox.OK,
	           icon       : Ext.MessageBox.ERROR
	    });
	});

	
	
    Ext.application({
        name: 'SmartApp',
        appFolder: 'app',
        autoCreateViewport: true,
        controllers: ["Main", "UserCtrl", "RoleCtrl", "CaseManageCtrl", "ActionCtrl", "RuleCtrl", "BatchManageCtrl"]

    });


});