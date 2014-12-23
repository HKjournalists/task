package com.asiainfo.aiga.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.ai.secframe.common.Constants;
import com.ai.secframe.ivalues.orgmodel.IStaffValue;
import com.ai.secframe.ivalues.orgmodel.ISysEmployeeValue;
import com.ai.secframe.ivalues.orgmodel.ISysStaffValue;
import com.ai.secframe.service.pubapi.interfaces.ISecframe;
import com.asiainfo.aiga.bo.BOAigaTestSubTaskBean;
import com.asiainfo.aiga.bo.BOAigaTestTaskBean;
import com.asiainfo.aiga.bo.BOAigaTestTaskChangeBean;
import com.asiainfo.aiga.dao.interfaces.IAigaTestTaskDao;
import com.asiainfo.aiga.ivalues.IBOAigaSolidTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaSubTaskProblemValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestPlanValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestSubTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestTaskChangeValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestTaskValue;
import com.asiainfo.aiga.service.interfaces.IAigaPublicSV;
import com.asiainfo.aiga.service.interfaces.IAigaTestSubTaskSV;
import com.asiainfo.aiga.service.interfaces.IAigaTestTaskSV;
import com.asiainfo.csc.common.common.ConstDefine;
import com.asiainfo.csc.common.define.IObjectType;
import com.asiainfo.csc.common.define.IStakeholderType;
import com.asiainfo.csc.common.define.WorkFlowParam;
import com.asiainfo.csc.matrix.bo.BOAlmStakeholderBean;
import com.asiainfo.csc.matrix.common.AlmMatrixClient;
import com.asiainfo.csc.matrix.common.impl.AlmVmTaskImpl;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmStakeholderDao;
import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmStakeholderSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkorderSV;
import com.sun.corba.se.impl.activation.ServerMain;


public class AigaTestTaskSVImpl extends AlmVmTaskImpl implements IAigaTestTaskSV{

	private IAigaTestTaskDao aigaTestTaskDao = (IAigaTestTaskDao)ServiceFactory.getService(IAigaTestTaskDao.class);
	@Override
	public void updateObjCurPhaseAndCurStatus(String objId, String objType,
			String linkId) throws Exception {
		// TODO Auto-generated method stub
		IBOAlmWorkflowValue iWorkflowValue = WorkFlowParam.getInstance().getWorkflowByLinkId(Long.valueOf(linkId));
		if(iWorkflowValue==null)
			throw new Exception("未查找到环节,函数updateObjCurPhaseAndCurStatus");
		
		Criteria sql = new Criteria();
		if(objType.equals( IObjectType.TESTTASK)){
			sql.addEqual(BOAigaTestTaskBean.S_TaskId, objId);
			IBOAigaTestTaskValue[] testTaskValues = aigaTestTaskDao.getAigaTestTask(sql.toString(), sql.getParameters());
			if(testTaskValues.length==1){
				aigaTestTaskDao.saveAigaTestTask(testTaskValues[0]);
			}
		}
	}

	@Override
	public void extraMethod(long orderId, String objId, String objType,
			String methodType) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void startWorkflow(IBOAigaTestTaskValue aValue, String cond,
			String option) throws Exception {
		// TODO Auto-generated method stub
		new AlmMatrixClient().createWorkflow("com.asiainfo.aiga.workflow.testTaskWF", String.valueOf(1),  IObjectType.TESTTASK, String.valueOf(aValue.getPlanId()), ServiceManager.getOpDateTime(), "测试计划流程创建", cond);
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
	public void saveTestTaskAndFirstWorkorder(IBOAigaTestTaskValue value,
			String cond, String option) throws Exception {
		// TODO Auto-generated method stub
		new AlmMatrixClient().createStartSaveOrder(String.valueOf(value.getTaskId()),  IObjectType.TESTTASK, "com.asiainfo.aiga.workflow.testTaskWF", cond, option);
	}

	@Override
	public IBOAigaTestTaskValue[] getAigaTestTask(String conditions, Map params)
			throws Exception {
		// TODO Auto-generated method stub
		return aigaTestTaskDao.getAigaTestTask(conditions, params);
	}

	@Override
	public IBOAigaTestTaskValue getAigaTestTaskByTaskId(String taskId)
			throws Exception {
		// TODO Auto-generated method stub
		return aigaTestTaskDao.getgetAigaTestTaskByTaskId(taskId);
	}

	@Override
	public IBOAigaTestTaskValue saveAigaTestTask(IBOAigaTestTaskValue value)
			throws Exception {
		// TODO Auto-generated method stub
		return aigaTestTaskDao.saveAigaTestTask(value);
	}

	@Override
	public void startAigaTestTaskWorkflow(IBOAigaTestTaskValue aigaTestTaskValue, 
			IBOAigaTestPlanValue iAigaTestPlanValue)
			throws Exception {
		// TODO Auto-generated method stub
		WorkFlowParam workFlowParam = WorkFlowParam.getInstance();
		IAlmStakeholderDao iAlmStakeholderDao = (IAlmStakeholderDao)ServiceFactory.getService(IAlmStakeholderDao.class);

		//保存测试任务，建立测试任务和测试计划关系
		aigaTestTaskValue.setPlanId(iAigaTestPlanValue.getPlanId());
		aigaTestTaskValue.setPlanTag(iAigaTestPlanValue.getPlanTag());
		aigaTestTaskValue.setFactCompleteTime(iAigaTestPlanValue.getFactCompleteTime());
		aigaTestTaskValue = saveAigaTestTask(aigaTestTaskValue);
		
		String condString = "";
		String wfName = "";
		String wfTemplateString = "";
		String objTypeString = "";
		
		if(aigaTestTaskValue.getTestType() == 0)//普通任务发起
		{
			//生成此测试任务干系人
			ISecframe secframe = (ISecframe) ServiceFactory.getService(Constants.SERVICE_SECFRAME);
			List<IBOAlmStakeholderValue> sttStds = new ArrayList<IBOAlmStakeholderValue>();//测试任务干系人包括创建干系人和任务拆分干系人
			IStaffValue staff = secframe.getStaffByStaffId(Long.valueOf(aigaTestTaskValue.getDistributeStaffid()));
			ISysStaffValue sys_staff = secframe.getSysStaffByCode(staff.getCode());
			ISysEmployeeValue employee = secframe.getSysEmployeeById(sys_staff.getEmployeeId());
			//创建任务干系人
			IBOAlmStakeholderValue approvalStakeholderCreate = new BOAlmStakeholderBean();
			approvalStakeholderCreate.setLinkId(Long.valueOf(workFlowParam.getCREATETESTTASK().getLinkId()));
			approvalStakeholderCreate.setLinkNo(workFlowParam.getCREATETESTTASK().getLinkNo());
			approvalStakeholderCreate.setTemplateId(Long.valueOf(workFlowParam.getCREATETESTTASK().getTemplateId()));
			approvalStakeholderCreate.setStdholderStaffId(Long.valueOf(sys_staff.getStaffId()));
			approvalStakeholderCreate.setStdholderStaffNo(sys_staff.getCode());
			approvalStakeholderCreate.setStdholderStaffName(employee.getEmployeeName());
			approvalStakeholderCreate.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			sttStds.add(approvalStakeholderCreate);
			//拆分环节干系人
			IBOAlmStakeholderValue approvalStakeholderSplit = new BOAlmStakeholderBean();
			approvalStakeholderSplit.setLinkId(Long.valueOf(workFlowParam.getTESTTASKSPLIT().getLinkId()));
			approvalStakeholderSplit.setLinkNo(workFlowParam.getTESTTASKSPLIT().getLinkNo());
			approvalStakeholderSplit.setTemplateId(Long.valueOf(workFlowParam.getTESTTASKSPLIT().getTemplateId()));
			approvalStakeholderSplit.setStdholderStaffId(Long.valueOf(sys_staff.getStaffId()));
			approvalStakeholderSplit.setStdholderStaffNo(sys_staff.getCode());
			approvalStakeholderSplit.setStdholderStaffName(employee.getEmployeeName());
			approvalStakeholderSplit.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			sttStds.add(approvalStakeholderSplit);
			//执行环节干系人
			IBOAlmStakeholderValue approvalStakeholderRunning = new BOAlmStakeholderBean();
			approvalStakeholderRunning.setLinkId(Long.valueOf(workFlowParam.getTESTTASKRUNNING().getLinkId()));
			approvalStakeholderRunning.setLinkNo(workFlowParam.getTESTTASKRUNNING().getLinkNo());
			approvalStakeholderRunning.setTemplateId(Long.valueOf(workFlowParam.getTESTTASKRUNNING().getTemplateId()));
			approvalStakeholderRunning.setStdholderStaffId(Long.valueOf(sys_staff.getStaffId()));
			approvalStakeholderRunning.setStdholderStaffNo(sys_staff.getCode());
			approvalStakeholderRunning.setStdholderStaffName(employee.getEmployeeName());
			approvalStakeholderRunning.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			sttStds.add(approvalStakeholderRunning);
			
			iAlmStakeholderDao.saveStakeholder(sttStds, aigaTestTaskValue.getTaskId(), IObjectType.TESTTASK);
			
			//启动此测试任务流程
			AlmMatrixClient amc = new AlmMatrixClient();
			//创建第一个工单
			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
			wfName = "启动测试任务流程";
			wfTemplateString = ConstDefine.TEMPLATE_NAME_TESTTASKWORKFLOW;
			objTypeString = IObjectType.TESTTASK;
			
		}else if(aigaTestTaskValue.getTestType() == 5)//UET任务发起
		{
			//生成此测试任务干系人
			ISecframe secframe = (ISecframe) ServiceFactory.getService(Constants.SERVICE_SECFRAME);
			List<IBOAlmStakeholderValue> sttStds = new ArrayList<IBOAlmStakeholderValue>();//测试任务干系人包括创建干系人和任务拆分干系人
			IStaffValue staff = secframe.getStaffByStaffId(Long.valueOf(aigaTestTaskValue.getDistributeStaffid()));
			ISysStaffValue sys_staff = secframe.getSysStaffByCode(staff.getCode());
			ISysEmployeeValue employee = secframe.getSysEmployeeById(sys_staff.getEmployeeId());
			//创建任务干系人
			IBOAlmStakeholderValue approvalStakeholderCreate = new BOAlmStakeholderBean();
			approvalStakeholderCreate.setLinkId(Long.valueOf(workFlowParam.getCREATEUETTASK().getLinkId()));
			approvalStakeholderCreate.setLinkNo(workFlowParam.getCREATEUETTASK().getLinkNo());
			approvalStakeholderCreate.setTemplateId(Long.valueOf(workFlowParam.getCREATEUETTASK().getTemplateId()));
			approvalStakeholderCreate.setStdholderStaffId(Long.valueOf(sys_staff.getStaffId()));
			approvalStakeholderCreate.setStdholderStaffNo(sys_staff.getCode());
			approvalStakeholderCreate.setStdholderStaffName(employee.getEmployeeName());
			approvalStakeholderCreate.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			sttStds.add(approvalStakeholderCreate);
			//拆分环节干系人
			IBOAlmStakeholderValue approvalStakeholderSplit = new BOAlmStakeholderBean();
			approvalStakeholderSplit.setLinkId(Long.valueOf(workFlowParam.getUETTASKSPLIT().getLinkId()));
			approvalStakeholderSplit.setLinkNo(workFlowParam.getUETTASKSPLIT().getLinkNo());
			approvalStakeholderSplit.setTemplateId(Long.valueOf(workFlowParam.getUETTASKSPLIT().getTemplateId()));
			approvalStakeholderSplit.setStdholderStaffId(Long.valueOf(sys_staff.getStaffId()));
			approvalStakeholderSplit.setStdholderStaffNo(sys_staff.getCode());
			approvalStakeholderSplit.setStdholderStaffName(employee.getEmployeeName());
			approvalStakeholderSplit.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			sttStds.add(approvalStakeholderSplit);
			//执行环节干系人
			IBOAlmStakeholderValue approvalStakeholderRunning = new BOAlmStakeholderBean();
			approvalStakeholderRunning.setLinkId(Long.valueOf(workFlowParam.getUETTASKRUNNING().getLinkId()));
			approvalStakeholderRunning.setLinkNo(workFlowParam.getUETTASKRUNNING().getLinkNo());
			approvalStakeholderRunning.setTemplateId(Long.valueOf(workFlowParam.getUETTASKRUNNING().getTemplateId()));
			approvalStakeholderRunning.setStdholderStaffId(Long.valueOf(sys_staff.getStaffId()));
			approvalStakeholderRunning.setStdholderStaffNo(sys_staff.getCode());
			approvalStakeholderRunning.setStdholderStaffName(employee.getEmployeeName());
			approvalStakeholderRunning.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			sttStds.add(approvalStakeholderRunning);
			
			iAlmStakeholderDao.saveStakeholder(sttStds, aigaTestTaskValue.getTaskId(), IObjectType.UETTASKT);
			
			//启动此测试任务流程
			AlmMatrixClient amc = new AlmMatrixClient();
			//创建第一个工单
			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
			wfName = "启动UET任务流程";
			wfTemplateString = ConstDefine.TEMPLATE_NAME_UETTASKWF;
			objTypeString = IObjectType.UETTASKT;
			
		}
		
		//启动此测试任务流程
		AlmMatrixClient amc = new AlmMatrixClient();
		//创建第一个工单
		amc.createStartSaveOrder(String.valueOf(aigaTestTaskValue.getTaskId()), objTypeString, wfTemplateString, condString, wfName);
		//启动流程
		amc.createWorkflow(wfTemplateString, "1", objTypeString, String.valueOf(aigaTestTaskValue.getTaskId()), ServiceManager.getOpDateTime(), wfName, condString);
	
	}

	@Override
	public void splitAigaTestTask(
			List<IBOAlmStakeholderValue> almStakeholderList,
			List<IBOAlmWorkorderValue> almWorkorderList,
			List<IBOAigaTestTaskValue> aigaTestTaskList,JSONArray subTaskStaffs)
			throws Exception {
		// TODO Auto-generated method stub
		WorkFlowParam workFlowParam = WorkFlowParam.getInstance();
		String objTypeString = "";
		String subObjTypeString = "";
		String subNameString = "";
		String curPhaseString = "";
		long curStatuString = 0;
		if(aigaTestTaskList.get(0).getTestType()==0)
		{
			objTypeString = IObjectType.TESTTASK;
			subObjTypeString = IObjectType.SUBTESTTASK;
			subNameString = "功能测试子任务";
			curPhaseString = workFlowParam.getCREATESUBTESTTASK().getPhaseId();
			curStatuString = workFlowParam.getCREATESUBTESTTASK().getLinkId();
		}else if(aigaTestTaskList.get(0).getTestType()== 5)
		{
			objTypeString = IObjectType.UETTASKT;
			subObjTypeString = IObjectType.EAESUBTEST;
			subNameString = "UET子任务";
			curPhaseString = workFlowParam.getCREATEEAESUBTASKTEST().getPhaseId();
			curStatuString = workFlowParam.getCREATEEAESUBTASKTEST().getLinkId();
		}else if(aigaTestTaskList.get(0).getTestType()== 9)
		{
			objTypeString = IObjectType.PERFTASK_FOLLOW;
			subObjTypeString = IObjectType.PERFSUBTEST;
			subNameString = "性能测试子任务";
			curPhaseString = workFlowParam.getCREATEPERFSUBTEST().getPhaseId();
			curStatuString = workFlowParam.getCREATEPERFSUBTEST().getLinkId();
		}
		
		//保存测试任务干系人
		IAlmStakeholderDao iAlmStakeholderDao = (IAlmStakeholderDao)ServiceFactory.getService(IAlmStakeholderDao.class);
		iAlmStakeholderDao.saveStakeholder(almStakeholderList, aigaTestTaskList.get(0).getTaskId(), objTypeString);
		//回单测试任务
		AlmMatrixClient amc = new AlmMatrixClient();
		IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
		amc.finishUserTask(almWorkorderList.get(0).getOrderId(), almWorkorderList.get(0).getResult(), 
				almWorkorderList.get(0).getOpinion(), almWorkorderList.get(0).getCond());
		
		//启动测试子任务流程
		
		if(subTaskStaffs != null && subTaskStaffs.length()>0)//遍历干系人JSONArray
		{
			int length = subTaskStaffs.length();
			for(int i = 0; i < length; i++)
			{
				JSONObject staffs = subTaskStaffs.getJSONObject(i);  
				String[] staffIdsrray = null;
				String[] staffNosrray = null;
				String[] staffNamesrray = null;
				if(staffs.has("staffIds"))
				{
					staffIdsrray = staffs.getString("staffIds").split(";"); 
					if(staffs.has("staffNos"))
						staffNosrray = staffs.getString("staffNos").split(";"); 
					if(staffs.has("staffNames"))
						staffNamesrray = staffs.getString("staffNames").split(";");
					
				    for (int j = 0; j < staffIdsrray.length; j++) 
				    {
				    	if(staffIdsrray[j]!=null && !staffIdsrray[j].equals(""))
				    	{
				    		//
				    		IBOAigaTestSubTaskValue iBOAigaTestSubTaskValue = new BOAigaTestSubTaskBean();
				    		iBOAigaTestSubTaskValue.setSubTaskPriority(aigaTestTaskList.get(0).getPriority());
				    		iBOAigaTestSubTaskValue.setFactCompleteTime(aigaTestTaskList.get(0).getFactCompleteTime());
				    		iBOAigaTestSubTaskValue.setSubTaskTag(generateSubTaskTag());
				    		iBOAigaTestSubTaskValue.setFactCompleteTime(aigaTestTaskList.get(0).getFactCompleteTime());
				    		iBOAigaTestSubTaskValue.setSubTaskName(aigaTestTaskList.get(0).getTaskName() + subNameString);
				    		iBOAigaTestSubTaskValue.setSubTaskStatus((int)curStatuString);
				    		iBOAigaTestSubTaskValue.setCurPhase(Integer.valueOf(curPhaseString));
				    		iBOAigaTestSubTaskValue.setSubTaskType(Integer.valueOf(subObjTypeString));

				    		iBOAigaTestSubTaskValue.setCreator(aigaTestTaskList.get(0).getDistributeStaffid());
				    		iBOAigaTestSubTaskValue.setCreatorStaff(aigaTestTaskList.get(0).getDistributeStaffname());
				    		
				    		iBOAigaTestSubTaskValue.setTestorId(Long.valueOf(staffIdsrray[j]));
				    		iBOAigaTestSubTaskValue.setTestorName(staffNamesrray[j]);
				    		iBOAigaTestSubTaskValue.setCreateTime(ServiceManager.getOpDateTime());
				    		iBOAigaTestSubTaskValue.setTaskId(aigaTestTaskList.get(0).getTaskId());
				    		iBOAigaTestSubTaskValue.setTaskTag(aigaTestTaskList.get(0).getTaskTag());
				    		iBOAigaTestSubTaskValue.setReqTag(aigaTestTaskList.get(0).getReqTag());
				    		iBOAigaTestSubTaskValue.setDevWorkDay(aigaTestTaskList.get(0).getDevWorkDay());
				    		iBOAigaTestSubTaskValue.setTestWorkDay(aigaTestTaskList.get(0).getTestWorkDay());
				    		iBOAigaTestSubTaskValue.setSubmitStaffId(Long.valueOf(aigaTestTaskList.get(0).getDistributeStaffid()));
				    		iBOAigaTestSubTaskValue.setSubmitStaffName(aigaTestTaskList.get(0).getDistributeStaffname());
				    		//由于null异常，所以暂时设置为1 by wenghy 2014-9-29
				    		Integer subType = 0;
				    		Integer bigType = 0;
				    		if(aigaTestTaskList.get(0).getSubType() != 0) {
				    			subType = (int)aigaTestTaskList.get(0).getSubType();
				    			iBOAigaTestSubTaskValue.setSubType(subType);
				    		}
				    		if(aigaTestTaskList.get(0).getBigType() != 0) {
				    			bigType = (int)aigaTestTaskList.get(0).getBigType();
				    		}
				    		iBOAigaTestSubTaskValue.setBigType(bigType);
				    		iAigaTestSubTaskSV.startAigaTestSubTaskWorkflow(aigaTestTaskList.get(0), iBOAigaTestSubTaskValue);
				    	}
				    }

				}
			}  
		}
	}
	
	public String generateSubTaskTag()
	{
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String reqTag = simpleDateFormat.format(new Date());
		reqTag = "ST"+reqTag + (int)Math.ceil(Math.random()*100);
		return reqTag;
	}

	@Override
	public void batchAllotTestTaskToSubTask(JSONArray subTaskStaffs)
			throws Exception {
		// TODO Auto-generated method stub
		
		
		//遍历批量子任务
		IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
		IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
		IAlmStakeholderSV iAlmStakeholderSV = BusiFactory.getAlmStakeholderSV();

		WorkFlowParam workFlowParam = WorkFlowParam.getInstance();
		if(subTaskStaffs != null && subTaskStaffs.length()>0)//遍历干系人JSONArray
		{
			int length = subTaskStaffs.length();
			for(int i = 0; i < length; i++)
			{
				JSONObject staffs = subTaskStaffs.getJSONObject(i);  
				String[] staffIdsrray = null;
				String[] staffNamesrray = null;
				String taskId = "0";
				
				if(staffs.has("taskId"))
				{
					Criteria sql = new Criteria();
					taskId = staffs.getString("taskId");//获取测试任务id序列信息 
					
					//生成测试任务下一环节，测试执行中的干系人
					sql = new Criteria();
					sql.addEqual(IBOAlmStakeholderValue.S_TemplateId, workFlowParam.getTESTTASKSPLIT().getTemplateId());
					sql.addEqual(IBOAlmStakeholderValue.S_LinkId, workFlowParam.getTESTTASKSPLIT().getLinkId());
					sql.addEqual(IBOAlmStakeholderValue.S_LinkNo, workFlowParam.getTESTTASKSPLIT().getLinkNo());
					sql.addEqual(IBOAlmStakeholderValue.S_ObjId, taskId);
					sql.addEqual(IBOAlmStakeholderValue.S_ObjType, 3);
					sql.addEqual(IBOAlmStakeholderValue.S_StdholdeType, 2);
					IBOAlmStakeholderValue[] iBOStakeholders = iAlmStakeholderSV.getStakeholderByCondition(sql.toString(), sql.getParameters());
					if(iBOStakeholders.length != 0){
						IBOAlmStakeholderValue iAlmStakeholderValue = new BOAlmStakeholderBean();
						iAlmStakeholderValue.setLinkId(workFlowParam.getTESTTASKRUNNING().getLinkId());
						iAlmStakeholderValue.setLinkNo(workFlowParam.getTESTTASKRUNNING().getLinkNo());
						iAlmStakeholderValue.setTemplateId(workFlowParam.getTESTTASKRUNNING().getTemplateId());
						iAlmStakeholderValue.setStdholderStaffId(iBOStakeholders[0].getStdholderStaffId());
						iAlmStakeholderValue.setStdholderStaffNo(iBOStakeholders[0].getStdholderStaffNo());
						iAlmStakeholderValue.setStdholderStaffName(iBOStakeholders[0].getStdholderStaffName());
						iAlmStakeholderValue.setStdholdeType(iBOStakeholders[0].getStdholdeType());
						IAlmStakeholderDao iAlmStakeholderDao = (IAlmStakeholderDao)ServiceFactory.getService(IAlmStakeholderDao.class);
						iAlmStakeholderDao.saveStakeholder(iAlmStakeholderValue, Long.valueOf(taskId), "3");
					}

					//回单测试任务拆分工单
					sql.clear();
					sql.addEqual(IBOAlmWorkorderValue.S_ObjId, taskId);
					sql.addEqual(IBOAlmWorkorderValue.S_ObjType, 3);
					sql.addEqual(IBOAlmWorkorderValue.S_OrderType, 2);
					sql.addEqual(IBOAlmWorkorderValue.S_Status, 2);
					sql.addEqual(IBOAlmWorkorderValue.S_LinkNo, workFlowParam.getTESTTASKSPLIT().getLinkNo());
					IAlmWorkorderSV iAlmWorkorderSV = (IAlmWorkorderSV)ServiceFactory.getService(IAlmWorkorderSV.class);
					IBOAlmWorkorderValue[] adminWorkorders = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
					if(adminWorkorders.length != 0){
						AlmMatrixClient amc = new AlmMatrixClient();
						amc.finishUserTask(adminWorkorders[0].getOrderId(), "Y", 
								"批量处理", 
								"<conds><cond name=\"staffId\" value=\"1\"></cond><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond></conds>");	
					}
					
					
					//启动子任务流程
					
					IBOAigaTestTaskValue iBOAigaTestTaskValue = iAigaTestTaskSV.getAigaTestTaskByTaskId(taskId);
					if(iBOAigaTestTaskValue!=null)
					{
						if(staffs.has("staffIds"))
						{
							staffIdsrray = staffs.getString("staffIds").split(";"); 
							if(staffs.has("staffNames"))
								staffNamesrray = staffs.getString("staffNames").split(";");
							
						    for (int j = 0; j < staffIdsrray.length; j++) 
						    {
						    	if(staffIdsrray[j]!=null && !staffIdsrray[j].equals(""))
						    	{
						    		//
						    		IBOAigaTestSubTaskValue iBOAigaTestSubTaskValue = new BOAigaTestSubTaskBean();
						    		iBOAigaTestSubTaskValue.setSubTaskPriority(iBOAigaTestTaskValue.getPriority());
						    		iBOAigaTestSubTaskValue.setFactCompleteTime(iBOAigaTestTaskValue.getFactCompleteTime());
						    		iBOAigaTestSubTaskValue.setBigType(iBOAigaTestTaskValue.getBigType());
						    		Integer subType = 0;
						    		if(iBOAigaTestTaskValue.getSubType() != 0) {
						    			subType = (int)iBOAigaTestTaskValue.getSubType();
						    			iBOAigaTestSubTaskValue.setSubType(subType);
						    		}
						    		iBOAigaTestSubTaskValue.setSubTaskTag(generateSubTaskTag());
						    		iBOAigaTestSubTaskValue.setSubTaskName(iBOAigaTestTaskValue.getTaskName()+"功能测试任务");
						    		iBOAigaTestSubTaskValue.setSubTaskStatus((int)workFlowParam.getCREATESUBTESTTASK().getLinkId());
						    		iBOAigaTestSubTaskValue.setCurPhase(Integer.valueOf(workFlowParam.getCREATESUBTESTTASK().getPhaseId()));
						    		iBOAigaTestSubTaskValue.setSubTaskType(4);
//						    		iBOAigaTestSubTaskValue.setCreator(staffIdsrray[j]);
//						    		iBOAigaTestSubTaskValue.setCreatorStaff(staffNamesrray[j]);
						    		iBOAigaTestSubTaskValue.setCreator(iBOAigaTestTaskValue.getDistributeStaffid());
						    		iBOAigaTestSubTaskValue.setCreatorStaff(iBOAigaTestTaskValue.getDistributeStaffname());
						    		iBOAigaTestSubTaskValue.setTestorId(Long.valueOf(staffIdsrray[j]));
						    		iBOAigaTestSubTaskValue.setTestorName(staffNamesrray[j]);
						    		iBOAigaTestSubTaskValue.setCreateTime(ServiceManager.getOpDateTime());
						    		iBOAigaTestSubTaskValue.setTaskId(iBOAigaTestTaskValue.getTaskId());
						    		iBOAigaTestSubTaskValue.setTaskTag(iBOAigaTestTaskValue.getTaskTag());
						    		iBOAigaTestSubTaskValue.setReqTag(iBOAigaTestTaskValue.getReqTag());
						    		iBOAigaTestSubTaskValue.setDevWorkDay(iBOAigaTestTaskValue.getDevWorkDay());
						    		iBOAigaTestSubTaskValue.setTestWorkDay(iBOAigaTestTaskValue.getTestWorkDay());
						    		iBOAigaTestSubTaskValue.setSubmitStaffId(Long.valueOf(iBOAigaTestTaskValue.getDistributeStaffid()));
						    		iBOAigaTestSubTaskValue.setSubmitStaffName(iBOAigaTestTaskValue.getDistributeStaffname());
						    		iAigaTestSubTaskSV.startAigaTestSubTaskWorkflow(iBOAigaTestTaskValue, iBOAigaTestSubTaskValue);
						    	}
						    }
		
						}
					}
				}
			}  
		}
	}

	@Override
	public void startAigaTestTaskWorkflowWithoutTestPlan(
			IBOAigaTestTaskValue aigaTestTaskValue) throws Exception {
		// TODO Auto-generated method stub
		WorkFlowParam workFlowParam = WorkFlowParam.getInstance();
		IAlmStakeholderDao iAlmStakeholderDao = (IAlmStakeholderDao)ServiceFactory.getService(IAlmStakeholderDao.class);

//		//保存测试任务，建立测试任务和测试计划关系
//		aigaTestTaskValue.setPlanId(iAigaTestPlanValue.getPlanId());
//		aigaTestTaskValue.setPlanTag(iAigaTestPlanValue.getPlanTag());
//		aigaTestTaskValue.setFactCompleteTime(iAigaTestPlanValue.getFactCompleteTime());
		aigaTestTaskValue.setSubmitStaffId(ServiceManager.getUser().getID());
		aigaTestTaskValue.setSubmitStaffName(ServiceManager.getUser().getName());
		aigaTestTaskValue = saveAigaTestTask(aigaTestTaskValue);
		
		//如果已经排期，则记录到历史表中
		saveTestTaskChange(aigaTestTaskValue);
		
		String condString = "";
		String wfName = "";
		String wfTemplateString = "";
		String objTypeString = "";
		
		if(aigaTestTaskValue.getTestType() == 0)//普通任务发起
		{
			//生成此测试任务干系人
			ISecframe secframe = (ISecframe) ServiceFactory.getService(Constants.SERVICE_SECFRAME);
			List<IBOAlmStakeholderValue> sttStds = new ArrayList<IBOAlmStakeholderValue>();//测试任务干系人包括创建干系人和任务拆分干系人
			IStaffValue staff = secframe.getStaffByStaffId(Long.valueOf(aigaTestTaskValue.getDistributeStaffid()));
			ISysStaffValue sys_staff = secframe.getSysStaffByCode(staff.getCode());
			ISysEmployeeValue employee = secframe.getSysEmployeeById(sys_staff.getEmployeeId());
			//创建任务干系人
			IBOAlmStakeholderValue approvalStakeholderCreate = new BOAlmStakeholderBean();
			approvalStakeholderCreate.setLinkId(Long.valueOf(workFlowParam.getCREATETESTTASK().getLinkId()));
			approvalStakeholderCreate.setLinkNo(workFlowParam.getCREATETESTTASK().getLinkNo());
			approvalStakeholderCreate.setTemplateId(Long.valueOf(workFlowParam.getCREATETESTTASK().getTemplateId()));
			approvalStakeholderCreate.setStdholderStaffId(Long.valueOf(sys_staff.getStaffId()));
			approvalStakeholderCreate.setStdholderStaffNo(sys_staff.getCode());
			approvalStakeholderCreate.setStdholderStaffName(employee.getEmployeeName());
			approvalStakeholderCreate.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			sttStds.add(approvalStakeholderCreate);
			//拆分环节干系人
			IBOAlmStakeholderValue approvalStakeholderSplit = new BOAlmStakeholderBean();
			approvalStakeholderSplit.setLinkId(Long.valueOf(workFlowParam.getTESTTASKSPLIT().getLinkId()));
			approvalStakeholderSplit.setLinkNo(workFlowParam.getTESTTASKSPLIT().getLinkNo());
			approvalStakeholderSplit.setTemplateId(Long.valueOf(workFlowParam.getTESTTASKSPLIT().getTemplateId()));
			approvalStakeholderSplit.setStdholderStaffId(Long.valueOf(sys_staff.getStaffId()));
			approvalStakeholderSplit.setStdholderStaffNo(sys_staff.getCode());
			approvalStakeholderSplit.setStdholderStaffName(employee.getEmployeeName());
			approvalStakeholderSplit.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			sttStds.add(approvalStakeholderSplit);
			//执行环节干系人
			IBOAlmStakeholderValue approvalStakeholderRunning = new BOAlmStakeholderBean();
			approvalStakeholderRunning.setLinkId(Long.valueOf(workFlowParam.getTESTTASKRUNNING().getLinkId()));
			approvalStakeholderRunning.setLinkNo(workFlowParam.getTESTTASKRUNNING().getLinkNo());
			approvalStakeholderRunning.setTemplateId(Long.valueOf(workFlowParam.getTESTTASKRUNNING().getTemplateId()));
			approvalStakeholderRunning.setStdholderStaffId(Long.valueOf(sys_staff.getStaffId()));
			approvalStakeholderRunning.setStdholderStaffNo(sys_staff.getCode());
			approvalStakeholderRunning.setStdholderStaffName(employee.getEmployeeName());
			approvalStakeholderRunning.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			sttStds.add(approvalStakeholderRunning);
			
			iAlmStakeholderDao.saveStakeholder(sttStds, aigaTestTaskValue.getTaskId(), IObjectType.TESTTASK);
			
			//启动此测试任务流程
			AlmMatrixClient amc = new AlmMatrixClient();
			//创建第一个工单
			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
			wfName = "启动测试任务流程";
			wfTemplateString = ConstDefine.TEMPLATE_NAME_TESTTASKWORKFLOW;
			objTypeString = IObjectType.TESTTASK;
			
		}else if(aigaTestTaskValue.getTestType() == 5)//UET任务发起
		{
			//生成此测试任务干系人
			ISecframe secframe = (ISecframe) ServiceFactory.getService(Constants.SERVICE_SECFRAME);
			List<IBOAlmStakeholderValue> sttStds = new ArrayList<IBOAlmStakeholderValue>();//测试任务干系人包括创建干系人和任务拆分干系人
			IStaffValue staff = secframe.getStaffByStaffId(Long.valueOf(aigaTestTaskValue.getDistributeStaffid()));
			ISysStaffValue sys_staff = secframe.getSysStaffByCode(staff.getCode());
			ISysEmployeeValue employee = secframe.getSysEmployeeById(sys_staff.getEmployeeId());
			//创建任务干系人
			IBOAlmStakeholderValue approvalStakeholderCreate = new BOAlmStakeholderBean();
			approvalStakeholderCreate.setLinkId(Long.valueOf(workFlowParam.getCREATEUETTASK().getLinkId()));
			approvalStakeholderCreate.setLinkNo(workFlowParam.getCREATEUETTASK().getLinkNo());
			approvalStakeholderCreate.setTemplateId(Long.valueOf(workFlowParam.getCREATEUETTASK().getTemplateId()));
			approvalStakeholderCreate.setStdholderStaffId(Long.valueOf(sys_staff.getStaffId()));
			approvalStakeholderCreate.setStdholderStaffNo(sys_staff.getCode());
			approvalStakeholderCreate.setStdholderStaffName(employee.getEmployeeName());
			approvalStakeholderCreate.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			sttStds.add(approvalStakeholderCreate);
			//拆分环节干系人
			IBOAlmStakeholderValue approvalStakeholderSplit = new BOAlmStakeholderBean();
			approvalStakeholderSplit.setLinkId(Long.valueOf(workFlowParam.getUETTASKSPLIT().getLinkId()));
			approvalStakeholderSplit.setLinkNo(workFlowParam.getUETTASKSPLIT().getLinkNo());
			approvalStakeholderSplit.setTemplateId(Long.valueOf(workFlowParam.getUETTASKSPLIT().getTemplateId()));
			approvalStakeholderSplit.setStdholderStaffId(Long.valueOf(sys_staff.getStaffId()));
			approvalStakeholderSplit.setStdholderStaffNo(sys_staff.getCode());
			approvalStakeholderSplit.setStdholderStaffName(employee.getEmployeeName());
			approvalStakeholderSplit.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			sttStds.add(approvalStakeholderSplit);
			//执行环节干系人
			IBOAlmStakeholderValue approvalStakeholderRunning = new BOAlmStakeholderBean();
			approvalStakeholderRunning.setLinkId(Long.valueOf(workFlowParam.getUETTASKRUNNING().getLinkId()));
			approvalStakeholderRunning.setLinkNo(workFlowParam.getUETTASKRUNNING().getLinkNo());
			approvalStakeholderRunning.setTemplateId(Long.valueOf(workFlowParam.getUETTASKRUNNING().getTemplateId()));
			approvalStakeholderRunning.setStdholderStaffId(Long.valueOf(sys_staff.getStaffId()));
			approvalStakeholderRunning.setStdholderStaffNo(sys_staff.getCode());
			approvalStakeholderRunning.setStdholderStaffName(employee.getEmployeeName());
			approvalStakeholderRunning.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
			sttStds.add(approvalStakeholderRunning);
			
			iAlmStakeholderDao.saveStakeholder(sttStds, aigaTestTaskValue.getTaskId(), IObjectType.UETTASKT);
			
			//启动此测试任务流程
			AlmMatrixClient amc = new AlmMatrixClient();
			//创建第一个工单
			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
			wfName = "启动UET任务流程";
			wfTemplateString = ConstDefine.TEMPLATE_NAME_UETTASKWF;
			objTypeString = IObjectType.UETTASKT;
			
		}
		
		//启动此测试任务流程
		AlmMatrixClient amc = new AlmMatrixClient();
		//创建第一个工单
		amc.createStartSaveOrder(String.valueOf(aigaTestTaskValue.getTaskId()), objTypeString, wfTemplateString, condString, wfName);
		//启动流程
		amc.createWorkflow(wfTemplateString, "1", objTypeString, String.valueOf(aigaTestTaskValue.getTaskId()), ServiceManager.getOpDateTime(), wfName, condString);
	
		
	}

	@Override
	public void startAigaTestTaskListWorkflowWithoutTestPlan(
			List<IBOAigaTestTaskValue> aigaTestTaskList) throws Exception {
		// TODO Auto-generated method stub
		if(aigaTestTaskList != null && aigaTestTaskList.size()>0)
		{
			for(IBOAigaTestTaskValue value : aigaTestTaskList)
			{
				startAigaTestTaskWorkflowWithoutTestPlan(value);
			}
		}
	}

	@Override
	public void startAigaUETTaskListWorkflow(
			List<IBOAigaTestTaskValue> aigaTestTaskList,
			List<IBOAlmStakeholderValue> almStakeholderList,String taskId) throws Exception {
		// TODO Auto-generated method stub
		String condString = "";
		String wfName = "";
		String wfTemplateString = "";
		String objTypeString = IObjectType.UETTASKT;
		//启动此测试任务流程
		AlmMatrixClient amc = new AlmMatrixClient();
		WorkFlowParam workFlowParam = WorkFlowParam.getInstance();
		IAlmStakeholderDao iAlmStakeholderDao = (IAlmStakeholderDao)ServiceFactory.getService(IAlmStakeholderDao.class);
		IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
		IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);

		if(aigaTestTaskList != null && aigaTestTaskList.size()>0)
		{
			for(IBOAigaTestTaskValue value : aigaTestTaskList)
			{
				saveAigaTestTask(value);
				//保存干系人
				iAlmStakeholderDao.saveStakeholder(almStakeholderList, value.getTaskId(), objTypeString);
				
				//获取创建干系人
				IBOAlmStakeholderValue createAlmStakeholderValue = new BOAlmStakeholderBean();
				for(IBOAlmStakeholderValue stakeholderValue : almStakeholderList){
					if(stakeholderValue.getLinkNo().equals(workFlowParam.getCREATEUETTASK().getLinkNo())){
						createAlmStakeholderValue = stakeholderValue;
						break;
					}
				}
				
				//创建第一个工单
				condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
				wfName = "启动UET任务流程";
				wfTemplateString = ConstDefine.TEMPLATE_NAME_UETTASKWF;

				//创建第一个工单
				amc.createStartSaveOrder(String.valueOf(value.getTaskId()), objTypeString, wfTemplateString, condString, wfName);
				//启动UET流程
				amc.createWorkflow(wfTemplateString, "1", objTypeString, String.valueOf(value.getTaskId()), ServiceManager.getOpDateTime(), wfName, condString);
			
				//启动UET子任务流程
				IBOAigaTestSubTaskValue iBOAigaTestSubTaskValue = new BOAigaTestSubTaskBean();
	    		iBOAigaTestSubTaskValue.setSubTaskTag(generateSubTaskTag());
	    		iBOAigaTestSubTaskValue.setBigType(value.getBigType());
	    		iBOAigaTestSubTaskValue.setPlCompleteTime(value.getPlCompleteTime());
	    		iBOAigaTestSubTaskValue.setFactCompleteTime(value.getFactCompleteTime());
	    		iBOAigaTestSubTaskValue.setSubTaskName("【"+value.getTaskName() + "】端到端子任务");
	    		iBOAigaTestSubTaskValue.setSubTaskStatus((int)workFlowParam.getCREATEEAESUBTASKTEST().getLinkId());
	    		iBOAigaTestSubTaskValue.setCurPhase(Integer.valueOf(workFlowParam.getCREATEEAESUBTASKTEST().getPhaseId()));
	    		iBOAigaTestSubTaskValue.setSubTaskType(Integer.valueOf(IObjectType.EAESUBTEST));
	    		iBOAigaTestSubTaskValue.setCreator(String.valueOf(createAlmStakeholderValue.getStdholderStaffId()));
	    		iBOAigaTestSubTaskValue.setCreatorStaff(createAlmStakeholderValue.getStdholderStaffName());
	    		iBOAigaTestSubTaskValue.setTestorId(Long.valueOf(value.getDistributeStaffid()));
	    		iBOAigaTestSubTaskValue.setTestorName(value.getDistributeStaffname());
	    		iBOAigaTestSubTaskValue.setCreateTime(ServiceManager.getOpDateTime());
	    		iBOAigaTestSubTaskValue.setTaskId(value.getTaskId());
	    		iBOAigaTestSubTaskValue.setTaskTag(value.getTaskTag());
	    		iBOAigaTestSubTaskValue.setReqTag(value.getReqTag());
	    		iBOAigaTestSubTaskValue.setDevWorkDay(value.getDevWorkDay());
	    		iBOAigaTestSubTaskValue.setTestWorkDay(value.getTestWorkDay());
	    		iBOAigaTestSubTaskValue.setSubmitStaffId(createAlmStakeholderValue.getStdholderStaffId());
	    		iBOAigaTestSubTaskValue.setSubmitStaffName(createAlmStakeholderValue.getStdholderStaffName());
	    		//由于null异常，所以暂时设置为1 by wenghy 2014-9-29
	    		Integer subType = 1;
	    		if(value.getSubType() != 0) {
	    			subType = (int)value.getSubType();
	    			iBOAigaTestSubTaskValue.setSubType(subType);
	    		}
	    		
	    		value.setDistributeStaffid(String.valueOf(createAlmStakeholderValue.getStdholderStaffId()));
	    		value.setDistributeStaffname(createAlmStakeholderValue.getStdholderStaffName());
	    		iAigaTestSubTaskSV.startAigaTestSubTaskWorkflow(value, iBOAigaTestSubTaskValue);
	    		
	    		//获取发起的测试任务
	    		IBOAigaTestTaskValue iBOAigaTestTaskValue = new BOAigaTestTaskBean();
	    		iBOAigaTestTaskValue = iAigaTestTaskSV.getAigaTestTaskByTaskId(taskId);
	    		if(iBOAigaTestTaskValue!=null){
	    			iBOAigaTestTaskValue.setUetTaskId(iBOAigaTestSubTaskValue.getTaskId());
	    			iAigaTestTaskSV.saveAigaTestTask(iBOAigaTestTaskValue);
	    		}
			}
		}
	}

	@Override
	public void batchSubTaskTestorChange(JSONArray subTaskChangeStaffs)
			throws Exception {
		// TODO Auto-generated method stub
		//遍历批量子任务
		IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
		IAlmStakeholderSV iAlmStakeholderSV = (IAlmStakeholderSV)ServiceFactory.getService(IAlmStakeholderSV.class);
		IAlmWorkorderSV iAlmWorkorderSV = (IAlmWorkorderSV)ServiceFactory.getService(IAlmWorkorderSV.class);
		ISecframe secframe = (ISecframe) ServiceFactory.getService(Constants.SERVICE_SECFRAME);
		Criteria sql = new Criteria();
		String subTaskId = "0";
		String changeStaffId = "0";
		if(subTaskChangeStaffs != null && subTaskChangeStaffs.length()>0)//遍历干系人JSONArray
		{
			int length = subTaskChangeStaffs.length();
			for(int i = 0; i < length; i++)
			{
				sql.clear();
				JSONObject subTaskStaffinfo = subTaskChangeStaffs.getJSONObject(i);  
				if(subTaskStaffinfo.has("subTaskId"))
				{
					subTaskId = subTaskStaffinfo.getString("subTaskId");//获取测试子任务id序列信息 
					IBOAigaTestSubTaskValue aigaTestSubTaskValue = iAigaTestSubTaskSV.getAigaTestSubTaskBySubTaskId(subTaskId);
					if(aigaTestSubTaskValue!=null)
					{
						if(subTaskStaffinfo.has("changeStaffId"))
						{	
							changeStaffId = subTaskStaffinfo.getString("changeStaffId");//获取修改测试人员Id
							IStaffValue staff = secframe.getStaffByStaffId(Long.valueOf(changeStaffId));
							ISysStaffValue sys_staff = secframe.getSysStaffByCode(staff.getCode());
							ISysEmployeeValue employee = secframe.getSysEmployeeById(sys_staff.getEmployeeId());

							//此对象在原测试人员下的待办工单
							sql.clear();
							sql.addEqual(IBOAlmWorkorderValue.S_ObjId, aigaTestSubTaskValue.getSubTaskId());
							sql.addEqual(IBOAlmWorkorderValue.S_ObjType, aigaTestSubTaskValue.getSubTaskType());
							sql.addEqual(IBOAlmWorkorderValue.S_ExecStaffId, aigaTestSubTaskValue.getCreator());
							sql.addEqual(IBOAlmWorkorderValue.S_Status, 2);
							IBOAlmWorkorderValue[] currentWorkorders = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
							if(currentWorkorders!=null && currentWorkorders.length>0)
							{
								for(IBOAlmWorkorderValue value : currentWorkorders)
								{
									value.setExecStaffId(sys_staff.getStaffId());
									value.setExecStaffNo(sys_staff.getCode());
								}
								iAlmWorkorderSV.saveAlmWorkorder(currentWorkorders);
							}
							
							//查询此子任务下测试人员干系人
							sql.clear();
							sql.addEqual(IBOAlmStakeholderValue.S_ObjId, aigaTestSubTaskValue.getSubTaskId());
							sql.addEqual(IBOAlmStakeholderValue.S_ObjType, aigaTestSubTaskValue.getSubTaskType());
							sql.addEqual(IBOAlmStakeholderValue.S_StdholderStaffId, aigaTestSubTaskValue.getTestorId());
							
							IBOAlmStakeholderValue[] almStakeholderValues = iAlmStakeholderSV.getStakeholderByCondition(sql.toString(),sql.getParameters());
							//修改子测试任务中的测试人员
							
//							aigaTestSubTaskValue.setCreator(String.valueOf(staff.getStaffId()));
//							aigaTestSubTaskValue.setCreatorStaff(employee.getEmployeeName());
							aigaTestSubTaskValue.setTestorId(staff.getStaffId());
							aigaTestSubTaskValue.setTestorName(employee.getEmployeeName());
							iAigaTestSubTaskSV.saveAigaTestSubTask(aigaTestSubTaskValue);
							//修改子任务流程关于测试人员的干系人
							
							if(almStakeholderValues!=null && almStakeholderValues.length>0)
							{
								for(IBOAlmStakeholderValue value : almStakeholderValues)
								{
									value.setStdholderStaffId(sys_staff.getStaffId());
									value.setStdholderStaffNo(sys_staff.getCode());
									value.setStdholderStaffName(employee.getEmployeeName());
									iAlmStakeholderSV.saveStakeholder(almStakeholderValues);
								}
							}
						}
					}
				}
			}  
		}
	}

	@Override
	public void startPerfTestTaskWorkflow(
			IBOAigaTestTaskValue aigaTestTaskValue,
			List<IBOAlmStakeholderValue> almStakeholderList,IBOAlmWorkorderValue workorderValue,String taskId) throws Exception {
		// TODO Auto-generated method stub
		IAlmStakeholderDao iAlmStakeholderDao = (IAlmStakeholderDao)ServiceFactory.getService(IAlmStakeholderDao.class);
		IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);

		aigaTestTaskValue.setSubmitStaffId(ServiceManager.getUser().getID());
		aigaTestTaskValue.setSubmitStaffName(ServiceManager.getUser().getName());
		aigaTestTaskValue = saveAigaTestTask(aigaTestTaskValue);
		
		String wfName = "";
		String wfTemplateString = "";
		String objTypeString = "";
		
		iAlmStakeholderDao.saveStakeholder(almStakeholderList, aigaTestTaskValue.getTaskId(), IObjectType.PERFTASK_FOLLOW);

		// 创建第一个工单
		wfName = "启动性能测试任务流程";
		wfTemplateString = ConstDefine.TEMPLATE_NAME_PERFTESTTASKWF;
		objTypeString = IObjectType.PERFTASK_FOLLOW;

		//启动此测试任务流程
		AlmMatrixClient amc = new AlmMatrixClient();
		//创建第一个工单
		amc.createStartSaveOrder(String.valueOf(aigaTestTaskValue.getTaskId()), objTypeString, wfTemplateString, workorderValue.getCond(), wfName);
		//启动流程
		amc.createWorkflow(wfTemplateString, "1", objTypeString, String.valueOf(aigaTestTaskValue.getTaskId()), ServiceManager.getOpDateTime(), wfName, workorderValue.getCond());

		//获取发起的测试任务
		IBOAigaTestTaskValue iBOAigaTestTaskValue = new BOAigaTestTaskBean();
		iBOAigaTestTaskValue = iAigaTestTaskSV.getAigaTestTaskByTaskId(taskId);
		if(iBOAigaTestTaskValue!=null){
			iBOAigaTestTaskValue.setPerfTaskId(aigaTestTaskValue.getTaskId());
			iAigaTestTaskSV.saveAigaTestTask(iBOAigaTestTaskValue);
		}
	}
	
	@Override
	public void savePerfTestTaskWorkflow(
			IBOAigaTestTaskValue aigaTestTaskValue) throws Exception {
		// TODO Auto-generated method stub
		aigaTestTaskValue.setSubmitStaffId(ServiceManager.getUser().getID());
		aigaTestTaskValue.setSubmitStaffName(ServiceManager.getUser().getName());
		aigaTestTaskValue = saveAigaTestTask(aigaTestTaskValue);

	}

	@Override
	public void saveTestTaskChange(IBOAigaTestTaskValue aigaTestTaskValue)
			throws Exception {
		// TODO Auto-generated method stub
		IBOAigaTestTaskChangeValue aigaTaskChange = new BOAigaTestTaskChangeBean();
		aigaTaskChange.setCreateTime(ServiceManager.getOpDateTime());
		aigaTaskChange.setChangeStaffId(ServiceManager.getUser().getID());
		aigaTaskChange.setChagneStaffName(ServiceManager.getUser().getName());
		aigaTaskChange.setChangeTaskId(aigaTestTaskValue.getTaskId());
		aigaTaskChange.setChangeTaskTag(aigaTestTaskValue.getTaskTag());
		aigaTaskChange.setChangeReson("第一次排期");
		aigaTaskChange.setPlanidN(aigaTestTaskValue.getPlanId());
		aigaTaskChange.setOnlineTimeN(aigaTestTaskValue.getFactCompleteTime());
		aigaTestTaskDao.saveAigaTestTaskChange(aigaTaskChange);
	}

	@Override
	public void subTaskRegn(List<IBOAlmStakeholderValue> iBOAlmStakeholderList,
			List<IBOAlmWorkorderValue> iBOAlmWorkorderList,List<IBOAigaTestPlanValue> iBOAigaTestPlanList,
			List<IBOAigaTestTaskValue> iBOAigaTestTaskList,List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList,
			List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskValue,
			List<IBOAigaSubTaskProblemValue> iBOAigaSubTaskProblemValue,
			String objType,JSONObject subTaskRegnInfo) throws Exception {
		// TODO Auto-generated method stub
		//处理转派人员工单、干系人等
		IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
		ISecframe secframe = (ISecframe) ServiceFactory.getService(Constants.SERVICE_SECFRAME);
		IAlmWorkorderSV iAlmWorkorderSV = (IAlmWorkorderSV)ServiceFactory.getService(IAlmWorkorderSV.class);
		IAlmStakeholderSV iAlmStakeholderSV = (IAlmStakeholderSV)ServiceFactory.getService(IAlmStakeholderSV.class);
		Criteria sql = new Criteria();
		String subTaskId = "";
		String changeStaffId = "";
		if(subTaskRegnInfo.has("subTaskId"))
		{
			subTaskId = subTaskRegnInfo.getString("subTaskId");//获取测试子任务id序列信息 
			IBOAigaTestSubTaskValue aigaTestSubTaskValue = iAigaTestSubTaskSV.getAigaTestSubTaskBySubTaskId(subTaskId);
			if(aigaTestSubTaskValue!=null)
			{
				if(subTaskRegnInfo.has("changeStaffId"))
				{	
					changeStaffId = subTaskRegnInfo.getString("changeStaffId");//获取修改测试人员Id
					IStaffValue staff = secframe.getStaffByStaffId(Long.valueOf(changeStaffId));
					ISysStaffValue sys_staff = secframe.getSysStaffByCode(staff.getCode());
					ISysEmployeeValue employee = secframe.getSysEmployeeById(sys_staff.getEmployeeId());

					//此对象在原测试人员下的待办工单
					sql.clear();
					sql.addEqual(IBOAlmWorkorderValue.S_ObjId, aigaTestSubTaskValue.getSubTaskId());
					sql.addEqual(IBOAlmWorkorderValue.S_ObjType, aigaTestSubTaskValue.getSubTaskType());
//					sql.addEqual(IBOAlmWorkorderValue.S_ExecStaffId, aigaTestSubTaskValue.getCreator());
					sql.addEqual(IBOAlmWorkorderValue.S_Status, 2);
					IBOAlmWorkorderValue[] currentWorkorders = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
					if(currentWorkorders!=null && currentWorkorders.length>0)
					{
						for(IBOAlmWorkorderValue value : currentWorkorders)
						{
							value.setExecStaffId(sys_staff.getStaffId());
							value.setExecStaffNo(sys_staff.getCode());
						}
						iAlmWorkorderSV.saveAlmWorkorder(currentWorkorders);
					}
					
					//查询此子任务下测试人员干系人
					sql.clear();
					sql.addEqual(IBOAlmStakeholderValue.S_ObjId, aigaTestSubTaskValue.getSubTaskId());
					sql.addEqual(IBOAlmStakeholderValue.S_ObjType, aigaTestSubTaskValue.getSubTaskType());
					sql.addEqual(IBOAlmStakeholderValue.S_StdholderStaffId, aigaTestSubTaskValue.getTestorId());
					
					//修改子测试任务中的测试人员
					IBOAlmStakeholderValue[] almStakeholderValues = iAlmStakeholderSV.getStakeholderByCondition(sql.toString(),sql.getParameters());
					aigaTestSubTaskValue.setTestorId(staff.getStaffId());
					aigaTestSubTaskValue.setTestorName(employee.getEmployeeName());
					iAigaTestSubTaskSV.saveAigaTestSubTask(aigaTestSubTaskValue);
					
					//修改子任务流程关于测试人员的干系人
					if(almStakeholderValues!=null && almStakeholderValues.length>0)
					{
						for(IBOAlmStakeholderValue value : almStakeholderValues)
						{
							value.setStdholderStaffId(sys_staff.getStaffId());
							value.setStdholderStaffNo(sys_staff.getCode());
							value.setStdholderStaffName(employee.getEmployeeName());
							iAlmStakeholderSV.saveStakeholder(almStakeholderValues);
						}
						
					}
				}
			}
		}
		//流程扭转
		IAigaPublicSV iAigaPublicSV = (IAigaPublicSV)ServiceFactory.getService(IAigaPublicSV.class);
		iAigaPublicSV.orderSubmitPublicFun(iBOAlmStakeholderList, iBOAlmWorkorderList, iBOAigaTestPlanList, 
				iBOAigaTestTaskList, iBOAigaSolidTaskList,iBOAigaTestSubTaskValue,
				iBOAigaSubTaskProblemValue,objType);
	}

}
