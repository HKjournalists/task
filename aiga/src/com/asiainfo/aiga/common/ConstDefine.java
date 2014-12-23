package com.asiainfo.aiga.common;

public interface ConstDefine {

	public final static String ADMIN_NO = "administrator";
	public final static String ADMIN_NAME = "管理人员";
	public final static String ADMIN_ID = "1";
	
	public final static String AUTO = "AUTO";
	public final static String AUTO_NAME = "自动机";
	public final static String AUTO_ID = "111";
	
	
	//平台业务类型
	public final static String TEST_PLAN_OBJ = "1";
	public final static String TEST_TASK_OBJ = "2";
	//流程模板类型
	public final static String VM_TEMPLATE_TYPE = "1";
	public final static String MATRIX_TEMPLATE_TYPE = "2";
	//工单状态
	//等待打单
	public final static String WO_STATUS_CREATE = "1"; 
	//等待处理
	public final static String WO_STATUS_RECEIVE = "2"; 
	//完成处理
	public final static String WO_STATUS_COMPLETE = "3";
	//工单加锁
	public final static String WO_STATUS_LOCK = "4";
	
	public final static String WO_SCHEDULE_STATUS_END = "F";
	public final static String WO_SCHEDULE_STATUS_WAIT = "W";
	
	public final static int WF_CASE_STATUS_ALLOW = 2;
	public final static int WF_CASE_STATUS_EX = 99;
	
	public final static String LINK_NO_TYPE_MGR = "mgr";
	public final static String LINK_NO_TYPE_START = "start";
	public final static String LINK_NO_TYPE_END = "end";
	public final static String LINK_NO_TYPE_TERMINATION = "termination";
	public final static String LINK_NO_TYPE_USER = "user";
	public final static String LINK_NO_TYPE_SIGN = "sign";
	
	public final static String LINK_NO_MEETING = "meeting";
	
	
	public final static String  IS_CURRENT_TASK = "Y";
	public final static String  IS_NOT_CURRENT_TASK = "N";
	//工单没有父工单
	public final static int WO_NO_PARENT = -1;
	
	public final static int WO_NO_WORKFLOW_ID = -1;
	
	public final static int WO_NO_LASTORDER_ID = -1;
	
	public final static int WO_NO_VM_TASK_ID = -1;
	
	public final static int WO_NO_LAST_VM_TASK_ID = -1;
	
	public final static int WO_NO_PARENT_VM_TASK_ID = -1;
	
	//流程审批
	public final static String STAKEHOLDERTYPE_WF = "2";
	public final static String STAKEHOLDERTYPE_DISCUSS = "1";
	public final static String STAKEHOLDERTYPE_NOTICE = "3";
	public final static String STAKEHOLDERTYPE_LOCK = "4";
	public final static String STAKEHOLDERTYPE_ANSWER = "7";
	public final static String STAKEHOLDERTYPE_COPY = "6";
	public final static String STAKEHOLDERTYPE_REQEXM = "8";
	
	
	//工单是否上锁
	public final static int LOCK = 1;
	public final static int NO_LOCK = 0;
	
	//是否需要打单
	public final static int PRINT = 1;
	public final static int NO_PRINT = 0;
	
	//打单状态
	public final static int FINISH_PRINT = 1;
	public final static int NO_FINISH_PRINT = 0;
	public final static int NOT_NEED_PRINT = 2;
	
	
	//工单审批结果
	//同意
	public final static String WO_APPROVAL_RESULT_PASS = "Y";
	//不同意
	public final static String WO_APPROVAL_RESULT_NO_PASS = "N";
	//没意见
	public final static String WO_APPROVAL_RESULT_NO_OPTION = "O";
	
	//工单处理类型
	//处理
	public final static String WO_DEAL_TYPE_APPROVE = "2";
	//转派
	public final static String WO_DEAL_TYPE_REAUTHORIZE = "5";
	//协作配合
	public final static String WO_DEAL_TYPE_COPY = "6";
	//回答问题
	public final static String WO_DEAL_TYPE_ANSWER = "7";
	//需求评审
	public final static String WO_DEAL_TYPE_REQEXM = "8";
	
	//测试计划流程
	public final static String TEMPLATE_ID_TESTPLANWORKFLOW = "10000";
	public final static String TEMPLATE_NAME_TESTPLANWORKFLOW = "com.asiainfo.aiga.workflow.testPlanWF";
	
//	//固化任务流程
//	public final static String TEMPLATE_ID_SOLIDTESTTASKWORKFLOW = "20000";
//	public final static String TEMPLATE_NAME_SOLIDTESTTASKWORKFLOW = "com.asiainfo.aiga.workflow.";
	
	//固化任务安全测试流程
	public final static String TEMPLATE_ID_SOLIDTESTTASKSECUTESTWORKFLOW = "21000";
	public final static String TEMPLATE_NAME_SOLIDTESTTASKSECUTESTWORKFLOW = "com.asiainfo.aiga.workflow.secuTestWF";
	//固化任务性能测试流程
	public final static String TEMPLATE_ID_SOLIDTESTTASKPERFTESTWORKFLOW = "22000";
	public final static String TEMPLATE_NAME_SOLIDTESTTASKPERFTESTWORKFLOW = "com.asiainfo.aiga.workflow.perfTestWF";
	//固化任务代码扫描流程
	public final static String TEMPLATE_ID_SOLIDTESTTASKCODESCANWORKFLOW = "23000";
	public final static String TEMPLATE_NAME_SOLIDTESTTASKCODESCANWORKFLOW = "com.asiainfo.aiga.workflow.codeScanWF";
	//固化任务回归测试流程
	public final static String TEMPLATE_ID_SOLIDTESTTASKREGRTESTWORKFLOW = "24000";
	public final static String TEMPLATE_NAME_SOLIDTESTTASKREGRTESTWORKFLOW = "com.asiainfo.aiga.workflow.regrTestWF";
	
	//测试任务流程
	public final static String TEMPLATE_ID_TESTTASKWORKFLOW = "30000";
	public final static String TEMPLATE_NAME_TESTTASKWORKFLOW = "com.asiainfo.aiga.workflow.testTaskWF";
	
	//测试任务流程
	public final static String TEMPLATE_ID_TESTSUBTASKWF = "40000";
	public final static String TEMPLATE_NAME_TESTSUBTASKWF = "com.asiainfo.aiga.workflow.testSubTaskWF";
	
	//测试任务流程
	public final static String TEMPLATE_ID_TESTEAESUBWF = "50000";
	public final static String TEMPLATE_NAME_TESTEAESUBWF = "com.asiainfo.aiga.workflow.testEAESubWF";
	
	//性能测试子流程
	public final static String TEMPLATE_ID_PERFSUBTESTWF = "60000";
	public final static String TEMPLATE_NAME_PERFSUBTESTWF = "com.asiainfo.aiga.workflow.perfTestSubWF";
	
	

}
