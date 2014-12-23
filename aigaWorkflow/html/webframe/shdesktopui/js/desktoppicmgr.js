  
  //根据员工登录编号查询自定义桌面的图标并生成图标
  function loadUserPict(pUserId,pPicArray){

		var param="?action=queryUserDesktopInfo&operatorId=" +pUserId;
		var gRowSet1 =g_NormalRowSetManager.create("virtual",_gModuleName+"/business/com.ai.frame.desktopui.web.UserVisitControlAction"+param);

    	var aCount=gRowSet1.count();
		if(gRowSet1==null||aCount==0)
		{
			return;
		}
		var preUrl=_gModuleName;
		for (var i=0;i<aCount;i++)
		{
				var aMovePictInst=new Array();
				aMovePictInst[0]=preUrl+gRowSet1.getValue(i,"PICT_URL");//图标URL
				aMovePictInst[1]=gRowSet1.getValue(i,"DISP_TEXT");
				aMovePictInst[2]=gRowSet1.getValue(i,"GOTO_URL");//目标URL
				aMovePictInst[3]=gRowSet1.getValue(i,"POS_X");
				aMovePictInst[4]=gRowSet1.getValue(i,"POS_Y");
				aMovePictInst[5]=divObj1;
				aMovePictInst[6]=gRowSet1.getValue(i,"FUNC_ID");
				aMovePictInst[7]="ISOLD";
				aMovePictInst[8]=""//是否移动，缺省为空；
				aMovePictInst[9]="";//是否删除，缺省为空；
				pPicArray[i]=aMovePictInst;
			}
		buildDeskPictFromAry(pPicArray);
  }

  function buildDeskPictFromAry(pPicArray)
	{
	  if (pPicArray==null||pPicArray.length==0){
		return;
	  }

	  for (var i=0;i<pPicArray.length;i++){
	  	 if(pPicArray[i]==null)continue;
	  	 
		 var aPictAry=pPicArray[i];
		 var iconSrc=aPictAry[0];
		 var btmText=aPictAry[1];
		 var gotoUrl=aPictAry[2];
		 var posX=aPictAry[3];
		 var posY=aPictAry[4];
		 var divObj=aPictAry[5];
		 var menuId=aPictAry[6];
		 var aMovePictInst = MovePict(iconSrc,btmText,gotoUrl,posX,posY,divObj,menuId);
		 aMovePictInst.buildNode();
	  }
	}




 //保存图标
 function saveDesktopPict(pUserID,pMovePictArray){
 	var param="?action=queryUserDesktopInfo&operatorId=" +pUserID;
	var gRowSet =g_NormalRowSetManager.create("virtual",_gModuleName+"/business/com.ai.frame.desktopui.web.UserVisitControlAction"+param);
 	
 	
	//aMovePictInst[7]="ISNEW";//新增的标志，新增时只有改标志的才保存到数据库。删除时该标志的不需删除数据库。
	var strMoveFuncIdList="";
	var strPosX="";
	var strPosY="";
	var hasNewRs=false;
	var hasMoveRs=false;
	
	for (var i=0;i<pMovePictArray.length;i++){
		if(pMovePictArray[i]==null)continue;
		
		var aMovePictInst=pMovePictArray[i];
		var isNew=aMovePictInst[7];//是否新建
		var isMove=aMovePictInst[8];//是否移动
		var isDelete=aMovePictInst[9];//是否删除
		if (isNew=="ISNEW"){
			if (isDelete=="ISDELETE"){//如果是新增的后又删除，则不需要保存，直接进行下一个循环
				pMovePictArray[i] = null;
				continue;
			}

			//新建gRowSet一行并设置值
			gRowSet.newRow();
			
			var row_no=gRowSet.getRow();
			gRowSet.setValue(row_no,"USER_ID",pUserID);
			gRowSet.setValue(row_no,"FUNC_ID",aMovePictInst[6]);
			gRowSet.setValue(row_no,"PICT_URL",aMovePictInst[0]);
			gRowSet.setValue(row_no,"POS_X",aMovePictInst[3]);
			gRowSet.setValue(row_no,"POS_Y",aMovePictInst[4]);
			gRowSet.setValue(row_no,"DISP_TEXT",aMovePictInst[1]);
			gRowSet.setValue(row_no,"GOTO_URL",aMovePictInst[2]);
			aMovePictInst[7] = "";//设置其不再是新增状态
		}else{
			var pos = -1;
			var aCount=gRowSet.count();
			for (var k=0;k<aCount;k++)
			{
				if(gRowSet.getValue(k,"FUNC_ID")!= aMovePictInst[6])continue;
				pos = k;
				break;
			}
			if(pos==-1)continue;
			
      		if (isMove=="ISMOVE" && isDelete!="ISDELETE"){      			
      			gRowSet.setValue(pos,"POS_X",aMovePictInst[3]);
				gRowSet.setValue(pos,"POS_Y",aMovePictInst[4]);
				aMovePictInst[8] ='';
      		}
			//剩余的是数据库存在的必须进行删除数据库操作的
			if (isDelete=="ISDELETE"){
				gRowSet.deleteRow(k);
				pMovePictArray[i] = null;
	   		}
		}
	}
	if(gRowSet.toXmlString(true)!=''){
		var str = gRowSet.toXmlString(true) 
		var list = new Array();
	    list[0]=gRowSet;
    	saveRowSet(_gModuleName+"/business/com.ai.frame.desktopui.web.UserVisitControlAction?action=saveUserDesktop",list);
   	}
}


//rename重命名一个图标的动作
function renameDesktopPictAction(pUserID,pDivId,pPicArray){
  var divName=pDivId;

  var i=divName.substring(5,divName.length);

  var aMovePictInst=pPicArray[i-1];
  var old_url=aMovePictInst[2];
  var aTitle=aMovePictInst[1];
  var linkDivName="AILinkName"+i;

  var linkDiv=document.all.item(linkDivName);
  var strNewDivHtml="<input name=\"new_pict_text\" class=\"input\" size=8 maxlength=20 value="+aTitle+" onfocus=\"this.select();\" onkeypress=\"desktopPicRenameInputEnterKeyPress('"+pUserID+"','"+pDivId+"')\" >";
  linkDiv.innerHTML=strNewDivHtml;
  document.all.item("new_pict_text").focus();

}



function desktopPicRenameInputEnterKeyPress(pUserID,pDivId){
     var lKeyCode = (navigator.appname=="Netscape")?event.which:event.keyCode;
     if ( lKeyCode == 13 ){
       saveDesktopNewName(pUserID,pDivId);
     }
     else
       return false;
}
//保存重新命名
function saveDesktopNewName(pUserID,pDivId){
  var new_text=document.all.item("new_pict_text").value;
  var divName=pDivId;
  var i=divName.substring(5,divName.length);
  var aMovePictInst=aryMovePict[i-1];
  var old_url=aMovePictInst[2];
  var aTitle=aMovePictInst[1];
  var linkDivName="AILinkName"+i;
  
  var linkDiv=document.all.item(linkDivName);

  if (new_text==aTitle||new_text==null||trim(new_text)==""){
	    linkDiv.innerHTML="<A class=b1 href='"+old_url+"'>"+aTitle+"</A>";
  }else{
  		 //设置新的名称
    	aMovePictInst[1]=new_text;
    	linkDiv.innerHTML="<A class=b1 href='"+old_url+"'>"+new_text+"</A>";
    	
		//如果是新建的则不保存
		if(aMovePictInst[7]=='ISNEW')return;
		  
  		var para = "?action=renameDesktopPic"  
		 + "&operatorId="+pUserID
		 + "&func_id=" + aMovePictInst[6]
		 + "&ico_name=" + new_text;

		PostInfo(_gModuleName+"/business/com.ai.frame.desktopui.web.UserVisitControlAction"+para);
  	
  return;
   
    //保存数据库
    //创建gRowSet
    var parameter=g_ConditonStrEncode("USER_ID="+pUserID+" AND FUNC_ID="+aMovePictInst[6]);
    var param="?action=queryRowSet&setName=com.ai.frame.userdeskpict.SETUserDesktopPict&param="+parameter;
    var gRenRowSet=g_NormalRowSetManager.create("virtual",_gModuleName+"/business/defaultaction"+param);
    gRenRowSet.setValue(0,"DISP_TEXT",new_text);
    var list = new Array();
    list[list.length]=gRenRowSet;
    saveRowSet(_gModuleName+'/business/com.ai.frame.userrecentmenu.UserRecentFuncAction?action=SaveUserRecentFunc',list);
    
  }
}




