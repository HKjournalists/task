/**
 * @since 2005.10
 * @author 张联华
 * @version 1.0
 * */

   //全局定义
      //原来在可用列表中的编号
      FieldOriginalId=new Array();

    //mouse
    function getEvent(evt) {
        if (isIE) return window.event;
        return evt;
    }
    function getSrcElement(evt) {
        if (isIE) return evt.srcElement;
        return evt.currentTarget;
    }

    function handleMouseDown(evt) {
        if (isIE5) return;
        clearTextSelection();
        evt = getEvent(evt);
        obj = getSrcElement(evt);
        if (!evt.shiftKey && !evt.ctrlKey && !isSelected(obj)) {
            clearSelected();
            setSelected(obj);
            if (!currentSelectedObj) return;
        }
        mousedDown = true;
    }

    function clearSelected() {
        for (var i = 0; i < selectedBucket.length; i++) {
            if (!selectedBucket[i].used || selectedBucket[i].used == false) {
                selectedBucket[i].style.backgroundColor = selectedBucket[i].originalBGColor;
            }
        }
        selectedBucket = new Array();
        currentSelectedObj = null;
    }
    function removeSelected(obj) {
        for (var i = 0; i < selectedBucket.length; i++) {
            if (selectedBucket[i].id == obj.id) {
                selectedBucket.splice(i, 1);
                obj.style.backgroundColor = obj.originalBGColor;
                defaultCursor(obj);
            }
        }
        if (currentSelectedObj == obj) {
            currentSelectedObj = null;
            if (selectedBucket.length > 0) {
                currentSelectedObj = selectedBucket[selectedBucket.length-1];
            }
        }
    }
    function setSelected(obj) {
        if (isSelected(obj)) {
            removeSelected(obj);
            return;
        }

        currentSelectedObj = obj;
        obj.originalBGColor = obj.style.backgroundColor;
        obj.style.backgroundColor = '#6699cc';
        moveCursor(obj);
        if (isIE5) {
            selectedBucket = selectedBucket.concat(currentSelectedObj);
        } else {
            selectedBucket.push(currentSelectedObj);
        }
    }
    function multiSelect(obj) {
        if (!currentSelectedObj) return;
        var tableId = getTableId(obj);

        if (getTableId(currentSelectedObj) != tableId ) {
            removeSelected(currentSelectedObj);
            setSelected(obj);
            return;
        }


        var prevSelectedObj = currentSelectedObj;
        var rowNum1 = getRowNum(currentSelectedObj);
        var rowNum2 = getRowNum(obj);
        var colNum1 = getColNum(currentSelectedObj);
        var colNum2 = getColNum(obj);
        var startRow = Math.min(rowNum1, rowNum2);
        var endRow =  Math.max(rowNum1, rowNum2);
        var startCol =  Math.min(colNum1, colNum2);
        var endCol =  Math.max(colNum1, colNum2);
        if (startRow == endRow && startCol == endCol) return;
        clearSelected();
        for (var i = startRow; i <= endRow; i++ ) {
            for (var j = startCol; j <= endCol; j++) {
                var cellId = constructId(tableId, i, j);
                var cell = document.getElementById(cellId);

                if (!cell.used && cell.innerHTML != '') {
                    setSelected(cell);
                }
            }
        }
        currentSelectedObj = prevSelectedObj;
    }

    function isSelected(obj) {
        for (var i = 0; i < selectedBucket.length; i++) {
            if (selectedBucket[i].id == obj.id) return true;
        }
        return false;
    }

    function handleMouseClick(evt) {
        clearTextSelection();
        evt = getEvent(evt);
        if (isIE5) {
            if (!currentSelectedObj || evt.ctrlKey) {
                obj = getSrcElement(evt);
                if (obj.used) return;
                if (obj.innerHTML == '') return;
                setSelected(obj);
                mousedDown = true;
            } else if (evt.shiftKey) {
                obj = getSrcElement(evt);
                if (obj.used) return;
                if (obj.innerHTML == '') return;
                multiSelect(obj);
            } else {
                handleMouseUp(evt);
            }
        } else if (evt.ctrlKey) {
            setSelected(obj);
        } else if (evt.shiftKey) {
            multiSelect(obj);
        }

    }

    function handleMouseUp(evt) {

        clearTextSelection();
        evt = getEvent(evt);

        if (!mousedDown && !evt.ctrlKey && !evt.shiftKey) {
            clearSelected();
            return;
        }
        evt = getEvent(evt);
        document.getElementById('dragDummy').style.visibility = 'hidden';
        if (currentSelectedObj) {
            if (currentHighlightedObj) {
                if (isSection(currentSelectedObj)) {
                    swapSections(evt);
                    handleDragOut(currentHighlightedObj);
                    currentHighlightedObj = null;
                    clearSelected();
                } else {

                    if (!(isInAvailableSection(currentSelectedObj) && isInAvailableSection(currentHighlightedObj))) {
                        insertCell(evt);
                    }
                    handleDragOut(currentHighlightedObj);
                    currentHighlightedObj = null;
                    clearSelected();
                }
            }
            if (evt.ctrlKey) {
                mousedDown = false;
                return;
            }
        }
        mousedDown = false;

    }
       function handleMouseMove(evt) {
        evt = getEvent(evt);
        if (currentSelectedObj && mousedDown) {
            clearTextSelection();

            var obj = getSrcElement(evt);

            var scrollX = getScrollX();
            var scrollY = getScrollY();
            var dragDummy = document.getElementById('dragDummy');
            var dragDummyValue = document.getElementById('dragDummyValue');
            dragDummy.style.visibility = 'visible';
            dragDummyValue.innerHTML = selectedBucket.length > 1 ? '多选' : isSection(currentSelectedObj) ? '页面分组' : currentSelectedObj.fName;
            dragDummy.style.left = getMouseX(evt) - currentOffsetX;
            dragDummy.style.top = getMouseY(evt) - currentOffsetY;

            var currentX = getObjX(dragDummy) - scrollX;
            if (currentX > document.body.clientWidth) {
                if (isIE) document.body.scrollLeft = document.body.scrollLeft + 10;
                //else window.scroll(10, 0);
            } else if (currentX < 0) {
                if (isIE) document.body.scrollLeft = document.body.scrollLeft - 10;
                //else window.scroll(-10, 0);
            }

            var currentY = getObjY(dragDummy) - scrollY;
            if (currentY > document.body.clientHeight - 50) {
                if (isIE) document.body.scrollTop = document.body.scrollTop + 50;
                //else window.scroll(0, 50);
            } else if (currentY < 50) {
                if (isIE) document.body.scrollTop = document.body.scrollTop - 50;
                //else window.scroll(0, -50);
            }

        }
    }

    function handleMouseOver(evt) {
        evt = getEvent(evt);
        obj = getSrcElement(evt);
        window.status = obj.style.zIndex;
        showProperties(evt);
        if (currentSelectedObj && mousedDown) {
            moveCursor(obj);
            if (isSection(currentSelectedObj)) {
                if (obj != currentHighlightedObj && isSection(obj)) {
                    if (currentHighlightedObj) handleDragOut(currentHighlightedObj);
                    currentHighlightedObj = obj;
                    var separator = document.getElementById(getSeparatorId(obj.tableId));
                    if (separator) {
                        separator.originalBGColor = separator.style.backgroundColor;
                        separator.style.backgroundColor = '000000';
                    }
                }
            } else {
                if (obj != currentHighlightedObj) {
                    if (currentHighlightedObj) handleDragOut(currentHighlightedObj);
                    currentHighlightedObj = obj;
                    if (isInAvailableSection(obj)) {
                        if (!isInAvailableSection(currentSelectedObj)) {
                            var t = getTable(getTableId(obj));
                            t.style.backgroundColor = '000000';
                        }
                    } else {
                        var separator = document.getElementById(getSeparatorId(obj.id));
                        if (separator) {
                            separator.originalBGColor = separator.style.backgroundColor;
                            separator.style.backgroundColor = '000000';
                        }
                    }
                }
            }
        }
    }
    function handleDragOut(obj) {
        if (currentSelectedObj) {
            if (isInAvailableSection(obj)) {
                var t = getTable(getTableId(obj));
                t.style.backgroundColor = 'FFFFFF';
            } else {
                var separatorId = isSection(obj) ? obj.tableId : obj.id;
                separatorId = getSeparatorId(separatorId)
                var separator = document.getElementById(separatorId);
                if (separator) {
                    separator.style.backgroundColor = separator.originalBGColor;
                }
            }
        }
    }
    function pointerCursor(obj) {
        if (!obj || !obj.style) return;
        if (obj.used) {
            if (isIE && !isIE5 && !isIE55) {
                obj.style.cursor = 'not-allowed';
            } else {
                obj.style.cursor = 'default';
            }
        } else if (isSelected(obj)) {
            moveCursor(obj);
        } else {
            if (!isIE5 && !isIE55) {
                obj.style.cursor = 'pointer';
            } else {
                obj.style.cursor = 'default';
            }
        }
    }

    function moveCursor(obj) {
        if (obj && obj.style && !isIE55 && !isIE5) {
            obj.style.cursor = 'move';
        }
    }

    function defaultCursor(obj) {
        if (obj && obj.style) {
            obj.style.cursor = 'default';
        }
    }

    function showProperties(evt) {
        obj = getSrcElement(evt);
        if (obj.innerHTML == '') return;

        pointerCursor(obj);

        var propHeader;
        var propValues;
        if (isSection(obj)) {
            obj.onmouseout = handleMouseOut;
            var sid=getTableIdFromSectionId(obj.id);//s17
            var  tableid="table"+sid.substring(1,sid.length)
            var t = document.getElementById(tableid);
            propHeader = obj.innerHTML;
            propValues = new Array(
                '要移动此页面分组，请单击此处并将它拖放到所需的新位置。');
        } else {
            var isRQ = obj.rq && obj.rq == '1';
            var isRO = obj.ro && obj.ro == '1';
            propHeader = obj.fName;
            propValues = new Array();

            if (obj.used) {
                //propValues = propValues.concat('&lt;span style=color:990000&gt;此字段已在页面布局中使用&lt;/span&gt;');
                //showMouseOver(evt, propHeader, propValues, 0);
                return;
            }

            propValues = propValues.concat('类型：&nbsp;&nbsp;' + obj.fDataLabel);

            if (isRQ || isRO) {
                propValues = propValues.concat('安全性：&nbsp;&nbsp;' + (isRQ ? '必填项' : isRO ? '只读' : '可编辑'));
            }
            if (obj.fLength) {
                propValues = propValues.concat('长度：&nbsp;&nbsp;' + obj.fLength);
            }

            if (obj.fPrecision) {
                propValues = propValues.concat('长度：&nbsp;&nbsp;' + obj.fPrecision);
            }

            if (obj.fScale) {
                propValues = propValues.concat('小数位数：&nbsp;&nbsp;' + obj.fScale);
            }

            if (isInAvailableSection(obj)) {
                propValues = propValues.concat('<br>');
                if (obj.fieldType == 'F' || obj.fieldType == 'C') {
                    propValues = propValues.concat('要将此字段添加到页面布局中，请将它拖放到字段部分。');
                } else if (obj.fieldType == 'K') {
                    propValues = propValues.concat('要将此 Web 链接添加到页面布局中，请将它拖放到 ' + getLinksSectionName('Web 链接') +' 部分。');
                } else {
                    propValues = propValues.concat('要将此相关列表添加到页面布局中，请将它拖放到相关列表部分。');
                }

            }

        }
        showMouseOver(evt, propHeader, propValues, 1000);
    }

    function handleMouseOut(evt) {
        hideMouseOver(0);
    }
    function handleLinkMouseOver(evt) {
        evt = getEvent(evt);
        obj = getSrcElement(evt);
        pointerCursor(obj);
        doNothing(evt);
    }

    function clearTextSelection(){
        if (isIE) {
            document.selection.empty();
        } else {
            window.getSelection().removeAllRanges();
        }
    }
//Sect
	//document.getElementById('afields_1r1c1') ,  field
	//'1915712',  itemId
	//'联系人所有人',  d dName
	//'联系人所有人',  f fName
	//50,l field.fLength
	//0, p fPrecision
	//0,s fScale
	//'自定义查找',typeLabel fDataLabel
	//'F',itemType fieldType
	//false,rq RequiredNess 是否必填
	//false,ro ReadonlyNess 是否只读，即不可编辑
	//'0',ad style.fontWeight = 'bold'; 是否加粗
	//'0',arq always required 总是必填
	//'0',aro always readonly 总是只读
	//'0',anrq always not required 总是不必填
	//'0' anro always not readonly 总是只读
    function setFieldAttributes(field, itemId, d, f, l, p, s, typeLabel, itemType, rq, ro, ad, arq, aro, anrq, anro,isRefresh) {
      if (field.initialized == '1') return;
        field.itemId = itemId;
        field.dName = d;
        field.fName = f;
        if (l != '0') field.fLength = l;
        if (s != '0' && p != '0') {
            field.fPrecision = p;
            field.fScale = s;
        }
        field.fDataLabel = typeLabel;
        setCellRequiredNess(field, rq);
        setCellReadonlyNess(field, ro);
        field.ad = ad;
        if (ad == '1') {
            field.style.fontWeight = 'bold';
        }
        field.arq = arq;    // always required
        field.aro = aro;    // always readonly
        field.anrq = anrq;  // always not required
        field.anro = anro;  // always not readonly
        field.fieldType = itemType;

        field.onmouseout = handleMouseOut;
        field.onmousedown = handleMouseDown;
        field.onmouseover = handleMouseOver;
        field.onclick = handleMouseClick;

        if (isRefresh==true ){
            if (FieldOriginalId[itemId]) {
                document.getElementById(field.id).originalId = FieldOriginalId[itemId];
            }
            field.style.backgroundColor = 'DAA520';
        }else{
            if (initUsedFields[itemId]) {
            	field.originalBGColor = 'DAA520';
                setCellToUsed(field);
                document.getElementById(initUsedFields[itemId]).originalId = field.id;
                //原来在可用列表中的编号
                FieldOriginalId[itemId]=field.id;
            } else {
                field.style.backgroundColor = 'DAA520';
                initUsedFields[itemId] = field.id;
            }
        }

        field.initialized = '1';
        formatField(field);

    }

    function setCellRequiredNess(f, required) {
        f.rq = required ? '1' : '0';
    }
    function setCellReadonlyNess(f, readonly) {
        f.ro = readonly ? '1' : '0';
    }
    function setCellInlinedNess(f, inlined) {
        f.il = inlined ? '1' : '0';
    }
    function formatField(field) {
        var name = field.dName;
        if (!name) name = field.fName;
        if (!name) return;
        if (field.ro == '1') {
            field.innerHTML = '<img src="../image/udfpage/readonly.gif" border="0" alt="只读" title="只读" width=15 height=15 onclick="doNothing(event);" onmousedown="doNothing(event);" align="top" onmouseover="doNothing(event);">' + '&nbsp;' + field.dName;
        } else if (field.rq == '1') {
            field.innerHTML = '<img src="../image/udfpage/required.gif" border="0" alt="必填项" title="必填项" width=15 height=15 onclick="doNothing(event);" onmousedown="doNothing(event);" align="top" onmouseover="doNothing(event);">' + '&nbsp;' + field.dName;
        } else if (field.il == '1') {
            field.innerHTML = '<img src="../image/udfpage/s.gif" border="0" width=15 height=15 onclick="doNothing(event);" onmousedown="doNothing(event);" align="top" onmouseover="doNothing(event);">' + '&nbsp;' + field.dName;
        } else {
            field.innerHTML = '<img src="../image/udfpage/s.gif" border="0" width=15 height=15 onclick="doNothing(event);" onmousedown="doNothing(event);" align="top" onmouseover="doNothing(event);">' + '&nbsp;' + field.dName;
        }
    }
    function setCellToEmpty(c) {
        c.itemId = '';
        c.innerHTML = '';
        c.originalId = '';
        c.onmousedown = '';
        c.onmouseout = '';
        c.onclick = '';
        if (isIE5) c.onclick = handleMouseClick;
        c.used = false;
        c.ro = '0';
        c.rq = '0';
        c.ad = '0';
        c.arq = '0';
        c.aro = '0';
        c.anrq = '0';
        c.anro = '0';
        c.fieldType = '';
    }
    function setCellToUsed(c) {
        c.style.backgroundColor = 'F5DEB3';
        c.style.color = 'B0B0B0';
        c.onmousedown = '';
        c.used = true;
    }
    function copyCell(to, from){
        if (from.innerHTML == '') {
            setCellToEmpty(to);
            return;
        }
        to.innerHTML = from.innerHTML;
        to.originalId = from.originalId ? from.originalId : from.id;
        to.onmousedown = handleMouseDown;
        to.onmouseout = handleMouseOut;
        to.onclick = handleMouseClick;
        to.onmouseover = handleMouseOver;
        to.used = false;
        to.dName =         from.dName;
        to.fName =         from.fName;
        to.fDataLabel =    from.fDataLabel;
        to.itemId = from.itemId;
        to.fieldType = from.fieldType;
        to.cosSpan=from.colSpan;
        if (from.fLength) to.fLength = from.fLength;
        if (from.fPrecision) to.fPrecision = from.fPrecision;
        if (from.fScale) to.fScale = from.fScale;
        if (from.ro) to.ro = from.ro;
        if (from.rq) to.rq = from.rq;
        if (from.ad) to.ad = from.ad;
        if (from.il) to.il = from.il;
        if (from.arq) to.arq = from.arq;
        if (from.aro) to.aro = from.aro;
        if (from.anrq) to.anrq = from.anrq;
        if (from.anro) to.anro = from.anro;

    }
    function insertCell(evt) {
        var tablesToReformat = new Array();
        //先判断currentHighlightedObj,即当前鼠标所在的目标区域是否是可供选择的列表范围（字段范围）
        //如果是，表示是从现有布局中删除
        //否则目标区域是当前工作区，是增加字段到布局中。
        if (isInAvailableSection(currentHighlightedObj)) {
            var deleteFieldList=new Array();
            //如果是
            for (var i = 0; i < selectedBucket.length; i++) {
                //还原initUsedFields，避免删除掉的行列在取originalId时为null
                initUsedFields[selectedBucket[i].itemId]=null;
                //恢复颜色设置
                var originalId=selectedBucket[i].originalId;
                var originalCell = document.getElementById(originalId);
                copyCell(originalCell, selectedBucket[i]);
                originalCell.style.backgroundColor = 'DAA520';
                originalCell.style.color = '000000';
                originalCell.innerHTML = originalCell.dName;
                setCellRequiredNess(originalCell, false);
                setCellReadonlyNess(originalCell, false);
                formatField(originalCell);
                //删除字段
                var aRowNo=-1;
                for (var j=0;j<FieldNormalRs.count();j++){
                  if (FieldNormalRs.getValue(j,"PROP_FIELD_NAME")==selectedBucket[i].itemId){
                    aRowNo=j;
                    break;
                  }
                }
                FieldNormalRs.deleteRow(aRowNo);
                deleteFieldList[deleteFieldList.length]=selectedBucket[i].itemId;
		var tableToReformatId = getTableId(selectedBucket[i]);
                reLoadSectionTable(tableToReformatId,"DELETE",null,deleteFieldList,null);
            }
            var numAlwaysDisplayedField = 0;
            //总是显示的字段数量
            for (var i = 0; i < selectedBucket.length; i++) {
                if (selectedBucket[i].ad && selectedBucket[i].ad == '1') {
                    numAlwaysDisplayedField++;
                    continue;
                }
                setCellToEmpty(selectedBucket[i]);
            }
            if (numAlwaysDisplayedField == 1) {
                alert('此字段可能无法从页面布局中删除。');
            } else if (numAlwaysDisplayedField > 1) {
                alert('没有删除所选的一个或多个字段，因为它们必须包括在页面布局中。');
            }
        } else {
        	//不是，当然就是工作区的字段。
        	//表示从可用列表中拖动到布局中

            var tableId = getTableId(currentHighlightedObj);
            var rowNum = getRowNum(currentHighlightedObj) - 1;
            var colNum = getColNum(currentHighlightedObj) - 1;
            var t = getTable(tableId);

            if (!t) return;

            //取SectionID
            var SectionID=tableId.split("s")[1];
            var selectedData = new Array();

            //清空该Section的所有初始化字段
            //还原initUsedFields，避免删除掉的行列在取originalId时为null
            for (var i=0;i<FieldNormalRs.count();i++){
               if (FieldNormalRs.getValue(i,"SECTION_ID")==SectionID){
                 var aTempItemId=FieldNormalRs.getValue(i,"PROP_FIELD_NAME");
                 initUsedFields[aTempItemId]=null;
               }
            }

            var isGoingToStandardSection = isInStandardSection(currentHighlightedObj);
            //计算要放置的位置的字段名称
            var toBeInsertFieldId=currentHighlightedObj.itemId;
            //是否插在某个字段的后面
            //用于拖放在空白字段上方时！
            var insertAfterFlag=false;
            //如果是空白字段，则一直追溯到前一个有效字段，并将字段放在该字段后面！
            //如果到该行的第一列仍然没有字段，则说明这是一个空的Section
            if (!toBeInsertFieldId){
              var aTempCol=colNum+1;
              var aTempRow=rowNum+1;
              var curObj=currentHighlightedObj;
              while ((!curObj||!curObj.itemId)){
                aTempCol--;
                if (aTempCol<1){
                  aTempRow--;
                  if (aTempRow<1){
                    break;
                  }
                  aTempCol=t.rows[0].cells.length;
                }
                var tempObjId="s"+SectionID+"r"+aTempRow+"c"+aTempCol;
                curObj=document.getElementById(tempObjId);
              }
              if (!curObj||!curObj.itemId){
                toBeInsertFieldId="AI_BLANK";
              }else{
              	toBeInsertFieldId=curObj.itemId;
              	insertAfterFlag=true;
              }
            }

            var foundRestrictedStandardField = 0;

            for (var j = 0; j < selectedBucket.length; j++) {
                //如果没有改变，则返回
                if (selectedBucket[j].itemId==toBeInsertFieldId){
                  return;
                }

                if (!isGoingToStandardSection) {
                    foundRestrictedStandardField++;
                    selectedBucket[j].style.backgroundColor = selectedBucket[j].originalBGColor;
                    continue;
                }
                var selData = new Object();

                copyCell(selData, selectedBucket[j]);

                if (!isInAvailableSection(selectedBucket[j])) {
                    var tableToReformatId = getTableId(selectedBucket[j]);
                    tablesToReformat[tableToReformatId] = tableToReformatId;
                    setCellToEmpty(selectedBucket[j]);
                } else {
                    setCellToUsed(selectedBucket[j]);
                }
                selData.FromTableId=getTableId(selectedBucket[j]);
                selData.Id=selectedBucket[j].id;
                selectedData = selectedData.concat(selData);
            }

            var newFieldsList=new Array();
            var moveFieldList=new Array();
            for (var j = 0; j < selectedData.length; j++) {
                var previousCell = new Object();
                copyCell(previousCell, selectedData[j]);
                //如果是从其他Section拖过来的，则不需要创建新行，只需要更新SectionId.
                //如果是在本Section中拖过来的，则不需要设置rowset.
                var aFieldId=previousCell.itemId;
		if (selectedData[j].FromTableId){
                  var aFromTableId=selectedData[j].FromTableId;
                  if (aFromTableId.indexOf("afield")>=0){
                    var aRowNo=-1;
                    //新增一行
                    //新增FieldNormalRs的一行
                    FieldNormalRs.newRow();
                    aRowNo=FieldNormalRs.getRow();

                    //只需要设置编号字段即可。
                    //其他要保存的字段是section_id和seq_id，在保存时设置。
                    //这样在保存之前可以任意拖动，只需最后确认位置即可。
                    newFieldsList[newFieldsList.length]=aFieldId;
                    FieldNormalRs.setValue(aRowNo,"PROP_FIELD_NAME",aFieldId);
                    //原来在可用列表中的编号
                    FieldOriginalId[aFieldId]=selectedData[j].Id;
                    //设置字段来源
                    var aPropSource="S";
                    if (aFieldId.length >= 11 && aFieldId.substring(0, 11)=="AI_APP_EXT_"){
                      aPropSource="U";
                    }
                    FieldNormalRs.setValue(aRowNo,"PROP_SOURCE",aPropSource);
                    //设置布局编号
                    FieldNormalRs.setValue(aRowNo,"PAGELAYOUT_ID",PAGE_LAYOUT_ID);
                    FieldNormalRs.setValue(aRowNo,"SEQ_ID","99");
                    FieldNormalRs.setValue(aRowNo,"SECTION_ID",SectionID);
                    //设定字段宽度，自动计算合适的宽度
                    var aFieldWidth=0;
                    //表格的宽度
                    var aSectionTblWidth=0;
                    for (var i=0;i<SectionNormalRs.count();i++){
                       if (SectionNormalRs.getValue(i,"SECTION_ID")==SectionID){
                         aSectionTblWidth=SectionNormalRs.getValue(i,"SECTION_WIDTH");
                         aSectionColSpan=SectionNormalRs.getValue(i,"COL_NO");
                         break;
                       }
                    }
                    var aFieldTblWidth=aSectionTblWidth;
                    aFieldWidth=eval(eval(aFieldTblWidth/aSectionColSpan)-100)+"";
                    var aZeroPos=aFieldWidth.indexOf(".");
                    if (aZeroPos>0){
                      aFieldWidth=aFieldWidth.substring(0,aZeroPos);
                    }
                    FieldNormalRs.setValue(aRowNo,"MAX_LENGTH",aFieldWidth);
                  }else{
                    //设置SectionID
                    //取移动字段的来源Section
                    var aOldSectionId=aFromTableId.split("s")[1];
                    var aRowNo=getRowNoByFieldId(aFieldId);
                    if (FieldNormalRs.getValue(aRowNo,"SECTION_ID")!=SectionID){
                      FieldNormalRs.setValue(aRowNo,"SECTION_ID",SectionID);
                      //改变SEQ_ID，以重新设置SEQ_ID。
                      FieldNormalRs.setValue(aRowNo,"SEQ_ID","99");
                    }else{
                      //在本Section中拖动
                      //99-本Section中拖动过的字段
                      //只是为了使rowset变化，没有别的用途
                      FieldNormalRs.setValue(aRowNo,"SEQ_ID","99");
                      aOldSectionId=null;
                    }
                    moveFieldList[moveFieldList.length]=aFieldId;
                  }
                }

            }
            if (foundRestrictedStandardField > 0) {
                alert('必须将字段放入字段部分。');
            }
            if (newFieldsList&&newFieldsList.length>0){
              reLoadSectionTable("s"+SectionID,"ADDNEW",toBeInsertFieldId,newFieldsList,insertAfterFlag);
            }
            if (moveFieldList&&moveFieldList.length>0){
              reLoadSectionTable("s"+SectionID,"MOVE",toBeInsertFieldId,moveFieldList,insertAfterFlag,aOldSectionId);
            }
        }

        selectedBucket = new Array();
    }


    function reLoadSectionTable(aSectionTableId,aAction,aToBeInsertField,aFieldListAry,insertAfterFlag,aOldSectionId){
      var xml=FieldNormalRs.toXmlString(false);
      if (xml==""){
        return;
      }
      var aTmpXml="<RootInfo>"+xml+"</RootInfo>";

      var SectionID=aSectionTableId.split("s")[1];
      //判断该Section是否新建的Section
      var aRowNo;
      var isNewSection="N";
      var aColSpan=0;
      for (var i=0;i<SectionNormalRs.count();i++){
         if (SectionNormalRs.getValue(i,"SECTION_ID")==SectionID){
           isNewSection="Y";
           aColSpan=SectionNormalRs.getValue(i,"COL_NO")
           break;
         }
      }
      var param="&SECTION_ID="+SectionID;
      param+="&ACTION_TYPE="+aAction;
      param+="&PAGE_LAYOUT_ID="+PAGE_LAYOUT_ID;
      var strFieldList="";
      if (aFieldListAry!=null){
        for (var i=0;i<aFieldListAry.length;i++){
          strFieldList+=aFieldListAry[i];
          if (i!=aFieldListAry.length-1){
            strFieldList+=",";
          }
        }
      }
      if (insertAfterFlag&&insertAfterFlag==true){
        param+="&INSERT_AFTER_FLAG=Y";
      }else{
        param+="&INSERT_AFTER_FLAG=N";
      }
      param+="&FIELD_LIST="+strFieldList;
      param+="&TO_BE_INST_FIELD="+aToBeInsertField;
      param+="&IS_NEW_SECTION="+isNewSection;
      param+="&NEW_SECTION_COL_SPAN="+aColSpan;

      var resu=PostInfotoServer("/business/com.ai.appframe2.udfpage.action.UserDefinePageAction?action=refreshSectionFieldTbl"+param,aTmpXml);
      document.all.item("TD_TABLE_"+SectionID).innerHTML=resu;

      if (document.all.item("FIELD_SCRIPT_"+SectionID)&&document.all.item("FIELD_SCRIPT_"+SectionID).innerHTML){
        eval(document.all.item("FIELD_SCRIPT_"+SectionID).innerHTML);
      }

      if (aAction=="MOVE"){
        //如果是从另一个Section中拖动的，则需要刷新另一个Section
        var anotherSectionId=-1;
        //MoveFieldList
        anotherSectionId=aOldSectionId;
        if (anotherSectionId!=-1&&anotherSectionId!=null&&anotherSectionId!=SectionID){
          //清空该Section的所有初始化字段
          //还原initUsedFields，避免删除掉的行列在取originalId时为null
          for (var i=0;i<FieldNormalRs.count();i++){
             if (FieldNormalRs.getValue(i,"SECTION_ID")==anotherSectionId){
               var aTempItemId=FieldNormalRs.getValue(i,"PROP_FIELD_NAME");
               initUsedFields[aTempItemId]=null;
             }
          }
          var param="&SECTION_ID="+anotherSectionId;
          aAction="REMOVE";
          param+="&ACTION_TYPE="+aAction;
          param+="&PAGE_LAYOUT_ID="+PAGE_LAYOUT_ID;
          if (insertAfterFlag&&insertAfterFlag==true){
            param+="&INSERT_AFTER_FLAG=Y";
          }else{
            param+="&INSERT_AFTER_FLAG=N";
          }
          param+="&FIELD_LIST="+strFieldList;
          param+="&TO_BE_INST_FIELD="+aToBeInsertField;
          param+="&IS_NEW_SECTION="+isNewSection;
          param+="&NEW_SECTION_COL_SPAN="+aColSpan;
          var resu=PostInfotoServer("/business/com.ai.appframe2.udfpage.action.UserDefinePageAction?action=refreshSectionFieldTbl"+param,aTmpXml);
          document.all.item("TD_TABLE_"+anotherSectionId).innerHTML=resu;
          if (document.all.item("FIELD_SCRIPT_"+anotherSectionId)&&document.all.item("FIELD_SCRIPT_"+anotherSectionId).innerHTML){
            eval(document.all.item("FIELD_SCRIPT_"+anotherSectionId).innerHTML);
          }
        }
      }
//        alert(FieldNormalRs.toXmlString());
    }

    //swap
    function swapSections(evt) {
        if (currentSelectedObj == currentHighlightedObj) return;

        currentSelectedObj.style.backgroundColor = currentSelectedObj.originalBGColor;
        handleDragOut(currentSelectedObj);
        handleDragOut(currentHighlightedObj);


        var currentTableId = currentSelectedObj.tableId;
        var highlightedTableId = currentHighlightedObj.tableId;
        var currentTable = document.getElementById(currentTableId);
        var currentDetailHeading = currentSelectedObj.detailHeading;
        var currentEditHeading = currentSelectedObj.editHeading;
        var currentCanEditLabel = currentSelectedObj.canEditLabel;
        var currentMasterLabel = currentSelectedObj.masterLabel;
        var currentSortOrder = currentSelectedObj.sortOrder;
        var currentItemId = currentSelectedObj.itemId;

        var currentBody = currentTable.cloneNode(true);
        deleteSectionRow(currentTableId);
        insertSectionRow(highlightedTableId, currentTableId, currentBody);
        // need this here for NS
        document.getElementById(currentSelectedObj.id).tableId = currentTableId;

        initSectionTable(document.getElementById(currentSelectedObj.id), currentTableId, currentSortOrder, currentDetailHeading, currentEditHeading, currentCanEditLabel, currentMasterLabel, currentItemId);
        initSection(document.getElementById(getTableIdFromSectionId(currentSelectedObj.id)));

        if (!isIE) copyCells(currentTable.rows[1].cells[0].childNodes[0], currentBody.rows[1].cells[0].childNodes[0]);
        if (!isIE) reformatTable(document.getElementById(getTableIdFromSectionId(currentSelectedObj.id)));

        clearTextSelection();
    }


    function copyCells(fromT, toT) {
        cellBuffer = new Array();
        for (var i = 0; i < fromT.rows.length; i++){
            if (i % 2 == 0) continue;
            var fromR = fromT.rows[i];
            var toR = toT.rows[i];
            for (var j = 0; j < fromR.cells.length; j++) {
                var fromC = fromR.cells[j];
                var toC = toR.cells[j];
                copyCell(toC, fromC);
            }
        }

    }
    function initSectionTable(sectionTable, tableId, sortOrder, detailHeading, editHeading, canEditLabel, masterLabel, itemId) {
        sectionTable.onmouseover = handleMouseOver;
        sectionTable.onmouseout = handleMouseOut;
        sectionTable.onmousedown = handleMouseDown;
        sectionTable.onclick = handleMouseClick;
        sectionTable.tableId = tableId;
        sectionTable.sortOrder = sortOrder;
        sectionTable.detailHeading = detailHeading;
        sectionTable.editHeading = editHeading;
        sectionTable.canEditLabel = canEditLabel;
        sectionTable.masterLabel = masterLabel;
        sectionTable.itemId = itemId;
    }
    function initSection(t) {
        for (var i = 0; i < t.rows.length; i++) {
            var row = t.rows[i];
            if (!row || i%2 == 0) continue;
            for (var j = 0; j < row.cells.length; j++) {
                var cell = row.cells[j];
                if (cell.innerHTML != '') {
                    cell.onmousedown = handleMouseDown;
                    cell.onclick = handleMouseClick;
                    cell.onmouseover = handleMouseOver;
                    cell.onmouseout = handleMouseOut;
                    cell.used = false;
                } else {
                    cell.onmousedown = '';
                    cell.onclick = handleMouseClick;
                    cell.onmouseover = handleMouseOver;
                    cell.onmouseout = handleMouseOut;
                    cell.used = false;
                }
            }

        }
    }


    function deleteSection(sectionId) {
        var t = getTable(getTableIdFromSectionId(sectionId));
        if (t.rows.length > 2) {
            if (!window.confirm('删除此页面分组会将其所有字段移回“可用字段”。' + '\n\n' + '是否确定？')) {
                return;
            }

        }
        var hasAlwaysDisplayedField = false;
        for (var i = 0; i < t.rows.length - 2 && !hasAlwaysDisplayedField; i++) {
            if (i % 2 == 0) continue;
            var row = t.rows[i];
            for (var j = 0; j < row.cells.length && !hasAlwaysDisplayedField; j++) {
                var cell = row.cells[j];
                if (cell.ad && cell.ad == '1') {
                    hasAlwaysDisplayedField = true;
                }
            }
        }
        if (hasAlwaysDisplayedField) {
            alert('不能删除此页面分组，因为至少有一个字段不能从页面布局中删除。');
            return;
        }

        var sectionHeader = document.getElementById(getSectionHeaderId(t.id));
        if (sectionHeader.canEditLabel == '0') {
            var okayToDelete = confirm(
                '确认删除分组？');
            if (!okayToDelete) return;
        }

        for (var i = t.rows.length-1; i >=0 ; i--) {
            if (i % 2 == 0) continue;
            var row = t.rows[i];
            for (var j = row.cells.length-1; j >=0; j--) {
                var cell = row.cells[j];
                //取SectionID
                var aSectionId=sectionId.split("sec_")[1];
                var aLabelId=aSectionId+"r"+eval(eval(i+1)/2)+"c"+eval(j+1);
                var aCellObj=document.getElementById(aLabelId);
                if (aCellObj&&aCellObj.originalId) {
                    var originalCell = document.getElementById(aCellObj.originalId);
                    if (originalCell) {
                        copyCell(originalCell, aCellObj);
                        //恢复可用字段列表中字的背景颜色
                        originalCell.style.backgroundColor = originalCell.originalBGColor;
                        //originalCell.style.backgroundColor = 'DAA520';
                        //恢复可用字段列表中字的颜色
                        originalCell.style.color = '000000';
                        setCellRequiredNess(originalCell, false);
                        setCellReadonlyNess(originalCell, false);
                        formatField(originalCell);
                        //删除该字段
                        var aRowNo=-1;
                        for (var k=0;j<FieldNormalRs.count();k++){
                          if (FieldNormalRs.getValue(k,"PROP_FIELD_NAME")==aCellObj.itemId){
                            aRowNo=k;
                            break;
                          }
                        }
                        FieldNormalRs.deleteRow(aRowNo);
                    }
                }
            }

        }
        deleteSectionRow(document.getElementById(sectionId).tableId);
        //删除RowSet
      var aRowNo;
      for (var i=0;i<SectionNormalRs.count();i++){
         if (SectionNormalRs.getValue(i,"SECTION_ID")==sectionId.substring(5,sectionId.length)){
           aRowNo=i;
           break;
         }
      }
      SectionNormalRs.deleteRow(aRowNo);
    }
    function deleteSectionRow(tableId) {
        var mainTable = document.getElementById('mainLayoutTable');
        var rpId =  getSeparatorId(tableId);
        var rowNum = -1;
        for (var i = 0; rowNum < 0 && i < mainTable.rows.length; i++) {
            var row = mainTable.rows[i];
            for (var j = 0; j < row.cells.length; j++) {
                var cell = row.cells[j];
                if (cell.id == rpId) {
                    rowNum = i;
                }
            }
        }
        mainTable.deleteRow(rowNum);
        mainTable.deleteRow(rowNum);
        mainTable.deleteRow(rowNum);
    }
    function insertSection(sectionText, c, sortOrder, detailHeading, editHeading) {
        if (sectionText == '') {
            alert('必须输入页面分组名称！');
            return;
        }
        var numColumns = parseInt(c);
        maxSectionTable++;
        maxSection++;
        var sectionName = "s" + maxSection;
        var tableName = "table" + maxSectionTable;
        var newSection = '';
        newSection += '<table cellspacing=1 cellpadding=2 style="background-color:000000" width="400" id="' + tableName + '">';
        newSection +=   '<tr style="background-color:#FFCC00"><td>';
        newSection +=       '<table border="0" cellspacing="0" cellpadding="0" width="100%">';
        newSection +=           '<tr valign=bottom ><td style="color:#000000" id="' + getSectionHeaderId(sectionName) + '"  align="left" width="99%">' + sectionText + '</td>';
        newSection +=               '<td align=right nowrap style="font-size:7pt;color:#000000">';
        newSection +=                   '<a onmouseover="handleLinkMouseOver(event);" onmousedown="doNothing(event);" onclick="openSectionEdit(\'' +  getSectionHeaderId(sectionName) + '\', event);">';
        newSection +=                       '编辑';
        newSection +=                   '</a>';
        newSection +=                   ' | ';
        newSection +=                   '<a onmouseover="handleLinkMouseOver(event);" onmousedown="doNothing(event);" onclick="deleteSection(\'' + getSectionHeaderId(sectionName) + '\');">';
        newSection +=                       '删除';
        newSection +=                   ' </a>';
        newSection +=               ' </td></tr>';
        newSection +=       '</table></td>';
        newSection +=   '</tr>';
        newSection +=   '<tr style="background-color:FFFFFF" height=15>';
        newSection +=       '<td>';
        newSection +=           '<table id="' + sectionName + '" width="100%" cellspacing=2 bgcolor="FFFFFF">';
        newSection +=               '<tr height=2>';
        for (var i = 0; i < numColumns; i++) {
            newSection +=               '<td id="' + getSeparatorId(constructId(sectionName, 1, i+1)) + '" width="200"></td>';
        }
        newSection +=               '</tr>';
        newSection +=               '<tr height=10>';
        for (var i = 0; i < numColumns; i++) {
            newSection +=               '<td id="' + constructId(sectionName, 1, i+1) + '"></td>';
        }
        newSection +=               '</tr>';
        newSection +=           '</table>';
        newSection +=       '</td>';
        newSection +=   '</tr>';
        newSection += '</table>';

        insertSectionRow('table0', tableName, newSection);
        initSectionTable(document.getElementById(getSectionHeaderId(sectionName)), tableName, sortOrder, detailHeading, editHeading, '1', sectionText, '');
        initSection(document.getElementById(sectionName));
        // NN does not suppport focus on just any elements
        if (isIE) document.getElementById(sectionName).focus();
    }
    function insertSectionRow(tableId, newTableId, newSection) {
        var mainTable = document.getElementById('mainLayoutTable');
        var rpId =  getSeparatorId(tableId);
        var rowNum = -1;
        for (var i = 0; rowNum < 0 && i < mainTable.rows.length; i++) {
            var row = mainTable.rows[i];
            for (var j = 0; j < row.cells.length; j++) {
                var cell = row.cells[j];
                if (cell.id == rpId) {
                    rowNum = i;
                }
            }
        }
        if (rowNum < 0) {
//          if (mainTable.rows.length - 2>0){
//            rowNum = mainTable.rows.length - 2;
//          }else{
            rowNum=0;
//          }
        }

        var newRow = mainTable.insertRow(rowNum);
        var newCell = newRow.insertCell(0);
        newCell.height = 5;
        newCell.id = getSeparatorId(newTableId);

        newRow = mainTable.insertRow(rowNum+1);
        newCell = newRow.insertCell(0);
        if (!newSection.nodeType) {
            newCell.innerHTML = newSection;
        } else {
            newCell.insertBefore(newSection, null);
        }
        newRow = mainTable.insertRow(rowNum+2);
        newCell = newRow.insertCell(0);
        newCell.height = 10;
    }

    //新建组成页面分组
    function newSection(){
      //弹出对话框，设置Section的标题、每行的列数。
      retFile=window.showModalDialog("SectionSetUp.jsp",window,"scroll:no;resizable:no;status:no;dialogHeight:200px;dialogWidth:250px");
      if (retFile==null){
        return;
      }
      var aTitle=retFile.title;
      var aCols=retFile.cols;
      var aIsDisp=retFile.isDisp;
      var aSecWidth=retFile.secWidth;
      //标题是否重复，如果标题重复，则不行。
      if (isSectionTitleUsed(aTitle)==true){
        alert("标题重复！请重新设置");
        return;
      }
      var aSectionId=PostInfo("/business/com.ai.appframe2.udfpage.action.UserDefinePageAction?action=getNewSectionId","").getValueByName("SECTION_ID");
      var tableName="table"+aSectionId;
      var param="&TABLE_NAME="+aTitle;
      param+="&COL_NUM="+aCols;
      param+="&SECTION_ID="+aSectionId;
      param+="&IS_DISP_TITLE="+aIsDisp;
      param+="&SECTION_WIDTH="+aSecWidth;
      var r=PostInfotoServer("/business/com.ai.appframe2.udfpage.action.UserDefinePageAction?action=getNewSection"+param,"");
      var aHtml=r;
      insertSectionRow('table0', tableName, aHtml);

      var sortOrder='h';
      var detailHeading="1";
      var editHeading="1";
      var sectionText=tableName;
      var sectionName="s"+aSectionId;
      initSectionTable(document.getElementById(getSectionHeaderId(sectionName)), tableName, sortOrder, detailHeading, editHeading, '1', sectionText, '');
      initSection(document.getElementById(sectionName));
      // NN does not suppport focus on just any elements
      if (isIE) document.getElementById(sectionName).focus();
      //todo 执行相关脚本!
      var aStartStr="<div id='DivSecTable' style='display:none'>";
      var aEndStr="</div>";
      var aStartPos=aHtml.indexOf(aStartStr)+aStartStr.length;
      var aEndPos=aHtml.indexOf(aEndStr);
      var ajs=aHtml.substring(aStartPos,aEndPos);
      eval(ajs);
      //设置SectionRs的值
      var aRowNo=SectionNormalRs.getRow();
      SectionNormalRs.setValue(aRowNo,"TITLE",aTitle);
      SectionNormalRs.setValue(aRowNo,"COL_NO",aCols);
      SectionNormalRs.setValue(aRowNo,"IS_DISP_TITLE",aIsDisp);
      SectionNormalRs.setValue(aRowNo,"SECTION_WIDTH",aSecWidth);
      SectionNormalRs.setValue(aRowNo,"PAGELAYOUT_ID",PAGE_LAYOUT_ID);
    }

    function editSection(sectionId){
        var s_sectionId = 's' + sectionId;
        var sectionTableId = getSectionHeaderId(s_sectionId);
        var sectionTable = document.getElementById(sectionTableId);
        var sectionName = escapeXML(sectionTable.innerHTML);
        var aRowNo=null;
        for (var i=0;i<SectionNormalRs.count();i++){
           if (SectionNormalRs.getValue(i,"SECTION_ID")==sectionId){
             aRowNo=i;
             break;
           }
        }
        var obj=new Object();
        obj.title=sectionName;
        obj.cols=SectionNormalRs.getValue(aRowNo,"COL_NO");
        obj.isDisp=SectionNormalRs.getValue(aRowNo,"IS_DISP_TITLE");
        obj.secWidth=SectionNormalRs.getValue(aRowNo,"SECTION_WIDTH");
	obj.isEdit=true;
        retFile=window.showModalDialog("SectionSetUp.jsp",obj,"scroll:no;resizable:no;status:no;dialogHeight:200px;dialogWidth:250px");
        if (retFile==null){
          return;
        }
        //更新表格内容
      var aTitle=retFile.title;
      var aIsDisp=retFile.isDisp;
      var aSecWidth=retFile.secWidth;
      //标题是否重复，如果标题重复，则不行。
      if (aTitle!=sectionName){
        if (isSectionTitleUsed(aTitle)==true){
          alert("标题重复！请重新设置");
          return;
        }
        sectionTable.innerHTML=aTitle;
        SectionNormalRs.setValue(aRowNo,"TITLE",aTitle);
      }
      if (aSecWidth!=obj.secWidth){
        SectionNormalRs.setValue(aRowNo,"SECTION_WIDTH",aSecWidth);
        //设置Section表格的宽度
        var s_sectionId = 'table' + sectionId;
        var sectionTable = getTable(s_sectionId);
        aSecWidth=aSecWidth*0.7;
        sectionTable.width=aSecWidth;
      }

      if (aIsDisp!=obj.isDisp){
        SectionNormalRs.setValue(aRowNo,"IS_DISP_TITLE",aIsDisp);
      }


    }

    function FieldEdit(evt) {
        if (selectedBucket.length != 1) {
            alert('请在页面布局页面分组选择且只能选择一个字段。');
            return;
        }
        var hasAtLeastOneField = false;

        f = selectedBucket[0];
        if (isInAvailableSection(f)) {
            alert('此功能仅可用于页面布局页面分组内的字段。');
            return;
        }
        if (isInStandardSection(f)) {
            hasAtLeastOneField = true;
        }

        if (!hasAtLeastOneField) {
            alert('此功能仅用于字段。请选择一个或多个字段。');
            return;
        }
        evt = getEvent(evt);
        setLastMousePosition(evt);
 	 //定位该字段的rowNo
        var aRowNo=-1;
        for (var j=0;j<FieldNormalRs.count();j++){
          if (FieldNormalRs.getValue(j,"PROP_FIELD_NAME")==selectedBucket[0].itemId){
            aRowNo=j;
            break;
          }
        }
        //取出原来的ColSpan
        var aOldColSpan=FieldNormalRs.getValue(aRowNo,"COL_SPAN");

        if (aOldColSpan==null||aOldColSpan==0){
          aOldColSpan=1;
        }

        var aOldMaxLength=0;
        var aOldDecimalLength=0;
        //取出原来的宽度
        aOldMaxLength=FieldNormalRs.getValue(aRowNo,"MAX_LENGTH");
        aOldDecimalLength=FieldNormalRs.getValue(aRowNo,"DECIMAL_LENGTH");
        //弹出设置窗口
        var obj=new Object();
        obj.oldColSpan=aOldColSpan;
        obj.oldMaxLength=aOldMaxLength;
        obj.oldDecimalLength=aOldDecimalLength;

      	retFile=window.showModalDialog("FieldPropSetUp.jsp",obj,"scroll:no;resizable:no;status:no;dialogHeight:300px;dialogWidth:400px");
        //比较返回值是否有效和是否不同于当前的colSpan
        if (retFile==null){
          return;
        }
        //有效设置，改变rowSet的值
        var aNewMaxLength=retFile.maxLength;
        if (aNewMaxLength!=aOldMaxLength){
          FieldNormalRs.setValue(aRowNo,"MAX_LENGTH",aNewMaxLength);
          //刷新页面该字段的长度
          var aLabelWidth = 100;
          var aChild = eval(aNewMaxLength) + eval(aLabelWidth);
          var aWidth=eval(aChild * 0.7)+"";
          var aZeroPos=aWidth.indexOf(".");
          if (aZeroPos>0){
            aWidth=aWidth.substring(0,aZeroPos);
          }
          selectedBucket[0].style.width=aWidth;
          //obj.fLength
          selectedBucket[0].fLength=aNewMaxLength;
        }
        var aNewDecimalLength=retFile.decimalLength;
        if (aNewDecimalLength!=aOldDecimalLength){
          FieldNormalRs.setValue(aRowNo,"DECIMAL_LENGTH",aNewDecimalLength);
          selectedBucket[0].fScale=aNewDecimalLength;
        }

        var aNewColSpan=retFile.colSpan;
        if (aNewColSpan!=aOldColSpan){
          FieldNormalRs.setValue(aRowNo,"COL_SPAN",aNewColSpan);
          //刷新布局表现
          var tableToReformatId = getTableId(selectedBucket[0]);
          var tobeChangeColSpanFieldList=new Array();
          tobeChangeColSpanFieldList[0]=selectedBucket[0].itemId;
          reLoadSectionTable(tableToReformatId,"CHANGE_COLSPAN",null,tobeChangeColSpanFieldList,null,null);
        }

    }
    //section
     function isSection(obj) {
        return obj.id.indexOf('sec_') > -1;
    }
    function getTableIdFromSectionId(sectionId) {
        return sectionId.substring(sectionId.indexOf('sec_')+4, sectionId.length);
    }
    function getSectionIndex(tableId) {
        return tableId.substring(tableId.indexOf('table') + 5, tableId.length);
    }
    function getTable(tableName) {
        return document.getElementById(tableName);
    }
    function getTableBody(tableName) {
        return document.getElementById(tableName).tBodies[0];
    }

    //当前目标是否在可供拖放的列表中，即右边的可用字段列表
    //字段的ID编号是以afields_开头的
    function isInAvailableSection(obj) {
        return getTableId(obj).indexOf('a') > -1;
    }

    function isStandardSection(sectionHeaderId) {
        var sectionId = getTableIdFromSectionId(sectionHeaderId);
        return sectionId.indexOf('s') == 0;
    }
    function isInStandardSection(obj) {
        return getTableId(obj).indexOf('s') > -1;
    }
    function isInListsSection(obj) {
        return getTableId(obj).indexOf('l') > -1;
    }
    function isInLinksSection(obj) {
        return getTableId(obj).indexOf('k') > -1;
    }
    function getTableId(obj) {
        return obj.id.substring(0, obj.id.indexOf('r'));
    }
    function getDivIdFromTableId(tableId) {
        return 'div_'+tableId;
    }
    function getRowNum(obj) {
        return parseInt(obj.id.substring(obj.id.indexOf('r')+1, obj.id.indexOf('c')));
    }
    function getColNum(obj) {
        return parseInt(obj.id.substring(obj.id.indexOf('c')+1, obj.id.length));
    }
    function constructId(tableId, rowNum, colNum) {
        return tableId + 'r' + rowNum + 'c' + colNum;
    }
    function getSeparatorId(baseId) {
        return 'rp_' + baseId;
    }
    function getSectionHeaderId(baseId) {
        return 'sec_' + baseId;
    }

    function addRow(tableName) {
        var columns = getTable(tableName).rows[0].cells.length;
        addRowWithColumn(tableName, columns);
    }

    function addRowWithColumn(tableName, columns) {
        var tr;
        var td;
        var columnWidth = 400 / columns;
        var tableBody = getTableBody(tableName);
        var length = tableBody.rows.length;
        var rowNum = (length/2) + 1;
        tr = tableBody.insertRow(tableBody.rows.length);
        tr.setAttribute("height", "2");

        for (var i = 0; i < columns; i++) {
            td = tr.insertCell(tr.cells.length);
            td.setAttribute("id", getSeparatorId(constructId(tableName, rowNum, i+1)));
            td.setAttribute("width", columnWidth);
        }

        tr = tableBody.insertRow(tableBody.rows.length);
        tr.setAttribute("height", "10");

        for (var i = 0; i < columns; i++) {
            td = tr.insertCell(tr.cells.length);
            td.setAttribute("id", constructId(tableName, rowNum, i+1));
            td.onmouseover = handleMouseOver;
            td.onclick = handleMouseClick;
        }

    }
    function delRow(tableName) {
        var tableBody = getTableBody(tableName);
        if (tableBody.childNodes.length > 0) {
            var lastRow = tableBody.childNodes[tableBody.childNodes.length-1];
            getTableBody(tableName).removeChild(lastRow);
        }
    }

    // deprecated
    function sectionHandleMouseOver(evt) {
        function getIECurrentTarget(evt, functionName) {
            var eventHandler = eval('evt.srcElement.on'+evt.type);
            if (eventHandler && eventHandler.toString().indexOf(functionName) > -1) {
                return evt.srcElement;
            }
            return null;
        }
        evt = getEvent(evt);
        obj = isIE ? getIECurrentTarget(evt, 'sectionHandleMouseOver') : getSrcElement(evt);
    }
    function reformatTable(t) {
        var isInListsSection = t.id && t.id.indexOf('l') > -1;
        for (var i = 0; i < t.rows.length; i++) {
            var row = t.rows[i];
            if (!row || i%2 == 0) continue;
            for (var j = 0; j < row.cells.length; j++) {
                var cell = row.cells[j];
                if (cell.innerHTML != '' && i > 2) {
                    var previousRow = t.rows[i-2];
                    var previousCell = previousRow.cells[j];
                    var done = false;
                    var k = 1;
                    while(!done && previousCell.innerHTML == '') {
                        copyCell(previousCell, cell);
                        setCellToEmpty(cell);
                        cell = previousCell;
                        k++;
                        if (i > (2*k)) {
                            previousCell = t.rows[i-(2*k)].cells[j];
                        } else {
                            done = true;
                        }

                    }
                }
            }

        }
        var foundOneEmptyRow = false;
        for (var i = 0; i < t.rows.length; i++) {
            var row = t.rows[i];
            if (!row || i%2 == 0) continue;
            var allCellsEmpty = true;
            for (var j = 0; j < row.cells.length; j++) {
                var cell = row.cells[j];

                if (cell.innerHTML != '') {
                    allCellsEmpty = false;
                    cell.style.backgroundColor = 'CCCCCC';
                    cell.style.color = '000000';
                    if (cell.ad == '1') {
                        cell.style.fontWeight = 'bold';
                    } else {
                        cell.style.fontWeight = 'normal';
                    }
                    if (cell.arq == '1') {
                        cell.rq = true;
                    }
                    if (cell.aro == '1') {
                        cell.ro = true;
                    }
                    if (cell.anrq == '1') {
                        cell.rq = false;
                    }
                    if (cell.anro == '1') {
                        cell.ro = false;
                    }
                    formatField(cell);
                } else {
                    setCellToEmpty(cell);
                    cell.style.backgroundColor = 'FFFFFF';
                    cell.style.cursor = 'default';
                }
                if (cell.fieldType == 'K' && isInListsSection) {
                    setCellInlinedNess(cell, true);
                    formatField(cell);
                }

            }
            if (allCellsEmpty) {
                if (foundOneEmptyRow) {
                    t.deleteRow(i-1);
                    t.deleteRow(i-1);
                    i = i - 2;
                } else {
                    foundOneEmptyRow = true;
                    row.cells[0].firstemptyrow = '1';
                }
            }
        }
        if (!foundOneEmptyRow) addRow(t.id);
    }
    function toggleColumns(sectionId) {
        var t = document.getElementById(getTableIdFromSectionId(sectionId));
        if (t.rows[0].cells.length > 1) {
            makeSingleColumn(t);
        } else {
            makeDoubleColumn(t);
        }
        reformatTable(t);
    }
    function cloneTableCells(t, sortOrder) {
        var originalTable = t.cloneNode(true);
        if (originalTable.rows.length == 0) return new Array();

        var cells = new Array(originalTable.rows.length * originalTable.rows[0].cells.length);
        var currentCellIndex = 0;
        if (sortOrder && sortOrder == 'h') {
            for (var i = 0; i < originalTable.rows.length; i++) {
                var row = originalTable.rows[i];
                var oRow = t.rows[i];
                for (var j = 0; j < row.cells.length; j++) {
                    var cell = row.cells[j];
                    var oCell = oRow.cells[j];
                    copyCell(cell, oCell);
                    cells[currentCellIndex++] = cell;
                }

            }
        } else {
            for (var i = 0; i < originalTable.rows.length; i++) {
                var row = originalTable.rows[i];
                var oRow = t.rows[i];
                for (var j = 0; j < row.cells.length; j++) {
                    currentCellIndex = (j * originalTable.rows.length) + i;
                    var cell = row.cells[j];
                    var oCell = oRow.cells[j];
                    copyCell(cell, oCell);
                    cells[currentCellIndex] = cell;
                }

            }
        }
        return cells;

    }
    function makeSingleColumn(t) {
        var cells = cloneTableCells(t, document.getElementById(getSectionHeaderId(t.id)).sortOrder);

        while (t.rows.length > 0) {
            t.deleteRow(0);
        }
        var row;
        var cell;
        var rowNum = 1;

        for (var i = 0; i < cells.length; i++ ){
            if (cells[i].innerHTML == '') continue;
            row = t.insertRow(t.rows.length);
            row.height = 2;
            cell = row.insertCell(0);
            cell.id = getSeparatorId(constructId(t.id, rowNum, 1));

            row = t.insertRow(t.rows.length);
            row.height = 10;
            cell = row.insertCell(0);
            copyCell(cell, cells[i]);
            cell.style.backgroundColor = cells[i].style.backgroundColor;
            cell.id = constructId(t.id, rowNum, 1);

            rowNum++;
        }
        if (t.rows.length == 0) {
            addRowWithColumn(t.id, 1);
        } else {
            addRow(t.id);
        }
    }
    function makeDoubleColumn(t) {
        var cells = cloneTableCells(t, document.getElementById(getSectionHeaderId(t.id)).sortOrder);

        while (t.rows.length > 0) {
            t.deleteRow(0);
        }
        var row1;
        var row2;
        var cell;
        var rowNum = 1;

        var isFirstCell = true;
        for (var i = 0; i < cells.length; i++ ){
            if (cells[i].innerHTML == '') continue;

            if (isFirstCell) {
                row1 = t.insertRow(t.rows.length);
                row1.height = 2;
                cell = row1.insertCell(0);
                cell.width = 200;
                cell.id = getSeparatorId(constructId(t.id, rowNum, 1));
                cell = row1.insertCell(1);
                cell.width = 200;
                cell.id = getSeparatorId(constructId(t.id, rowNum, 2));
            }

            if (isFirstCell) {
                row2 = t.insertRow(t.rows.length);
                row2.height = 10;
                cell = row2.insertCell(0);
                copyCell(cell, cells[i]);
                cell.style.backgroundColor = cells[i].style.backgroundColor;
                cell.id = constructId(t.id, rowNum, 1);
                cell = row2.insertCell(1);
                cell.id = constructId(t.id, rowNum, 2);
            } else {
                cell = row2.cells[1];
                copyCell(cell, cells[i]);
                cell.style.backgroundColor = cells[i].style.backgroundColor;
            }
            if (isFirstCell) {
                rowNum++;
            }
            isFirstCell = !isFirstCell;
        }
        if (!isFirstCell) {
            cell = t.rows[t.rows.length-1].cells[1];
            cell.onmousedown = handleMouseDown;
            cell.onmouseout = handleMouseOut;
            cell.onclick = handleMouseClick;
            cell.onmouseover = handleMouseOver;
            cell.used = false;
        }
        if (t.rows.length == 0) {
            addRowWithColumn(t.id, 2);
        } else {
            addRow(t.id);
        }
    }


    function swapDivs(div1, div2) {
        if (currentDisplayedDiv) {
            currentDisplayedDiv.style.display = 'none';
        }
        if (div1 != div2) {
            var d1 = document.getElementById(div1);
            d1.style.display = 'none';
        }
        var d2 = document.getElementById(div2);
        d2.style.display = 'block';
        d2.style.zIndex = 0;
        currentDisplayedDiv = d2;
    }
    function swapAvailableType(sel) {
        if (currentDisplayedDiv) {
            currentDisplayedDiv.style.display = 'none';
        }
        var divId = sel.options[sel.selectedIndex].value;
        var firstDiv = document.getElementById(divId);
        if (firstDiv) {
            firstDiv.style.display = 'block';
            currentDisplayedDiv = firstDiv;
        }

    }


    function scrollAvailableSection(){
        var doTableHeightScrolling = isIE || true;
        if (!cru) cru = (!doTableHeightScrolling) ? document.getElementById('availableSectionWrapper') : document.getElementById('scrollBuffer');
        if (!cru) return;



        if(!availableSectionPosInited) {
            availableSectionInitPosX = getObjX(cru)
            availableSectionInitPosY = getObjY(cru)
            availableSectionPosInited = true
            cru.style.zIndex = 0;
            return
        }

        //don't scroll it till it goes offscreen
        if(availableSectionInitPosY+5 < (window.pageYOffset ? window.pageYOffset : document.body.scrollTop)){
            if (doTableHeightScrolling) {
                cru.height = (window.pageYOffset ? window.pageYOffset : document.body.scrollTop) - availableSectionInitPosY + 5;
            } else {
                cru.style.position='absolute'
                cru.style.left=availableSectionInitPosX
                cru.style.top= (window.pageYOffset ? window.pageYOffset : document.body.scrollTop) + 5
                cru.style.zIndex = 0;
            }
        } else if(cru.style.position=='absolute' || !isIE){
            if (doTableHeightScrolling) {
                cru.height = 0;
            } else {
                cru.style.left=0;
                cru.style.top=0;
                cru.style.zIndex = 0;
                cru.style.position='static'
            }
        }
    }

    function doNothing(evt) {
        evt = getEvent(evt);
        evt.cancelBubble = true;
    }


    document.body.onresizeend = scrollAvailableSection;
    document.body.onscroll = scrollAvailableSection;
    if (!isIE) setInterval("doScroll()",200);
    var lastPageYOffset = 0;
    function doScroll() {
        if (window.pageYOffset != lastPageYOffset) {
            scrollAvailableSection();
            lastPageYOffset = window.pageYOffset;
        }
    }

    function handleCheckBoxDependencies(checkBoxElement) {
        var autoAssign = document.getElementById('autoAssign');
        var autoAssignOn = document.getElementById('autoAssignOn');
        var autoNotify = document.getElementById('autoNotify');
        var autoNotifyOn = document.getElementById('autoNotifyOn');
        if (autoAssign == checkBoxElement) {
            if (!autoAssign.checked) {
                autoAssignOn.checked = false;
            }
        } else if (autoAssignOn == checkBoxElement) {
            if (autoAssignOn.checked) {
                autoAssign.checked = true;
            }
        } else if (autoNotify == checkBoxElement) {
            if (!autoNotify.checked) {
                autoNotifyOn.checked = false;
            }
        } else if (autoNotifyOn == checkBoxElement) {
            if (autoNotifyOn.checked) {
                autoNotify.checked = true;
            }
        }

    }
 //properties


	function showMouseOver(evt, header, v, timeout) {

		var properties = document.getElementById('properties');
        var positionX = getMouseX(evt) + 10;
        var scrollX = getScrollX();
        if ((positionX + properties.offsetWidth) > (document.body.clientWidth + scrollX)) {
            positionX = positionX - ((positionX + properties.offsetWidth) - document.body.clientWidth) + scrollX;

        }
        var positionY = getMouseY(evt) + 20;
        var scrollY = getScrollY();
        if ((positionY + properties.offsetHeight) > (document.body.clientHeight + scrollY)) {
            positionY = positionY - (40 + properties.offsetHeight);

        }
		properties.style.left = positionX;
		properties.style.top = positionY;
		properties.style.zIndex = 100;

		var propName = document.getElementById('propHeader');
		propName.innerHTML = header;

		var i = 0;
		for (; i < v.length && i < maxValues;  i++) {
			document.getElementById('propDiv'+i).style.display = 'block';
			document.getElementById('propText'+i).innerHTML = v[i];
		}

		for (; i < maxValues; i++) {
			var emptyRow = document.getElementById('propDiv'+i);
			if (emptyRow) {
				emptyRow.style.display = 'none';
			}
		}

		displayProperties = true;
		setTimeout(makePropertiesVisible, timeout);
	}

	function hideMouseOver(timeout) {
		displayProperties = false;
		setTimeout(makePropertiesHidden, timeout);
	}

	function setMouseOverWidth(w) {
		document.getElementById('properties').width = w;
	}
    function makePropertiesVisible() {
        if (displayProperties) {
            var properties = document.getElementById('properties');
            properties.style.visibility = 'visible';
        }
    }
    function makePropertiesHidden() {
        var properties = document.getElementById('properties');
        properties.style.visibility = 'hidden';
    }
	//Xml

	function handleUnload() {
		if (openedWindow) {
			openedWindow.close();
		}
	}

    function previewDetail() {
        openedWindow = window.open(
            '/setup/layout/preview.jsp?layoutId=00h20000000kDsj',
            'preview',
            'width=700,height=500,'+
                'location=no,dependent=no,resizable=yes,'+
                'toolbar=no,status=no,directories=no,menubar=no,'+
                'scrollbars=1',
            false);
    }
    function previewEdit() {
        openedWindow = window.open(
            '/setup/layout/preview.jsp?type=Opportunity',
            'preview',
            'width=700,height=500,'+
                'location=no,dependent=no,resizable=yes,'+
                'toolbar=no,status=no,directories=no,menubar=no,'+
                'scrollbars=1',
            false);
    }
    function saveMe() {
        var nameElement = document.getElementById('name');
        if (nameElement) {
            var layoutName = nameElement.value;
            layoutName = layoutName.replace(/\s/g, '');
            if (layoutName.length == 0) {
                alert('必须输入一个名称');
                return;
            }
        }
        toXML();

	if (FieldNormalRs.toXmlString()==""&&SectionNormalRs.toXmlString()==""){
          alert("数据未改变！");
          return;
        }
    	var list = new Array();
        list[list.length]=SectionNormalRs;
    	list[list.length]=FieldNormalRs;
        var resu=saveRowSet('/business/com.ai.appframe2.udfpage.action.UserPageDesignDataAction?action=saveUserPageDesignData',list);
 	r=resu.getValueByName("RESU");
        if (r!=null){
          var ary=r.split(",");
          alert(ary[1]);
          if (ary[0]=="Y"){
            location.reload();
          }
        }else{
          alert("保存失败！原因未知。");
        }
//        alert(FieldNormalRs.toXmlString());
//        alert(SectionNormalRs.toXmlString());
    }
    function sectionToXML(tableId) {
        var tId = getSectionIndex(tableId);
        var sectionId = 's' + tId;
        var sectionTableId = getSectionHeaderId(sectionId);
        var sectionTable = document.getElementById(sectionTableId);

        var sectionName = escapeXML(sectionTable.innerHTML);
        var sortOrder = sectionTable.sortOrder;
        var detailHeading = sectionTable.detailHeading;
        var editHeading = sectionTable.editHeading;
        var fieldsTable = document.getElementById(sectionId);

        if (fieldsTable) {
            for (var j = 0; j < fieldsTable.rows.length; j++) {
                if (j%2==0) continue;
                var row = fieldsTable.rows[j];
                var aRowNo=j;
                for (var k = 0; k < row.cells.length; k++) {
                    var afieldId=sectionId+"r"+eval(eval(j+1)/2)+"c"+eval(k+1);
                    var afield=document.getElementById(afieldId);
                    if (afield && afield.itemId && afield.itemId != '') {
                        var afieldName=afield.fName;
                        var afieldItemType=afield.fieldType;
                        var itemId=afield.itemId;
                        //根据itemId查询该字段在rowset中的行号
                        var aRowNo=getRowNoByFieldId(itemId);
                         //设置SEQ_ID值。
                        var totalColNum=fieldsTable.rows[0].cells.length;
                        var aLineNum=j+1;
                        var aColNo=k+1;
                        var aSeqId=eval((aLineNum-1)*totalColNum+aColNo);
//                        alert(afieldName+",oldSEQID:"+FieldNormalRs.getValue(aRowNo,"SEQ_ID")+",new seqId:"+aSeqId);
                        //如果没有改变，则不需要设置,这样可避免去保存。
                        if (FieldNormalRs.getValue(aRowNo,"SEQ_ID")!=aSeqId||FieldNormalRs.getValue(aRowNo,"SEQ_ID")==99){
                          FieldNormalRs.setValue(aRowNo,"SEQ_ID",aSeqId);
                          var aPkValue=FieldNormalRs.getValue(aRowNo,"LAYOUT_DETAIL_ID");
                          if (aPkValue!=null&&aPkValue!=""){
                            FieldNormalRs.getRowObj(aRowNo).I=aPkValue;
                          }
                        }
			//设置SectionId,如果 没有改变，则不需要设置,这样可避免去保存。
                        if (FieldNormalRs.getValue(aRowNo,"SECTION_ID")!=tId){
                          FieldNormalRs.setValue(aRowNo,"SECTION_ID",tId);
                          var aPkValue=FieldNormalRs.getValue(aRowNo,"LAYOUT_DETAIL_ID");
                          if (aPkValue!=null&&aPkValue!=""){
                            FieldNormalRs.getRowObj(aRowNo).I=aPkValue;
                          }
                        }
                    }
                    //fieldToXML(row.cells[k], k);
                }
            }
        }
    }
    function fieldToXML(field, x) {
        if (field.itemId && field.itemIdopenSectionEdit != '') {
            xml += '\t<item ';
            xml += 'name="' + escapeXML(field.fName) + '" ';
            xml += 'itemId="' + field.itemId + '" ';
            xml += 'itemType="' + field.fieldType + '" ';
            var fieldBehavior = null;
            if (field.fieldType == 'F' || field.fieldType == 'C') {
                fieldBehavior = field.ro == '1' ? 'readonly' : (field.rq == '1' ? 'required' : 'editable');
            } else if (field.fieldType == 'K') {
                fieldBehavior = field.il == '1' ? 'inline' : 'popup';
            }
            if (fieldBehavior) {
                xml += 'behavior="' + fieldBehavior + '" ';
            }

            xml += 'xPos="' + x + '" ';
            xml +='>';
            xml += '</item>\n';
        }
    }

    function toXML() {
        var mainTable = document.getElementById('mainLayoutTable');
        var mainRows = mainTable.rows;
        var seq_id=0;
        for (var i = 0; i < mainRows.length; i++ ) {
            var cell = mainRows[i].cells[0];
            var sectionTable = cell.childNodes[0];
            if (sectionTable && sectionTable.id) {
                var sectionId=sectionTable.id;
                sectionId=sectionId.substring(5,sectionId.length);
                var aRowNo=null;
                for (var j=0;j<SectionNormalRs.count();j++){
                   if (SectionNormalRs.getValue(j,"SECTION_ID")==sectionId){
                     aRowNo=j;
                     seq_id++;
                     if (SectionNormalRs.getValue(j,"SEQ_ID")!=seq_id){
                       SectionNormalRs.getRowObj(aRowNo).I=sectionId;
                       SectionNormalRs.setValue(aRowNo,"SEQ_ID",seq_id);
                     }
                     break;
                   }
                }
                //设置Section的顺序编号SEQ_ID
                sectionToXML(sectionTable.id);
            }
        }
    }

    function isSectionTitleUsed(pTitle) {
        var mainTable = document.getElementById('mainLayoutTable');
        var mainRows = mainTable.rows;
        for (var i = 0; i < mainRows.length; i++ ) {
            var cell = mainRows[i].cells[0];
            var sectionTable = cell.childNodes[0];
            if (sectionTable && sectionTable.id) {
                var tId = getSectionIndex(sectionTable.id);
                var sectionId = 's' + tId;
                var sectionTableId = getSectionHeaderId(sectionId);
                var sectionTable = document.getElementById(sectionTableId);
                var aTitle = escapeXML(sectionTable.innerHTML);
                if (aTitle==pTitle){
                  return true;
                }
            }
        }
        return false;
    }

    function getRowNoByFieldId(aFieldId){
      if (!FieldNormalRs||FieldNormalRs.count()==0){
        return -1;
      }
      for (var i=0;i<FieldNormalRs.count();i++){
        if (FieldNormalRs.getValue(i,"PROP_FIELD_NAME")==aFieldId){
          return i;
        }
      }
      return -1;
    }

    function escapeXML(v) {
        //return escapeJS(v, true, false);
        v = v.replace(/&/g, '\&amp;');
        v = v.replace(/"/g, '\&quot;');
        v = v.replace(/'/g, "\'");
        v = v.replace(/</g, '&lt;');
        v = v.replace(/>/g, '&gt;');

        return v;
    }
    function escapeJS(v, escapeHTML, escapeWhiteSpace) {
        v = v.replace(/'/g, "\'");

        if (escapeHTML) {
            v = v.replace(/&/g, '&amp;');
            v = v.replace(/</g, '&lt;');
            v = v.replace(/>/g, '&gt;');
        }

        if (escapeWhiteSpace) {
            v = v.replace(/\t/g, "&nbsp;&nbsp;");
            v = v.replace(/\n/g, "<br>");
        }
        return v;

    }

    function getSectionColNum(aSectionId){
        for (var j=0;j<SectionNormalRs.count();j++){
           if (SectionNormalRs.getValue(j,"SECTION_ID")==aSectionId){
             return SectionNormalRs.getValue(j,"COL_NO");
           }
        }
        return -1;
    }



