var contract_tid = 0;
var contract_dH = 0;
var contract_CurrentObj = null;

function AIContractFrame_OpenClose(id){
	contract_CurrentObj = document.all("stractFrame_UD_" + id);
	if(contract_CurrentObj == null){
	  alert("未能找到ContractFrame对象, 对象Id:" + id);
	  return;
	}
	
	event.returnValue =false;
	if (contract_CurrentObj.style.display==''){
		contract_dH =contract_CurrentObj.style.posHeight;
		AIContractFrame_closeMe();
  		document.all("stractFrame_UD_"+ id).className='t-tool-down'
  	} else{
		contract_CurrentObj.style.display='';
		AIContractFrame_openMe();
		document.all("stractFrame_UD_"+ id).className='t-tool-up'
	}
}

function AIContractFrame_closeMe(){
	if(contract_CurrentObj == null) return;
	
	var h = parseInt(contract_CurrentObj.style.height);
	if(h > 0){
		h = h - Math.ceil(h/2);
		contract_CurrentObj.style.height = h+"px";
	}
	else {
		contract_CurrentObj.style.display='none';
		window.clearTimeout(contract_tid);
		return false;
	}

	contract_tid = window.setTimeout("AIContractFrame_closeMe()");
}
 
function AIContractFrame_openMe(){
	if(contract_CurrentObj == null) return;
	var h = parseInt(contract_CurrentObj.style.height);
	if(h < contract_dH){
		h = h + Math.ceil((contract_dH-h)/2);
		contract_CurrentObj.style.height = h+"px";
	}
	else {
		window.clearTimeout(contract_tid);
		return false;
	}
	
	contract_tid = window.setTimeout("AIContractFrame_openMe()");
}