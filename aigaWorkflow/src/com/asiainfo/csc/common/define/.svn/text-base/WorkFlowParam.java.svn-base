package com.asiainfo.csc.common.define;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.matrix.bo.BOAlmWorkflowBean;
import com.asiainfo.csc.matrix.bo.BOTopoViewBean;
import com.asiainfo.csc.matrix.common.ConstDefine;
import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;
import com.asiainfo.csc.matrix.ivalues.IBOTopoViewValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkflowSV;

public class WorkFlowParam {

	private static WorkFlowParam wfp;

	public static WorkFlowParam getInstance() {
		if (wfp == null) {
			wfp = new WorkFlowParam();
		}
		return wfp;
	}
	
	private static Map<String,IBOAlmWorkflowValue> workflowsMap = new HashMap<String,IBOAlmWorkflowValue>();

	
	public static Map<String, IBOAlmWorkflowValue> getWorkflowsMap() {
		return workflowsMap;
	}
	/**
	 * 根据指定环节编号在数据库中查询对应记录并返回Bean对象
	 * 
	 * @param linkNo
	 * @return
	 * @author zhangbing
	 */
	private IBOAlmWorkflowValue getWorkflowByCondition(String linkNo) {
		try {
			return getWorkflowInMap(linkNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 
	* @Title: getAllWorkflows
	* @author lilj@asiainfo-linkage.com 
	* @Description: 从数据库里取出所有workflow 
	* @param  
	* @return void 
	* @throws
	 */
	private void getAllWorkflows(){
		try {
			IAlmWorkflowSV service = (IAlmWorkflowSV) ServiceFactory.getService(IAlmWorkflowSV.class);
			IBOAlmWorkflowValue[] workflows = service.getAlmWorkflowByCondition("",new HashMap());
			workflowsMap = new HashMap<String,IBOAlmWorkflowValue>();
			if(workflows!=null&&workflows.length>0){
				for(IBOAlmWorkflowValue workflow:workflows){
					workflowsMap.put(workflow.getLinkNo(), workflow);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 
	* @Title: getWorkflowInMap
	* @author lilj@asiainfo-linkage.com 
	* @Description: 根据linkNo获取workflow 
	* @param @param linkNo
	* @param @return 
	* @return IBOAlmWorkflowValue 
	* @throws
	 */
	private IBOAlmWorkflowValue getWorkflowInMap(String linkNo){
		if(workflowsMap==null||workflowsMap.size()==0){
			getAllWorkflows();
		}
		return workflowsMap.get(linkNo);
	}
	
	public IBOAlmWorkflowValue getWorkflowByLinkId(long LinkId)
	{
		try{
			IAlmWorkflowSV ws = (IAlmWorkflowSV) ServiceFactory.getService(IAlmWorkflowSV.class);
			Criteria sql = new Criteria();
			sql.addEqual(IBOAlmWorkflowValue.S_LinkId, LinkId);
			
			IBOAlmWorkflowValue[] wv = ws.getAlmWorkflowByCondition(sql.toString(),sql.getParameters());

			if (wv.length == 0)
				throw new Exception("工作流环节配置表ALM_WORKFLOW  没有配置环节ID:" + LinkId
						+ "!");
			if (wv.length > 1)
				throw new Exception("工作流环节配置表ALM_WORKFLOW  环节ID:" + LinkId
						+ "配置重复！");
			return wv[0];
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 通过指定环节编号返回对应的环节配置实例
	 * 
	 * @param linkNo
	 *            环节编号
	 * @return
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 * @author zhangbing
	 */
	public IBOAlmWorkflowValue getWorkflowByLinkNo(String linkNo)
			throws IllegalArgumentException, IllegalAccessException,
			InvocationTargetException {
		Class workflowParamClass = WorkFlowParam.getInstance().getClass();
		Method[] methods = workflowParamClass.getMethods();
		for (Method method : methods) {
			if (method.getName().equals("get" + linkNo.toUpperCase())) {
				return (IBOAlmWorkflowValue) method.invoke(WorkFlowParam.getInstance(), new Object[]{});
			}
		}
		return null;
	}
	
	/**
	 * 根据环节与条件确定下一环节的BEAN对象
	 * @param linkNo
	 * @param cond
	 * @return
	 */
	public IBOAlmWorkflowValue getNextWorkflow(String linkNo,String cond){
		try{
		Criteria condition=new Criteria();
		
		condition.addEqual(BOAlmWorkflowBean.S_TemplateType,ConstDefine.MATRIX_TEMPLATE_TYPE);
		condition.addEqual(BOAlmWorkflowBean.S_LinkNo, linkNo);
		IBOAlmWorkflowValue[] workflow=BusiFactory.getAlmWorkflowSV().getAlmWorkflowByCondition(condition.toString(),condition.getParameters());
		if(workflow.length==0)
			throw new Exception("未找到LINKNO");
		if(workflow.length>1)
			throw new Exception(ConstDefine.MATRIX_TEMPLATE_TYPE+"模版"+linkNo+"环节配置重复");
		condition.clear();
		condition.addEqual(BOTopoViewBean.S_Fpoint, workflow[0].getLinkId());
		condition.addEqual(BOTopoViewBean.S_Cond, cond);
		IBOTopoViewValue[] topoViewValue = BusiFactory.getAlmTopoViewSV().getTopoByCondition(condition.toString(), condition.getParameters());
		if(topoViewValue.length==0)
			throw new Exception("未找到环节"+linkNo);
		condition.clear();
		//找到下一环节linkNo
		condition.addEqual(BOAlmWorkflowBean.S_TemplateType,ConstDefine.MATRIX_TEMPLATE_TYPE);
		condition.addEqual(BOAlmWorkflowBean.S_LinkId, topoViewValue[0].getTpoint());
		workflow=BusiFactory.getAlmWorkflowSV().getAlmWorkflowByCondition(condition.toString(),condition.getParameters());
		if(workflow.length==0)
			throw new Exception("未找到"+linkNo+"的下一环节");
		return workflow[0];
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

	//测试计划流程
	private final IBOAlmWorkflowValue CREATETESTPLAN = getWorkflowByCondition("createTestPlan");
	private final IBOAlmWorkflowValue PLANRUNNING = getWorkflowByCondition("planRunning");
	private final IBOAlmWorkflowValue VERSIONREPORTSMT = getWorkflowByCondition("versionReportSmt");
	private final IBOAlmWorkflowValue ONLINEVERIFY = getWorkflowByCondition("onlineVerify");
	private final IBOAlmWorkflowValue ONLINETRACK = getWorkflowByCondition("onlineTrack");
	private final IBOAlmWorkflowValue TESTPLANEND = getWorkflowByCondition("testPlanEnd");
	
	//测试任务流程
	private final IBOAlmWorkflowValue CREATETESTTASK = getWorkflowByCondition("createTestTask");
	private final IBOAlmWorkflowValue TESTTASKSPLIT = getWorkflowByCondition("testTaskSplit");
	private final IBOAlmWorkflowValue TESTTASKRUNNING = getWorkflowByCondition("testTaskRunning");
	private final IBOAlmWorkflowValue TESTTASKEND = getWorkflowByCondition("testTaskEnd");
	
	//安全测试流程
	private final IBOAlmWorkflowValue CREATESECUTEST = getWorkflowByCondition("createSecuTest");
	private final IBOAlmWorkflowValue SECUTESTALLOT = getWorkflowByCondition("secuTestAllot");
	private final IBOAlmWorkflowValue SECUTESTRUNNING = getWorkflowByCondition("secuTestRunning");
	private final IBOAlmWorkflowValue SECUTESTVERIFY = getWorkflowByCondition("secuTestVerify");
	private final IBOAlmWorkflowValue SECUTESTEND = getWorkflowByCondition("secuTestEnd");
	
	
	//性能测试流程
	private final IBOAlmWorkflowValue CREATEPERFTEST = getWorkflowByCondition("createPerfTest");
	private final IBOAlmWorkflowValue PERFTESTALLOT = getWorkflowByCondition("perfTestAllot");
	private final IBOAlmWorkflowValue PERFTESTDESIGN = getWorkflowByCondition("perfTestDesign");
	private final IBOAlmWorkflowValue PERFTESTVERIFY = getWorkflowByCondition("perfTestVerify");
	private final IBOAlmWorkflowValue PERFTESTRUNNING = getWorkflowByCondition("perfTestRunning");
	private final IBOAlmWorkflowValue PERFINTERFACEVERIFY = getWorkflowByCondition("perfInterfaceVerify");
	private final IBOAlmWorkflowValue PERFTESTEND = getWorkflowByCondition("perfTestEnd");
	
	//代码扫描流程
	private final IBOAlmWorkflowValue CREATECODESCAN = getWorkflowByCondition("createCodeScan");
	private final IBOAlmWorkflowValue CODESCANALLOT = getWorkflowByCondition("codeScanAllot");
	private final IBOAlmWorkflowValue CODESCANRUNNING = getWorkflowByCondition("codeScanRunning");
	private final IBOAlmWorkflowValue CODESCANVERIFY = getWorkflowByCondition("codeScanVerify");
	private final IBOAlmWorkflowValue CODESCANEND = getWorkflowByCondition("codeScanEnd");
	
	//自动回归测试流程
	private final IBOAlmWorkflowValue CREATEREGRTEST = getWorkflowByCondition("createRegrTest");
	private final IBOAlmWorkflowValue REGRTESTALLOT = getWorkflowByCondition("regrTestAllot");
	private final IBOAlmWorkflowValue REGRTESTRUNNING = getWorkflowByCondition("regrTestRunning");
	private final IBOAlmWorkflowValue REGRTESTPRODLINKTEST = getWorkflowByCondition("regrTestProdLinkTest");
	private final IBOAlmWorkflowValue RGRTESTVERIFY = getWorkflowByCondition("rgrTestVerify");
	private final IBOAlmWorkflowValue RGRTESTPROVERIFY = getWorkflowByCondition("rgrTestProVerify");
	private final IBOAlmWorkflowValue REGRTESTEND = getWorkflowByCondition("regrTestEnd");
	
	//手工回归测试流程
	private final IBOAlmWorkflowValue CREATEHWREGRTEST = getWorkflowByCondition("createHWRegrTest");
	private final IBOAlmWorkflowValue HWREGRTESTALLOT = getWorkflowByCondition("hwRegrTestAllot");
	private final IBOAlmWorkflowValue HWREGRTESTRUNNING = getWorkflowByCondition("hwRegrTestRunning");
	private final IBOAlmWorkflowValue HWREGRTESTPRODLINKTEST = getWorkflowByCondition("hwRegrTestProdLinkTest");
	private final IBOAlmWorkflowValue HWREGRTESTVERIFY = getWorkflowByCondition("hwRegrTestVerify");
	private final IBOAlmWorkflowValue HWREGRTESTPROVERIFY = getWorkflowByCondition("hwRegrTestProVerify");
	private final IBOAlmWorkflowValue HWREGRTESTEND = getWorkflowByCondition("hwRegrTestEnd");
	
	//测试子任务流程
	private final IBOAlmWorkflowValue CREATESUBTESTTASK = getWorkflowByCondition("createSubTestTask");
	private final IBOAlmWorkflowValue SUBTESTTASKAYS = getWorkflowByCondition("subTestTaskAys");
	private final IBOAlmWorkflowValue SUBTESTTASKDSGN = getWorkflowByCondition("subTestTaskDsgn");
	private final IBOAlmWorkflowValue SUBTESTTASKVERIFY = getWorkflowByCondition("subTestTaskVerify");
	private final IBOAlmWorkflowValue SUBTESTTASKFUNCTEST = getWorkflowByCondition("subTestTaskFuncTest");
	private final IBOAlmWorkflowValue SUBTESTTASKQUAREL = getWorkflowByCondition("subTestTaskQuaRel");
	private final IBOAlmWorkflowValue SUBTESTTASKPRODUCE = getWorkflowByCondition("subTestTaskProduce");
	private final IBOAlmWorkflowValue SUBTASKTASKEND = getWorkflowByCondition("subTaskTaskEnd");
	
	//端到端测试子流程
	private final IBOAlmWorkflowValue CREATEEAESUBTASKTEST = getWorkflowByCondition("createEAESubTaskTest");
	private final IBOAlmWorkflowValue EAESUBTASKTESTAYS = getWorkflowByCondition("eaeSubTaskTestAys");
	private final IBOAlmWorkflowValue EAESUBTASKTESTDSGN = getWorkflowByCondition("eaeSubTaskTestDsgn");
	private final IBOAlmWorkflowValue EAESUBTASKTESTVERIFY = getWorkflowByCondition("eaeSubTaskTestVerify");
	private final IBOAlmWorkflowValue EAESUBTASKTESTQUAREL = getWorkflowByCondition("eaeSubTaskTestQuaRel");
	private final IBOAlmWorkflowValue EAESUBTASKTESTPRODUCE = getWorkflowByCondition("eaeSubTaskTestProduce");
	private final IBOAlmWorkflowValue EAESUBTASKTESTEND = getWorkflowByCondition("eaeSubTaskTestEnd");
	private final IBOAlmWorkflowValue EAESUBTASKTESTFUNC = getWorkflowByCondition("eaeSubTaskTestFunc");
	private final IBOAlmWorkflowValue EAESUBTASKTESTBTVERIFY = getWorkflowByCondition("eaeSubTaskTestBTVerify");
	private final IBOAlmWorkflowValue EAESUBTASKTESTONLINEVERIFY = getWorkflowByCondition("eaeSubTaskTestOnlineVerify");

	//性能子测试流程
	private final IBOAlmWorkflowValue CREATEPERFSUBTEST = getWorkflowByCondition("createPerfSubTest");
	private final IBOAlmWorkflowValue PERFSUBTASKAYS = getWorkflowByCondition("perfSubTaskAys");
	private final IBOAlmWorkflowValue PERFSUBTASKDSGN = getWorkflowByCondition("perfSubTaskDsgn");
	private final IBOAlmWorkflowValue PERFSUBTASKFUNCTEST = getWorkflowByCondition("perfSubTaskFuncTest");
	private final IBOAlmWorkflowValue PERFSUBTASKQUAREL = getWorkflowByCondition("perfSubTaskQuaRel");
	private final IBOAlmWorkflowValue PERFSUBTASKPRODUCE = getWorkflowByCondition("perfSubTaskProduce");	
	private final IBOAlmWorkflowValue PERFSUBTESTEND = getWorkflowByCondition("perfSubTestEnd");
	
	//UET任务流程
	private final IBOAlmWorkflowValue CREATEUETTASK = getWorkflowByCondition("createUETTask");
	private final IBOAlmWorkflowValue UETTASKSPLIT = getWorkflowByCondition("uetTaskSplit");
	private final IBOAlmWorkflowValue UETTASKRUNNING = getWorkflowByCondition("uetTaskRunning");
	private final IBOAlmWorkflowValue UETTASKEND = getWorkflowByCondition("uetTaskEnd");
	
	//问题跟踪流程
	private final IBOAlmWorkflowValue CREATEPROBLEMFOLLOW = getWorkflowByCondition("createProblemFollow");
	private final IBOAlmWorkflowValue TESTERMODIFY = getWorkflowByCondition("testerModify");
	private final IBOAlmWorkflowValue HANDMANVERIFY = getWorkflowByCondition("handmanVerify");
	private final IBOAlmWorkflowValue PROBLEMFOLLOWEND = getWorkflowByCondition("problemFollowEnd");
	
	//性能测试任务流程
	private final IBOAlmWorkflowValue CREATEPERFTESTTASK = getWorkflowByCondition("createPerfTestTask");
	private final IBOAlmWorkflowValue FACTORYMGRRECE = getWorkflowByCondition("factoryMgrRece");
	private final IBOAlmWorkflowValue INTERFACEALLOT = getWorkflowByCondition("interfaceAllot");
	private final IBOAlmWorkflowValue PERTESTTASKRUNNING = getWorkflowByCondition("perTestTaskRunning");
	private final IBOAlmWorkflowValue DRAFTERMODIFY = getWorkflowByCondition("drafterModify");
	private final IBOAlmWorkflowValue PERTESTTASKEND = getWorkflowByCondition("perTestTaskEnd");
	
	public IBOAlmWorkflowValue getEAESUBTASKTESTBTVERIFY() {
		return EAESUBTASKTESTBTVERIFY;
	}
	public IBOAlmWorkflowValue getEAESUBTASKTESTONLINEVERIFY() {
		return EAESUBTASKTESTONLINEVERIFY;
	}
	public IBOAlmWorkflowValue getCREATECODESCAN() {
		return CREATECODESCAN;
	}
	public IBOAlmWorkflowValue getCODESCANALLOT() {
		return CODESCANALLOT;
	}
	public IBOAlmWorkflowValue getCODESCANRUNNING() {
		return CODESCANRUNNING;
	}
	public IBOAlmWorkflowValue getCODESCANEND() {
		return CODESCANEND;
	}

	public IBOAlmWorkflowValue getCREATEREGRTEST() {
		return CREATEREGRTEST;
	}
	public IBOAlmWorkflowValue getREGRTESTALLOT() {
		return REGRTESTALLOT;
	}
	public IBOAlmWorkflowValue getREGRTESTRUNNING() {
		return REGRTESTRUNNING;
	}
	public IBOAlmWorkflowValue getREGRTESTEND() {
		return REGRTESTEND;
	}
	
	public IBOAlmWorkflowValue getCREATETESTPLAN() {
		return CREATETESTPLAN;
	}
	public IBOAlmWorkflowValue getPLANRUNNING() {
		return PLANRUNNING;
	}
	public IBOAlmWorkflowValue getVERSIONREPORTSMT() {
		return VERSIONREPORTSMT;
	}
	public IBOAlmWorkflowValue getONLINEVERIFY() {
		return ONLINEVERIFY;
	}
	public IBOAlmWorkflowValue getONLINETRACK() {
		return ONLINETRACK;
	}
	public IBOAlmWorkflowValue getTESTPLANEND() {
		return TESTPLANEND;
	}
	public IBOAlmWorkflowValue getCREATETESTTASK() {
		return CREATETESTTASK;
	}
	public IBOAlmWorkflowValue getTESTTASKSPLIT() {
		return TESTTASKSPLIT;
	}
	public IBOAlmWorkflowValue getTESTTASKRUNNING() {
		return TESTTASKRUNNING;
	}
	public IBOAlmWorkflowValue getTESTTASKEND() {
		return TESTTASKEND;
	}
	public IBOAlmWorkflowValue getCREATESECUTEST() {
		return CREATESECUTEST;
	}
	public IBOAlmWorkflowValue getSECUTESTALLOT() {
		return SECUTESTALLOT;
	}
	public IBOAlmWorkflowValue getSECUTESTRUNNING() {
		return SECUTESTRUNNING;
	}
	public IBOAlmWorkflowValue getSECUTESTEND() {
		return SECUTESTEND;
	}
	public IBOAlmWorkflowValue getCREATEPERFTEST() {
		return CREATEPERFTEST;
	}
	public IBOAlmWorkflowValue getPERFTESTALLOT() {
		return PERFTESTALLOT;
	}
	public IBOAlmWorkflowValue getPERFTESTRUNNING() {
		return PERFTESTRUNNING;
	}
	public IBOAlmWorkflowValue getPERFTESTEND() {
		return PERFTESTEND;
	}
	public IBOAlmWorkflowValue getCREATESUBTESTTASK() {
		return CREATESUBTESTTASK;
	}
	public IBOAlmWorkflowValue getSUBTESTTASKAYS() {
		return SUBTESTTASKAYS;
	}
	public IBOAlmWorkflowValue getSUBTESTTASKDSGN() {
		return SUBTESTTASKDSGN;
	}
	public IBOAlmWorkflowValue getSUBTESTTASKVERIFY() {
		return SUBTESTTASKVERIFY;
	}
	public IBOAlmWorkflowValue getSUBTESTTASKFUNCTEST() {
		return SUBTESTTASKFUNCTEST;
	}
	public IBOAlmWorkflowValue getSUBTESTTASKQUAREL() {
		return SUBTESTTASKQUAREL;
	}
	public IBOAlmWorkflowValue getSUBTESTTASKPRODUCE() {
		return SUBTESTTASKPRODUCE;
	}
	public IBOAlmWorkflowValue getSUBTASKTASKEND() {
		return SUBTASKTASKEND;
	}
	public IBOAlmWorkflowValue getCREATEEAESUBTASKTEST() {
		return CREATEEAESUBTASKTEST;
	}
	public IBOAlmWorkflowValue getEAESUBTASKTESTAYS() {
		return EAESUBTASKTESTAYS;
	}
	public IBOAlmWorkflowValue getEAESUBTASKTESTDSGN() {
		return EAESUBTASKTESTDSGN;
	}
	public IBOAlmWorkflowValue getEAESUBTASKTESTVERIFY() {
		return EAESUBTASKTESTVERIFY;
	}
	public IBOAlmWorkflowValue getEAESUBTASKTESTQUAREL() {
		return EAESUBTASKTESTQUAREL;
	}
	public IBOAlmWorkflowValue getEAESUBTASKTESTPRODUCE() {
		return EAESUBTASKTESTPRODUCE;
	}
	public IBOAlmWorkflowValue getEAESUBTASKTESTEND() {
		return EAESUBTASKTESTEND;
	}
	public IBOAlmWorkflowValue getPERFTESTDESIGN() {
		return PERFTESTDESIGN;
	}
	public IBOAlmWorkflowValue getPERFTESTVERIFY() {
		return PERFTESTVERIFY;
	}
	public IBOAlmWorkflowValue getREGRTESTPRODLINKTEST() {
		return REGRTESTPRODLINKTEST;
	}
	public IBOAlmWorkflowValue getCREATEPERFSUBTEST() {
		return CREATEPERFSUBTEST;
	}
	public IBOAlmWorkflowValue getPERFSUBTESTEND() {
		return PERFSUBTESTEND;
	}
	public IBOAlmWorkflowValue getCREATEUETTASK() {
		return CREATEUETTASK;
	}
	public IBOAlmWorkflowValue getUETTASKSPLIT() {
		return UETTASKSPLIT;
	}
	public IBOAlmWorkflowValue getUETTASKRUNNING() {
		return UETTASKRUNNING;
	}
	public IBOAlmWorkflowValue getUETTASKEND() {
		return UETTASKEND;
	}
	public IBOAlmWorkflowValue getEAESUBTASKTESTFUNC() {
		return EAESUBTASKTESTFUNC;
	}
	public IBOAlmWorkflowValue getCREATEHWREGRTEST() {
		return CREATEHWREGRTEST;
	}
	public IBOAlmWorkflowValue getHWREGRTESTALLOT() {
		return HWREGRTESTALLOT;
	}
	public IBOAlmWorkflowValue getHWREGRTESTRUNNING() {
		return HWREGRTESTRUNNING;
	}
	public IBOAlmWorkflowValue getHWREGRTESTPRODLINKTEST() {
		return HWREGRTESTPRODLINKTEST;
	}
	public IBOAlmWorkflowValue getHWREGRTESTEND() {
		return HWREGRTESTEND;
	}
	public IBOAlmWorkflowValue getCREATEPROBLEMFOLLOW() {
		return CREATEPROBLEMFOLLOW;
	}
	public IBOAlmWorkflowValue getTESTERMODIFY() {
		return TESTERMODIFY;
	}
	public IBOAlmWorkflowValue getHANDMANVERIFY() {
		return HANDMANVERIFY;
	}
	public IBOAlmWorkflowValue getPROBLEMFOLLOWEND() {
		return PROBLEMFOLLOWEND;
	}
	public IBOAlmWorkflowValue getPERFSUBTASKAYS() {
		return PERFSUBTASKAYS;
	}
	public IBOAlmWorkflowValue getPERFSUBTASKDSGN() {
		return PERFSUBTASKDSGN;
	}
	public IBOAlmWorkflowValue getPERFSUBTASKFUNCTEST() {
		return PERFSUBTASKFUNCTEST;
	}
	public IBOAlmWorkflowValue getPERFSUBTASKQUAREL() {
		return PERFSUBTASKQUAREL;
	}
	public IBOAlmWorkflowValue getPERFSUBTASKPRODUCE() {
		return PERFSUBTASKPRODUCE;
	}
	public IBOAlmWorkflowValue getCREATEPERFTESTTASK() {
		return CREATEPERFTESTTASK;
	}
	public IBOAlmWorkflowValue getFACTORYMGRRECE() {
		return FACTORYMGRRECE;
	}
	public IBOAlmWorkflowValue getINTERFACEALLOT() {
		return INTERFACEALLOT;
	}
	public IBOAlmWorkflowValue getPERTESTTASKRUNNING() {
		return PERTESTTASKRUNNING;
	}
	public IBOAlmWorkflowValue getDRAFTERMODIFY() {
		return DRAFTERMODIFY;
	}
	public IBOAlmWorkflowValue getPERTESTTASKEND() {
		return PERTESTTASKEND;
	}
	public IBOAlmWorkflowValue getSECUTESTVERIFY() {
		return SECUTESTVERIFY;
	}
	public IBOAlmWorkflowValue getCODESCANVERIFY() {
		return CODESCANVERIFY;
	}
	public IBOAlmWorkflowValue getRGRTESTVERIFY() {
		return RGRTESTVERIFY;
	}
	public IBOAlmWorkflowValue getHWREGRTESTVERIFY() {
		return HWREGRTESTVERIFY;
	}
	public IBOAlmWorkflowValue getRGRTESTPROVERIFY() {
		return RGRTESTPROVERIFY;
	}
	public IBOAlmWorkflowValue getHWREGRTESTPROVERIFY() {
		return HWREGRTESTPROVERIFY;
	}
	public IBOAlmWorkflowValue getPERFINTERFACEVERIFY() {
		return PERFINTERFACEVERIFY;
	}


}
