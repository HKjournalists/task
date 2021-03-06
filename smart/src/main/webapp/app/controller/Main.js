Ext.define('SmartApp.controller.Main', {
    extend: 'Ext.app.Controller',
    //将Viewport.js添加到控制器
    views: ['Viewport', 'main.menuTree'],
    stores: ['MenuTreeStore'],
    init: function () {

        this.control({
            'menuTree': {
                itemclick: this.MenuNodeClick
            }
        });

        var menuTree = Ext.getCmp("menuTree");


    },
    MenuNodeClick: function (view, record, item, index, e) {

        var tabPanel = Ext.getCmp("main_tab_panel");

        //if this tab has been existed, only set active to it.
        var exist_flag = false;
        for(var i=0; i < tabPanel.items.getCount(); i++){
            if (tabPanel.items.getAt(i).id == record.raw.view_name){
                exist_flag = true;
                break;
            }

        }
        if(!exist_flag){

            /*tabPanel.add({
                id: record.raw.view_name,
                title: record.raw.text,
                closable: true,
                layout:'fit',
                items:[{
                    xtype: record.raw.view_name,
                    title: ''
                }]
            });*/

            tabPanel.add({
                id: record.raw.view_name,
                title: record.raw.text,
                closable: true,
                
                xtype: record.raw.view_name
            })
        }

        tabPanel.setActiveTab(record.raw.view_name);

    }

});
