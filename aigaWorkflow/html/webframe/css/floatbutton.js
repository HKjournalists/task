var ie = document.all != null;

var moz = !ie && document.getElementById != null && document.layers == null;



/*

if (moz) {	// set up ie environment for Moz



	extendEventObject();

	//emulateAttachEvent();

	//emulateFromToElement();

	emulateEventHandlers(["click", "dblclick", "mouseover", "mouseout",

							"mousedown", "mouseup", "mousemove",

							"keydown", "keypress", "keyup"]);

	emulateDocumentAll();

	emulateElement()

	emulateCurrentStyle(["left", "right", "top", "bottom", "width", "height"]);



	// Mozilla returns the wrong button number

	Event.LEFT = 1;

	Event.MIDDLE = 2;

	Event.RIGHT = 3;







}

else {

	Event = {};

	// IE is returning wrong button number as well :-)

	Event.LEFT = 1;

	Event.MIDDLE = 4;

	Event.RIGHT = 2;

}

*/







/*

 * Extends the event object with srcElement, cancelBubble, returnValue,

 * fromElement and toElement

 */

function extendEventObject() {

	Event.prototype.__defineSetter__("returnValue", function (b) {

		if (!b) this.preventDefault();

	});



	Event.prototype.__defineSetter__("cancelBubble", function (b) {

		if (b) this.stopPropagation();

	});



	Event.prototype.__defineGetter__("srcElement", function () {

		var node = this.target;

		while (node.nodeType != 1) node = node.parentNode;

		return node;

	});



	Event.prototype.__defineGetter__("fromElement", function () {

		var node;

		if (this.type == "mouseover")

			node = this.relatedTarget;

		else if (this.type == "mouseout")

			node = this.target;

		if (!node) return;

		while (node.nodeType != 1) node = node.parentNode;

		return node;

	});



	Event.prototype.__defineGetter__("toElement", function () {

		var node;

		if (this.type == "mouseout")

			node = this.relatedTarget;

		else if (this.type == "mouseover")

			node = this.target;

		if (!node) return;

		while (node.nodeType != 1) node = node.parentNode;

		return node;

	});



	Event.prototype.__defineGetter__("offsetX", function () {

		return this.layerX;

	});

	Event.prototype.__defineGetter__("offsetY", function () {

		return this.layerY;

	});

}



/*

 * Emulates element.attachEvent as well as detachEvent

 */

function emulateAttachEvent() {

	window.attachEvent =

	HTMLDocument.prototype.attachEvent =

	HTMLElement.prototype.attachEvent = function (sType, fHandler) {

		var shortTypeName = sType.replace(/on/, "");

		fHandler._ieEmuEventHandler = function (e) {

			window.event = e;

			return fHandler();

		};

		this.addEventListener(shortTypeName, fHandler._ieEmuEventHandler, false);

	};



	window.detachEvent =

	HTMLDocument.prototype.detachEvent =

	HTMLElement.prototype.detachEvent = function (sType, fHandler) {

		var shortTypeName = sType.replace(/on/, "");

		if (typeof fHandler._ieEmuEventHandler == "function")

			this.removeEventListener(shortTypeName, fHandler._ieEmuEventHandler, false);

		else

			this.removeEventListener(shortTypeName, fHandler, true);

	};

}



/*

 * This function binds the event object passed along in an

 * event to window.event

 */

function emulateEventHandlers(eventNames) {

	for (var i = 0; i < eventNames.length; i++) {

		document.addEventListener(eventNames[i], function (e) {

			window.event = e;

		}, true);	// using capture

	}

}



/*

 * Simple emulation of document.all

 * this one is far from complete. Be cautious

 */



function emulateAllModel() {

	var allGetter = function () {

		var a = this.getElementsByTagName("*");

		var node = this;

		a.tags = function (sTagName) {

			return node.getElementsByTagName(sTagName);

		};

		return a;

	};

	HTMLDocument.prototype.__defineGetter__("all", allGetter);

	HTMLElement.prototype.__defineGetter__("all", allGetter);

}



function extendElementModel() {

	HTMLElement.prototype.__defineGetter__("parentElement", function () {

		if (this.parentNode == this.ownerDocument) return null;

		return this.parentNode;

	});



	HTMLElement.prototype.__defineGetter__("children", function () {

		var tmp = [];

		var j = 0;

		var n;

		for (var i = 0; i < this.childNodes.length; i++) {

			n = this.childNodes[i];

			if (n.nodeType == 1) {

				tmp[j++] = n;

				if (n.name) {	// named children

					if (!tmp[n.name])

						tmp[n.name] = [];

					tmp[n.name][tmp[n.name].length] = n;

				}

				if (n.id)		// child with id

					tmp[n.id] = n

			}

		}

		return tmp;

	});



	HTMLElement.prototype.contains = function (oEl) {

		if (oEl == this) return true;

		if (oEl == null) return false;

		return this.contains(oEl.parentNode);

	};

}



/*



document.defaultView.getComputedStyle(el1,<BR>null).getPropertyValue('top');



*/

function emulateCurrentStyle(properties) {

	HTMLElement.prototype.__defineGetter__("currentStyle", function () {

		var cs = {};

		var el = this;

		for (var i = 0; i < properties.length; i++) {

			//cs.__defineGetter__(properties[i], function () {

			//	window.status = "i: " + i	;

			//	return document.defaultView.getComputedStyle(el, null).getPropertyValue(properties[i]);

			//});

			cs.__defineGetter__(properties[i], encapsulateObjects(el, properties[i]));

		}

		return cs;

	});

}

// used internally for emualteCurrentStyle

function encapsulateObjects(el, sProperty) {

	return function () {

		return document.defaultView.getComputedStyle(el, null).getPropertyValue(sProperty);

	};

}



function emulateHTMLModel() {



	// This function is used to generate a html string for the text properties/methods

	// It replaces '\n' with "<BR"> as well as fixes consecutive white spaces

	// It also repalaces some special characters

	function convertTextToHTML(s) {

		s = s.replace(/\&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<BR>");

		while (/\s\s/.test(s))

			s = s.replace(/\s\s/, "&nbsp; ");

		return s.replace(/\s/g, " ");

	}



	HTMLElement.prototype.insertAdjacentHTML = function (sWhere, sHTML) {

		var df;	// : DocumentFragment

		var r = this.ownerDocument.createRange();



		switch (String(sWhere).toLowerCase()) {

			case "beforebegin":

				r.setStartBefore(this);

				df = r.createContextualFragment(sHTML);

				this.parentNode.insertBefore(df, this);

				break;



			case "afterbegin":

				r.selectNodeContents(this);

				r.collapse(true);

				df = r.createContextualFragment(sHTML);

				this.insertBefore(df, this.firstChild);

				break;



			case "beforeend":

				r.selectNodeContents(this);

				r.collapse(false);

				df = r.createContextualFragment(sHTML);

				this.appendChild(df);

				break;



			case "afterend":

				r.setStartAfter(this);

				df = r.createContextualFragment(sHTML);

				this.parentNode.insertBefore(df, this.nextSibling);

				break;

		}

	};



	HTMLElement.prototype.__defineSetter__("outerHTML", function (sHTML) {

	   var r = this.ownerDocument.createRange();

	   r.setStartBefore(this);

	   var df = r.createContextualFragment(sHTML);

	   this.parentNode.replaceChild(df, this);



	   return sHTML;

	});



	HTMLElement.prototype.__defineGetter__("canHaveChildren", function () {

		switch (this.tagName) {

			case "AREA":

			case "BASE":

			case "BASEFONT":

			case "COL":

			case "FRAME":

			case "HR":

			case "IMG":

			case "BR":

			case "INPUT":

			case "ISINDEX":

			case "LINK":

			case "META":

			case "PARAM":

				return false;

		}

		return true;

	});



	HTMLElement.prototype.__defineGetter__("outerHTML", function () {

		var attr, attrs = this.attributes;

		var str = "<" + this.tagName;

		for (var i = 0; i < attrs.length; i++) {

			attr = attrs[i];

			if (attr.specified)

				str += " " + attr.name + '="' + attr.value + '"';

		}

		if (!this.canHaveChildren)

			return str + ">";



		return str + ">" + this.innerHTML + "</" + this.tagName + ">";

	});





	HTMLElement.prototype.__defineSetter__("innerText", function (sText) {

		this.innerHTML = convertTextToHTML(sText);

		return sText;

	});



	var tmpGet;

	HTMLElement.prototype.__defineGetter__("innerText", tmpGet = function () {

		var r = this.ownerDocument.createRange();

		r.selectNodeContents(this);

		return r.toString();

	});



	HTMLElement.prototype.__defineSetter__("outerText", function (sText) {

		this.outerHTML = convertTextToHTML(sText);

		return sText;

	});

	HTMLElement.prototype.__defineGetter__("outerText", tmpGet);



	HTMLElement.prototype.insertAdjacentText = function (sWhere, sText) {

		this.insertAdjacentHTML(sWhere, convertTextToHTML(sText));

	};



}

/*

 * This script was created by Erik Arvidsson (erik@eae.net)

 * for WebFX (http://webfx.eae.net

 * Copyright 2001

 *


 *

 * Created: 2001-03-17

 */



/*

 * This file depends on emulateAttachEvent and extendEventObject

 * found in ieemu.js to get Mozilla to work

 *

 * Styling is currently done in a separate css files



 *

 */



/* Set up IE Emualtion for Mozilla */

if (window.moz == true && (typeof window.emulateAttachEvent != "function" || typeof window.extendEventObject != "function"))

	alert("Error! IE Emulation file not included.");



if (window.moz) {

	emulateAttachEvent();

	extendEventObject();

}

/* end Mozilla specific emulation initiation */



function createButton(el) {

        //alert(el.id);

	//el.attachEvent("onmouseover",	createButton.overCoolButton);

	el.onmouseover = createButton.overCoolButton;

	el.attachEvent("onmouseout",	createButton.outCoolButton);

	el.attachEvent("onmousedown",	createButton.downCoolButton);

	el.attachEvent("onmouseup",	createButton.upCoolButton);

	el.attachEvent("onclick",	createButton.clickCoolButton);

	el.attachEvent("ondblclick",	createButton.clickCoolButton);

	el.attachEvent("onkeypress",	createButton.keypressCoolButton);

	el.attachEvent("onkeyup",	createButton.keyupCoolButton);

	el.attachEvent("onkeydown",	createButton.keydownCoolButton);

	el.attachEvent("onfocus",	createButton.focusCoolButton);

	el.attachEvent("onblur",	createButton.blurCoolButton);



	el.className = "coolButton";



	el.setEnabled	= createButton.setEnabled;

	el.getEnabled	= createButton.getEnabled;

	el.setValue	= createButton.setValue;

	el.getValue	= createButton.getValue;

	el.setToggle	= createButton.setToggle;

	el.getToggle	= createButton.getToggle;

	el.setAlwaysUp	= createButton.setAlwaysUp;

	el.getAlwaysUp	= createButton.getAlwaysUp;



	el._enabled	= true;

	el._toggle	= false;

	el._value	= false;

	el._alwaysUp	= false;



        //alert("CreateButton--Return:"+el);

	return el;

}



createButton.LEFT = window.moz ? 0 : 1;



/* event listeners */



createButton.overCoolButton = function () {

	//alert("onmouseover");

	var toEl = createButton.getParentCoolButton(window.event.toElement);

	//alert(toEl.id);

	var fromEl = createButton.getParentCoolButton(window.event.fromElement);

	//alert(fromEl.id);

	if (toEl == fromEl || toEl == null) return;



	toEl._over = true;



	if (!toEl._enabled) return;



	createButton.setClassName(toEl);

};



createButton.outCoolButton = function () {

	var toEl = createButton.getParentCoolButton(window.event.toElement);

	var fromEl = createButton.getParentCoolButton(window.event.fromElement);

	if (toEl == fromEl || fromEl == null) return;



	fromEl._over = false;

	fromEl._down = false;



	if (!fromEl._enabled) return;



	createButton.setClassName(fromEl);

};



createButton.downCoolButton = function () {

	if (window.event.button != createButton.LEFT) return;



	var el = createButton.getParentCoolButton(window.event.srcElement);

	if (el == null) return;



	el._down = true;



	if (!el._enabled) return;



	createButton.setClassName(el);

};



createButton.upCoolButton = function () {

	if (window.event.button != createButton.LEFT) return;



	var el = createButton.getParentCoolButton(window.event.srcElement);

	if (el == null) return;



	el._down = false;



	if (!el._enabled) return;



	if (el._toggle)

		el.setValue(!el._value);

	else

		createButton.setClassName(el);

};



createButton.clickCoolButton = function () {

 	var el = createButton.getParentCoolButton(window.event.srcElement);

	el.onaction = el.getAttribute("onaction");

	if (el == null || !el._enabled || el.onaction == "" || el.onaction == null) return;



	if (typeof el.onaction == "string")

		el.onaction = new Function ("event", el.onaction);



	el.onaction(window.event);

};



createButton.keypressCoolButton = function () {

	var el = createButton.getParentCoolButton(window.event.srcElement);

	if (el == null || !el._enabled || window.event.keyCode != 13) return;



	el.setValue(!el._value);



	if (el.onaction == null) return;



	if (typeof el.onaction == "string")

		el.onaction = new Function ("event", el.onaction);



	el.onaction(window.event);

};



createButton.keydownCoolButton = function () {

	var el = createButton.getParentCoolButton(window.event.srcElement);

	if (el == null || !el._enabled || window.event.keyCode != 32) return;

	createButton.downCoolButton();

};



createButton.keyupCoolButton = function () {

	var el = createButton.getParentCoolButton(window.event.srcElement);

	if (el == null || !el._enabled || window.event.keyCode != 32) return;

	createButton.upCoolButton();



	//el.setValue(!el._value);	// is handled in upCoolButton()



	if (el.onaction == null) return;



	if (typeof el.onaction == "string")

		el.onaction = new Function ("event", el.onaction);



	el.onaction(window.event);

};



createButton.focusCoolButton = function () {

	var el = createButton.getParentCoolButton(window.event.srcElement);

	if (el == null || !el._enabled) return;

	createButton.setClassName(el);

};



createButton.blurCoolButton = function () {

	var el = createButton.getParentCoolButton(window.event.srcElement);

	if (el == null) return;



	createButton.setClassName(el)

};



createButton.getParentCoolButton = function (el) {

	//alert("getParentCoolButton="+el.id);

	if (el == null) return null;

	if (/coolButton/.test(el.className))

		return el;

	return createButton.getParentCoolButton(el.parentNode);

};



/* end event listeners */



createButton.setClassName = function (el) {

	//alert("createButton.setClassName ");

	var over = el._over;

	var down = el._down;

	var focused;

	try {

		focused = (el == document.activeElement && el.tabIndex > 0);

	}

	catch (exc) {

		focused = false;

	}



	if (!el._enabled) {

		if (el._value)

			el.className = "coolButtonActiveDisabled";

		else

			el.className = el._alwaysUp ? "coolButtonUpDisabled" : "coolButtonDisabled";

	}

	else {

		if (el._value) {

			if (over || down || focused)

				el.className = "coolButtonActiveHover";

			else

				el.className = "coolButtonActive";

		}

		else {

			if (down)

				el.className = "coolButtonActiveHover";

			else if (over || el._alwaysUp || focused)

				el.className = "coolButtonHover";

			else

				el.className = "coolButton";

		}

	}

};



createButton.setEnabled = function (b) {

	alert("createButton.setEnabled");

	if (this._enabled != b) {

		this._enabled = b;

		createButton.setClassName(this, false, false);

		if (!window.moz) {

			if (b)

				this.innerHTML = this.firstChild.firstChild.innerHTML;

			else

				this.innerHTML = "<span class='coolButtonDisabledContainer'><span class='coolButtonDisabledContainer'>" + this.innerHTML + "</span></span>";

	       alert(this.id + ".innerHTML="+this.innerHTML);

		}

	}

};



createButton.getEnabled = function () {

	return this._enabled;

};



createButton.setValue = function (v, bDontTriggerOnChange) {

	if (this._toggle && this._value != v) {

		this._value = v;

		createButton.setClassName(this, false, false);



		this.onchange = this.getAttribute("onchange");



		if (this.onchange == null || this.onchange == "" || bDontTriggerOnChange) return;



		if (typeof this.onchange == "string")

			this.onchange = new Function("", this.onchange);



		this.onchange();

	}

};



createButton.getValue = function () {

	return this._value;

};



createButton.setToggle = function (t) {

	if (this._toggle != t) {

		this._toggle = t;

		if (!t) this.setValue(false);

	}

};



createButton.getToggle = function () {

	return this._toggle;

};



createButton.setAlwaysUp = function (up) {

	if (this._alwaysUp != up) {

		this._alwaysUp = up;

		createButton.setClassName(this, false, false);

	}

};



createButton.getAlwaysUp = function () {

	return this._alwaysUp;

};
