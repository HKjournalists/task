package com.asiainfo.csc.matrix.common;

import java.lang.reflect.Method;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.ai.comframe.client.ComframeClient;
import com.ai.comframe.client.TaskInfo;
import com.ai.comframe.console.interfaces.IWorkflowConsole;
import com.ai.secframe.common.Constants;
import com.ai.secframe.ivalues.orgmodel.IStaffValue;
import com.ai.secframe.service.pubapi.interfaces.ISecframe;
import com.asiainfo.csc.matrix.bo.BOAlmHisStakeholderBean;
import com.asiainfo.csc.matrix.bo.BOAlmHisWorkflowCaseBean;
import com.asiainfo.csc.matrix.bo.BOAlmHisWorkorderBean;
import com.asiainfo.csc.matrix.bo.BOAlmWorkflowCaseBean;
import com.asiainfo.csc.matrix.bo.BOAlmWorkorderBean;
import com.asiainfo.csc.matrix.bo.BOScheduleBean;
import com.asiainfo.csc.matrix.common.impl.AlmCommonFunImpl;
import com.asiainfo.csc.matrix.common.impl.AlmVmTaskImpl;
import com.asiainfo.csc.matrix.common.interfaces.IAlmBusiObjUpdate;
import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOAlmHisStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmHisWorkflowCaseValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmHisWorkorderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmSubReqValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowCaseValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowTemplateValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;
import com.asiainfo.csc.matrix.ivalues.IBOScheduleValue;
import com.asiainfo.csc.matrix.ivalues.IBOTopoViewValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmHisStakeholderSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmHisWorkorderSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmStakeholderSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkflowSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkflowTemplateSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkorderSV;

public class AlmMatrixClient {
	private final static transient Log log = LogFactory.getLog(AlmMatrixClient.class);
	IAlmWorkorderSV iAlmWorkorderSV = BusiFactory.getAlmWorkorderSV();
	IAlmHisWorkorderSV iAlmHisWorkorderSV = BusiFactory.getAlmHisWorkorderSV();
	IAlmStakeholderSV iAlmStakeholderSV = BusiFactory.getAlmStakeholderSV();
	IAlmWorkflowSV iAlmWorkflowSV = BusiFactory.getAlmWorkflowSV();
	IAlmWorkflowTemplateSV iAlmWorkflowTemplateSV = BusiFactory.getAlmWorkflowTemplateSV();
	IAlmHisStakeholderSV iAlmHisStakeholderSV = BusiFactory.getAlmHisStakeholderSV();
	AlmCommonFunImpl commonFun = new AlmCommonFunImpl();
	IWorkflowConsole iwc =(IWorkflowConsole)ServiceFactory.getService("com.ai.comframe.console.WorkflowConsole");
	ISecframe secframe = (ISecframe) ServiceFactory.getService(Constants.SERVICE_SECFRAME);
	private IAlmBusiObjUpdate BusiObjUpdate = null;
	
	public AlmMatrixClient(){
	}
	public AlmMatrixClient(IAlmBusiObjUpdate iAlmBusiObjUpdate){
		this.BusiObjUpdate = iAlmBusiObjUpdate;
	}
	
	/**
	 * 创建VM流程实例，一般先调用createStartSaveOrder函数来保存需求创建的工单
	 * @param flowCode
	 * @param staffId
	 * @param objectTypeId
	 * @param objectId
	 * @param startTime
	 * @param notes
	 * @param cond
	 * @return
	 * @throws Exception
	 */
	public long createWorkflow(String flowCode,String staffId,
            String objectTypeId, String objectId,
            Timestamp startTime,String notes,String cond) throws  Exception{
		//将业务对象管理工单状态置为已完成
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_LinkNoType, ConstDefine.LINK_NO_TYPE_MGR);
		sql.addEqual(IBOAlmWorkorderValue.S_ObjId, objectId);
		sql.addEqual(IBOAlmWorkorderValue.S_ObjType, objectTypeId);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
		sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_RECEIVE);
		IBOAlmWorkorderValue[] adminWorkorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(adminWorkorders.length != 0){
			adminWorkorders[0].setIsCurrentTask(ConstDefine.IS_NOT_CURRENT_TASK);
			adminWorkorders[0].setStatus(ConstDefine.WO_STATUS_COMPLETE);
			adminWorkorders[0].setFinishTime(ServiceManager.getOpDateTime());
			adminWorkorders[0].setExecTimes(ServiceManager.getOpDateTime().getTime() - adminWorkorders[0].getCreateTime().getTime());
			iAlmWorkorderSV.saveAlmWorkorder(adminWorkorders);
		}
		
		sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowTemplateValue.S_TemplateName, flowCode);
		IBOAlmWorkflowTemplateValue[] iBOAlmWorkflowTemplateValues =iAlmWorkflowTemplateSV.getAlmWorkflowTemplateByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowTemplateValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一模板编号查询到不唯一的配置信息,查询表：ALM_WORKFLOW_TEMPLATE；查询条件为【");
				sb.append(IBOAlmWorkflowTemplateValue.S_TemplateName +":" + flowCode);
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);	
				throw new Exception(sb.toString());
			}
		}
		if(ConstDefine.VM_TEMPLATE_TYPE.equals(iBOAlmWorkflowTemplateValues[0].getTemplateType())){
			HashMap aVars =  new HashMap<String,String>();
			//创建VM工作流实例时，需一次性对流程中使用的所有自定义变量进行初始化
			aVars = commonFun.analyzeCond(aVars, cond);
			return ComframeClient.getDefaultComframeClient().createWorkflow(flowCode, staffId, objectTypeId, objectId, aVars, null, "");
		}
		if(ConstDefine.MATRIX_TEMPLATE_TYPE.equals(iBOAlmWorkflowTemplateValues[0].getTemplateType())){
			return this.createMatrixWF(flowCode, staffId, objectTypeId, objectId, startTime, notes, cond);
		}
		return 0;
		
	}
	
	/**
	 * 创建矩阵流程实例
	 * @param flowCode
	 * @param staffId
	 * @param objectTypeId
	 * @param objectId
	 * @param startTime
	 * @param notes
	 * @param cond
	 * @return
	 * @throws Exception
	 */
	public long createMatrixWF(String flowCode,String staffId,
            String objectTypeId, String objectId,
            Timestamp startTime,String notes,String cond) throws  Exception{
		//1创建alm_work_flow_case矩阵流程实例
		String condition = "TEMPLATE_NAME=:templateName";
		Map<String,Object> paramter = new HashMap<String,Object>();
		paramter.put("templateName", flowCode);
		IBOAlmWorkflowTemplateValue[] template = BusiFactory.getAlmWorkflowTemplateSV().getAlmWorkflowTemplateByCondition(condition, paramter);
		if(template.length==0||template==null)
			throw new Exception("未找到相应的模版");
		
		IBOAlmWorkflowCaseValue almWorkflowCase = new BOAlmWorkflowCaseBean();
		almWorkflowCase.setTaskTemplateId(template[0].getTemplateId());
		almWorkflowCase.setQueueId("AI");
		almWorkflowCase.setTaskTag(flowCode);
		almWorkflowCase.setParentTaskId(-1);
		almWorkflowCase.setState(ConstDefine.WF_CASE_STATUS_ALLOW);
		almWorkflowCase.setStartDate(ServiceManager.getOpDateTime());
		almWorkflowCase.setWorkflowObjectId(objectId);
		almWorkflowCase.setWorkflowObjectTypeId(objectTypeId);
		almWorkflowCase.setCreateStaffId(staffId);
		almWorkflowCase.setCreateDate(ServiceManager.getOpDateTime());
		almWorkflowCase.setDescription(notes);
		IBOAlmWorkflowCaseValue[] almWorkflowCases = {almWorkflowCase};
		BusiFactory.getAlmWorkflowCaseSV().saveAlmWorkflowCase(almWorkflowCases);
		//2创建Alm_workorder开始环节工单
		condition = "LINK_NO_TYPE=:linkNoType and TEMPLATE_NAME=:templateName";
		paramter = new HashMap<String,Object>();
		paramter.put("linkNoType", ConstDefine.LINK_NO_TYPE_START);
		paramter.put("templateName", flowCode);
		IBOAlmWorkflowValue[] workflows = BusiFactory.getAlmWorkflowSV().getAlmWorkflowByCondition(condition, paramter);
		if(workflows.length==0||workflows==null)
			throw new Exception("未找到相应的流程配置");
		
		IBOAlmWorkorderValue workorder = new BOAlmWorkorderBean();
		workorder.setWorkflowId(almWorkflowCase.getTaskId());
		workorder.setParentOrderId(ConstDefine.WO_NO_PARENT);
		//查询上一条工单ID
		IBOAlmWorkorderValue lastWorkorder = null;
		lastWorkorder = iAlmWorkorderSV.getLastWorkorderByObjIdAndObjType(objectId,objectTypeId);
		if(lastWorkorder != null){
			workorder.setLastOrderId(lastWorkorder.getOrderId());
		}
		workorder.setVmTaskId(ConstDefine.WO_NO_VM_TASK_ID);
		workorder.setParentVmTaskId(ConstDefine.WO_NO_PARENT_VM_TASK_ID);
		workorder.setLastVmTaskId(ConstDefine.WO_NO_LAST_VM_TASK_ID);
		workorder.setLinkNo(workflows[0].getLinkNo());
		workorder.setLinkId(workflows[0].getLinkId());
		workorder.setLinkNoType(workflows[0].getLinkNoType());
		workorder.setIsCurrentTask(ConstDefine.IS_CURRENT_TASK);
		workorder.setObjId(Long.parseLong(objectId));
		workorder.setObjType(objectTypeId);
		workorder.setOrderType(ConstDefine.STAKEHOLDERTYPE_WF);
		workorder.setDealType(ConstDefine.WO_DEAL_TYPE_APPROVE);
		workorder.setIsLock(ConstDefine.NO_LOCK);
		workorder.setFinishPrint(ConstDefine.NOT_NEED_PRINT);
		workorder.setResult(ConstDefine.WO_APPROVAL_RESULT_PASS);
		workorder.setCond(cond);
		workorder.setStatus(ConstDefine.WO_STATUS_COMPLETE);
		workorder.setCreateTime(ServiceManager.getOpDateTime());
		workorder.setRecvTime(ServiceManager.getOpDateTime());
		workorder.setExecTime(ServiceManager.getOpDateTime());
		workorder.setFinishTime(ServiceManager.getOpDateTime());
		IBOAlmWorkorderValue[] workorders = {workorder};
		BusiFactory.getAlmWorkorderSV().saveAlmWorkorder(workorders);
		//3创建ALM_SCHEDULE矩阵流程调度记录
		IBOScheduleValue schedule = new BOScheduleBean();
		schedule.setWorkflowId(almWorkflowCase.getTaskId());
		schedule.setQueueId("AI");
		schedule.setAddDate(ServiceManager.getOpDateTime());
		schedule.setState(ConstDefine.WO_SCHEDULE_STATUS_WAIT);
		IBOScheduleValue[] schedules = {schedule};
		BusiFactory.getAlmScheduleSV().saveSchedule(schedules);
		return almWorkflowCase.getTaskId();
	}
	
	/**
	 * 保存工单，以及处理人
	 * @param almWorkorderValue
	 * @param almStakeholder
	 * @param vars
	 * @throws Exception
	 */
	public void saveWorkorder(IBOAlmWorkorderValue almWorkorderValue,List<IBOAlmStakeholderValue> almStakeholder, String cond)throws Exception{
		try{
			almWorkorderValue.setCond(cond);
			IBOAlmWorkorderValue[] workorders = {almWorkorderValue};
			BusiFactory.getAlmWorkorderSV().saveAlmWorkorder(workorders);
			long objId = almWorkorderValue.getObjId();
			for (IBOAlmStakeholderValue holder : almStakeholder) {
				holder.setCreateTime(ServiceManager.getOpDateTime());
				holder.setObjId(objId);
				holder.setObjType(almWorkorderValue.getObjType());
				BusiFactory.getAlmStakeholderSV().saveStakeholder(new IBOAlmStakeholderValue[]{holder});
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("保存工单以及处理人失败！\n\n错误原因："
					+ (e.getCause() == null ? e.getMessage() : e.getCause()
							.getMessage()), e);
		}
	}
	//流程回退 根据在历史轨迹中选中的工单记录，回退到与选中工单记录相同的环节
	//需要考虑在使用回退功能时 被驱动的流程如何流转
	public void rollbackWorkflowByRollbackOrderId(long rollbackorderId) throws Exception{
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_OrderId, rollbackorderId);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
		sql.addEqual(IBOAlmWorkorderValue.S_IsCurrentTask, ConstDefine.IS_NOT_CURRENT_TASK);
		sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_COMPLETE);
		IBOAlmWorkorderValue[] iWorkOrderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(iWorkOrderValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("查询未完成工单数量不唯一；查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_OrderId +":" + rollbackorderId + ",");
				sb.append(IBOAlmWorkorderValue.S_OrderType +":" +  ConstDefine.STAKEHOLDERTYPE_WF + ",");
				sb.append(IBOAlmWorkorderValue.S_IsCurrentTask +":" + ConstDefine.IS_NOT_CURRENT_TASK + ",");
				sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_COMPLETE + ",");
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowValue.S_LinkNo, iWorkOrderValues[0].getLinkNo());
		sql.addEqual(IBOAlmWorkflowValue.S_LinkId, iWorkOrderValues[0].getLinkId());
		IBOAlmWorkflowValue[] iBOAlmWorkflowValues =  iAlmWorkflowSV.getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一环节查询到不唯一的配置信息,查询表：ALM_WORKFLOW；查询条件为【");
				sb.append(IBOAlmWorkflowValue.S_LinkId +":" + iWorkOrderValues[0].getLinkId() + ",");
				sb.append(IBOAlmWorkflowValue.S_LinkNo + ":" + iWorkOrderValues[0].getLinkNo());
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);	
				throw new Exception(sb.toString());
			}
		}
		sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowTemplateValue.S_TemplateName, iBOAlmWorkflowValues[0].getTemplateName());
		IBOAlmWorkflowTemplateValue[] iBOAlmWorkflowTemplateValues =iAlmWorkflowTemplateSV.getAlmWorkflowTemplateByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowTemplateValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一模板编号查询到不唯一的配置信息,查询表：ALM_WORKFLOW_TEMPLATE；查询条件为【");
				sb.append(IBOAlmWorkflowTemplateValue.S_TemplateName +":" + iBOAlmWorkflowValues[0].getTemplateName() + ",");
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);	
				throw new Exception(sb.toString());
			}
		}
		if(ConstDefine.VM_TEMPLATE_TYPE.equals(iBOAlmWorkflowTemplateValues[0].getTemplateType())){
			
			sql = new Criteria();
			sql.addEqual(IBOAlmWorkorderValue.S_WorkflowId, iWorkOrderValues[0].getWorkflowId());
			sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
			sql.addEqual(IBOAlmWorkorderValue.S_IsCurrentTask, ConstDefine.IS_CURRENT_TASK);
			sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_RECEIVE);
			iWorkOrderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
			if(iWorkOrderValues.length != 1){
				if (log.isErrorEnabled()) {
					StringBuffer sb = new StringBuffer();
					sb.append("查询未完成工单数量不唯一；查询条件为【");
					sb.append(IBOAlmWorkorderValue.S_WorkflowId +":" + iWorkOrderValues[0].getWorkflowId() + ",");
					sb.append(IBOAlmWorkorderValue.S_OrderType +":" +  ConstDefine.STAKEHOLDERTYPE_WF + ",");
					sb.append(IBOAlmWorkorderValue.S_IsCurrentTask +":" + ConstDefine.IS_CURRENT_TASK + ",");
					sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_RECEIVE + ",");
					sb.append("】");
					sb.append("SQL:" + sql.toString());
					log.error(sb);
					throw new Exception(sb.toString());
				}
			}
			if(ConstDefine.LINK_NO_TYPE_SIGN.equals(iWorkOrderValues[0].getLinkNoType())){
				if (log.isErrorEnabled()) {
					StringBuffer sb = new StringBuffer();
					sb.append("会签环节不可以使用回退!");
					log.error(sb);
					throw new Exception(sb.toString());
				}
			}
			Map aVars = ComframeClient.getDefaultComframeClient().getWorkflowVars(iWorkOrderValues[0].getWorkflowId());
			ComframeClient.getDefaultComframeClient().finishUserTask(iWorkOrderValues[0].getVmTaskId(), String.valueOf(iWorkOrderValues[0].getExecStaffId()), iWorkOrderValues[0].getResult(), null, aVars);
			iwc.jumpToTask(iWorkOrderValues[0].getVmTaskId(), iBOAlmWorkflowValues[0].getVmLinkId() ,iWorkOrderValues[0].getExecStaffId()+"", iWorkOrderValues[0].getOpinion(), aVars);
		}
		if(ConstDefine.MATRIX_TEMPLATE_TYPE.equals(iBOAlmWorkflowTemplateValues[0].getTemplateType())){
			
		}
		//调研驱动函数	
		//需要考虑回退时如何调研驱动??????????????????????????????????
	}
	
	/**
	 * 工单转派，只针对人工任务
	 * @param orderId
	 * @param iBOAlmStakeholderValue
	 * @return
	 * @throws Exception
	 */
	public long reAuthorizeTask(long orderId, IBOAlmStakeholderValue iBOAlmStakeholderValue) throws Exception{
		
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_OrderId, orderId);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
		sql.addEqual(IBOAlmWorkorderValue.S_IsCurrentTask, ConstDefine.IS_CURRENT_TASK);
		sql.addEqual(IBOAlmWorkorderValue.S_LinkNoType, ConstDefine.LINK_NO_TYPE_USER);
		sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_RECEIVE);
		IBOAlmWorkorderValue[] iWorkOrderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(iWorkOrderValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("查询未完成工单数量不唯一；查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_OrderId +":" + orderId + ",");
				sb.append(IBOAlmWorkorderValue.S_OrderType +":" +  ConstDefine.STAKEHOLDERTYPE_WF + ",");
				sb.append(IBOAlmWorkorderValue.S_IsCurrentTask +":" + ConstDefine.IS_CURRENT_TASK + ",");
				sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_RECEIVE + ",");
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		
		IBOAlmWorkorderValue newWorkOrderValue = iAlmWorkorderSV.capyWorkorderByWorkorderNoSave(iWorkOrderValues[0]);
		if(ConstDefine.LINK_NO_TYPE_USER.equals(iWorkOrderValues[0].getLinkNoType())){
			
		}
		if(ConstDefine.LINK_NO_TYPE_SIGN.equals(iWorkOrderValues[0].getLinkNoType())){
			newWorkOrderValue.setParentOrderId(ConstDefine.WO_NO_PARENT);
		}
		newWorkOrderValue.setLastOrderId(iWorkOrderValues[0].getOrderId());
		newWorkOrderValue.setExecStaffId(iBOAlmStakeholderValue.getStdholderStaffId());
		newWorkOrderValue.setExecStaffNo(iBOAlmStakeholderValue.getStdholderStaffNo());
		newWorkOrderValue.setCreateTime(ServiceManager.getOpDateTime());
		newWorkOrderValue.setLockTime(null);
		newWorkOrderValue.setRealseLockTime(null);
		newWorkOrderValue.setLockTimes(0);
		if(ConstDefine.NOT_NEED_PRINT == newWorkOrderValue.getFinishPrint()){
			newWorkOrderValue.setRecvTime(ServiceManager.getOpDateTime());
			newWorkOrderValue.setExecTime(ServiceManager.getOpDateTime());
			newWorkOrderValue.setExecTimes(0);
		}
		else if(ConstDefine.NO_FINISH_PRINT == newWorkOrderValue.getFinishPrint()){
			newWorkOrderValue.setRecvTime(null);
			newWorkOrderValue.setExecTime(null);
			newWorkOrderValue.setExecTimes(0);
		}
		else if(ConstDefine.FINISH_PRINT == newWorkOrderValue.getFinishPrint()){
			newWorkOrderValue.setRecvTime(ServiceManager.getOpDateTime());
			newWorkOrderValue.setExecTime(ServiceManager.getOpDateTime());
			newWorkOrderValue.setExecTimes(0);
		}
			
		iAlmWorkorderSV.saveAlmWorkorder( new IBOAlmWorkorderValue[]{newWorkOrderValue});
		//将被转派人的干系人信息保存到历史表中
		iAlmHisStakeholderSV.copyHisStakeholderByStakeholder(newWorkOrderValue, iBOAlmStakeholderValue);
		//将转派人的工单状态置为已完成
		iWorkOrderValues[0].setIsCurrentTask(ConstDefine.IS_NOT_CURRENT_TASK);
		iWorkOrderValues[0].setDealType(ConstDefine.WO_DEAL_TYPE_REAUTHORIZE);
		iWorkOrderValues[0].setResult(ConstDefine.WO_APPROVAL_RESULT_NO_OPTION);
		iWorkOrderValues[0].setStatus(ConstDefine.WO_STATUS_COMPLETE);
		iWorkOrderValues[0].setFinishTime(ServiceManager.getOpDateTime());
		iWorkOrderValues[0].setExecTimes(iWorkOrderValues[0].getExecTimes() + ServiceManager.getOpDateTime().getTime() - iWorkOrderValues[0].getExecTime().getTime());
		iAlmWorkorderSV.saveAlmWorkorder(iWorkOrderValues);
		return iWorkOrderValues[0].getOrderId();
	}
	/**
	 * 终止VM或矩阵流程实例  对于嵌套驱动流程此函数没有提供解决方案
	 * @param workflowId
	 * @param staffId
	 * @param reason
	 * @return
	 * @throws Exception
	 */
	public void terminateWorkflow(long workflowId, String staffId, String reason) throws Exception{
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_WorkflowId, workflowId);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
		sql.addEqual(IBOAlmWorkorderValue.S_ParentOrderId, ConstDefine.WO_NO_PARENT);
		//按orderId降序排列
		sql.addDescendingOrderByColumn(IBOAlmWorkorderValue.S_OrderId);
		IBOAlmWorkorderValue[] workorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(workorders.length == 0 ){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("不存在"+IBOAlmWorkorderValue.S_WorkflowId+"为"+workflowId+"的工作流实例，查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_WorkflowId +":" + workflowId + ",");
				sb.append(IBOAlmWorkorderValue.S_OrderType +":" + ConstDefine.STAKEHOLDERTYPE_WF + ",");
				sb.append(IBOAlmWorkorderValue.S_ParentOrderId +":" + ConstDefine.WO_NO_PARENT);
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowValue.S_LinkNo, workorders[0].getLinkNo());
		sql.addEqual(IBOAlmWorkflowValue.S_LinkId, workorders[0].getLinkId());
		IBOAlmWorkflowValue[] iBOAlmWorkflowValues =  iAlmWorkflowSV.getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一环节查询到不唯一的配置信息,查询表：ALM_WORKFLOW；查询条件为【");
				sb.append(IBOAlmWorkflowValue.S_LinkId +":" + workorders[0].getLinkId() + ",");
				sb.append(IBOAlmWorkflowValue.S_LinkNo + ":" + workorders[0].getLinkNo());
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);	
				throw new Exception(sb.toString());
			}
		}
		sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowTemplateValue.S_TemplateName, iBOAlmWorkflowValues[0].getTemplateName());
		IBOAlmWorkflowTemplateValue[] iBOAlmWorkflowTemplateValues =iAlmWorkflowTemplateSV.getAlmWorkflowTemplateByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowTemplateValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一模板编号查询到不唯一的配置信息,查询表：ALM_WORKFLOW_TEMPLATE；查询条件为【");
				sb.append(IBOAlmWorkflowTemplateValue.S_TemplateName +":" + iBOAlmWorkflowValues[0].getTemplateName() + ",");
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);	
				throw new Exception(sb.toString());
			}
		}
		sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowValue.S_TemplateName, iBOAlmWorkflowValues[0].getTemplateName());
		sql.addEqual(IBOAlmWorkflowValue.S_LinkNoType, ConstDefine.LINK_NO_TYPE_TERMINATION);
		IBOAlmWorkflowValue[] terminationWFs =  iAlmWorkflowSV.getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一环节查询到不唯一的配置信息,查询表：ALM_WORKFLOW；查询条件为【");
				sb.append(IBOAlmWorkflowValue.S_TemplateName +":" + iBOAlmWorkflowValues[0].getTemplateName() + ",");
				sb.append(IBOAlmWorkflowValue.S_LinkNoType + ":" + ConstDefine.LINK_NO_TYPE_TERMINATION);
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);	
				throw new Exception(sb.toString());
			}
		}
		
		//生成流程终止操作工单
		IStaffValue staff = secframe.getStaffByStaffId(Long.parseLong(staffId));
		IBOAlmWorkorderValue iWorkOrderValue = new BOAlmWorkorderBean();
		iWorkOrderValue.setWorkflowId(workflowId);
		iWorkOrderValue.setParentOrderId(ConstDefine.WO_NO_PARENT);
		//查询上一条工单ID
		iWorkOrderValue.setLastOrderId(workorders[0].getOrderId());
		iWorkOrderValue.setVmTaskId(ConstDefine.WO_NO_VM_TASK_ID);
		iWorkOrderValue.setParentVmTaskId(ConstDefine.WO_NO_PARENT_VM_TASK_ID);
		iWorkOrderValue.setLastVmTaskId(ConstDefine.WO_NO_LAST_VM_TASK_ID);
		iWorkOrderValue.setLinkId(terminationWFs[0].getLinkId());
		iWorkOrderValue.setLinkNo(terminationWFs[0].getLinkNo());
		iWorkOrderValue.setLinkNoType(ConstDefine.LINK_NO_TYPE_TERMINATION);
		iWorkOrderValue.setIsCurrentTask(ConstDefine.IS_NOT_CURRENT_TASK);
		iWorkOrderValue.setOrderType(ConstDefine.STAKEHOLDERTYPE_WF);
		iWorkOrderValue.setObjId(workorders[0].getObjId());
		iWorkOrderValue.setObjType(workorders[0].getObjType());
		iWorkOrderValue.setDealType(ConstDefine.WO_DEAL_TYPE_APPROVE);
		iWorkOrderValue.setIsLock(ConstDefine.NO_LOCK);
		iWorkOrderValue.setFinishPrint(ConstDefine.NOT_NEED_PRINT);
		iWorkOrderValue.setExecStaffId(staff.getStaffId());
		iWorkOrderValue.setExecStaffNo(staff.getCode());
		iWorkOrderValue.setStatus(ConstDefine.WO_STATUS_COMPLETE);
		iWorkOrderValue.setCreateTime(ServiceManager.getOpDateTime());
		iWorkOrderValue.setRecvTime(ServiceManager.getOpDateTime());
		iWorkOrderValue.setFinishTime(ServiceManager.getOpDateTime());
		IBOAlmWorkorderValue[] iBOAlmWorkorderValues =	{iWorkOrderValue};
		iAlmWorkorderSV.saveAlmWorkorder(iBOAlmWorkorderValues);
		//保存流转终止操作人的干系人信息
		IBOAlmHisStakeholderValue iBOAlmHisStakeholderValue = new BOAlmHisStakeholderBean();
		iBOAlmHisStakeholderValue.setOrderId(iWorkOrderValue.getOrderId());
		iBOAlmHisStakeholderValue.setTemplateId(iBOAlmWorkflowTemplateValues[0].getTemplateId());
		iBOAlmHisStakeholderValue.setLinkId(iWorkOrderValue.getLinkId());
		iBOAlmHisStakeholderValue.setLinkNo(iWorkOrderValue.getLinkNo());
		iBOAlmHisStakeholderValue.setObjId(iWorkOrderValue.getObjId());
		iBOAlmHisStakeholderValue.setObjType(iWorkOrderValue.getObjType());
		iBOAlmHisStakeholderValue.setStdholderStaffOrgId(staff.getOrganizeId());
		iBOAlmHisStakeholderValue.setStdholderStaffId(staff.getStaffId());
		iBOAlmHisStakeholderValue.setStdholderStaffNo(staff.getCode());
		iBOAlmHisStakeholderValue.setStdholderStaffName(staff.getName());
		iBOAlmHisStakeholderValue.setStdholdeType(iWorkOrderValue.getOrderType());
		iBOAlmHisStakeholderValue.setCreateTime(ServiceManager.getOpDateTime());
		IBOAlmHisStakeholderValue[] iBOAlmHisStakeholderValues = {iBOAlmHisStakeholderValue};
		BusiFactory.getAlmHisStakeholderDao().saveHisStakeholder(iBOAlmHisStakeholderValues);
		
		if(ConstDefine.VM_TEMPLATE_TYPE.equals(iBOAlmWorkflowTemplateValues[0].getTemplateType())){
			Criteria condition=new Criteria();
			condition.clear();
			condition.addEqual(IBOAlmStakeholderValue.S_ObjId,workorders[0].getObjId());
			condition.addEqual(IBOAlmStakeholderValue.S_ObjType, workorders[0].getObjType());
			condition.addEqual(IBOAlmStakeholderValue.S_StdholdeType, ConstDefine.STAKEHOLDERTYPE_WF);
			IBOAlmStakeholderValue[] stakeholders=BusiFactory.getAlmStakeholderSV().getStakeholderByCondition(condition.toString(), condition.getParameters());
			for(IBOAlmStakeholderValue stakeholder : stakeholders){
				stakeholder.delete();
				BusiFactory.getAlmStakeholderSV().saveStakeholder(new IBOAlmStakeholderValue[]{stakeholder});
			}
			
			condition.clear();
			condition.addEqual(BOAlmWorkorderBean.S_ObjId,workorders[0].getObjId());
			condition.addEqual(BOAlmWorkorderBean.S_ObjType,workorders[0].getObjType());
			condition.addEqual(BOAlmWorkorderBean.S_OrderType,ConstDefine.STAKEHOLDERTYPE_WF);
			workorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(condition.toString(),condition.getParameters());
			for(IBOAlmWorkorderValue workorderVal : workorders){
				//更新所有工单状态为已完成
				if(workorderVal.getStatus() != ConstDefine.WO_STATUS_COMPLETE){
					workorderVal.setFinishTime(ServiceManager.getOpDateTime());
					workorderVal.setStatus(ConstDefine.WO_STATUS_COMPLETE);
					workorderVal.setIsCurrentTask(ConstDefine.IS_NOT_CURRENT_TASK);
				}
				iAlmWorkorderSV.saveAlmWorkorder(new IBOAlmWorkorderValue[]{workorderVal});
				//将工单移到工单历史表中
				this.cutAlmWorkOrderToAlmHisWorkOrder(workorderVal);
			}
			ComframeClient.getDefaultComframeClient().terminateWorkflow(workflowId, staffId, reason);
		}else if(ConstDefine.MATRIX_TEMPLATE_TYPE.equals(iBOAlmWorkflowTemplateValues[0].getTemplateType())){
			Criteria condition=new Criteria();
			condition.addEqual(BOAlmWorkflowCaseBean.S_TaskId, workflowId);
			IBOAlmWorkflowCaseValue[] workflowCases=BusiFactory.getAlmWorkflowCaseSV().getAlmWorkflowCaseByCondition(condition.toString(),condition.getParameters());
			if(workflowCases.length==0||workflowCases==null)
				throw new Exception("未找到相应的流程实例，函数terminateWorkflow");
			IBOAlmHisWorkflowCaseValue hisWorkflowCase = new BOAlmHisWorkflowCaseBean();
			hisWorkflowCase.setTaskId(workflowCases[0].getTaskId());
			hisWorkflowCase.setTaskTemplateId(workflowCases[0].getTaskTemplateId());
			hisWorkflowCase.setQueueId(workflowCases[0].getQueueId());
			hisWorkflowCase.setTaskTag(workflowCases[0].getTaskTag());
			hisWorkflowCase.setParentTaskId(workflowCases[0].getParentTaskId());
			hisWorkflowCase.setState(workflowCases[0].getState());
			hisWorkflowCase.setWorkflowObjectId(workflowCases[0].getWorkflowObjectId());
			hisWorkflowCase.setWorkflowObjectTypeId(workflowCases[0].getWorkflowObjectTypeId());
			hisWorkflowCase.setCreateStaffId(workflowCases[0].getCreateStaffId());
			hisWorkflowCase.setCreateDate(workflowCases[0].getCreateDate());
			hisWorkflowCase.setStartDate(workflowCases[0].getStartDate());
			hisWorkflowCase.setDescription(workflowCases[0].getDescription());
			BusiFactory.getAlmHisWorkflowCaseDao().saveHisWorkflowCase(new IBOAlmHisWorkflowCaseValue[]{hisWorkflowCase});
				
			workflowCases[0].delete();
			BusiFactory.getAlmWorkflowCaseSV().saveAlmWorkflowCase(new IBOAlmWorkflowCaseValue[]{workflowCases[0]});
			
			condition.clear();
			condition.addEqual(BOScheduleBean.S_WorkflowId, workflowId);
			IBOScheduleValue[] scheduleValues=BusiFactory.getAlmScheduleSV().getScheduleByCondition(condition.toString(),condition.getParameters());
			if(scheduleValues.length==0||scheduleValues==null)
				throw new Exception("未找到相应的调度队列，函数terminateWorkflow");
			scheduleValues[0].delete();
			BusiFactory.getAlmScheduleSV().saveSchedule(new IBOScheduleValue[]{scheduleValues[0]});
				
			condition.clear();
			condition.addEqual(IBOAlmStakeholderValue.S_ObjId,workflowCases[0].getWorkflowObjectId());
			condition.addEqual(IBOAlmStakeholderValue.S_ObjType, workflowCases[0].getWorkflowObjectTypeId());
			condition.addEqual(IBOAlmStakeholderValue.S_StdholdeType, ConstDefine.STAKEHOLDERTYPE_WF);
			IBOAlmStakeholderValue[] stakeholders=BusiFactory.getAlmStakeholderSV().getStakeholderByCondition(condition.toString(), condition.getParameters());
			for(IBOAlmStakeholderValue stakeholder : stakeholders){
				stakeholder.delete();
				BusiFactory.getAlmStakeholderSV().saveStakeholder(new IBOAlmStakeholderValue[]{stakeholder});
			}
			
			condition.clear();
			condition.addEqual(BOAlmWorkorderBean.S_ObjId,workorders[0].getObjId());
			condition.addEqual(BOAlmWorkorderBean.S_ObjType,workorders[0].getObjType());
			condition.addEqual(BOAlmWorkorderBean.S_OrderType,ConstDefine.STAKEHOLDERTYPE_WF);
			workorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(condition.toString(),condition.getParameters());
			for(IBOAlmWorkorderValue workorderVal : workorders){
				//更新所有工单状态为已完成
				workorderVal.setFinishTime(ServiceManager.getOpDateTime());
				workorderVal.setStatus(ConstDefine.WO_STATUS_COMPLETE);
				workorderVal.setIsCurrentTask(ConstDefine.IS_NOT_CURRENT_TASK);
				iAlmWorkorderSV.saveAlmWorkorder(new IBOAlmWorkorderValue[]{workorderVal});
				//将工单移到工单历史表中
				this.cutAlmWorkOrderToAlmHisWorkOrder(workorderVal);
			}
			
		}
		//修改业务对象状态
		if(BusiObjUpdate != null){
			BusiObjUpdate.updateObjCurPhaseAndCurStatus(String.valueOf(workorders[0].getObjId()),String.valueOf(workorders[0].getObjType()),String.valueOf(terminationWFs[0].getLinkId()));
		}
			
	  }
	
	/**
	 * 打单函数
	 * @param orderId
	 * @param iBOAlmStakeholderValue
	 * @throws Exception
	 */
	public void printTask(long orderId,IBOAlmStakeholderValue iBOAlmStakeholderValue) throws Exception{
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_OrderId, orderId);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
		sql.addEqual(IBOAlmWorkorderValue.S_IsCurrentTask, ConstDefine.IS_CURRENT_TASK);
		sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_CREATE);
		IBOAlmWorkorderValue[] iWorkOrderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(iWorkOrderValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("查询未完成工单数量不唯一；查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_OrderId +":" + orderId + ",");
				sb.append(IBOAlmWorkorderValue.S_OrderType +":" +  ConstDefine.STAKEHOLDERTYPE_WF + ",");
				sb.append(IBOAlmWorkorderValue.S_IsCurrentTask +":" + ConstDefine.IS_CURRENT_TASK + ",");
				sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_CREATE);
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		iWorkOrderValues[0].setExecStaffId(iBOAlmStakeholderValue.getStdholderStaffId());
		iWorkOrderValues[0].setExecStaffNo(iBOAlmStakeholderValue.getStdholderStaffNo());
		iWorkOrderValues[0].setFinishPrint(ConstDefine.FINISH_PRINT);
		iWorkOrderValues[0].setStatus(ConstDefine.WO_STATUS_RECEIVE);
		iWorkOrderValues[0].setRecvTime(ServiceManager.getOpDateTime());
		iWorkOrderValues[0].setExecTime(ServiceManager.getOpDateTime());
		iAlmWorkorderSV.saveAlmWorkorder(iWorkOrderValues);
		//将加锁的干系人信息保存到历史表中
		sql = new Criteria();
		sql.addEqual(IBOAlmHisStakeholderValue.S_OrderId, orderId);
		IBOAlmHisStakeholderValue[] iBOAlmHisStakeholderValues = iAlmHisStakeholderSV.getHisStakeholderByCondition(sql.toString(), sql.getParameters());
		if(iWorkOrderValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("查询未完成工单数量不唯一；查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_OrderId +":" + orderId + ",");
				sb.append(IBOAlmWorkorderValue.S_OrderType +":" +  ConstDefine.STAKEHOLDERTYPE_WF + ",");
				sb.append(IBOAlmWorkorderValue.S_IsCurrentTask +":" + ConstDefine.IS_CURRENT_TASK + ",");
				sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_CREATE);
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		iBOAlmHisStakeholderValues[0].setStdholderStaffId(iBOAlmStakeholderValue.getStdholderStaffId());
		iBOAlmHisStakeholderValues[0].setStdholderStaffNo(iBOAlmStakeholderValue.getStdholderStaffNo());
		iBOAlmHisStakeholderValues[0].setStdholderStaffName(iBOAlmStakeholderValue.getStdholderStaffName());
		iBOAlmHisStakeholderValues[0].setStdholderStaffOrgId(iBOAlmStakeholderValue.getStdholderStaffOrgId());
		iAlmHisStakeholderSV.saveHisStakeholder(iBOAlmHisStakeholderValues);
	}

	/**
	 * VM或矩阵流程工单回单
	 * @param orderId
	 * @param result
	 * @param reason
	 * @param cond
	 * @return
	 * @throws Exception
	 */
	public boolean finishUserTask(long orderId,String result,
            String reason,String cond) throws
            Exception{
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_OrderId, orderId);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
		sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_RECEIVE);
		IBOAlmWorkorderValue[] workorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(workorders.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("查找业务系统工单数量不为1，查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_OrderId +":" + orderId + ",");
				sb.append(IBOAlmWorkorderValue.S_OrderType +":" + ConstDefine.STAKEHOLDERTYPE_WF + ",");
				sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_RECEIVE);
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowValue.S_LinkNo, workorders[0].getLinkNo());
		sql.addEqual(IBOAlmWorkflowValue.S_LinkId, workorders[0].getLinkId());
		IBOAlmWorkflowValue[] iBOAlmWorkflowValues =  iAlmWorkflowSV.getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一环节查询到不唯一的配置信息,查询表：ALM_WORKFLOW；查询条件为【");
				sb.append(IBOAlmWorkflowValue.S_LinkId +":" + workorders[0].getLinkId() + ",");
				sb.append(IBOAlmWorkflowValue.S_LinkNo + ":" + workorders[0].getLinkNo());
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);	
				throw new Exception(sb.toString());
			}
		}
		sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowTemplateValue.S_TemplateName, iBOAlmWorkflowValues[0].getTemplateName());
		IBOAlmWorkflowTemplateValue[] iBOAlmWorkflowTemplateValues =iAlmWorkflowTemplateSV.getAlmWorkflowTemplateByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowTemplateValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一模板编号查询到不唯一的配置信息,查询表：ALM_WORKFLOW_TEMPLATE；查询条件为【");
				sb.append(IBOAlmWorkflowTemplateValue.S_TemplateName +":" + iBOAlmWorkflowValues[0].getTemplateName() + ",");
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);	
				throw new Exception(sb.toString());
			}
		}
		
		if(ConstDefine.VM_TEMPLATE_TYPE.equals(iBOAlmWorkflowTemplateValues[0].getTemplateType())){
			HashMap aVars =  (HashMap)ComframeClient.getDefaultComframeClient().getWorkflowVars(workorders[0].getWorkflowId());
			aVars = commonFun.analyzeCond(aVars, cond);
			ComframeClient.getDefaultComframeClient().setWorkflowVars(workorders[0].getWorkflowId(), aVars);
			if(ConstDefine.LINK_NO_TYPE_USER.equals(iBOAlmWorkflowValues[0].getLinkNoType())){
				workorders[0].setResult(result);
				workorders[0].setOpinion(reason);
				workorders[0].setCond(cond);
				BusiFactory.getAlmWorkorderSV().saveAlmWorkorder(workorders);
				ComframeClient.getDefaultComframeClient().finishUserTask(workorders[0].getVmTaskId(),String.valueOf(workorders[0].getExecStaffId()), "", null, null);
			}else if(ConstDefine.LINK_NO_TYPE_SIGN.equals(iBOAlmWorkflowValues[0].getLinkNoType())){
				
				//会签VM子任务回单
				sql = new Criteria();
				sql.addEqual(TaskInfo.S_WorkflowId, workorders[0].getWorkflowId());
				sql.addEqual(TaskInfo.S_ParentTaskId, workorders[0].getParentVmTaskId());
				sql.addEqual(TaskInfo.S_TaskStaffId, String.valueOf(workorders[0].getExecStaffId()));
				sql.addEqual(TaskInfo.S_TaskTag, workorders[0].getLinkNo());
				TaskInfo[] taskInfos = ComframeClient.getDefaultComframeClient().getTaskAllInfos(sql.toString(), sql.getParameters(), -1, -1);
				if(taskInfos.length != 1){
					if (log.isErrorEnabled()) {
						StringBuffer sb = new StringBuffer();
						sb.append("查找到业务工单关联的VM会签子任务单数量不为1,查询表：VM_TASK&VM_TASK_TRANS；查询条件为【");
						sb.append(TaskInfo.S_WorkflowId +":" + workorders[0].getWorkflowId() + ",");
						sb.append(TaskInfo.S_ParentTaskId +":" + workorders[0].getParentVmTaskId() + ",");
						sb.append(TaskInfo.S_TaskStaffId +":" + String.valueOf(workorders[0].getExecStaffId()) + ",");
						sb.append(TaskInfo.S_TaskTag +":" + workorders[0].getLinkNo());
						sb.append("】");
						sb.append("SQL:" + sql.toString());
						log.error(sb);	
						throw new Exception(sb.toString());
					}
				}
				TaskInfo taskInfo = ComframeClient.getDefaultComframeClient().getTaskInfo(taskInfos[0].getTaskId());
				ComframeClient.getDefaultComframeClient().finishUserTask(taskInfo.getTaskId(),String.valueOf(workorders[0].getExecStaffId()) , workorders[0].getResult(), null, null);
				
				//会签业务系统工单回单
				workorders[0].setVmTaskId(taskInfo.getTaskId());
				workorders[0].setIsCurrentTask(ConstDefine.IS_NOT_CURRENT_TASK);
				workorders[0].setStatus(ConstDefine.WO_STATUS_COMPLETE);
				workorders[0].setExecTimes(workorders[0].getExecTimes() + ServiceManager.getOpDateTime().getTime() - workorders[0].getExecTime().getTime());
				workorders[0].setFinishTime(ServiceManager.getOpDateTime());
				workorders[0].setResult(result);
				workorders[0].setOpinion(reason);
				BusiFactory.getAlmWorkorderSV().saveAlmWorkorder(workorders);
				if(BusiObjUpdate != null){
					BusiObjUpdate.extraMethod(workorders[0].getOrderId(), String.valueOf(workorders[0].getObjId()), String.valueOf(workorders[0].getObjType()),"signRearTask");
				}
				//判断会签环节子工单是否都完成，如都完成将业务系统会签主工单状态修改为已完成
				sql = new Criteria();
				sql.addNotEqual(IBOAlmWorkorderValue.S_ParentOrderId, ConstDefine.WO_NO_PARENT);
				sql.addEqual(IBOAlmWorkorderValue.S_LinkId, workorders[0].getLinkId());
				sql.addEqual(IBOAlmWorkorderValue.S_LinkNo, workorders[0].getLinkNo());
				sql.addEqual(IBOAlmWorkorderValue.S_ObjId, workorders[0].getObjId());
				sql.addEqual(IBOAlmWorkorderValue.S_ObjType, workorders[0].getObjType());
				sql.addEqual(IBOAlmWorkorderValue.S_OrderType, workorders[0].getOrderType());
				sql.addNotEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_COMPLETE);
				IBOAlmWorkorderValue[] signWorkorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
				if(signWorkorders.length!=0){
					return false;
				}
				else{
					sql = new Criteria();
					sql.addEqual(IBOAlmWorkorderValue.S_ParentOrderId, ConstDefine.WO_NO_PARENT);
					sql.addEqual(IBOAlmWorkorderValue.S_LinkId, workorders[0].getLinkId());
					sql.addEqual(IBOAlmWorkorderValue.S_LinkNo, workorders[0].getLinkNo());
					sql.addEqual(IBOAlmWorkorderValue.S_ObjId, workorders[0].getObjId());
					sql.addEqual(IBOAlmWorkorderValue.S_ObjType, workorders[0].getObjType());
					sql.addEqual(IBOAlmWorkorderValue.S_OrderType, workorders[0].getOrderType());
					sql.addNotEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_COMPLETE);
					IBOAlmWorkorderValue[] signParentWorkorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
					if(signParentWorkorders.length != 1){
						if (log.isErrorEnabled()) {
							StringBuffer sb = new StringBuffer();
							sb.append("查找业务系统会签主工单数量不为1，查询条件为【");
							sb.append(IBOAlmWorkorderValue.S_ParentOrderId +":" + ConstDefine.WO_NO_PARENT + ",");
							sb.append(IBOAlmWorkorderValue.S_LinkId +":" + workorders[0].getLinkId() + ",");
							sb.append(IBOAlmWorkorderValue.S_LinkNo +":" + workorders[0].getLinkNo() + ",");
							sb.append(IBOAlmWorkorderValue.S_ObjId +":" + workorders[0].getObjId() + ",");
							sb.append(IBOAlmWorkorderValue.S_ObjType +":" + workorders[0].getObjType() + ",");
							sb.append(IBOAlmWorkorderValue.S_OrderType +":" + workorders[0].getOrderType() + ",");
							sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_COMPLETE + ",");
							sb.append("】");
							sb.append("SQL:" + sql.toString());
							log.error(sb);
							throw new Exception(sb.toString());
						}
					}
					signParentWorkorders[0].setStatus(ConstDefine.WO_STATUS_COMPLETE);
					signParentWorkorders[0].setFinishTime(ServiceManager.getOpDateTime());
					signParentWorkorders[0].setExecTimes(ServiceManager.getOpDateTime().getTime() - signParentWorkorders[0].getCreateTime().getTime());
					signParentWorkorders[0].setCond(cond);
					BusiFactory.getAlmWorkorderSV().saveAlmWorkorder(signParentWorkorders);
				}
			}
		}else{
			//处理矩阵流程工单回单
			
			workorders[0].setResult(result);
			workorders[0].setOpinion(reason);
			workorders[0].setCond(cond);
			workorders[0].setStatus(ConstDefine.WO_STATUS_COMPLETE);
			workorders[0].setFinishTime(ServiceManager.getOpDateTime());
			if(ConstDefine.LINK_NO_TYPE_SIGN.equals(workorders[0].getLinkNoType()) && workorders[0].getParentOrderId()!=ConstDefine.WO_NO_PARENT){
				workorders[0].setIsCurrentTask(ConstDefine.IS_NOT_CURRENT_TASK);
			}
			BusiFactory.getAlmWorkorderSV().saveAlmWorkorder(workorders);
			
			if(ConstDefine.LINK_NO_TYPE_SIGN.equals(workorders[0].getLinkNoType())){
				//判断会签所有子工单是否处理完				
				sql = new Criteria();
				sql.addEqual(IBOAlmWorkorderValue.S_ParentOrderId, workorders[0].getParentOrderId());
				sql.addEqual(IBOAlmWorkorderValue.S_LinkId, workorders[0].getLinkId());
				sql.addEqual(IBOAlmWorkorderValue.S_LinkNo, workorders[0].getLinkNo());
				sql.addEqual(IBOAlmWorkorderValue.S_ObjId, workorders[0].getObjId());
				sql.addEqual(IBOAlmWorkorderValue.S_ObjType, workorders[0].getObjType());
				sql.addEqual(IBOAlmWorkorderValue.S_OrderType, workorders[0].getOrderType());
				sql.addNotEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_COMPLETE);
				IBOAlmWorkorderValue[] signChildrenNoFinishWorkorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
				if(signChildrenNoFinishWorkorders.length == 0){
					sql = new Criteria();
					sql.addEqual(IBOAlmWorkorderValue.S_OrderId, workorders[0].getParentOrderId());
					sql.addEqual(IBOAlmWorkorderValue.S_LinkId, workorders[0].getLinkId());
					sql.addEqual(IBOAlmWorkorderValue.S_LinkNo, workorders[0].getLinkNo());
					sql.addEqual(IBOAlmWorkorderValue.S_ObjId, workorders[0].getObjId());
					sql.addEqual(IBOAlmWorkorderValue.S_ObjType, workorders[0].getObjType());
					sql.addEqual(IBOAlmWorkorderValue.S_OrderType, workorders[0].getOrderType());
					sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_RECEIVE);
					IBOAlmWorkorderValue[] signParentWorkorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
					if(signParentWorkorders.length != 1){
						if (log.isErrorEnabled()) {
							StringBuffer sb = new StringBuffer();
							sb.append("查找业务系统会签主工单数量不为1，查询条件为【");
							sb.append(IBOAlmWorkorderValue.S_OrderId +":" + workorders[0].getParentOrderId() + ",");
							sb.append(IBOAlmWorkorderValue.S_LinkId +":" + workorders[0].getLinkId() + ",");
							sb.append(IBOAlmWorkorderValue.S_LinkNo +":" + workorders[0].getLinkNo() + ",");
							sb.append(IBOAlmWorkorderValue.S_ObjId +":" + workorders[0].getObjId() + ",");
							sb.append(IBOAlmWorkorderValue.S_ObjType +":" + workorders[0].getObjType() + ",");
							sb.append(IBOAlmWorkorderValue.S_OrderType +":" + workorders[0].getOrderType() + ",");
							sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_RECEIVE + ",");
							sb.append("】");
							sb.append("SQL:" + sql.toString());
							log.error(sb);
							throw new Exception(sb.toString());
						}
					}
					signParentWorkorders[0].setCond(cond);
					signParentWorkorders[0].setStatus(ConstDefine.WO_STATUS_COMPLETE);
					signParentWorkorders[0].setFinishTime(ServiceManager.getOpDateTime());
					BusiFactory.getAlmWorkorderSV().saveAlmWorkorder(signParentWorkorders);
					//修改ALM_SCHEDULE调度表状态
					sql = new Criteria();
					sql.addEqual(IBOScheduleValue.S_WorkflowId, workorders[0].getWorkflowId());
					IBOScheduleValue[] schedules = BusiFactory.getAlmScheduleSV().getScheduleByCondition(sql.toString(), sql.getParameters());
					if(schedules.length != 1){
						if (log.isErrorEnabled()) {
							StringBuffer sb = new StringBuffer();
							sb.append("未找到相应的调度队列，查询条件为【");
							sb.append(IBOScheduleValue.S_WorkflowId +":" + workorders[0].getWorkflowId());
							sb.append("】");
							sb.append("SQL:" + sql.toString());
							log.error(sb);
							throw new Exception(sb.toString());
						}
					}
					schedules[0].setState(ConstDefine.WO_SCHEDULE_STATUS_WAIT);
					BusiFactory.getAlmScheduleSV().saveSchedule(schedules);
				}
				
				
			}
			if(ConstDefine.LINK_NO_TYPE_USER.equals(workorders[0].getLinkNoType())){
				//修改ALM_SCHEDULE调度表状态
				sql = new Criteria();
				sql.addEqual(IBOScheduleValue.S_WorkflowId, workorders[0].getWorkflowId());
				IBOScheduleValue[] schedules = BusiFactory.getAlmScheduleSV().getScheduleByCondition(sql.toString(), sql.getParameters());
				if(schedules.length != 1){
					if (log.isErrorEnabled()) {
						StringBuffer sb = new StringBuffer();
						sb.append("未找到相应的调度队列，查询条件为【");
						sb.append(IBOScheduleValue.S_WorkflowId +":" + workorders[0].getWorkflowId());
						sb.append("】");
						sb.append("SQL:" + sql.toString());
						log.error(sb);
						throw new Exception(sb.toString());
					}
				}
				schedules[0].setState(ConstDefine.WO_SCHEDULE_STATUS_WAIT);
				BusiFactory.getAlmScheduleSV().saveSchedule(schedules);
			}
		}
		//调研驱动函数	
		this.drivFun(workorders[0]);
		
		return false;
	}
	
	/**
	 * 驱动函数,一般不需调用
	 * @param workorder
	 * @throws Exception
	 */
	private void drivFun(IBOAlmWorkorderValue workorder) throws Exception{
		//2.将DRIVPOINT作为参数传入 执行DRIVPOINT_FUN指定方法 判断关联流程是否可以进行回单操作 注意处理因为流程嵌套导致的递归回单		
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_OrderId, workorder.getOrderId());
		sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_COMPLETE);
		IBOAlmWorkorderValue[] workorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(workorders.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("查找业务系统工单数量不为1，查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_OrderId +":" + workorder.getOrderId() + ",");
				sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_COMPLETE);
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		if(ConstDefine.LINK_NO_TYPE_USER.equals(workorders[0].getLinkNoType())){
			
		}
		//工单为会签工单
		if(ConstDefine.LINK_NO_TYPE_SIGN.equals(workorders[0].getLinkNoType())){
			sql = new Criteria();
			sql.addEqual(IBOAlmWorkorderValue.S_OrderId, workorder.getParentOrderId());
			sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_COMPLETE);
			workorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
			if(workorders.length == 0){
				return;
			}
			if(workorders.length > 1){
				if (log.isErrorEnabled()) {
					StringBuffer sb = new StringBuffer();
					sb.append("查找业务系统会签主工单数量不为1，查询条件为【");
					sb.append(IBOAlmWorkorderValue.S_OrderId +":" + workorders[0].getParentOrderId() + ",");
					sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_RECEIVE);
					sb.append("】");
					sb.append("SQL:" + sql.toString());
					log.error(sb);
					throw new Exception(sb.toString());
				}
			}
		}
		IBOTopoViewValue[] topoViewValues = BusiFactory.getAlmTopoViewSV().getTopoByFpointAndCond(String.valueOf(workorders[0].getLinkId()),workorders[0].getCond());
		if(topoViewValues!=null&&topoViewValues.length==1)
			if(topoViewValues[0].getDrivnos()!=null&&!"".equals(topoViewValues[0].getDrivnos().trim())){
				String[] drivnos = topoViewValues[0].getDrivnos().trim().split(",");
				for(String drivno : drivnos){
					String fun = topoViewValues[0].getDrivnoFun();
					int endIndex = fun.lastIndexOf(".");
					String serviceId = fun.substring(0, endIndex);
					String methodName = fun.substring(endIndex+1);
					Object funCase = ServiceFactory.getService(serviceId);
					Class funClass = funCase.getClass();
					//fun中参数列表业务对象ID:obj_id、obj_type、topoNo
					Class[] parameterTypes = {Long.class,String.class,String.class,String.class};
					Object[] parameterValues = {workorders[0].getObjId(),workorders[0].getObjType(),topoViewValues[0].getNo(),drivno};
					Method method = funClass.getMethod(methodName, parameterTypes);
					//返回值关联调度流程工单集合 如果返回值为null表示没有找到关联调度工单
					IBOAlmWorkorderValue[] linkWorkorders = (IBOAlmWorkorderValue[])method.invoke(funCase, parameterValues);
					if(linkWorkorders!=null)
						for(IBOAlmWorkorderValue linkWorkorder : linkWorkorders){
							//执行关联流程回单操作
							sql = new Criteria();
							sql.addEqual(IBOTopoViewValue.S_No, drivno);
							IBOTopoViewValue[] linkTopoViewValues = BusiFactory.getAlmTopoViewSV().getTopoByCondition(sql.toString(), sql.getParameters());
							if("".equals(linkWorkorder.getCond()) || null == linkWorkorder.getCond() ){
								this.finishUserTask(linkWorkorder.getOrderId(),"DRIV_WF", "", linkTopoViewValues[0].getCond());
							}else{
								this.finishUserTask(linkWorkorder.getOrderId(),"DRIV_WF", "", linkWorkorder.getCond());
							}
						}
				}
			}
	}
	
	/**
	 * 创建需求保存需求创建的工单，在创建需求时先调用该函数再调用createWorkflow函数
	 * @param objId
	 * @param objType
	 * @param templateName
	 * @param cond
	 * @param opinion
	 * @return
	 * @throws Exception
	 */
	public long createStartSaveOrder(String objId,String objType,String templateName,String cond,String opinion) throws Exception {
		
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowTemplateValue.S_TemplateName, templateName);
		IBOAlmWorkflowTemplateValue[] iBOAlmWorkflowTemplateValues =iAlmWorkflowTemplateSV.getAlmWorkflowTemplateByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowTemplateValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一模板编号查询到不唯一的配置信息,查询表：ALM_WORKFLOW_TEMPLATE；查询条件为【");
				sb.append(IBOAlmWorkflowTemplateValue.S_TemplateName +":" + templateName);
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);	
				throw new Exception(sb.toString());
			}
		}
		sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowValue.S_TemplateName, templateName);
		sql.addEqual(IBOAlmWorkflowValue.S_LinkNoType, ConstDefine.LINK_NO_TYPE_MGR);
		IBOAlmWorkflowValue[] iBOAlmWorkflowValues =  iAlmWorkflowSV.getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一环节查询到不唯一的配置信息,查询表：ALM_WORKFLOW；查询条件为【");
				sb.append(IBOAlmWorkflowValue.S_TemplateName +":" + templateName + ",");
				sb.append(IBOAlmWorkflowValue.S_LinkNoType + ":" + ConstDefine.LINK_NO_TYPE_MGR);
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);	
				throw new Exception(sb.toString());
			}
		}
		sql = new Criteria();
		sql.addEqual(IBOAlmStakeholderValue.S_TemplateId, iBOAlmWorkflowTemplateValues[0].getTemplateId());
		sql.addEqual(IBOAlmStakeholderValue.S_LinkId, iBOAlmWorkflowValues[0].getLinkId());
		sql.addEqual(IBOAlmStakeholderValue.S_LinkNo, iBOAlmWorkflowValues[0].getLinkNo());
		sql.addEqual(IBOAlmStakeholderValue.S_ObjId, Long.parseLong(objId));
		sql.addEqual(IBOAlmStakeholderValue.S_ObjType, Long.parseLong(objType));
		sql.addEqual(IBOAlmStakeholderValue.S_StdholdeType, ConstDefine.STAKEHOLDERTYPE_WF);
		IBOAlmStakeholderValue[] iBOStakeholders = iAlmStakeholderSV.getStakeholderByCondition(sql.toString(), sql.getParameters());
		if(iBOStakeholders.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("人工前置任务查询当前环节干系人出错,干系人查询结果不唯一或未查到干系人；查询条件为【");
				sb.append(IBOAlmStakeholderValue.S_TemplateId +":" + iBOAlmWorkflowTemplateValues[0].getTemplateId() + ",");
				sb.append(IBOAlmStakeholderValue.S_LinkId +":" + iBOAlmWorkflowValues[0].getLinkId() + ",");
				sb.append(IBOAlmStakeholderValue.S_LinkNo +":" + iBOAlmWorkflowValues[0].getLinkNo() + ",");
				sb.append(IBOAlmStakeholderValue.S_ObjId +":" + Long.parseLong(objId) + ",");
				sb.append(IBOAlmStakeholderValue.S_ObjType +":" + Long.parseLong(objType) + ",");
				sb.append(IBOAlmStakeholderValue.S_StdholdeType + ":" + ConstDefine.STAKEHOLDERTYPE_WF);
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_ObjId, objId);
		sql.addEqual(IBOAlmWorkorderValue.S_ObjType, objType);
		sql.addEqual(IBOAlmWorkorderValue.S_LinkNoType, ConstDefine.LINK_NO_TYPE_MGR);
		sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_RECEIVE);
		IBOAlmWorkorderValue iWorkOrderValue = null;
		IBOAlmWorkorderValue[] iWorkOrders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(iWorkOrders.length==0){
			iWorkOrderValue = new BOAlmWorkorderBean();
			iWorkOrderValue.setWorkflowId(ConstDefine.WO_NO_WORKFLOW_ID);
			iWorkOrderValue.setParentOrderId(ConstDefine.WO_NO_PARENT);
			iWorkOrderValue.setLastOrderId(ConstDefine.WO_NO_LASTORDER_ID);	
			iWorkOrderValue.setVmTaskId(ConstDefine.WO_NO_VM_TASK_ID);
			iWorkOrderValue.setParentVmTaskId(ConstDefine.WO_NO_PARENT_VM_TASK_ID);
			iWorkOrderValue.setLastVmTaskId(ConstDefine.WO_NO_LAST_VM_TASK_ID);
			iWorkOrderValue.setLinkId(iBOAlmWorkflowValues[0].getLinkId());
			iWorkOrderValue.setLinkNo(iBOAlmWorkflowValues[0].getLinkNo());
			iWorkOrderValue.setLinkNoType(ConstDefine.LINK_NO_TYPE_MGR);
			iWorkOrderValue.setIsCurrentTask(ConstDefine.IS_CURRENT_TASK);
			iWorkOrderValue.setOrderType(ConstDefine.STAKEHOLDERTYPE_WF);
			iWorkOrderValue.setObjId(Long.parseLong(objId));
			iWorkOrderValue.setObjType(objType);
			iWorkOrderValue.setDealType(ConstDefine.WO_DEAL_TYPE_APPROVE);
			iWorkOrderValue.setIsLock(ConstDefine.NO_LOCK);
			iWorkOrderValue.setFinishPrint(ConstDefine.NOT_NEED_PRINT);
			iWorkOrderValue.setExecRoleId(iBOStakeholders[0].getRoleId());
			iWorkOrderValue.setExecRoleCode(iBOStakeholders[0].getRoleCode());
			iWorkOrderValue.setExecStaffId(iBOStakeholders[0].getStdholderStaffId());
			iWorkOrderValue.setExecStaffNo(iBOStakeholders[0].getStdholderStaffNo());
			//***
			//工单加锁代码 为解决
			//****
			iWorkOrderValue.setResult(ConstDefine.WO_APPROVAL_RESULT_PASS);
			iWorkOrderValue.setCond(cond);
			iWorkOrderValue.setOpinion(opinion);
			iWorkOrderValue.setStatus(ConstDefine.WO_STATUS_RECEIVE);
			iWorkOrderValue.setCreateTime(ServiceManager.getOpDateTime());
			iWorkOrderValue.setRecvTime(ServiceManager.getOpDateTime());
			iWorkOrderValue.setExecTime(ServiceManager.getOpDateTime());
		}
		else if(iWorkOrders.length==1)
		{
			iWorkOrderValue = iWorkOrders[0];
			iWorkOrderValue.setCond(cond);
			iWorkOrderValue.setOpinion(opinion);
		}
		else
			throw new Exception("生成第一条工单错误，查询到的工单大于1");
		IBOAlmWorkorderValue[] iBOAlmWorkorderValues =	{iWorkOrderValue};
		iAlmWorkorderSV.saveAlmWorkorder(iBOAlmWorkorderValues);
		//将干系人信息移到干系人历史表中
		iAlmHisStakeholderSV.copyHisStakeholderByStakeholder(iWorkOrderValue, iBOStakeholders[0]);
		//更业务对象的阶段和状态
		if(BusiObjUpdate != null){
			BusiObjUpdate.updateObjCurPhaseAndCurStatus(objId,objType,String.valueOf(iBOAlmWorkflowValues[0].getLinkId()));
		}
		return iWorkOrderValue.getOrderId();
	}
	
	/**
	 * 此函数用于与将工作流无直接关联的其他工单从工单表中移到工单历史表中
	 * @param workorder
	 * @throws Exception
	 */
	public void cutAlmWorkOrderToAlmHisWorkOrder(IBOAlmWorkorderValue workorder) throws Exception{
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_OrderId, workorder.getOrderId());
		sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_COMPLETE);
		IBOAlmWorkorderValue[] workorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(workorders.length == 0){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("查找业务系统工单数量为0，当前工单状态未完成。查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_OrderId +":" + workorders[0].getOrderId() + ",");
				sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_COMPLETE);
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		iAlmHisWorkorderSV.capyHisWorkorderByWorkorder(workorders[0]);
		workorders[0].delete();
		iAlmWorkorderSV.saveAlmWorkorder(workorders);
		
	}
	
	/**
	 * 为工单加锁
	 * @param orderId
	 * @param iBOAlmStakeholderValue
	 * @param lockOption
	 * @throws Exception
	 */
	public void lockWO(long orderId, IBOAlmStakeholderValue iBOAlmStakeholderValue,String lockOption) throws Exception{
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_OrderId, orderId);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
		sql.addEqual(IBOAlmWorkorderValue.S_IsCurrentTask, ConstDefine.IS_CURRENT_TASK);
		List<String> statusList = new ArrayList<String>();
		statusList.add(ConstDefine.WO_STATUS_RECEIVE);
		statusList.add(ConstDefine.WO_STATUS_CREATE);
		sql.addIn(IBOAlmWorkorderValue.S_Status, statusList);
		IBOAlmWorkorderValue[] iWorkOrderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(iWorkOrderValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("查询未完成工单数量不唯一；查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_OrderId +":" + orderId + ",");
				sb.append(IBOAlmWorkorderValue.S_OrderType +":" +  ConstDefine.STAKEHOLDERTYPE_WF + ",");
				sb.append(IBOAlmWorkorderValue.S_IsCurrentTask +":" + ConstDefine.IS_CURRENT_TASK + ",");
				sb.append(IBOAlmWorkorderValue.S_Status +":(" + ConstDefine.WO_STATUS_RECEIVE+","+ConstDefine.WO_STATUS_CREATE + "),");
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		iWorkOrderValues[0].setIsLock(ConstDefine.LOCK);
		iWorkOrderValues[0].setStatus(ConstDefine.WO_STATUS_LOCK);
		iWorkOrderValues[0].setLockStaffId(iBOAlmStakeholderValue.getStdholderStaffId());
		iWorkOrderValues[0].setLockStaffNo(iBOAlmStakeholderValue.getStdholderStaffNo());
		iWorkOrderValues[0].setLockOpinion(lockOption);
		iWorkOrderValues[0].setLockTime(ServiceManager.getOpDateTime());
		if(iWorkOrderValues[0].getFinishPrint() == ConstDefine.NO_FINISH_PRINT){
			//不做处理
		}else if(iWorkOrderValues[0].getFinishPrint() == ConstDefine.FINISH_PRINT){
			iWorkOrderValues[0].setExecTimes(iWorkOrderValues[0].getExecTimes() + ServiceManager.getOpDateTime().getTime() - iWorkOrderValues[0].getExecTime().getTime());
			iWorkOrderValues[0].setExecTime(null);
		}else if(iWorkOrderValues[0].getFinishPrint() == ConstDefine.NOT_NEED_PRINT){
			iWorkOrderValues[0].setExecTimes(iWorkOrderValues[0].getExecTimes() + ServiceManager.getOpDateTime().getTime() - iWorkOrderValues[0].getExecTime().getTime());
			iWorkOrderValues[0].setExecTime(null);
		}
		iAlmWorkorderSV.saveAlmWorkorder(iWorkOrderValues);
		//将加锁的干系人信息保存到历史表中
		iAlmHisStakeholderSV.copyHisStakeholderByStakeholder(iWorkOrderValues[0], iBOAlmStakeholderValue);
	}
	
	/**
	 * 为工单解锁
	 * @param orderId
	 * @throws Exception
	 */
	public void clearLockWo(long orderId) throws Exception{
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_OrderId, orderId);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
		sql.addEqual(IBOAlmWorkorderValue.S_IsCurrentTask, ConstDefine.IS_CURRENT_TASK);
		sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_LOCK);
		IBOAlmWorkorderValue[] iWorkOrderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(iWorkOrderValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("查询未完成工单数量不唯一；查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_OrderId +":" + orderId + ",");
				sb.append(IBOAlmWorkorderValue.S_OrderType +":" +  ConstDefine.STAKEHOLDERTYPE_WF + ",");
				sb.append(IBOAlmWorkorderValue.S_IsCurrentTask +":" + ConstDefine.IS_CURRENT_TASK + ",");
				sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_LOCK + ",");
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		iWorkOrderValues[0].setIsLock(ConstDefine.NO_LOCK);
		if(ConstDefine.NO_FINISH_PRINT == iWorkOrderValues[0].getFinishPrint()){
			iWorkOrderValues[0].setStatus(ConstDefine.WO_STATUS_CREATE);
		}else if(ConstDefine.FINISH_PRINT == iWorkOrderValues[0].getFinishPrint()){
			iWorkOrderValues[0].setStatus(ConstDefine.WO_STATUS_RECEIVE);
			iWorkOrderValues[0].setExecTime(ServiceManager.getOpDateTime());
		}else if(ConstDefine.NOT_NEED_PRINT == iWorkOrderValues[0].getFinishPrint()){
			iWorkOrderValues[0].setStatus(ConstDefine.WO_STATUS_RECEIVE);
			iWorkOrderValues[0].setExecTime(ServiceManager.getOpDateTime());
		}
		iWorkOrderValues[0].setRealseLockTime(ServiceManager.getOpDateTime());
		iWorkOrderValues[0].setLockTimes(iWorkOrderValues[0].getLockTimes() + ServiceManager.getOpDateTime().getTime() - iWorkOrderValues[0].getLockTime().getTime());
		iAlmWorkorderSV.saveAlmWorkorder(iWorkOrderValues);
	}
	
	
	
	/**
	 * 为流程无关工单加锁
	 * @param orderId
	 * @param iBOAlmStakeholderValue
	 * @param lockOption
	 * @throws Exception
	 */
	public void lockNoWFWo(long orderId, String orderType, IBOAlmStakeholderValue iBOAlmStakeholderValue,String lockOption) throws Exception{
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_OrderId, orderId);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, orderType);
		sql.addEqual(IBOAlmWorkorderValue.S_IsCurrentTask, ConstDefine.IS_NOT_CURRENT_TASK);
		sql.addEqual(IBOAlmWorkorderValue.S_IsLock, ConstDefine.NO_LOCK);
		List<String> statusList = new ArrayList<String>();
		statusList.add(ConstDefine.WO_STATUS_RECEIVE);
		sql.addIn(IBOAlmWorkorderValue.S_Status, statusList);
		IBOAlmWorkorderValue[] iWorkOrderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(iWorkOrderValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("查询未完成工单数量不唯一；查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_OrderId +":" + orderId + ",");
				sb.append(IBOAlmWorkorderValue.S_OrderType +":" +  orderType + ",");
				sb.append(IBOAlmWorkorderValue.S_IsCurrentTask +":" + ConstDefine.IS_NOT_CURRENT_TASK + ",");
				sb.append(IBOAlmWorkorderValue.S_Status +":(" + ConstDefine.WO_STATUS_RECEIVE + "),");
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		iWorkOrderValues[0].setIsLock(ConstDefine.LOCK);
		iWorkOrderValues[0].setStatus(ConstDefine.WO_STATUS_LOCK);
		iWorkOrderValues[0].setLockStaffId(iBOAlmStakeholderValue.getStdholderStaffId());
		iWorkOrderValues[0].setLockStaffNo(iBOAlmStakeholderValue.getStdholderStaffNo());
		iWorkOrderValues[0].setLockOpinion(lockOption);
		iWorkOrderValues[0].setLockTime(ServiceManager.getOpDateTime());
		if(iWorkOrderValues[0].getFinishPrint() == ConstDefine.NO_FINISH_PRINT){
			//不做处理
		}else if(iWorkOrderValues[0].getFinishPrint() == ConstDefine.FINISH_PRINT){
			iWorkOrderValues[0].setExecTimes(iWorkOrderValues[0].getExecTimes() + ServiceManager.getOpDateTime().getTime() - iWorkOrderValues[0].getExecTime().getTime());
			iWorkOrderValues[0].setExecTime(null);
		}else if(iWorkOrderValues[0].getFinishPrint() == ConstDefine.NOT_NEED_PRINT){
			iWorkOrderValues[0].setExecTimes(iWorkOrderValues[0].getExecTimes() + ServiceManager.getOpDateTime().getTime() - iWorkOrderValues[0].getExecTime().getTime());
			iWorkOrderValues[0].setExecTime(null);
		}
		iAlmWorkorderSV.saveAlmWorkorder(iWorkOrderValues);
		//将加锁的干系人信息保存到历史表中
		iAlmHisStakeholderSV.copyHisStakeholderByStakeholder(iWorkOrderValues[0], iBOAlmStakeholderValue);
	}
	
	/**
	 * 为流程无关工单解锁
	 * @param orderId
	 * @throws Exception
	 */
	public void clearLockNoWFWo(long orderId, String orderType) throws Exception{
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_OrderId, orderId);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, orderType);
		sql.addEqual(IBOAlmWorkorderValue.S_IsCurrentTask, ConstDefine.IS_NOT_CURRENT_TASK);
		sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_LOCK);
		IBOAlmWorkorderValue[] iWorkOrderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(iWorkOrderValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("查询未完成工单数量不唯一；查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_OrderId +":" + orderId + ",");
				sb.append(IBOAlmWorkorderValue.S_OrderType +":" +  orderType + ",");
				sb.append(IBOAlmWorkorderValue.S_IsCurrentTask +":" + ConstDefine.IS_NOT_CURRENT_TASK + ",");
				sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_LOCK + ",");
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		iWorkOrderValues[0].setIsLock(ConstDefine.NO_LOCK);
		if(ConstDefine.NO_FINISH_PRINT == iWorkOrderValues[0].getFinishPrint()){
			iWorkOrderValues[0].setStatus(ConstDefine.WO_STATUS_CREATE);
		}else if(ConstDefine.FINISH_PRINT == iWorkOrderValues[0].getFinishPrint()){
			iWorkOrderValues[0].setStatus(ConstDefine.WO_STATUS_RECEIVE);
			iWorkOrderValues[0].setExecTime(ServiceManager.getOpDateTime());
		}else if(ConstDefine.NOT_NEED_PRINT == iWorkOrderValues[0].getFinishPrint()){
			iWorkOrderValues[0].setStatus(ConstDefine.WO_STATUS_RECEIVE);
			iWorkOrderValues[0].setExecTime(ServiceManager.getOpDateTime());
		}
		iWorkOrderValues[0].setRealseLockTime(ServiceManager.getOpDateTime());
		iWorkOrderValues[0].setLockTimes(iWorkOrderValues[0].getLockTimes() + ServiceManager.getOpDateTime().getTime() - iWorkOrderValues[0].getLockTime().getTime());
		iAlmWorkorderSV.saveAlmWorkorder(iWorkOrderValues);
	}
	
	/**
	 * 创建通知&抄送工单
	 * @param orderId
	 * @param iBOAlmStakeholderValue
	 * @throws Exception
	 */
	public void newNoticeWo(long orderId, IBOAlmStakeholderValue iBOAlmStakeholderValue) throws Exception{
		this.newNoWFWo( orderId,  ConstDefine.STAKEHOLDERTYPE_NOTICE, iBOAlmStakeholderValue);
	}
	
	/**
	 * 关闭通知&抄送工单
	 * @param orderId
	 * @throws Exception
	 */
	public void finishNoticeWo(long orderId) throws Exception{
		this.finishNoWFWo(orderId, ConstDefine.STAKEHOLDERTYPE_NOTICE);
	}
	
	/**
	 * 创建讨论工单
	 * @param orderId
	 * @param iBOAlmStakeholderValue
	 * @throws Exception
	 */
	public void newDiscussWo(long orderId, IBOAlmStakeholderValue iBOAlmStakeholderValue) throws Exception{
		this.newNoWFWo( orderId,  ConstDefine.STAKEHOLDERTYPE_DISCUSS, iBOAlmStakeholderValue);
	}
	
	/**
	 * 关闭讨论工单
	 * @param orderId
	 * @throws Exception
	 */
	public void finishDiscussWo(long orderId) throws Exception{
		this.finishNoWFWo(orderId, ConstDefine.STAKEHOLDERTYPE_DISCUSS);
	}
	
	/**
	 * 创建与工作流无关的工单 比如 通知、抄送、讨论等
	 * @param orderId
	 * @param orderType
	 * @param iBOAlmStakeholderValue
	 * @throws Exception
	 */
	public void newNoWFWo(long orderId, String orderType, IBOAlmStakeholderValue iBOAlmStakeholderValue) throws Exception{
		if(!orderType.equals(iBOAlmStakeholderValue.getStdholdeType())){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("干系人 字段"+iBOAlmStakeholderValue.S_StdholdeType+"取值为"+orderType);
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_OrderId, orderId);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
		sql.addEqual(IBOAlmWorkorderValue.S_IsCurrentTask, ConstDefine.IS_CURRENT_TASK);
		sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_RECEIVE);
		IBOAlmWorkorderValue[] iWorkOrderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(iWorkOrderValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("查询未完成工单数量不唯一；查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_OrderId +":" + orderId + ",");
				sb.append(IBOAlmWorkorderValue.S_OrderType +":" +  ConstDefine.STAKEHOLDERTYPE_WF + ",");
				sb.append(IBOAlmWorkorderValue.S_IsCurrentTask +":" + ConstDefine.IS_CURRENT_TASK + ",");
				sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_RECEIVE + ",");
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		IBOAlmWorkorderValue iWorkOrderValue = new BOAlmWorkorderBean();
		iWorkOrderValue.setWorkflowId(ConstDefine.WO_NO_WORKFLOW_ID);
		iWorkOrderValue.setParentOrderId(iWorkOrderValues[0].getOrderId());
		iWorkOrderValue.setLastOrderId(iWorkOrderValues[0].getOrderId());	
		iWorkOrderValue.setVmTaskId(ConstDefine.WO_NO_VM_TASK_ID);
		iWorkOrderValue.setParentVmTaskId(ConstDefine.WO_NO_PARENT_VM_TASK_ID);
		iWorkOrderValue.setLastVmTaskId(ConstDefine.WO_NO_LAST_VM_TASK_ID);
		iWorkOrderValue.setLinkId(iWorkOrderValues[0].getLinkId());
		iWorkOrderValue.setLinkNo(iWorkOrderValues[0].getLinkNo());
		iWorkOrderValue.setLinkNoType(iWorkOrderValues[0].getLinkNoType());
		iWorkOrderValue.setIsCurrentTask(ConstDefine.IS_NOT_CURRENT_TASK);
		iWorkOrderValue.setOrderType(orderType);
		iWorkOrderValue.setObjId(iWorkOrderValues[0].getObjId());
		iWorkOrderValue.setObjType(iWorkOrderValues[0].getObjType());
		iWorkOrderValue.setDealType(ConstDefine.WO_DEAL_TYPE_APPROVE);
		iWorkOrderValue.setIsLock(ConstDefine.NO_LOCK);
		iWorkOrderValue.setFinishPrint(ConstDefine.NOT_NEED_PRINT);
		iWorkOrderValue.setExecRoleId(iBOAlmStakeholderValue.getRoleId());
		iWorkOrderValue.setExecRoleCode(iBOAlmStakeholderValue.getRoleCode());
		iWorkOrderValue.setExecStaffId(iBOAlmStakeholderValue.getStdholderStaffId());
		iWorkOrderValue.setExecStaffNo(iBOAlmStakeholderValue.getStdholderStaffNo());
		iWorkOrderValue.setStatus(ConstDefine.WO_STATUS_RECEIVE);
		iWorkOrderValue.setCreateTime(ServiceManager.getOpDateTime());
		iWorkOrderValue.setRecvTime(ServiceManager.getOpDateTime());
		iWorkOrderValue.setExecTime(ServiceManager.getOpDateTime());
		IBOAlmWorkorderValue[] iBOAlmWorkorderValues =	{iWorkOrderValue};
		iAlmWorkorderSV.saveAlmWorkorder(iBOAlmWorkorderValues);
		//保存历史干系人
		iAlmHisStakeholderSV.copyHisStakeholderByStakeholder(iWorkOrderValue, iBOAlmStakeholderValue);
	}
	
	/**
	 * 关闭与工作流无关的工单 比如 通知、抄送、讨论等
	 * @param orderId
	 * @param orderType
	 * @throws Exception
	 */
	public void finishNoWFWo(long orderId, String orderType) throws Exception{
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_OrderId, orderId);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, orderType);
		sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_RECEIVE);
		IBOAlmWorkorderValue[] iWorkOrderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(iWorkOrderValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("查询未完成工单数量不唯一；查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_OrderId +":" + orderId + ",");
				sb.append(IBOAlmWorkorderValue.S_OrderType +":" +  orderType + ",");
				sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_RECEIVE + ",");
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		
		
		//删除干系人
		sql = new Criteria();
		sql.addEqual(IBOAlmStakeholderValue.S_LinkId, iWorkOrderValues[0].getLinkId());
		sql.addEqual(IBOAlmStakeholderValue.S_LinkNo, iWorkOrderValues[0].getLinkNo());
		sql.addEqual(IBOAlmStakeholderValue.S_ObjId, iWorkOrderValues[0].getObjId());
		sql.addEqual(IBOAlmStakeholderValue.S_ObjType, iWorkOrderValues[0].getObjType());
		sql.addEqual(IBOAlmStakeholderValue.S_StdholdeType, orderType);
		sql.addEqual(IBOAlmStakeholderValue.S_StdholderStaffId, iWorkOrderValues[0].getExecStaffId());
		IBOAlmStakeholderValue[] iBOStakeholders = iAlmStakeholderSV.getStakeholderByCondition(sql.toString(), sql.getParameters());
		for(IBOAlmStakeholderValue iBOStakeholder :iBOStakeholders){
			iBOStakeholder.delete();
		}
		iAlmStakeholderSV.saveStakeholder(iBOStakeholders);
		
		//修改通知工单状态
		iWorkOrderValues[0].setStatus(ConstDefine.WO_STATUS_COMPLETE);
		iWorkOrderValues[0].setFinishTime(ServiceManager.getOpDateTime());
		iWorkOrderValues[0].setExecTimes(ServiceManager.getOpDateTime().getTime() - iWorkOrderValues[0].getExecTime().getTime());
		iAlmWorkorderSV.saveAlmWorkorder(iWorkOrderValues);
		//将工单信息移到历史表中
		this.cutAlmWorkOrderToAlmHisWorkOrder(iWorkOrderValues[0]);
	}
}
