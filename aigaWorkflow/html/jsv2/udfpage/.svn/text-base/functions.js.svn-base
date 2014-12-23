var isIE = navigator.appName.indexOf("Microsoft") != -1;
var isIE5 = navigator.userAgent.indexOf('MSIE 5.0') > 0;
var isOpera = navigator.userAgent.indexOf("Opera") != -1;

var lastMouseX;
var lastMouseY;
var curPopupWindow = null;
var helpWindow = null;
var win = null;

var beenFocused = false;
document.onmousedown = markFocused;
function markFocused() {
    beenFocused = true;
}

function copyInnerHTML(src, dest) {
    dest.innerHTML = src.innerHTML;
}

function setLastMousePosition(e) {
    if (navigator.appName.indexOf("Microsoft") != -1) e = window.event;
    lastMouseX = e.screenX;
    lastMouseY = e.screenY;
}

function openClickout(url) {
    window.open(url, "_blank", 'width=640,height=480,dependent=no,resizable=yes,toolbar=yes,status=yes,directories=yes,menubar=yes,scrollbars=1', false);
}

function openIntegration(url, props, positionType) {
    var newWindow = window.open(url, "_blank", props, false);
    if (positionType == 2){
        newWindow.moveTo(0, 0);
    } else if (positionType == 0){
        newWindow.moveTo(0, 0);
        newWindow.resizeTo(self.screen.width, self.screen.height);
    }
}

/**
 * Calls through to the openPopupFocus() with closeOnLoseFocus set to true.
 */
function openPopup(url, name, pWidth, pHeight, features, snapToLastMousePosition) {
    openPopupFocus (url, name, pWidth, pHeight, features, snapToLastMousePosition, true);
}

/**
 * Used for help popup links that need #'s escaped inline.
 */
function openPopupFocusEscapePounds(url, name, pWidth, pHeight, features, snapToLastMousePosition, closeOnLoseFocus) {
    openPopupFocus (url.replace("#","%23"), name, pWidth, pHeight, features, snapToLastMousePosition, closeOnLoseFocus);
}

/**
 * Handles popup windows.
 * If snapToLastMousePosition is true, then the popup will open up near the mouse click.
 * If closeOnLoseFocus is true, then it will close when the user clicks back into the browser window that opened it.
 */
function openPopupFocus(url, name, pWidth, pHeight, features, snapToLastMousePosition, closeOnLoseFocus) {
    closePopup();

    if (snapToLastMousePosition) {
        if (lastMouseX - pWidth < 0) {
            lastMouseX = pWidth;
        }
        if (lastMouseY + pHeight > screen.height) {
            lastMouseY -= (lastMouseY + pHeight + 50) - screen.height;
        }
        lastMouseX -= pWidth;
        lastMouseY += 10;
        features += ",screenX=" + lastMouseX + ",left=" + lastMouseX + ",screenY=" + lastMouseY + ",top=" + lastMouseY;
    }

    if (closeOnLoseFocus) {
        curPopupWindow = window.open(url, name, features, false);
        curPopupWindow.focus ();
    } else {
        // assign the open window to a dummy var so when closePopup() is called it won't be assigned to curPopupWindow
        win = window.open(url, name, features, false);
        win.focus ();
    }
}

function closePopup() {
    if (curPopupWindow != null) {

        if (!curPopupWindow.closed) {
            curPopupWindow.close();
        }
        curPopupWindow = null;
    }
}

function openLookup(baseURL,width,modified,searchParam,originalWidthParam) {
    if (modified == '1') baseURL = baseURL + searchParam;
    baseURL = baseURL + "&" + originalWidthParam + "=";
    if (isIE) {
        baseURL = baseURL + document.body.offsetWidth;
    } else {
        baseURL = baseURL + window.innerWidth;
    }
    openPopup(baseURL, "lookup", 350, 300, "width="+width+",height=300,toolbar=no,status=no,directories=no,menubar=no,resizable=yes,scrollable=no", true);
}

function pick(form,field,val) {
    eval("document."+form+"[\""+field+"\"].value=" + "\""+val+"\"");
    closePopup();
    return false;
}

function pickSubmit(form,field,val) {
    eval("document."+form+"[\""+field+"\"].value=" + "\""+val+"\"");
    eval("document."+form+".submit()");
    closePopup();
    return false;
}

function pickcolor(form,field,val) {
    newval = parseInt(val, 16);
    eval("document."+form+"[\""+field+"\"].value=" + "\""+newval+"\";");
    eval("document.getElementById(\""+field+"cell\").style.backgroundColor=\"#"+val+"\"");
    closePopup();
    return false;
}

function comboBoxPick (form, fieldName, comboBoxArrayName, index) {
    // get the field we are inserting the value into
    var field = eval ("document." +form+ "[\"" +fieldName+ "\"]");

    if (field != null) {
        // get to the javascript array for this combobox
        var comboBoxArray = eval (comboBoxArrayName);
        if (comboBoxArray != null) {

            if (index >= 0 && index < comboBoxArray.length) {
                // if we pass the bounds check, assign the value
                field.value = comboBoxArray[index];
            }
        }
    }
    closePopup ();
    return false;
}

function listProperties(obj) {
    var names = "";
    for (var i in obj) names += i + ", ";
    alert(names);
}

/**
relatedFieldName/Value are for copying in a value other than the selected name.
extraNameElementName identifies another element on the parent page to copy the name again (if the element is empty).
*/
function lookupPick(formName, parentIdElementName, parentEditElementName, relatedFieldName, id, display, relatedFieldValue, extraNameElementName) {
    var parentIdElement = document.getElementsByName(parentIdElementName)[0];
    var parentEditElement = document.getElementsByName(parentEditElementName)[0];
    var parentEditOldValueElement = document.getElementsByName(parentEditElementName + "_lkold")[0];
    var relatedFieldElement = document.getElementsByName(relatedFieldName)[0];
    var extraNameElement = document.getElementsByName(extraNameElementName)[0];

    if (parentIdElement.type == "select-one") {
        var found = false;
        for (i = 0; i < parentIdElement.options.length; i++) {
            if (parentIdElement.options[i].value == id ) {
                parentIdElement.selectedIndex = i;
                found = true;
                break;
            }
        }
        if (!found) {
            parentIdElement.options[parentIdElement.options.length] = new Option(display, id);
            parentIdElement.selectedIndex = parentIdElement.options.length - 1;
        }
        parentEditElement.value = display;
        parentEditOldValueElement.value = display;
    } else {
        // If we want to default display text into another field, make sure
        // the field's either empty or matches our parent lookup's value exactly
        if (extraNameElementName) {
            if ("undefined" != typeof extraNameElement &&
                (extraNameElement.value.length == 0 || extraNameElement.value == parentEditElement.value)) {
                extraNameElement.value = display;
            }
        }

        parentIdElement.value = id;
        parentEditElement.value = display;
        parentEditOldValueElement.value = display;
    }

    if (relatedFieldName.length > 0) {
        relatedFieldElement.value = relatedFieldValue;
    }

    var onPick = document.getElementsByName(parentEditElementName+ '_onpk')[0];
    if (onPick && onPick.value != '') {
        eval(onPick.value);
    }

    var parentSubmitParam = document.getElementsByName(parentEditElementName+ '_lspf')[0];
    var doPost = parentSubmitParam.value;
    if (doPost == '1') {
        eval("document."+formName+".submit()");
    }
    closePopup();

    return false;
}

function setFocusOnLoad() {
    if (!beenFocused) { setFocus(); }
}

function setFocus() {
    var sidebarSearch;
    // search for a tabIndexed field to focus on
    for(var firstIndex=1; firstIndex < 5; firstIndex ++ ){
        var nextIndex = firstIndex;
        for (var frm = 0; frm < document.forms.length; frm++) {
            for (var fld = 0; fld < document.forms[frm].elements.length; fld++) {
                var elt = document.forms[frm].elements[fld];
                if ( elt.tabIndex != nextIndex) continue;
                if ((elt.type == "text" || elt.type == "textarea" || elt.type == "password") && !elt.disabled
                   && elt.name != "sbstr" &&  elt.name.indexOf("owner") != 0 && elt.name.indexOf("tsk1") != 0 && elt.name.indexOf("evt1") != 0) {
                    elt.focus();
                    if (elt.type == "text") {
                        elt.select();
                    }
                    return true;
                } else {
                    nextIndex++;
                    fld = 0;
                }
            }
        }
    }

    // failed to find a tabIndexed field, try to find the field based on it's natural position.
    for (var frm = 0; frm < document.forms.length; frm++) {
        for (var fld = 0; fld < document.forms[frm].elements.length; fld++) {
            var elt = document.forms[frm].elements[fld];
            // skip buttons, radio, or check-boxes
            // to skip "select" types, remove from if statement
            if ((elt.type == "text" || elt.type == "textarea" || elt.type == "password") && !elt.disabled) {
                if (elt.name == "sbstr" && document.forms[frm].name == "sbsearch") {
                    sidebarSearch = elt;
                } else if (elt.name.indexOf("owner") != 0) {
                    elt.focus();
                    // select text in text field or textarea
                    if (elt.type == "text") {
                        elt.select();
                    }
                    return true;
                }
            }
        }
    }

    return true;
}

function setNamedFocus(element_name) {
    for (var frm = 0; frm < document.forms.length; frm++) {
        for (var fld = 0; fld < document.forms[frm].elements.length; fld++) {
            var elt = document.forms[frm].elements[fld];
            if (elt.name == element_name) {
                elt.focus();
                if (elt.type == "text") {
                    elt.select();
                }
                return true;
            }
        }
    }
    return true;
}

// removes the leading and trailing spaces from a string,
// similar to the java.lang.String.trim() function
// added by lturetsky, taken from http://www.voy.com/1888/58.html
function trim(st) {
    var len = st.length
    var begin = 0, end = len - 1;
    while (st.charAt(begin) == " " && begin < len) {
        begin++;
    }
    while (st.charAt(end) == " " && begin < end) {
        end--;
    }
    return st.substring(begin, end+1);
}


function formatPhone (field) {
    field.value = trim(field.value);

    var ov = field.value;
    var v = "";
    var x = -1;

    // is this phone number 'escaped' by a leading plus?
    if (0 < ov.length && '+' != ov.charAt(0)) { // format it
        // count number of digits
        var n = 0;
        if ('1' == ov.charAt(0)) {  // skip it
            ov = ov.substring(1, ov.length);
        }

        for (i = 0; i < ov.length; i++) {
            var ch = ov.charAt(i);

            // build up formatted number
            if (ch >= '0' && ch <= '9') {
                if (n == 0) v += "(";
                else if (n == 3) v += ") ";
                else if (n == 6) v += "-";
                v += ch;
                n++;
            }
            // check for extension type section;
            // are spaces, dots, dashes and parentheses the only valid non-digits in a phone number?
            if (! (ch >= '0' && ch <= '9') && ch != ' ' && ch != '-' && ch != '.' && ch != '(' && ch != ')') {
                x = i;
                break;
            }
        }
        // add the extension
        if (x >= 0) v += " " + ov.substring(x, ov.length);

        // if we recognize the number, then format it
        if (n == 10 && v.length <= 40) field.value = v;
    }
    return true;
}

function clearcols () {
    for (var frm = 0; frm < document.forms.length; frm++) {
        for (var fld = 0; fld < document.forms[frm].elements.length; fld++) {
            var elt = document.forms[frm].elements[fld];
            if (elt.name == "c" || elt.name.substring(0,2) == "c_") {
                elt.checked = false;
            }
        }
    }
}

function setcols () {
    for (var frm = 0; frm < document.forms.length; frm++) {
        for (var fld = 0; fld < document.forms[frm].elements.length; fld++) {
            var elt = document.forms[frm].elements[fld];
            if (elt.name == "c" || elt.name.substring(0,2) == "c_") {
                elt.checked = true;
            }
        }
    }
}

function setUsername(uname, fname, lname, suffix) {
    if (uname.value.length == 0) {
        uname.value =
                    fname.value.substring(0,1).toLowerCase()
                    + lname.value.toLowerCase()
                    + "@"
                    + suffix.value;
    }
}
function setAlias(alias, fname, lname) {
    if (alias.value.length == 0) {
        alias.value = fname.value.substring(0,1).toLowerCase() +
                      lname.value.substring(0,4).toLowerCase();
    }
}

// POPUP WINDOW NUMBER 1
function popWin(url) {
    closePopup();
    curPopupWindow = window.open(url,"win","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=550,height=300",false);
}
/**
 * Do NOT remove this function!
 * This function is used from within our help docs.
 */
function popWin2(url) {
   win = window.open(url,"win","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=720,height=500",false);
}

/**
 * Do NOT remove this function!
 * Our help docs tell our customers to use this call to open links up in a new browser window.
 */
function adminWin(url) {
   win = window.open(url,"win","toolbar=1,location=1,directories=0,status=1,menubar=1,scrollbars=1,resizable=1,width=800,height=600",false);
}

// Changed name of window for printWin so that Printable views do not disappear
// Newname is popWin, Oldname(changed) was curPopupWindow
function printWin(url) {
  popWin = window.open(url,"win","dependent=no,toolbar=1,directories=0,location=0,status=1,menubar=1,scrollbars=1,resizable=1,width=705,height=400",false);
  popWin.focus();
}


function moveSelectElement3(sourceSelect, targetSelect, sourceLabel, targetLabel, keepTarget) {
    if (sourceSelect.selectedIndex > -1) {
        for (i=0; i < sourceSelect.length; ++i) {
            var selectedOption = sourceSelect.options[i];
            if (selectedOption.selected) {
                if (selectedOption.text != sourceLabel) {
                    var newOption = new Option(selectedOption.text, selectedOption.value);
                    if (targetSelect.options.length > 0 && targetSelect.options[0].text == targetLabel) {
                        targetSelect.options[0] = newOption;
                        targetSelect.selectedIndex = 0;
                    } else {
                        targetSelect.options[targetSelect.options.length] = newOption;
                        targetSelect.selectedIndex = targetSelect.options.length - 1;
                    }
                } else {
                    sourceSelect.selectedIndex = -1;
                }
            }
        }
        if(!keepTarget)
        {   removeSelectElement3(sourceSelect, sourceLabel);
        }
    }
}

function moveOption (sourceSelect, targetSelect,
                     keepSourceLabel, unmovableSourceValues, unmovableAlertMessage,
                     keepTargetLabel) {

    var sourceOptions = sourceSelect.options;

    var canMove;
    var option;

    // find which ones are selected...
    var selectedIds = new Array ();
    var index = 0;
    if (sourceSelect.cannotBeEmpty) {
        var numSelected = 0;
        for (var i = 0; i < sourceSelect.length; i++) {
            if (sourceSelect.options[i].selected) numSelected++;
        }
        if (numSelected == sourceSelect.options.length) {
            if (sourceSelect.handleEmptyList) {
                sourceSelect.handleEmptyList();
            }
            return;
        }
    }
    for (var i = 0; i < sourceSelect.length; i++) {
        option = sourceOptions[i];
        if (option.selected) {
            canMove = (option.text != keepSourceLabel);
            if (canMove && unmovableSourceValues != null) {
                // make sure we don't move any options defined as unmovable
                for (var j = 0; j < unmovableSourceValues.length; j++) {
                    if (unmovableSourceValues[j] == option.value) {
                        canMove = false;
                        if (unmovableAlertMessage != null)
                            alert(unmovableAlertMessage);
                        break;
                    }
                }
            }

            // if this option can be moved we add it to our array of elements to move
            if (canMove) {
                selectedIds[index] = i;
                index++;
            } else {
                // if we can't move this option, then unselect it
                option.selected = false;
            }
        }
    }

    // move them over one by one
    var targetOptions = targetSelect.options;
    if (selectedIds.length > 0) {
        targetSelect.selectedIndex = -1;
        for (var i = 0; i < selectedIds.length; i++) {
            option = new Option (sourceOptions[selectedIds[i]].text, sourceOptions[selectedIds[i]].value);

            // replace the target value if its the last one
            if (targetOptions.length == 1 && targetOptions[0].text == keepTargetLabel) {
                targetOptions[0] = option;
                targetOptions[0].selected = true;
            } else {
                targetOptions[targetOptions.length] = option;
                targetOptions[targetOptions.length-1].selected = true;
            }
        }
    }

    // notify the Select Elements that their contents have changed
    if (targetSelect["onchange"]) {
        targetSelect.onchange();
    }
    if (sourceSelect["onchange"]) {
        sourceSelect.onchange();
    }

    // remove selected values from the source, starting with the last one selected
    for (var i = selectedIds.length - 1; i > -1; i--) {
        sourceSelect.remove(selectedIds[i]);
    }

    // Workaround here for a bug in IE:
    // If you have a select element with many values, and you've scrolled to
    // the bottom and move an option from the top-most element you can now see,
    // IE would not refresh the select element, leaving a hole in the list.
    // By forcing the select element disabled and back, it seems to refresh the
    // element properly.
    sourceSelect.disabled = true;
    sourceSelect.disabled = false;

    // make sure we don't get an empty list
    if (sourceOptions.length == 0) {
        sourceOptions[0] = new Option (keepSourceLabel, keepSourceLabel);
    }

    // if we moved anything, put the focus on the target list box
    if (selectedIds.length > 0) targetSelect.focus ();

    // invoke if the Slect Element has local function
    if (targetSelect["onLocalMoveOptions"])
        targetSelect.onLocalMoveOptions();
    if (sourceSelect["onLocalMoveOptions"])
        sourceSelect.onLocalMoveOptions();
}

function removeSelectElement3(sourceSelect, sourceLabel)
{   if (sourceSelect.selectedIndex > -1)
    {   for (i=sourceSelect.length-1; i > -1; i--)
        {   if (sourceSelect.options[i].selected) sourceSelect.options[i] = null;
        }
        if (sourceSelect.length == 0)
        {   var placeHolder = new Option(sourceLabel, sourceLabel);
            sourceSelect.options[0] = placeHolder;
        }
    }
}


function moveUp(sourceSelect, topSourceValue, unmovableAlertMessage) {
    if (sourceSelect.length > 1) {
        var options = sourceSelect.options;

        // find which ones are selected...
        var selectedIds = new Array ();
        var index = 0;
        if (topSourceValue != null) {
            if (options[0].value == topSourceValue && options[1].selected) {
                options[1].selected = false;
                if (unmovableAlertMessage != null)
                    alert(unmovableAlertMessage);
                        }
            }
        for (var i = 1; i < sourceSelect.length; i++) {
            if (options[i].selected) {
                selectedIds[index] = i;
                index++;
            }
        }

        // move each selected option up
        var selId;
        for (var i = 0; i < selectedIds.length; i++) {
            selId = selectedIds[i];
            privateMoveUp (options, selId);
            options[selId].selected = false;
            options[selId-1].selected = true;
        }

        sourceSelect.focus ();

        // invoke if the Slect Element has local function
        if (sourceSelect["onLocalMoveUp"])
            sourceSelect.onLocalMoveUp();
    }
}

function moveDown(sourceSelect, topSourceValue, unmovableAlertMessage) {
    if (sourceSelect.length > 1) {
        var options = sourceSelect.options;

        // find which ones are selected
        var selectedIds = new Array ();
        var index = 0;
        if (topSourceValue != null) {
            // make sure we don't move the top value down
            if (topSourceValue == options[0].value && options[0].selected) {
                options[0].selected = false;
                if (unmovableAlertMessage != null)
                    alert(unmovableAlertMessage);
            }
        }

        for (var i = sourceSelect.length-2; i >= 0; i--) {
            if (sourceSelect.options[i].selected) {
                // add any remaining selected elements to our array of elements to move
                selectedIds[index] = i;
                index++;
            }
        }

        // move each selected element down
        var selId;
        for (var i = 0; i < selectedIds.length; i++) {
            selId = selectedIds[i];
            privateMoveDown (options, selId);
            options[selId].selected = false;
            options[selId+1].selected = true;
        }

        sourceSelect.focus ();

        // invoke if the Slect Element has local function
        if (sourceSelect["onLocalMoveDown"])
            sourceSelect.onLocalMoveDown();
    }
}


function moveTop(sourceSelect) {
    var selIndex = sourceSelect.selectedIndex;

    if (sourceSelect.length > 1 && selIndex > 0) {
        var options = sourceSelect.options;

        for (var i = selIndex; i > 0; i--) {
            privateMoveUp (options, i);
        }

        sourceSelect.focus ();
        sourceSelect.selectedIndex = 0;

        // invoke if the Slect Element has local function
        if (sourceSelect["onLocalMoveTop"])
            sourceSelect.onLocalMoveTop();
    }
}

function moveBottom(sourceSelect) {
    var selIndex = sourceSelect.selectedIndex;

    // gots to have at least 2 items and something selected, but not the last one
    if (sourceSelect.length > 1 && selIndex > -1 && selIndex < sourceSelect.length - 1) {
        var options = sourceSelect.options;

        for (var i = selIndex; i < sourceSelect.length - 1; i++) {
            privateMoveDown (options, i);
        }

        sourceSelect.focus ();
        sourceSelect.selectedIndex = sourceSelect.length - 1;

        // invoke if the Slect Element has local function
        if (sourceSelect["onLocalMoveBottom"])
            sourceSelect.onLocalMoveBottom();
    }
}

/*
 * Do not call this function directly.
 * As it does NO bounds checking.
 * Please use the moveUp or moveTop calls.
 */
function privateMoveUp (options, index) {
    var newOption = new Option (options[index-1].text, options[index-1].value);
    options[index-1].text = options[index].text;
    options[index-1].value = options[index].value;
    options[index].text = newOption.text;
    options[index].value = newOption.value;
}

/*
 * Do not call this function directly.
 * As it does NO bounds checking.
 * Please use the moveDown or moveBottom calls.
 */
function privateMoveDown (options, index) {
    var newOption = new Option (options[index+1].text, options[index+1].value);
    options[index+1].text = options[index].text;
    options[index+1].value = options[index].value;
    options[index].text = newOption.text;
    options[index].value = newOption.value;
}


/**
 * Used when submitting a dueling list boxes element.
 * Stores all the values into hidden form parameters so we can get them out
 */
function saveAllSelected (fromSelectArray, toArray, delim, escape, emptyLabel) {
    var i,j,escapedValue;
    // loop through all the select elements
    for (i = 0; i < fromSelectArray.length; i++) {
        toArray[i].value = ''; // clear out the value to start
        // now loop through all the values in the select element
        for (j = 0; j < fromSelectArray[i].length; j++) {
            // copy over the value as long as it is not the emptyLabel
            if (!(fromSelectArray[i].length == 1 && fromSelectArray[i].options[0].value == emptyLabel)) {
                var val = fromSelectArray[i].options[j].value.replace(new RegExp(escape+escape,"g"), escape+escape);
                toArray[i].value += val.replace(new RegExp(delim,"g"), escape+delim);
            }

            // add the delimiter (except after the last one)
            if (j + 1 < fromSelectArray[i].length) {
                toArray[i].value += delim;
            }
        }
    }
}

function openwizard(url, name, resizable) {
  var win = window.open('', name, 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable='+resizable+',width=675,height=550,screenx=50,screeny=10,left=50,top=10',false)
  if ((win.document.URL == '') || (win.document.URL == 'about:blank')) win.location = url;
  win.focus ();
}

function openwizard2(url, name, resizable) {
  var win = window.open(url, name, 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable='+resizable+',width=675,height=550,screenx=50,screeny=10,left=50,top=10',false)

}

function escapeUTF(src) {
    var ret = "";
    for (i = 0; i < src.length; i++) {
        var ch = src.charCodeAt(i);
        if (ch <= 0x7F) {
            ret += escape(src.charAt(i));
        } else if (ch <= 0x07FF) {
            ret += '%' + ((ch >> 6) | 0xC0).toString(16) + '%' + ((ch & 0x3F) | 0x80).toString(16);
        } else if (ch >= 0x0800) {
            ret += '%' + ((ch >> 12) | 0xE0).toString(16) +
                   '%' + (((ch >> 6) & 0x3F) | 0x80).toString(16) + '%' + ((ch & 0x3F) | 0x80).toString(16);
        }
    }
    return ret;
}

function openRefer(url) {
    window.open(url, 'referv2', 'resizable=no,toolbar=no,status=no,directories=no,scrollbars=yes,width=420,height=500', false);
}

function changeOpenerWindowLocation (url) {
    if ((window.top.opener == null) || window.top.opener.closed) {
        window.top.open (url);
    } else {
        window.top.opener.location.href = url;
        window.top.opener.focus ();
    }
}

function verifyChecked(form, element_name, errorMessage) {
    for (i = 0; i < form.elements.length; i++) {
        if ((form.elements[i].name == element_name) && form.elements[i].checked) {
            return true;
        }
    }

    // if we haven't returned yet, it's not checked
    alert(errorMessage);
    return false;
}

function verifyCheckedWarning(form, element_name, errorMessage) {
    var isChecked = false;
    for (i = 0; i < form.elements.length; i++) {
        if ((form.elements[i].name == element_name) && form.elements[i].checked) {
            isChecked = true;
        }
    }
    if (isChecked) {
        return window.confirm(errorMessage);
    }
    return true;
}

function submitFormActionURL (form, url) {
    form.action = url;
    form.submit();
}

function SelectChecked(form, element_name, value)
{
    var i = 0;
    for (i = 0; i < form.elements.length; i++) {
        if (form.elements[i].name == element_name) {
            form.elements[i].checked = value;
        }
    }
}

function SelectAllOrNoneByCheckbox(form, element_name, control)
{
    SelectChecked(form, element_name, control.checked);
}

function getLoginCookieValue()
{
    var c = document.cookie;
    var idx = c.indexOf('login=');
    if ( idx == -1) return "";
    idx += 'login='.length;
    var end = c.indexOf(';',idx);
    if ( end == -1) end = c.length;
    return c.substring(idx,end);
}

function loader()
{
     var username = getLoginCookieValue();
     if (username.length > 0) {
         document.login_noop.un_noop.value = username;
         document.login.un.value = username;
         document.login.pw.focus();
     } else {
         document.login_noop.un_noop.focus();
     }
     document.login.width.value=screen.width;
     document.login.height.value=screen.height;
}

    function handleMSPChange(sel) {
        var sElem = document.getElementById(sel.id + '_selected');
        var uElem = document.getElementById(sel.id + '_unselected');
        var sI = 0;
        var uI = 0;
        sElem.length = 0;
        uElem.length = 0;
        for (var i = 0; i < sel.options.length; i++) {
            if (sel.options[i].selected) {
                sElem.options[sI] = new Option(sel.options[i].text, sel.options[i].value);;
                sElem.options[sI].originalIndex = i;
                sI++;
            } else {
                uElem.options[uI] = new Option(sel.options[i].text, sel.options[i].value);
                uElem.options[uI].originalIndex = i;
                uI++;
            }
        }
        if (!sElem.style.width) {
            sel.style.display = 'block';
            var selW = sel.scrollWidth;
            selW = selW + 35;
            sel.style.display = 'none';
            sElem.style.width = selW;
            uElem.style.width = selW;
        }
    }

    function handleMSPSelect(selId) {
        var mainElem = document.getElementById(selId);
        var uElem = document.getElementById(selId + '_unselected');
        for (var i = 0; i < uElem.options.length; i++) {
            if (uElem.options[i].selected) {
                mainElem.options[uElem.options[i].originalIndex].selected = true;
            }
        }
        handleMSPChange(mainElem);
    }

    function handleMSPUnSelect(selId) {
        var mainElem = document.getElementById(selId);
        var sElem = document.getElementById(selId + '_selected');
        for (var i = 0; i < sElem.options.length; i++) {
            if (sElem.options[i].selected) {
                mainElem.options[sElem.options[i].originalIndex].selected = false;
            }
        }
        handleMSPChange(mainElem);
    }

    function handleSelectAllNoneCheckboxClick(chkbox, children) {
        for (var i = 0; i < children.length; i++) {
            var child = document.getElementById(children[i]);
            if (child) {
                child.checked = chkbox.checked;
            }
        }
    }



    function getObjX(obj){
        if(!obj.offsetParent) return 0;
        var x = getObjX(obj.offsetParent);
        return obj.offsetLeft + x;
    }

    function getObjY(obj){
        if(!obj.offsetParent) return 0;
        var y = getObjY(obj.offsetParent);
        return obj.offsetTop + y;
    }
    function getScrollX(){
        if (window.pageXOffset) return window.pageXOffset;
        if (document.body.scrollHeight) return document.body.scrollLeft;
    }
    function getScrollY(){
        if (window.pageYOffset) return window.pageYOffset;
        if (document.body.scrollWidth) return document.body.scrollTop;
    }
    function getMouseX(evt) {
        if (evt.pageX) return evt.pageX;
        obj = getSrcElement(evt);
        return getScrollX() + evt.x;
    }
    function getMouseY(evt) {
        if (evt.pageY) return evt.pageY;
        return getScrollY() + evt.y;
    }
    function getSrcElement(evt) {
        evt = getEvent(evt);
        if (evt.srcElement) return evt.srcElement;
        return evt.currentTarget;
    }
    function getEvent(evt) {
        if (isIE) return window.event;
        return evt;
    }
    function ltrim(s) {
        return s.replace( /^\s*/, "" );
    }

    function rtrim(s) {
        return s.replace( /\s*$/, "" );
    }

    function trim(s){
        return rtrim(ltrim(s));
    }


    function setCookie(name, value, expires, path) {
        document.cookie= name + '=' + escape(value) +
            ((expires) ? '; expires=' + expires.toGMTString() : '') +
            ((path) ? '; path=' + path : '; path=/');
    }

    function getCookie(name) {
        var dc = document.cookie;
        var prefix = name + '=';
        var begin = dc.indexOf('; ' + prefix);
        if (begin == -1) {
            begin = dc.indexOf(prefix);
            if (begin != 0) return null;
        } else {
            begin += 2;
        }
        var end = document.cookie.indexOf(';', begin);
        if (end == -1) {
            end = dc.length;
        }
        return unescape(dc.substring(begin + prefix.length, end));
    }

    function deleteCookie(name, path) {
        if (getCookie(name)) {
            document.cookie = name + '=' +
                ((path) ? '; path=' + path : '; path=/') +
                '; expires=Thu, 01-Jan-70 00:00:01 GMT';
        }
    }

    function addTwistCookie(cookieName, headerId, onOff) {
        var currentCookie = getCookie(cookieName);
        var cookieVal = headerId + ':' + (onOff ? '1' : '0') + ',' ;

        if (currentCookie) {
            var start = currentCookie.indexOf(headerId);
            while (start > -1) {
                var end = start + 18;
                var val = currentCookie.substring(start, end);
                currentCookie = currentCookie.substring(0, start) + currentCookie.substring(end, currentCookie.length);
                start = currentCookie.indexOf(headerId);
            }
            cookieVal = currentCookie + cookieVal;
        }
        setCookie(cookieName, cookieVal);
    }

    function handleTextAreaElementChange(textId, countId, tableId, myTextId, maxLength, remainingText, overText) {

        var textArea = document.getElementById(textId);
        var counter = document.getElementById(countId);
        var myTable = document.getElementById(tableId);
        var myText = document.getElementById(myTextId);

        if (!textArea || !counter || !myTable || !myText) return;

        var valueLength = textArea.value.length;
        if (valueLength > 0 && !(isIE || isIE5)) {
            var lines = textArea.value.match(/\n/g);
            if (lines) valueLength += lines.length;
        }
        var remaining = maxLength - valueLength;

        if (remaining < 0) {
            counter.style.backgroundColor = 'FF3333';
            counter.style.color = 'FFFFFF';
            counter.innerHTML = (-1 * remaining);
            myText.style.backgroundColor = 'FF3333';
            myText.style.color = 'FFFFFF';
            myText.innerHTML = overText;
            myTable.style.visibility = 'visible';
        } else if (remaining < 50) {
            counter.style.backgroundColor = 'FFFF66';
            counter.style.color = '000000';
            counter.innerHTML = remaining;
            myText.style.backgroundColor = 'FFFF66';
            myText.style.color = '000000';
            myText.innerHTML = remainingText;
            myTable.style.visibility = 'visible';
        } else {
            myTable.style.visibility = 'hidden';
        }
    }

/**
 *
 * Reports
 *
 */

// Used by filter lookup widgets to back fill the selected values
var filterLookupValueElem;

// Posts to load the filter lookup widget into a new window
function openFilterLookupWindow(fieldSelectName, valueElemName) {
    filterLookupValueElem = valueElemName;
    var reportForm = document.getElementById('report');
    reportForm.target = 'filter_lookup';
    var fieldSelect = document.getElementById(fieldSelectName);
    var field = fieldSelect.options[fieldSelect.selectedIndex];
    reportForm.lookup.value = field.value;
    reportForm.submit();
    reportForm.target = '';
    reportForm.lookup.value = '';
}
