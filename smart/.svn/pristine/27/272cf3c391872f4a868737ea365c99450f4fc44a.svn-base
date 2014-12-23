Ext.define('SmartApp.view.User.UserForm', {  //注意定义名称 的形式
    extend: 'Ext.window.Window',
    alias: 'widget.userformview',

    initComponent: function() {
        var me = this;

        Ext.apply(this, {
            title : '编辑',
            layout: 'fit',
            autoShow: true,
            width: 500,
            height: 360,
            plain: true,
            modal: true,
            closable: true,
            maximizable: true,
            autoScroll: true,
            items:[{
                xtype: "form",
                title: "用户信息",
                layout: 'anchor',
                bodyPadding: 7,
                autoScroll: true,
                defaults: {
                    anchor: '95%'
                },
                defaultType: 'textfield',
                items:[{
                    fieldLabel: '用户名',
                    name: 'username',
                    allowBlank: false
                },{
                    fieldLabel: '密码',
                    name: 'password',
                    inputType: 'password',
                    minLength: 6,
                    allowBlank: false
                },{
                    fieldLabel: '确认密码',
                    name: 'confirm',
                    minLength: 6,
                    inputType: 'password',
                    vtype : "password",// 自定义的验证类型
                    confirmTo : "password",
                    allowBlank: false
                },{
                    fieldLabel: '真实姓名',
                    name: 'realname'
                },{
                    fieldLabel: '电子邮件',
                    name: 'email'
                },{
                    fieldLabel: '手机号码',
                    name: 'mobile'
                },{
                    fieldLabel: '所属部门',
                    name: 'department'
                },{
                    fieldLabel: '上级经理',
                    name: 'manager'
                },{
                    xtype: 'combobox',
                    name: 'roleids',
                    fieldLabel: '所属角色',
                    multiSelect: true,
                    displayField: 'name',
                    valueField: 'roleid',
                    editable : false,
                    store: "RoleStore",
                    queryMode: 'local'
                }]

            }],
            buttons:[{
                        text: '保存',
                        action: 'save'
                    }, {
                        text: '取消',
                        scope: me,
                        handler: me.close
                    }]
        });
        me.callParent(arguments);
    }


});