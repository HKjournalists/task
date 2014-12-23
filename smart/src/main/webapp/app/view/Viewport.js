Ext.define('SmartApp.view.Viewport', {
    extend: 'Ext.container.Viewport',
    alias: 'widget.mainview',

    requires: [
        'Ext.menu.Menu',
        'Ext.menu.Item',
        'Ext.tab.Panel',
        'Ext.tab.Tab',
        'SmartApp.view.main.menuTree'
    ],

    itemId: 'mainView',
    layout: 'border',

    initComponent: function() {
        var me = this;

        Ext.applyIf(me, {
            items: [

            	{
                    xtype: 'container',
                    id: 'app-header',
                    region: 'north',
                    layout:{
                        type: 'hbox',
                        align: 'middle'
                    },
                    items:[
                        {
                            xtype: 'component',
                            id: 'app-header-title',

                            html: '<b>新疆自动化测试平台</b>V1.0',
                            flex: 1

                        },{
                        	xtype: "toolbar",
                        	margin: "0 25 0 0",
                        	border: false,
                        	style: "background-color: transparent !important;background-image: none !important;",
                        	layout: "hbox",
                        	items:[{
                        		xtype: "button",
                        		iconCls: "Doorout",
                        		cls:"cssButton",
                        		text: "注销", 
                        		cls:"x-btn-text-icon",
                        		handler: function(){
                        			 Ext.Ajax.request({     
                 						url:'userlogin/logout',
                 						success: function(resp,opts) {
                 							window.location="login.html";
                 						}
                        			 });
                        		}
                        	}]
                        }
                    ]

            	},
                {
                    xtype: 'panel',
                    region: 'west',
                    split: true,
                    collapsible: true,
                    itemId: 'main',
                    width: 220,
                    title: '菜单',
                    
                    autoScroll: true,
                    items: [
                        {
                            xtype: "menuTree",
                            id: "menuTree",
                            border: false,
                            layout: "fit"
                        }
                    ]
                },
                {
                    xtype: 'panel',
                    region: 'center',
                    itemId: 'contentPanel',
                    layout: 'border',
                    border: false,
                    items: [
                        {
                            xtype: 'tabpanel',
                            activeTab: 0,
                            id: "main_tab_panel",
                            region: "center",
                            layout: "fit",
                            //autoDestroy: false,
                            items: [
                                {
                                    xtype: 'panel',
                                    title: '工作台',
                                    bodyStyle: {  
                                        background: 'url(images/welcome.jpg) no-repeat #FFFFFF  bottom right', 
                                        padding: '10px'  
                                    }
                                }
                            ]
                        }
                    ]
                }
            ]
        });

        me.callParent(arguments);
    }

});

//Ext.create("SmartApp.view.MainView");