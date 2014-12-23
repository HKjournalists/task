function createDBTreeXmlModel(xmlStr,valueAttrName,displayTextAttrName,userObjectAttrName)
    {
		if(xmlStr!=null && xmlStr!=""){
			var xmlObject= new ActiveXObject("Msxml.DOMDocument");
            xmlObject.async = false;
            var isSuccess = xmlObject.loadXML(xmlStr);
			if (!isSuccess)
			 {
				alert("无法获取菜单信息,请检查:\n当前用户是否已经失效或者被管理员注销.\n网络连接是否正常.\n数据库运行是否正常");
				return null;
			 }
            var xmlNode = xmlObject.documentElement;
			var dBTreeXmlModel= new DBTreeXmlModel(xmlNode,valueAttrName,valueAttrName,displayTextAttrName,userObjectAttrName);
			return dBTreeXmlModel;
		}
		else{
		   alert("xml字符串为空或者Null");
		   return null;
		}

    }

/****************************************************************************/
/*函数说明：DBTreeXmlModel类定义。供DBTree调用.从xml中获取数据构造树结点。树的层次等同于xml结点的层次
/*输入参数：xmlNode         xmlDom结点对象
            nIdAttrName			根节点的id层次值
			nValueAttrName		根节点的value值
			nDisplayTextAttrName根节点的显示值
/*******************************************************/

function DBTreeXmlModel(xmlNode,nIdAttrName,nValueAttrName,nTextAttrName,userObjectAttrName)
{

	this.rootNode = null;
     //Node数组
	this.nodeArray=new NodeHashArray();

	this.userObjectArray = new Array();

	this.loadXmlData = loadXmlData;

    var rootId = xmlNode.attributes.getNamedItem(nIdAttrName).nodeValue;
	var rootVal = xmlNode.attributes.getNamedItem(nValueAttrName).nodeValue;
	var rootText = xmlNode.attributes.getNamedItem(nTextAttrName).nodeValue;
	
	if( rootText=="亚信固网运营支撑系统" ){
		rootText = "河南移动需求管理平台";
	}

	this.userObjectAttrNameArray = null;
	if(userObjectAttrName.indexOf(",")){
	  this.userObjectAttrNameArray = userObjectAttrName.split(",");
	}
	else{
	  this.userObjectAttrNameArray = new Array();
	  this.userObjectAttrNameArray[userObjectAttrNameArray.length] = userObjectAttrName;
	}

	//获取指定属性
	var userObj = new Array();
	for(var i=0;i<this.userObjectAttrNameArray.length;i++){
	  userObj[this.userObjectAttrNameArray[i]] =  xmlNode.attributes.getNamedItem(this.userObjectAttrNameArray[i]).nodeValue;

	}
	this.userObjectArray[rootVal] =userObj;


	this.rootNode = new Node(rootVal,rootText);
	this.rootNode.pkVal = rootId;

	this.nodeArray.push(this.rootNode.value,this.rootNode);

	for(var i=0;i<xmlNode.childNodes.length;i++){
      this.loadXmlData(this.rootNode,xmlNode.childNodes(i),nIdAttrName,nValueAttrName,nTextAttrName,userObjectAttrName);
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
								    textArray[textArray.length]=(node.childrenArray[j].displayText);
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
								    valueArray[valueArray.length] = node.childrenArray[j].value;
								   }
								}
								return valueArray;
							}
   this.getRowSetRow = function(id)
	                        {
                                return -1;
	                        }
   this.getUserObject = function(id,attrName)
	                        {
	                          if(id==null || id=="") return null;
							  if(attrName==null || attrName=="") return null;
							  var userObject = this.userObjectArray[id];
							  return userObject[attrName];
	                        }
  this.getAllVals = function(){
    var tmp = this.getChildrenVal(this.getRootVal());
    var result= this.getChildrenVal(this.getRootVal());
    
    while(tmp.length>0){
      var arr = this.getChildrenVal(tmp.pop());
      if(arr==null || arr.length==0)continue;
      result = result.concat(arr);
      tmp = tmp.concat(arr);
    }
    return result;
    
  }
  
  this.getAllChildrenVals = function(value){
    var tmp = this.getChildrenVal(value);
    var result= this.getChildrenVal(value);
    
    while(tmp.length>0){
      var arr = this.getChildrenVal(tmp.pop());
      if(arr==null || arr.length==0)continue;
      result = result.concat(arr);
      tmp = tmp.concat(arr);
    }
    return result;
    
  }
    /************************end of public interface****************************/

}

/****************************************************************************/
/*函数说明：将xml数据构造为treeModel.返回解析后的xml对象XmlSetClass
/*输入参数：xmlStr		xml字符串;
            idAttrName		属性名，定义该属性为树节点的id层次值
			valueAttrName     值属性名
			textAttrName	显示值数属性名，定义该属性为树节点的显示文本
/*输出参数：返回rootNode对象
/*******************************************************/

function loadXmlData(parentTreeNodeObj,nXmlNode,nIdAttrName,nValueAttrName,nTextAttrName,userObjectAttrName)
{
	var vId = nXmlNode.attributes.getNamedItem(nIdAttrName).nodeValue;
	var vVal = nXmlNode.attributes.getNamedItem(nValueAttrName).nodeValue;
	var vText = nXmlNode.attributes.getNamedItem(nTextAttrName).nodeValue;
	var userObj = new Array();
	for(var i=0;i<this.userObjectAttrNameArray.length;i++){
	  userObj[this.userObjectAttrNameArray[i]] =  nXmlNode.attributes.getNamedItem(this.userObjectAttrNameArray[i]).nodeValue;

	}
	this.userObjectArray[vVal] =userObj;
	var newNode = new Node(vVal,vText);

	parentTreeNodeObj.addChild(newNode);
    parentTreeNodeObj.pkVal = vId;

	this.nodeArray.push(newNode.value,newNode);

	for(var i=0;i<nXmlNode.childNodes.length;i++){
	   this.loadXmlData(newNode,nXmlNode.childNodes(i),nIdAttrName,nValueAttrName,nTextAttrName,userObjectAttrName);
	}








}



/*----------------------------------end dbtreeModel-------------------------------*/
