<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>

<!-- 弹出框 ，提示框 -->
<script language="JavaScript">
	function aialmPrompt(){
		var argleng = arguments.length;
		var info = arguments[0];
		//type --- alert(不用传值)  error（0） ok（1）
		var type = "alert";
		if(argleng==2){  type = arguments[1];}
		ymPrompt.setDefaultCfg({winAlpha:'0.8',maskAlpha:'0',maskAlphaColor:'#000'});
		//属性  useSlide:true(淡入淡出) //fixPosition:false  不随滚动条滚动
		if(type=="alert"){  ymPrompt.alert({message:info,titleBar:false,width:260,height:145,btn:[['确定']],useSlide:false,fixPosition:false});}
		if(type=="ok"){  ymPrompt.succeedInfo({message:info,titleBar:false,width:260,height:145,btn:[['确定']],useSlide:false,fixPosition:false});}
		if(type=="error"){  ymPrompt.errorInfo({message:info,titleBar:false,width:260,height:145,btn:[['确定']],useSlide:false,fixPosition:false});}
}
	function aialmWin(){
		var argleng = arguments.length;
		var info = arguments[0];
		var width = 800;
		var height = 450;
		if(argleng==3){
			width = arguments[1];
			height = arguments[2];
		}
		ymPrompt.setDefaultCfg({winAlpha:'0.8',maskAlpha:'0',maskAlphaColor:'#000'});
		ymPrompt.win({message:info,width:width,height:height,title:'信息展示', maxBtn:true,minBtn:true,iframe:true,fixPosition:false,useSlide:false});
	}
	
	function selectStaff()
	{
		//workflow 中的 环节名称
		var roleCode = arguments[0];
		var deepCnt =  arguments[2];
		var url = "";
		if(deepCnt=="" || deepCnt==null){
			url="<%=request.getContextPath()%>/csc/common/SelectStaff.jsp?type="+roleCode;
		}else{
			url="<%=request.getContextPath()%>/csc/common/SelectStaff.jsp?type="+roleCode+"&deepCnt="+deepCnt;
		}
		var returnData = window.showModalDialog(url,"org","scroll:no;resizable:no;status:no;dialogHeight:300px;dialogWidth:560px");
		return returnData;
	}
	
	function selectStaffByProject()
	{
		var roleCode = arguments[0];
		var staffId =  arguments[1];
		var projectCode =  arguments[2];
		var parentOrgId =  arguments[3];
		var chooseType=arguments[4];
		if(chooseType == null) {
			chooseType = "";
		}
		url="<%=request.getContextPath()%>/csc/common/SelectStaff.jsp?type="+roleCode+"&cur_userId="+staffId+"&projectCode="+projectCode+"&parentOrgId="+parentOrgId+"&chooseType="+chooseType;
		var returnData = window.showModalDialog(url,"org","scroll:no;resizable:no;status:no;dialogHeight:320px;dialogWidth:560px");
		return returnData;
	}
	
	function selectStaffsByProject()
	{
		
		var roleCode = arguments[0];
		var staffId =  arguments[1];
		var projectCode =  arguments[2];
		var parentOrgId =  arguments[3];
		var chooseType=arguments[4];
		url="<%=request.getContextPath()%>/csc/common/SelectMultiPsn.jsp?type="+roleCode+"&cur_userId="+staffId+"&projectCode="+projectCode+"&parentOrgId="+parentOrgId+"&chooseType="+chooseType;
		var returnData = window.showModalDialog(url,"org","scroll:no;resizable:no;status:no;dialogHeight:400px;dialogWidth:560px");
		return returnData;
	}

	function inputOpinion()
	{
		url="<%=request.getContextPath()%>/csc/req/PublicFile/InputOpinion.jsp";
		var returnData = window.showModalDialog(url,"org","scroll:no;resizable:no;status:no;dialogHeight:80px;dialogWidth:560px");
		return returnData;
	}
	
	function selectStaffByProjectNocode() {
		var staffId =  arguments[0];
		
		url="<%=request.getContextPath()%>/aialmJT/common/SelectStaffNoCode.jsp?staffId="+staffId;
		var returnData = window.showModalDialog(url,"org","scroll:no;resizable:no;status:no;dialogHeight:300px;dialogWidth:560px");
		return returnData;
	}

	
	//9-13 dxp 是否按钮的 confirm
	function noticeConfirm(msg)
	{     
	     function   window.confirm(str){  
		      str=   str.replace(/\'/g,   "'&   chr(39)   &'").replace(/\r\n/g,   "'&   VBCrLf   &'");  
		      execScript("n   =   msgbox('"+   str   +"', vbYesNo ,  '')",   "vbscript");  
		      return(n == 6);  
	     }
	     return window.confirm(msg);
	}
	
</script>
<%
String aiEdit_2cwmin = "150"; 
String aiEdit_3cw = "150";
String aiEdit_2X3cw = "300";
String aiEdit_4cw = "200";
String aiEdit_2cw = "100";
String aiEditArea_2cwmin = "300";
String aiEditArea_2cw = "595" ;
String aiEditArea_4cw = "700" ;
String aiEditArea_7cw = "850";
String aiEditArea_max_width = "840";
String aiEditArea_high_min = "40";
String aiEditArea_high_middle = "80";
String aiEditArea_high_max = "180";
int staffbtn_width = 21; 
String aiEdit_btn_3cw = (Integer.parseInt(aiEdit_3cw) - staffbtn_width)+"";
String aiEdit_btn_4cw = (Integer.parseInt(aiEdit_4cw) - staffbtn_width)+"";
String aiEdit_btn_2cw = (Integer.parseInt(aiEdit_2cw) - staffbtn_width)+"";
String aiEdit_btn_2cwmin = (Integer.parseInt(aiEdit_2cwmin) - staffbtn_width)+"";
%>