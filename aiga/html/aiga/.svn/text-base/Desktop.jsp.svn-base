<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String reqId = request.getParameter("reqId");
	reqId = "1";
%>
<!DOCTYPE html>
<html>
	<head>
		<title>自动化测试平台</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/extJs/resources/css/ext-neptune.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/icon.css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/extJs/ext-all.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/base/jquery-1.6.1.js"></script>
		<style type="text/css">
			.x-panel-ghost {
			    z-index: 1;
			}
			.x-border-layout-ct {
			    background: #DFE8F6;
			}
			.x-portal-body {
			    padding: 0 0 0 8px;
			}
			.x-portal .x-portal-column {
			    padding: 8px 8px 0 0;
			}
			.x-portal .x-panel-dd-spacer {
			    border: 2px dashed #99bbe8;
			    background: #f6f6f6;
			    border-radius: 4px;
			    -moz-border-radius: 4px;
			    margin-bottom: 10px;
			}
			.x-portlet {
			    margin-bottom:10px;
			    padding: 1px;
			}
			.x-portlet .x-panel-body {
			    background: #fff;
			}
			.portlet-content {
			    padding: 10px;
			    font-size: 11px;
			}

		</style>
	</head>
	<body>
		<form id="logoutForm" action="<%=request.getContextPath()%>/logout.do">
		</form>
	</body>
	<script type="text/javascript">
		Ext.Loader.setConfig({
			enabled : true
		});
	
		Ext.Loader.setPath({
			'Ext.ux' : '../extJs/ux',
			'Ext.app' : '../extJs/app'
		});
	
		Ext.require(['Ext.app.Portlet', 'Ext.app.PortalColumn', 'Ext.app.PortalPanel',
				'Ext.app.PortalDropZone', 'Ext.ux.TabReorderer',
				'Ext.ux.TabCloseMenu']);
	
		var ajax = function(config) { // 封装、简化AJAX
			Ext.Ajax.request({
				url : config.url, // 请求地址
				params : config.params, // 请求参数
				method : 'post', // 方法
				callback : function(options, success, response) {
					config.callback(Ext.JSON.decode(response.responseText));
					// 调用回调函数
				}
			});
			return false;
		};
		Ext.onReady(function() {
			var tab = Ext.create('Ext.tab.Panel', {
				activeTab : 0,
				id: 'tabPanel',
				enableTabScroll : true,
				animScroll : true,
				border : true,
				autoScroll : true,
				region : 'center',
				split : true,
				items : [{
					iconCls : 'icon-activity',
					title : '平台首页',
					xtype:'portalpanel',
					layout:'column',
					items : [{
							xtype : 'portalcolumn',
							columnWidth : 0.7,
			                items:[
			                	{title: '待办事项',height : 200,iconCls : 'icon-note' },
			                	{ title: '相关任务',height : 200,iconCls : 'icon-news' }
			                ]
			            },{
			            	xtype : 'portalcolumn',
			            	columnWidth : 0.3,
			                items:[
			                	{title: '结果报表',height : 200, iconCls : 'icon-chart'},
			                	{ title: '功能链接', height : 200, iconCls : 'icon-link'}
			                ]
			            }]
				}],
				plugins: [Ext.create('Ext.ux.TabReorderer'),
	       		  Ext.create('Ext.ux.TabCloseMenu',{
	       		  	closeTabText: '关闭面板',
	       		  	closeOthersTabsText: '关闭其他',
	       		  	closeAllTabsText: '关闭所有'
	       		  })]
			});
			var tree = Ext.create("Ext.panel.Panel", {
				region : 'west',
				title : "系统菜单",
				width : 250,
				iconCls : "icon-tree",
				autoScroll : true,
				layout : 'accordion',
				collapsible : true,
				layoutConfig : {
					animate : true
				},
				split : true
			});
			var title = Ext.create("Ext.panel.Panel", {
				height : 80,
				html : '自动化测试管理平台',
				region : 'north',
				split : true,
				bbar : [{
					iconCls : 'icon-user',
					text : '管理员'
				},'-',{
					text : Ext.Date.format(new Date(),'Y年m月d日')
				},'->',{
					text : '退出',
					iconCls : 'icon-logout',
					handler: function(){
						$("#logoutForm").submit();
					}
				}],
				bodyStyle : 'backgroud-color:#99bbe8;line-height : 50px;padding-left:20px;font-size:22px;color:#000000;font-family:黑体;font-weight:bolder;' +
						'background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, rgba(153,187, 232, 0.4) ), color-stop(50%, rgba(153, 187, 232, 1) ),color-stop(0%, rgba(153, 187, 232, 0.4) ) )'
			});
			Ext.create('Ext.container.Viewport',{
				layout : 'border',
				items : [title,tab,tree],
				listeners : {
					afterrender : function(){
						Ext.getBody().mask('正在加载系统菜单....');
						ajax({
							url : "<%=request.getContextPath()%>/getMenuTreePanelList.do",// 获取面板的地址
							params : {
								action : "list"
							},
							callback : addTree
						});
					}
				}
			});
			
			function addTree(data) {
				data = data.data;
				Ext.getBody().unmask();
				for (var i = 0; i < data.length; i++) {
					tree.add(Ext.create("Ext.tree.Panel", {
						title : data[i].menuText,
						iconCls : data[i].iconCls,
						//useArrows: true,
						autoScroll : true,
						rootVisible : false,
						viewConfig : {
							loadingText : "正在加载..."
						},
						store : createStore(data[i].menuId),
						listeners : {
							afterlayout : function() {
								if (this.getView().el) {
									var el = this.getView().el;
									var table = el
											.down("table.x-grid-table");
									if (table) {
										table.setWidth(el.getWidth());
									}
								}
							},
							itemclick : function(view,node){
								if (node.isLeaf()) { //判断是否是根节点
									if(node.data.type === 'URL'){ //判断资源类型
										var panel = Ext.create('Ext.panel.Panel',{
											title : node.data.text,
											closable : true,
											iconCls : 'icon-activity',
											html : '<iframe width="100%" height="100%" frameborder="0" src="<%=request.getContextPath()%>'+node.data.component+'"></iframe>'
										});
										tab.add(panel);
										tab.setActiveTab(panel);
										$("#"+panel.id+"-body").find("iframe").css("height",$("#"+panel.id+"-body").css("height"));
									}else if(node.data.type === 'COMPONENT'){
										var panel = Ext.create(node.data.component,{
											title : node.data.text,
											closable : true,
											iconCls : 'icon-activity'
										});
										tab.add(panel);
										tab.setActiveTab(panel);
										panel.getView().refresh();
									}
								}
							}
						}
					}));
					tree.doLayout();
	
				}
			}
			var model = Ext.define("TreeModel", { // 定义树节点数据模型
				extend : "Ext.data.Model",
				fields : [{name : "id",type : "string"},
						{name : "text",type : "string"},
						{name : "iconCls",type : "string"},
						{name : "leaf",type : "boolean"},
						{name : 'type'},
						{name : 'component'}]
			});
			var createStore = function(id) { // 创建树面板数据源
				var me = this;
				return Ext.create("Ext.data.TreeStore", {
					defaultRootId : id, // 默认的根节点id
					model : model,
					proxy : {
						type : "ajax", // 获取方式
						url : "<%=request.getContextPath()%>/getMenuTreeNodeList.do" // 获取树节点的地址
					},
					clearOnLoad : true,
					nodeParam : "id"// 设置传递给后台的参数名,值是树节点的id属性
				});
			};
		});
		
	</script>
</html>