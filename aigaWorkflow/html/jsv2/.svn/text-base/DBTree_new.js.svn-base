//----------------DBTreeNew.js------------------
/*******************************************************************************
 *文件名称：DBTreeNew.js
 *    说明：与taglib中的dbtreenew对应.

函数说明： 
1.	定义 var dbTree = g_DBTreeNewManager.get(treeId)

2.    方法说明：
	tree.getSelectionPath();返回从root到当前选中节点的path路径数组。数组中是节点的值(val)

	tree.getSelectionPathInfo();返回从root到当前选中节点的path路径数组。数组中是Object对象包括以下属性Obejct.value,Object.text,Object.userobj

	tree.getCurNodeInfo();得到当前点击节点的信息 返回元素为Object对象，Object对象包括以下属性Obejct.value,Object.text,Object.userobj

	tree.setCurNodeInfo(value,text,userObj);设置当前选中的树节点的信息

        tree.setRootNodeInfo(pVal,pText,pUserObj);设置根节点的信息
         tree.getRootNodeInfo();获取根节点的信息,返回元素为Object对象，Object对象包括以下属性Obejct.value,Object.text,Object.userobj

	tree.getCheckedNodesInfo();多选状态下得到选中的节点的信息数组。数组中的元素为Object对象，
				    包括Object.value,Object.text,Object.userobj

	tree.clearSelection();单选状态下清空当前节点。多选状态下不仅清空当前节点，还清空所有checkbox的选中状态

	tree.refresh(pParentNodeVal,getchilddeep,parameter) 重新刷新指定的树节点的值,
        如果pParentNodeVal为null，表示刷新根节点.
        getchilddeep为int数值，表示获取孩子的深度，该参数会传递到后台的,供业务使用
        parameter＝参数。名值对形式。
        成功返回DBTREE_REFRESH_SUCCEED_FLAG，
	失败返回DBTREE_REFRESH_ERROR_FLAG,或者DBTree_REFRESH_USER_ERROR_FLAG

	tree.getNodeInfo(pNodeVal)  得到当前结点的信息，Object对象，Object对象包括以下属性Obejct.value,Object.text,Object.userobj
	tree.getBrotherNodesInfo(pNodeVal)  得到当前结点的兄弟结点的信息，不包括自身.返回数组，数组元素为Object对象，Object对象包括以下属性Obejct.value,Object.text,Object.userobj

	tree.isNodeInitial(pNodeVal) 判定显示的节点是否执行getChild方法，获取过孩子数据 返回true/false

	tree.getChildrenNodesInfo(pNodeVal) 得到一个树节点所有孩子节点的信息。返回数组，数组元素为Object对象，Object对象包括以下属性Obejct.value,Object.text,Object.userobj

	tree.setNodeChecked(pNodeVal,checkflag)多选状态，设置一个树节点的check状态 checkflag = true/false

	tree.getParentNodeInfo(pNodeVal) 得到当前节点的父节点信息。如果当前节点是根节点，返回null，其他返回Object对象.Object对象包括以下属性Obejct.value,Object.text,Object.userobj
	
	tree.setNodeSelect(pNodeVal) 将一个节点设置成选中状态
	tree.hasChildNode(pNodeVal) 判断某一个节点是否存在下属子节点

        /** add at 2006-4-19 针对aiocs客服team的新需求而增加
        tree.getPrevBrotherNodeInfo() 得到当前结点的上一个兄弟结点的信息，没有返回null，有返回Object对象，Object对象包括以下属性Obejct.value,Object.text,Object.userobj

        tree.getNextBrotherNodeInfo() 得到当前结点的下一个兄弟结点的信息，没有返回null，有返回Object对象，Object对象包括以下属性Obejct.value,Object.text,Object.userobj
//add by zr by 2006年6月19日	应辽宁需求和上海需求，增加外部方法
	tree.expandNodeByValue(pVal,isExpand) 根据节点value，设置某个节点是否展开或者收缩
	tree.setQueryCondtion(pConditionStr)设置查询条件，可用于在buildChild时传入条件
	tree.isNodeExpand(pVal)判断一个节点是否展开状态。返回true展开，false收缩
	
	//add by zr at 2006-10-8.多选条件下,增加设置checkbox的编辑状态的选项
	tree.setCheckBoxSts(pTreeNodeVal,pFlag) 多选状态下,根据树节点value值,设置该节点的checkbox的状态是否为可编辑的.pFlag=true/false
	


3.支持事件(tag属性)
    //-节点类型(g_Tree_NODETYPE_ROOT,g_Tree_NODETYPE_DIR,g_Tree_NODETYPE_LEAF)
	onselect 节点选中触发该事件，参数newSelNodeVal,newSelNodeText,newSelNodeUserObj,newSelNodeType
	oncheckboxclick 多选状态下，鼠标点击checkbox触发该事件,参数value,text,userobj,isChecked(true/false),treeNodeObj.nType
	onrightclick 右键点击节点触发该事件,参数value,text,userobj,treeNodeObj.nType
	ondblclick 双击节点触发该事件,参数value,text,userobj,treeNodeObj.nType
  
	//add by zr at 2006年6月19日
	增加事件
	onwillexpand 在树节点展开或者收缩前调用该方法，参数isExpand-将要展开true/收缩false,nodeVal-展开的节点value,nodeText-展开的节点文本,nodeUsrObj-展开的节点usrobj字符串
	//add by caipeng at 2008年7月1日
    explanonselect 点击节点文字时是否展开节点 true：展开,false:不展开。默认为true展开


*/
var NODE_CLOSE_IMG = _gModuleName+"/jsv2/image/tree_pic/close.gif";
var NODE_OPEN_IMG = _gModuleName+"/jsv2/image/tree_pic/open.gif";
var NODE_LAST_CLOSE_IMG =_gModuleName+"/jsv2/image/tree_pic/lastclose.gif";
var NODE_LAST_OPEN_IMG =_gModuleName+"/jsv2/image/tree_pic/lastopen.gif";
var NODE_LEAF_IMG = _gModuleName+"/jsv2/image/tree_pic/node.gif";
var NODE_LAST_LEAF_IMG = _gModuleName+"/jsv2/image/tree_pic/lastnode.gif";

var g_Tree_NODETYPE_ROOT = "1";
var g_Tree_NODETYPE_DIR = "2";
var g_Tree_NODETYPE_LEAF = "3";
var g_Tree_ROOT_Node_HTML_ID_SUFFIX= "0";


//颜色变量配置
var DBTREE_NODE_SEL_COLOR = "#1F469F"; //树节点被选中的颜色
var DBTREE_NODE_COLOR = "#000000";   //树节点未选中的颜色
var DBTREE_NODE_BACKGROUD_COLOR= "#FFE99B"; //树节点背景色;

//刷新树成功和失败的标志
var DBTREE_REFRESH_SUCCEED_FLAG ="SUCCESS";
var DBTREE_REFRESH_ERROR_FLAG ="ERROR_SYSTEM";
var DBTree_REFRESH_USER_ERROR_FLAG = "ERROR_USER";//用户抛出AITagException


var g_DBTreeNewManager = new DBTreeNewManager();
//formrowset的inital错误获取函数
function DBTreeNew_getInitErrorData(pTreeId){

    if(document.all("DBTreeNew_CUSTOM_ERROR_" + pTreeId)==null)
      {
         return null;
      }
      else
      {
      var errorXmlNode = document.all("DBTreeNew_CUSTOM_ERROR_" + pTreeId).XMLDocument.childNodes(0);
      //alert(errorXmlNode);
      if(errorXmlNode==null)
      {
      return null;
      }
      else{
      return createUserDataClass(errorXmlNode,false);
      }
      }
  }
function DBTreeNewManager(){
 this.List = new Array();
 this.push = function(dbtreeObj){
      this.List[dbtreeObj.DBTreeID] = dbtreeObj;
      return dbtreeObj.DBTreeID;
 }
 this.get = function(id){
    var result = this.List[id];
    if(!result){
       result = new DBTreeNew(id);
    }
    return result;
 }
 this.remove = function(id){
   this.List[id] = null;
 }
}



function DBTreeNew(treeID)
{
  this.DBTreeID = treeID;

  g_DBTreeNewManager.push(this);

  this.cachedID="-1";

  this.isMultiSelect = false;

  this.isHaveLine = false;//是否有线树

  this.curSelNodeID = "";//当前选中的节点id
  
  this.isdrag=false;

  this.OnSelectChangeFunc =null;

  this.OnCheckBoxClickFunc = null;

  this.OnClickFunc = null;
  
  //双击事件
  this.OnDBLClickFunc = null;

  this.OnRightClickFunc = null;
  
  this.OnWillExpandFunc = null;
  
  this.queryCondtion ="";//buildChild时，可设置查询条件传递后台
  
  this.dragedNode = null;//被拖拉过的节点信息
  
  this.explanOnSelect = true;//是否点击节点label时展开节点
  
  this.initial();

}

//内部方法
DBTreeNew.prototype.initial = DBTreeNew_initial;
DBTreeNew.prototype.getChildNodeDivObj = DBTreeNew_getChildNodeDivObj;
DBTreeNew.prototype.buildChildNode = DBTreeNew_buildChildNode;
DBTreeNew.prototype.nodeLableOnClick = DBTreeNew_nodeLableOnClick;
DBTreeNew.prototype.nodeLableOnMouseDown = DBTreeNew_nodeLableOnMouseDown;
DBTreeNew.prototype.nodeLableOnDblClick = DBTreeNew_nodeLableOnDblClick;
DBTreeNew.prototype.expandNodeUI =DBTreeNew_expandNodeUI;
DBTreeNew.prototype.expandNode = DBTreeNew_expandNode;
DBTreeNew.prototype.exeOnCheckBoxClick = DBTreeNew_exeOnCheckBoxClick;
DBTreeNew.prototype.exeOnRightClick = DBTreeNew_exeOnRightClick;
DBTreeNew.prototype.exeOnWillExpand = DBTreeNew_exeOnWillExpand;




//对外接口方法
DBTreeNew.prototype.getSelectionPath = DBTreeNew_getSelectionPath;

DBTreeNew.prototype.getSelectionPathInfo = DBTreeNew_getSelectionPathInfo;

DBTreeNew.prototype.getNodeInfo = DBTreeNew_getNodeInfo;
DBTreeNew.prototype.getCurNodeInfo = DBTreeNew_getCurNodeInfo;

DBTreeNew.prototype.setCurNodeInfo = DBTreeNew_setCurNodeInfo;

DBTreeNew.prototype.getCheckedNodesInfo =  DBTreeNew_getCheckedNodesInfo;

DBTreeNew.prototype.clearSelection  = DBTreeNew_clearSelection;

DBTreeNew.prototype.refresh = DBTreeNew_refresh;

DBTreeNew.prototype.getBrotherNodesInfo = DBTreeNew_getBrotherNodesInfo;

DBTreeNew.prototype.getChildrenNodesInfo = DBTreeNew_getChildrenNodesInfo;

DBTreeNew.prototype.setNodeChecked = DBTreeNew_setNodeChecked;

DBTreeNew.prototype.isNodeInitial = DBTreeNew_isNodeInitial;

DBTreeNew.prototype.getParentNodeInfo = DBTreeNew_getParentNodeInfo;


DBTreeNew.prototype.setRootNodeInfo = DBTreeNew_setRootNodeInfo;
DBTreeNew.prototype.getRootNodeInfo = DBTreeNew_getRootNodeInfo;

DBTreeNew.prototype.getPrevBrotherNodeInfo = DBTreeNew_getPrevBrotherNodeInfo;

DBTreeNew.prototype.getNextBrotherNodeInfo = DBTreeNew_getNextBrotherNodeInfo;

DBTreeNew.prototype.expandNodeByValue = DBTreeNew_expandNodeByValue;

DBTreeNew.prototype.setQueryCondtion = DBTreeNew_setQueryCondtion;

DBTreeNew.prototype.isNodeExpand = DBTreeNew_isNodeExpand;
DBTreeNew.prototype.setNodeSelect = DBTreeNew_setNodeSelect;
DBTreeNew.prototype.hasChildNode = DBTreeNew_hasChildNode;

DBTreeNew.prototype.setCheckBoxSts = DBTreeNew_setCheckBoxSts;

DBTreeNew.prototype.getDragedNodeInfo = DBTreeNew_getDragedNodeInfo;




/****************
* 内部方法实现
*2
*/
function DBTreeNew_exeOnDragStart(nodeObj){
   var dragId = event.srcElement.pID;
   var dragNodeObj = document.all.item(dragId);
   var treeObj = g_DBTreeNewManager.get(dragNodeObj.tID);
   if(dragNodeObj){
       
       treeObj.dragedNode = {value:dragNodeObj.I,text:dragNodeObj.T,userobj:dragNodeObj.U};
   }
   else{
      treeObj.dragedNode = null;
     
   }
   
     
  
}


function DBTreeNew_initial()
{
  var obj =  DBTreeNew_Public_getTreeDivObj(this.DBTreeID);
  this.cachedID = obj.PK;
  if(obj.mSel=="true")
    this.isMultiSelect = true;
  else
    this.isMultiSelect = false;
  if(obj.line=="true")
    this.isHaveLine = true;
  else
    this.isHaveLine = false;
  if(obj.isdrag=="true")  
    this.isdrag=true;
  else
    this.isdrag=false;
  
  if (obj.explanonselect=="false"){
    this.explanOnSelect = false;
  }
  
  this.isUseLocalCache = false;
  
  if(obj.isUseLocalCache != null && obj.isUseLocalCache == 'true'){
  	this.isUseLocalCache = true;
  	this.dataModel = obj.dataModel;
  }
  
  var funcName = "";
  try
  {

     if(obj.clickF!="")
     {
       funcName = obj.clickF;
       eval("this.OnClickFunc = "+obj.clickF);
     }
     //双击事件
     if(obj.dblClickF!="")
     {
       funcName = obj.dblClickF;
       eval("this.OnDBLClickFunc = "+obj.dblClickF);
     }
     if(obj.rClickF!="")
     {
			 funcName = obj.rClickF;
       eval("this.OnRightClickFunc="+obj.rClickF);
     }
     if(obj.clickCBF!="")
     {
       funcName = obj.clickCBF;
       eval("this.OnCheckBoxClickFunc = "+obj.clickCBF);
     }
     if(obj.beExF!="")
     {
     	 funcName = obj.beEx;
       eval("this.OnWillExpandFunc = "+obj.beExF);
     }
  }
  catch(e)
  {
     alert("[DBTreeNew.initial]初始化时绑定外部关联事件方法出错。请检查方法是否存在.\n方法名称:"+funcName);
     throw e;
  }


}




function DBTreeNew_getChildNodeDivObj(pNodeId)
{
  var obj = document.all.item(pNodeId+"_C_DIV");
  if(obj)
  {
     return obj;
  }
  else
  {
    alert("[DBTreeNew]无法获取指定节点的孩子Div.指定节点的ID="+pNodeId);
    return null;
  }
}

function DBTreeNew_buildChildNode(pParentNode,getChildDeep,pConditionStr)
{
   var reVal = null;
   if(getChildDeep==null || isNaN(parseInt(getChildDeep,10)))
     getChildDeep = "1";
   var nodeObj = pParentNode;
   if(nodeObj)
     {
	var childDivObj = this.getChildNodeDivObj(pParentNode.id);
	if(childDivObj)
	       {
		 var checksts = "false";
		     if(this.isMultiSelect==true && DBTreeNew_Public_getNodeCheckBoxObj(pParentNode.id) 
		      && DBTreeNew_Public_getNodeCheckBoxObj(pParentNode.id).checked==true)
		 {
		   checksts = "true";
		 }
		var parentLastNode =  nodeObj.isLN;
		var isParentLastNodeArray = new Array();
		if(this.isHaveLine)
		{
		   isParentLastNodeArray[isParentLastNodeArray.length] = nodeObj.isLN;
		   var parentNodeId = nodeObj.pID;
		   var parentObj = document.all.item(parentNodeId);
		   while(parentObj!=null)
		   {
			 isParentLastNodeArray[isParentLastNodeArray.length] = parentObj.isLN;
			 if(parentObj.pID!="null")
			   parentObj = document.all.item(parentObj.pID);
			 else
			  parentObj = null;
		    }
		   isParentLastNodeArray = isParentLastNodeArray.reverse();
		   parentLastNode = isParentLastNodeArray.join("|||");
		}
		var url = _gModuleName + "/dbtreenewservlet?action=getchild&pk="+this.cachedID;
		
		var para = "parentval="+g_ConditonStrEncode(nodeObj.I)
		+"&parentnodeid=" + g_ConditonStrEncode(nodeObj.id)
		+"&parentuserobj="+g_ConditonStrEncode(nodeObj.U)
		+"&parentlevel="+nodeObj.l
		+"&parentchecksts="+checksts
		+"&parenttext="+g_ConditonStrEncode(nodeObj.T)
		+"&parentislastnode="+parentLastNode
		+"&getdeep="+getChildDeep;
		
		if(this.isUseLocalCache == true || this.isUseLocalCache == 'true'){
		
			para = para+"&treeid="+this.DBTreeID
				+"&isHaveLine="+this.isHaveLine
				+"&isMultiSelect="+this.isMultiSelect
				+"&dataModel="+this.dataModel
				+"&isUseLocalCache="+this.isUseLocalCache;
		}
		
		if(_gModuleName!="" && nodeObj.fOPic.indexOf(_gModuleName)>=0)
		{
		  para=para
		  +"&parentfoldopenpic="+nodeObj.fOPic.replace(_gModuleName,"")
		  +"&parentfoldclosepic="+nodeObj.fCPic.replace(_gModuleName,"")
		  +"&parentleafpic="+nodeObj.lPic.replace(_gModuleName,"");

		}
		else
		{
		 para=para
		 +"&parentfoldopenpic="+nodeObj.fOPic
		 +"&parentfoldclosepic="+nodeObj.fCPic
		 +"&parentleafpic="+nodeObj.lPic;

		}
		
        if(pConditionStr!=null)
         {
          para+="&"+(pConditionStr);
         }
         
          var sRe = gCheckLogOut(postParamToServer(url,para));
          
          var xml = new ActiveXObject("Msxml.DOMDocument");
          xml.async = false;
          var xmlFlag =xml.loadXML(sRe);
          
	      if(xmlFlag==false)
	      {
                alert("返回值不符合xml定义.reVal="+sRe);
	      }
	      else
	      {
		var xmlNode = xml.documentElement;
		var flag ="N";
		var data = "";
		for(var i =0;i<xmlNode.childNodes.length;i++)
		{
		  var tmpNode = xmlNode.childNodes(i);
		  if (tmpNode.nodeName =="FLAG")
		  {
		    flag = tmpNode.text;
		  }
		  if (tmpNode.nodeName =="DATA")
		   {
		    data = tmpNode.text;
                   }

		}
              //alert(flag);
	       if(flag == DBTREE_REFRESH_SUCCEED_FLAG)
		     {
		     childDivObj.innerHTML = "";
		     if(data!="")
		      {
			       childDivObj.innerHTML = data;
			       if(nodeObj.nType!=g_Tree_NODETYPE_ROOT)
			       {
			       	 nodeObj.nType = g_Tree_NODETYPE_DIR;
			       	 if(this.isHaveLine)
			         {
			           if(nodeObj.isLN=="true")
			           {
				           if(nodeObj.exp=="true")
				           {
				             DBTreeNew_Public_getNodeLineImgObj(nodeObj.id).src = NODE_LAST_OPEN_IMG;
				           }
				           else
				           {
				          	 DBTreeNew_Public_getNodeLineImgObj(nodeObj.id).src = NODE_LAST_CLOSE_IMG;
				           }
			           }
			           else
			           	{

			           		if(nodeObj.exp=="true")
				             {
				              DBTreeNew_Public_getNodeLineImgObj(nodeObj.id).src = NODE_OPEN_IMG;
				             }
				             else
				             {
				          	  DBTreeNew_Public_getNodeLineImgObj(nodeObj.id).src = NODE_CLOSE_IMG;
				             }


				          }
             		}
			       }
			       
			      


		      }
		     else
		      {
				       if(nodeObj.nType!=g_Tree_NODETYPE_ROOT)
			         {
				      
				       nodeObj.nType = g_Tree_NODETYPE_LEAF;
				       DBTreeNew_Public_getNodeImgObj(nodeObj.id).src = nodeObj.lPic;
				    	 if(this.isHaveLine)
				    	 {
				        if(nodeObj.isLN=="true")
					       DBTreeNew_Public_getNodeLineImgObj(nodeObj.id).src = NODE_LAST_LEAF_IMG;
				        else
					       DBTreeNew_Public_getNodeLineImgObj(nodeObj.id).src = NODE_LEAF_IMG;
	             }
		          }
		        }
		         nodeObj.isInit = "true";
             reVal = createNewUserDataClass();
             reVal.addData("FLAG",DBTREE_REFRESH_SUCCEED_FLAG);

			}
	    else if(flag==DBTree_REFRESH_USER_ERROR_FLAG)
	      {
                nodeObj.isInit = "false";
                if(data!=null)
                  {
                    reVal =  createUserDataByXml(data);
                    reVal.addData("FLAG",DBTree_REFRESH_USER_ERROR_FLAG);
                  }

	      }
              else if(flag == DBTREE_REFRESH_ERROR_FLAG)
              {
                 reVal = createNewUserDataClass();
                 reVal.addData("FLAG",DBTREE_REFRESH_ERROR_FLAG);
                 reVal.addData("MESSAGE",data);
              }
	      else
	      {
		 reVal = data;
		 alert("获取子节点错误,详细信息:"+data);
		 nodeObj.isInit = "false";
	      }
	    }
       }
     }
     return reVal;

}

function DBTreeNew_nodeLableOnMouseDown(labelObj,nodeObj){
  //判断是否设置为drag模式
  if(this.isdrag && nodeObj.nType==g_Tree_NODETYPE_LEAF){
     var e =  event.srcElement;
     var range = document.body.createTextRange();
	 range.moveToElementText(e);
	 range.select();
	
  }
}
function DBTreeNew_nodeLableOnClick(labelObj,nodeObj,isRightClick)
{
  var lastSelNodeVal ="";
  var lastSelNodeText = "";
  var lastSelNodeUserObj="";
  var newSelNodeVal = "";
  var newSelNodeText = "";
  var newSelNodeUserObj = "";
  if(this.curSelNodeID!="")
  {
    var lastSelObj = document.all.item(this.curSelNodeID);
    if(lastSelObj)
    {
      var lastSelLabelObj = DBTreeNew_Public_getNodeLabelObj(this.curSelNodeID);
      //alert("here lastSelLabelObj="+lastSelLabelObj.innerHTML);
      lastSelLabelObj.style.backgroundColor = "transparent";
      lastSelLabelObj.style.color = DBTREE_NODE_COLOR;
      lastSelNodeVal = lastSelObj.I;
      lastSelNodeText = lastSelObj.T;
      lastSelNodeUserObj = lastSelObj.U;
    }

  }
  labelObj.style.backgroundColor = DBTREE_NODE_BACKGROUD_COLOR;
  labelObj.style.color = DBTREE_NODE_SEL_COLOR;
  newSelNodeVal = nodeObj.I;
  newSelNodeText = nodeObj.T;
  newSelNodeUserObj = nodeObj.U;
  newSelNodeType = nodeObj.nType;
  this.curSelNodeID = nodeObj.id;
  
  
  
  try
  {
    if(this.OnClickFunc){
  	  if(!isRightClick)
        this.OnClickFunc(newSelNodeVal,newSelNodeText,newSelNodeUserObj,newSelNodeType);
    }
  }
  catch(e)
       {
	  alert("[DBTreeNew.nodeLableOnClick]执行外部关联的OnClick方法出现错误.\n方法信息:"+this.OnClickFunc);
	   throw e;
       }

}


function DBTreeNew_nodeLableOnDblClick(labelObj,nodeObj)
{
  var lastSelNodeVal ="";
  var lastSelNodeText = "";
  var lastSelNodeUserObj="";
  var newSelNodeVal = "";
  var newSelNodeText = "";
  var newSelNodeUserObj = "";
  if(this.curSelNodeID!="")
  {
    var lastSelObj = document.all.item(this.curSelNodeID);
    if(lastSelObj)
    {
      var lastSelLabelObj = DBTreeNew_Public_getNodeLabelObj(this.curSelNodeID);
      //alert("here lastSelLabelObj="+lastSelLabelObj.innerHTML);
      lastSelLabelObj.style.backgroundColor = "transparent";
      lastSelLabelObj.style.color = DBTREE_NODE_COLOR;
      lastSelNodeVal = lastSelObj.I;
      lastSelNodeText = lastSelObj.T;
      lastSelNodeUserObj = lastSelObj.U;
    }

  }
  labelObj.style.backgroundColor = DBTREE_NODE_BACKGROUD_COLOR;
  labelObj.style.color = DBTREE_NODE_SEL_COLOR;
  newSelNodeVal = nodeObj.I;
  newSelNodeText = nodeObj.T;
  newSelNodeUserObj = nodeObj.U;
  newSelNodeType = nodeObj.nType;
  this.curSelNodeID = nodeObj.id;
  try
  {
  if(this.OnDBLClickFunc)
    this.OnDBLClickFunc(newSelNodeVal,newSelNodeText,newSelNodeUserObj,newSelNodeType);
  }
  catch(e)
       {
    alert("[DBTreeNew.nodeLableOnClick]执行外部关联的OnClick方法出现错误.\n方法信息:"+this.OnClickFunc);
     throw e;
       }

}

//内部方法，展开（收缩）树节点
function DBTreeNew_expandNodeUI(pNodeObj,flag)
{
   if(pNodeObj.nType == g_Tree_NODETYPE_DIR && pNodeObj.isInit=="true")
    {

      var childDivObj = this.getChildNodeDivObj(pNodeObj.id);
      if(flag)
      {
	 childDivObj.style.display = "inline";
	  pNodeObj.exp="true";

	// alert( pNodeObj.fOPic);
	  DBTreeNew_Public_getNodeImgObj(pNodeObj.id).src = pNodeObj.fOPic;
	  //有线状态,且节点为非根节点时.
          if(this.isHaveLine && pNodeObj.l!="0")
	 {
	   if(pNodeObj.isLN=="true")
	      DBTreeNew_Public_getNodeLineImgObj(pNodeObj.id).src = NODE_LAST_OPEN_IMG;
	   else
	      DBTreeNew_Public_getNodeLineImgObj(pNodeObj.id).src = NODE_OPEN_IMG;
	 }
       }
      else
      {
	  childDivObj.style.display = "none";
	   pNodeObj.exp="false";
	   DBTreeNew_Public_getNodeImgObj(pNodeObj.id).src = pNodeObj.fCPic;
	   if(this.isHaveLine && pNodeObj.l!="0")
	 {
	   if(pNodeObj.isLN=="true")
	      DBTreeNew_Public_getNodeLineImgObj(pNodeObj.id).src = NODE_LAST_CLOSE_IMG;
	   else
	      DBTreeNew_Public_getNodeLineImgObj(pNodeObj.id).src = NODE_CLOSE_IMG;
	 }
      }
    }

}


//根据节点value，展开或者收缩某个节点。如果该节点没有init，首先init，
function DBTreeNew_expandNode(nodeObj,isExpand)
{
	
  if(nodeObj)
     {
       if(nodeObj.nType == g_Tree_NODETYPE_ROOT)
         return;
        //如果该对象没有被初始化,并且是收起操作的话,则直接返回
       if(nodeObj.isInit=="false" && isExpand ==false){
        return;
       }
       //执行展开事件  
       this.exeOnWillExpand(nodeObj,isExpand);
         
    	 if(nodeObj.isInit=="false" && nodeObj.nType !=  g_Tree_NODETYPE_LEAF)
    		{
		      var ud = this.buildChildNode(nodeObj,1,this.queryCondtion);
      		if(ud!=null && ud.getValueByName("FLAG") != DBTREE_REFRESH_SUCCEED_FLAG)
      			{
          		if(ud.getValueByName("MESSAGE")!=null)
          		{
            			alert("获取子节点失败,详细信息:"+ud.getValueByName("MESSAGE"));
          		}
          		else
          		{
            			alert("获取子节点失败");
          		}

      			}
      		this.expandNodeUI(nodeObj,true);

   		 }
    	else
    	{
	 			this.expandNodeUI(nodeObj,isExpand);	
    	}
       
       
       
       
    }
}




function DBTreeNew_exeOnCheckBoxClick(treeNodeObj)
{
  try
  {
    if(this.OnCheckBoxClickFunc)
    {
      var isChecked = false;
      checkboxObj =  DBTreeNew_Public_getNodeCheckBoxObj(treeNodeObj.id);
      if(checkboxObj.checked == true)
	isChecked = true;
      this.OnCheckBoxClickFunc(treeNodeObj.I,treeNodeObj.T,treeNodeObj.U,isChecked,treeNodeObj.nType);
    }
  }
  catch(e)
       {
	  alert("[DBTreeNew.exeOnCheckBoxClick]执行外部关联的OnCheckBoxClick方法出现错误.\n方法信息:"+this.OnCheckBoxClickFunc);
	  throw e;
       }
}

function DBTreeNew_exeOnRightClick(treeNodeObj)
{
  try
  {
  	if(treeNodeObj!=null){
    	var label = DBTreeNew_Public_getNodeLabelObj(treeNodeObj.id);
    	var treeObj = g_DBTreeNewManager.get(treeNodeObj.tID);
		treeObj.nodeLableOnClick(label,treeNodeObj,true);
    }
    if(this.OnRightClickFunc)
    {
       this.OnRightClickFunc(treeNodeObj.I,treeNodeObj.T,treeNodeObj.U,treeNodeObj.nType);
    }
  }
  catch(e)
       {
	  alert("[DBTreeNew.exeOnRightClick]执行外部关联的exeOnRightClick方法出现错误.\n方法信息:"+this.exeOnRightClickFunc);
	  throw e;
       }
}


function DBTreeNew_exeOnWillExpand(treeNodeObj,isExpand)
{
	 try
  {
    
    if(this.OnWillExpandFunc)
    {
       this.OnWillExpandFunc(isExpand,treeNodeObj.I,treeNodeObj.T,treeNodeObj.U,treeNodeObj.nType);
    }
  }
  catch(e)
       {
	  alert("[DBTreeNew.exeOnWillExpand]执行外部关联的OnWillExpand方法出现错误.\n方法信息:"+this.exeOnWillExpand);
	  throw e;
       }
}



/**********对外接口方法***************************************************/
function DBTreeNew_getSelectionPath()
{
  var reArray = new Array();
  if(this.curSelNodeID!="")
  {

    var curSelObj = document.all.item(this.curSelNodeID);
    if(curSelObj)
     {
       reArray[reArray.length] = curSelObj.I;
       var parentNodeId = curSelObj.pID;
       var parentObj = document.all.item(parentNodeId)
       while(parentObj)
       {
	  reArray[reArray.length] = parentObj.I;
	  if(parentObj.pID!="null")
	    parentObj = document.all.item(parentObj.pID);
	  else
	    parentObj = null;
       }
       reArray = reArray.reverse();
     }

  }
  return reArray;
}


function DBTreeNew_getSelectionPathInfo()
{
  var reArray = new Array();
  if(this.curSelNodeID!="")
  {

    var curSelObj = document.all.item(this.curSelNodeID);
    if(curSelObj)
     {
       var tmpObj = new Object();
       tmpObj.value = curSelObj.I;
       tmpObj.text = curSelObj.T;
       tmpObj.userobj = curSelObj.U;
       reArray[reArray.length] = tmpObj;
       var parentNodeId = curSelObj.pID;
       var parentObj = document.all.item(parentNodeId);
       while(parentObj)
       {
	  var tmpObj = new Object();
	  tmpObj.value = parentObj.I;
	  tmpObj.text = parentObj.T;
	  tmpObj.userobj = parentObj.U;
	  reArray[reArray.length] = tmpObj;
	  if(parentObj.pID!="null")
	    parentObj = document.all.item(parentObj.pID);
	  else
	    parentObj = null;
       }
       reArray = reArray.reverse();
     }

  }
  return reArray;
}


function  DBTreeNew_getCurNodeInfo()
{
  var reObj = null;
  if(this.curSelNodeID!="")
   {
     var curSelObj = document.all.item(this.curSelNodeID);
     if(curSelObj)
     {
       reObj = {value:curSelObj.I,text:curSelObj.T,userobj:curSelObj.U};
     }
   }
  return reObj;
}


function DBTreeNew_setCurNodeInfo(pVal,pText,pUserObj)
{
  if(this.curSelNodeID!="")
   {
     var curSelObj = document.all.item(this.curSelNodeID);
     if(curSelObj)
     {
       if(pVal!=null)
       curSelObj.I = pVal;
       if(pText!=null)
       {
	 curSelObj.T = pText;
	 var obj = DBTreeNew_Public_getNodeLabelObj(this.curSelNodeID);
	 obj.innerText = pText;
       }
       if(pUserObj!=null)
       curSelObj.U = pUserObj;
     }
   }
}

function DBTreeNew_getCheckedNodesInfo()
{
  var reArray = new Array();
  if(this.isMultiSelect==true)
  {
    var treeDivObj = DBTreeNew_Public_getTreeDivObj(this.DBTreeID);

    var checkBoxObjArray = treeDivObj.all.tags("INPUT");

    for(var i=0;i<checkBoxObjArray.length;i++)
    {

      if(checkBoxObjArray.item(i).type=="checkbox")
      {

      if(checkBoxObjArray.item(i).checked==true)
       {
	 var treeNodeId = checkBoxObjArray.item(i).pID;
	 var obj = document.all.item(treeNodeId);
	 if(obj)
	    reArray[reArray.length] = {value:obj.I,text:obj.T,userobj:obj.U};
       }
    }
    }
  }
  return reArray;
}

function DBTreeNew_clearSelection()
{
  //如果是多选，先清空所有checkbox的状态
  if(this.isMultiSelect)
   {
    var treeDivObj = DBTreeNew_Public_getTreeDivObj(this.DBTreeID);
    var checkBoxObjArray = treeDivObj.all.tags("INPUT");
  for(var i=0;i<checkBoxObjArray.length;i++)
    {
      if(checkBoxObjArray.item(i).type=="checkbox")
      {
	if(checkBoxObjArray.item(i).checked)
	 {
	  checkBoxObjArray.item(i).checked = false;
	 }
      }
    }
  }
  //设置选中的节点为未选中
  if(this.curSelNodeID!="")
   {
     var curLabelSelObj = DBTreeNew_Public_getNodeLabelObj(this.curSelNodeID);
     if(curLabelSelObj)
     {

       curLabelSelObj.style.backgroundColor = "transparent";
       curLabelSelObj.style.color = DBTREE_NODE_COLOR;
     }
     this.curSelNodeID = "";
   }



}

function DBTreeNew_refresh(pParentNodeVal,pGetChildDeep,condition)
{
  var reVal =null;
  var parentNodeObj = null;

   //如果pParentNodeVal==null,意味着对这个根节点进行更新
  if(pParentNodeVal==null || pParentNodeVal=="")
  {
     parentNodeObj = DBTreeNew_Public_getRootNodeObj(this.DBTreeID);
  }
  else
  {   //更新指定节点的孩子节点
    parentNodeObj = DBTreeNew_Public_getNodeByValue(this.DBTreeID,pParentNodeVal);
  }
  if(parentNodeObj)
    {
      //如果this.queryCondtion有值，将值与参数conditon合并作为条件出入后台
      if(this.queryCondtion!="")
      {
        if(condition!=null && condition.length>0)
           condition = this.queryCondtion+"&"+condition;
        else
           condition = this.queryCondtion;    
      }
      
      reVal = this.buildChildNode(parentNodeObj,pGetChildDeep,condition);
      if(reVal.getValueByName("FLAG") == DBTREE_REFRESH_SUCCEED_FLAG)
      {
        if(parentNodeObj.exp=="true")
         this.expandNodeUI(parentNodeObj,true);
      }
      else if(reVal.getValueByName("FLAG")== DBTree_REFRESH_USER_ERROR_FLAG){
        return reVal;
      }
      else{
        alert(reVal.getValueByName("MESSAGE"));
      }
    }
  return reVal;

}


function DBTreeNew_getBrotherNodesInfo(pNodeVal)
{
   var reArray = new Array();
   var selNode =  DBTreeNew_Public_getNodeByValue(this.DBTreeID,pNodeVal);
   if(selNode)
   {
     if(selNode.l!="0" && selNode.pID!="null")
     {

       var parentNodeChildDivObj = this.getChildNodeDivObj(selNode.pID);
       var tableObjArray = parentNodeChildDivObj.all.tags("TABLE");
       for(var i=0;i<tableObjArray.length;i++)
       {
	 if(tableObjArray.item(i).I && tableObjArray.item(i).I!=pNodeVal &&  tableObjArray.item(i).l == selNode.l)
	 {
	    reArray[reArray.length] = {value:tableObjArray.item(i).I,text:tableObjArray.item(i).T,userobj:tableObjArray.item(i).U};

	 }
       }
     }


   }
   return reArray;
}

function DBTreeNew_getChildrenNodesInfo(pParentNodeVal)
{
   var reArray = new Array();
   var selNode =  DBTreeNew_Public_getNodeByValue(this.DBTreeID,pParentNodeVal);
   if(selNode)
   {
       if(selNode.isInit == "false")
       {
	 this.buildChildNode(selNode,1,this.queryCondtion);
       }
       if(selNode.nType!=g_Tree_NODETYPE_LEAF)
       {
	 var parentNodeChildDivObj = this.getChildNodeDivObj(selNode.id);
	 var tableObjArray = parentNodeChildDivObj.all.tags("TABLE");
	 for(var i=0;i<tableObjArray.length;i++)
	 {
	 if(tableObjArray.item(i).pID!=null && tableObjArray.item(i).pID==selNode.id)
	   reArray[reArray.length] = {value:tableObjArray.item(i).I,text:tableObjArray.item(i).T,userobj:tableObjArray.item(i).U};
	  }
       }



   }
   return reArray;
}

function DBTreeNew_hasChildNode(pParentNodeVal)
{
   var bHasChild = false;
   var selNode =  DBTreeNew_Public_getNodeByValue(this.DBTreeID,pParentNodeVal);
   if(selNode)
   {
       if(selNode.isInit == "false")
       {
	 	this.buildChildNode(selNode,1,this.queryCondtion);
       }
       if(selNode.nType!=g_Tree_NODETYPE_LEAF)
       {
		 var parentNodeChildDivObj = this.getChildNodeDivObj(selNode.id);
		 var tableObjArray = parentNodeChildDivObj.all.tags("TABLE");
		 if(tableObjArray!=null && tableObjArray.length>0)
		 	bHasChild = true;
       }
   }
   return bHasChild;
}
function DBTreeNew_setNodeChecked(pNodeVal,flag)
{
  if(this.isMultiSelect==true)
  {
     var selNode =  DBTreeNew_Public_getNodeByValue(this.DBTreeID,pNodeVal);
     if(selNode)
     {
       var checkBoxObj = DBTreeNew_Public_getNodeCheckBoxObj(selNode.id);
       if(checkBoxObj)
	 checkBoxObj.checked = flag;
     }
  }

}

function DBTreeNew_isNodeInitial(pNodeVal)
{
  var reVal = false;
  var selNode =  DBTreeNew_Public_getNodeByValue(this.DBTreeID,pNodeVal);
  if(selNode)
     {
       if(selNode.isInit=="true")
	 reVal = true;
     }
  return reVal;
}

//add by hexg ,2006-8-23
function DBTreeNew_getNodeInfo(pNodeVal){
	var reVal = null;
	var selNode =  DBTreeNew_Public_getNodeByValue(this.DBTreeID,pNodeVal);
	if(selNode)
	{
		var treeNode = document.all.item(selNode.id);
       	if(treeNode)
			reVal = {value:treeNode.I,text:treeNode.T,userobj:treeNode.U};
	}
  	return reVal;
}
function DBTreeNew_getParentNodeInfo(pNodeVal)
{
  var reVal = null;
  var selNode =  DBTreeNew_Public_getNodeByValue(this.DBTreeID,pNodeVal);
  if(selNode && selNode.nType!=g_Tree_NODETYPE_ROOT)
     {
       var parentNode = document.all.item(selNode.pID);
       if(parentNode)
	 reVal = {value:parentNode.I,text:parentNode.T,userobj:parentNode.U};

     }
  return reVal;
}


function DBTreeNew_getRootNodeInfo(){
  var curSelObj = DBTreeNew_Public_getRootNodeObj(this.DBTreeID);
  reObj = {value:curSelObj.I,text:curSelObj.T,userobj:curSelObj.U};
  return reObj;
}

function DBTreeNew_setRootNodeInfo(pRootVal,pRootText,pRootUserobj)
{
  if(pRootVal == null)
    {
     alert("根节点值不可为空");
     return;
    }
  if(pRootText==null)
    {
      pRootText = pRootVal;
    }
  var rootObj = DBTreeNew_Public_getRootNodeObj(this.DBTreeID);
  if(rootObj)
  {
     rootObj.I = pRootVal;
     rootObj.T = pRootText;
     if(pRootUserobj!=null)
     {
       rootObj.U = pRootUserobj;
     }
     var labelObj = DBTreeNew_Public_getNodeLabelObj(rootObj.id);
     labelObj.innerText = rootObj.T;

  }
}

function DBTreeNew_expandNodeByValue(pValue,isExpand)
{
	var selNode =  DBTreeNew_Public_getNodeByValue(this.DBTreeID,pValue);
	if(selNode)
	{
		this.expandNode(selNode,isExpand);
	}
}

//hexg 
function DBTreeNew_setNodeSelect(pValue){
	var selNode =  DBTreeNew_Public_getNodeByValue(this.DBTreeID,pValue);
	if(selNode)
	{
		var label = DBTreeNew_Public_getNodeLabelObj(selNode.id);
		var treeObj = g_DBTreeNewManager.get(selNode.tID);
		treeObj.nodeLableOnClick(label,selNode)
		if(selNode.exp=="false")
	 		treeObj.expandNode(selNode,true);
	}
}

function DBTreeNew_setQueryCondtion(pConditionStr)
{
	 this.queryCondtion = pConditionStr;
}

function DBTreeNew_isNodeExpand(pNodeValue)
{
   var selNode =  DBTreeNew_Public_getNodeByValue(this.DBTreeID,pNodeValue);
   if(selNode)
   {
     
   
     if("true"==selNode.exp)
       return true;
     else
       return false;  
   }
  
}







/******全局函数**********************************************************/
function DBTreeNew_Public_getTreeDivObj(pDBTreeId)
{
  var treeDivId = "$Tree_"+pDBTreeId;
  var obj = document.all.item(treeDivId);
  if(obj)
  {
    return obj;
  }
  else
  {
    alert("[DBTreeNew_getTreeDivObj]无法获取树组件所在的Div对象");
    return null;
  }
}
function DBTreeNew_Public_getRootNodeObj(pDBTreeId)
{
  var rootId = "$Tree_"+pDBTreeId+"|||"+g_Tree_ROOT_Node_HTML_ID_SUFFIX;
  var obj = document.all.item(rootId);
  if(obj)
  {
    return obj;
  }
  else
  {
    alert("[DBTreeNew]无法获取根节点html对象");
    return null;
  }
}

function DBTreeNew_Public_getNodeByValue(pDBTreeId,pNodeValue)
{
  var reObj = null;
  var tableObjArray = DBTreeNew_Public_getTreeDivObj(pDBTreeId).all.tags("TABLE");
  for(var i=0;i<tableObjArray.length;i++)
    {
      if(tableObjArray.item(i).I && tableObjArray.item(i).I==pNodeValue)
       {
	 reObj = tableObjArray.item(i);
	 break;
       }
    }
  return reObj;
}

function DBTreeNew_Public_getNodeLabelObj(pTreeNodeId)
{
  var labelId = pTreeNodeId+"_LABEL";
  var obj = document.all.item(labelId);
  if(obj)
  {
    return obj;
  }
  else
  {
    alert("[DBTreeNew]无法获取树节点对象的LABEL");
    return null;
  }
}

function DBTreeNew_Public_getNodeImgObj(pTreeNodeId)
{
  var imgId = pTreeNodeId+"_IMG";
  var obj = document.all.item(imgId);
  if(obj)
  {
    return obj;
  }
  else
  {
    alert("[DBTreeNew]无法获取树节点的IMG对象");
    return null;
  }
}

function DBTreeNew_Public_getNodeLineImgObj(pTreeNodeId)
{
  var imgId = pTreeNodeId+"_L_IMG";
  var obj = document.all.item(imgId);
  if(obj)
  {
    return obj;
  }
  else
  {
    alert("[DBTreeNew]无法获取有线树分支节点的Line对象");
    return null;
  }
}

function DBTreeNew_Public_getNodeCheckBoxObj(pTreeNodeId)
{
  var sId = pTreeNodeId+"_CB";
  var obj = document.all.item(sId);
  if(obj)
  {
    return obj;
  }
  else
  {
    alert("[DBTreeNew]无法获取树节点的CHECKBOX对象");
    return null;
  }
}



function DBTreeNew_Node_OnMouseDown(nodeObj){
  
  var srcObj = event.srcElement;
  var treeObj = g_DBTreeNewManager.get(nodeObj.tID); 
  
  if(srcObj.tagName=="LABEL")
  {
    treeObj.nodeLableOnMouseDown(srcObj,nodeObj);
  }
}


function DBTreeNew_Node_OnClick(nodeObj)
{

  var srcObj = event.srcElement;
  var treeObj = g_DBTreeNewManager.get(nodeObj.tID);

  if(srcObj.tagName=="LABEL")
  {
  	
    treeObj.nodeLableOnClick(srcObj,nodeObj)
    if(nodeObj.exp=="false" && treeObj.explanOnSelect==true)
	 		treeObj.expandNode(nodeObj,true);

  }
  if(srcObj.tagName == "IMG")
  {
    if(nodeObj.exp=="true")
	 		treeObj.expandNode(nodeObj,false);
    else
	  	treeObj.expandNode(nodeObj,true);    

  }
  if(srcObj.tagName == "INPUT" && srcObj.type && srcObj.type=="checkbox")
  {
    treeObj.exeOnCheckBoxClick(nodeObj);
  }
}

//双击事件
function DBTreeNew_Node_OnDBLClick(nodeObj)
{
  var srcObj = event.srcElement;
  var treeObj = g_DBTreeNewManager.get(nodeObj.tID);

  if(srcObj.tagName=="LABEL")
  {
    treeObj.nodeLableOnDblClick(srcObj,nodeObj)
    if(nodeObj.exp=="false")
      treeObj.expandNode(nodeObj,true);

  }
  if(srcObj.tagName == "IMG")
  {
    if(nodeObj.exp=="true")
      treeObj.expandNode(nodeObj,false);
    else
      treeObj.expandNode(nodeObj,true);    

  }
  if(srcObj.tagName == "INPUT" && srcObj.type && srcObj.type=="checkbox")
  {
    treeObj.exeOnCheckBoxClick(nodeObj);
  }
}

function DBTreeNew_OnContextMenu(treeDivObj)
{
  var srcObj = event.srcElement;
  if(srcObj && (srcObj.id.indexOf("_LABEL") || srcObj.id.indexOf("_CB")) && srcObj.pID)
  {
    var nodeObj = document.all.item(srcObj.pID);
    if(nodeObj)
    {

      var treeObj = g_DBTreeNewManager.get(nodeObj.tID);
     
	  
      treeObj.exeOnRightClick(nodeObj);
      window.event.returnValue = false;
      window.event.cancelBubble = true;
    }
  }
}


function DBTreeNew_getNextBrotherNodeInfo ()
{
   var reObject = null;
  if(this.curSelNodeID!="")
  {
    var curSelObj = document.all.item(this.curSelNodeID);
    if(curSelObj && curSelObj.l!="0" && curSelObj.pID!="null")
    {
       var parentNodeChildDivObj = this.getChildNodeDivObj(curSelObj.pID);
       var childrenObjArray = parentNodeChildDivObj.all.tags("TABLE");
       for(var i=0;i<childrenObjArray.length;i++)
       {
         if(childrenObjArray.item(i).id == curSelObj.id &&  (i+1) < childrenObjArray.length)
         {
            for(var j=i+1;j<childrenObjArray.length;j++)
           {
             if(childrenObjArray.item(j).l==curSelObj.l){
             reObject = {value:childrenObjArray.item(j).I,text:childrenObjArray.item(j).T,userobj:childrenObjArray.item(j).U};
             break;
             }
           }
         }

      }
    }
  }
  return reObject;
}

function DBTreeNew_getPrevBrotherNodeInfo()
{
  var reObject = null;
  if(this.curSelNodeID!="")
  {
    var curSelObj = document.all.item(this.curSelNodeID);
    if(curSelObj && curSelObj.l!="0" && curSelObj.pID!="null")
    {
       var parentNodeChildDivObj = this.getChildNodeDivObj(curSelObj.pID);
       var childrenObjArray = parentNodeChildDivObj.all.tags("TABLE");
       for(var i=0;i<childrenObjArray.length;i++)
       {
         if(childrenObjArray.item(i).id == curSelObj.id &&  i > 0)
         {
           for(var j=i-1;j>=0;j--)
           {
             if(childrenObjArray.item(j).l==curSelObj.l){
             reObject = {value:childrenObjArray.item(j).I,text:childrenObjArray.item(j).T,userobj:childrenObjArray.item(j).U};
             break;
             }
           }
         }

      }
    }
  }
  return reObject;

}

function DBTreeNew_setCheckBoxSts(pTreeNodeVal,pFlag)
{
  
  if(this.isMultiSelect==true)
  {
     var selNode =  DBTreeNew_Public_getNodeByValue(this.DBTreeID,pTreeNodeVal);
     if(selNode)
     {
       var checkBoxObj = DBTreeNew_Public_getNodeCheckBoxObj(selNode.id);
       if(checkBoxObj)
          if(pFlag==false)
	        checkBoxObj.disabled = true;
	      else
	        checkBoxObj.disabled = false;  
     }
  }
}
//获取drag的节点信息
function DBTreeNew_getDragedNodeInfo(){
  return this.dragedNode;
}

function DBTreeNew_clearPageCache(){
	var treedivs = document.getElementsByTagName("div");
	var treeNewPks = new Array();
	for (var i = 0;i < treedivs.length;i++){
		if (typeof(treedivs[i].PK) !="undefined" && 
			treedivs[i].PK!='-1' && 
			treedivs[i].id.indexOf("$Tree_") > -1){

			treeNewPks.push(treedivs[i].PK);
		}
	}
	if (treeNewPks.length > 0){
	    var XMLSender = new ActiveXObject("Microsoft.XMLHTTP");
	    XMLSender.Open("POST",_gModuleName + "/dbtreenewservlet?action=clearobj&pks="+treeNewPks.join(";"),true);
	    XMLSender.setRequestHeader("Content-Type","multipart/form-data");
	    XMLSender.send(null);
	}
	
	window.detachEvent("onunload",DBTreeNew_clearPageCache);
}

if (typeof(_isClearCacheObj)!="undefined" && _isClearCacheObj == "Y"){
	window.attachEvent("onbeforeunload",DBTreeNew_clearPageCache);
}

