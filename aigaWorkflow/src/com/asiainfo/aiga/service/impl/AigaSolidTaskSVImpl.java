package com.asiainfo.aiga.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.service.ServiceFactory;
import com.asiainfo.aiga.dao.interfaces.IAigaSolidTaskDao;
import com.asiainfo.aiga.ivalues.IBOAigaSolidTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestPlanValue;
import com.asiainfo.aiga.service.interfaces.IAigaSolidTaskSV;
import com.asiainfo.csc.common.common.ConstDefine;
import com.asiainfo.csc.common.define.IObjectType;
import com.asiainfo.csc.common.define.WorkFlowParam;
import com.asiainfo.csc.matrix.common.AlmMatrixClient;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmStakeholderDao;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public class AigaSolidTaskSVImpl implements IAigaSolidTaskSV{
	
	IAigaSolidTaskDao iAigaSolidTaskDao = (IAigaSolidTaskDao)ServiceFactory.getService(IAigaSolidTaskDao.class);
	@Override
	public IBOAigaSolidTaskValue getAigaSolidTaskByTaskId(String taskId)
			throws Exception {
		// TODO Auto-generated method stub
		return iAigaSolidTaskDao.getAigaSolidTaskByTaskId(taskId);
	}

	@Override
	public IBOAigaSolidTaskValue[] getAigaSolidTasks(String conditions,
			Map params) throws Exception {
		// TODO Auto-generated method stub
		return iAigaSolidTaskDao.getAigaSolidTasks(conditions, params);
	}

	@Override
	public IBOAigaSolidTaskValue saveAigaSolidTask(IBOAigaSolidTaskValue value)
			throws Exception {
		// TODO Auto-generated method stub
		return iAigaSolidTaskDao.saveAigaSolidTask(value);
	}

	@Override
	public IBOAigaSolidTaskValue saveAigaSolidTaskByTaskPlan(
			IBOAigaSolidTaskValue aigaSolidTaskValue,
			IBOAigaTestPlanValue aigaTestPlanValue) throws Exception {
		// TODO Auto-generated method stub
		WorkFlowParam workFlowParam = WorkFlowParam.getInstance();
		
		aigaSolidTaskValue.setPlanDscr(aigaTestPlanValue.getPlanDscr());
		aigaSolidTaskValue.setFactCompleteTime(aigaTestPlanValue.getFactCompleteTime());
		aigaSolidTaskValue.setPlanId(aigaTestPlanValue.getPlanId());
		aigaSolidTaskValue.setVersionContent(aigaTestPlanValue.getVersionContent());
		aigaSolidTaskValue.setPlCompleteTime(aigaTestPlanValue.getPlCompleteTime());
		aigaSolidTaskValue.setOnLineType(aigaTestPlanValue.getOnLineType());
		aigaSolidTaskValue.setChangeReason(aigaTestPlanValue.getChangeReason());
		aigaSolidTaskValue.setReqTime(aigaTestPlanValue.getReqTime());
		aigaSolidTaskValue.setIsSecurityTest(aigaTestPlanValue.getIsSecurityTest());
		aigaSolidTaskValue.setIsCodeScan(aigaTestPlanValue.getIsCodeScan());
		aigaSolidTaskValue.setSubmitStaffId(aigaTestPlanValue.getSubmitStaffId());
		aigaSolidTaskValue.setSubmitStaffName(aigaTestPlanValue.getSubmitStaffName());
		aigaSolidTaskValue.setBeginTime(aigaTestPlanValue.getBeginTime());
		aigaSolidTaskValue.setPlanTag(aigaTestPlanValue.getPlanTag());
		aigaSolidTaskValue.setIsRegressionTest(aigaTestPlanValue.getIsRegressionTest());
		aigaSolidTaskValue.setIsPerformanceTest(aigaTestPlanValue.getIsPerformanceTest());
		aigaSolidTaskValue.setBigType(aigaTestPlanValue.getBigType());
		aigaSolidTaskValue.setCodeCommitDate(aigaTestPlanValue.getCodeCommitDate());
		
		aigaSolidTaskValue.setCreateTime(ServiceManager.getOpDateTime());
		if(aigaSolidTaskValue.getTaskType() == Long.valueOf(IObjectType.SOLIDTESTTASK_SECUTEST))
		{
			aigaSolidTaskValue.setTaskStatus(workFlowParam.getCREATESECUTEST().getLinkId());
			aigaSolidTaskValue.setTaskPhase(Long.valueOf(workFlowParam.getCREATESECUTEST().getPhaseId()));
			aigaSolidTaskValue.setPlanName(aigaTestPlanValue.getPlanName()+"_安全测试");
		}
		if(aigaSolidTaskValue.getTaskType() == Long.valueOf(IObjectType.SOLIDTESTTASK_PERFTEST))
		{
			aigaSolidTaskValue.setTaskStatus(workFlowParam.getCREATEPERFTEST().getLinkId());
			aigaSolidTaskValue.setTaskPhase(Long.valueOf(workFlowParam.getCREATEPERFTEST().getPhaseId()));
			aigaSolidTaskValue.setPlanName(aigaTestPlanValue.getPlanName()+"_性能测试");
		}
		if(aigaSolidTaskValue.getTaskType() == Long.valueOf(IObjectType.SOLIDTESTTASK_CODESCAN))
		{
			aigaSolidTaskValue.setTaskStatus(workFlowParam.getCREATECODESCAN().getLinkId());
			aigaSolidTaskValue.setTaskPhase(Long.valueOf(workFlowParam.getCREATECODESCAN().getPhaseId()));
			aigaSolidTaskValue.setPlanName(aigaTestPlanValue.getPlanName()+"_代码扫描");
		}
		if(aigaSolidTaskValue.getTaskType() == Long.valueOf(IObjectType.SOLIDTESTTASK_REGRTEST))
		{
			aigaSolidTaskValue.setTaskStatus(workFlowParam.getCREATEREGRTEST().getLinkId());
			aigaSolidTaskValue.setTaskPhase(Long.valueOf(workFlowParam.getCREATEREGRTEST().getPhaseId()));
			aigaSolidTaskValue.setPlanName(aigaTestPlanValue.getPlanName()+"_自动回归测试");
		}
		if(aigaSolidTaskValue.getTaskType() == Long.valueOf(IObjectType.SOLIDTESTTASK_REGRTEST_HW))
		{
			aigaSolidTaskValue.setTaskStatus(workFlowParam.getCREATEHWREGRTEST().getLinkId());
			aigaSolidTaskValue.setTaskPhase(Long.valueOf(workFlowParam.getCREATEHWREGRTEST().getPhaseId()));
			aigaSolidTaskValue.setPlanName(aigaTestPlanValue.getPlanName()+"_手工回归测试");
		}
		return iAigaSolidTaskDao.saveAigaSolidTask(aigaSolidTaskValue);
	}

	@Override
	public void startAigaSolidTaskWorkflow(//一次启动一个固化任务流程
			IBOAigaTestPlanValue aigaTestPlanValue,
			IBOAigaSolidTaskValue aigaSolidTaskValue,
			List<IBOAlmStakeholderValue> stds,
			IBOAlmWorkorderValue workorderValue) throws Exception {
		// TODO Auto-generated method stub
		IAlmStakeholderDao iAlmStakeholderDao = (IAlmStakeholderDao)ServiceFactory.getService(IAlmStakeholderDao.class);
		IBOAigaSolidTaskValue iAigaSolidTaskValue = saveAigaSolidTaskByTaskPlan(aigaSolidTaskValue,aigaTestPlanValue);
		
		//1.识别固化任务干系人
		List<IBOAlmStakeholderValue> stStds = new ArrayList<IBOAlmStakeholderValue>();//安全测试干系人
		for(IBOAlmStakeholderValue value : stds)
		{
			if(Long.valueOf(value.getObjType()) == iAigaSolidTaskValue.getTaskType())
			{
				stStds.add(value);
//				iAlmStakeholderDao.saveStakeholder(stds, iAigaSolidTaskValue.getTaskId(), String.valueOf(iAigaSolidTaskValue.getTaskType()));
			}
//			else if(String.valueOf(value.getObjType()) == IObjectType.SOLIDTESTTASK_PERFTEST)
//			{
//				stStds.add(value);
////				iAlmStakeholderDao.saveStakeholder(stds, iAigaSolidTaskValue.getTaskId(), String.valueOf(iAigaSolidTaskValue.getTaskType()));
//			}else if(String.valueOf(value.getObjType()) == IObjectType.SOLIDTESTTASK_REGRTEST)
//			{
//				stStds.add(value);
////				iAlmStakeholderDao.saveStakeholder(stds, iAigaSolidTaskValue.getTaskId(), String.valueOf(iAigaSolidTaskValue.getTaskType()));
//			}else if(String.valueOf(value.getObjType()) == IObjectType.SOLIDTESTTASK_CODESCAN)
//			{
//				stStds.add(value);
////				iAlmStakeholderDao.saveStakeholder(stds, iAigaSolidTaskValue.getTaskId(), String.valueOf(iAigaSolidTaskValue.getTaskType()));
//			}
		}
		iAlmStakeholderDao.saveStakeholder(stStds, iAigaSolidTaskValue.getTaskId(), String.valueOf(iAigaSolidTaskValue.getTaskType()));

		
		//保存干系人
		//根据固化任务类型启动相关固化任务
		String wfTemplateString = "";
		String wfName = "";
		String condString = "";
		if(aigaSolidTaskValue.getTaskType() == Long.valueOf(IObjectType.SOLIDTESTTASK_SECUTEST))
		{
			wfTemplateString = ConstDefine.TEMPLATE_NAME_SOLIDTESTTASKSECUTESTWORKFLOW;
			wfName = "启动安全测试";
			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
		}else if(aigaSolidTaskValue.getTaskType() == Long.valueOf(IObjectType.SOLIDTESTTASK_PERFTEST))
		{
			wfTemplateString = ConstDefine.TEMPLATE_NAME_SOLIDTESTTASKPERFTESTWORKFLOW;
			wfName = "启动性能测试";
			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
		}else if(aigaSolidTaskValue.getTaskType() == Long.valueOf(IObjectType.SOLIDTESTTASK_CODESCAN))
		{
			wfTemplateString = ConstDefine.TEMPLATE_NAME_SOLIDTESTTASKCODESCANWORKFLOW;
			wfName = "启动代码扫描";
			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
		}else if(aigaSolidTaskValue.getTaskType() == Long.valueOf(IObjectType.SOLIDTESTTASK_REGRTEST))
		{
			wfTemplateString = ConstDefine.TEMPLATE_NAME_SOLIDTESTTASKREGRTESTWORKFLOW;
			wfName = "启动自动回归测试";
			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
		}else if(aigaSolidTaskValue.getTaskType() == Long.valueOf(IObjectType.SOLIDTESTTASK_REGRTEST_HW))
		{
			wfTemplateString = ConstDefine.TEMPLATE_NAME_SOLIDTESTTASKHWREGRTESTWORKFLOW;
			wfName = "启动手动回归测试";
			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
		}
		AlmMatrixClient amc = new AlmMatrixClient();
		//创建第一个工单
		amc.createStartSaveOrder(String.valueOf(iAigaSolidTaskValue.getTaskId()), String.valueOf(iAigaSolidTaskValue.getTaskType()), wfTemplateString,condString,wfName);
		//启动流程
		amc.createWorkflow(wfTemplateString, "1", String.valueOf(iAigaSolidTaskValue.getTaskType()), String.valueOf(iAigaSolidTaskValue.getTaskId()), ServiceManager.getOpDateTime(), wfName, condString);
	}
}
