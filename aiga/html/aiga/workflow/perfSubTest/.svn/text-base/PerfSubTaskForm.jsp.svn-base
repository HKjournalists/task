<!DOCTYPE html>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.asiainfo.aiga.common.WorkflowParam"%>
<%@include file="/aiga/common/common.jsp"%>
<%
	String subTaskId = request.getParameter("objId");
	String subTaskType = request.getParameter("objType");
	String query = request.getParameter("query");
	boolean isRead = false;
	if(query != null && "1".equals(query)) {
		isRead = true;
	}
%>
<html>
	<head>
		<title>性能测试子任务</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/ie-tab.css">
		<style type="text/css">
			.float-form-left {
				float: left;
				display: none;
			}
			
			.float-form-left div {
				border-left: none;
			}
			
			.float-form-right {
				float: right;
				display: none;
			}
			
			.float-form-right div {
				border-right: none;
			}
			
			#formDiv {
				/*
				width: 100%;
				border: 1px solid #99bce8;
				*/
				display: inline-block;
				margin-bottom: 15px;
			}
			
			.fun-elem {
				position: relative;
				margin-left: 20px;
			}
			
			.none-border div {
				border-style: none;
			}
			
			.lab-fun-qry-img {
				cursor: pointer;
				position: relative;
				left: 2px;
				top: 2px;
			}
			
			.icon-ok {
				display: inline-block;
				width: 20px;
				height: 20px;
				background: url('<%=request.getContextPath()%>/css/images/yes.png')
					no-repeat;
			}
			
			.x-collapsed {
				border: none;
			}
		</style>
	</head>
	<body>
		<div id="base">
			<form id="perSubTaskForm" action="">
				<input type="hidden" name="perId" />
				<input type="hidden" name="sysName" />
				<input type="hidden" name="busiName" />
				<input type="hidden" name="simpleDesc" />
				<input type="hidden" name="acceptChannel" />
				<input type="hidden" name="proportion" />
				<input type="hidden" name="testOpinion" />
				<input type="hidden" name="averageTimeRequire" />
				<input type="hidden" name="tps" />
				<input type="hidden" name="peakBusi" />
				<input type="hidden" name="busiCity" />
				<input type="hidden" name="peakDesc" />
				<input type="hidden" name="webServer" />
				<input type="hidden" name="interServer" />
				<input type="hidden" name="appServer" />
				<input type="hidden" name="dbServer" />
				<input type="hidden" name="otherServer" />
				<input type="hidden" name="relaSubTaskId" value="<%=subTaskId%>" />
				<input type="hidden" name="channelCheck" />
				<input type="hidden" name="channelText" />
			</form>
			<div id="formDiv"></div>
			<div id="fileTrans" style="display: none;"><jsp:include
					page="/aiga/attach/fileTrans.jsp"></jsp:include></div>
		</div>
	</body>
	<script type="text/javascript">
		
		var screenWidth = document.documentElement.clientWidth;
		var screenHeight = document.documentElement.clientHeight;
		var extIndex = 0;
		var curCount = 0;
		var current_linkNo = '<%=WorkflowParam.getWorkflow("subTestTaskAys").getLinkNo()%>';
		var hasRefresh = false;
		var hasSysFolder = false;
		
		var resourceCellEdit = "";
        var reasonCellEdit = "";
		
		Ext.onReady(init);
		
		function init() {
			Ext.tip.QuickTipManager.init();
			
			resourceCellEdit = Ext.create('Ext.grid.plugin.CellEditing', {
            	clicksToEdit: 1
            });
            reasonCellEdit = Ext.create('Ext.grid.plugin.CellEditing', {
            	clicksToEdit: 1
            });
			regeditData();
			setInterval("hideXMask()",1000);
			addReqForm();
			addFunpTabs();
			//initPerSubForm();
			/*
			*/
		}
		
		function initPerSubForm() {
	  		MaskLoading();
			$.ajax({
	    		async: false,
				url: '<%=request.getContextPath()%>/getSubRelaPerForm.do',
				data: 'relaSubTaskId=<%=subTaskId%>',
				type: 'post',
				dataType: 'json',
				success: function(json) {
					$('#perSubTaskForm input[name]').each(function(){
						var fieldName = $(this).attr("name");
						$(this).val(json.data[fieldName]);
					});
				}
			});
	    	MaskOver();
		}
		
		function regeditData() {
			Ext.define('perfModel', {
				extend: 'Ext.data.Model',
				fields: [
					{name: 'pftId', type: 'string', convert: null},
					{name: 'taskTag', type: 'string'},
			        {name: 'testObjType', type: 'string', convert: null},
			        {name: 'testObjDscr', type: 'string'},
			        {name: 'perfDemand', type: 'string'}
				]
			});
			Ext.define('ResultInfo', {
				extend: 'Ext.data.Model',
				fields: [
					{name: 'resultId', type: 'string'},
					{name: 'subTaskId', type: 'string', defaultValue: '<%=subTaskId%>'},
					{name: 'sysName', type: 'string'},
					{name: 'funName', type: 'string'},
			        {name: 'targetName', type: 'string'},
			        {name: 'countAperture', type: 'string'},
			        {name: 'conditionDesc', type: 'string'},
					{name: 'targetValue', type: 'string'},
			        {name: 'resultDesc', type: 'string'},
			        {name: 'testValue', type: 'string'},
			        {name: 'resultJudge', type: 'string'},
					{name: 'resultReview', type: 'string'},
			        {name: 'resultExp', type: 'string'}
				]
			});
			Ext.define('InstCase', {
			    extend: 'Ext.data.Model',
			    fields: [
			        {name: 'caseId', type: 'int', convert: null},
			        {name: 'caseName', type: 'string'},
			        {name: 'funFolderId', type: 'int', convert: null},
			        {name: 'caseDesc', type: 'string'},
			        {name: 'createTime', type: 'string'},
			        {name: 'updateTime', type: 'string'},
			        {name: 'author', type: 'string'},
			        {name: 'latestOperator', type: 'string'},
			        {name: 'baseCaseId', type: 'int', convert: null},
			        
			        {name: 'sysLabel',  type: 'string'},
			        {name: 'ownLabel',  type: 'string'},
			        {name: 'url',  type: 'string'},
			        {name: 'approvalPsn',  type: 'string'},
			        {name: 'status', type: 'int', convert: null},
			        {name: 'apporvalName',  type: 'string'},
			        {name: 'approvalNo',  type: 'string'},
			        {name: 'authorNo', type: 'int'},
			        
			        {name: 'important', type: 'int', convert: null},
			        {name: 'maintenanceFac', type: 'int', convert: null},
			        {name: 'regressionTest', type: 'int', convert: null},
			        {name: 'hasTest', type: 'int', convert: null},
			        {name: 'testType', type: 'string'},
			        {name: 'caseType', type: 'string'},
			        {name: 'efficiencyTest', type: 'int', convert: null},
			        {name: 'efficiencyTestType', type: 'int', convert: null},
			        
			        {name: 'teminalTest', type: 'int', convert: null},
			        {name: 'casePerCond', type: 'string'},
			        {name: 'caseOperateInst', type: 'string'},
			        {name: 'preResult', type: 'string'},
			        {name: 'secId', type: 'int', convert: null},
			        {name: 'elemValue',  type: 'string'}
			    ]
			});
			Ext.define('FuncPoint',{
				extend: 'Ext.data.Model',
				fields: [
					{name: 'funId', type: 'int', convert: null},
			        {name: 'subTaskId',  type: 'int', convert: null},
			        {name: 'relaFolderId',  type: 'int', convert: null},
			        {name: 'sysId',  type: 'int', convert: null},
			        {name: 'sysName',  type: 'string'},
			        {name: 'createTime',  type: 'string'},
			        {name: 'updateTime',  type: 'string'},
			        {name: 'baseFunLabel',  type: 'string'},
			        {name: 'busiLabel',  type: 'string'},
			        {name: 'dataCheckScript',  type: 'string'},
			        {name: 'importantClass',  type: 'string'},
			        {name: 'menuPath',  type: 'string'},
			        {name: 'funType',  type: 'string', convert: null},
			        {name: 'funDesc',  type: 'string'},
			        {name: 'funTag',  type: 'string'},
			        {name: 'isInvalid',  type: 'int', convert: null}
				]
			});
			Ext.define('Knowledge',{
	        	extend: 'Ext.data.Model',
	        	fields:[
	        		{name:'knowledgeId', type:'int', convert: null},
	        		{name:'sysName', type:'string'},
	        		{name:'subSysName', type:'string'},
	        		{name:'moduleName', type:'string'},
	        		{name:'knowledgeName', type:'string'},
	        		{name:'knowledgeType', type:'int', convert: null},
	        		{name:'knowledgeDesc', type:'string'}
	        	]
	        });
			Ext.define('Resource', {
				extend: 'Ext.data.Model',
				fields: [
					{name: 'id', type: 'int', convert: null},
			        {name: 'subTaskId',  type: 'int', defaultValue:'<%=subTaskId%>'},
			        {name: 'resourceType',  type: 'String'},
			        {name: 'resourceDesc',  type: 'string'}
				]
			});
			Ext.define('SubReason', {
				extend: 'Ext.data.Model',
				fields: [
					{name: 'reasonId', type: 'string', convert: null},
			        {name: 'subTaskId',  type: 'int', defaultValue:'<%=subTaskId%>'},
			        {name: 'reasonType',  type: 'String', convert: null},
			        {name: 'reasonEnvType',  type: 'String', convert: null},
			        {name: 'reasonDesc',  type: 'string'}
				]
			});
			Ext.define('HisSeceneModel', {
				extend: 'Ext.data.Model',
				fields: [
					{name: 'operatorName', type: 'string'},
			        {name: 'operatorType',  type: 'string'},
			        {name: 'seceneName',  type: 'string'},
			        {name: 'operateTime',  type: 'string'},
			        {name: 'hisSecId',  type: 'string'}
				]
			});
			Ext.define('HisElemModel', {
				extend: 'Ext.data.Model',
				fields: [
					{name: 'elemName', type: 'string'},
			        {name: 'elemTag',  type: 'string'},
			        {name: 'operatorType',  type: 'string'},
			        {name: 'operateTime',  type: 'string'},
			        {name: 'operatorName',  type: 'string'},
			        {name: 'elemId',  type: 'string'}
				]
			});
			Ext.define('HisCaseModel', {
				extend: 'Ext.data.Model',
				fields: [
					{name: 'caseName', type: 'string'},
			        {name: 'operatorType',  type: 'string'},
			        {name: 'operateTime',  type: 'string'},
			        {name: 'operatorName',  type: 'string'}
				]
			});
			Ext.define('HisSubElemModel', {
				extend: 'Ext.data.Model',
				fields: [
					{name: 'elemName', type: 'string'},
			        {name: 'elemTag',  type: 'string'},
			        {name: 'operatorType',  type: 'string'},
			        {name: 'operateTime',  type: 'string'},
			        {name: 'operatorName',  type: 'string'}
				]
			});
			Ext.define('mapModel', {
		        extend: 'Ext.data.Model',
		        fields: [{
		                name: 'constantId',
		                type: 'string'
		            }, {
		                name: 'categoryName',
		                type: 'string'
		            }, {
		                name: 'category',
		                type: 'string'
		            }, {
		                name: 'show',
		                type: 'string'
		            }, {
		                name: 'value',
		                type: 'int'
		            }, {
		                name: 'other1',
		                type: 'string'
		            }, {
		                name: 'other2',
		                type: 'string'
		            }, {
		                name: 'memo',
		                type: 'string'
		            }
		        ]
		    });
			var workflowParamStore = new Ext.data.Store({
				autoLoad: true,
				mode: 'remote',
	            id: 'workflowParamStore',
	            fields: ['phaseId', 'phaseName', 'linkId', 'vmTaskName'],
	            proxy: {
	                type: 'ajax',
	                url: '<%=request.getContextPath()%>/getWorkflowParam.do?query=60000',
	                reader: {
	                    type: 'json',
	                    root: 'data'
	                }
	            }
	        });
	        var mapStore = new Ext.data.Store({
		        id: 'mapStore',
				mode: 'remote',
		        model: mapModel,
		        groupField: 'categoryName',
		        proxy: {
		        	async:false,
		            type: 'ajax',
		            url: '<%=request.getContextPath()%>/getMultipleSysConstant.do?categorys=ELEM_TYPE,IS_GLOBAL,ANALYSIS_METHOD,has_test',
		            reader: {
		                type: 'json',
		                root: 'data'
		            }
		        }
		    });
	        var knowledgeType = new Ext.data.Store({
				autoLoad: true,
				mode: 'remote',
			 	id: 'knowledgeType',
			    fields: ['value','show'],
			    proxy: {
				   	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=knowledge_type'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			   }
			});
			var subTaskClass = new Ext.data.Store({
				autoLoad: true,
				mode: 'remote',
			 	id: 'subTaskClass',
			    fields: ['value','show'],
			    proxy: {
				   	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=sub_task_class'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			   }
			});
			var reviewResult = new Ext.data.Store({
				autoLoad: true,
				mode: 'remote',
			 	id: 'reviewResult',
			    fields: ['value','show'],
			    proxy: {
				   	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=reviewResult'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			   }
			});
			var usableStore = new Ext.data.Store({
				autoLoad: true,
				mode: 'remote',
			 	id: 'usableStore',
			    fields: ['value','show'],
			    proxy: {
				   	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=usable'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			   }
			});
			var priorityStore = new Ext.data.Store({
	            autoLoad: true,
				mode: 'remote',
	            id: 'priorityStore',
	            fields: ['value', 'show'],
	            proxy: {
	                type: 'ajax',
	                url: '<%=request.getContextPath()%>/getComBox.do?query=priorityStore',
	                reader: {
	                    type: 'json',
	                    root: 'data'
	                }
	            }
	        });
	        var joinStore = new Ext.data.Store({
	            autoLoad: true,
				mode: 'remote',
	            id: 'joinStore',
	            fields: ['value', 'show'],
	            proxy: {
	                type: 'ajax',
	                url: '<%=request.getContextPath()%>/getSysParam.do?category=joinType',
	                reader: {
	                    type: 'json',
	                    root: 'data'
	                }
	            }
	        });
			var importance = new Ext.data.Store({
				autoLoad: true,
				mode: 'remote',
			 	id: 'importance',
			    fields: ['value','show'],
			    proxy: {
				   	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=req_importance'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			   }
			});
			var possible = new Ext.data.Store({
				autoLoad: true,
				id: 'possible',
				mode: 'remote',
				fields: ['value','show'],
				proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=possible'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			   }
			});
			var isUnion = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'isUnion',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=req_union'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var priority = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'priority',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=req_priority'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var testTaskStatus = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'testTaskStatus',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=test_task_status'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var isOverCircle = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'isOverCircle',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=is_over_circle'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var testImportance = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'testImportance',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=test_importance'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var reviewStatus = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'reviewStatus',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=req_reviewStatus'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var bigType = new Ext.data.Store({
				autoLoad: true,
				mode: 'remote',
			 	id: 'bigType',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getComBox.do?query=bigTypeStore'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var subType = new Ext.data.Store({
				autoLoad: true,
				mode: 'remote',
			 	id: 'subType',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getQryAndOther2.do?query=subTypeStore'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var funType = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'funType',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=fun_type'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var resType = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'resType',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=resource_type'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var reasonType = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'reasonType',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=test_unable_reason'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var reasonEnvType = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'reasonEnvType',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=test_unable_env'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			
			Ext.regModel('searchModel', {
				fields: [
			        {type: 'string',name:'sysName',mapping:'sysName'},
			        {type: 'string',name:'funId',mapping:'funId'}
			    ]
			});
			var searchStore = Ext.create('Ext.data.Store', {
				storeId:'searchStore',
				mode: 'remote',
				model:"searchModel",
			    proxy: {
			        type: 'ajax',
		        	url : '<%=request.getContextPath()%>/searchFunFolder.do',
			        reader: {
						type:"json",
						root: 'data'
			        }
			    }
			});
			
			var hisElemStore = Ext.create('Ext.data.Store', {
				autoLoad: true,
				mode: 'remote',
				storeId: 'hisElemStore',
				model: 'HisElemModel',
				proxy: {
					type: 'ajax',
					url: '<%=request.getContextPath()%>/getRelaHisElem.do?subTaskId=<%=subTaskId%>',
					reader: {
						type: 'json',
						root: 'data'
					}
				}
			});
			var hisSeceneStore = Ext.create('Ext.data.Store', {
				autoLoad: true,
				mode: 'remote',
				storeId: 'hisSeceneStore',
				model: 'HisSeceneModel',
				proxy: {
					type: 'ajax',
					url: '<%=request.getContextPath()%>/getRelaHisScene.do?subTaskId=<%=subTaskId%>',
					reader: {
						type: 'json',
						root: 'data'
					}
				}
			});
			var hisCaseStore = Ext.create('Ext.data.Store', {
				autoLoad: true,
				mode: 'remote',
				storeId: 'hisCaseStore',
				model: 'HisCaseModel',
				proxy: {
					type: 'ajax',
					url: '<%=request.getContextPath()%>/getRelaHisCase.do?subTaskId=<%=subTaskId%>',
					reader: {
						type: 'json',
						root: 'data'
					}
				}
			});
			var perfStore = Ext.create('Ext.data.Store', {
			     autoLoad: true,
				 mode: 'remote',
			     id: 'perfStore',
			     model: "perfModel",
			     proxy: {
			         type: 'ajax',
			         url: '<%=request.getContextPath()%>/getPerfTestTaskBySubId.do?subTaskId=<%=subTaskId%>',
			         reader: {
			             type: 'json',
			             root: 'data'
			         }
			     }
			});
			var testObjType = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'testObjType',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=testObj_Type'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var resultInfoStore = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			 	id: 'resultInfoStore',
			    model: 'ResultInfo',
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getPerfSubResultBySubTaskId.do?subTaskId=<%=subTaskId%>',
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
		}
		
		function hideXMask() {
			$(".x-mask").each(function(){
				if($(this).css("visibility") == "hidden") {
					$(this).addClass("not-dis");
				}
			});
		}
		
		function addReqForm() {
			var subTaskForm = new Ext.form.FormPanel({
				id: 'subTaskForm',
				renderTo: Ext.get('formDiv'),
				layout: 'vbox',
				collapsible: true,
				titleCollapse: true,
				title: '测试子任务信息',
				cls: 'ui-formPanel',
				width: screenWidth*0.96,
				bodyBorder: 1,
				fieldDefaults: {
				    labelAlign: 'right',
				    labelWidth: 60,
				    labelStyle: 'font-weight:bold'
				}, 
				defaults: { 
				    margins: '5 0 0 0'
				},
				items: [{
						xtype: 'fieldcontainer',
		                labelStyle: 'font-weight:bold;padding:0',
		                layout: 'hbox',
		                defaultType: 'textfield',
		                fieldDefaults: {
		                    labelAlign: 'right'
		                },
		                items:[{
						width: 920,
						name: 'subTaskName',
						xtype: 'textfield',
						fieldLabel: '子任务名称'
						}]
					},
					{
	                xtype: 'fieldcontainer', 
	                labelStyle: 'font-weight:bold;padding:0', 
	                layout: 'hbox', 
	                defaultType: 'textfield', 
	                fieldDefaults: { 
	                    labelAlign: 'right' 
	                }, 
	                items: [
		               {
		                    width: 230,
		                    xtype: 'datetimefield',
		                    name: 'createTime',
							readOnly: true,
		                    fieldLabel: '分派时间'
		                }, {
		                    xtype: 'combo',
		                	width: 230,
		                    name: 'subTaskStatus',
		                    fieldLabel: '测试子任务状态',
		                    store: 'workflowParamStore',
		                    valueField: 'linkId',
            				displayField: 'vmTaskName',
							readOnly: true,
		                }, {
			            	width: 230, 
			                xtype: 'textfield',
			                name: 'creatorStaff',
			                fieldLabel: '子任务派发人',
							readOnly: true,
		            	},{
		                	width: 230,
		                	name:"subTaskTag",
		                	fieldLabel : "子任务编号",
							readOnly: true,
		                },
		            	{
		                	xtype: "hidden",
		                	name:"subTaskId",
		                	fieldLabel : "子任务ID"
		                },{
		                	xtype: "hidden",
		                	name:"reqTag",
		                	fieldLabel : "需求Tag"
		                },{
		                	xtype: "hidden",
		                	name:"taskId",
		                	fieldLabel : "taskId"
		                },{
		                	xtype: 'hidden',
		                    name: 'taskTag',
		                    fieldLabel: '任务编号'
		                },{
		                	xtype: 'hidden',
		                    name: 'subTaskType',
		                    fieldLabel: '子任务类型'
		                },{
		                	xtype: 'hidden',
		                    name: 'creator'
		                },{
		                	xtype: 'hidden',
		                    name: 'curPhase'
		                },{
		                	xtype: 'hidden',
		                    name: 'testorId'
		                },{
		                	xtype: 'hidden',
		                    name: 'testorName'
		                },{
		                	xtype: 'hidden',
		                    name: 'isJoinDebug'
		                },{
		                	xtype: 'hidden',
		                    name: 'joinEnvironment'
		                },{
		                	xtype: 'hidden',
		                    name: 'submitStaffId'
		                },{
		                	xtype: 'hidden',
		                    name: 'subStaffName'
		                },{
		                	xtype: 'hidden',
		                    name: 'joinDebugVals'
		                },{
		                	xtype: 'hidden',
		                    name: 'joinDebugValsOther'
		                },{
		                	xtype: 'hidden',
		                    name: 'joinType'
		                },{
		                	xtype: 'hidden',
		                    name: 'auditRate'
		                },{
		                	xtype: 'hidden',
		                    name: 'scriptFunRate'
		                },{
		                	xtype: 'hidden',
		                    name: 'scriptPerRate'
		                },{
		                	xtype: 'hidden',
		                    name: 'usable'
		                },{
		                	xtype: 'hidden',
		                    name: 'testReply'
		                },{
		                	xtype: 'hidden',
		                    name: 'reqAnalysis'
		                },{
		                	xtype: 'hidden',
		                    name: 'nowTestInfo'
		                }
	                ]
	            }, {
	           		xtype: 'fieldcontainer',
	                labelStyle: 'font-weight:bold;padding:0',
	                layout: 'hbox',
	                defaultType: 'textfield',
	                fieldDefaults: {
	                    labelAlign: 'right'
	                },
					items:[{ 
	                    width: 230,
	                    xtype: 'datetimefield',
	                    name: 'factCompleteTime',
	                    readOnly: true,
	                    fieldLabel: '计划上线时间'
	                },
	                {
		            	width: 230,
		                name:'subTaskPriority',
		                xtype: 'combo',
		                displayField: 'show',
		                store: 'priorityStore',
		                valueField: 'value',
		                fieldLabel: '子任务优先级'
		            },{
		            	width: 230,
		                name:'bigType',
		                xtype: 'combo',
		                displayField: 'show',
		                store: 'bigType',
		                valueField: 'value',
		                fieldLabel: '系统大类',
					    listeners:{
					    	change: function(combo, newValue, oldValue, eOpts) {
					    		Ext.StoreMgr.get('subType').setProxy({type: 'ajax',
							        url: '<%=request.getContextPath()%>/getQryAndOther2.do?query=subTypeStore&other2='+newValue,
							        reader: {
							        	type: 'json',
							        	root: 'data'
							    }});
							    Ext.StoreMgr.get('subType').load();
					    		
					    	},
					    	select: function(combo, records, eOpts) {
					    		subTaskForm.getForm().findField('subType').clearValue();
					    	}
					    }
		            },{
		            	width: 230,
		                name:'subType',
		                xtype: 'combo',
		                displayField: 'show',
		                store: 'subType',
		                valueField: 'value',
		                <%if(isRead) {%>
	                    readOnly: true,
	                    <%}%>
		                fieldLabel: '系统子类'
		            }]
		        },
	            {
            		xtype: 'fieldcontainer',
	                labelStyle: 'font-weight:bold;padding:0',
	                layout: 'hbox',
	                fieldDefaults: {
	                    labelAlign: 'right'
	                },
					items:[
					/*
		            {
		            	width: 230,
		                name:'subTaskClass',
		                xtype: 'combo',
		                displayField: 'show',
		                store: 'subTaskClass',
		                valueField: 'value',
		                fieldLabel: '子任务分类',
		                listeners: {
		                	change: function(combo, newValue, oldValue, eOpts) {
			    				showHideClass(newValue);
			    			}
		                }
		            },
		            */
		            {
		            	width: 230,
		                name:'reviewResult',
		                xtype: 'combo',
		                displayField: 'show',
		                store: 'reviewResult',
		                valueField: 'value',
		                fieldLabel: '评审结果',
		                readOnly: true
		            }
		            /*
		            ,
		            {
		            	width: 130,
		                xtype: 'checkbox',
		                name:'isJointDebug',
		                fieldLabel: '是否联调',
		                listeners:{
		                	'change':function(obj, newValue, oldValue, eOpts){
		                		showJoinSysTab(newValue);
		                	}
		                }
		            }
		            */
		            ]}
		            ]
			});
			loadReq();
		}
		
		function loadReq() {
			Ext.getCmp("subTaskForm").getForm().load({url:'<%=request.getContextPath()%>/getTestSubTaskById.do',
				params:{subTaskId:'<%=subTaskId%>'},
	    		async: false,
				success: function(form, action) {
					var reqNo = action.result.data.reqTag;
					var taskId = action.result.data.taskId;
					/*
					Ext.getCmp('nowTestForm').getForm().findField('testReply').setValue(action.result.data.testReply);
					Ext.getCmp('nowTestForm').getForm().findField('reqAnalysis').setValue(action.result.data.reqAnalysis);
					Ext.getCmp('nowTestForm').getForm().findField('nowTestInfo').setValue(action.result.data.nowTestInfo);
					Ext.getCmp('nowTestForm').getForm().findField('usable').setValue(action.result.data.usable);
					*/
					if(form.findField('reviewResult').getValue() == 0) {
						form.findField('reviewResult').setValue('');
					}
					
					var value=Ext.getCmp('subTaskForm').getForm().findField('subTaskStatus').getValue();
					if(value==-1){
						Ext.getCmp('subTaskForm').getForm().findField('subTaskStatus').setValue("已关闭");
					}
				}
			});
		}
		
		function subReq() {
			//subJoinInfo();
			//setNowTestInfo();
			//saveSubTaskClassInfo();
			Ext.getCmp("subTaskForm").getForm().submit(
				{
					url:'<%=request.getContextPath()%>/saveSubTaskInfo.do',
					async: false,
					success: function(form, action) {
						saveReasons();
						loadReq();
					},
					failture: function(form, action) {;
						Ext.MessageBox.alert("提示","提交数据失败");
					}
				}
			);
		}
		
		function addFunpTabs() {
			var store = Ext.create('Ext.data.Store', {
			     autoLoad: true,
				 mode: 'remote',
			     model: "Resource",
			     proxy: {
			         type: 'ajax',
			         url: '<%=request.getContextPath()%>/getResources.do?subTaskId=<%=subTaskId%>'+'&_='+(new Date()).getTime(),
			         reader: {
			             type: 'json',
			             root: 'data'
			         }
			     }
			});
			var reasonStore = Ext.create('Ext.data.Store', {
				autoLoad: true,
				mode: 'remote',
				model: 'SubReason',
				proxy: {
			        type: 'ajax',
			        url: '<%=request.getContextPath()%>/getReasons.do?subTaskId=<%=subTaskId%>'+'&_='+(new Date()).getTime(),
			        reader: {
			            type: 'json',
			            root: 'data'
			        }
			    }
			});
			var tabs = new Ext.TabPanel({
				id: 'funTab',
				width: screenWidth*0.96,
				frame: true,
				height: 420,
				deferredRender: true,
				renderTo: Ext.get('base'),
				activeTab: 0,
				cls:"ui-tab-bar",
				bodyCls:"ui-tab-body",
				bodyBorder: 0,
				items: [
					Ext.create('Ext.grid.Panel', {
						title: '性能指标',
						id: 'perfPanel',
						store: 'perfStore',
						width:screenWidth*0.85,
					    columns: [
					    	{xtype:'rownumberer'},
					    	{dataIndex: 'pftId', hidden: true},
					    	{dataIndex: 'taskId', hidden: true},
					    	{header: '测试对象类型', dataIndex:'testObjType', editor:{xtype:'combo',displayField:'show', valueField:'value', store:'testObjType'},
					    		renderer:function(value){
					    			var rec = Ext.StoreMgr.get('testObjType').find('value',value);
					    			if(rec == -1) {
					    				return '';
					    			}
					    			return Ext.StoreMgr.get('testObjType').getAt(rec).raw.show;
					    		}
					    	},
					        {header: '对象描述', dataIndex: 'testObjDscr', field: 'textarea' ,height: 20,flex: 1},
					        {header: '性能描述', dataIndex: 'perfDemand', field: 'textarea' ,height: 20,flex: 1}
					    ],
					    selType: 'cellmodel',
					    plugins: [
					        Ext.create('Ext.grid.plugin.CellEditing', {
					            clicksToEdit: 1
					        })
					    ],
					    height: 200,
					    width: screenWidth*0.85,
					    /*
					    tbar: [
						    {
						    	text: '新增',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		var r = Ext.create('perfModel');
						    		var index = perfStore.data.length;
							    	perfStore.insert(index,r);
							    	Ext.getCmp('perfPanel').getView().refresh();
						    	}
						    },
						    {
						    	text: '删除',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		confirmDelPerf();
						    	}
						    },
						     {
						    	text: '保存',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		savePerfTask();
						    	}
						    }
					    ]
					    */
					}),
					{id:'tab1',title:'功能点列表',html:'',autoScroll: true,
						listeners:{
							activate: function(tab) {
								if(hasRefresh) {
									return;
								}
								hasRefresh = true;
								setTimeout("refreshFuns()",300);
							},
							show: function(curTab, eOpts) {
								<%if(!isRead) {%>
								$("#addFunBtn").css("display","block");
								<%}%>
							},
							hide: function(curTab, eOpts) {
								<%if(!isRead) {%>
								$("#addFunBtn").css("display","none");
								<%}%>
							}
						}
					},
					new Ext.form.Panel({
						title: '变更信息',
						items:[
							Ext.create('Ext.grid.Panel', {
								id: 'hisElemGrid',
					    		title:'要素变更历史',
								cls: 'ui-formPanel',
								store: 'hisElemStore',
								listeners: {
									show: function(curTab, eOpts) {
										Ext.getCmp('hisElemGrid').getStore().reload();
										Ext.getCmp('hisSeceneGrid').getStore().reload();
									}
								},
							    columns: [
							    	{xtype:'rownumberer'},
							        {hidden: true, dataIndex: 'elemId'},
							        {header: '要素名称',  dataIndex: 'elemName' ,width:200},
							        {header: '要素编号', dataIndex: 'elemTag',width: 200},
							        {header: '修改类型', dataIndex: 'operatorType',
							        	renderer: function(value) {
							        		if(value == "add") {
							        			return "增加";
							        		} else if(value == "modify") {
							        			return "修改";
							        		} else if(value == "delete") {
							        			return "删除";
							        		}
							        	}
							        },
							        {header: '操作时间', dataIndex: 'operateTime', width: 140},
							        {header: '操作员', dataIndex: 'operatorName'},
							        {header: '明细',renderer:function(val){return '<a href="javascript:void(0)" onclick="viewHisSubElem()">查看子元素明细</a>';}}
							    ],
							    height: 150,
							    width: screenWidth*0.75
							}),
						Ext.create('Ext.grid.Panel', {
				    		title:'场景变更历史',
							cls: 'ui-formPanel',
							store: 'hisSeceneStore',
						    columns: [
						    	{xtype:'rownumberer'},
						        {header: '场景名称',  dataIndex: 'seceneName',width:230},
						        {header: '修改类型', dataIndex: 'operatorType',
						        	renderer: function(value) {
						        		if(value == "add") {
						        			return "增加";
						        		} else if(value == "modify") {
						        			return "修改";
						        		} else if(value == "delete") {
						        			return "删除";
						        		}
						        	}
						        },
						        {header: '操作员工', dataIndex: 'operatorName'},
						        {header: '操作时间', dataIndex: 'operateTime', width: 140}
						    ],
						    height: 150,
						    width: screenWidth*0.75
						})]
					}),
					Ext.create('Ext.grid.Panel', {
						title: '变更用例',
						id: 'hisCaseGrid',
						store: 'hisCaseStore',
						width:screenWidth*0.85,
						columns: [
							{xtype:'rownumberer'},
					        {header: '用例名称',  dataIndex: 'caseName',width:230},
					        {header: '修改类型', dataIndex: 'operatorType',
					        	renderer: function(value) {
						        		if(value == "add") {
						        			return "增加";
						        		} else if(value == "modify") {
						        			return "修改";
						        		} else if(value == "delete") {
						        			return "删除";
						        		}
						        	}
					        },
					        {header: '操作员工', dataIndex: 'operatorName'},
					        {header: '操作时间', dataIndex: 'operateTime', width: 140}
						]
					}),
					Ext.create('Ext.grid.Panel', {
						title: '子任务结果信息',
						id: 'resultInfo',
						store: 'resultInfoStore',
						width:screenWidth*0.85,
						selType: 'cellmodel',
					    plugins: [
					        Ext.create('Ext.grid.plugin.CellEditing', {
					            clicksToEdit: 1
					        })
					    ],
					    tbar: [
						    {
						    	text: '新增',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		var r = Ext.create('ResultInfo');
						    		var index = Ext.StoreMgr.get('resultInfoStore').data.length;
							    	Ext.StoreMgr.get('resultInfoStore').insert(index,r);
							    	Ext.getCmp('resultInfo').getView().refresh();
						    	}
						    },
						    {
						    	text: '删除',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		confirmDelResultInfo();
						    	}
						    },
						    {
						    	text: '保存',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		saveResultInfo();
						    	}
						    }
					    ],
						columns: [
							{xtype:'rownumberer'},
							{dataIndex: 'resultId', hidden: true},
							{dataIndex: 'subTaskId', hidden: true},
					        {header: '系统',  dataIndex: 'sysName', field: 'textfield'},
					        {header: '功能', dataIndex: 'funName', field: 'textfield'},
					        {header: '指标名称', dataIndex: 'targetName', field: 'textfield'},
					        {header: '统计口径', dataIndex: 'countAperture', field: 'textfield'},
					        {header: '生产条件说明', dataIndex: 'conditionDesc', field: 'textfield'},
					        {header: '目标值', dataIndex: 'targetValue', field: 'textfield'},
					        {header: '测试结果说明', dataIndex: 'resultDesc', field: 'textfield'},
					        {header: '测试值', dataIndex: 'testValue', field: 'textfield'},
					        {header: '测试判定结果', dataIndex: 'resultJudge', field: 'textfield'},
					        {header: '最终结果评审', dataIndex: 'resultReview', field: 'textfield'},
					        {header: '结果说明', dataIndex: 'resultExp', field: 'textfield'}
						]
					}),
					Ext.create('Ext.grid.Panel', {
						title: '资源描述',
						id: 'resPanel',
						store: store,
						width:screenWidth*0.85,
					    columns: [
					    	{xtype:'rownumberer'},
					    	{dataIndex: 'id', hidden: true},
					    	{dataIndex: 'reqId', hidden: true},
					    	{header: '资源类型', dataIndex:'resourceType', editor:{xtype:'combo',displayField:'show', valueField:'value', store:'resType'},
					    		renderer:function(value){
					    			var rec = Ext.StoreMgr.get('resType').find('value',value);
					    			if(rec == -1) {
					    				return '';
					    			}
					    			return Ext.StoreMgr.get('resType').getAt(rec).raw.show;
					    		}
					    	},
					        {header: '资源描述', dataIndex: 'resourceDesc', field: 'textfield' ,height: 20,flex: 1}
					    ],
					    selType: 'cellmodel',
					    plugins: [
					        resourceCellEdit
					    ],
					    height: 200,
					    width: screenWidth*0.85,
					    tbar: [
						    {
						    	text: '新增',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		var r = Ext.create('Resource');
						    		var index = store.data.length;
							    	store.insert(index,r);
							    	Ext.getCmp('resPanel').getView().refresh();
						    	}
						    },
						    {
						    	text: '删除',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		confirmDelRes();
						    	}
						    },
						    {
						    	text: '保存',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		saveResources();
						    	}
						    }
					    ]
					}),
					Ext.create('Ext.grid.Panel', {
						title: '可测性分析',
						id: 'reasonPanel',
						store: reasonStore,
						width:screenWidth*0.8,
					    columns: [
					    	{xtype:'rownumberer'},
					    	{dataIndex: 'reasonId', hidden: true},
					    	{dataIndex: 'subTaskId', hidden: true},
					    	{header: '不可测环境', dataIndex:'reasonEnvType', editor:{xtype:'combo',displayField:'show', valueField:'value', store:'reasonEnvType'},
					    		renderer:function(value){
					    			var rec = Ext.StoreMgr.get('reasonEnvType').find('value',value);
					    			if(rec == -1) {
					    				return '';
					    			}
					    			return Ext.StoreMgr.get('reasonEnvType').getAt(rec).raw.show;
					    		}
					    	},
					    	{header: '不可测类型', dataIndex:'reasonType', editor:{xtype:'combo',displayField:'show', valueField:'value', store:'reasonType'},
					    		renderer:function(value){
					    			var rec = Ext.StoreMgr.get('reasonType').find('value',value);
					    			if(rec == -1) {
					    				return '';
					    			}
					    			return Ext.StoreMgr.get('reasonType').getAt(rec).raw.show;
					    		}
					    	},
					        {header: '不可测描述', dataIndex: 'reasonDesc', field: 'textfield' ,height: 20,flex: 1}
					    ],
					    selType: 'cellmodel',
					    plugins: [
					        reasonCellEdit
					    ],
					    height: 200,
					    width: screenWidth*0.85,
					    tbar: [
						    {
						    	text: '新增',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		var r = Ext.create('SubReason');
						    		var index = reasonStore.data.length;
							    	reasonStore.insert(index,r);
							    	Ext.getCmp('reasonPanel').getView().refresh();
						    	}
						    },
						    {
						    	text: '删除',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		confirmDelReason();
						    	}
						    },
						     {
						    	text: '保存',
						    	height: 20,
						    	width: 40,
						    	handler: function() {
						    		saveReasons();
						    	}
						    }
					    ]
					}),
					{title: "历史轨迹",width:screenWidth*0.8,height:350,html: '<iframe id="f_1" scrolling="auto" frameborder="0" width="100%" height="250" src="<%=request.getContextPath()%>/aiga/workflow/common/HistoryTrack.jsp?objId=${param.objId}&objType=${param.objType}"></iframe>'},
					{
						title: '附件列表',
						contentEl:'fileTrans',
	                    listeners:{
	                    	beforeshow:function(tab,eOpts){
	                    		$('#fileTrans').show();
	                    		var subTaskTag = Ext.getCmp('subTaskForm').getForm().findField('subTaskTag').getValue();
                    			initPackList(subTaskTag, '3', current_linkNo,'0','0',false);
	                    	}
	                    }
                    },
                    Ext.form.Panel({
                    	title: '联调信息',
                    	id:'joinPanel',
                    	layout: 'vbox',
                    	defaults: {margins: '5 0 0 0'},
                    	listeners:{
							activate: function(tab) {
								showJoinSysHtml();
							}
						},
			  			items:[
							{
							    xtype: 'fieldcontainer',
							    layout: 'hbox',
							    defaultType: 'textfield',
							    fieldDefaults: { 
							        labelAlign: 'right',
							        labelWidth: 100,
							        width: 230
							    },
							    items: [
							    	{id:'joinPanelType',xtype:'combo',displayField:'show',valueField:'value',store:'joinStore',name: 'joinType',fieldLabel: '联调类型',
							    		listeners:{
							    			'select':function(obj, record, eOpts) {
							    				var sel = record[0].data.value;
							    				showHideJoinSys(sel);
							    			}
							    		}
							    	}
							    ]
							},
							{
								layout: 'hbox',
							    fieldDefaults: { 
							        labelAlign: 'right',
							        labelWidth: 100,
							        width: 230
							    },
							    items:[
							    	{html:'<div id="joinSys1" class="joinDiv"></div><div id="joinSys2" class="joinDiv"></div>'}
							    ]
							}
						]
                    })
                ],
				buttons:[
					//{text:'分析完毕（全部提交）',handler: funSave}
					//{text:'查看用例集',handler: function(){viewCollection();}}
				]
			});
			var zTabs = Ext.select("#funTab");
			zTabs.insertHtml("afterBegin",'<div id="viewRelaCase" style="position: absolute; right: 90px; top: 5px; z-index: 2;"><a href="javascript:void(0);" class="W_btn_b fn-mr-20" onclick="viewRelaCase();return false;"><span>查看关联用例</span></a></div>');
			zTabs.insertHtml("afterBegin",'<div id="addFunBtn" style="position: absolute; right: -16px; top: 5px; z-index: 2;display: none;"><a href="javascript:void(0);" class="W_btn_c fn-mr-20" onclick="addFunArea();return false;"><span>新增功能点</span></a></div>');
			new Ext.form.Panel({
                    	title: '对账测试',
                    	id: 'accountTest',
                    	layout: 'vbox',
						fieldDefaults: {
						    labelAlign: 'right', 
						    labelWidth: 200, 
						},
						defaults: {
						    margins: '10 0 5 0'
						},
						listeners:{
							afterrender: function(panel, eOpts) {
								refreshAccountTestTbl();
							}
						},
						items:[
							{html:'<table id="accountTestTbl" class="acc_test_tbl" cellspacing="0" cellpadding="2">'+
							'<thead><tr><th width="100" rowspan="2">对账类型</th><th width="100"  rowspan="2">对账记录数</th><th colspan="2">对账测试（剔除合理差异）</th>'+
							'<th colspan="2">对账测试（原始差异）</th><th colspan="4">对账裸差</th></tr>'+
							'<tr><th width="100" >话单或账单一致率</th><th width="100" >费用一致率</th><th width="100" >话单或账单一致率</th>'+
							'<th width="100" >费用一致率</th><th width="100" >裸差用户数</th><th width="100" >裸差费用</th>'+
							'<th width="100" >平均用户裸差费用</th><th width="100" >用户裸差费用分档分布</th></tr></thead><tbody></tbody></table>'}
						]
                    });
                    new Ext.form.Panel({
                    	title: '数据稽核',
                    	id: 'dataAudit',
                    	layout: 'vbox',
						fieldDefaults: {
						    labelAlign: 'right', 
						    labelWidth: 120, 
						},
						defaults: {
						    margins: '10 0 5 0'
						},
						listeners:{
							afterrender: function(panel, eOpts) {
								refreshAuditDiv();
							}
						},
						items:[
							{html:'<div id="auditDiv" class="checkTbl"></div>'}
						]
                    });
                    new Ext.form.Panel({
                    	title: '割接测试',
                    	id: 'cutOverTest',
						layout: 'vbox',
						fieldDefaults: { 
						    labelAlign: 'right', 
						    labelWidth: 120, 
						    width: screenWidth*0.8
						},
						defaults: {
						    margins: '10 0 5 0'
						},
						items:[
							{xtype:'textareafield',fieldLabel:'【数据稽核准确率】',name:'cutOverDataRate',height: 80},
							{xtype:'textareafield',fieldLabel:'【脚本功能测试通过率】',name:'cutOverFunRate',height: 80},
							{xtype:'textareafield',fieldLabel:'【脚本性能测试通过率】',name:'cutOverPerRate',height: 80}
						]
                    });
                    showJoinSysTab(false);
			}
		
		function showHideJoinSys(val) {
			showJoinSysHtml();
			var other = Ext.getCmp("subTaskForm").getForm().findField("joinDebugValsOther").getValue();
			if(val == 1) {
				$("#joinSys2").hide();
				$("#joinSys1").show();
				$("#joinSys1").find("input[name=joinDebugValsOther]").val(other);
			} else {
				$("#joinSys1").hide();
				$("#joinSys2").show();
				$("#joinSys2").find("input[name=joinDebugValsOther]").val(other);
			}
		}
		
		function showJoinSysHtml() {
			if(hasSysFolder) {
				return;
			}
			hasSysFolder = true;
			$.ajax({
				url:'<%=request.getContextPath()%>/getSysFolder.do',
	    		async: false,
				dataType:'json',
				type:'post',
				success: function(json) {
					var sys1Html = "";
					var sys2Html = "";
					var jsonData = json.data;
					for(var sys = 0; sys <jsonData.length; sys++) {
						var sysFirm = jsonData[sys].firm;
						var typeAry = sysFirm.split(",");
						var is1 = false;
						for(var s in typeAry) {
							if(typeAry[s] == "1") {
								is1 = true;
								break;
							}
						}
						if(is1) {
							sys1Html += "<span><label><input type='checkbox' name='joinSys1' value='" + jsonData[sys].sysId + "' />"+ jsonData[sys].sysName+"</label></span>";
						} else {
							sys2Html += "<span><label><input type='checkbox' name='joinSys2' value='" + jsonData[sys].sysId + "' />"+ jsonData[sys].sysName+"</label></span>";
						}
					}
					sys1Html += "<span class='otherJoinSpan'><label>其他<input type='text' name='joinDebugValsOther' /></label></span>";
					sys2Html += "<span class='otherJoinSpan'><label>其他<input type='text' name='joinDebugValsOther' /></label></span>";
					$("#joinSys1").html(sys1Html);
					$("#joinSys2").html(sys2Html);
					var joinDebugVals = Ext.getCmp("subTaskForm").getForm().findField("joinDebugVals").getValue();
					if(joinDebugVals == null) {
						joinDebugVals = "";
					}
					var joinType = Ext.getCmp("subTaskForm").getForm().findField("joinType").getValue();
					if(joinType == null || joinType == "") {
						joinType = "1";
					}
					Ext.getCmp("joinPanelType").select(parseInt(joinType));
					var joinValAry = joinDebugVals.split(",");
					for(var i = 0; i < joinValAry.length; i++) {
						$("input[type=checkbox][value="+joinValAry[i]+"]").attr("checked",true);
					}
					showHideJoinSys(joinType);
					Ext.getCmp("joinPanel").doLayout();
				}
			});
		}
		
		function subJoinInfo() {
			var isJoin = Ext.getCmp("subTaskForm").getForm().findField("isJointDebug").getValue();
			var joinType = Ext.getCmp("joinPanelType").getValue();
			var typeAry = new Array();
			var joinDebugValsOther = "";
			if(isJoin && joinType) {
				if(joinType == 1) {
					$("#joinSys1").find("input[name=joinSys1]:checked").each(function(){
						typeAry.push($(this).val());
					});
					joinDebugValsOther = $("#joinSys1").find("input[name=joinDebugValsOther]").val();
				} else {
					$("#joinSys2").find("input[name=joinSys2]:checked").each(function(){
						typeAry.push($(this).val());
					});
					joinDebugValsOther = $("#joinSys2").find("input[name=joinDebugValsOther]").val();
				}
				Ext.getCmp("subTaskForm").getForm().findField("joinType").setValue(joinType);
				Ext.getCmp("subTaskForm").getForm().findField("joinDebugValsOther").setValue(joinDebugValsOther);
				Ext.getCmp("subTaskForm").getForm().findField("joinDebugVals").setValue(typeAry);
			}
		}
		
		function confirmRemoveFun() {
			var funId = $(event.srcElement).parents(".tab1-fun").attr("id");
			Ext.MessageBox.confirm('提示','确定要删除该功能点？',function(btn){
				if(btn == 'yes') {
					removeFun(funId);
				} else {
					return;
				}
			});
		}
		
		function removeFun(funId) {
			var funIndex = $("#tab1-body").find(".tab1-fun").length;
			/*
			if(funIndex == 1) {
				alert("无法删除最后节点");
				return;
			}
			*/
			var curIndex = funId.replace("funP","");
			var curFunTag = Ext.getCmp("funP"+curIndex).getForm().findField("funTag").getValue();
	  		MaskLoading();
			$.ajax({
	    		async: false,
				url: '<%=request.getContextPath()%>/deleteFunPoint.do',
				type: 'POST',
				dataType: "json",
				data: 'funTag='+curFunTag+'&_='+(new Date()).getTime(),
				success: function(json) {
					Ext.getCmp('tab1').remove(Ext.getCmp('funP'+curIndex));
					curCount--;
					//$("#funP"+curIndex).remove();
					//$("#elem"+curIndex).remove();
					refreshFunList();
				}
			});
	    	MaskOver();
		}
		
		function refreshFunList() {
			$("#tab1-body").find(".tab1-fun").each(function(index){
				index++;
				var id = $(this).attr("id");
				//Ext.getCmp(id).setTitle("功能点"+index);
			});
			$("#tab1-body").find(".x-grid").each(function(index){
				index++;
				var id = $(this).attr("id");
				//Ext.getCmp(id).setTitle("列表要素"+index);
			});
			Ext.getCmp('funTab').doLayout();
		}
		
		function funSave() {
			MaskLoading();
			subReq();
			$("#tab1-body").find(".tab1-fun").each(function(index){
				index++;
				var id = $(this).attr("id");
				var funPNo = id.replace("funP","");
				subCurFun(funPNo, false, false);
			});
			saveResources();
			MaskOver();
			top.Ext.Msg.alert("提示","数据提交成功");
			return true;
		}
		
		function funSub() {
			/*
			*/
			//var isPer = Ext.getCmp("subTaskForm").getForm().findField('isPerformance').getValue();
			//var sysName = $('#perSubTaskForm>input[name=sysName]').val();
			//if(isPer&&(sysName == null || sysName == "")) {
			//	Ext.Msg.alert('提示','请输入性能测试任务单！');
			//	return;
			//}
			if(!checkBeforeSubmit()) {
				return false;
			}
			MaskLoading();
			subReq();
			var correct = true;
			$("#tab1-body").find(".tab1-fun").each(function(index){
				index++;
				var id = $(this).attr("id");
				var funPNo = id.replace("funP","");
				subCurFun(funPNo, false, false);
			});
			saveResources();
			MaskOver();
			//top.Ext.Msg.alert("提示","数据提交成功");
			if(!correct) {
				top.Ext.Msg.alert("提示","请在功能点名称中输入选择功能点，或者删除无效功能点，然后才能设计完成");
			}
			return correct;
			//perSubTaskSub();
		}
		
		function saveResources() {
			resourceCellEdit.completeEdit();
			var curRes = Ext.getCmp('resPanel').getSelectionModel().getSelection();
			var resStore = Ext.getCmp('resPanel').getStore();
			var resources = new Array();
			resStore.each(function(rec){
				resources.push(Ext.encode(rec.data));
			});
			resources = "[" + resources + "]";
			$.ajax({
	    		async: false,
				type: 'POST',
				dataType: "json",
				url: '<%=request.getContextPath()%>/saveResources.do',
				data: 'table='+resources+"&_=" + (new Date()).getTime(),
				success: function(data) {
					resStore.reload();
				}
			});
		}
		
		function saveReasons() {
			reasonCellEdit.completeEdit();
			var curReason = Ext.getCmp('reasonPanel').getSelectionModel().getSelection();
			var reasonStore = Ext.getCmp('reasonPanel').getStore();
			var reasons = new Array();
			reasonStore.each(function(rec){
				reasons.push(Ext.encode(rec.data));
			});
			reasons = "[" + reasons + "]";
			$.ajax({
	    		async: false,
				type: 'POST',
				dataType: "json",
				url: '<%=request.getContextPath()%>/saveReasons.do?subTaskId=<%=subTaskId%>',
				data: 'table='+reasons+"&_=" + (new Date()).getTime(),
				success: function(data) {
					reasonStore.reload();
				}
			});
		}
		
		function getNewFunTag() {
			var date = new Date();
			var month = date.getMonth()+1;
			var day = date.getDate();
			var hour = date.getHours();
			var min = date.getMinutes();
			var sec = date.getSeconds();
			var newTag = "FUN"+pad2(month)+pad2(day)+pad2(hour)+pad2(min)+pad2(sec)+Math.ceil(Math.random()*10000);
			return newTag;
		}
		
		function pad2(str) {
			var len = str.toString().length;
			while(len<2) {
				str = "0" + str;
				len = str.toString().length;
			}
			return str;
		}
		
		function refreshFuns() {
	  		MaskLoading();
			$.ajax({
	    		async: false,
				url: '<%=request.getContextPath()%>/getFunPoints.do',
				type: 'POST',
				dataType: "json",
				data: 'subTaskId=<%=subTaskId%>'+'&_='+(new Date()).getTime(),
				success: function(json) {
					var ary = json.data;
					for(var i = 0; i < ary.length; i++) {
						addFunArea(ary[i]);
					}
					if(ary.length == 0) {
						//addFunArea();
					}
					expandFirstFun();
				}
			});
	    	MaskOver();
		}
		
		function addFunArea(data, isCopy, isLabel) {
			collapseAllFun();
			var isCollapsed = false;
			var newTag = getNewFunTag();
			var relaId = 0;
			var curFunId = 0;
			if(data != null) {
				newTag = data.funTag;
				if(isCopy == null) {
					isCollapsed = true;
				}
				relaId = data.relaFolderId;
				curFunId = data.funId;
			}
			var funType = new Ext.data.Store({
			 	autoLoad: true,
				mode: 'remote',
			    fields: ['value','show'],
			    proxy: {
			    	type: 'ajax',
			        url: '<%=request.getContextPath()%>/getSysParam.do?category=fun_type'+'&_='+(new Date()).getTime(),
			        reader: {
			        	type: 'json',
			        	root: 'data'
			        }
			    }
			});
			var funForm = new Ext.form.FormPanel({
				title: '功能点'+(++curCount),
				id: 'funP'+(++extIndex),
				width: screenWidth*0.88,
				cls: 'ui-formPanel tab1-fun',
				margin:'0 0 5 0',
				defaults: {
				    margins: '5 0 5 0'
				},
				collapsed: isCollapsed,
				titleCollapse: true,
				collapsible: true,
				bodyBorder: 0,
				layout: 'vbox',
				listeners:{
					beforeexpand:function() {
						collapseAllFun();
					}
				},
				items: [
					{
						layout: 'hbox',
						width:screenWidth*0.78,
						border: 0,
						items: [
							{fieldLabel: '功能点名称',labelAlign: 'right',width:300,xtype: 'combo',name: 'sysName',store: 'searchStore',<%if(isRead){%>readOnly: true,<%}%>
            					minChars:1,queryCaching:true,queryParam : 'kw',displayField: 'sysName',typeAhead: true,
            					typeAheadDelay: 800, hideTrigger: true,
            					listeners:{
            						select: function(comp, The, eOpts){
            							var curIndex = funForm.getId().replace("funP","");
            							var funId = funForm.getForm().findField('funId').getValue();
					            		funForm.getForm().load({
					            			url: '<%=request.getContextPath()%>/getFunFolderByFunId.do',
					            			async: false,
					            			params: {funId: The[0].raw.funId},
					            			success: function(form, action) {
					            				form.findField('funId').setValue(funId);
					            				form.findField('relaFolderId').setValue(The[0].raw.funId);
					            				form.findField('subTaskId').setValue("<%=subTaskId%>");
					            				
					            				Ext.getCmp('tipFunP'+curIndex).destroy();
					            				Ext.create('Ext.tip.ToolTip', {
													id: 'tipFunP'+curIndex,
											        target: 'funPType'+curIndex,
											        width: 200,
											        autoLoad: {
											        	url: '<%=request.getContextPath()%>/getFunTypeTips.do',
											        	params: { funType: form.findField('funType').getValue()}
											        },
											        dismissDelay: 15000
											    });
					            			}
					            		});
					            		setTimeout("subCurFun("+curIndex+", false, true)", 500);
									 	return;
					            	},
					            	beforeselect: function(combo, record, index, eOpts ){
					            		//console.log(index);
					            		//console.log(eOpts);
					            	}
				            	},
					            listConfig: {
					                loadingText: 'Searching...',
					                emptyText: '没有搜索到结果'
					            }
					            //pageSize: 10
					        },
					        <%if(!isRead){%>
					        {cls:'none-border',html:"<img class='lab-fun-qry-img' width='18' height='18' src='<%=request.getContextPath()%>/css/images/search.png' onclick='relaFunFolder()' title='根据标签查找功能点' />"},
					        <%}%>
							{labelAlign: 'right',id:'funPType'+extIndex,width:300,xtype: 'combo',
								readOnly:true,fieldLabel: '功能点类型',store: funType,displayField: 'show',valueField: 'value',name: 'funType',
							},
							//{cls:'none-border',html:"<a href='javascript:void(0)' onclick=\"qryKnowledgeWindow('funP"+extIndex+"')\">查询知识点</a>"},
							//{cls:'none-border',html:"<a href='javascript:void(0)' style='margin-left:10px;' onclick=\"qryFunHistory('funP"+extIndex+"')\">查询功能点历史</a>"},
							{xtype:'hidden',fieldLabel:'主键',name:'funId',convert: null},
							{xtype:'hidden',fieldLabel:'关联子任务ID',name:'subTaskId',value:'<%=subTaskId%>'},
							{xtype:'hidden',fieldLabel:'关联模板ID',name:'relaFolderId'},
							{xtype:'hidden',fieldLabel:'创建日期',name:'createTime'},
							{xtype:'hidden',fieldLabel:'更新日期',name:'updateTime'},
							{xtype:'hidden',fieldLabel:'归属系统ID',name:'sysId'},
							{xtype:'hidden',fieldLabel:'业务标签',name:'busiLabel'},
							{xtype:'hidden',fieldLabel:'基础功能标签',name:'baseFunLabel'},
							{xtype:'hidden',fieldLabel:'数据检查脚本',name:'dataCheckScript'},
							{xtype:'hidden',fieldLabel:'重要级别',name:'importantClass'},
							{xtype:'hidden',fieldLabel:'菜单路径',name:'menuPath'},
							{xtype:'hidden',fieldLabel:'功能点编号',name:'funTag'},
							{xtype:'hidden',fieldLabel:'功能点描述',name:'funDesc'},
							{xtype:'hidden',fieldLabel:'是否已被禁用',name:'isInvalid'}
						]
					}
				]
			});
			var testSeceneRModel = Ext.regModel("testSeceneRModel",{
				fields:[
					{name:'caseId',type:'string'},
					{name:'caseName',type:'string'},
					{name:'secId',type:'string'},
					{name:'casePreCond',type:'string'},
					{name:'caseOperateInst',type:'string'},
					{name:'preResult',type:'string'},
					{name:'hasTest',type:'string'},
					{name:'ownLabel',type:'string'}
				]
			});
			
			var testSeceneRProxy = new Ext.data.proxy.Ajax({
				type:"ajax",
				model:testSeceneRModel,
				url:'<%=request.getContextPath()%>/getCaseByFunId.do?funId='+curFunId+'&relaId='+relaId,
				reader:{
					root:"data",
					type:"json"
				}
			});
			var testSeceneRStore = Ext.create('Ext.data.Store',{
				autoLoad: true,
				mode: 'remote',
				model:testSeceneRModel,
				proxy:testSeceneRProxy,
				listeners:{
				}
			});
			var gridPanel = Ext.create('Ext.grid.Panel', {
			    //title:'包含用例',
				cls: 'ui-formPanel fun-elem',
			    id: 'caseList'+extIndex,
			    store: testSeceneRStore,
			    columns: [
			    	{xtype:'rownumberer'},
			        {header:"主键",width:100,dataIndex:"caseId",sortable:true,hidden:true},
					{header:"测式场景",width:100,dataIndex:"ownLabel",sortable:true,renderer: function (value,cellmeta,record){
			              try {
			                  var store = Ext.data.StoreManager.lookup("mapStore");
			                  store.clearFilter(true);
			                  store.filter("categoryName", "secene_show");
			                  return store.findRecord("value", value).getData().show + "";
			              } catch (e) {
			                  return ""+value;
			              };
			          }},
					{header:"用例名称",width:100,dataIndex:"caseName",sortable:true},
					{header:"用例前置条件",width:100,dataIndex:"casePreCond",sortable:true},
					{header:"用例操作说明",width:100,dataIndex:"caseOperateInst",sortable:true},
					{header:"预期结果",width:100,dataIndex:"preResult",sortable:true}
					/*,
					{header:"需要实现自动化",width:100,dataIndex:"hasTest",sortable:true,renderer: function (value,cellmeta,record){
			             try {
			                 var store = Ext.data.StoreManager.lookup("mapStore");
			                 store.clearFilter(true);
			                 store.filter("categoryName", "是否实现自动化");
			                 return store.findRecord("value", value).getData().show + "";
			             } catch (e) {
			                 return ""+value;
			             };
			         }}
			         */
			    ],
			    height: 190,
			    width: screenWidth*0.75
			    <%if(!isRead){%>
			    ,tbar:[
			    	{text:'s',handler:function(){}}
			    ]
			    <%}%>
			});
			funForm.add(gridPanel);
			Ext.getCmp('tab1').add(funForm);
			<%if(!isRead){%>
			var funFormSel = Ext.select('#funP'+extIndex);
			funFormSel.insertHtml("afterBegin",'<div style="position: absolute; right: 70px; top: 8px; z-index: 2;"><img title="删除" onclick="confirmRemoveFun()" src="<%=request.getContextPath()%>/css/images/no.png"  style="width:18px;height:18px;cursor: pointer;"/></div>');
			funFormSel.insertHtml("afterBegin",'<div style="position: absolute; right: 40px; top: 5px; z-index: 2;"><img title="提交" onclick="subCurFun('+extIndex+', true, true)" src="<%=request.getContextPath()%>/css/images/yes.png" style="width:22px;height:22px;cursor: pointer;"/></div>');
			var gridPanelSel = Ext.select('#caseList'+extIndex);
			gridPanelSel.insertHtml("afterBegin",'<div style="position: absolute; left: 0px; top: -1px; *top: 1px; z-index: 2;"><a href="javascript:void(0)" class="W_btn_c fn-mr-20" onclick="manageCase('+extIndex+')"><span>管理用例</span></a></div>');
			gridPanelSel.insertHtml("afterBegin",'<div style="position: absolute; left: 80px; top: -1px; *top: 1px; z-index: 2;"><a href="javascript:void(0)" class="W_btn_b fn-mr-20" onclick="relaCase('+extIndex+')"><span>关联用例</span></a></div>');
			<%}%>
			if(data) {
				var thisFunp = new FuncPoint(data);
				funForm.getForm().loadRecord(thisFunp);
			} else {
				funForm.getForm().reset();
				funForm.getForm().findField("funTag").setValue(newTag);
			}
			if(isCollapsed) {
				funForm.setTitle("功能点【"+funForm.getForm().findField("sysName").getValue()+"】");
			}
			if(isLabel) {
				subCurFun(extIndex, false, false);
			}
			Ext.create('Ext.tip.ToolTip', {
				id: 'tipFunP'+extIndex,
		        target: 'funPType'+extIndex,
		        width: 200,
		        autoLoad: {
		        	url: '<%=request.getContextPath()%>/getFunTypeTips.do',
		        	params: { funType: funForm.getForm().findField('funType').getValue()}
		        },
		        dismissDelay: 15000         //15秒后自动隐藏
		    });
			Ext.getCmp('funTab').doLayout();
		}
		
		function copyFunPoint(formId) {
			MaskLoading();
			Ext.getCmp(formId).getForm().submit({
				url: '<%=request.getContextPath()%>/copyFunRela.do',
				params: {newTag: getNewFunTag()},
				async: false,
				success: function(form, action) {
			MaskOver();
					addFunArea(action.result.data, true);
				}
			});
		}
		
		function showButton() {
			var returnStr = "<a href='javascript:void(0)' class='ui-a' onclick=''>查看子要素</a>";
			return returnStr;
		}
		
		function confirmDelRes() {
			var curSel = Ext.getCmp('resPanel').getSelectionModel().getSelection();
			if(curSel.length == 0) {
				return;
			}
			Ext.MessageBox.confirm('提示','确定要删除该资源？',function(btn){
				if(btn == 'yes') {
					delResource();
				} else {
					return;
				}
			});
		}
		
		function confirmDelReason() {
			var curSel = Ext.getCmp('reasonPanel').getSelectionModel().getSelection();
			if(curSel.length == 0) {
				return;
			}
			Ext.MessageBox.confirm('提示','确定要删除该分析？',function(btn){
				if(btn == 'yes') {
					delReason();
				} else {
					return;
				}
			});
		}
		
		function delResource() {
			var curSel = Ext.getCmp('resPanel').getSelectionModel().getSelection();
			var resId = curSel[0].get('id');
			if(!resId) {
				Ext.getCmp('resPanel').getStore().remove(curSel);
    			Ext.getCmp('resPanel').getView().refresh();
    			return;
			}
	  		MaskLoading();
			$.ajax({
	    		async: false,
    			type: 'POST',
    			url: '<%=request.getContextPath()%>/deleteResource.do',
    			data: 'resId='+resId+'&_='+(new Date()).getTime(),
    			success: function(data) {
    				Ext.getCmp('resPanel').getStore().remove(curSel);
    				Ext.getCmp('resPanel').getView().refresh();
    			}
    		});
	    	MaskOver();
		}
		
		function delReason() {
			var curSel = Ext.getCmp('reasonPanel').getSelectionModel().getSelection();
			var reasonId = curSel[0].get('reasonId');
			if(!reasonId) {
				Ext.getCmp('reasonPanel').getStore().remove(curSel);
    			Ext.getCmp('reasonPanel').getView().refresh();
    			return;
			}
	  		MaskLoading();
			$.ajax({
	    		async: false,
    			type: 'POST',
    			url: '<%=request.getContextPath()%>/deleteReason.do',
    			data: 'reasonId='+reasonId+'&_='+(new Date()).getTime(),
    			success: function(data) {
    				Ext.getCmp('reasonPanel').getStore().remove(curSel);
    				Ext.getCmp('reasonPanel').getView().refresh();
    			}
    		});
	    	MaskOver();
		}
		
		function refreshCurElem(curGridId) {
			var elemTag = Ext.getCmp(curGridId).getSelectionModel().getSelection()[0].get('testelemTag');
			Ext.Ajax.request({
				url:"<%=request.getContextPath()%>/getElemCaseCount.do?elemTag="+elemTag,  
				success:function(response,config){
					MaskOver();
					var caseIdJson = Ext.JSON.decode(response.responseText);
					var size = caseIdJson.size;
					Ext.getCmp(curGridId).getSelectionModel().getSelection()[0].set('size',size);
					Ext.getCmp(curGridId).getSelectionModel().getSelection()[0].commit();
				},
				failure:function(response,config){
					MaskOver();
				}
			});
		}
		
		function subCurFun(curId, isAlert, isRefresh) {
			var funTag = Ext.getCmp("funP"+curId).getForm().findField("funTag").getValue();
			var relaFolderId =  Ext.getCmp("funP"+curId).getForm().findField("relaFolderId").getValue();
			if(relaFolderId == null || relaFolderId == "" || relaFolderId == "0") {
				top.Ext.Msg.alert("提示","请在功能点名称中输入选择功能点");
				return false;
			}
			MaskLoading();
			Ext.getCmp("funP"+curId).submit({
				url:'<%=request.getContextPath()%>/saveFunPoint.do',
				async: false,
				success: function(form, action) {
					Ext.getCmp("funP"+curId).load({
						url: '<%=request.getContextPath()%>/getFunPByTag.do?funTag='+funTag,
						success: function(form, action) {
							if(isAlert) {
								Ext.Msg.alert('提示','提交成功！');
							}
							var funId = form.findField('funId').getValue();
							var relaId = form.findField('relaFolderId').getValue();
							Ext.getCmp("funP"+curId).setTitle("功能点【"+action.result.data.sysName+"】");
							Ext.getCmp("caseList"+curId).getStore().setProxy({
						        type: 'ajax',
						        async: false,
						        url: '<%=request.getContextPath()%>/getCaseByFunId.do?funId='+funId+"&relaId="+relaId,
						        reader: {
						            type: 'json',
						            root: 'data'
						        }
						    });
						    if(isRefresh) {
            					Ext.getCmp("caseList"+curId).getStore().reload();
						    }
			MaskOver();
						}
					});
				},
				failture: function(form, action) {
			MaskOver();
					Ext.MessageBox.alert("提示","提交数据失败");
				}
			});
	    	MaskOver();
	    	return true;
		}
		
		function qryKnowledgeWindow(funFrmId) {
			var knowledgeGridStore = new Ext.data.Store({
	        	model: 'Knowledge',
	        	id: 'knowledgeGridStore',
	        	proxy: {
					type: 'ajax',
				    reader: {
				        type: 'json',
				        root: 'data'
				    }
				}
	        });
			var queryForm = new Ext.form.Panel({
	        	id: 'queryForm',
	        	title: '查询信息',
	        	cls: 'ui-formPanel',
	        	width: screenWidth*0.8,
	  			defaults: {margins: '5 0 0 0'},
	  			layout: 'vbox',
	  			items:[
					{
					    xtype: 'fieldcontainer',
					    layout: 'hbox',
					    defaultType: 'textfield',
					    fieldDefaults: { 
					        labelAlign: 'right',
					        labelWidth: 100,
					        width: 230
					    },
					    items: [
					    	{name: 'knowledgeName',fieldLabel: '知识点名称'},
					        {name: 'sysName',fieldLabel:'系统名称'},
					        {name: 'subSysName',fieldLabel:'子系统名称'},
					       	{name: 'moduleName',fieldLabel: '模块名称'},
					       	{xtype: 'hidden',name: 'knowledgeId',fieldLabel: '知识点ID'}
					    ]
					},
					{
					    xtype: 'fieldcontainer',
					    layout: 'hbox',
					    defaultType: 'textfield',
					    fieldDefaults: { 
					        labelAlign: 'right',
					        labelWidth: 100,
					        width: 230
					    },
					    items: [
					    	{xtype:'combo',valueField:'value',displayField:'show',store:'knowledgeType',name: 'knowledgeType',fieldLabel: '知识点类型'},
					        {name: 'knowledgeDesc',fieldLabel:'知识点描述'},
					        {xtype:'button',margin:'0 0 0 35',width:60,height: 25,text:'查询',handler: function() {queryKnowledge();}}
					    ]
					}
	  			]
	        });
	       	
	        var knowledgeGrid = new Ext.grid.Panel({
	        	id: 'knowledgeGrid',
	        	title: '知识点列表',
	        	cls: 'ui-formPanel',
	        	layout: 'fit',
	        	width: screenWidth*0.9,
	        	height: 290,
	        	store: 'knowledgeGridStore',
	        	columns: [
	        		{xtype:'rownumberer'},
	        		{header:'系统名称',dataIndex:'sysName',field:'textfield',width:100},
	        		{header:'子系统名称',dataIndex:'subSysName',field:'textfield',width:100},
	        		{header:'模块名称',dataIndex:'moduleName',field:'textfield',width:100},
	        		{header:'知识点名称',dataIndex:'knowledgeName',field:'textfield',width:100},
	        		{header:'知识点类型',dataIndex:'knowledgeType',field:'textfield',width:100,editor:{xtype:'combo',displayField:'show', valueField:'value', store:'knowledgeType'},
	        			renderer:function(value){
			    			var rec = Ext.StoreMgr.get('knowledgeType').find('value',value);
			    			if(rec == -1) {
			    				return '';
			    			}
			    			return Ext.StoreMgr.get('knowledgeType').getAt(rec).raw.show;
			    		}
	        		},
	        		{header:'知识点描述',dataIndex:'knowledgeDesc',field:'textfield',width:300}
	        	],
	        	listeners: {
	        		dblclick: {
	  					element: 'body',
	  					fn: function() {
	  						
	  					}
	  				}
	        	}
	        });
			var win = new Ext.window.Window({
				title: '知识点查询',
				layout: 'vbox',
				width: screenWidth*0.8,
				height: 430,
				modal: true,
				id: 'qryKnowledgeWin',
				items:[
					queryForm,knowledgeGrid
				]
			});
			win.show();
		}
		
		function queryKnowledge() {
	    	var sysName = Ext.getCmp('queryForm').getForm().findField('sysName').getValue();
	    	var subSysName = Ext.getCmp('queryForm').getForm().findField('subSysName').getValue();
	    	var moduleName = Ext.getCmp('queryForm').getForm().findField('moduleName').getValue();
	    	var knowledgeName = Ext.getCmp('queryForm').getForm().findField('knowledgeName').getValue();
	    	var knowledgeType = Ext.getCmp('queryForm').getForm().findField('knowledgeType').getValue();
	    	
	    	Ext.getCmp('knowledgeGrid').getStore().load({
	    		url:'<%=request.getContextPath()%>/getKnowledgeByCon.do',
	  			params:{sysName:sysName,subSysName:subSysName,moduleName:moduleName,knowledgeName:knowledgeName,
	  				knowledgeType:knowledgeType},
	  			success: function(form, action) {
	  				
				}
	    	});
	    }
		
		function viewCollection() {
			var subTaskId = Ext.getCmp('subTaskForm').getForm().findField('subTaskId').getValue();
			var win = new top.Ext.window.Window({
				title: '用例集管理',
				layout: 'fit',
				width: screenWidth*0.8,
				height: 530,
				modal: true,
				constrain:true,
				id: 'collection',
				html: "<iframe src='<%=request.getContextPath()%>/aiga/userCase/caseCollection.jsp?subTaskId="+subTaskId+"' frameborder='0' width='930' height='530'></iframe>"
			});
			win.show();
		}
		
		function showPerformanceForm() {
			var valJson = getValJson();
			//alert(valJson);
			//return;
			var win = new top.Ext.window.Window({
				title:'性能测试单',
				id:'perFormWin',
				width: screenWidth*0.7,
				height: 420,
				modal: true,
				closable: true,
				constrain:true,
				items:[{html:'<iframe src="<%=request.getContextPath()%>/aiga/workflow/performance.jsp?valJson='+valJson+'" width="700" height="420" frameborder="0" scroll="none"></iframe>'}]
			});
			win.show();
		}
		
		function getValJson() {
			var json = "{";
			$("#perSubTaskForm").find(":input[name]").each(function(){
				var name = $(this).attr("name");
				json += "'"+name+"':'"+$(this).val() + "',";
			});
			json += "}";
			json = json.replace(",}","}");
			return json;
		}
		
		function perSubTaskSub() {
			var isPer = Ext.getCmp("subTaskForm").getForm().findField('isPerformance').getValue();
			if(!isPer) {
				return;
			}
			var paramStr = "";
			$("#perSubTaskForm").find(":input[name]").each(function(){
				var name = $(this).attr("name");
				paramStr += name+"="+$(this).val()+"&";
			});
			paramStr += "random="+Math.random();
	  		MaskLoading();
			$.ajax({
	    		async: false,
				type: 'POST',
				dataType: "json",
				url: '<%=request.getContextPath()%>/savePerSubTask.do',
				data: paramStr,
				success: function(data) {
					
				}
			});
	    	MaskOver();
		}
		
		function refreshPerSubTaskForm(valJson) {
			var json = eval("("+valJson+")");
			$("#perSubTaskForm").find(":input[name]").each(function(){
				var name = $(this).attr("name");
				$(this).val(json[name]);
			});
			$("#perSubTaskForm").find(":input[name=relaSubTaskId]").val(Ext.getCmp("subTaskForm").getForm().findField("subTaskId").getValue());
		}
		
		function closePerFrame(valJson) {
			if(valJson != null) {
				refreshPerSubTaskForm(valJson);
			}
			Ext.getCmp("perFormWin").close();
		}
		
		function collapseAllFun() {
			$("#tab1-body").find(".tab1-fun").each(function(index){
				index++;
				var id = $(this).attr("id");
				var funPNo = id.replace("funP","");
				Ext.getCmp(id).collapse();
			});
		}
		
		function expandFirstFun() {
			$("#tab1-body").find(".tab1-fun:eq(0)").each(function(){
				var id = $(this).attr("id");
				Ext.getCmp(id).expand();
			});
		}
		
		function qryFunHistory(formId) {
			var tempId = Ext.getCmp(formId).getForm().findField('relaFolderId').getValue();
			var win = new top.Ext.window.Window({
				title: '功能点需求分析版本展现（功能点变更历史）',
				layout: 'fit',
				modal: true,
				constrain:true,
				resizable:false,
				width: screenWidth*0.78,
				height: 500,
				html: '<iframe width="100%" height="100%" frameborder="0" src="<%=request.getContextPath()%>/aiga/workflow/funHistory.jsp?tempId='+tempId+'"> </iframe>'
			});
			win.show();
		}
		
		function showHideClass(val) {
			Ext.getCmp("funTab").remove(Ext.getCmp("accountTest"), false);
			Ext.getCmp("funTab").remove(Ext.getCmp("dataAudit"), false);
			Ext.getCmp("funTab").remove(Ext.getCmp("cutOverTest"), false);
			if(val == 1) {
				Ext.getCmp("funTab").add(Ext.getCmp("accountTest"));
			} else if(val == 2) {
				Ext.getCmp("funTab").add(Ext.getCmp("dataAudit"));
			} else if(val == 3) {
				Ext.getCmp("funTab").add(Ext.getCmp("cutOverTest"));
				var cutOverDataRate = Ext.getCmp("subTaskForm").getForm().findField("auditRate").getValue();
				var cutOverFunRate = Ext.getCmp("subTaskForm").getForm().findField("scriptFunRate").getValue();
				var cutOverPerRate = Ext.getCmp("subTaskForm").getForm().findField("scriptPerRate").getValue();
				Ext.getCmp("cutOverTest").getForm().findField("cutOverDataRate").setValue(cutOverDataRate);
				Ext.getCmp("cutOverTest").getForm().findField("cutOverFunRate").setValue(cutOverFunRate);
				Ext.getCmp("cutOverTest").getForm().findField("cutOverPerRate").setValue(cutOverPerRate);
			}
		}
		
		function showJoinSysTab(val) {
			if(val == true) {
				Ext.getCmp("funTab").add(Ext.getCmp("joinPanel"));
			} else {
				Ext.getCmp("funTab").remove(Ext.getCmp("joinPanel"), false);
			}
		}
		
		function refreshAuditDiv() {
			$.ajax({
				url: '<%=request.getContextPath()%>/getSysParam.do',
				data: 'category=audit_type',
	    		async: false,
				dataType: 'json',
				type: 'post',
				success: function(json) {
					var audits = json.data;
					for(var i = 0; i < audits.length; i++) {
						var curHtml = "<div><label><input type='checkbox' name='auditType' value='"+audits[i].value+"' />"+audits[i].show+"</label>"+
							"<span>稽核记录（<input type='text' name='auditCount' />）</span><span>准确率（<input type='text' name='auditRate' />）</span>"+
							"<input type='hidden' value='null' name='auditId' /><input type='hidden' value='<%=subTaskId%>' name='subTaskId' />"+"</div>";
						$(curHtml).appendTo($("#auditDiv"));
					}
					Ext.getCmp("dataAudit").doLayout();
					$.ajax({
						url: '<%=request.getContextPath()%>/getAuditBySubTaskId.do',
						data: 'subTaskId=<%=subTaskId%>',
						dataType: 'json',
	    				async: false,
						type: 'post',
						success: function(aJson) {
							var auditAry = aJson.data;
							for(var i = 0; i < auditAry.length; i++) {
								var val = auditAry[i].auditType;
								var obj = $("#auditDiv").find("input[name=auditType][value="+val+"]").parent().parent();
								var checkSts = false;
								if(auditAry[i].checkStatus == 1) {
									checkSts = true;
								}
								if(checkSts) {
									obj.find("input[type=checkbox]").attr("checked", true);
								} else {
									obj.find("input[name=auditId]").val(auditAry[i].auditId);
									continue;
								}
								for(var key in auditAry[i]) {
									obj.find("input[name="+key+"]").val(auditAry[i][key]);
								}
							}
						}
					});
				}
			});
		}
		
		function saveAudits() {
			var list = new Array();
			$("#auditDiv>div").each(function(){
				var curAuditList = new Array();
				$(this).find("input[name]").each(function(){
					var theVal = null;
					if($(this).val() != null && $(this).val() != "") {
						theVal = $(this).val();
					}
					var curStr = "'"+$(this).attr("name") + "':'" + theVal + "'";
					curAuditList.push(curStr);
				});
				if($(this).find("input[type=checkbox").attr("checked")) {
					curAuditList.push("'checkStatus':'1'");
				} else {
					curAuditList.push("'checkStatus':'0'");
				}
				curAuditList = "{"+curAuditList+"}";
				list.push(curAuditList);
			});
			list = "["+list+"]";
			$.ajax({
				url: '<%=request.getContextPath()%>/saveAudits.do',
	    		async: false,
				dataType: 'json',
				data: 'table='+list,
				type: 'post',
				success: function(json){
					
				}
			});
		}
		
		function refreshAccountTestTbl() {
			$.ajax({
				url: '<%=request.getContextPath()%>/getSysParam.do',
				data: 'category=account_test_type',
				dataType: 'json',
	    		async: false,
				type: 'post',
				success: function(json) {
					var accounts = json.data;
					for(var i = 0; i < accounts.length; i++) {
						var curHtml = '<tr><td><label><input type="checkbox" name="accountType" value='+accounts[i].value+' />'+accounts[i].show+'</label></td>'+
							'<td><input type="text" name="accountCount" /></td><td><input type="text" name="minusWordsRate" /></td>'+
							'<td><input type="text" name="minusFeeRate" /></td><td><input type="text" name="orginBillRate" /></td>'+
							'<td><input type="text" name="orginFeeRate" /></td><td><input type="text" name="bareCount" /></td>'+
							'<td><input type="text" name="bareFee" /></td><td><input type="text" name="averageBareFee" /></td>'+
							'<td><input type="text" name="averageBareDis" /><input type="hidden" name="subTaskId" value="<%=subTaskId%>" />'+
							'<input type="hidden" name="accountId" value="null" /></td></tr>';
						$(curHtml).appendTo($("#accountTestTbl>tbody"));
					}
					Ext.getCmp("accountTest").doLayout();
					$.ajax({
						url: '<%=request.getContextPath()%>/getAccountTestBySubTaskId.do',
						data: 'subTaskId=<%=subTaskId%>',
						dataType: 'json',
	    				async: false,
						type: 'post',
						success: function(aJson) {
							var accountAry = aJson.data;
							for(var i in accountAry) {
								var val = accountAry[i].accountType;
								var obj = $("#accountTestTbl").find("input[name=accountType][value="+val+"]").parent().parent().parent();
								var checkSts = false;
								if(accountAry[i].checkStatus == 1) {
									checkSts = true;
								}
								if(checkSts) {
									obj.find("input[type=checkbox]").attr("checked", true);
								} else {
									obj.find("input[name=accountId]").val(accountAry[i].accountId);
									continue;
								}
								for(var key in accountAry[i]) {
									obj.find("input[name="+key+"]").val(accountAry[i][key]);
								}
							}
						}
					});
				}
			});
		}
		
		function saveAccountTests() {
			var list = new Array();
			$("#accountTestTbl>tbody>tr").each(function(){
				var curAuditList = new Array();
				$(this).find("input[name]").each(function(){
					var theVal = null;
					if($(this).val() != null && $(this).val() != "") {
						theVal = $(this).val();
					}
					var curStr = "'"+$(this).attr("name") + "':'" + theVal+"'";
					curAuditList.push(curStr);
				});
				if($(this).find("input[type=checkbox").attr("checked")) {
					curAuditList.push("'checkStatus':'1'");
				} else {
					curAuditList.push("'checkStatus':'0'");
				}
				curAuditList = "{"+curAuditList+"}";
				list.push(curAuditList);
			});
			list = "["+list+"]";
			$.ajax({
				url: '<%=request.getContextPath()%>/saveAccountTests.do',
	    		async: false,
				dataType: 'json',
				data: 'table='+list,
				type: 'post',
				success: function(json){
					
				}
			});
		}
		
		function setScriptRate() {
			var cutOverDataRate = Ext.getCmp("cutOverTest").getForm().findField("cutOverDataRate").getValue();
			var cutOverFunRate = Ext.getCmp("cutOverTest").getForm().findField("cutOverFunRate").getValue();
			var cutOverPerRate = Ext.getCmp("cutOverTest").getForm().findField("cutOverPerRate").getValue();
			Ext.getCmp("subTaskForm").getForm().findField("auditRate").setValue(cutOverDataRate);
			Ext.getCmp("subTaskForm").getForm().findField("scriptFunRate").setValue(cutOverFunRate);
			Ext.getCmp("subTaskForm").getForm().findField("scriptPerRate").setValue(cutOverPerRate);
		}
		
		function saveSubTaskClassInfo() {
			var classType = Ext.getCmp("subTaskForm").getForm().findField("subTaskClass").getValue();
			if(classType == "1") {
				saveAccountTests();
			} else if(classType == "2") {
				saveAudits();
			} else if(classType == "3") {
				setScriptRate();
			}
		}
		
		function setNowTestInfo() {
			var testReply = Ext.getCmp('nowTestForm').getForm().findField("testReply").getValue();
			var reqAnalysis = Ext.getCmp('nowTestForm').getForm().findField("reqAnalysis").getValue();
			var nowTestInfo = Ext.getCmp('nowTestForm').getForm().findField("nowTestInfo").getValue();
			var usable = Ext.getCmp('nowTestForm').getForm().findField("usable").getValue();
			Ext.getCmp('subTaskForm').getForm().findField("testReply").setValue(testReply);
			Ext.getCmp('subTaskForm').getForm().findField("reqAnalysis").setValue(reqAnalysis);
			Ext.getCmp('subTaskForm').getForm().findField("nowTestInfo").setValue(nowTestInfo);
			Ext.getCmp('subTaskForm').getForm().findField("usable").setValue(usable);
		}
		
		function manageCase(num) {
			var subTaskTag = Ext.getCmp('subTaskForm').getForm().findField('subTaskTag').getValue();
			var funId = Ext.getCmp('funP'+num).getForm().findField('funId').getValue();
			var relaId = Ext.getCmp('funP'+num).getForm().findField('relaFolderId').getValue();
			var sysId = Ext.getCmp('funP'+num).getForm().findField('sysId').getValue();
			var paramStr = "?subTaskTag="+subTaskTag+"&funId="+relaId+"&sysId="+sysId+"&normalMac=&TemporaryTag=";
			var win = new top.Ext.window.Window({
				title: '用例管理',
				layout: 'fit',
				width: screenWidth*0.9,
				height: 530,
				listeners:{
					beforeclose: function(panel, eOpts) {
						Ext.getCmp("caseList"+num).getStore().setProxy({
					        type: 'ajax',
					        url: '<%=request.getContextPath()%>/getCaseByFunId.do?funId='+funId+'&relaId='+relaId,
					        reader: {
					            type: 'json',
					            root: 'data'
					        }
					    });
						Ext.getCmp('caseList'+num).getStore().load();
					}
				},
				modal: true,
				constrain:true,
				html: "<iframe src='<%=request.getContextPath()%>/aiga/userCase/funPointAnalysis.jsp"+paramStr+"' frameborder='0' width='100%' height='530'></iframe>"
			});
			win.show();
		}
		
		function relaCase(num) {
			var funId = Ext.getCmp('funP'+num).getForm().findField('funId').getValue();
			var relaId = Ext.getCmp('funP'+num).getForm().findField('relaFolderId').getValue();
			var store = Ext.getCmp('caseList'+num).getStore();
			var caseIds = new Array();
			for(var i = 0; i < store.getCount(); i++) {
				caseIds.push(store.getAt(i).data.caseId);
			}
			var win = new top.Ext.window.Window({
				title: '用例关联',
				layout: 'fit',
				width: screenWidth*0.7,
				height: 530,
				listeners:{
					beforeclose: function(panel, eOpts) {
						Ext.getCmp("caseList"+num).getStore().setProxy({
					        type: 'ajax',
					        url: '<%=request.getContextPath()%>/getCaseByFunId.do?funId='+funId+'&relaId='+relaId,
					        reader: {
					            type: 'json',
					            root: 'data'
					        }
					    });
						Ext.getCmp('caseList'+num).getStore().load();
					}
				},
				modal: true,
				constrain:true,
				html: "<iframe src='<%=request.getContextPath()%>/aiga/userCase/subTaskCaseRela.jsp?funId="+funId+"&relaId="+relaId+"&caseIds="+caseIds+"' frameborder='0' width='100%' height='530'></iframe>"
			});
			win.show();
		}
		
		function viewHisSubElem() {
			var sel = Ext.getCmp('hisElemGrid').getSelectionModel().getSelection();
			if(sel.length == 0) {
				return;
			}
			var elemId = sel[0].get('elemId');
			var store = Ext.create('Ext.data.Store', {
				autoLoad: true,
				storeId: 'hisSubElemStore',
				model: 'HisSubElemModel',
				proxy: {
					type: 'ajax',
					url: '<%=request.getContextPath()%>/getRelaHisSubElem.do?elemId='+elemId,
					reader: {
						type: 'json',
						root: 'data'
					}
				}
			});
			var win = new top.Ext.window.Window({
				title: '子元素历史',
				layout: 'fit',
				width: screenWidth*0.7,
				height: 530,
				modal: true,
				constrain:true,
				items: [
					Ext.create('Ext.grid.Panel',{
						store: store,
						columns: [
							{xtype:'rownumberer'},
					        {header: '子要素名称',  dataIndex: 'elemName' ,width:200},
					        {header: '修改类型', dataIndex: 'operatorType'},
					        {header: '操作时间', dataIndex: 'operateTime', width: 140},
					        {header: '操作员', dataIndex: 'operatorName'}
						]
					})
				]
			});
			win.show();
		}
		
		function checkBeforeSubmit() {
			var subTaskBaseForm = Ext.getCmp("subTaskForm").getForm();
			//var nowTestForm = Ext.getCmp('nowTestForm').getForm();
			var checkList = ["subTaskName","createTime","subTaskStatus","creatorStaff","factCompleteTime","bigType","subType"];
			for(var i = 0; i < checkList.length; i++) {
				if(subTaskBaseForm.findField(checkList[i]).getValue() == null || subTaskBaseForm.findField(checkList[i]).getValue() == "") {
					Ext.Msg.alert("校验提示", "请填写"+subTaskBaseForm.findField(checkList[i]).getFieldLabel()+"字段");
					return false;
				}
			}
			/*
			var nowTestInfoList = ["testReply","reqAnalysis","nowTestInfo","usable"];
			for(var i = 0; i < nowTestInfoList.length; i++) {
				if(nowTestForm.findField(nowTestInfoList[i]).getValue() == null || nowTestForm.findField(nowTestInfoList[i]).getValue() == "") {
					Ext.Msg.alert("校验提示", "请填写"+nowTestForm.findField(nowTestInfoList[i]).getFieldLabel()+"字段");
					return false;
				}
			}
			*/
			return true;
		}
		
		function saveResultInfo() {
			var curResult = Ext.getCmp('resultInfo').getSelectionModel().getSelection();
			if(curResult.length == 1) {
				curResult[0].commit();
			}
			var resultStore = Ext.getCmp('resultInfo').getStore();
			var resultInfos = new Array();
			resultStore.each(function(rec){
				resultInfos.push(Ext.encode(rec.data));
			});
			resultInfos = "[" + resultInfos + "]";
			$.ajax({
	    		async: false,
				type: 'POST',
				dataType: "json",
				url: '<%=request.getContextPath()%>/saveResultInfos.do',
				data: 'table='+resultInfos,
				success: function(data) {
					resultStore.reload();
				}
			});
		}
		
		function confirmDelResultInfo() {
			var curSel = Ext.getCmp('resultInfo').getSelectionModel().getSelection();
			if(curSel.length == 0) {
				return;
			}
			Ext.MessageBox.confirm('提示','确定要删除该指标？',function(btn){
				if(btn == 'yes') {
					delResultInfo();
				} else {
					return;
				}
			});
		}
		
		function delResultInfo() {
			var curSel = Ext.getCmp('resultInfo').getSelectionModel().getSelection();
			var resultId = curSel[0].get('resultId');
			if(!resultId) {
				Ext.getCmp('resultInfo').getStore().remove(curSel);
    			Ext.getCmp('resultInfo').getView().refresh();
    			return;
			}
	  		MaskLoading();
			$.ajax({
	    		async: false,
    			type: 'POST',
    			url: '<%=request.getContextPath()%>/deleteResultInfo.do',
    			data: 'resultId='+resultId+'&_='+(new Date()).getTime(),
    			success: function(data) {
    				Ext.getCmp('resultInfo').getStore().remove(curSel);
    				Ext.getCmp('resultInfo').getView().refresh();
    			}
    		});
	    	MaskOver();
		}
		
		function relaFunFolder() {
			var relaFunWin = new Ext.window.Window({
				title: '查询功能点',
				id: 'relaFunWin',
				modal: true,
				layout: 'vbox',
				width: screenWidth*0.9,
				height: 540,
				items: [
					Ext.create('Ext.form.Panel', {
						title: '查询区域',
						id: 'qryFunDivPanel',
						width: screenWidth*0.89,
						height: 540,
						layout:'vbox',
						items: [
							{html:'<iframe width="'+screenWidth*0.89+'" height="540" scrolling="yes" src="<%=request.getContextPath()%>/aiga/workflow/FunFolderLabelQry.jsp?subTaskId=<%=subTaskId%>" frameborder="0" ></iframe>'}
						]
					})
				]
			});
			Ext.getCmp('relaFunWin').show();
		}
		
		function addLabelFuns(records) {
			for(var i = 0; i < records.length; i++) {
				var curData = records[i].data;
				var relaId = curData.funId;
				curData.funId = "";
				curData.subTaskId = "<%=subTaskId%>";
				curData.relaFolderId = relaId;
				curData.funTag = getNewFunTag();
				addFunArea(curData, false, true);
			}
		}
		
		function viewRelaCase() {
			var relaCaseWin = new Ext.window.Window({
				title: '关联用例',
				id: 'relaCaseWin',
				modal: true,
				layout: 'vbox',
				width: screenWidth*0.9,
				height: 500,
				items: [
					{html:'<iframe width="'+screenWidth*0.89+'" height="460" scrolling="auto" src="<%=request.getContextPath()%>/getSubTaskFunPointDetail.do?subTaskId=<%=subTaskId%>" frameborder="0" ></iframe>'}
				]
			});
			Ext.getCmp('relaCaseWin').show();
		}
		
	</script>
</html>