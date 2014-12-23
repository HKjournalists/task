

/*Form中必须填写的字段需要增加红色*号*/
Ext.form.field.Base.prototype.initComponent = function () {
    var me = this;
    Ext.form.field.Base.superclass.initComponent.call(this);
    me.subTplData = me.subTplData || {};
    this.addEvents('focus', 'blur', 'specialkey');
    // Init mixins
    me.initLabelable();
    me.initField(); // Default name to inputId
    if (!me.name) {
        me.name = me.getInputId();
    }
    if (this.allowBlank === false && this.fieldLabel) {
        this.fieldLabel = '<font color=red>*</font>' + this.fieldLabel;
    }
}


/*增加校验方式*/
Ext.apply(Ext.form.VTypes, {
    password : function(val, field) {// val指这里的文本框值，field指这个文本框组件，大家要明白这个意思
        if (field.confirmTo) {// confirmTo是我们自定义的配置参数，一般用来保存另外的组件的id值
            var pwd = field.up("form").down("textfield[name=" + field.confirmTo + "]");// 取得confirmTo的那个name的值
            return (val == pwd.getValue());
        }
        return true;
    },
    passwordText: "两次输入的密码不一致"
});