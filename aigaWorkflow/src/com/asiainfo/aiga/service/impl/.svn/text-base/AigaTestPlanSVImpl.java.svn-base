package com.asiainfo.aiga.service.impl;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.ai.secframe.common.Constants;
import com.ai.secframe.ivalues.orgmodel.IStaffValue;
import com.ai.secframe.service.pubapi.interfaces.ISecframe;
import com.asiainfo.aiga.bo.BOAigaSolidTaskBean;
import com.asiainfo.aiga.bo.BOAigaTestPlanBean;
import com.asiainfo.aiga.bo.BOAigaTestPlanChangeBean;
import com.asiainfo.aiga.dao.interfaces.IAigaTestPlanDao;
import com.asiainfo.aiga.dao.interfaces.IAigaTestSubTaskDao;
import com.asiainfo.aiga.ivalues.IBOAigaSolidTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestPlanChangeValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestPlanValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestSubTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestTaskValue;
import com.asiainfo.aiga.service.interfaces.IAigaPublicSV;
import com.asiainfo.aiga.service.interfaces.IAigaSolidTaskSV;
import com.asiainfo.aiga.service.interfaces.IAigaTestPlanSV;
import com.asiainfo.aiga.service.interfaces.IAigaTestTaskSV;
import com.asiainfo.csc.common.common.ConstDefine;
import com.asiainfo.csc.common.define.IObjectType;
import com.asiainfo.csc.common.define.IStakeholderType;
import com.asiainfo.csc.common.define.WorkFlowParam;
import com.asiainfo.csc.common.ivalues.IBOStaffManagerRelatValue;
import com.asiainfo.csc.common.service.interfaces.IStaffManagerRelatSV;
import com.asiainfo.csc.matrix.bo.BOAlmStakeholderBean;
import com.asiainfo.csc.matrix.common.AlmMatrixClient;
import com.asiainfo.csc.matrix.common.impl.AlmVmTaskImpl;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmStakeholderDao;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public class AigaTestPlanSVImpl extends AlmVmTaskImpl implements IAigaTestPlanSV {

	private IAigaTestPlanDao aigaTestPlanDao = (IAigaTestPlanDao)ServiceFactory.getService(IAigaTestPlanDao.class);
	private IAigaTestSubTaskDao  aigaTestSubTaskDao= (IAigaTestSubTaskDao)ServiceFactory.getService(IAigaTestSubTaskDao.class);
	@Override
	public void updateObjCurPhaseAndCurStatus(String objId, String objType,
			String linkId) throws Exception {
		// TODO Auto-generated method stub
		IBOAlmWorkflowValue iWorkflowValue = WorkFlowParam.getInstance().getWorkflowByLinkId(Long.valueOf(linkId));
		if(iWorkflowValue==null)
			throw new Exception("未查找到环节,函数updateObjCurPhaseAndCurStatus");
		
		Criteria sql = new Criteria();
		if(objType.equals(IObjectType.TESTPLAN)){
			sql.addEqual(BOAigaTestPlanBean.S_PlanId, objId);
			IBOAigaTestPlanValue[] planValues = aigaTestPlanDao.getAigaTestPlan(sql.toString(), sql.getParameters());
			if(planValues.length==1){
				planValues[0].setPlanStatus(Long.valueOf(linkId));
				aigaTestPlanDao.saveAigaTestPlan(planValues[0]);
			}
		}
	}

	@Override
	public void extraMethod(long orderId, String objId, String objType,
			String methodType) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void startWorkflow(IBOAigaTestPlanValue aValue, String cond,
			String option) throws Exception {
		// TODO Auto-generated method stub
		this.saveTestPlanAndFirstWorkorder(aValue, cond, option);
		new AlmMatrixClient().createWorkflow("com.asiainfo.aiga.workflow.testPlanWF", String.valueOf(1), IObjectType.TESTPLAN, String.valueOf(aValue.getPlanId()), ServiceManager.getOpDateTime(), "测试计划流程创建", cond);
	}

	@Override
	public void saveWorkorder(IBOAlmWorkorderValue woValue,
			List<IBOAlmStakeholderValue> IShVList, String cond)
			throws Exception {
		// TODO Auto-generated method stub
		new AlmMatrixClient().saveWorkorder(woValue, IShVList, cond);
	}

	@Override
	public void approveWorkorder(IBOAlmWorkorderValue woValue,
			List<IBOAlmStakeholderValue> IShVList, String cond)
			throws Exception {
		// TODO Auto-generated method stub
		new AlmMatrixClient().saveWorkorder(woValue, IShVList, cond);
		new AlmMatrixClient().finishUserTask(woValue.getOrderId(), woValue.getResult(), woValue.getOpinion(), cond);
	}

	@Override
	public void saveTestPlanAndFirstWorkorder(IBOAigaTestPlanValue value,
			String cond, String option) throws Exception {
		// TODO Auto-generated method stub
		new AlmMatrixClient().createStartSaveOrder(String.valueOf(value.getPlanId()), IObjectType.TESTPLAN, "com.asiainfo.aiga.workflow.testPlanWF", cond, option);
	}


	@Override
	public void startTestPlanWorkflow(List<IBOAigaTestPlanValue> atps, List<IBOAlmStakeholderValue> stds,
			List<IBOAlmWorkorderValue> orders,List<IBOAigaTestTaskValue> attasks,
			List<IBOAigaSolidTaskValue> astasks) throws Exception {
		// TODO Auto-generated method stub
		
//		String condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"42676\"></cond></conds>";
		
		WorkFlowParam workFlowParam = WorkFlowParam.getInstance();
		//获取测试计划相关干系人
		List<IBOAlmStakeholderValue> tpStds = new ArrayList<IBOAlmStakeholderValue>();
		//获取固化任务相关干系人
		List<IBOAlmStakeholderValue> stStds = new ArrayList<IBOAlmStakeholderValue>();
		
		for(IBOAlmStakeholderValue value : stds)
		{
			if(value.getLinkNo().equals(workFlowParam.getCREATETESTPLAN().getLinkNo()) || 
					value.getLinkNo().equals(workFlowParam.getPLANRUNNING().getLinkNo()))
			{
				tpStds.add(value);
			}
//			if(value.getObjType() != null && !value.getObjType().equals(""))
//			{
//				stStds.add(value);
//			}
		}
		//保存测试计划
		IBOAigaTestPlanValue tpValue = saveAigaTestPlan(atps.get(0));
		//启动测试计划流程
//		orders.get(0).setCond(condString);
		startTestPlanWorkflow(tpValue,tpStds,orders.get(0));

		//处理固化任务，根据测试计划中对固化任务的选择，创建固化任务
		Criteria criteria = new Criteria();
		ISecframe secframe = (ISecframe) ServiceFactory.getService(Constants.SERVICE_SECFRAME);
		IStaffValue staff = null;
//		ISysStaffValue sys_staff = secframe.getSysStaffByCode(staff.getCode());
		
		IStaffManagerRelatSV iStaffManagerRelatSV=(IStaffManagerRelatSV)ServiceFactory.getService(IStaffManagerRelatSV.class);
		IBOStaffManagerRelatValue[] iSMRValue = null;
		if(tpValue.getIsSecurityTest() == 1)
		{
			IBOAigaSolidTaskValue iasTaskValue = new BOAigaSolidTaskBean();
			iasTaskValue.setTaskType(Long.valueOf(IObjectType.SOLIDTESTTASK_SECUTEST));
			astasks.add(iasTaskValue);
			criteria.clear();
			criteria.addEqual(IBOStaffManagerRelatValue.S_SysTag,tpValue.getBigType());
			criteria.addEqual(IBOStaffManagerRelatValue.S_ReqType,IObjectType.SOLIDTESTTASK_SECUTEST);
			iSMRValue=iStaffManagerRelatSV.getStaffManagerByCondition(criteria.toString(), criteria.getParameters());
			if(iSMRValue==null||iSMRValue.length==0)
			{
				throw new Exception("没有在sys_staff_manager_relat中配置安全测试人，需求类型getBigType，系统类型"+IObjectType.SOLIDTESTTASK_SECUTEST+"！！！");
			}
			IBOAlmStakeholderValue approvalStakeholderCreate = new BOAlmStakeholderBean();
			approvalStakeholderCreate.setLinkId(workFlowParam.getCREATESECUTEST().getLinkId());
			approvalStakeholderCreate.setLinkNo(workFlowParam.getCREATESECUTEST().getLinkNo());
			approvalStakeholderCreate.setTemplateId(workFlowParam.getCREATESECUTEST().getTemplateId());
			approvalStakeholderCreate.setStdholderStaffId(tpValue.getSubmitStaffId());
			staff = secframe.getStaffByStaffId(tpValue.getSubmitStaffId());
			approvalStakeholderCreate.setStdholderStaffNo(staff.getCode());
			approvalStakeholderCreate.setStdholderStaffName(tpValue.getSubmitStaffName());
			approvalStakeholderCreate.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderCreate.setObjType(IObjectType.SOLIDTESTTASK_SECUTEST);
			stStds.add(approvalStakeholderCreate);
//			IBOAlmStakeholderValue approvalStakeholderAllot = new BOAlmStakeholderBean();
//			approvalStakeholderAllot.setLinkId(workFlowParam.getSECUTESTALLOT().getLinkId());
//			approvalStakeholderAllot.setLinkNo(workFlowParam.getSECUTESTALLOT().getLinkNo());
//			approvalStakeholderAllot.setTemplateId(workFlowParam.getSECUTESTALLOT().getTemplateId());
//			approvalStakeholderAllot.setStdholderStaffId(iSMRValue[0].getStaffId());
//			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
//			approvalStakeholderAllot.setStdholderStaffNo(staff.getCode());
//			approvalStakeholderAllot.setStdholderStaffName(iSMRValue[0].getStaffName());
//			approvalStakeholderAllot.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
//			approvalStakeholderAllot.setObjType(IObjectType.SOLIDTESTTASK_SECUTEST);
			
			IBOAlmStakeholderValue approvalStakeholderRunning = new BOAlmStakeholderBean();
			approvalStakeholderRunning.setLinkId(workFlowParam.getSECUTESTRUNNING().getLinkId());
			approvalStakeholderRunning.setLinkNo(workFlowParam.getSECUTESTRUNNING().getLinkNo());
			approvalStakeholderRunning.setTemplateId(workFlowParam.getSECUTESTRUNNING().getTemplateId());
			approvalStakeholderRunning.setStdholderStaffId(iSMRValue[0].getStaffId());
			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
			approvalStakeholderRunning.setStdholderStaffNo(staff.getCode());
			approvalStakeholderRunning.setStdholderStaffName(iSMRValue[0].getStaffName());
			approvalStakeholderRunning.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderRunning.setObjType(IObjectType.SOLIDTESTTASK_SECUTEST);
			stStds.add(approvalStakeholderRunning);
			
			criteria.clear();
			criteria.addEqual(IBOStaffManagerRelatValue.S_SysTag,"99");
			criteria.addEqual(IBOStaffManagerRelatValue.S_ReqType,IObjectType.SOLIDTESTTASK_SECUTEST);
			iSMRValue=iStaffManagerRelatSV.getStaffManagerByCondition(criteria.toString(), criteria.getParameters());
			if(iSMRValue==null||iSMRValue.length==0)
			{
				throw new Exception("没有在sys_staff_manager_relat中配置安全测试评审人，需求类型99，系统类型"+IObjectType.SOLIDTESTTASK_SECUTEST+"！！！");
			}
			
			IBOAlmStakeholderValue approvalStakeholderVerify = new BOAlmStakeholderBean();
			approvalStakeholderVerify.setLinkId(workFlowParam.getSECUTESTVERIFY().getLinkId());
			approvalStakeholderVerify.setLinkNo(workFlowParam.getSECUTESTVERIFY().getLinkNo());
			approvalStakeholderVerify.setTemplateId(workFlowParam.getSECUTESTVERIFY().getTemplateId());
			approvalStakeholderVerify.setStdholderStaffId(iSMRValue[0].getStaffId());
			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
			approvalStakeholderVerify.setStdholderStaffNo(staff.getCode());
			approvalStakeholderVerify.setStdholderStaffName(iSMRValue[0].getStaffName());
			approvalStakeholderVerify.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderVerify.setObjType(IObjectType.SOLIDTESTTASK_SECUTEST);
			stStds.add(approvalStakeholderVerify);
		}
		if(tpValue.getIsPerformanceTest() == 1)
		{
			IBOAigaSolidTaskValue iasTaskValue = new BOAigaSolidTaskBean();
			iasTaskValue.setTaskType(Long.valueOf(IObjectType.SOLIDTESTTASK_PERFTEST));
			astasks.add(iasTaskValue);
			criteria.clear();
			criteria.addEqual(IBOStaffManagerRelatValue.S_SysTag,"1");
			criteria.addEqual(IBOStaffManagerRelatValue.S_ReqType,IObjectType.SOLIDTESTTASK_PERFTEST);
			iSMRValue=iStaffManagerRelatSV.getStaffManagerByCondition(criteria.toString(), criteria.getParameters());
			if(iSMRValue==null||iSMRValue.length==0)
			{
				throw new Exception("没有在sys_staff_manager_relat中配置性能测试负责人，需求类型1，系统类型"+IObjectType.SOLIDTESTTASK_SECUTEST+"！！！");
			}
			IBOAlmStakeholderValue approvalStakeholderCreate = new BOAlmStakeholderBean();
			approvalStakeholderCreate.setLinkId(workFlowParam.getCREATEPERFTEST().getLinkId());
			approvalStakeholderCreate.setLinkNo(workFlowParam.getCREATEPERFTEST().getLinkNo());
			approvalStakeholderCreate.setTemplateId(workFlowParam.getCREATEPERFTEST().getTemplateId());
			approvalStakeholderCreate.setStdholderStaffId(tpValue.getSubmitStaffId());
			staff = secframe.getStaffByStaffId(tpValue.getSubmitStaffId());
			approvalStakeholderCreate.setStdholderStaffNo(staff.getCode());
			approvalStakeholderCreate.setStdholderStaffName(tpValue.getSubmitStaffName());
			approvalStakeholderCreate.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderCreate.setObjType(IObjectType.SOLIDTESTTASK_PERFTEST);
			stStds.add(approvalStakeholderCreate);
			IBOAlmStakeholderValue approvalStakeholderAllot = new BOAlmStakeholderBean();
			approvalStakeholderAllot.setLinkId(workFlowParam.getPERFTESTALLOT().getLinkId());
			approvalStakeholderAllot.setLinkNo(workFlowParam.getPERFTESTALLOT().getLinkNo());
			approvalStakeholderAllot.setTemplateId(workFlowParam.getPERFTESTALLOT().getTemplateId());
			approvalStakeholderAllot.setStdholderStaffId(iSMRValue[0].getStaffId());
			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
			approvalStakeholderAllot.setStdholderStaffNo(staff.getCode());
			approvalStakeholderAllot.setStdholderStaffName(iSMRValue[0].getStaffName());
			approvalStakeholderAllot.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderAllot.setObjType(IObjectType.SOLIDTESTTASK_PERFTEST);
			stStds.add(approvalStakeholderAllot);
			
			criteria.clear();
			criteria.addEqual(IBOStaffManagerRelatValue.S_SysTag,"99");
			criteria.addEqual(IBOStaffManagerRelatValue.S_ReqType,IObjectType.SOLIDTESTTASK_PERFTEST);
			iSMRValue=iStaffManagerRelatSV.getStaffManagerByCondition(criteria.toString(), criteria.getParameters());
			if(iSMRValue==null||iSMRValue.length==0)
			{
				throw new Exception("没有在sys_staff_manager_relat中配置性能测试评审人，需求类型99，系统类型"+IObjectType.SOLIDTESTTASK_SECUTEST+"！！！");
			}
			IBOAlmStakeholderValue approvalStakeholderVerify = new BOAlmStakeholderBean();
			approvalStakeholderVerify.setLinkId(workFlowParam.getPERFTESTVERIFY().getLinkId());
			approvalStakeholderVerify.setLinkNo(workFlowParam.getPERFTESTVERIFY().getLinkNo());
			approvalStakeholderVerify.setTemplateId(workFlowParam.getPERFTESTVERIFY().getTemplateId());
			approvalStakeholderVerify.setStdholderStaffId(iSMRValue[0].getStaffId());
			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
			approvalStakeholderVerify.setStdholderStaffNo(staff.getCode());
			approvalStakeholderVerify.setStdholderStaffName(iSMRValue[0].getStaffName());
			approvalStakeholderVerify.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderVerify.setObjType(IObjectType.SOLIDTESTTASK_PERFTEST);
			stStds.add(approvalStakeholderVerify);
		}
		if(tpValue.getIsCodeScan() == 1)
		{
			IBOAigaSolidTaskValue iasTaskValue = new BOAigaSolidTaskBean();
			iasTaskValue.setTaskType(Long.valueOf(IObjectType.SOLIDTESTTASK_CODESCAN));
			astasks.add(iasTaskValue);
			criteria.clear();
			criteria.addEqual(IBOStaffManagerRelatValue.S_SysTag,"1");
			criteria.addEqual(IBOStaffManagerRelatValue.S_ReqType,IObjectType.SOLIDTESTTASK_CODESCAN);
			iSMRValue=iStaffManagerRelatSV.getStaffManagerByCondition(criteria.toString(), criteria.getParameters());
			if(iSMRValue==null||iSMRValue.length==0)
			{
				throw new Exception("没有在sys_staff_manager_relat中配置代码扫描负责人，需求类型1，系统类型"+IObjectType.SOLIDTESTTASK_CODESCAN+"！！！");
			}
			IBOAlmStakeholderValue approvalStakeholderCreate = new BOAlmStakeholderBean();
			approvalStakeholderCreate.setLinkId(workFlowParam.getCREATECODESCAN().getLinkId());
			approvalStakeholderCreate.setLinkNo(workFlowParam.getCREATECODESCAN().getLinkNo());
			approvalStakeholderCreate.setTemplateId(workFlowParam.getCREATECODESCAN().getTemplateId());
			approvalStakeholderCreate.setStdholderStaffId(tpValue.getSubmitStaffId());
			staff = secframe.getStaffByStaffId(tpValue.getSubmitStaffId());
			approvalStakeholderCreate.setStdholderStaffNo(staff.getCode());
			approvalStakeholderCreate.setStdholderStaffName(tpValue.getSubmitStaffName());
			approvalStakeholderCreate.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderCreate.setObjType(IObjectType.SOLIDTESTTASK_CODESCAN);
			stStds.add(approvalStakeholderCreate);
			IBOAlmStakeholderValue approvalStakeholderAllot = new BOAlmStakeholderBean();
			approvalStakeholderAllot.setLinkId(workFlowParam.getCODESCANALLOT().getLinkId());
			approvalStakeholderAllot.setLinkNo(workFlowParam.getCODESCANALLOT().getLinkNo());
			approvalStakeholderAllot.setTemplateId(workFlowParam.getCODESCANALLOT().getTemplateId());
			approvalStakeholderAllot.setStdholderStaffId(iSMRValue[0].getStaffId());
			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
			approvalStakeholderAllot.setStdholderStaffNo(staff.getCode());
			approvalStakeholderAllot.setStdholderStaffName(iSMRValue[0].getStaffName());
			approvalStakeholderAllot.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderAllot.setObjType(IObjectType.SOLIDTESTTASK_CODESCAN);
			stStds.add(approvalStakeholderAllot);
			
			criteria.clear();
			criteria.addEqual(IBOStaffManagerRelatValue.S_SysTag,"99");
			criteria.addEqual(IBOStaffManagerRelatValue.S_ReqType,IObjectType.SOLIDTESTTASK_CODESCAN);
			iSMRValue=iStaffManagerRelatSV.getStaffManagerByCondition(criteria.toString(), criteria.getParameters());
			if(iSMRValue==null||iSMRValue.length==0)
			{
				throw new Exception("没有在sys_staff_manager_relat中配置代码扫描评审人，需求类型99，系统类型"+IObjectType.SOLIDTESTTASK_CODESCAN+"！！！");
			}
			IBOAlmStakeholderValue approvalStakeholderVerify = new BOAlmStakeholderBean();
			approvalStakeholderVerify.setLinkId(workFlowParam.getCODESCANVERIFY().getLinkId());
			approvalStakeholderVerify.setLinkNo(workFlowParam.getCODESCANVERIFY().getLinkNo());
			approvalStakeholderVerify.setTemplateId(workFlowParam.getCODESCANVERIFY().getTemplateId());
			approvalStakeholderVerify.setStdholderStaffId(iSMRValue[0].getStaffId());
			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
			approvalStakeholderVerify.setStdholderStaffNo(staff.getCode());
			approvalStakeholderVerify.setStdholderStaffName(iSMRValue[0].getStaffName());
			approvalStakeholderVerify.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderVerify.setObjType(IObjectType.SOLIDTESTTASK_CODESCAN);
			stStds.add(approvalStakeholderVerify);
		}
		if(tpValue.getIsRegressionTest() == 1)
		{
			IBOAigaSolidTaskValue iasTaskValue = new BOAigaSolidTaskBean();
			iasTaskValue.setTaskType(Long.valueOf(IObjectType.SOLIDTESTTASK_REGRTEST));
			astasks.add(iasTaskValue);
			criteria.clear();
			criteria.addEqual(IBOStaffManagerRelatValue.S_SysTag,tpValue.getBigType());
			criteria.addEqual(IBOStaffManagerRelatValue.S_ReqType,IObjectType.SOLIDTESTTASK_REGRTEST);
			iSMRValue=iStaffManagerRelatSV.getStaffManagerByCondition(criteria.toString(), criteria.getParameters());
			if(iSMRValue==null||iSMRValue.length==0)
			{
				throw new Exception("没有在sys_staff_manager_relat中配置回归测试负责人，需求类型1，系统类型"+IObjectType.SOLIDTESTTASK_REGRTEST+"！！！");
			}
			IBOAlmStakeholderValue approvalStakeholderCreate = new BOAlmStakeholderBean();
			approvalStakeholderCreate.setLinkId(workFlowParam.getCREATEREGRTEST().getLinkId());
			approvalStakeholderCreate.setLinkNo(workFlowParam.getCREATEREGRTEST().getLinkNo());
			approvalStakeholderCreate.setTemplateId(workFlowParam.getCREATEREGRTEST().getTemplateId());
			approvalStakeholderCreate.setStdholderStaffId(tpValue.getSubmitStaffId());
			staff = secframe.getStaffByStaffId(tpValue.getSubmitStaffId());
			approvalStakeholderCreate.setStdholderStaffNo(staff.getCode());
			approvalStakeholderCreate.setStdholderStaffName(tpValue.getSubmitStaffName());
			approvalStakeholderCreate.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderCreate.setObjType(IObjectType.SOLIDTESTTASK_REGRTEST);
			stStds.add(approvalStakeholderCreate);
//			IBOAlmStakeholderValue approvalStakeholderAllot = new BOAlmStakeholderBean();
//			approvalStakeholderAllot.setLinkId(workFlowParam.getREGRTESTALLOT().getLinkId());
//			approvalStakeholderAllot.setLinkNo(workFlowParam.getREGRTESTALLOT().getLinkNo());
//			approvalStakeholderAllot.setTemplateId(workFlowParam.getREGRTESTALLOT().getTemplateId());
//			approvalStakeholderAllot.setStdholderStaffId(iSMRValue[0].getStaffId());
//			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
//			approvalStakeholderAllot.setStdholderStaffNo(staff.getCode());
//			approvalStakeholderAllot.setStdholderStaffName(iSMRValue[0].getStaffName());
//			approvalStakeholderAllot.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
//			approvalStakeholderAllot.setObjType(IObjectType.SOLIDTESTTASK_REGRTEST);
//			stStds.add(approvalStakeholderAllot);
			
			IBOAlmStakeholderValue approvalStakeholderRunning = new BOAlmStakeholderBean();
			approvalStakeholderRunning.setLinkId(workFlowParam.getREGRTESTRUNNING().getLinkId());
			approvalStakeholderRunning.setLinkNo(workFlowParam.getREGRTESTRUNNING().getLinkNo());
			approvalStakeholderRunning.setTemplateId(workFlowParam.getREGRTESTRUNNING().getTemplateId());
			approvalStakeholderRunning.setStdholderStaffId(iSMRValue[0].getStaffId());
			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
			approvalStakeholderRunning.setStdholderStaffNo(staff.getCode());
			approvalStakeholderRunning.setStdholderStaffName(iSMRValue[0].getStaffName());
			approvalStakeholderRunning.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderRunning.setObjType(IObjectType.SOLIDTESTTASK_REGRTEST);
			stStds.add(approvalStakeholderRunning);
			
			IBOAlmStakeholderValue approvalStakeholderPro = new BOAlmStakeholderBean();
			approvalStakeholderPro.setLinkId(workFlowParam.getREGRTESTPRODLINKTEST().getLinkId());
			approvalStakeholderPro.setLinkNo(workFlowParam.getREGRTESTPRODLINKTEST().getLinkNo());
			approvalStakeholderPro.setTemplateId(workFlowParam.getREGRTESTPRODLINKTEST().getTemplateId());
			approvalStakeholderPro.setStdholderStaffId(iSMRValue[0].getStaffId());
			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
			approvalStakeholderPro.setStdholderStaffNo(staff.getCode());
			approvalStakeholderPro.setStdholderStaffName(iSMRValue[0].getStaffName());
			approvalStakeholderPro.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderPro.setObjType(IObjectType.SOLIDTESTTASK_REGRTEST);
			stStds.add(approvalStakeholderPro);
			
			criteria.clear();
			criteria.addEqual(IBOStaffManagerRelatValue.S_SysTag,"99");
			criteria.addEqual(IBOStaffManagerRelatValue.S_ReqType,IObjectType.SOLIDTESTTASK_REGRTEST);
			iSMRValue=iStaffManagerRelatSV.getStaffManagerByCondition(criteria.toString(), criteria.getParameters());
			if(iSMRValue==null||iSMRValue.length==0)
			{
				throw new Exception("没有在sys_staff_manager_relat中配置回归测试评审人，需求类型99，系统类型"+IObjectType.SOLIDTESTTASK_REGRTEST+"！！！");
			}
			IBOAlmStakeholderValue approvalStakeholderVerify = new BOAlmStakeholderBean();
			approvalStakeholderVerify.setLinkId(workFlowParam.getRGRTESTVERIFY().getLinkId());
			approvalStakeholderVerify.setLinkNo(workFlowParam.getRGRTESTVERIFY().getLinkNo());
			approvalStakeholderVerify.setTemplateId(workFlowParam.getRGRTESTVERIFY().getTemplateId());
			approvalStakeholderVerify.setStdholderStaffId(iSMRValue[0].getStaffId());
			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
			approvalStakeholderVerify.setStdholderStaffNo(staff.getCode());
			approvalStakeholderVerify.setStdholderStaffName(iSMRValue[0].getStaffName());
			approvalStakeholderVerify.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderVerify.setObjType(IObjectType.SOLIDTESTTASK_REGRTEST);
			stStds.add(approvalStakeholderVerify);
			
			IBOAlmStakeholderValue approvalStakeholderProVerify = new BOAlmStakeholderBean();
			approvalStakeholderProVerify.setLinkId(workFlowParam.getRGRTESTPROVERIFY().getLinkId());
			approvalStakeholderProVerify.setLinkNo(workFlowParam.getRGRTESTPROVERIFY().getLinkNo());
			approvalStakeholderProVerify.setTemplateId(workFlowParam.getRGRTESTPROVERIFY().getTemplateId());
			approvalStakeholderProVerify.setStdholderStaffId(iSMRValue[0].getStaffId());
			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
			approvalStakeholderProVerify.setStdholderStaffNo(staff.getCode());
			approvalStakeholderProVerify.setStdholderStaffName(iSMRValue[0].getStaffName());
			approvalStakeholderProVerify.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderProVerify.setObjType(IObjectType.SOLIDTESTTASK_REGRTEST);
			stStds.add(approvalStakeholderProVerify);
		}
		
		if(tpValue.getIsHwregressionTest() == 1)
		{
			IBOAigaSolidTaskValue iasTaskValue = new BOAigaSolidTaskBean();
			iasTaskValue.setTaskType(Long.valueOf(IObjectType.SOLIDTESTTASK_REGRTEST_HW));
			astasks.add(iasTaskValue);
			criteria.clear();
			criteria.addEqual(IBOStaffManagerRelatValue.S_SysTag,tpValue.getBigType());
			criteria.addEqual(IBOStaffManagerRelatValue.S_ReqType,IObjectType.SOLIDTESTTASK_REGRTEST_HW);

			iSMRValue=iStaffManagerRelatSV.getStaffManagerByCondition(criteria.toString(), criteria.getParameters());
			if(iSMRValue==null||iSMRValue.length==0)
			{
				throw new Exception("没有在sys_staff_manager_relat中配置手工回归测试负责人，需求类型"+tpValue.getBigType()+"，系统类型"+IObjectType.SOLIDTESTTASK_REGRTEST_HW+"！！！");
			}
			IBOAlmStakeholderValue approvalStakeholderCreate = new BOAlmStakeholderBean();
			approvalStakeholderCreate.setLinkId(workFlowParam.getCREATEHWREGRTEST().getLinkId());
			approvalStakeholderCreate.setLinkNo(workFlowParam.getCREATEHWREGRTEST().getLinkNo());
			approvalStakeholderCreate.setTemplateId(workFlowParam.getCREATEHWREGRTEST().getTemplateId());
			approvalStakeholderCreate.setStdholderStaffId(tpValue.getSubmitStaffId());
			staff = secframe.getStaffByStaffId(tpValue.getSubmitStaffId());
			approvalStakeholderCreate.setStdholderStaffNo(staff.getCode());
			approvalStakeholderCreate.setStdholderStaffName(tpValue.getSubmitStaffName());
			approvalStakeholderCreate.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderCreate.setObjType(IObjectType.SOLIDTESTTASK_REGRTEST_HW);
			stStds.add(approvalStakeholderCreate);
//			IBOAlmStakeholderValue approvalStakeholderAllot = new BOAlmStakeholderBean();
//			approvalStakeholderAllot.setLinkId(workFlowParam.getHWREGRTESTALLOT().getLinkId());
//			approvalStakeholderAllot.setLinkNo(workFlowParam.getHWREGRTESTALLOT().getLinkNo());
//			approvalStakeholderAllot.setTemplateId(workFlowParam.getHWREGRTESTALLOT().getTemplateId());
//			approvalStakeholderAllot.setStdholderStaffId(iSMRValue[0].getStaffId());
//			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
//			approvalStakeholderAllot.setStdholderStaffNo(staff.getCode());
//			approvalStakeholderAllot.setStdholderStaffName(iSMRValue[0].getStaffName());
//			approvalStakeholderAllot.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
//			approvalStakeholderAllot.setObjType(IObjectType.SOLIDTESTTASK_REGRTEST_HW);
//			stStds.add(approvalStakeholderAllot);
			
			IBOAlmStakeholderValue approvalStakeholderRunning = new BOAlmStakeholderBean();
			approvalStakeholderRunning.setLinkId(workFlowParam.getHWREGRTESTRUNNING().getLinkId());
			approvalStakeholderRunning.setLinkNo(workFlowParam.getHWREGRTESTRUNNING().getLinkNo());
			approvalStakeholderRunning.setTemplateId(workFlowParam.getHWREGRTESTRUNNING().getTemplateId());
			approvalStakeholderRunning.setStdholderStaffId(iSMRValue[0].getStaffId());
			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
			approvalStakeholderRunning.setStdholderStaffNo(staff.getCode());
			approvalStakeholderRunning.setStdholderStaffName(iSMRValue[0].getStaffName());
			approvalStakeholderRunning.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderRunning.setObjType(IObjectType.SOLIDTESTTASK_REGRTEST_HW);
			stStds.add(approvalStakeholderRunning);
			
			IBOAlmStakeholderValue approvalStakeholderPro = new BOAlmStakeholderBean();
			approvalStakeholderPro.setLinkId(workFlowParam.getHWREGRTESTPRODLINKTEST().getLinkId());
			approvalStakeholderPro.setLinkNo(workFlowParam.getHWREGRTESTPRODLINKTEST().getLinkNo());
			approvalStakeholderPro.setTemplateId(workFlowParam.getHWREGRTESTPRODLINKTEST().getTemplateId());
			approvalStakeholderPro.setStdholderStaffId(iSMRValue[0].getStaffId());
			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
			approvalStakeholderPro.setStdholderStaffNo(staff.getCode());
			approvalStakeholderPro.setStdholderStaffName(iSMRValue[0].getStaffName());
			approvalStakeholderPro.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderPro.setObjType(IObjectType.SOLIDTESTTASK_REGRTEST_HW);
			stStds.add(approvalStakeholderPro);
			
			criteria.clear();
			criteria.addEqual(IBOStaffManagerRelatValue.S_SysTag,"99");
			criteria.addEqual(IBOStaffManagerRelatValue.S_ReqType,IObjectType.SOLIDTESTTASK_REGRTEST_HW);

			iSMRValue=iStaffManagerRelatSV.getStaffManagerByCondition(criteria.toString(), criteria.getParameters());
			if(iSMRValue==null||iSMRValue.length==0)
			{
				throw new Exception("没有在sys_staff_manager_relat中配置手工回归测试评审人，需求类型"+tpValue.getBigType()+"，系统类型"+IObjectType.SOLIDTESTTASK_REGRTEST_HW+"！！！");
			}
			IBOAlmStakeholderValue approvalStakeholderVerify = new BOAlmStakeholderBean();
			approvalStakeholderVerify.setLinkId(workFlowParam.getHWREGRTESTVERIFY().getLinkId());
			approvalStakeholderVerify.setLinkNo(workFlowParam.getHWREGRTESTVERIFY().getLinkNo());
			approvalStakeholderVerify.setTemplateId(workFlowParam.getHWREGRTESTVERIFY().getTemplateId());
			approvalStakeholderVerify.setStdholderStaffId(iSMRValue[0].getStaffId());
			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
			approvalStakeholderVerify.setStdholderStaffNo(staff.getCode());
			approvalStakeholderVerify.setStdholderStaffName(iSMRValue[0].getStaffName());
			approvalStakeholderVerify.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderVerify.setObjType(IObjectType.SOLIDTESTTASK_REGRTEST_HW);
			stStds.add(approvalStakeholderVerify);
			
			IBOAlmStakeholderValue approvalStakeholderProVerify = new BOAlmStakeholderBean();
			approvalStakeholderProVerify.setLinkId(workFlowParam.getHWREGRTESTPROVERIFY().getLinkId());
			approvalStakeholderProVerify.setLinkNo(workFlowParam.getHWREGRTESTPROVERIFY().getLinkNo());
			approvalStakeholderProVerify.setTemplateId(workFlowParam.getHWREGRTESTPROVERIFY().getTemplateId());
			approvalStakeholderProVerify.setStdholderStaffId(iSMRValue[0].getStaffId());
			staff = secframe.getStaffByStaffId(iSMRValue[0].getStaffId());
			approvalStakeholderProVerify.setStdholderStaffNo(staff.getCode());
			approvalStakeholderProVerify.setStdholderStaffName(iSMRValue[0].getStaffName());
			approvalStakeholderProVerify.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			approvalStakeholderProVerify.setObjType(IObjectType.SOLIDTESTTASK_REGRTEST_HW);
			stStds.add(approvalStakeholderProVerify);
		}
		
		//遍历 保存固化任务，保存干系人，启动各固化任务流程
		if(astasks != null && astasks.size()>0)
		{
			IAigaSolidTaskSV iAigaSolidTaskSV = (IAigaSolidTaskSV)ServiceFactory.getService(IAigaSolidTaskSV.class);
			for(IBOAigaSolidTaskValue value : astasks)
			{
				//保存固化任务，保存干系人
				//循环遍历启动固化任务流程
				iAigaSolidTaskSV.startAigaSolidTaskWorkflow(tpValue, value, stStds, orders.get(0));
			}
		}
		
		//生成测试任务相关干系人
		//保存测试任务
		//启动测试任务流程
//		IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
//		if(attasks != null && attasks.size()>0)
//		{
//			for(IBOAigaTestTaskValue value : attasks)
//			{
//				iAigaTestTaskSV.startAigaTestTaskWorkflow(value,tpValue);
//			}
//		}
	}

	@Override
	public void startWorkflow(String templateId, String objId, String objType, String cond)
			throws Exception {
		// TODO Auto-generated method stub
		AlmMatrixClient amc = new AlmMatrixClient();
		if(templateId.equals(ConstDefine.TEMPLATE_ID_TESTPLANWORKFLOW)){//启动测试计划流程
			amc.createWorkflow(ConstDefine.TEMPLATE_NAME_TESTPLANWORKFLOW, "1", objType, objId, ServiceManager.getOpDateTime(), "测试计划流程", cond);
		}
//		else if(templateId.equals(ConstDefine.TEMPLATE_ID_SOLIDTESTTASKWORKFLOW)){//启动固化任务流程
//			amc.createWorkflow(ConstDefine.TEMPLATE_NAME_SOLIDTESTTASKWORKFLOW, "1", objType, objId, ServiceManager.getOpDateTime(), "固化任务流程", cond);	
//		}
	}

	@Override
	public IBOAigaTestPlanValue[] getAigaTestPlan(String conditions, Map params)
			throws Exception {
		// TODO Auto-generated method stub
		return aigaTestPlanDao.getAigaTestPlan(conditions, params);
	}

	@Override
	public IBOAigaTestPlanValue getAigaTestPlanByPlanId(String planId)
			throws Exception {
		// TODO Auto-generated method stub
		return aigaTestPlanDao.getAigaTestPlanByPlanId(planId);
	}

	@Override
	public IBOAigaTestPlanValue saveAigaTestPlan(IBOAigaTestPlanValue value) throws Exception {
		// TODO Auto-generated method stub
		return aigaTestPlanDao.saveAigaTestPlan(value);
	}

	@Override
	public void startTestPlanWorkflow(IBOAigaTestPlanValue value,
			List<IBOAlmStakeholderValue> stds,
			IBOAlmWorkorderValue workorderValue) throws Exception {
		// TODO Auto-generated method stub
		AlmMatrixClient amc = new AlmMatrixClient();
		IAlmStakeholderDao iAlmStakeholderDao = (IAlmStakeholderDao)ServiceFactory.getService(IAlmStakeholderDao.class);
		//保存干系人
		IBOAlmStakeholderValue approvalStakeholderPlan = null;
		IBOAlmStakeholderValue approvalStakeholderVersion = null;
		IAigaPublicSV iAigaPublicSV = (IAigaPublicSV)ServiceFactory.getService(IAigaPublicSV.class);
		WorkFlowParam workFlowParam = WorkFlowParam.getInstance();
		approvalStakeholderPlan = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getPLANRUNNING().getLinkId(),
				workFlowParam.getPLANRUNNING().getLinkNo(), //插入计划执行干系人
				workFlowParam.getPLANRUNNING().getTemplateId(),
				stds.get(0).getStdholderStaffId(), 
				stds.get(0).getStdholderStaffName(),
				IStakeholderType.STDHOLDETYPE_APPROVAL, 
				value.getPlanId(), 
				IObjectType.TESTPLAN);
		
		approvalStakeholderVersion = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getVERSIONREPORTSMT().getLinkId(),
				workFlowParam.getVERSIONREPORTSMT().getLinkNo(), //插入版本报告干系人
				workFlowParam.getVERSIONREPORTSMT().getTemplateId(),
				stds.get(0).getStdholderStaffId(), 
				stds.get(0).getStdholderStaffName(),
				IStakeholderType.STDHOLDETYPE_APPROVAL, 
				value.getPlanId(), 
				IObjectType.TESTPLAN);
		
		stds.add(approvalStakeholderPlan);
		stds.add(approvalStakeholderVersion);
		iAlmStakeholderDao.saveStakeholder(stds, value.getPlanId(), IObjectType.TESTPLAN);
		//创建第一个工单
		amc.createStartSaveOrder(String.valueOf(value.getPlanId()), IObjectType.TESTPLAN, "com.asiainfo.aiga.workflow.testPlanWF",workorderValue.getCond(),workorderValue.getOpinion());
		//启动流程
		amc.createWorkflow("com.asiainfo.aiga.workflow.testPlanWF", "1", IObjectType.TESTPLAN, String.valueOf(value.getPlanId()), ServiceManager.getOpDateTime(), "测试计划流程", workorderValue.getCond());
		value.setStartMark(1);
		IAigaTestPlanSV aigaTestPlanSV = (IAigaTestPlanSV)ServiceFactory.getService(IAigaTestPlanSV.class);
		aigaTestPlanSV.saveAigaTestPlan(value);
	}

	@Override
	public void saveTestPlanFirstOrder(List<IBOAigaTestPlanValue> atps,List<IBOAlmStakeholderValue> stds,
			IBOAlmWorkorderValue workorderValue,List<IBOAigaTestTaskValue> attasks)
			throws Exception {
		// TODO Auto-generated method stub
		//保存测试计划表单信息
		IBOAigaTestPlanValue tpValue = saveAigaTestPlan(atps.get(0));
		//保存测试计划和测试任务关系
		if(attasks != null && attasks.size()>0)
		{
			IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
			for(IBOAigaTestTaskValue value : attasks)
			{
				value.setPlanId(tpValue.getPlanId());
				value.setPlanTag(tpValue.getPlanTag());
				iAigaTestTaskSV.saveAigaTestTask(value);
			}
		}
		//保存创建环节干系人
		IAlmStakeholderDao iAlmStakeholderDao = (IAlmStakeholderDao)ServiceFactory.getService(IAlmStakeholderDao.class);
		iAlmStakeholderDao.saveStakeholder(stds, tpValue.getPlanId(), IObjectType.TESTPLAN);
		//保存第一条工单
		AlmMatrixClient amc = new AlmMatrixClient();
		amc.createStartSaveOrder(String.valueOf(tpValue.getPlanId()), IObjectType.TESTPLAN, "com.asiainfo.aiga.workflow.testPlanWF",workorderValue.getCond(),"");

	}

	@Override
	public void testPlanChange(JSONObject testPlanChange) throws Exception {
		// TODO Auto-generated method stub
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
		Timestamp codeCommitDate = null;
		Timestamp factCompleteTime = null;
		Timestamp reqTime = null;
		long versionContent = 0;
		
		if(testPlanChange != null)//遍历变更信息JSONObject
		{
			String planId = "0";
			if(testPlanChange.has("planId"))
				planId = testPlanChange.getString("planId");
			IBOAigaTestPlanValue iBOAigaTestPlanValue = getAigaTestPlanByPlanId(planId);
			
			if(iBOAigaTestPlanValue != null)
			{
				codeCommitDate = iBOAigaTestPlanValue.getCodeCommitDate();
				factCompleteTime = iBOAigaTestPlanValue.getFactCompleteTime();
				reqTime = iBOAigaTestPlanValue.getReqTime();
				versionContent = iBOAigaTestPlanValue.getVersionContent();
				//将测试计划信息更新
				if(testPlanChange.has("codeCommitDate"))
				{
					if( testPlanChange.getString("codeCommitDate") != null && !testPlanChange.getString("codeCommitDate").equals("null") && !testPlanChange.getString("codeCommitDate").equals(""))
					{
						Date date;
						date = formatter1.parse(testPlanChange.getString("codeCommitDate")); 
						String time = formatter.format(date);
						Timestamp begindate = Timestamp.valueOf(time);
						iBOAigaTestPlanValue.setCodeCommitDate(begindate);
					}
					else {
						iBOAigaTestPlanValue.setCodeCommitDate(null);
					}
				}
				if(testPlanChange.has("factCompleteTime"))
				{
					if( testPlanChange.getString("factCompleteTime") != null && !testPlanChange.getString("factCompleteTime").equals("null") && !testPlanChange.getString("factCompleteTime").equals(""))
					{
						Date date;
						date = formatter1.parse(testPlanChange.getString("factCompleteTime")); 
						String time = formatter.format(date);
						Timestamp begindate = Timestamp.valueOf(time);
						iBOAigaTestPlanValue.setFactCompleteTime(begindate);
					}
					else {
						iBOAigaTestPlanValue.setFactCompleteTime(null);
					}
				}
				if(testPlanChange.has("reqTime"))
				{
					if( testPlanChange.getString("reqTime") != null && !testPlanChange.getString("reqTime").equals("null") && !testPlanChange.getString("reqTime").equals(""))
					{
						Date date;
						date = formatter1.parse(testPlanChange.getString("reqTime")); 
						String time = formatter.format(date);
						Timestamp begindate = Timestamp.valueOf(time);
						iBOAigaTestPlanValue.setReqTime(begindate);
					}
					else {
						iBOAigaTestPlanValue.setReqTime(null);
					}
				}
				if(testPlanChange.has("changeReason"))
				{
					iBOAigaTestPlanValue.setChangeReason(testPlanChange.getString("changeReason"));
				}
				if(testPlanChange.has("versionContent"))
				{
					iBOAigaTestPlanValue.setVersionContent(Long.valueOf(testPlanChange.getString("versionContent")));
				}
				saveAigaTestPlan(iBOAigaTestPlanValue);
				
				//将测试计划下的固化任务信息更新
				IAigaSolidTaskSV iAigaSolidTaskSV = (IAigaSolidTaskSV)ServiceFactory.getService(IAigaSolidTaskSV.class);
				Criteria sqlSolid = new Criteria();
				sqlSolid.addEqual(IBOAigaSolidTaskValue.S_PlanId, planId);
				IBOAigaSolidTaskValue[] aigaSolidTaskValues = iAigaSolidTaskSV.getAigaSolidTasks(sqlSolid.toString(), sqlSolid.getParameters());
				if(aigaSolidTaskValues!=null && aigaSolidTaskValues.length>0)
				{
					for(IBOAigaSolidTaskValue value : aigaSolidTaskValues)
					{
						value.setCodeCommitDate(iBOAigaTestPlanValue.getCodeCommitDate());
						value.setFactCompleteTime(iBOAigaTestPlanValue.getFactCompleteTime());
						value.setReqTime(iBOAigaTestPlanValue.getReqTime());
						value.setChangeReason(iBOAigaTestPlanValue.getChangeReason());
						iAigaSolidTaskSV.saveAigaSolidTask(value);
					}
				}
				//将测试计划下的测试任务信息更新
				IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
				Criteria sqlTask = new Criteria();
				sqlTask.addEqual(IBOAigaTestTaskValue.S_PlanId, planId);
				IBOAigaTestTaskValue[] aigaTestTaskValues = iAigaTestTaskSV.getAigaTestTask(sqlTask.toString(), sqlTask.getParameters());
				if(aigaTestTaskValues!=null && aigaTestTaskValues.length>0)
				{
					for(IBOAigaTestTaskValue value : aigaTestTaskValues)
					{
						value.setFactCompleteTime(iBOAigaTestPlanValue.getFactCompleteTime());
						iAigaTestTaskSV.saveAigaTestTask(value);
						Criteria sqlSubTask = new Criteria();
						sqlSubTask.addEqual(IBOAigaTestSubTaskValue.S_TaskId, value.getTaskId());
						IBOAigaTestSubTaskValue[] subValues =  aigaTestSubTaskDao.getAigaTestSubTasks(sqlSubTask.toString(), sqlSubTask.getParameters());
						for(IBOAigaTestSubTaskValue subValue : subValues){
							subValue.setFactCompleteTime(value.getFactCompleteTime());
							aigaTestSubTaskDao.saveAigaTestSubTask(subValue);
						}
						
					}
				}
				
				//保存测试计划变更记录
				IBOAigaTestPlanChangeValue aigaTestPlanChangeValue = new BOAigaTestPlanChangeBean();
				aigaTestPlanChangeValue.setCreateTime(ServiceManager.getOpDateTime());
				aigaTestPlanChangeValue.setChangeStaffId(ServiceManager.getUser().getID());
				aigaTestPlanChangeValue.setChangeStaffName(ServiceManager.getUser().getName());
				aigaTestPlanChangeValue.setChangePlanId(iBOAigaTestPlanValue.getPlanId());
				aigaTestPlanChangeValue.setChangePlanTag(iBOAigaTestPlanValue.getPlanTag());
				aigaTestPlanChangeValue.setChangeReason(iBOAigaTestPlanValue.getChangeReason());
				aigaTestPlanChangeValue.setCodecommitdateN(iBOAigaTestPlanValue.getCodeCommitDate());
				aigaTestPlanChangeValue.setFactcompletetimeN(iBOAigaTestPlanValue.getFactCompleteTime());
				aigaTestPlanChangeValue.setReqtimeN(iBOAigaTestPlanValue.getReqTime());
				aigaTestPlanChangeValue.setVersionContentN(iBOAigaTestPlanValue.getVersionContent());
				
				aigaTestPlanChangeValue.setVersionContentO(versionContent);
				aigaTestPlanChangeValue.setCodecommitdateO(codeCommitDate);
				aigaTestPlanChangeValue.setFactcompletetimeO(factCompleteTime);
				aigaTestPlanChangeValue.setReqtimeO(reqTime);
				saveAigaTestPlanChange(aigaTestPlanChangeValue);
			}
		
		}
	}

	@Override
	public void saveAigaTestPlanChange(IBOAigaTestPlanChangeValue value)
			throws Exception {
		// TODO Auto-generated method stub
		aigaTestPlanDao.saveAigaTestPlanChange(value); 
	}

	
}
