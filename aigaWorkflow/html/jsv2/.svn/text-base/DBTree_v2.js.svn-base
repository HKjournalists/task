//----------------DBTree.js------------------
/*******************************************************************************
 *文件名称：DBTree.js
 *    说明：对DataRow数据集根据用户提供的treemodel构造一棵按要求分层的html树形结构

  综述：
	tree是一个javascript组件，其主要作用是接受NormalRowSet对象，对象并逐层递归生成树显示。
	目前公用模块提供已经定义默认的treemodel：
	DBTreeModel,其具体使用见同名的.js文件,每个treemodel需要实现如下接口函数
接口说明:
	1.this.getRootVal = function getRootVal()
	返回根节点的值
	2.this.getRootText = function getRootText()
	返回根节点的显示文本
	3.this.getChildrenCount = function getChildrenCount(id)
	根据父节点的值,返回该父亲节点的孩子个数
	4.this.getChildrenText = function getChildrenText(id)
	根据父节点的值,返回该父亲节点的孩子们的显示文本数组
	5.this.getChildrenVal = function getChildrenVal(id)
	根据父节点的值,返回该父亲节点的孩子们的显示值数组
	注:getChildrenText和getChildrenVal函数对同一个父亲id,返回的值和文本应该是下标统一的.

	6.this.getAllVals
	7.this.getAllTexts
    得到所有节点的value值和text数组
	8.this.getAllChildrenVals(id)
	得到某个指定节点的所有孩子的数组
	9.this.getText(id)
	根据value值获得显示displayText文本

	注：6,7,8接口函数用于多选树的情况，如果只是单选树显示，只需要返回null即可。

函数说明：
1.	定义 var dbTree = new DBTree(model)
	参数说明：
	参数1：treeModel类。
2	显示tree：dbTree.displayTree();
	无参数
3.  在增加树到页面时,使用div.appendChild(dbTree.getUIObject());

4	非叶子节点是否相应事件dbTree.setFolderEvent("true")
	参数：如果只要求叶子节点相应事件，可以设置为"false"即可。

5	事件说明：
	tree.addListener(S_OnChange,obj);增加监听事件
	tree.removeListener(S_OnChange,obj);删除监听事件
6
    tree.getPathFromRoot();返回从root到当前选中节点的path路径数组。数组中是节点的值

	tree.getRowSetRow();选中节点对应rowset的第几行，如果选中的节点是非叶子节点，只能返回该节点第一个子节点对应的行

	tree.getCurNodeValue();得到当前点击节点的value,

	tree.getCurNodeText() ;得到当前点击节点的text,

	tree.setCurNodeValue(pValue)  设置当前节点的value值

	tree.setCurNodeText(pText)   设置当前节点的displayText值

	tree.getSelectedNodesValue();多选状态下得到选中的节点的value数组

	tree.getSelectedNodesText(); 多选状态下得到选中的节点的text数组

	tree.clearSelectedSts() ; 单选状态下清空当前节点。多选状态下不仅清空当前节点，还清空所有checkbox的选中状态


	tree.setFolderEvent(boolean) 设置是否允许非叶子节点响应事件

	tree.setRootEvent(boolean) 设置是否允许根节点响应事件

	tree.setMultiSelectFlag(boolean) 设置多选标志

	tree.setMultiRecursionFlag(boolean) 设置多选下的递归标志

	this.setMultiInitDisabledArray(nValArray) 设置多选初始化下的check的disable状态

	tree.setShowMenu(boolean,width) 是否显示菜单标志,若显示的话,width为菜单的宽度

  tree.reload(Module,boolean) 树重载，true获取重载前的选定节点，并将其展开，false不展开

	tree.addChildTreeNode(pValue,pText,pNodeType)   在当前节点下增加一个孩子节点pValue-节点值 pText-节点文本,pNodeType-节点类型."fold","leaf"

	tree.removeCurTreeNode()  从树结构中删除当前选中节点.




        tree.getBrotherValues()  得到当前选中结点的兄弟结点的id，不包括自身



	tree.getParentValues()得到当前选中节点父节点的value值，如果选中为根节点，或者没有选中的节点，返回null。


	[Deprecation]tree.setSelectedByValue(var id,isExpand);
	单选时选中第一个value相同的节点，多选时选中所有给定value的节点,isExpand=true时展开树节点，false不展开树节点



	[Deprecation] tree.setSelectedByName(var name,isExpand)
	单选时选中第一个value相同的节点，多选时选中所有给定value的节点,isExpand=true时展开树节点，false不展开树节点

        tree.getPrevBrotherValue() 得到当前选中节点，的前一个兄弟节点的id,add at 2006-4-19为兼容客服系统代码而新增

        tree.getNextBrotherValue() 得到当前选中节点的后一个兄弟节点的id,add at 2006-4-19为兼容客服系统代码而新增




 ******************************************************************************/
var g_DBTreeManager = new DBTreeManager();

function DBTreeManager(){
 this.List = new Array();
 this.push = function(dbtreeId,dbtreeObj){
      this.List[dbtreeId] = dbtreeObj;
	  return dbtreeId;
 }
 this.get = function(pk){
    return result = this.List[pk];
 }
 this.remove = function(pk){
   this.List[pk] = null;
 }
}

/*******************************************************/
/*函数说明：DBTree类，
/*输入参数：treeModel：树的Model模型对象
/*输出参数：DBTree对象实例。
/*******************************************************/

function DBTree(nTreeModel,nIsInitAll,nInitDeep)
{
	var dbTreeClass = new DBTreeClass(nTreeModel,nIsInitAll,nInitDeep);
	return dbTreeClass;
}


/**************************************** */
/*treeModel:树的model                     */
/*showDeep：显示的节点深度                */
/**************************************** */
function DBTreeClass(treeModel,nIsInitAll,nInitDeep)
{
	this.PK = null;

	this.UIObject = document.createElement("div");
	//this.UIObject.style.position="absolute";

	//obj.nodeImgObj.src = imgHEADo;
	this.curdeep =0;

    this.isInitAll = nIsInitAll;
    if(nIsInitAll==null)
		this.isInitAll = false;
    //alert("this.isIntAll="+this.isInitAll);
	this.initDeep = nInitDeep;
	if(nInitDeep==null)
       this.initDeep = 1;
	this.treeModel = treeModel;
    this.rootNode =null;

	this.selTreeNodePath="";/*当前选中的节点的路径字符串*/
	this.selPathArray=null;/*当前选中的节点的路径数组*/

	this.curTreeNode=null;
	this.curNodeValue="";
    this.curNodeText ="";

	this.selNodesValue=null;/*多选情况下check的节点数组的value和显示文本*/
	this.selNodesText=null;

	this.isFolderFireEvent=true;/*判断是否允许文件夹响应事件*/
	this.isRootFireEvent=false;/*判断是否允许根节点响应事件*/
	this.isSameNodeFireEvent=false;/*判断相同节点是否允许重复触发事件*/

	this.isMultiSelect=false;/*判断是否允许在每个节点显示check控件表示多选*/
	this.isMultiRecursion=true;/*判断是否允许在多选时进行递归选择*/


	this.MultiInitValArray = null;/*在多选状态下，用户对节点进行展开时，设置节点checkbox的check初始状态*/
	this.MultiInitCheckBoxDisabledArray = null;/*在多选状态下，用户对节点进行展开时，设置节点checkbox的disabled状态*/

	this.isFolderFireEvent=true;/*判断是否允许文件夹响应事件*/

	this.selRowSetRow=0; /*选中节点对应rowset的第几行，如果选中的节点是非叶子节点，只能返回该节点第一个子节点对应的行*/

	this.pathArray=null;


	this.isShowMenu=false /*是否显示菜单的标志*/
	this.popMenuFuncName="";

	this.menuWidth = 100;/*菜单的默认宽度*/
	this.menuItemArray=null;

	//方法
	this.getDataObj = function getDataObj(){ return this};

	this.getModel=function getModel()
					{
						return this.treeModel;
					};


	this.buildTree = buildTree;
	this.displayTree=displayTree;

	this.UIObject.onmousedown = DBTreeOnClickFunc;
	this.UIObject.onclick = DBTreeCheckBoxClickFunc;

	this.isAllowDrag = false;
	this.UIObject.ondragstart = DBTreeOnDragStart;



	//事件函数

	this.addListener = Object_addListener;
    this.removeListener =  Object_removeListener;
    this.fireListener = Object_fireListener;


	/*------------用户可以调用的方法-------------*/
	this.getUIObject = function()
					 {

						return this.UIObject;
					 }
	//设置是否运行拖拽节点
	this.setAllowDragDrop = function(flag){
			      this.isAllowDrag = flag;
					}
	this.getPathFromRoot=function()//节点路径数组。
			     {
		       return this.pathArray;
			  };
    this.getRowSetRow=function()
					 {
						return this.selRowSetRow;
			     };

    this.getCurNodeValue=function()
			 {
						return this.curNodeValue;
					 };
	this.getCurNodeText =function()
			 {
						 return this.curNodeText;
					 }
        this.getPrevBrotherValue = function()
        {
          var reVal = null;
          var curId = this.getCurNodeValue();
          if(curId!=null && curId!="")
          {
            var pathArray = this.getPathFromRoot();
            if(pathArray!=null && pathArray.length>1)
            {
              var parentId = pathArray[pathArray.length-2];
              var tmpArray = this.treeModel.getChildrenVal(parentId);
              //alert(tmpArray.length);
              for(var i=0;i<tmpArray.length;i++)
              {
                if(tmpArray[i]==curId && i>0)
                {
                  reVal = tmpArray[i-1];
                  break;
                }
              }
            }
          }
          return reVal;
        }
        this.getNextBrotherValue = function()
        {
          var reVal = null;
          var curId = this.getCurNodeValue();
          if(curId!=null && curId!="")
          {
            var pathArray = this.getPathFromRoot();
            if(pathArray!=null && pathArray.length>1)
            {
              var parentId = pathArray[pathArray.length-2];
              var tmpArray = this.treeModel.getChildrenVal(parentId);
              //alert(tmpArray.length);
              for(var i=0;i<tmpArray.length;i++)
              {
                if(tmpArray[i]==curId && (i+1)<tmpArray.length)
                {
                  reVal = tmpArray[i+1];
                  break;
                }
              }
            }
          }
          return reVal;
        }

	this.getBrotherValues = function()
			 {

						var reArray = new Array();
						var curId = this.getCurNodeValue();

						if(curId!=null && curId!="")
						 {
			   var pathArray = this.getPathFromRoot();

						   if(pathArray!=null && pathArray.length>1)
							 {

							   var parentId = pathArray[pathArray.length-2];

							   var tmpArray = this.treeModel.getChildrenVal(parentId);
							   //alert(tmpArray.length);
							   for(var i=0;i<tmpArray.length;i++)
								 {
								   if(tmpArray[i]!=curId)
									 {
									   reArray[reArray.length]=tmpArray[i];
									 }
								 }

							 }
						 }
			return reArray;
			 }
	    this.getParentValues = function()
	   {
		     var curId = this.getCurNodeValue();
		var parentId = -1;
		  if(curId!=null && curId!="")
		   {
			     var pathArray = this.getPathFromRoot();
			 if(pathArray!=null && pathArray.length>2)
			      {
				 parentId = pathArray[pathArray.length-2];
			      }
			}
		return parentId;
	    }

	this.setCurNodeValue = function (pValue) // 设置当前节点的value值
			{
						 if(this.curTreeNode!=null && pValue!=null)
						  {
						this.curTreeNode.setTreeNodeValue(pValue);
							this.curNodeValue = pValue;
						  }
			}

	this.setCurNodeText= function(pText)//设置当前节点的displayText值
		       {
					   if(this.curTreeNode!=null && pText!=null)
					   {
						   this.curTreeNode.setTreeNodeText(pText);
						   this.curNodeText = pText;
					   }
			    }
    this.setSameNodeEvent=function(flag)
			{
				 this.isSameNodeFireEvent=flag;
					}
	this.setFolderEvent=function(flag)
					{
						this.isFolderFireEvent=flag;
					}
	this.setRootEvent = function(flag)
			{
				this.isRootFireEvent = flag;
			}
	this.setMultiSelectFlag =function setMultiSelectFlagFunc(flag)
					{
						if(flag)
						{
						  this.isMultiSelect = true;
						  //若设置树多选,默认初始化所有节点
						  //this.isInitAll=true;
						}
						else
						{
						  this.isMultiSelect = false;
						}
					}

	this.setMultiRecursionFlag = function setMultiRecursionFlagFunc(flag)
					{
						if(flag)
						   {
							 this.isMultiRecursion = true;

						   }
						else
						  {
							 this.isMultiRecursion = false;
						  }
					}
    this.clearSelectedSts = function()
			{
				//如果是多选，先清空所有checkbox的状态
						if(this.isMultiSelect)
						{
			    var checkboxArray = this.getUIObject().all.tags("INPUT");
							for(var i=0;i<checkboxArray.length;i++)
								{
									if(checkboxArray.item(i).type=="checkbox" && checkboxArray.item(i).id=="DBTree_checkbox")
				       if(checkboxArray.item(i).checked)
										{
											checkboxArray.item(i).checked=false;
										}
								}

						}
						//设置所有的label为未选状态
						var labelArray =this.getUIObject().all.tags("LABEL");
					   //alert("label.length="+labelArray.length);
					    for (var i=0; i< labelArray.length; i++)
							{

								if(labelArray.item(i) && labelArray.item(i).id=="DBTree_label")
								{
									labelArray.item(i).style.backgroundColor = "transparent";
									labelArray.item(i).style.color = DBTREE_NODE_COLOR;
								}
							}
			}

	this.reload = function DBTreeReload(treeModel,nFlag) //树重载，true获取重载前的选定节点，并将其展开，false只是展开
			{
			 var curNodePathArray = null;
			 if(nFlag && this.curNodeValue)
			 {
			 	 curNodePathArray = this.getPathFromRoot();
			 }
			 else
			 	{
			 		this.curTreeNode=null;
	        this.curNodeValue="";
          this.curNodeText ="";
			 		
			 	}
			 this.treeModel = treeModel;
			 var obj= this.getDataObj();
			 for(var i=0;i<obj.UIObject.children.length;i++)
						{
							obj.UIObject.removeChild(obj.UIObject.children[i]);
							//obj.removeNode(true);
						}
						obj.innerHTML="";
						var tmpObj = createDBTreeNodeClassFactory(treeModel.getRootVal(),treeModel.getRootText(),0,obj,"root");
						obj.UIObject.appendChild(tmpObj.UIObject);
			      this.rootNode = tmpObj;
						this.rootNode.isInit = true;
						this.rootNode.isExpand= true;
			      var deep =0;
						this.buildTree(this.rootNode,deep);
						//alert(this.innerHTML);
						deep =0;
						if(nFlag && this.curNodeValue && curNodePathArray!=null)
						{
							
							var divArray = this.getUIObject().all.tags("DIV");
							var tmpTreeNode = null;
							
							for(var j=1;j<=curNodePathArray.length-1;j++)
							{
								
								for(var m=0;m<divArray.length;m++)
					       {
						       
						       if(divArray.item(m).id=="DBTreeNode_"+curNodePathArray[j])
						       {
						          tmpTreeNode = g_DBTreeNodeManager.get(divArray.item(m).PK);
						          if(tmpTreeNode)
						          {
									      tmpTreeNode.setVisible(true);
												tmpTreeNode.setExpand(true);
									      tmpTreeNode.buildChildNode();
									    }
									    break; 
						       }
							   }
							
						  }
						  divArray = this.getUIObject().all.tags("DIV");
						  for(var n=0;n<divArray.length;n++)
						  {
						  	if(divArray.item(n).id == "DBTreeNode_"+this.curNodeValue)
						  	{
						  		tmpTreeNode = g_DBTreeNodeManager.get(divArray.item(n).PK);
						  		tmpTreeNode.setSelected(true);
						  	}
						  }
						}
			}
	this.refresh = function DBTreeRefresh(nParemeter){
			   this.treeModel.refreshModel(this.PK,nParemeter);
					   this.reload(this.treeModel,false);

					}
	this.getSelectedNodesValue=function()
		       {

					   var initSelArray = null;
					   //复制初始化数组倒initSelArray中.值为索引值.
		       if(this.MultiInitValArray!=null)
					   {
			 initSelArray = new Array();
						 for(var k=0;k<this.MultiInitValArray.length;k++)
						   {
							 initSelArray[this.MultiInitValArray[k]]=this.MultiInitValArray[k];
						   }
					   }
		       //alert("initSelArray.value="+initSelArray.join());
					   var multiSelArray = new Array();
					   if(this.isMultiSelect)
						{
					    var checkboxArray = this.getUIObject().all.tags("INPUT");
							for(var i=0;i<checkboxArray.length;i++)
								{
									if(checkboxArray.item(i).type=="checkbox" && checkboxArray.item(i).id=="DBTree_checkbox")
									{


										 //如果页面的checkbox值中有MultiInitValArray中的值。则在initArray中设置未“DBTree_null”
										 if(initSelArray!=null)
												{
													if(initSelArray[checkboxArray.item(i).value]!=null)
													{
														initSelArray[checkboxArray.item(i).value]="DBTree_null";
													}

												}
										if(checkboxArray.item(i).checked)
										{
											//根节点不算,因为根节点为用户指定，只是虚节点，在数据库中并没有相应的记录关连.如果根节点被选中，则所有树节点都被选中
											//alert("this.rootNode.id="+this.rootNode.id+" item.value="+checkboxArray.item(i).value);
											if(checkboxArray.item(i).value==this.rootNode.value)
											{
												multiSelArray = this.treeModel.getAllVals();
												multiSelArray.shift();
												return multiSelArray;
											}
											else
											{

											   multiSelArray[multiSelArray.length]=checkboxArray.item(i).value;
											   //如果某个节点被选中并且未展开，则获取该节点所有的孩子节点的值
  
                    
											  if(g_DBTreeNodeManager.get(checkboxArray.item(i).PK).isInit==false)
												{
												   //alert("get all children node value selNode.value="+checkboxArray.item(i).value);
												   var tmpArray = this.treeModel.getAllChildrenVals(checkboxArray.item(i).value);
												   for(var n=1;n<tmpArray.length;n++)
													{
													   multiSelArray[multiSelArray.length]=tmpArray[n];
													   if(initSelArray!=null)
													   {
															if(initSelArray[tmpArray[n]]!=null)
															  {
																initSelArray[tmpArray[n]]="DBTree_null";
															  }

													   }
													}

												}

											}




										}//inner if

				    };
								}
			     //将initSelArray中不为“DBTree_null”的值加入multiSelArray中
							if(initSelArray!=null && this.MultiInitValArray!=null)
							{
								for(var m=0;m<this.MultiInitValArray.length;m++)
								{
									if(initSelArray[this.MultiInitValArray[m]]!="DBTree_null")
									{
				       multiSelArray[multiSelArray.length]=initSelArray[this.MultiInitValArray[m]];
									}



								}
							}
							 //清除内存
							//initSelArray.length=0;
							initSelArray=null;

						}//end outest if

						return multiSelArray;

		       }
	this.getSelectedNodesText=function()
		       {
			      // alert("in getSelectednodestext");
					   var multiSelArray = new Array();
					   if(this.isMultiSelect)
						{

							var valArray = this.getSelectedNodesValue();
			    for(var i=0;i<valArray.length;i++)
							{
								multiSelArray[multiSelArray.length]=this.treeModel.getText(valArray[i]);
							}
						}
						return multiSelArray;

		       }
     this.setShowMenu=function(flag,showMenuFunc,hideMenuFuncName)
		       {
			      if(flag)
					   {
						  this.isShowMenu=true;
						  this.popMenuFuncName = showMenuFunc;
					      this.UIObject.oncontextmenu = DBTreeRightClickFunc;
						  if(hideMenuFuncName!=null && hideMenuFuncName!="")
						      this.UIObject.onclick = hideMenuFuncName;


		       }
					  else
					   {
						  this.isShowMenu=false;
						  this.UIObject.oncontextmenu = "";
						  this.UIObject.onclick = "";

					   }
				   }
	 this.setMultiInitValArray= function(nValArray)
		       {
			    if(nValArray == null) return;
					 if(nValArray.length==0 && this.MultiInitValArray)
						 this.MultiInitValArray.length =0;

		     this.MultiInitValArray = null;
					 this.MultiInitValArray = nValArray;
		       }
	 this.setMultiInitDisabledArray= function(nValArray)
		       {
			    if(nValArray == null) return;
				if(nValArray.length==0 && this.MultiInitCheckBoxDisabledArray)
					 this.MultiInitCheckBoxDisabledArray.length =0;


			this.MultiInitCheckBoxDisabledArray = null;
				this.MultiInitCheckBoxDisabledArray = nValArray;
		       }

	 this.setSelectedByValue=function(nVal,nIsExpand)
		      {
			      if(nVal==null || nIsExpand==null) return;
					  var divArray = this.getUIObject().all.tags("DIV");

		      for(var i=0;i<divArray.length;i++)
					  {
						     if(divArray.item(i).id=="DBTreeNode_"+nVal)
						      {
				                 if(this.isMultiSelect)
						       {

									  var divObj = g_DBTreeNodeManager.get(divArray.item(i).PK);
									  divObj.setChecked("checked");
                                      divObj.isInit =true;
									  if(nIsExpand)
											{


												while(divObj && divObj.deep>=0 && divObj.treeNodeType!="root")
													{
													    //alert("divObj.id="+divObj.id+" divObj.nodeParent.isExpand="+divObj.nodeParent.isExpand);
													      divObj.setVisible(true);
													      divObj.setExpand(true);
														  divObj = divObj.nodeParent;

													}

											}


						       }
								 else
								   {
										var divObj = g_DBTreeNodeManager.get(divArray.item(i).PK);
									    divObj.setSelected(true);
										if(nIsExpand)
											{


												while(divObj && divObj.deep>=0 && divObj.treeNodeType!="root")
													{
													    //alert("divObj.id="+divObj.id+" divObj.nodeParent.isExpand="+divObj.nodeParent.isExpand);
													      divObj.setVisible(true);
													      divObj.setExpand(true);
														  divObj = divObj.nodeParent;

													}
						break;

											}



									  }
							 //如果flag＝false，节点收缩
					if(!nIsExpand)
					  {
						     var divObj = g_DBTreeNodeManager.get(divArray.item(i).PK);
							 divObj.setExpand(false);
						  
					  }		  
							  }
					   }
		   

		      }
     this.setSelectedByText=function(nText,nIsExpand)
		      {
			     // alert("in setselectbytext="+nIsExpand+" nText"+nText);
					  if(nText==null || nIsExpand==null) return;
					  var divArray = this.getUIObject().all.tags("DIV");
		      for(var i=0;i<divArray.length;i++)
					  {
						     if(divArray.item(i).displayText && divArray.item(i).displayText==nText)
						      {
				 if(this.isMultiSelect)
						       {
				      var divObj = g_DBTreeNodeManager.get(divArray.item(i).PK);
									  divObj.setChecked("checked");
									  if(nIsExpand)
											{

												while(divObj && divObj.deep>=0 && divObj.treeNodeType!="root")
													{
													    //alert("divObj.id="+divObj.id+" divObj.nodeParent.isExpand="+divObj.nodeParent.isExpand);
													      divObj.setVisible(true);
													      divObj.setExpand(true);
														  divObj = divObj.nodeParent;

													}

											}
						       }
								 else
								   {
										var divObj = g_DBTreeNodeManager.get(divArray.item(i).PK);
										divObj.setSelected(true);
										if(nIsExpand)
											{

												while(divObj && divObj.deep>=0 && divObj.treeNodeType!="root")
													{
													    //alert("divObj.id="+divObj.id+" divObj.nodeParent.isExpand="+divObj.nodeParent.isExpand);
													      divObj.setVisible(true);
													      divObj.setExpand(true);
														  divObj = divObj.nodeParent;

													}
						break;
											}

									  }
							  }
					   }


		      }
    //在当前节点下增加一个孩子节点pValue-节点值 pText-节点文本
    this.addChildTreeNode=function (pValue,pText,pNodeType)
		     {
			    if(this.curTreeNode!=null)
					 {
						this.curTreeNode.addChildNode(pValue,pText,pNodeType);

						//将增加的treenode信息增加到datamodel中
						this.treeModel.addChildNode(this.curTreeNode.value,pValue,pText);


					 }


		     }
	//删除当前选中的结点
	this.removeCurTreeNode = function ()
		      {
			     if(this.curTreeNode!=null)
					  {
					    //将dataModel中的结点数据删除
						this.treeModel.delNode(this.curTreeNode.value);
						//alert("this.curTreeNode="+this.curTreeNode);
						//删除页面html树对象
						this.curTreeNode.remove();

						this.curTreeNode = null;
						this.curNodeValue = "";
						this.curNodeText = "";


					  }
		  }
    this.removeTreeNode = function(pTreeNodeValue)
				 {
					//将dataModel中的结点数据删除
					this.treeModel.delNode(pTreeNodeValue);
					//如果有html对象，删除html对象
		    var divArray = this.getUIObject().all.tags("DIV");
					for(var i=0;i<divArray.length;i++)
					  {
					     if(divArray.item(i).id=="DBTreeNode_"+pTreeNodeValue)
						      {
				 var divObj = g_DBTreeNodeManager.get(divArray.item(i).PK);
								 if(divObj)
								  {
									 divObj.remove();
									 if(this.curTreeNode && this.curTreeNode.PK == divObj.PK)
									  {
					this.curTreeNode = null;
								this.curNodeValue = "";
								this.curNodeText = "";
									  }
				     break;
								  }
							  }
					  }
				 }
	 /*-----------------------------

	this.rootNode = createDBTreeNodeClassFactory(this.treeModel.getRootVal(),this.treeModel.getRootText(),0,this,"root");

	this.rootNode.isInit = true;
	if(this.initDeep>0)
		this.rootNode.isExpand = true;
	this.curTreeNode = this.rootNode;
*/

	return this;
}

/*******************************************************/
/*函数说明：据model接口的要求,构造树的模型
/*输入参数：根节点的Node对象.
/*输出参数：null
/*******************************************************/


function buildTree(nNode,deep)
{


	if(deep>=0 && deep<=this.initDeep)
	{
       nNode.setVisible(true);
	   if(this.isMultiSelect && this.MultiInitValArray!=null)
		 {

			 for(var j=0;j<this.MultiInitValArray.length;j++)
				 {
					if(nNode.value==this.MultiInitValArray[j])
					 {
						nNode.checkbox.checked =true;
						nNode.checkSts="checked";
						break;

					 }
				 }
		}
	   //初始化

	   if(this.isMultiSelect && this.MultiInitCheckBoxDisabledArray!=null)
	   {

		     for(var m=0;m<this.MultiInitCheckBoxDisabledArray.length;m++)
			{
				//alert("value= "+nNode.value+","+this.MultiInitCheckBoxDisabledArray[m]);
				if(nNode.value == this.MultiInitCheckBoxDisabledArray[m])
				{
					 nNode.checkbox.disabled = true;
					 break;
				}

			}

	   }

	}
	if(deep>0 && deep<this.initDeep)
	{
		nNode.isInit = true;
		nNode.isExpand = true;
		if(nNode.isLastTreeNode)
			nNode.setTreeNodeType(nNode.treeNodeType,"bottom","open");
		else
	    nNode.setTreeNodeType(nNode.treeNodeType,"center","open");

	}
	if(this.isInitAll)
	{
		nNode.isInit = true;
	}

	var count = this.treeModel.getChildrenCount(nNode.value);
	//alert("childcount="+count);
	   if(count>0)
	{


		var childsVal = this.treeModel.getChildrenVal(nNode.value);
		var  childsText = this.treeModel.getChildrenText(nNode.value);
		deep+=1;
		var tmpNode = null;
		if(this.isInitAll)
		{
	    //nNode.setExpand(true);
			for(var i =0;i<count;i++)
			{

				//alert("in buildtree count="+this.treeModel.getChildrenCount(childsVal[i])+" childsVal[i]="+childsVal[i]);
				if(this.treeModel.getChildrenCount(childsVal[i])>0)
					tmpNode = nNode.addChildNode(childsVal[i],childsText[i],"fold");
				else
				    tmpNode = nNode.addChildNode(childsVal[i],childsText[i],"leaf");

				this.buildTree(tmpNode,deep);
			}
		}
		else
		{
	   if(deep<=this.initDeep)
			    {
				  for(var i =0;i<count;i++)
					{

						//alert("in buildtree count="+this.treeModel.getChildrenCount(childsVal[i])+" childsVal[i]="+childsVal[i]);
						if(this.treeModel.getChildrenCount(childsVal[i])>0)
							tmpNode = nNode.addChildNode(childsVal[i],childsText[i],"fold");
						else
							tmpNode = nNode.addChildNode(childsVal[i],childsText[i],"leaf");
						this.buildTree(tmpNode,deep);
					}


				}

		}

	}

}




/*******************************************************/
/*函数说明：将数据集合根据排序字段分层显示，返回构造好的html树
/*输入参数：无
/*输出参数：返回html字符串
/*******************************************************/


function displayTree()
{
	this.rootNode = createDBTreeNodeClassFactory(this.treeModel.getRootVal(),this.treeModel.getRootText(),0,this,"root");
	this.UIObject.appendChild(this.rootNode.getUIObject());
	var deep=0;
	this.rootNode.isInit = true;

	if(this.initDeep>0)
		this.rootNode.isExpand = true;

	this.buildTree(this.rootNode,deep);
	deep =0;

	this.curTreeNode = this.rootNode;



	//alert(this.innerHTML);



}






/*******************************************************/
/*函数说明：获取当前节点开始到根结点的路径，返回数组，
/*输入参数：node:当前点击的树节点,
	    isText:true表示返回的是文本displayText的路径数组，false表示返回的是value值的路径数组。
			isRootNode: true表示返回的数组顺序是从根节点到当前节点。false表示从当前节点到根节点的数组
/*输出参数：返回数组
/****************************************************/

	function getNodePath(node,isText,isRootToNode)
	{
		var nodePathToRoot = new Array();

		var curObj = node;

		while(curObj!=null)
		{
	  if(isText)
			nodePathToRoot[nodePathToRoot.length]= curObj.displayText;
		  else
	    nodePathToRoot[nodePathToRoot.length]=curObj.value;
		  curObj = curObj.nodeParent;
		}
		if(isRootToNode)
		{
	  var nodePathFromRoot =nodePathToRoot.reverse();
		  return nodePathFromRoot;
		}
		else
		  return nodePathToRoot;
	}

//独立函数
//开始拖拽函数
function DBTreeOnDragStart(){


}


function DBTreeOnClickFunc()
{
	var selDiv = null;
	var selObj = null;

	//节点伸展和收缩事件
	//alert("on click "+event.srcElement.id);

       if(event.srcElement.id=="DBTree_node")
	{
		selDiv = event.srcElement;
		//alert("selPK="+selDiv.PK);
	selObj = g_DBTreeNodeManager.get(selDiv.PK);
		if(selObj.isExpand)
		{

			selObj.setExpand(false);
		}
		else
		{
			selObj.buildChildNode();
			selObj.setExpand(true);

		}
	}//

	//树节点节点选中事件
	else if(event.srcElement.id=="DBTree_label" )
	{


	   selDiv = event.srcElement;
	   selObj = g_DBTreeNodeManager.get(selDiv.PK);
	   rootObj = selObj.rootNode;
	   rootObj.curNodeValue=selObj.value;
	   rootObj.curNodeText=selObj.displayText;
       rootObj.curTreeNode=selObj;
       rootObj.pathArray=getNodePath(selObj,false,true);
	   rootObj.selRowSetRow = rootObj.treeModel.getRowSetRow(selObj.value);
       selObj.buildChildNode();
	   if(rootObj.isAllowDrag && selObj.treeNodeType!="root"){
	      var e =  event.srcElement;
		  var range = document.body.createTextRange();
		  range.moveToElementText(e);
	  range.select();
	  //window.event.cancelBubble = true;
	   }
	   //alert("rootObj.selRowSetRow="+rootObj.selRowSetRow);
	   //如果是根节点，并且不允许根节点触发事件
		if(!rootObj.isRootFireEvent && selObj.treeNodeType=="root")
		   {
			 return;

		   }

	   ///设置节点颜色;
	   var labelArray =rootObj.getUIObject().all.tags("LABEL");//document.all.tags("LABEL");
	   //alert("label.length="+labelArray.length);
	   for (var i=0; i< labelArray.length; i++)
		{

			if(labelArray.item(i) && labelArray.item(i).id=="DBTree_label")
			{
				labelArray.item(i).style.backgroundColor = "transparent";
			    labelArray.item(i).style.color = DBTREE_NODE_COLOR;
	    }
		}
	   event.srcElement.style.backgroundColor = DBTREE_NODE_BACKGROUD_COLOR;
	   event.srcElement.style.color = DBTREE_NODE_SEL_COLOR;






	   //alert("rootObj.id"+rootObj.id);
	  }
	 //右键事件else if(event.button==2)
       window.event.cancelBubble = true;
       window.event.returnValue = false;


}


function DBTreeCheckBoxClickFunc()
{

   //checkbox状态
	  if(event.srcElement.id=="DBTree_checkbox")
	  {
		var selDiv = event.srcElement;
        var selObj = g_DBTreeNodeManager.get(selDiv.PK);
        selObj.isInit =true;
		if(event.srcElement.checked)
		  {
			//alert("selObj.id="+selObj.id);
			selObj.setChecked("checked");
		  }
	   else
		  {
			selObj.setChecked("unchecked");
		  }

	  }
	 else if(event.srcElement.id=="DBTree_label" )
	 {
		  //树节点的点击事件
		  var selDiv = event.srcElement;
	      var selObj = g_DBTreeNodeManager.get(selDiv.PK);
	      rootObj = selObj.rootNode;
		   //如果是根节点，并且不允许根节点触发事件

		  if(!rootObj.isRootFireEvent && selObj.treeNodeType=="root")
		   {

			 return;

		   }

			 if(rootObj.isSameNodeFireEvent)
				{


					//如果是根节点，并且不允许根节点触发事件
					if(rootObj.isRootFireEvent && selObj.treeNodeType=="root")
						{
							rootObj.fireListener(S_OnChange,rootObj,window.event);

						}
					else if(selObj.treeNodeType!="root")
					   {
					//如果允许文件夹触发事件的标志为true，则任何节点都可以发出事件。否则，只有叶子节点才能够发出事件

							if(rootObj.isFolderFireEvent )
								{

									rootObj.fireListener(S_OnChange,rootObj,window.event);

								}
								else
								{
									if(selObj.treeNodeType!="fold")
										rootObj.fireListener(S_OnChange,rootObj,window.event);
								}
					   }
				}
			   else
				{
				   if(rootObj.selTreeNodePath!=rootObj.pathArray.join())
						{
							//如果是根节点，并且不允许根节点触发事件
							if(rootObj.isRootFireEvent && selObj.treeNodeType=="root")
								{
									rootObj.fireListener(S_OnChange,rootObj,window.event);

								}
			    else if(selObj.treeNodeType!="root")
							   {
									//如果允许文件夹触发事件的标志为true，则任何节点都可以发出事件。否则，只有叶子节点才能够发出事件
									if(rootObj.isFolderFireEvent)
										{

											rootObj.fireListener(S_OnChange,rootObj,window.event);

										}
									else
										{
											if(selObj.treeNodeType!="fold")
												rootObj.fireListener(S_OnChange,rootObj,window.event);
										}
							   }

						}

				}//end outest if-else
			rootObj.selTreeNodePath=rootObj.pathArray.join();

      
	 }
      window.event.cancelBubble = true;
      //window.event.returnValue = false;
}

//菜单相关的函数
//菜单相关的函数
function DBTreeRightClickFunc()
{
   if(event.srcElement.id=="DBTree_checkbox" || event.srcElement.id=="DBTree_label")
	{
	  // alert("right click ok");
	   var selDiv = event.srcElement;
	   var selObj = g_DBTreeNodeManager.get(selDiv.PK);
	   //获取根对象，
	   var rootObj = selObj.rootNode;
	   //如果是根节点，并且不允许根节点触发事件
	   if(!rootObj.isRootFireEvent && selObj.treeNodeType=="root")
		   {
			 return;

		   }

	   if(selObj.rootNode.isShowMenu && selObj.rootNode.popMenuFuncName!="")
		{
	  //alert(selObj.rootNode.popMenuFuncName);
		  //eval(selObj.rootNode.popMenuFuncName+"()");
		  eval(selObj.rootNode.popMenuFuncName+"('"+selObj.value+"','"+selObj.displayText+"')");

		}

	}
   window.event.returnValue = false;
   return false;
}

/*
function hideDBTreeMenu()
{
   var menuID = document.all.item("DBTreeMenu");
   if(menuID)
	menuID.style.visibility="hidden";
}
*/

/*************************全局函数*********************************************/
var g_DBTreeNodeManager = new DBTreeNodeManager();

function DBTreeNodeManager()
 {
	 this.DBTreeNodeList = new Array();
	 this.MaxId = 0;
	 this.getNewPK = function()
		 {
		  this.MaxId = this.MaxId + 1;
		  //alert("GridId" + this.MaxId);
		  return "DBTreeNodePK_" + this.MaxId;
	     }
	 this.push = function(pDBTreeNode)
		 {
		  this.DBTreeNodeList[pDBTreeNode.PK] = pDBTreeNode;
	     }
	 this.get = function(pk)
		 {
		  return this.DBTreeNodeList[pk];
	     }
     this.getTreeNodeList = function()
	     {
		   return this.DBTreeNodeList;
	     }

  }

/******************************************************************************/

/*--------------------end of tree-----------------------------------------------*/


/*------------------------------------------------------------------*/
/*树模型节点类.将rowset构造为tree的结构,供DBTree使用                 */
/*------------------------------------------------------------------*/
//树节点类
function Node(value, displayText)
{
	this.value = value;
	this.displayText = displayText;
	this.childrenArray = new Array();//子节点数组
	this.nC = 0 //child个数
	this.nodeParent = null;

	this.whichRow = 0;//该节点对应于RowSet的第几行数据。
	this.pkVal=""; //标示在分层结构中该节点的层次值。
	this.parentPK="";//标示在分层结构中该节点父节点的层次值
	this.addChild = addChild;
	this.delChild = delChild;
	this.isSameChild=isSameChild;
	this.clearChild = clearChild;


	/*******************************************************/
	/*函数说明：增加一个子节点
    /*输入参数：childNode:节点类
	/*输出参数：无
	/*******************************************************/

	function addChild(childNode)
	{
		childNode.nodeParent = this;
	this.childrenArray[this.nC] = childNode;
		this.nC++;


	}


	function delChild(childNodeId)
	{

	   for(var i=0;i<this.childrenArray.length;i++)
		{
		   if(this.childrenArray[i].value == childNodeId)
			{
	      if(i<this.childrenArray.length-1 && i>0)
				{

				  var tmpNode = this.childrenArray[i];
				  this.childrenArray[i] = this.childrenArray[this.childrenArray.length-1];
				  this.childrenArray[this.childrenArray.length-1] = tmpNode;
				  this.childrenArray.pop();
				  this.nC--;
				}
	      else if(i==0)
		{
		  this.childrenArray.shift();
		  this.nC--;
				}
	      else if(i==this.childrenArray.length-1)
				{
		  this.childrenArray.pop();
				  this.nC--;
				}
	      break;
			}
		}
	}

	/*******************************************************/
	/*函数说明：判断node的子节点中是否有与提供的参数节点相同的节点。
    /*输入参数：childNode：要比较的节点类
	/*输出参数：如果没有相同节点，返回－1，否则返回相同节点的数组索引值。
	/*******************************************************/

	function isSameChild(childNode)
	{

		var val=-1;
		for (var i=(this.nC-1);i>=0; i--)
			{
				if(this.childrenArray[i].value==childNode.value)
				{
					val=i;
					break;
				}
			}
       return val;

	}

	function clearChild()
	{
		this.childrenArray.length = 0;
		this.nC = 0;
	}


}

/*---------------------end Model Node------------------------------------------------------*/




/*----------------------------DBTreeHiberarchyModel.js----------------------------------------*/
/*文件名称：DBTreeHiberarchyModel.js
 *说明：对DataRow数据集根据用户提供的两个父子列进行分层构建。构造一棵按要求分层的树形Model.供DBTree调用。
  综述：
	该Model的主要作用是接受DataRowSet对象。指定数据集dataRowSet，父子层次关系列，树节点值列，树节点显示列。
	  就可以调用DBTree将树形结构显示。
  使用说明：
	1。直接调用工厂类函数，即可生成相应的Model。
		如：
		var model = createDBTreeHiberarchyModel("root","bofile","0",gRowSet,0,1,"0,2");
		var tree = new DBTree(model);

/****************************************************************************/


/****************************************************************************/
/*函数说明：产生一个DBTreeHiberarchyModel对象的工厂类。
/*输入参数：rootId			根节点的value
			rootText		根节点的显示值
			rootVal			根节点的层次值
			dataRowSet		数据集对象;
	    valueColName		列名，定义该列的为树节点的值
			displayColName	列名，定义该列为树节点的显示文本
			hiberarchyCols	列名，指定两列为层次列。以“,”分隔,依次为父层次列,子层次列；
/*输出参数：返回DBTreeHiberarchyModel对象
/*******************************************************/
function createDBTreeHiberarchyModel(rootId,rootText,dataRowSet,valueColName,displayColName,hiberarchyCols)
    {
		var pRootId = rootId;
		//var pRootPkVal=rootPkVal;
		var pRootPkVal = rootId;
		if(pRootId==null || pRootId=="")
			pRootId = rootText;
		if(pRootPkVal==null || pRootPkVal=="")
			pRootPkVal =rootText;
	//alert(pRootId+","+pRootPkVal);


		var dBTreeHiberarchyModel= new DBTreeHiberarchyModel(pRootId,rootText,pRootPkVal);
		dBTreeHiberarchyModel.loadData(dataRowSet,valueColName,displayColName,hiberarchyCols);
		return dBTreeHiberarchyModel;
    }

/****************************************************************************/
/*函数说明：DBTreeHiberarchyModel类定义。供DBTree调用
/*输入参数：rootId			根节点的value
			rootText		根节点的显示值
			rootPkVal		根节点的层次值
/*输出参数：返回DBTreeHiberarchyModel对象
/*******************************************************/

function DBTreeHiberarchyModel(rootId,rootText,rootPkVal)
{
	this.rootNode=new Node(rootId,rootText);


	this.rootNode.pkVal = rootId;


	this.dataRowSet = null;

	this.valueColName = null;

	this.displayColName = null;

	this.hiberarchyCols = null;

	this.loadData = loadHiberarchyModelData;

	this.nodeArray=null;
    //根据一个节点获取所有节点的value或者text;flag =1返回val数组，2－返回text数组
	this.childArray=null;
	this.getAllChildren= function(selNode,flag)
				{
				       if(selNode!=null)
								{

								  if(flag==1)
									 this.childArray[this.childArray.length]=selNode.value;
								  else if(flag ==2)
				     this.childArray[this.childArray.length]=selNode.displayText;
								  var tmpNode = selNode;
								  for(var i=0;i<tmpNode.nC;i++)
									{
									  //alert("cursion tmpNodetmpNode.childrenArray[i]"+tmpNode.childrenArray[i].value);
									  this.getAllChildren(tmpNode.childrenArray[i],flag);

									}
								}

				}

	/********************标准接口************************************ */
	this.getRootVal = function getRootVal(){ return this.rootNode.value;}

	this.getRootText = function getRootText(){return this.rootNode.displayText;}

	this.getText = function getText(id)
				    {
				      if(id==null || id=="") return null;
							  var node = this.nodeArray.get(id);
							  if(node!=null)
								{
								  return node.displayText;
								}
			      else
								{
								  return null;
								}
				}

	this.getChildrenCount = function getChildrenCount(id)
							{
								if(id==null || id=="") return 0;

								var node = this.nodeArray.get(id);
								//alert("in getChildrenCount,id="+id+" node="+node+" nC="+node.nC);
								if(node!=null)
								  return node.nC;
								else
								  return 0;
							}
	this.getChildrenText = function getChildrenText(id)
							{
								if(id==null || id=="") return null;
								var node = this.nodeArray.get(id);
				var textArray = new Array();
								if(node!=null)
								{
								  for(var j=0;j<node.nC;j++)
								   {
								    textArray[textArray.length]=node.childrenArray[j].displayText;
								   }
								}
								return textArray;
							}
	this.getChildrenVal = function getChildrenVal(id)
							{
								if(id==null || id=="") return null;
								var node = this.nodeArray.get(id);
				var valueArray = new Array();
								if(node!=null)
								{
								  //alert(node.value+","+node.nC);
								  for(var j=0;j<node.nC;j++)
								   {
								    valueArray[valueArray.length]=node.childrenArray[j].value;
								   }
								}
								return valueArray;
							}
    this.getAllChildrenVals = function(id)
			       {
				      if(id==null || id=="") return null;
							  var node = this.nodeArray.get(id);
							  if(node!=null)
							   {
								   this.childArray = new Array();
								   this.getAllChildren(node,1);
							   }
							  return this.childArray;
			       }
	this.getRowSetRow = function(id)
				{


							   if(id==null || id=="") return -1;
							   var node = this.nodeArray.get(id);
							   if(node!=null)
							    {
								   return node.whichRow;
								}
			       else
				{
								  return -1;
								  /*for(var i=this.dataRowSet.count();i>=0;i--)
								  {
								    if
								  }*/
								}
				}
     this.getAllVals = function()
				{

							   var node = this.nodeArray.get(this.rootNode.value);
							   if(node!=null)
							   {
								   this.childArray = new Array();
								   this.getAllChildren(node,1);
							   }
							   return this.childArray;
				    }
    this.getAllTexts = function()
				{

							   var node = this.nodeArray.get(this.rootNode.value);
							   if(node!=null)
							   {
								   this.childArray = new Array();
								   this.getAllChildren(node,2);
							   }
							   return this.childArray;
				}
    this.addChildNode = function(parentId,id,text)
			       {
				     var node = this.nodeArray.get(parentId);

							 if(node!=null && node!="null")
							   {
				  var childNode = new Node(id,text);
								  if(node.isSameChild(childNode)==-1)
								   {
									  node.addChild(childNode);
									  this.nodeArray.push(id,childNode);
									  childNode.nodeParent = node;
								   }
							   }

			       }
    this.delNode = function(pId)
			       {
							  if(pId==null || pId =="") return;
							  var node = this.nodeArray.get(pId);
							  if(node!=null)
							   {
								  var parentNode = node.nodeParent;
				  parentNode.delChild(pId);
								  this.nodeArray[pId] = null;

							   }
			       }
	this.refreshModel = function(pTreeId,parameters,qryset){
				    var  tUrl =  _gModuleName + "/dbtreerefresh?action=refresh&pk="+pTreeId;
							if(parameters)
							  tUrl = tUrl + "&" + parameters;
							var tmpstr  = "<RootInfo>"
							if(qryset != null)
								tmpstr = tmpstr + qryset.toXmlString(false);
							tmpstr = tmpstr   + "</RootInfo>";
							var dataRowSetObj = g_NormalRowSetManager.create(pTreeId+"_RowSet",tUrl);
							this.rootNode.clearChild();

							this.dataRowSet = null;

							this.loadData(dataRowSetObj,this.valueColName,this.displayColName,this.hiberarchyCols);

						}
	/************************end of public interface****************************/

}

/****************************************************************************/
/*函数说明：将dataRowSet数据构造为treeModel
/*输入参数：dataRowSet		数据集对象;
	    valueColName		列名，定义该列的为树节点的值
			displayColName	列名，定义该列为树节点的显示文本
			hiberarchyCols	列名，指定两列为层次列。以“,”分隔；
/*输出参数：返回rootNode对象
/*******************************************************/

function loadHiberarchyModelData(dataRowSet,nValueColName,nDisplayColName,hiberarchyCols)
{

	if(this.dataRowSet!=null) this.dataRowSet = null;

	this.dataRowSet = dataRowSet;

	this.valueColName = nValueColName;

	this.displayColName = nDisplayColName;

	this.hiberarchyCols = hiberarchyCols;
		//获取层次列号的数组
	var valueColName = nValueColName;
	var displayColName =nDisplayColName;
	var hiberarchyArray = hiberarchyCols.split(",");

	if(hiberarchyArray==null || hiberarchyArray.length!=2)
	{
		alert("树节点的层次列不符合规范");
		return;
	}
	 //Node数组
	if(this.nodeArray!=null){
	  this.nodeArray.clear();

	}
	this.nodeArray=new NodeHashArray();

	var backupArray = new Array();



	//在nodeArray中插入根节点
	this.nodeArray.push(this.rootNode.value,this.rootNode);

		//获取数据集的行数
	var rowcount = dataRowSet.count();
	//	alert("rowcount="+rowcount);
	//alert("nodeArray length="+this.nodeArray.getArray.length);

	//alert(" valueColName="+valueColName+" displayColName="+displayColName+" hiberarchyArray="+hiberarchyArray.join());
	var newNode = null;
	var parentPKVal = null;
	for(var i=0;i<rowcount;i++)
	{

		//alert("i="+i+" valueColName="+valueColName+" displayColName="+displayColName);
		//如果为value或者displayText为null，不加入树结构
		if(dataRowSet.getValue(i,valueColName)=="" || dataRowSet.getDisplayText(i,displayColName)=="")
				continue;
		newNode = new Node(dataRowSet.getValue(i,valueColName),dataRowSet.getDisplayText(i,displayColName));


		  //设定当前节点的whichRow属性，该属性说明Node对应于rowset的哪一行
		newNode.whichRow=i;

		  //取得节点层次Id值.
		newNode.pkVal = this.value;//dataRowSet.getValue(i,hiberarchyArray[1]);



	      //取得父节点值
		parentPKVal = dataRowSet.getValue(i,hiberarchyArray[0]);
		  //alert("line 11317:parentPKVal="+parentPKVal+" i="+i);
		  //如果父节点Id为null,设定它的父亲为根节点
		if(new String(parentPKVal)==null || new String(parentPKVal)=="" || new String(parentPKVal).toUpperCase()=="NULL")
		{
			//alert("line 11319:root.pkVal="+this.rootNode.pkVal);
			parentPKVal = this.rootNode.pkVal;
		}

		newNode.parentPK=parentPKVal;


		  //join the new node to nodeArray
		this.nodeArray.push(newNode.value,newNode);

		  //get the parent of the new node
		var parentNode = this.nodeArray.get(parentPKVal);
		if(parentNode!=null)
		{
			parentNode.addChild(newNode);


		}
		else
		{
			 //the node that no parent will store in the backupArray
			backupArray[backupArray.length] = newNode;

		}
	}//end of for


	//再次尝试将backup数组中的无父节点数组向树中插。
	//如果仍然没有父亲，就直接设置该节点的父亲为根节点
	for(var j=0;j<backupArray.length;j++)
	{

		var backNode = backupArray[j];
		parentNode = this.nodeArray.get(backNode.parentPK);
		if(parentNode!=null)
		{
		 parentNode.addChild(backNode);
		}
		else
		{
		  this.rootNode.addChild(backNode);
		}

	}


}

/*******************************************************/
/*函数说明：node数组
/****************************************************/
function NodeHashArray()
 {
	 this.nodeHashTable = new Array();
     this.push = function(pKey,pObj)
		 {
		    if(pKey==null || pObj==null)
				return;
			var key = new String(pKey);
			this.nodeHashTable[key] = pObj;
	     }
	 this.get = function(pKey)
		 {
		   if(pKey==null)
	      return null;
		   var key = new String(pKey);
		   if(this.nodeHashTable[key])
		     return this.nodeHashTable[pKey];
		   else
			 return null;
	     }
     this.getArray = function()
	     {
		   return this.nodeHashTable;
	     }
     this.clear = function()
	     {
		   this.nodeHashTable.length = 0;
		   this.nodeHashTable=new Array();

	     }

  }

/*----------------------------------end dbtreeModel-------------------------------*/
//----------------DBTreeNode.js------------------

/*******************************************************/
/*函数说明：树显示节点类
/*输入参数：
/*输出参数：
/****************************************************/

//图片变量配置变量
var imgHEADc =_gModuleName +"/jsv2/image/tree_pic/homepage.gif";//根节点colse的图片
var imgHEADo =_gModuleName +"/jsv2/image/tree_pic/homepage.gif";//根节点open的图片

var imgFoldo =_gModuleName + "/jsv2/image/tree_pic/fold_o.gif";//分支节点open的图片
var imgFoldc =_gModuleName + "/jsv2/image/tree_pic/fold_c.gif";//分支节点close的图片

var imgLeafc=_gModuleName + "/jsv2/image/tree_pic/leaf_c.gif";
var imgLeafo=_gModuleName + "/jsv2/image/tree_pic/leaf_o.gif";

//颜色变量配置
var DBTREE_NODE_SEL_COLOR = "#1F469F"; //树节点被选中的颜色
var DBTREE_NODE_COLOR = "#000000";   //树节点未选中的颜色
var DBTREE_NODE_BACKGROUD_COLOR= "#FFE99B"; //树节点背景色;

//子节点相对于父亲节点的位偏移量
var OFFSET_WIDTH =18;
//节点之间的间距
var OFFSET_HEIGHT = 22;

function createDBTreeNodeClassFactory(nValue,nDisplayText,nDeep,nRoot,nNodeType,nDiv)
{
    var dbTreeNodeClass = new DBTreeNodeClass(nValue,nDisplayText,nDeep,nRoot,nNodeType,nDiv);
	dbTreeNodeClass.buildNode();
	return dbTreeNodeClass;
}

function DBTreeNodeClass(nValue,nDisplayText,nDeep,nRoot,nNodeType,nDiv)
{
	this.PK = g_DBTreeNodeManager.getNewPK();
    g_DBTreeNodeManager.push(this);
	if(nDiv)
		this.UIObject = nDiv;
	else
	{
		this.UIObject = document.createElement("div");

	}
	this.value = nValue;
	this.displayText = nDisplayText;

	this.UIObject.value=this.value;
	this.UIObject.displayText=this.displayText;
    this.UIObject.PK=this.PK;
	this.UIObject.id = "DBTreeNode_"+this.value;
	this.UIObject.style.display="none";
	this.UIObject.style.position = "relative";



	//this.style="position:relative;visibility:hidden";

	this.isInit = false;//是否初始化标志
    this.isVisible =false;
	this.isExpand=false;//是否扩展标志

	this.rootNode = nRoot;

	this.treeNodeType=nNodeType;

	this.deep = nDeep/*表示节点的层深*/

	this.isLastTreeNode = true //如果是最后一个节点，值为true。否则为false

	this.childrenArray = new Array();//子treeNode节点数组
	this.nC = 0 //child个数
	this.nodeParent = null;//父亲节点

    this.tiaoImgObj = null;//节点的线条显示对象
	this.nodeImgObj = null;//节点的显示img对象

	this.checkbox = null /*多选时指向checkbox*/
	this.checkSts ="unchecked";/*多选框的当前状态，有三种状态:checked:选中,unchecked-未选中,other-其子节点有未选中的。*/

	this.label=null;

	this.getUIObject = getUIObjectFunc;
	this.buildNode = buildTreeNodeFunc;/*将数据构造为div的显示对象*/
	this.buildChildNode = buildChildNodeFunc;/*构造该节点所属的孩子对象*/
	this.setTreeNodeType = setTreeNodeTypeFunc;/*设置节点的类型.内部使用*/

    this.addChildNodes = addChildNodesFunc; /*新增多个孩子节点treeNode对象*/
	this.addChildNode = addChildNodeFunc; /*新增孩子节点treeNode对象*/
	this.removeChildNode = removeChildNodeFunc; /*删除孩子节点对象*/
	this.remove         = removeFunc;          /*删除自身节点*/
    this.setTreeNodeValue = setTreeNodeValueFunc; /*设置树节点的value和displayText属性*/
	this.setTreeNodeText = setTreeNodeTextFunc;   /*设置树节点的displayText属性*/

	this.setSelected = setSelectedFunc;/*设置为选中*/

	this.setChecked = setMultiCheckStsFunc;/*设置多选时checkbox的状态*/
	//this.setChildrenNodeVisible = setChildrenNodeVisibleFunc;
	this.setVisible =setVisibleFunc;/*设置节点的是否可视*/
	this.setExpand  =setExpandFunc;/*设置节点的收缩和展开*/

	return this;

}

function getUIObjectFunc()
{
   return this.UIObject;
}

/*
   设置树节点类型
   pType="root","fold","leaf"分别表示根类型,文件夹类型,叶子类型
   pPos ="center","bottom"分别表示位于中间的节点还是位于最下面的节点.目前只对fold有用.
   pState="open","close" 表示节点状态是打开的还是关闭的.目前只对fold类型起作用
*/
function setTreeNodeTypeFunc(pType,pPos,pState)
{

	if(pType=="")
		pType=this.treeNodeType;
	if(pType=="root")
	{
      this.treeNodeType="root";
      this.nodeImgObj.src = imgHEADc;

	}
    else if(pType == "fold")
	{
       this.treeNodeType="fold";
	   if(pState=="open")
			{
	      if(this.nodeImgObj.src != imgFoldo)
			     this.nodeImgObj.src = imgFoldo;
			}
       else
	    {
	      if(this.nodeImgObj.src != imgFoldc)
			    this.nodeImgObj.src = imgFoldc;
			}



	}
	else if(pType == "leaf")
	{

	   this.treeNodeType="leaf";
	   if(pState!=null && pState=="open")
			{

		   if(this.nodeImgObj.src != imgLeafo)
			      this.nodeImgObj.src = imgLeafo;
			}
       else
			{

		  if(this.nodeImgObj.src != imgLeafc)
			     this.nodeImgObj.src = imgLeafc;
			}




	}
}


/*创建一个树的显示节点的方法*/
function  buildTreeNodeFunc()
{
	var htmStrArray = new Array();
	if((this.deep)>0)
	{
	    var tiaoImgWidth = (this.deep) * OFFSET_WIDTH;
	htmStrArray[htmStrArray.length]="<table height=0 border=0 cellspacing='0' cellpadding='0'><tr style=\"height:"+OFFSET_HEIGHT+"px;\"><td style='width:"+tiaoImgWidth+"px;cursor:default' NOWRAP></td>";
		//this.UIObject.innerHTML = "<TABLE><IMG align='absmiddle' lowsrc='"+imgTIAO+"' disabled='true' style='width:"+tiaoImgWidth+"px;height:"+OFFSET_HEIGHT+"px;cursor:default'></IMG>";
	}
	if(this.deep == 0)
	   {
			this.UIObject.style.display="block";
		this.UIObject.style.position="relative";
	    htmStrArray[htmStrArray.length]="<table height=0 border=0 cellspacing='0' cellpadding='0'><tr><td nowrap></td>";

	   }


	//节点图片对象
	htmStrArray[htmStrArray.length]="<td NOWRAP><input type=\"IMAGE\"  PK="+this.PK+" id = \"DBTree_node\" align=\"absmiddle\" style=\"cursor:default;width:16px;\" disabled=true/>";


    //checkbox
	if(this.rootNode.isMultiSelect)
	{
      htmStrArray[htmStrArray.length]="<input type=\"CHECKBOX\" PK="+this.PK+" id = \"DBTree_checkbox\" value="+this.value+" displayText="+this.displayText+" />";
	}

	//label
	if(this.treeNodeType!="root")
	{
      htmStrArray[htmStrArray.length]="<LABEL  PK="+this.PK+" id=\"DBTree_label\" class='p9'>"+this.displayText+"</LABEL>";
	}
	else
	{
	  htmStrArray[htmStrArray.length]="<LABEL  PK="+this.PK+" id=\"DBTree_label\" class='p9' style='font-weight:bold'>"+this.displayText+"</LABEL>";
	}


	htmStrArray[htmStrArray.length]="</td></tr></table>";
    this.UIObject.innerHTML="";
	this.UIObject.innerHTML=htmStrArray.join("");


	this.nodeImgObj = this.UIObject.all.item("DBTree_node");

    if(this.rootNode.isMultiSelect)
	{
	  this.checkbox = this.UIObject.all.item("DBTree_checkbox");
	}
	this.label = this.UIObject.all.item("DBTree_label");

	if(this.treeNodeType=="root")
	{
		this.setTreeNodeType("root","null","close");


	}
	if(this.treeNodeType=="fold")
	{
		this.setTreeNodeType("fold","bottom","close");

	}
	if(this.treeNodeType=="leaf")
	{
		this.setTreeNodeType("leaf","bottom","close");

	}




}






function buildChildNodeFunc()
{
   if(!this.isInit )
		 {

		   var childsVal = this.rootNode.treeModel.getChildrenVal(this.value);
	   var childsText = this.rootNode.treeModel.getChildrenText(this.value);
		   this.addChildNodes(childsVal,childsText);
		   this.isInit=true;
		 }
}




function removeFunc()
{
   if(this.nodeParent!=null)
	{

	   this.nodeParent.removeChildNode(this.value,this.displayText);
    }
}
//删除一个孩子节点
function removeChildNodeFunc(pValue,pText)
{

   if(this.nC==0) return;

      //将该节点从childrenArray数组中删除
   if(this.childrenArray[0].value == pValue && this.childrenArray[0].displayText == pText)
	{
	   //将该节点对应的对象从html中删除
	   this.UIObject.removeChild(this.childrenArray[0].getUIObject());
	   this.childrenArray.shift();

	}
   else if(this.childrenArray[(this.nC-1)].value == pValue && this.childrenArray[(this.nC-1)].displayText == pText)
    {
	//将该节点对应的对象从html中删除
	   this.UIObject.removeChild(this.childrenArray[this.nC-1].getUIObject());
		//如果要删除的节点是最后一个.删除后,他前面的那个节点要变为最后一个.
	   this.childrenArray.pop();

	}
   else
	{
	for(var i=0;i<this.nC;i++)
	     {
		   if(this.childrenArray[i].value == pValue && this.childrenArray[i].displayText == pText)
			{
			     //将该节点对应的对象从html中删除
			   this.UIObject.removeChild(this.childrenArray[i].getUIObject());
				//将要删除的节点赋值为第一个节点.将第一个节点删除
			    this.childrenArray[i] = this.childrenArray[0];
			    this.childrenArray.shift();

			   break;
			}
		 }
	}

	 //孩子节点个数减1
   this.nC = this.nC-1;


	//如果删除后子节点的个数为0.则父节点的图片要改变为叶子节点的图片
   if(this.nC==0)
	{
	   //alert("after del this.isLastTreeNode="+this.isLastTreeNode);
	   //如果该节点为根节点.其孩子节点即使删光了,它的图片都不变
	   if(this.treeNodeType=="root") return;
	   this.setTreeNodeType("leaf","","open");

	}


}//end

function addChildNodesFunc(pValueArray,pTextArray)
{
   if(pValueArray==null || pTextArray==null ) return;
   if(pValueArray.length && pValueArray.length==0) return;
   if(pTextArray.length && pTextArray.length==0 ) return;
   if(pValueArray.length!=pTextArray.length)
	{
	   alert("获取数据Value和Text数组的长度不一致");
	   return;
    }
   for(var i=0; i<pValueArray.length;i++)
	{
	   if(this.rootNode.treeModel.getChildrenCount(pValueArray[i])>0)
	      nChildNode = createDBTreeNodeClassFactory(pValueArray[i],pTextArray[i],this.deep+1,this.rootNode,"fold");
       else
	      nChildNode = createDBTreeNodeClassFactory(pValueArray[i],pTextArray[i],this.deep+1,this.rootNode,"leaf");
       nChildNode.nodeParent = this;
	   this.UIObject.appendChild(nChildNode.getUIObject());
	   this.childrenArray[this.nC++]=nChildNode;

       if(this.rootNode.isMultiSelect)
		 {

		   if(this.checkSts=="checked")
			 {
			   nChildNode.checkbox.checked =true;
			   nChildNode.checkSts="checked";
			 }
		   else
			 {
			   if(this.rootNode.MultiInitValArray!=null)
				 {
				   for(var j=0;j<this.rootNode.MultiInitValArray.length;j++)
					 {
						if(nChildNode.value==this.rootNode.MultiInitValArray[j])
						 {
							nChildNode.checkbox.checked =true;
							nChildNode.checkSts="checked";
							break;

						 }
					 }
				 }



			 }
		  if(this.rootNode.MultiInitCheckBoxDisabledArray!=null)
			   {
					  for(var m=0;m<this.rootNode.MultiInitCheckBoxDisabledArray.length;m++)
					{
						if(nChildNode.value == this.rootNode.MultiInitCheckBoxDisabledArray[m])
						{
							 nChildNode.checkbox.disabled = true;
							 break;
						}

					}

				   }
		 }


	}
	if(this.treeNodeType=="leaf" && this.nC>0)
	{
	   this.setTreeNodeType("fold","","close");
	}



}
function addChildNodeFunc(pValue,pText,pNodeType)
{
	if(pValue==null|| pText==null) return;
	if(pValue=="" || pText=="") return;
	if(pNodeType==null || pNodeType=="" ) pNodeType="leaf";
	var nChildNode = createDBTreeNodeClassFactory(pValue,pText,this.deep+1,this.rootNode,pNodeType);
	nChildNode.nodeParent = this;
	//alert("run here "+this.treeNodeType);
	if(this.treeNodeType=="leaf")
	{
		this.setTreeNodeType("fold","","close");

	}

	if(this.isExpand)
	{
		nChildNode.setVisible(this.isExpand);
	}

	//alert("IN ADDCHILD="+this.nC);
	//alert("int DBTreeNodeClass->addChildNodeFunc nChildNode.id="+nChildNode.id);
	this.UIObject.appendChild(nChildNode.getUIObject());
	this.childrenArray[this.nC++]=nChildNode;
	 return nChildNode;

}
/*设置树节点的value属性*/
function setTreeNodeValueFunc(pValue)
{
	 this.id = "DBTreeNodeClass_"+pValue;
	 this.value = pValue;
	 if(this.rootNode.isMultiSelect)
	 {
		this.checkbox.value = pValue;
	 }
    this.label.innerText=this.displayText;


}
 /*设置树节点的displayText属性*/
function setTreeNodeTextFunc(pText)
{

	this.displayText = pText;
	if(this.rootNode.isMultiSelect)
	 {
		this.checkbox.displayText=pText;

	 }
    this.label.innerText=pText;
}

function setSelectedFunc()
{

	   this.rootNode.curNodeValue=this.value;
	   this.rootNode.curNodeText=this.displayText;
       this.rootNode.curTreeNode=this;
       this.rootNode.pathArray=getNodePath(this,false,true);
	   this.rootNode.selRowSetRow = this.rootNode.treeModel.getRowSetRow(this.value);
       this.buildChildNode();
	//设置所有的LABEL的颜色为透明.设置本treeNode的label为选中的颜色.
	var labelArray =this.rootNode.getUIObject().all.tags("LABEL");
	for (var i=0; i< labelArray.length; i++)
		{

			if(labelArray.item(i) && labelArray.item(i).id=="DBTree_label")
			{
				labelArray.item(i).style.backgroundColor = "transparent";
			    labelArray.item(i).style.color = DBTREE_NODE_COLOR;
	    }
		}
	this.label.style.backgroundColor = DBTREE_NODE_BACKGROUD_COLOR;
	this.label.style.color = DBTREE_NODE_SEL_COLOR;
	if(this.rootNode.isSameNodeFireEvent)
				{

					//如果是根节点，并且不允许根节点触发事件
					if(this.rootNode.isRootFireEvent && this.treeNodeType=="root")
						{
							this.rootNode.fireListener(S_OnChange,this.rootNode,window.event);

						}
					else
					if(this.treeNodeType!="root")
					   {
					//如果允许文件夹触发事件的标志为true，则任何节点都可以发出事件。否则，只有叶子节点才能够发出事件
							if(this.rootNode.isFolderFireEvent )
								{

									this.rootNode.fireListener(S_OnChange,this.rootNode,window.event);

								}
								else
								{
									if(this.treeNodeType!="fold")
										this.rootNode.fireListener(S_OnChange,this.rootNode,window.event);
								}
					   }
				}
			   else
				{
				   if(this.rootNode.selTreeNodePath!=this.rootNode.pathArray.join())
						{
							//如果是根节点，并且不允许根节点触发事件
							if(this.rootNode.isRootFireEvent && this.treeNodeType=="root")
								{
									this.rootNode.fireListener(S_OnChange,this.rootNode,window.event);

								}
			    else
							if(this.treeNodeType!="root")
							   {
									//如果允许文件夹触发事件的标志为true，则任何节点都可以发出事件。否则，只有叶子节点才能够发出事件
									if(this.rootNode.isFolderFireEvent)
										{

											this.rootNode.fireListener(S_OnChange,this.rootNode,window.event);

										}
									else
										{
											if(this.treeNodeType!="fold")
												this.rootNode.fireListener(S_OnChange,this.rootNode,window.event);
										}
							   }

						}

				}//end outest if-else
		 this.rootNode.selTreeNodePath=this.rootNode.pathArray.join();



}

function setMultiCheckStsFunc(flag)// flag=checked选中 flag=unchecked 未选中 isClearFlag-如果有第二个参数，表示是否清除以前的checkbox的选中状态
{
  if(this.rootNode.isMultiSelect)
	{

	  if(arguments[1])
		{
		  var checkboxArray = this.rootNode.getUIObject().all.tags("INPUT");
		  for(var i=0;i<checkboxArray.length;i++)
			{
				//alert("checkboxArray.item(i).type"+checkboxArray.item(i).type)
			   if(checkboxArray.item(i).type=="checkbox" && checkboxArray.item(i).id=="DBTree_checkbox")
				 {
					if(checkboxArray.item(i).checked)
					{
						checkboxArray.item(i).checked=false;
						checkboxArray.item(i).checkSts="false";
					}
				 }
			}
		}
	  if(flag=="checked")
		{
		  //alert(" this.checkbox.checked" +this.checkbox.checked)
		  this.checkbox.checked =true;
		  this.checkSts="checked";

		  if(this.rootNode.isMultiRecursion )
			{
			  for(var i=0;i<this.nC;i++)
				{
				  this.childrenArray[i].setChecked("checked");

				}
			}
		}
	  else if(flag == "unchecked")
		{
		  this.checkbox.checked = false;
		  this.checkSts="unchecked";
		  //其父亲节点也取消选中
		  //alert("before check this.nodeParent="+this.nodeParent.checkbox.checked);
		  var parentObj = this.nodeParent;
		  while(parentObj!=null)
			{
				//alert("before checed parent.checkbox.check="+this.nodeParent.checkbox.checked)
				parentObj.checkbox.checked=false;
				parentObj.checkSts="unchecked";
				parentObj = parentObj.nodeParent;
	    }

		  if(this.rootNode.isMultiRecursion)
			{
			  if(this.isInit==false);
			   {
				  this.buildChildNode();
			   }
			  for(var i=0;i<this.nC;i++)
				{
				  this.childrenArray[i].setChecked("unchecked");

				}
			}
		}//end of else
      /*var parentObj = this.nodeParent;
	  while(parentObj!=null)
		{
	  for(var i=0;i<parentObj.childrenArray.length;i++)
			{
			  if()
			}
		}
    */

	}
}


function setVisibleFunc(nFlag)
{
	if(nFlag)
	{
		this.UIObject.style.display="block";
		this.isVisible=true;

	}
	else
	{
		this.UIObject.style.display="none";
		this.isVisible=false;

	}
}

function setExpandFunc(nFlag)
{
	if(this.treeNodeType=="leaf" || this.treeNodeType=="root")
		return ;

	this.isExpand = nFlag
	   if(this.isExpand)
	{
	  this.buildChildNode();
	  this.setTreeNodeType("fold","","open");


	}
	else
	{
	    this.setTreeNodeType("fold","","close");
	}
	for(var i=0;i<this.childrenArray.length;i++)
		{
	   this.childrenArray[i].setVisible(this.isExpand);
		}



}

function clearPageTreeCache(){
	var formxmls = document.getElementsByTagName("xml");
	var dbtreePks = new Array();
	for (var i = 0;i < formxmls.length;i++){
		if (formxmls[i].id.indexOf("_RowSetData") > -1){
			dbtreePks.push(formxmls[i].PK);
		}
	}
	if (dbtreePks.length > 0){
	    var XMLSender = new ActiveXObject("Microsoft.XMLHTTP");
	    XMLSender.Open("POST",_gModuleName + "/dbtreerefresh?action=clearobj&pks="+dbtreePks.join(";"),true);
	    XMLSender.setRequestHeader("Content-Type","multipart/form-data");
	    XMLSender.send(null);
	}
	window.detachEvent("onunload",clearPageTreeCache);
}

if (typeof(_isClearCacheObj)!="undefined" && _isClearCacheObj == "Y"){
	window.attachEvent("onunload",clearPageTreeCache);
}
