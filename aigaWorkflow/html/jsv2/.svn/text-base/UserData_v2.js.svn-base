/*******************************************************************************
    作者 ： guankun  guankun@asiainfo.com
   UserDataClass： 自定义数据集对象
    使用说明：
      1、创建：
	 createUserDataClass(aXmlNodem,isCreate)：根据xmlNode生成UserDataClass数据对象.isCreate--true：当aXmlNode为空的时候创建一个空的UserDataClass对象
      2、主要方法：
	 count：参数数量
	 getName(aIndex):根据索引获得参数名称
	 get(aIndex)：根据索引获取参数值
	 getValueByName(aParaName):获得参数aPara的值
	 clear():清楚参数
	 getClassName():返回类型名称"UserDataClass"
aXmlNode节点格式：<UD><p name="p1">v1</p><p name="p2">v2</p></UD>

      3.功能扩展add by zhongrui at 2005-10-21

	createNewUserDataClass()扩展功能，可直接创建空的UserData通过addData，
	removeData增加属性值，通过toXmlString生成xml
	xml格式<UD><p name="p1">v1</p><p name="p2">v2</p></UD>
	方法列表：
	定义
	var userDataObj = createNewUserDataClass();
	userDataObj.addData(pName,pVal)
	userDataObj.setData(pName,pVal,isCreate)
	userDataObj.remove(pName)
	userDataObj.toXmlString();
******************************************************************************/
function createUserDataClass(aXmlNode,isCreate)
{
  if (!aXmlNode && !isCreate) return null;
  return new UserDataClass(aXmlNode);
}

function createUserDataByXml(pXmlStr)
{
  var m_xml = new ActiveXObject("Msxml.DOMDocument");
   m_xml.async = false;
   m_xml.loadXML(pXmlStr);
   var m_XmlNode = m_xml.documentElement;
   return createUserDataClass(m_XmlNode);
}

function createNewUserDataClass()
{
  return new UserDataClass(null)
}



function UserDataClass(aXmlNode)
{
  this.List = null;
  this.initial(aXmlNode);
}
UserDataClass.prototype.count = UserDataClass_count;
UserDataClass.prototype.getName = UserDataClass_getName;
UserDataClass.prototype.getValue = UserDataClass_getValue;
UserDataClass.prototype.getValueByName = UserDataClass_getValueByName;
UserDataClass.prototype.getClassName = UserDataClass_getClassName;
UserDataClass.prototype.clear = UserDataClass_clear;
/**??????????????????***************/
UserDataClass.prototype.initial = UserDataClass_initial;
UserDataClass.prototype.add = UserDataClass_add;
UserDataClass.prototype.set = UserDataClass_set;
UserDataClass.prototype.remove = UserDataClass_remove;
UserDataClass.prototype.hasPara = UserDataClass_hasPara;
UserDataClass.prototype.getObject = UserDataClass_getObject;

UserDataClass.prototype.addData = UserDataClass_addData;
UserDataClass.prototype.toXmlString = UserDataClass_toXmlString;
UserDataClass.prototype.setData =  UserDataClass_setData;






function UserDataClass_initial(aXmlNode){
  if (aXmlNode == null) return;
  if (aXmlNode.childNodes == null) return;
  var tmpObj = null;
  for (var i=0;i<aXmlNode.childNodes.length;i++){
    tmpObj = new Object();
    if (aXmlNode.childNodes(i).attributes == null || aXmlNode.childNodes(i).attributes.getNamedItem("n") == null)
    {
      showMessage("运行期错误---UserDataClass_initial()","节点格式不合规范，缺少属性--n--(属性名称)");
      continue;
    }
    tmpObj.NAME = aXmlNode.childNodes(i).attributes.getNamedItem("n").nodeValue;
    tmpObj.VALUE = aXmlNode.childNodes(i).text;
     this.set(tmpObj,true);
  }
}

function UserDataClass_count(){
  if (this.List == null )
    return 0;
  else
    return this.List.length;
}

function UserDataClass_getName(aIndex){
  var tmpObj = this.getObject(aIndex);
  if (tmpObj)
    return tmpObj.NAME;
  else return null;
}

function UserDataClass_getValue(aIndex){
  var tmpObj = this.getObject(aIndex);
  if (tmpObj)
    return tmpObj.VALUE;
  else return null;
}

function UserDataClass_getValueByName(aParaName){
  var i = this.hasPara(aParaName);
  var tmpObj = this.getObject(i);
  if (tmpObj)
    return tmpObj.VALUE;
  else return null;
}

function UserDataClass_clear(){
  this.List = null;
}
function UserDataClass_getClassName(){
  return "UserDataClass";
}

function UserDataClass_add(aObject){
  if (aObject == null) return false;
  if (this.List == null){
    this.List = new Array() ;
    this.List[this.List.length] = (aObject);
    return true;
  }
  else{
    var i = this.hasPara(aObject.NAME);
    if (i == -1){
      this.List[this.List.length] = (aObject);
      return true;
    }
    else
      return false;
  }
}
function UserDataClass_set(aObject,isCreate){
  if (aObject == null) return false;
  var i = this.hasPara(aObject.NAME);

  if (i == -1){
    if (isCreate)
      return this.add(aObject);
    else
      return false;
  }else{
    this.List[i].VALUE = aObject.VALUE;
    return true;
  }
}

function UserDataClass_remove(pName){
  var idx  = this.hasPara(pName);
  if(idx>=0)
  {
    this.List.splice(idx,1);
  }

}

function UserDataClass_hasPara(aParaName){
  var ri = -1;
  if (this.List == null) return -1;
  if (aParaName == null) return -1;
  for (var i=0;i<this.count();i++){
    if (this.getName(i) != null && aParaName != null &&
	this.getName(i).toUpperCase() == aParaName.toUpperCase())
    {
	    ri = i;
	    break;
    }
  }
  return ri;
}

function UserDataClass_getObject(aIndex){
  if (this.List == null) return null;
  if (aIndex <0 || aIndex >= this.count()) return null;
  return this.List[aIndex];
}



/**
????
**/
function UserDataClass_addData(pName,pVal)
{
  if(pName==null || pName=="")
     return false;
  if(pVal==null) pVal = "";
  var obj = new Object();
  obj.NAME = pName;
  obj.VALUE = pVal;
  return this.add(obj);

}
function UserDataClass_setData(pName,pVal,isCreate)
{
  if(pName==null || pName=="")
     return false;
  if(pVal==null)
     pVal = "";
  var obj = new Object();
  obj.NAME = pName;
  obj.VALUE = pVal;

  return this.set(obj,isCreate);

}

function UserDataClass_toXmlString()
{
  if(this.List == null || this.List.length==0)
    return "";
  var reArray = new Array();
  reArray[reArray.length] = "<UD>";
  for(var i=0;i<this.List.length;i++)
  {
     reArray[reArray.length] = "<p n=\"";
     reArray[reArray.length] = g_CheckAndTransStr(this.List[i].NAME);
     reArray[reArray.length] ="\">";
     reArray[reArray.length] = g_CheckAndTransStr(this.List[i].VALUE);
     reArray[reArray.length] ="</p>";
  }
  reArray[reArray.length] = "</UD>";
  return reArray.join("");
}



