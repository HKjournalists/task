/*-----------��ʽ�޸ļ�¼:by hequ 2009-10-26��ƽ̨���������ʽ��---------------------*/

/*-----------ҳ�������ʽ-----------*/
BODY {font-family:Arial,"����";font-size:12px; margin: 0;padding:0; background-color:#FFFFFF; overflow:auto;SCROLLBAR-FACE-COLOR:#E3EAF2;SCROLLBAR-HIGHLIGHT-COLOR:#B9C9D6;SCROLLBAR-SHADOW-COLOR:#B9C9D6;SCROLLBAR-3DLIGHT-COLOR:#F8F9FD;SCROLLBAR-ARROW-COLOR:#B9C9D6;SCROLLBAR-TRACK-COLOR:#F8F9FD;SCROLLBAR-DARKSHADOW-COLOR:#F8F9FD;}
tr,td {font-family:Arial,"����";FONT-SIZE: 12px}
textarea {font-size:12px; background-color: #FFFFFF; color:#000000;  border:1 solid #97A0A4;}
select {font-size:12px;background-color: #FFFFFF;color:#000000;}
input{font-size:12px;color:#000000; background-color: #FFFFFF; border-width:0px; border-style:solid; border-color:#97A0A4;padding-top: 2px;padding-left: 3px;height: 20px;}
form {display: inline;}
.G-Table-NoData{ color:#FF0000;}
.progressWrapper {
	width: 240px;
	overflow: hidden;
	float: left;
}
td, p, li, th {
    font-family:"Tahoma", "����", "Helvetica", "sans-serif";
    font-size: 12px;
    color: #333;
    SCROLLBAR-FACE-COLOR:#E7EFFF; FONT-SIZE: 12px;
    SCROLLBAR-HIGHLIGHT-COLOR: #97A0A4;
    SCROLLBAR-SHADOW-COLOR:#97A0A4;
    SCROLLBAR-3DLIGHT-COLOR: #E7EFFF;
    SCROLLBAR-ARROW-COLOR: #023EEE;
    SCROLLBAR-TRACK-COLOR: #E4E6F8;
    SCROLLBAR-DARKSHADOW-COLOR: #E4E6F8;
}

/*-----------ҳ�治ͬ����λ�õĶ���-----------*/
.area_tab{ width:100%; text-align:center; padding-top:5px;}
.td_font{ width:100px; text-align:right;}
.td_button{ width:10%; text-align:center;}
.area_button{ width:100%; text-align:center; height:40px; padding-top:12px;}

/*-----------ҳ���л���������ʽ�Ķ���-----------*/
A:link {COLOR: #074E86; TEXT-DECORATION: none;}
A:visited {COLOR: #074E86; TEXT-DECORATION: none;}
a:active {COLOR: #074E86; text-decoration: none;}
A:hover {COLOR: #333; TEXT-DECORATION: none;}

/*-- 20130417 add --*/
input,select,textarea { font-family:Arial,Tahoma,"\5fae\8f6f\96c5\9ed1";}
.tableOK { border-collapse:collapse;}
.tableOK tr td,.tableOK tr th { border:1px #D3D3D3 solid;}
.tableOK tr th { background:#F1F1F1; height:22px; line-height:22px; text-align:center; color:#666; font-weight:normal;}
.tableOK tr td { line-height:26px;}
.borderNone { border:none;}
.tableOK tr td.hideThisTd {border:none; display: none;}

.tableOK_ins { border-collapse:collapse;}
.tableOK_ins tr td,{ border-style: none;}
.tableOK_ins tr td { line-height:26px;}

.bgTransparent { background:transparent;}
.oprite_area { height:26px; line-height:26px; background:url(<%=request.getContextPath()%>/csc/images/contractframe/contractframe_head.gif);}
.oprite_area em { font-style:normal; color:#204d84; font-weight:bold; padding-left:24px;}

.bigBtn { width:90px; height:26px; border:none; background:url(<%=request.getContextPath()%>/csc/images/opera_area/btn_bg_01.gif) no-repeat left top;
 color:#3f5a8f; font-size:12px;}

/*-----------AIButton��ʽ-----------*/
/*������ť*/
.btn-1word {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-2word {height:20px; width:48px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/2wordbtn_new.gif);}
.btn-3word {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-4word {height:20px; width:80px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/4wordbtn_new.gif);}
.btn-5word {height:20px; width:90px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/5wordbtn_new.gif);}
.btn-6word {height:20px; width:100px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/6wordbtn_new.gif);}
/*.btn-6word{
	border-RIGHT: #97A0A4 1px solid; 
	border-TOP: #97A0A4 1px solid; 
	border-LEFT: #97A0A4 1px solid; 
	border-BOTTOM: #97A0A4 1px solid;
	height:20px;
	font-size: 12px;
	color:#2F5188;
	background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);
}*/
.btn-7word {height:20px; width:110px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/7wordbtn_new.gif);}
.btn-8word {height:20px; width:120px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/8wordbtn_new.gif);}
.btn-9word {height:20px; width:130px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/11wordbtn_new.gif);}
.btn-10word {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-11word {height:20px; width:130px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/11wordbtn_new.gif);}
.btn-12word {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-13word {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-14word {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-15word {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-16word {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-17word {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-18word {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-19word {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-20word {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}

/*��껬��*/
.btn-1word-hover {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-2word-hover {height:20px; width:48px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/2wordbtn_new.gif);}
.btn-3word-hover {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-4word-hover {height:20px; width:80px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/4wordbtn_new.gif);}
.btn-5word-hover {height:20px; width:90px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/5wordbtn_new.gif);}
.btn-6word-hover {height:20px; width:100px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/6wordbtn_new.gif);}
/*.btn-6word{
	border-RIGHT: #97A0A4 1px solid; 
	border-TOP: #97A0A4 1px solid; 
	border-LEFT: #97A0A4 1px solid; 
	border-BOTTOM: #97A0A4 1px solid;
	height:20px;
	font-size: 12px;
	color:#2F5188;
	background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);
}*/
.btn-7word-hover {height:20px; width:110px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/7wordbtn_new.gif);}
.btn-8word-hover {height:20px; width:120px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/8wordbtn_new.gif);}
.btn-9word-hover {height:20px; width:130px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/11wordbtn_new.gif);}
.btn-10word-hover {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-11word-hover {height:20px; width:130px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/11wordbtn_new.gif);}
.btn-12word-hover {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-13word-hover {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-14word-hover {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-15word-hover {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-16word-hover {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-17word-hover {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-18word-hover {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-19word-hover {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-20word-hover {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}

/*��ɫ��ť*/
.btn-1word-gray{border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-2word-gray{height:20px; width:48px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/2wordbtn_new.gif);}
.btn-3word-gray{border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-4word-gray{height:20px; width:80px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/4wordbtn_new.gif);}
.btn-5word-gray{height:20px; width:90px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/5wordbtn_new.gif);}
.btn-6word-gray {height:20px; width:100px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/6wordbtn_new.gif);}
/*.btn-6word{
	border-RIGHT: #97A0A4 1px solid; 
	border-TOP: #97A0A4 1px solid; 
	border-LEFT: #97A0A4 1px solid; 
	border-BOTTOM: #97A0A4 1px solid;
	height:20px;
	font-size: 12px;
	color:#2F5188;
	background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);
}*/
.btn-7word-gray {height:20px; width:110px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/7wordbtn_new.gif);}
.btn-8word-gray {height:20px; width:120px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/8wordbtn_new.gif);}
.btn-9word-gray {height:20px; width:130px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/11wordbtn_new.gif);}
.btn-10word-gray {border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-11word-gray {height:20px; width:130px; font-size:12px; color:#405A91; background:url(<%=request.getContextPath()%>/jsv2/image/button/11wordbtn_new.gif);}
.btn-12word-gray{border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-13word-gray{border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-14word-gray{border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-15word-gray{border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-16word-gray{border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-17word-gray{border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-18word-gray{border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-19word-gray{border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}
.btn-20word-gray{border: 1 solid #97A0A4;height:20px;font-size: 12px;color:#2F5188;background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);}

/*-----------CrossGrid��ʽ-----------*/
/*���̶���ͷ̧ͷ������ʽ*/
.CrossGridRowHead_Name{BACKGROUND-COLOR: #ffdddd;}
/*���̶���ͷ��ֵ������ʽ*/
.CrossGridRowHead_Value{BACKGROUND-COLOR: #efe1ff;}
/*���̶���ͷ����ʽ*/
.CrossGridColHead{BACKGROUND-COLOR: #ecffec;}
/* ����������ʽ*/
.CrossGrid_Data{BACKGROUND-COLOR: #FFFFFF;}
/* ѡ����/����ʽ*/
.CrossGrid_Row{BACKGROUND-COLOR: #c4ccff;}

/*-----------DBGrid ��ʽ-----------*/
.td_hover{background-color:#E5EFF8;color:#013299;}
.title_hover{height:20px;color:#5371BA;font-weight:bold;text-align:center;border:#B9C9D6 solid;border-width:0 1 1 0;background-color:#E3EAF2;display:block;}
/*�����������ʽ*/
.G-TableOuterDiv{border: 1px solid #B9C9D6;background:#F7F8FA;}
.G-TableHead{height:20px;color:#5371BA;font-weight:;TABLE-LAYOUT: fixed;border-COLLAPSE: collapse;background-color:#E3EAF2;display:block;}
/*�������������ʽ*/
.G-TableBody{border:#B9C9D6;background-color:#E1EDFA;}
/*����������ʽ*/
.G-TableFoot{background-color:#E3EAF2;border:#B9C9D6 solid;border-width:0 1 1 1;height:27px;}
/*���ͷ������ʽ*/
.GH-Head{height:20px;color:#5371BA;text-align:center;border:#B9C9D6 solid;border-width:0 1 0 0;background:#E3EAF2;}
/*���ͷTR��ʽ*/
.GH-TR{} 
/*���ͷTD��ʽ*/
.GH-TD{height:20px;color:#5371BA;text-align:center;border:#B9C9D6 solid;border-width:0 1 1 0;background-color:#E3EAF2;display:block;}
/*�ϼ�����ʽ*/
.GD-Total-TR{border:#B9C9D6 solid;border-width:0 1 1 0;color:#013299;}
/*�ϼ��е�Ԫ����ʽ*/
.GD-Total-TD{border:#B9C9D6 solid;border-width:0 1 1 0;color:#013299;}  
/*��������ж�ѡ��Ԫ����ʽ*/
.GD-S{width:24px;border:#B9C9D6 solid;border-width:0 1 1 0;display:block;}
/*���ͷ��ѡ��Ԫ����ʽ*/
.GH-S{height:20px;width:24px;color:#000000;border:#B9C9D6 solid;border-width:0 1 1 0;TABLE-LAYOUT: fixed;border-COLLAPSE: collapse;background-color:#E3EAF2;display:block;}
/*���ͷ�Ķ�ѡCheckbox��ʽ*/
.GH-S-C{border:0;width:24px;}
/*��������еĶ�ѡCheckbox��ʽ*/
.GD-S-C{border:0;}
/*���ͷ�����*/
.GH-Seq{height:20px;width:30px;color:#5371BA;text-align:center;font-weight:bold;border:#B9C9D6 solid;border-width:0 1 1 0;TABLE-LAYOUT: fixed;border-COLLAPSE: collapse;background-color:#E3EAF2;display:block;}
/*������ݵ����*/
.GD-Seq{text-align:center;border:#B9C9D6 solid;border-width:0 1 1 0;display:block;}
/*��������ʽ*/
.GD-One{background-color:#F3F3F3;border:#B9C9D6 solid;border-width:1 1 1 0;color:#666;}
/*ż������ʽ*/
.GD-Two{background-color:#FFFFFF;border:#B9C9D6 solid;border-width:1 1 1 0;color:#666;}
/*�����������TD��ʽ*/
.GD-TD{background-color: ;border:#B9C9D6 solid;border-width:0 1 1 0;word-break:break-all;}
/*ѡ������ʽ*/
.GD-SelectRow{}
/*��ǰ����ʽ*/
.GD-CurrentRow{background-color:#E6FFFF;color:#013299;}
/*��ǰ��Ԫ����ʽ*/
.GD-CurrentCell{background-color:#FFF475;border:#B9C9D6 solid;border-width:0 1 1 0;word-break:break-all;color:#013299;}
/*DBGrid��������ʽ*/
.G-ScrollBar{overflow:auto;SCROLLBAR-FACE-COLOR:#E3EAF2;SCROLLBAR-HIGHLIGHT-COLOR:#B9C9D6;SCROLLBAR-SHADOW-COLOR:#B9C9D6;SCROLLBAR-3DLIGHT-COLOR:#F8F9FD;SCROLLBAR-ARROW-COLOR:#B9C9D6;SCROLLBAR-TRACK-COLOR:#F8F9FD;SCROLLBAR-DARKSHADOW-COLOR:#F8F9FD;}
/*̧ͷ����������ʽ*/
.GH-SORT-ASC{float:right;width:13px;height:14px;background:url(<%=request.getContextPath()%>/jsv2/image/grid/sort_u.gif);background-repeat:no-repeat;}
/*̧ͷ����������ʽ*/
.GH-SORT-DESC{float:right;width:13px;height:14px;background:url(<%=request.getContextPath()%>/jsv2/image/grid/sort_d.gif);background-repeat:no-repeat;}
.GH-SORT{float:right;width:13px;height:14px;background-repeat:no-repeat;}
.TABLE_TREE_BUTTON{
	width:16px;
	height:16px;
	text-align: center;
	font-size: 12pt;
	border-RIGHT: #2C59AA 1px solid; 
	border-TOP: #2C59AA 1px solid; 
	border-LEFT: #2C59AA 1px solid; 
	border-BOTTOM: #2C59AA 1px solid;
	padding: 0px 1px 0px 2px;
	FONT-SIZE: 9pt; 
	FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#C3DAF5); 
	CURSOR: hand; 
}
input.TABLE_TREE_BUTTON{
	font-family:Tahoma,"\5fae\8f6f\96c5\9ed1";
	font-size: 14px; 
	width: 16px;
	height: 16px; 
	border: #2C59AA 1px solid; 
	text-indent: -4px; 
	*text-indent: 0px; 
	padding-bottom: 2px; 
	line-height: 12px;
	overflow: hidden;
	margin-left:2px;
	margin-right:2px;
}
input.table-page{border:1px solid #8A8A8A;
	background:url(<%=request.getContextPath()%>/jsv2/image/input.gif);
	width:2em;height:1.2em;
	text-align:center;font-size:9pt;
	position:relative;top:-1px;padding-top:0;
}
#page-first{width:16px;background:url(<%=request.getContextPath()%>/jsv2/image/grid/button_begin.gif) no-repeat left 1px;}
#page-prev{width:16px;background:url(<%=request.getContextPath()%>/jsv2/image/grid/button_prv.gif) no-repeat left 1px;}
#page-next{width:16px;background:url(<%=request.getContextPath()%>/jsv2/image/grid/button_next.gif) no-repeat left 1px;}
#page-last{width:16px;background:url(<%=request.getContextPath()%>/jsv2/image/grid/button_end.gif) no-repeat left 1px;}
#page-go{width:15px;background:url(<%=request.getContextPath()%>/jsv2/image/grid/button_go.gif) no-repeat left top;}

/*-----------TAB��ʽ-----------*/
/*Tab_b��ʽ*/
/*��߹�����ť��ʽ*/
.TAB_B_SCROLLLEFTBUTTON{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/left_b.gif) left bottom  no-repeat;width:12px;height:25px;cursor:hand;margin-left:-1px;}
.TAB_B_SCROLLLEFTBUTTON_HOVER{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/left_b.gif) left bottom  no-repeat;width:12px;height:25px;cursor:hand;margin-left:-1px;}
.TAB_B_SCROLLLEFTENDBUTTON{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/left_b_end.gif) left bottom  no-repeat;width:12px;height:25px;cursor:hand;}
.TAB_B_SCROLLLEFTENDBUTTON_HOVER{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/left_b_end.gif) left bottom  no-repeat;width:12px;height:25px;cursor:hand;}
/*�ұ߹�����ť��ʽ*/
.TAB_B_SCROLLRIGHTBUTTON{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/right_b.gif) left bottom  no-repeat;width:12px;height:25px;cursor:hand;margin-left:-1px;}
.TAB_B_SCROLLRIGHTBUTTON_HOVER{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/right_b.gif) left bottom  no-repeat;width:12px;height:25px;cursor:hand;margin-left:-1px;}
.TAB_B_SCROLLRIGHTENDBUTTON{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/right_b_end.gif) left bottom  no-repeat;width:12px;height:25px;cursor:hand;margin-left:-1px;}
.TAB_B_SCROLLRIGHTENDBUTTON_HOVER{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/right_b_end.gif) left bottom  no-repeat;width:12px;height:25px;cursor:hand;margin-left:-1px;}
/*�����ǩ��ʽ*/
.TAB_B_ITEM_STYLE{width:100%; height:25px;}
/*TITLE��ʽ����ߵ�ͼƬ*/
.TAB_B_TITLE_STYLE{padding-left:12px;color:#15428B;float:left;height:24px;z-index:100;margin:0 1px 0 1px;border-bottom: 1 solid #97A0A4;border-left: 1 solid #97A0A4;background-color:#D6E1F8;}
/*TITLE��ʽ���ұߵ�ͼƬ*/
.TAB_B_TITLE_STYLE a{padding-right:12px;float:right;height:24px;border-right: 1 solid #97A0A4;}
/*�۽���ǰTITLE��ʽ����ߵ�ͼƬ*/
.TAB_B_TITLE_STYLE_CURRENT{padding-left:12px;color:#15428B;float:left;height:24px;z-index:100;margin:0 1px 0 1px;border-bottom: 1 solid #97A0A4;border-left: 1 solid #97A0A4;background-color:#FFFFFF;}
/*�۽���ǰTITLE��ʽ���ұߵ�ͼƬ*/
.TAB_B_TITLE_STYLE_CURRENT a{padding-right:12px;float:right;height:24px;border-right: 1 solid #97A0A4;}
/*��괥��TITLE��ʽ����ߵ�ͼƬ*/
.TAB_B_TITLE_STYLE_HOVER{padding-left:12px;color:#000000;float:left;height:24px;z-index:100;margin:0 1px 0 1px;border-bottom: 1 solid #97A0A4;border-left: 1 solid #97A0A4;background-color:#D6E1F8;}
/*��괥��TITLE��ʽ���ұߵ�ͼƬ*/
.TAB_B_TITLE_STYLE_HOVER a{padding-right:12px;float:right;height:24px;border-right: 1 solid #97A0A4;}
/*title��������ʽ*/
.TAB_B_TITLE_FONT_STYLE{color:#000000;text-align:center;cursor: hand;padding-top:6px;}
/*���岿����ʽ*/
.TAB_B_MAIN_TAB {border:1 solid green;background:#FFFFFF;}

/*Tab_h��ʽ*/
/*��߹�����ť��ʽ*/
.TAB_H_SCROLLLEFTBUTTON{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/left.gif) left top  no-repeat;width:12px;height:25px;cursor:hand;margin-left:-1px;}
.TAB_H_SCROLLLEFTBUTTON_HOVER{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/left.gif) left top  no-repeat;width:12px;height:25px;cursor:hand;margin-left:-1px;}
.TAB_H_SCROLLLEFTENDBUTTON{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/left_end.gif) left top  no-repeat;width:12px;height:25px;cursor:hand;}
.TAB_H_SCROLLLEFTENDBUTTON_HOVER{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/left_end.gif) left top  no-repeat;width:12px;height:25px;cursor:hand;}
/*�ұ߹�����ť��ʽ*/
.TAB_H_SCROLLRIGHTBUTTON{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/right.gif) left top  no-repeat;width:12px;height:25px;cursor:hand;margin-left:-1px;}
.TAB_H_SCROLLRIGHTBUTTON_HOVER{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/right.gif) left top  no-repeat;width:12px;height:25px;cursor:hand;margin-left:-1px;}
.TAB_H_SCROLLRIGHTENDBUTTON{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/right_end.gif) left top  no-repeat;width:12px;height:25px;cursor:hand;margin-left:-1px;}
.TAB_H_SCROLLRIGHTENDBUTTON_HOVER{background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/right_end.gif) left top  no-repeat;width:12px;height:25px;cursor:hand;margin-left:-1px;}
/*�����ǩ��ʽ*/
.TAB_H_ITEM_STYLE{width:100%; height:25px;margin:8px 0 0 0;background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/tab_bottom.gif) repeat-x left bottom;}
/*TITLE��ʽ����ߵ�ͼƬ*/
.TAB_H_TITLE_STYLE{
	padding-left:12px;
	color:#666;
	float:left;
	height:25px;
	z-index:100;
	margin:0 0px 0 0px;
	border-top: 0 solid #97A0A4;
	border-left: 0 solid #97A0A4;
	background-color:#D6E1F8;
	background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/tab_left.gif) left top  no-repeat;
	}

/*TITLE��ʽ���ұߵ�ͼƬ*/
.TAB_H_TITLE_STYLE a{
	padding-right:12px;
	margin:0 0px 0 0px;
	float:right;
	height:25px;
	border-right: 0 solid #97A0A4;
	background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/tab_right.gif) right top  no-repeat;
	}
/*�۽���ǰTITLE��ʽ����ߵ�ͼƬ*/
.TAB_H_TITLE_STYLE_CURRENT{
	padding-left:12px;
	color:#074E86;
	float:left;height:25px;z-index:100;
	margin:0 0px 0 0px;
	border-top: 0 solid #97A0A4;border-left: 0 solid #97A0A4;
	background-color:#FFFFFF;
	background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/tab_left.gif) left bottom  no-repeat;
	}
/*�۽���ǰTITLE��ʽ���ұߵ�ͼƬ*/
.TAB_H_TITLE_STYLE_CURRENT a{
	padding-right:12px;
	margin:0;
	float:right;
	color:#074E86;
	height:25px;border-right: 0 solid #97A0A4;
	background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/tab_right.gif) right bottom no-repeat;
	}
/*��괥��TITLE��ʽ����ߵ�ͼƬ*/
.TAB_H_TITLE_STYLE_HOVER{
	padding-left:12px;
	color:#000000;
	float:left;
	height:25px;z-index:100;
	margin:0 0px 0 0px;
	border-top: 0 solid #97A0A4;
	border-left: 0 solid #97A0A4;
	background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/tab_left.gif) left center no-repeat;
	}

/*��괥��TITLE��ʽ���ұߵ�ͼƬ*/
.TAB_H_TITLE_STYLE_HOVER a{
	padding-right:12px;
	float:right;
	height:25px;
	background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/tab_right.gif) right center no-repeat;}

/*TITLE��������ʽ*/
.TAB_H_TITLE_FONT_STYLE{text-align:center;cursor:pointer;padding-top:6px;white-space:nowrap; word-break:keep-all;}
/*���岿�ֵ���ʽ*/
.TAB_H_MAIN_TAB {margin: 0 0 0 0;background:#FFFFFF;}

/*�رհ�ť��ʽ*/
.TAB_ITEM_CLOSE_BUTTON{
width:10px;height:10px;
cursor:pointer;
float:right;
background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/close1.gif) left bottom no-repeat;
margin:3px 0 0 3px;
vertical-align:middle;
}
.TAB_ITEM_CLOSE_BUTTON_CURRENT{
width:10px;height:10px;
cursor:hand;
float:right;
background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/close1.gif) left top no-repeat;
margin:3px 0 0 3px;
vertical-align:middle;
}
.TAB_ITEM_CLOSE_BUTTON_HOVER{
width:10px;height:10px;
cursor:hand;
float:right;
background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/close1.gif) left top no-repeat;
margin:3px 0 0 3px;
vertical-align:middle;
}

/*tab_v��ʽ*/
/*�����ǩ��ʽ*/
.TAB_V_ITEM_STYLE{height:100%;padding:12px 0 12px 0;}
/*TITLE��ʽ����ߵ�ͼƬ*/
.TAB_V_TITLE_STYLE{
	padding-left:12px;
	color:#15428B;
	float:left;
	height:25px;
	z-index:100;
	margin: 0 0 0 0;
	border-top: 0 solid #97A0A4;border-left: 0 solid #97A0A4;border-bottom: 0 solid #97A0A4;
	background-color:#D6E1F8;
	background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/tab_left.gif) left bottom  no-repeat;
	}
/*TITLE��ʽ���ұߵ�ͼƬ*/
.TAB_V_TITLE_STYLE a{
	padding-right:12px;
	float:right;
	height:25px;margin-top:1px;
	border-right: 1 solid #97A0A4;
	margin: 0 0 0 0;
	background:url(<%=request.getContextPath()%>/jsv2/image/tabPage/tab_rigt.gif) rigt bottom  no-repeat;
	}
/*�۽���ǰTITLE��ʽ����ߵ�ͼƬ*/
.TAB_V_TITLE_STYLE_CURRENT{margin: 0 0 0 0;padding-left:12px;color:#15428B;float:left;height:25px;z-index:100;margin-top:1px;border-top: 1 solid #97A0A4;border-left: 1 solid #97A0A4;border-bottom: 1 solid #97A0A4;background-color:#FFFFFF;}
/*�۽���ǰTITLE��ʽ���ұߵ�ͼƬ*/
.TAB_V_TITLE_STYLE_CURRENT a{margin: 0 0 0 0;padding-right:12px;float:right;height:25px;margin-top:1px;border-right: 1 solid #97A0A4;}
/*��괥��TITLE��ʽ����ߵ�ͼƬ*/
.TAB_V_TITLE_STYLE_HOVER{margin: 0 0 0 0;padding-left:12px;color:#000000;float:left;height:25px;z-index:100;margin-top:1px;border-top: 1 solid #97A0A4;border-left: 1 solid #97A0A4;border-bottom: 1 solid #97A0A4;background-color:#D6E1F8;}
/*��괥��TITLE��ʽ���ұߵ�ͼƬ*/
.TAB_V_TITLE_STYLE_HOVER a{margin: 0 0 0 0;padding-right:12px;float:right;height:25px;margin-top:1px;border-right: 1 solid #97A0A4;}
/*title��������ʽ*/
.TAB_V_TITLE_FONT_STYLE{color:#000000;cursor: hand;padding-top:3px;}
/*���岿����ʽ*/
.TAB_V_MAIN_TAB {margin: 0 0 0 0;border:1 solid red;background:#FFFFFF;}

/*-----------DBForm.css-----------/
.DBForm_tdDis{height:20;border:1 solid #B1BAC2;background-color:#E7F4FE;padding:5 0 0 5;}
.DBForm_tdTit{padding-left:30;}


/*-----------DBDate.css-----------*/
/* ���Ƶ�Ԫ����ʾ��ʽ */
.DBDate-CalHead {cursor:default; text-align:center; font:bold 12px arial; color:white;}
.DBDate-CalCell {cursor:hand; text-align:center;}
.DBDate-CellAnchor {text-decoration:none; font:12px arial;}
/* ����������ʾ��ʽ*/
.DBDate-WeekHead {cursor:default; font:12px arial; text-align:center; color:#ddddea;}
.DBDate-WeekCol {cursor:default; font:bold 12px arial; text-align:center; color:gray; background-color:#ddddea;}
/* �·ݵ��� */
.DBDate-MonthNav {vertical-align:middle; height:22; width:18; font:12px fixedsys; color:black;}
/* ���� */
.DBDate-CalHead {cursor:default; text-align:center; font:bold 12px arial; color:white;}
.DBDate-CalCell {cursor:hand; text-align:center;}
.DBDate-CellAnchor {text-decoration:none; font:12px arial;}
/* ����������ʾ��ʽ*/
.DBDate-WeekHead {cursor:default; font:12px arial; text-align:center; color:#ddddea;}
.DBDate-WeekCol {cursor:default; font:bold 12px arial; text-align:center; color:gray; background-color:#ddddea;}
/* �·ݵ��� */
.DBDate-MonthNav {vertical-align:middle; height:22; width:18; font:12px fixedsys; color:black;}
/* ���� */
.DBDate-CalTop {text-align:center;}
.DBDate-CalMiddle {}
.DBDate-CalBottom {text-align:center;}
/* ���� */
.DBDate-CalTitle {vertical-align:middle; font:12px arial; color:black;}
/* ������ʾ */
.DBDate-Today {text-decoration:none; font:bold 12px sans-serif; color:black;}
A.DBDate-Today:hover {color:yellow}
A.DBDate-Today:active {color:red}
/* ���� */
.DBDate-CalTitle {vertical-align:middle; font:12px arial; color:black;}
/* ������ʾ */
.DBDate-Today {text-decoration:none; font:bold 12px sans-serif; color:black;}
A.DBDate-Today:hover {color:yellow}
A.DBDate-Today:active {color:red}

/*-----------DBCombobox.css-----------*/
.combo-hilite {cursor:hand;background:#EAF2FF;border:1px solid #78ACFF;color:#000000;font-size:12px;}
.combo-item {cursor:hand;background:#FFFFFF;border:1px solid #FFFFFF;color:#000000;font-size:12px;}
.combo-input {border: 1px solid #78ACFF !important;}
.combo-list-width {width:133px}
.combo-list {border:1px solid #97A0A4;width:150px;}

/*-----------PopMenu�����˵����-----------*/
.aipopmenu_backdiv{background-color: #D6E1F8; border: 1 solid #97A0A4;}
.aipopmenu_menu{padding-left:16;padding-top:2;padding-bottom:2; font-size: 12px;}
.aipopmenu_overmenu{padding-left:16;padding-top:2;padding-bottom:2;background-color:highlight;color:highlighttext; font-size: 12px;}
.aipopmenu_sepa{width:100%;border: 1px solid #f0f0f0}
.aipopmenu_disablemenutext{color:#c0c0c0;}




/*-----------��������ص�CSS-----------*/
.AIAPPFRAME_WAIT_MAIN_CSS{position:absolute; z-index:500; left:0; top:0; width:90%; height:98%; clip:rect(0,100%,100%,0); background-color:transparent; layer-background-color:white;visibility:hidden}
.AIAPPFRAME_WAIT_DIV_CSS{background-color:#D6E1F8;width:300px;height:80px;color:#2F5188;border: 2 solid #97A0A4;}
.AIAPPFRAME_WAIT_LOAD_CSS{background-color:#D6E1F8;width:32px;height:32px;}

/*-----------�ļ��ϴ���������ص�CSS-----------*/
.AIAPPFRAME_UPLOAD_MAIN_CSS{position:absolute; z-index:500; left:0; top:0; width:100%; height:98%; clip:rect(0,100%,100%,0); background-color:transparent; layer-background-color:white;visibility:hidden}
.AIAPPFRAME_UPLOAD_DIV_CSS{background-color:#D6E1F8;width:300px;height:80px;color:#2F5188;border: 2 solid #97A0A4;}
.AIAPPFRAME_UPLOAD_LOAD_CSS{background-color:#D6E1F8;width:32px;height:32px;}
/*������������ʽ*/
.prog-border {height: 15px;width: 380px;background: #fff;border: 1px solid #000;margin: 0;padding: 0;}
/*������ǰ����ʽ*/
.prog-bar {height: 11px;margin: 2px;padding: 0px;background: #00ff00;}

/*-----------DBTreeNew��ص�css��ʽ-----------*/
/*���ڵ���ͼƬ����ʽ*/
.T-Img{cursor:hand;}
/*���ڵ��е����ֶ�ѡ״̬ʱ,checkbox����ʽ*/
.T-Checkbox{cursor:hand;}
/*���ı���ǩ����ʽ*/
.T-Label{cursor:hand;font-family: "����", "Arial", "Verdana"; font-size: 12px;}

/*-----------DBListBox��ص�css��ʽ-----------*/
/*��������������µ�CSS��ʽ*/
.DBListBox_normal_style{BORDER: 1px solid #7AB3D6;BORDER-COLLAPSE: collapse;}
/*�����򲻿��õ�����µ�CSS��ʽ*/
.DBListBox_disabled_style{BORDER: 0px solid #97A0A4;BORDER-COLLAPSE: collapse;}

/*-----------AIContentFrame��ص�css��ʽ-----------*/
.line_start{padding:3px}
.line_end{padding:0}
.AIContentFrame_head_bg{width:20px;height:22px;		background:url(<%=request.getContextPath()%>/jsv2/image/contentframe/contentframe_title.gif) ;repeat-x;border-top:1 solid #D2DFE7;}
.AIContentFrame_head_left{width:20px;height:22px;	background:url(<%=request.getContextPath()%>/jsv2/image/contentframe/contentframe_title.gif) ;repeat-x;border-left:1 solid #D2DFE7;}
.AIContentFrame_head_right{width:20px;height:22px;	background:url(<%=request.getContextPath()%>/jsv2/image/contentframe/contentframe_title.gif) ;repeat-x;border-right:1 solid #D2DFE7;}
.AIContentFrame_main{border:1 solid #D2DFE7;background-color:#FFFFFF;}

/*-----------AIContractFrame���ڲ�����ʽ-----------*/
.AIContentFrame{text-align:center}
.AIContent{ width:100%}
.x-box-tl{}
.x-box-tc{}
.x-box-tr{}
.x-box-ml{}
.x-box-mc{background:url(<%=request.getContextPath()%>/jsv2/image/contentframe/tb-title.gif) repeat-x; padding:6px 12px 0 16px; height:28px; text-align:left;color:#567BA5;font-weight:bold;}
.x-box-mm{ margin:0 0 5px 0; text-align:left}
.x-box-mr{}
.x-box-bl{}
.x-box-bc{}
.x-box-br{}
.x-tool-up{width:15px;height:15px;float:right;cursor:pointer;background:url(<%=request.getContextPath()%>/jsv2/image/contentframe/tool-up.gif) no-repeat;margin-left:2px;background-position:0 0px;}
.x-tool-up:hover{background-position:-15px 0px;}
.x-tool-down{width:15px;height:15px;float:right;cursor:pointer;background:url(<%=request.getContextPath()%>/jsv2/image/contentframe/tool-down.gif) no-repeat;margin-left:2px;background-position:0 0px;}
.x-tool-down:hover{background-position:-15px 0px;}

/*-----------AIContractFrame���ڲ�����ʽ-----------*/
.AIContractFrame{text-align:center}
.AIContract{ width:100%}
.t-bot-mc{background:url(<%=request.getContextPath()%>/jsv2/image/contentframe/tb-title.gif) repeat-x; padding:3px 12px 0 12px; height:28px; text-align:left;}
.t-bot-mc-title{float:left;color:#567BA5;font-weight:bold;padding:4px 0 0 6px;white-space: nowrap; word-break: keep-all;}
.t-bot-mc-right{float:right;padding:0;white-space: nowrap; word-break: keep-all;}
.t-bot-mc-word{color:#567BA5;width:80%;text-align:center;padding-top:5px;}
.t-bot-mc-button{width:20%;text-align:right;}
.t-bot-mm{ margin:0 0 5px 0; text-align:left}
.t-tool-up{width:15px;height:15px;float:left;cursor:pointer;background:url(<%=request.getContextPath()%>/jsv2/image/contentframe/tool-up.gif) no-repeat;margin-left:2px;margin-top:4px;background-position:0 0px;}
.t-tool-up:hover{background-position:-15px 0px;}
.t-tool-down{width:15px;height:15px;float:left;cursor:pointer;background:url(<%=request.getContextPath()%>/jsv2/image/contentframe/tool-down.gif) no-repeat;margin-left:2px;margin-top:4px;background-position:0 0px;}
.t-tool-down:hover{background-position:-15px 0px;}

/*-----------outlook�˵���ʽ-----------*/
.title00{height:24px;cursor:pointer;background:url(<%=request.getContextPath()%>/jsv2/image/contentframe/tb-title.gif) repeat-x bottom;;text-align:center; padding-top:6px;text-decoration:none;}
.title00:hover{background:url(<%=request.getContextPath()%>/jsv2/image/contentframe/tb-title.gif) repeat-x bottom;}

.content{ height:100%;overflow:auto;padding:0px;margin:0px;}
a.li {display:block; height:20px;padding-left:30px;text-decoration: none;padding-top:3px;}
a.li:hover {background-color: #D6E1F8;height:20px;}

/*-----------AIDBForm��ص�CSS-----------*/
.dbform_inputfield_style{border-style:solid;border-color:#CCC;border-width:0px 0px 1px 0px;BORDER-COLLAPSE: collapse}
.dbform_lable_style{background-color: #99BBE8;BORDER:1px solid #7AB3D6;}
.dbform_password_style{BORDER:1px solid #CCC;BORDER-COLLAPSE: collapse}
.dbform_checkbox_style{border:0}
.dbform_textarea_style{BORDER:1px solid #CCC;BORDER-COLLAPSE: collapse;background:#FFF url(<%=request.getContextPath()%>/webframe/shdesktopui/theme/default/images/textareaBg01.gif) repeat-x left top;}
/*dblist���*/
.dbform_listbox_input_style{border-style:solid;border-color:#CCC;border-width:0px 0px 1px 0px;BORDER-COLLAPSE: collapse}
.dbform_listbox_list_style{BORDER:0px solid #7AB3D6;BORDER-COLLAPSE: collapse;}
.dbform_listbox_input_disable_style{background-color: #E3F2F9;BORDER:0px solid #7AB3D6;BORDER-COLLAPSE: collapse;}
.selectspan{height:20px;border:0px solid #7AB3D6;}
/**dbdate,dbdatetime��ص���ʽ**/
.dbform_dbdate_span_style{BORDER:1px solid #7AB3D6;BORDER-COLLAPSE: collapse}
/*dbdate�������ʽ*/
.dbform_dbdate_input_style{border-style:solid;border-color:#b9c9d6;border-width:0px 0px 1px 0px;BORDER-COLLAPSE: collapse}
/*dbdate��ť��ʽ*/
.dbform_dbdate_btn_style{background:url(<%=request.getContextPath()%>/csc/images/icon_date_new.gif) no-repeat 2px 1px;width:20px;height:20px;border: none;cursor:hand; font-size:0;}
/*dbspan��ʽ*/
.dbform_dbspan_style{}
/*dbhtml�����*/
.dbform_dbhtml_style{}
.DBForm_Layout_Table{}
.DBForm_Layout_Tr{}
.DBForm_Layout_Title_Head{}
.DBForm_Layout_Title_Td{}
.DBForm_Layout_Data_Td{}

/*-----------DBLink css-----------*/
.dbform_dblink_style{}

/*-----------DBOpenWin Css-----------*/
.dbform_dbopenwin_editor_style{BORDER:1px solid #7AB3D6;BORDER-COLLAPSE: collapse}
.dbform_dbopenwind_btn_style{font-size:9pt bold; background-color: #C4CCFF;BORDER:1px solid #7AB3D6;}

 /*-----------DBFile Css-----------*/
.dbform_dbfile_btn_style{font-size:9pt bold; background-color: #C4CCFF;BORDER:1px solid #97A0A4;}

/*---------------------��������չʾ input disable_style----------------------------------------------------------------*/
.dbform_disable_style        			{border-style: dashed;border-color:#ddd;border-width:0px 0px 1px 0px;;BORDER-COLLAPSE: collapse;color:#333;background-color: #FFFFFF;}
.dbform_listbox_input_disable_style     {border-style: dashed;border-color:#ddd;border-width:0px 0px 1px 0px;;BORDER-COLLAPSE: collapse;color:gray;background-color: #FFFFFF;}
.dbform_disable_lable_style             {BORDER:0px solid #7AB3D6;BORDER-COLLAPSE: collapse;color:gray;background-color: #FFFFFF;}
.dbform_disable_date_style      		{BORDER:0px solid #7AB3D6;BORDER-COLLAPSE: collapse;color:gray;background-color: #FFFFFF;}
.dbform_disable_date_style      		{BORDER:0px solid #7AB3D6;BORDER-COLLAPSE: collapse;color:gray;background-color: #FFFFFF;}
.dbform_disable_textArea_style          {BORDER:1px solid #CCC;BORDER-COLLAPSE: collapse;background:#FFF url(<%=request.getContextPath()%>/webframe/shdesktopui/theme/default/images/textareaBg01.gif) repeat-x left top;}
.dbform_disable_checkBox_style          {BORDER:0px solid #7AB3D6;BORDER-COLLAPSE: collapse;color:gray;background-color: #FFFFFF;}
.dbform_disable_link_style            	{BORDER:0px solid #7AB3D6;BORDER-COLLAPSE: collapse;color:gray;background-color: #FFFFFF;}
.dbform_disable_openWin_style  			{BORDER:0px solid #7AB3D6;BORDER-COLLAPSE: collapse;color:gray;background-color: #FFFFFF;}
.dbform_disable_File_style            	{BORDER:0px solid #7AB3D6;BORDER-COLLAPSE: collapse;color:gray;background-color: #FFFFFF;}

