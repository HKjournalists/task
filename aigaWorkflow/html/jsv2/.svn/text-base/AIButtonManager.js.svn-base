/** 　
 *作者 ： 张华
 *时间：2007-12-20
 *功能：提供根据button的ID设置button的disabled
 *方法：
 * get(pk)：根据button的唯一标志ID获取button对象。
 * setDisabled(flag):设置按钮状态.flag的值为true/false。
**/
function AIButtonManager(){
	this.List = new Array();
 	this.push = function(aiButton){
    	this.List[aiButton.AIButtonPK] = aiButton;
    	return aiButton.AIButtonPK;
 	}
 	this.get = function(pk){
    	var result = this.List[pk];
    	if(!result){
       		result = new AIButton(pk);
    	}
    	return result;
 	}
 	this.remove = function(pk){
   		this.List[pk] = null;
 	}
}

var g_AIButtonManager = new AIButtonManager();

function AIButton(pk){
	this.AIButtonPK = pk;
	this.AIButton = document.getElementById(pk);
	this.OperatorAuthor = this.AIButton.OperatorAuthor;
	this.ParentNode = this.AIButton.parentNode;	
	g_AIButtonManager.push(this);
}
AIButton.prototype.setDisabled = AIButton_SetDisabled;
function AIButton_SetDisabled(flag){
	if(flag==false){
    	if(this.OperatorAuthor !=null && (this.OperatorAuthor==false || this.OperatorAuthor=='false')){
      		return;
    	}
    }
    this.AIButton.disabled = flag;
    //modify
    var temp = this.AIButton.className;
    var end = temp.toLowerCase().indexOf("-gray");
    if (flag && (end == -1)) {
    	end = this.AIButton.className.toLowerCase().indexOf("word")+ 4;
		this.AIButton.className = temp.substring(0, end) + "-gray";
	} else if (flag == false && end != -1) {
		end = this.AIButton.className.toLowerCase().indexOf("word")+ 4;
		this.AIButton.className = temp.substring(0, end);
	}
    
    /*********************
    if(flag==false)
    	this.ParentNode.className = "button";
    else
    	this.ParentNode.className = "button disable";
    **********************/
}

function AIButtonSetDisabled(flag){
	if(flag==false){
    	if(this.OperatorAuthor !=null && (this.OperatorAuthor==false || this.OperatorAuthor=='false')){
      		return;
    	}
    }
    this.disabled = flag;
    if(flag==false)
    	this.parentNode.className = "button";
    else
    	this.parentNode.className = "button disable";
}

/**
 *设置鼠标在button上的样式变化，
 *overObj为组件对象，classType为css样式
*/
function mouseOver(overObj, classType)
{
	overObj.className=classType;
}


/**
 *设置鼠标在button上的样式变化，
 *overObj为组件对象，classType为css样式
*/
function mouseOut(outObj, classType)
{
	outObj.className=classType;
}
