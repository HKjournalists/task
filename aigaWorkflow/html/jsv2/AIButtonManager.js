/** ��
 *���� �� �Ż�
 *ʱ�䣺2007-12-20
 *���ܣ��ṩ����button��ID����button��disabled
 *������
 * get(pk)������button��Ψһ��־ID��ȡbutton����
 * setDisabled(flag):���ð�ť״̬.flag��ֵΪtrue/false��
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
 *���������button�ϵ���ʽ�仯��
 *overObjΪ�������classTypeΪcss��ʽ
*/
function mouseOver(overObj, classType)
{
	overObj.className=classType;
}


/**
 *���������button�ϵ���ʽ�仯��
 *overObjΪ�������classTypeΪcss��ʽ
*/
function mouseOut(outObj, classType)
{
	outObj.className=classType;
}
