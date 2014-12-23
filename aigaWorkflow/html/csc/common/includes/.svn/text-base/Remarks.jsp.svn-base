<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/appframe2.tld" prefix="ai" %>
<%@include file="/csc/common/taglib.jsp"%>
<html>
	<body>
		<div id="remarks_pucker" >
			<div id="pucker">
				<table id="pucker_head" width="100%" height="10" style="padding: 0 0 0 0;margin: 0 0 0 0 ;">
					<tr onclick="onRemarks_HideShow()"  style="cursor:hand;"  >
			 			<td style="width:120;font-family:Arial, 黑体 10pt; padding: 0 5px 0 0;" align="right"><img style="vertical-align:middle;" src="<%=request.getContextPath()%>/csc/images/div/attach.gif">&nbsp;后续备注
						</td>
						<td align="center" width="20" >
							<a style="align: center;" href="###"> <img id="show_hide_ico_remarks" src="<%=request.getContextPath()%>/csc/images/pucker/show.png" name="show_hide_ico" border="0" alt="提示：展开/隐藏"></a>
						</td>
						<td align="right" id="" class="EXT_line_bottom">&nbsp;</td>
						<td align="right" id="btn_Add" class="EXT_line_bottom" style="display:none"  height="20" width="20"> 
							<a style="align: right;" href="###" onClick="openRemarkDialog('csc/common/includes/AddRemarks.jsp')"><img id="" src="<%=request.getContextPath()%>/csc/images/pucker/up.gif"  name="btn_addRemarks" border="0" alt="提示：新增备注"></a> 
						</td>
						<td align="right" id="btn_Update" class="EXT_line_bottom" style="display:none"  height="20" width="20"> 
							<a style="align: right;" href="###" onClick="openUpdateDialog('csc/common/includes/AddRemarks.jsp')"><img id="" src="<%=request.getContextPath()%>/csc/images/pucker/rela.gif"  name="btn_updateRemarks" border="0" alt="提示：修改备注"></a> 
						</td>
						<td align="right" id="btn_Delete" class="EXT_line_bottom" style="display:none"  height="20" width="20"> 
							<a style="align: right;" href="###" onClick="deleteRemarks()"><img id="" src="<%=request.getContextPath()%>/csc/images/pucker/del.gif"  name="btn_attDelete" border="0" alt="提示：删除备注"></a>
			           	</td>
					</tr>
				</table>
			</div>
			<div id="childRemarksRelat" style="display:none;" >
				<table align="center" width="100%">
					<tr>
						<td width="120">&nbsp;</td>
						<td>
							<ai:stable tableid="tblRemarks" setname="com.asiainfo.csc.common.web.SETReqRemarks"
					            invoke_type="service" initial="false" footdisplay="none"
					            invoke_name="com.asiainfo.csc.common.service.ReqRemarksSV" 
					            invoke_querymethod="queryReqRemarks(String objTag, String objType,int $STARTROWINDEX,int $ENDROWINDEX)"
					            invoke_countmethod="countReqRemarks(String objTag, String objType)"
					            editable="false" needrefresh="true" multiselect="false"
					            width="100%" height="80" rowheight="-1" pagesize="100" rowsequence="true"
					            ondbclick="" oncontextmenu="">				
								<ai:col fieldname="REMARK_ID"       visible="false"></ai:col>
								<ai:col fieldname="OBJ_TYPE"        visible="false"></ai:col>
								<ai:col fieldname="OBJ_TAG"      	visible="false"></ai:col>
								<ai:col fieldname="REMARKS" 	 	visible="true" width="500" ></ai:col>
								<ai:col fieldname="CREATE_TIME"     visible="true" width="100"></ai:col>
								<ai:col fieldname="CHANGE_TIME" 	visible="true" width="100"></ai:col>
							</ai:stable>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
	<script type="text/javascript">
	function getTblRemarks(){
		return g_TableRowSetManager.get("tblRemarks");
	}
	var objTag = "";
	var objType = 0;
	var type=0;
	function initRemarksList(_objNo, _objType,_type){
		objTag=_objNo;
		objType=_objType;
		type=_type;
		getTblRemarks().refresh(null, "objTag=" + objTag + "&objType=" + objType);
	}
	function refreshRemarksList(){
		getTblRemarks().refresh(null, "objTag=" + objTag + "&objType=" + objType);
		remarksCount();
	}
	
	function remarksCount(){
		var count=getTblRemarks().getTotalRowCount();
		if(count>0){
			document.getElementById("btn_Add").style.display = "block";
			document.getElementById("btn_Update").style.display = "block";
			document.getElementById("btn_Delete").style.display = "block";
		}else{
			document.getElementById("btn_Add").style.display = "block";
			document.getElementById("btn_Update").style.display = "none";
			document.getElementById("btn_Delete").style.display = "none";
		}
	}
	function onRemarks_HideShow(){
		if(type==0){
			if(document.getElementById('childRemarksRelat').style.display=='none'){
				document.getElementById('childRemarksRelat').style.display = 'block';
				document.getElementById('show_hide_ico_remarks').src="<%=request.getContextPath()%>/csc/images/pucker/hide.png";
			}else{
				document.getElementById('childRemarksRelat').style.display='none';
				document.getElementById('show_hide_ico_remarks').src="<%=request.getContextPath()%>/csc/images/pucker/show.png";
			}
		}else{
			if(document.getElementById('childRemarksRelat').style.display=='none'){
				remarksCount();
				document.getElementById('childRemarksRelat').style.display = 'block';
				document.getElementById('show_hide_ico_remarks').src="<%=request.getContextPath()%>/csc/images/pucker/hide.png";
				
			}else {
				document.getElementById('childRemarksRelat').style.display='none';
				document.getElementById("btn_Add").style.display = "none";
				document.getElementById("btn_Update").style.display = "none";
				document.getElementById("btn_Delete").style.display = "none";
				document.getElementById('show_hide_ico_remarks').src="<%=request.getContextPath()%>/csc/images/pucker/show.png";
			}
		}
	}
	
	function openRemarkDialog(url) {
		var remarkId="";
		url = "<%=request.getContextPath()%>/" + url + "?objTag=" + objTag + "&objType=" + objType+ "&remarkId=" + remarkId;
		width = '500px';     
		height = '300px';   
		window.showModalDialog(url,window,'dialogWidth='+width+';dialogHeight='+height+';toolbar=no;directories=no;status=no;menubar=no;scrollbars=no;resizable=yes;modal=no'); 
	
	}
	
	function openUpdateDialog(url) {
		var remarkId=getTblRemarks().getValue(getTblRemarks().getRow(),"REMARK_ID");
		if(remarkId.length==0){
			alert("请选中一条记录");
			return;
		}
		url = "<%=request.getContextPath()%>/" + url + "?remarkId=" + remarkId;
		width = '500px';     
		height = '300px';   
		window.showModalDialog(url,window,'dialogWidth='+width+';dialogHeight='+height+';toolbar=no;directories=no;status=no;menubar=no;scrollbars=no;resizable=yes;modal=no'); 
	
	}
	function deleteRemarks(){
		var remarkId=getTblRemarks().getValue(getTblRemarks().getRow(),"REMARK_ID");
		if(remarkId.length==0){
			alert("请选中一条记录");
			return;
		}else{
			if(!confirm('确认要删除选择的备注信息吗？')){
			return;
			}else{
				var url = "<%=request.getContextPath()%>/business/com.asiainfo.csc.common.web.RemarksAction?action=delRemarks&remarkId="+remarkId;
	    		var rtn = PostInfo(url,null);
	    		if(rtn.getValueByName('retVal')=='Y'){
	    			refreshRemarksList();
	    		}
    		}
		}
	}
	</script>
</html>