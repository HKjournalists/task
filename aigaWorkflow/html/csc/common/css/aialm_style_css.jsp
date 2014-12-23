<%@ page contentType="text/html; charset=GBK" %>
#frame_top{
	width: 100%;
	background-image: url(<%=request.getContextPath()%>/webframe/shdesktopui/images/top_bg.gif);
	border-width: 0px;
	border-style: dashed;
	border-color: #000000;
	height: 48px;
}
body{
    margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	overflow: auto;
    font-size: 12px;
    background-color: #FFFFFF;
}
/*--------------暂时删除-------------
/*------tr, td{						----- */
/*------	height:20;				----- */
/*------	border-bottom: 1;		----- */
/*------	border-top: 0;			----- */
/*------	border-left: 0;			----- */
/*------	border-right: 0;		----- */
/*------	border-color: #E5EFF5;	----- */
/*------	border-style: solid;	----- */
/*------}							----- */
-------------- */


/* ------------------活动分配页面布局------------------ */
#active_left {
	width: 49%;
	height: 100%;
	float: left;
	border-width: 0px;
	border-style: dashed;
	border-color: #000000;
}
#active_right {
	width: 49%;
	height:100%;
	float: right;
	margin-left: 10px;
	border-width: 0px;
	border-style: dashed;
	border-color: #000000;
}


/* ------------------页面布局------------------ */
#main {
	height: 100%;
	width: 100%;
	margin-top: 5px;
	margin-left: 10px;
	margin-bottom: 10px;
	border-width: 0px;
	border-style: dashed;
	border-color: #000000;
}

#top {
	height: 45;
	width: 100%;
	float: top;
	margin-top: 5px;
	margin-left: 10px;
	margin-bottom: 10px;
	border-width: 0px;
	border-style: dashed;
	border-color: #000000;
}
=======

#top {
	height: 45;
	width: 100%;
	float: top;
	margin-top: 5px;
	margin-left: 10px;
	margin-bottom: 10px;
	border-width: 0px;
	border-style: dashed;
	border-color: #000000;
}


#left {
	width: 30%;
	height: 100%;
	float: left;
	border-width: 0px;
	border-style: dashed;
	border-color: #000000;
}

#selectBtn {
	width: 5%;
	height: 100%;
	float: left;
	border-width: 0px;
	border-style: dashed;
	border-color: #000000;
}

#right {
	width: 60%;
	height: 100%;
	float: left;
	margin-left: 10px;
	border-width: 0px;
	border-style: dashed;
	border-color: #000000;
}

#left_top {
	width: 49%;
	height: 50%;
	float: left;
	border-width: 0px;
	border-style: dashed;
	border-color: #000000;
}

#left_bottom {
	width: 49%;
	height: 50%;
	float: left;
	border-width: 0px;
	border-style: dashed;
	border-color: #000000;
}

#right_top {
	width: 49%;
	height: 50%;
	float: right;
	margin-left: 10px;
	border-width: 0px;
	border-style: dashed;
	border-color: #000000;
}

#right_bottom {
	width: 49%;
	height: 50%;
	float: right;
	margin-left: 10px;
	border-width: 0px;
	border-style: dashed;
	border-color: #000000;
}

#selReqPoint {
	float: left;
	border-width: 0px;
	border-style: dashed;
	border-color: #000000;
}

#detail {
	float: left;
	border-width: 0px;
	border-style: dashed;
	border-color: #000000;
}

#active {

}
#version {

}

#button {
	margin-top: 10px;
}

/* ------------------下拉控件样式------------------ */
.popdownMain {
	border-width: 0px;
	border-color: gray;
	border-style: solid;
}
.popdownMain1 {
	border-width: 0px;
	border-color: gray;
	border-style: solid;
	background:   #E5EFF5;
	
}
.popdownMain2 {
	border-width: 0px;
	border-color: gray;
	border-style: solid;
}

.popdownBody {
	border-width: 0px;
	border-color: gray;
	border-style: solid;
}

.popdownBody1 {
	border-width: 0px;
	border-color: gray;
	border-style: solid;
}

/* ------------------选择员工的按钮状态------------------ */	
.staffbtn {
	font-weight: blod;
	color:026A95;
	text-decoration: none;
	background-image: url(<%=request.getContextPath()%>/csc/images/selstaff.gif);
	background-repeat: no-repeat;
	height: 20px;
	width: 20px;
	border: none;
	cursor:hand;
	letter-spacing: 2px;
	margin: 0px;
	padding: 2 0 0 0;
}

/* ------------------？？？？------------------ */	
.table_title_info{
	font-weight: blod;
	color:026A95;
	text-decoration: none;
	background-image: url(<%=request.getContextPath()%>/csc/images/button/background001.gif);
	background-repeat: no-repeat;
	height: 20px;
	width: 30px;
	border: none;
	cursor:hand;
	letter-spacing: 2px;
	margin: 0px;
	padding: 2 0 0 0;
}
.tab_table_title{
	font-weight: blod;
	color: white;
	text-decoration: none;
	background-image: url(<%=request.getContextPath()%>/csc/images/table/background001.gif);
	background-repeat: no-repeat;
	height: 20px;
	border: none;
	cursor:hand;
	letter-spacing: 2px;
	margin: 0px;
	padding: 2 0 0 0;
}


/* ------------------标签格式，r必填、v只读、e编辑------------------ */	
/*	background:   #E5EFF5;*/
.title_r{
	height:25;
	font-family:Arial,"黑体" 12px;
	width:120;
	color: red;
	border-bottom: 0;
	border-top: 0;
	border-left: 0;
	border-right: 0;
/*--border-color: #E5EFF5;--*/
	border-color: #DEE7F0;
	border-style: solid;
	text-align:	  right;
	padding: 0 5px 0 0;
	background:   #F7F8FA;
}
.title_e{
	height:25;
	font-family:Arial,"黑体" 12px;
	width:100px;
	border-bottom: 0;
	border-top: 0;
	border-left: 0;
	border-right: 0;
	border-color: #DEE7F0;
	border-style: solid;
	text-align:	  right;
	color:#666;
}
.title_v{
	height:25;
	font-family:Arial,"黑体" 12px;
	width:120;
	border-bottom: 0;
	border-top: 0;
	border-left: 0;
	border-right: 0;
/*--border-color: #E5EFF5;--*/
	border-color: #DEE7F0;
	border-style: solid;
	text-align:	  right;
	padding: 0 5px 0 0;
	background:   #F7F8FA;
}

/* ------------------table head 样式------------------ */	
.table_v{
	border-width: 0px;
	border-color: white;
	border-style: solid;
	background:   #FFFFFF;
	text-align:	  right;
	padding: 0 0 0 0;
}


/* ------------------用于轨迹跟踪 表格宽度------------------ */	
.title_phase{
	width:50;
}
.table_phase{
	TABLE-LAYOUT: fixed;
	BORDER-COLLAPSE: collapse;
	border-width: 1px;
	border-color: gray;
	border-style: solid;
}

.table_form{
	align: center;
	border:1;
}
/* ------------------用于file相关样式------------------ */	
.file_upload{
	border-width: 1px;
	border-color: white;
	border-style: solid;
	background:   #E5EFF5;
	text-align:	  left;
	padding: 0 0 0 0;
}

/* ------------------输入框描述:格式（ai:dbformfield）------------------ */	
/*	background:   #F1F3F8;  */
.aiEdit_2col{
	height:30;
	border-bottom: 1;
	border-top: 0;
	border-left: 0;
	border-right: 0;
	border-color: #E5EFF5;
	border-style: solid;
	text-align:	  left;
	padding: 0 0 0 2px;
	
}

.aiEdit_3col{
	height:30px;
	width:140px;
}

.aiEdit_4col{
	height:30;
	border-bottom: 1;
	border-top: 0;
	border-left: 0;
	border-right: 0;
	border-color: #E5EFF5;
	border-style: solid;
	text-align:	  left;
	padding: 0 0 0 2px;
}

/**used in input text bg*/
.displayBg{
   background: "#E3F2F9"
}


.img_min{
	width:  30;
	height: 30;
}
.td_img_min{
	width:40;
}
.table_v{
	border-width: 0px;
	border-color:  ;
	border-style: solid;
	background-color: #FFFFFF;
	text-align:	  right;
	padding: 0 0 0 0;
}
.tablehead{
	font-family:Arial,"黑体" 10pt;
	width:100%;
	height: 20;
	background:   #EEF3F7;
	border:0;
	cellpadding:0;
	cellspacing:0;
}
.tdhead_item{
	text-align:	left;
}

/* ------------------代替 ai:contentform ------------------ */	
.div_title1{
	width: 100%;
	margin-right: auto; 
	margin-left: auto;
	margin: 0px ;
	margin-top:2px;
	margin-bottom:6px;
	cellpadding:0;
	cellspacing:0;
	border:0px solid #7AB3D6;
	margin: 0px 0 0 0;
	
/*	background-color: #E4E6F8;*/

}

.div_title{
	width: 100%;
	margin-right: auto; 
	margin-left: auto;
	margin: 0px ;
	margin-top:2px;
	margin-bottom:6px;
	cellpadding:0;
	cellspacing:0;
	border:1px solid #dae4ee;
	margin: 5px 0 0 0;
}

.div_title_test {
	width: 100%;
	margin-right: auto; 
	margin-left: auto;
	margin: 0px ;
	margin-bottom:6px;
	cellpadding:0;
	cellspacing:0;
	border-style: none;
}

.div_file_upload{
	width: 100%;
	margin-right: auto; 
	margin-left: auto;
	margin: 0px ;
	margin-top:2px;
	margin-bottom:6px;
	cellpadding:0;
	cellspacing:0;
	border:1px solid #c4d9eb;
/*	background-color: #E4E6F8;*/
}
.content_title{
	color: #4682B4;
	margin: 0px;
	background-image: url(<%=request.getContextPath()%>/csc/images/contractframe/contractframe_head_new.gif);
	background-repeat: repeat-x;
	height:26px;
	width:100%;
	font-weight:bold
	margin: 0 0 0 0 ;
	padding:0 0 0 0 ;
	border-bottom:1px #bdd3e6 solid;
}

.content_forAIstable{
	margin: 0px;
	width:100%;
}

.content_title_text{
	height:22px;
	color:#204D84;
	align:left;
	font-weight:bold;
	text-indent:6px;
}
.content_title_text_bnt{
	color:#FFFFFF;
	align:right;
}
.title_1px{
	width:120;
	height:1px;
	padding: 0 0 0 0;
}

/* ------------------输入框 样式（部分替代 ai:dbformfield） ------------------ */	

.input_lab_style{
	border-bottom: 1px solid #4682B4;
	background:   #F1F3F8;
	color: red;
}

.input_text_editable{
	BORDER:1px solid #4682B4;BORDER-COLLAPSE: collapse;
}

/* ------------------pucker样式 ------------------ */	
.pucker_head{
	width:120;
 	font-family:Arial,"黑体" 10pt; 
 	float:right;
 	margin-right: auto; 
	margin-left: auto;
	margin: 0px ;
	margin-top:2px;
	margin-bottom:6px;
}
/*-------background:  #F1F3F8;-------------------*/
.pucker_line{
	border-top: 1px  double #4682B4;
	background:  #F1F3F8;
	background-repeat: no-repeat;
	line-height: 20px;
	cursor:hand;
}


/*------------------用于《table》标签，bottom 有灰色的线，无竖线---------------------------------*/
.table_context{
	background:  #FFFFFF;
	padding: 0 0 0 0;
}

/*------------------------test-----------------------------*/
.EXT_line_bottom{
	border-bottom: 1;
	border-bottom-color:7AB3D6;
	border-bottom-style:dashed;
	border-top: 0;
	border-left: 0;
	border-left-color:green;
	border-left-style:groove;
	border-right: 0;
	margin: 0 0 0 0 ;
	padding:0 0 0 0 ;
	margin-color: gray;
	padding-color:gray;
	v-align:bottom;
}
.EXT_line_top{
	border-bottom: 0;
	border-bottom-color:7AB3D6;
	border-bottom-style:dashed;
	border-top: 1;
	border-left: 0;
	border-left-color:green;
	border-left-style:groove;
	border-right: 0;
	margin: 0 0 0 0 ;
	padding:0 0 0 0 ;
	margin-color: gray;
	padding-color:gray;
	v-align:bottom;
}

/*------------------------用于讨论页面的样式-----------------------------*/

.table_line{
	border-bottom: 1px;
	border-top: 1px;
	border-left: 1px;
	border-right: 1px;
	border-color: #FFCC66;
	border-style: solid;

}
.title_head{
	height:25;
	font-family:'Verdana'; 
	font-size:13px;
	border-bottom: 0;
	border-top: 0;
	border-left: 0;
	border-right: 0;
	border-color: #E4E6F8;
	border-style: solid;
	text-align:	left;
	padding: 0 5px 0 0;
	background:   #efeeee;
}
.title_list{
	height:25;
	font-family:'Verdana'; 
	font-size:13px;
	color: green;
	width: 120;
	border-bottom: 0;
	border-top: 0;
	border-left: 0;
	border-right: 0;
	border-color: #E4E6F8;
	border-style: solid;
	text-align:	left;
	padding: 0 5px 0 0;
	background:   #ffffcc;
}
.font_link{
	font-family:'Verdana'; 
	color:#6699CC; 
	font-size:13px;
}
.font_context{
	font-family:'Verdana'; 
	color:#6699CC; 
	font-size:13px;
}

/*-- 20130320 add --*/

.bigOrange { color:#D85B00; font-size:14px;}
.bigGreen { color:#037A00; font-size:14px;}

.title_e b { color:#F00; font-size:18px; font-weight:normal;}
.aiEdit_3col_new { height:30; border:none; padding: 0 0 0 2px;}
.flow_light { color:#6D8BB5; font-weight:normal;}
.right_highLightFont { font-weight:normal; color:#D55900; padding-right:8px;}

/* ----------------以下为新增样式-------------- */
.div_title_new {
	width: 100%;
	cellpadding:0;
	cellspacing:0;
	border:1px solid #B9C9D6;
	margin: 0px 0px 5px 0px;
}
.explain_title_div {
	color: #4682B4;
	background-image: url("<%=request.getContextPath()%>/csc/images/contractframe/contractframe_head.gif");
	background-repeat: repeat-x;
	height: 26px;
	width: 100%;
	margin: 0 0 0 0;
	padding:0 0 0 0;
	border-style: solid;
	border-color: #B9C9D6;
	border-width: 0px 0px 1px 0px;
}
.explain_title_div img {
	float: left;
	width: 16px;
	height: 16px;
	margin: 4px 0px 4px 4px;
}
.explain_title_div font {
	float: left;
	text-align: center;
	height: 20px;
	padding: 6px 0px 0px 4px;
	font-size: 12px;
	color:#0D3B60;
}
.explain_title_button {
	float: right;
	height: 20px;
	margin:3px 4px 1px 4px;
	border: 1 solid #97A0A4;
	text-align: center;
	font-size: 12px;
	color:#2F5188;
	background:url(<%=request.getContextPath()%>/jsv2/image/button/button_bg.gif);
}

#indexDivPDiv {
	position: absolute;
	top: 0px;
	right: 0px;
	bottom: 0px;
	left: 0px;
	margin: 0px;
	cursor: hand;
	z-index: 9999;
}

#indexDiv {
	width: 100%;
	height: 100%;
	background: #000;
	filter:alpha(Opacity=60);-moz-opacity:0.6;opacity: 0.6;
	position: absolute;
	top: 0px;
	right: 0px;
	bottom: 0px;
	left: 0px;
	margin: 0px;
	padding: 0px;
}

#flowImg {
	position: absolute;
}



