Ext.onReady(function() {
            Ext.form.Basic.prototype.afterAction = function(action, success) {
                if (action.waitMsg) {
                    var messageBox = Ext.MessageBox,
                        waitMsgTarget = this.waitMsgTarget;
                    if (waitMsgTarget === true) {
                        this.owner.el.unmask();
                    } else if (waitMsgTarget) {
                        waitMsgTarget.unmask();
                    } else {
                        // Do not fire the hide event because that triggers complex processing
                        // which is not necessary just for the wait window, and which may interfere with the app.
                        messageBox.suspendEvents(true);
                        messageBox.hide();
                        messageBox.resumeEvents();
                    }
                }
                if (success) {
                    if (action.reset) {
                        this.reset();
                    }
                    Ext.callback(action.success, action.scope || action, [this, action]);
                    this.fireEvent('actioncomplete', this, action);
                } else {
                    Ext.callback(action.failure, action.scope || action, [this, action]);
                    this.fireEvent('actionfailed', this, action);
                }
            }
           // field.Text
            Ext.form.field.Text.prototype.setReadOnly = function(c) {
            	var a = this,
        		b = a.inputEl;
            	try{
            		Ext.select( '#'+a.id+' + div.x-btn' ).each(function(){Ext.getCmp(this.dom.id).disable(true);});
            	}catch(e){alert(e);}
        	c = !!c;
        	a[c ? "addCls" : "removeCls"](a.readOnlyCls);
        	a.readOnly = c;
        	c?a.addCls("textFieldGray"):a.removeCls("textFieldGray");
        	if (b) {
        		b.dom.readOnly = c
        	} else {
        		if (a.rendering) {
        			a.setReadOnlyOnBoxReady = true
        		}
        	}
        	a.fireEvent("writeablechange", a, c);
            }
            Ext.form.field.Number.prototype.setReadOnly = function(c) {
            	var a = this,
        		b = a.inputEl;
            	try{
            		Ext.select( '#'+a.id+' + div.x-btn' ).each(function(){Ext.getCmp(this.dom.id).disable(true);});
            	}catch(e){alert(e);}
        	c = !!c;
        	a[c ? "addCls" : "removeCls"](a.readOnlyCls);
        	a.readOnly = c;
        	c?a.addCls("numberFieldGray"):a.removeCls("numberFieldGray");
        	if (b) {
        		b.dom.readOnly = c
        	} else {
        		if (a.rendering) {
        			a.setReadOnlyOnBoxReady = true
        		}
        	}
        	a.fireEvent("writeablechange", a, c);
            }
            Ext.form.field.ComboBox.prototype.setReadOnly = function(c) {
            	var a = this,
        		b = a.inputEl;
        	c = !!c;
        	a[c ? "addCls" : "removeCls"](a.readOnlyCls);
        	a.readOnly = c;
        	c?a.addCls("textFieldGray"):a.removeCls("textFieldGray");
        	if (b) {
        		b.dom.readOnly = c
        	} else {
        		if (a.rendering) {
        			a.setReadOnlyOnBoxReady = true
        		}
        	}
        	a.fireEvent("writeablechange", a, c);
            }
            Ext.form.field.Date.prototype.setReadOnly = function(c) {
            	var a = this,
        		b = a.inputEl;
        	c = !!c;
        	a[c ? "addCls" : "removeCls"](a.readOnlyCls);
        	a.readOnly = c;
        	c?a.addCls("textFieldGray"):a.removeCls("textFieldGray");
        	if (b) {
        		b.dom.readOnly = c
        	} else {
        		if (a.rendering) {
        			a.setReadOnlyOnBoxReady = true
        		}
        	}
        	a.fireEvent("writeablechange", a, c);
            }
            Ext.form.field.Checkbox.prototype.setReadOnly = function(c) {
            	var a = this,
        		b = a.inputEl;
        	c = !!c;
        	a[c ? "addCls" : "removeCls"](a.readOnlyCls);
        	a.readOnly = c;
        	//c?a.addCls("textFieldGray"):a.removeCls("textFieldGray");
        	if (b) {
        		b.dom.readOnly = c
        	} else {
        		if (a.rendering) {
        			a.setReadOnlyOnBoxReady = true
        		}
        	}
        	a.fireEvent("writeablechange", a, c);
            }
            /**
             * 解决 findRecord value 模糊匹配的问题[更改 exactMatch 的缺省值为 false ][2014-11-12  wenghy]
             * @param property
             * @param value
             * @param start
             * @param anyMatch
             * @param caseSensitive
             * @param exactMatch
             * @returns
             */ 
            Ext.data.Store.prototype.find= function(property, value, start, anyMatch, caseSensitive, exactMatch) {
            	 if(exactMatch==undefined||exactMatch=='undefined')exactMatch=true;
                var fn = this.createFilterFn(property, value, anyMatch, caseSensitive, exactMatch);
                return fn ? this.data.findIndexBy(fn, null, start) : -1;
            }
        });