package com.asiainfo.csc.matrix.common.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.util.criteria.Criteria;
import com.ai.comframe.client.ComframeClient;
import com.ai.comframe.client.TaskInfo;
import com.asiainfo.csc.common.define.IStakeholderType;
import com.asiainfo.csc.matrix.bo.BOAlmStakeholderBean;
import com.asiainfo.csc.matrix.bo.BOAlmWorkorderBean;
import com.asiainfo.csc.matrix.common.AlmMatrixClient;
import com.asiainfo.csc.matrix.common.ConstDefine;
import com.asiainfo.csc.matrix.common.interfaces.IAlmVmTask;
import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowTemplateValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmHisStakeholderSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmHisWorkorderSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmStakeholderSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkflowSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkflowTemplateSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkorderSV;

public abstract class AlmVmTaskImpl implements IAlmVmTask {
	private final static transient Log log = LogFactory.getLog(AlmVmTaskImpl.class);
	IAlmWorkorderSV iAlmWorkorderSV = BusiFactory.getAlmWorkorderSV();
	IAlmHisWorkorderSV iAlmHisWorkorderSV = BusiFactory.getAlmHisWorkorderSV();
	IAlmStakeholderSV iAlmStakeholderSV = BusiFactory.getAlmStakeholderSV();
	IAlmWorkflowSV iAlmWorkflowSV = BusiFactory.getAlmWorkflowSV();
	IAlmWorkflowTemplateSV iAlmWorkflowTemplateSV = BusiFactory.getAlmWorkflowTemplateSV();
	IAlmHisStakeholderSV iAlmHisStakeholderSV = BusiFactory.getAlmHisStakeholderSV();
	
	//人工环节前置任务
	public void userPreTask(long workflowId, String workflowTag, long taskId, String taskTag, String objId, String objType) throws Exception
	{
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowTemplateValue.S_TemplateName, workflowTag);
		IBOAlmWorkflowTemplateValue[] iBOAlmWorkflowTemplateValues =iAlmWorkflowTemplateSV.getAlmWorkflowTemplateByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowTemplateValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一模板编号查询到不唯一的配置信息,查询表：ALM_WORKFLOW_TEMPLATE；查询条件为【");
				sb.append(IBOAlmWorkflowTemplateValue.S_TemplateName +":" + workflowTag + ",");
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);	
				throw new Exception(sb.toString());
			}
		}
		sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowValue.S_TemplateName, workflowTag);
		sql.addEqual(IBOAlmWorkflowValue.S_LinkNo, taskTag);
		IBOAlmWorkflowValue[] iBOAlmWorkflowValues =  iAlmWorkflowSV.getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一环节查询到不唯一的配置信息,查询表：ALM_WORKFLOW；查询条件为【");
				sb.append(IBOAlmWorkflowValue.S_TemplateName +":" + workflowTag + ",");
				sb.append(IBOAlmWorkflowValue.S_LinkNo + ":" + taskTag);
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
		TaskInfo taskInfo = ComframeClient.getDefaultComframeClient().getTaskInfo(taskId);
		IBOAlmWorkorderValue iWorkOrderValue = new BOAlmWorkorderBean();
		iWorkOrderValue.setWorkflowId(workflowId);
		iWorkOrderValue.setParentOrderId(ConstDefine.WO_NO_PARENT);
		//查询上一条工单ID
		IBOAlmWorkorderValue lastWorkorder = null;
		IBOAlmWorkorderValue lastWorkorder1=null;
		lastWorkorder = iAlmWorkorderSV.getLastWorkorderByObjIdAndObjType(objId,objType);
		if(lastWorkorder != null){
				//如果当前环节为前一个环节回退后流转到此处
				if("N".equals(lastWorkorder.getResult())){
					lastWorkorder1 = iAlmWorkorderSV.getFristWorkorderByObjIdAndObjTypeAndLinkNo(objId,objType, taskTag);
					if(lastWorkorder1 != null){
						//woValue.setLastOrderId(lastWorkorder.getOrderId());
						iWorkOrderValue.setLastOrderId(lastWorkorder1.getLastOrderId());
					}else{
						iWorkOrderValue.setLastOrderId(lastWorkorder.getLastOrderId());
					}
				}
				//当前环节的前一个环节正常向下流转
				else{
					lastWorkorder = iAlmWorkorderSV.getLastWorkorderByObjIdAndObjType(objId,objType);
					if(lastWorkorder != null){
						iWorkOrderValue.setLastOrderId(lastWorkorder.getOrderId());
					}
				}
		}
		iWorkOrderValue.setVmTaskId(taskId);
		iWorkOrderValue.setParentVmTaskId(ConstDefine.WO_NO_PARENT_VM_TASK_ID);
		iWorkOrderValue.setLastVmTaskId((taskInfo.getLastTaskId()!=null&&!"".equals(taskInfo.getLastTaskId())?Long.parseLong(taskInfo.getLastTaskId()):ConstDefine.WO_NO_LAST_VM_TASK_ID));
		iWorkOrderValue.setLinkId(iBOAlmWorkflowValues[0].getLinkId());
		iWorkOrderValue.setLinkNo(iBOAlmWorkflowValues[0].getLinkNo());
		iWorkOrderValue.setLinkNoType(ConstDefine.LINK_NO_TYPE_USER);
		iWorkOrderValue.setIsCurrentTask(ConstDefine.IS_CURRENT_TASK);
		iWorkOrderValue.setOrderType(ConstDefine.STAKEHOLDERTYPE_WF);
		iWorkOrderValue.setObjId(Long.parseLong(objId));
		iWorkOrderValue.setObjType(objType);
		iWorkOrderValue.setDealType(ConstDefine.WO_DEAL_TYPE_APPROVE);
		iWorkOrderValue.setIsLock(ConstDefine.NO_LOCK);
		if(!"".equals(iBOStakeholders[0].getRoleCode()) && "".equals(iBOStakeholders[0].getStdholderStaffNo())){
			iWorkOrderValue.setFinishPrint(ConstDefine.NO_FINISH_PRINT);
		}else{
			if(ConstDefine.PRINT == iBOAlmWorkflowValues[0].getIsPrint())
				iWorkOrderValue.setFinishPrint(ConstDefine.NO_FINISH_PRINT);
			if(ConstDefine.NO_PRINT == iBOAlmWorkflowValues[0].getIsPrint())
				iWorkOrderValue.setFinishPrint(ConstDefine.NOT_NEED_PRINT);
		}
		iWorkOrderValue.setExecRoleId(iBOStakeholders[0].getRoleId());
		iWorkOrderValue.setExecRoleCode(iBOStakeholders[0].getRoleCode());
		iWorkOrderValue.setExecStaffId(iBOStakeholders[0].getStdholderStaffId());
		iWorkOrderValue.setExecStaffNo(iBOStakeholders[0].getStdholderStaffNo());
		//***
		//工单加锁代码 为解决
		//****
		if(!"".equals(iBOStakeholders[0].getRoleCode()) && "".equals(iBOStakeholders[0].getStdholderStaffNo())){
			iWorkOrderValue.setStatus(ConstDefine.WO_STATUS_CREATE);
		}else{
			if(ConstDefine.PRINT == iBOAlmWorkflowValues[0].getIsPrint())
				iWorkOrderValue.setStatus(ConstDefine.WO_STATUS_CREATE);
			if(ConstDefine.NO_PRINT == iBOAlmWorkflowValues[0].getIsPrint())
				iWorkOrderValue.setStatus(ConstDefine.WO_STATUS_RECEIVE);
		}
		iWorkOrderValue.setCreateTime(ServiceManager.getOpDateTime());
		if(!"".equals(iBOStakeholders[0].getRoleCode()) && "".equals(iBOStakeholders[0].getStdholderStaffNo())){
			
		}else{
			if(ConstDefine.NO_PRINT == iBOAlmWorkflowValues[0].getIsPrint()){
				iWorkOrderValue.setRecvTime(ServiceManager.getOpDateTime());
				iWorkOrderValue.setExecTime(ServiceManager.getOpDateTime());
			}
		}
		IBOAlmWorkorderValue[] iBOAlmWorkorderValues =	{iWorkOrderValue};
		iAlmWorkorderSV.saveAlmWorkorder(iBOAlmWorkorderValues);
		//将干系人信息移到干系人历史表中
		iAlmHisStakeholderSV.copyHisStakeholderByStakeholder(iWorkOrderValue, iBOStakeholders[0]);
		//更业务对象的阶段和状态
		this.updateObjCurPhaseAndCurStatus(objId,objType,String.valueOf(iBOAlmWorkflowValues[0].getLinkId()));
		
		this.extraMethod(iWorkOrderValue.getOrderId(), objId, objType, "userPreTask");
	}
	//人工环节后置任务
	public void userRearTask(long workflowId, String workflowTag, long taskId, String taskTag, String objId, String objType) throws Exception
	{
		TaskInfo taskInfo = ComframeClient.getDefaultComframeClient().getTaskInfo(taskId);
		if (workflowId == 0)
		{
			workflowId = taskInfo.getWorkflowId();
		}

		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_WorkflowId, workflowId);
		sql.addEqual(IBOAlmWorkorderValue.S_ObjId, Long.parseLong(objId));
		sql.addEqual(IBOAlmWorkorderValue.S_ObjType, objType);
		sql.addEqual(IBOAlmWorkorderValue.S_LinkNo, taskTag);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
		sql.addEqual(IBOAlmWorkorderValue.S_IsCurrentTask, ConstDefine.IS_CURRENT_TASK);

		IBOAlmWorkorderValue[] iWorkOrderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(iWorkOrderValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("查询人工任务当前待处理工单时出错,查询结果不唯一。查询表：ALM_WORKORDER；查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_WorkflowId +":" + workflowId + ",");
				sb.append(IBOAlmWorkorderValue.S_ObjId + ":" + Long.parseLong(objId) + ",");
				sb.append(IBOAlmWorkorderValue.S_ObjType + ":" + objType + ",");
				sb.append(IBOAlmWorkorderValue.S_LinkNo + ":" + taskTag + ",");
				sb.append(IBOAlmWorkorderValue.S_IsCurrentTask + ":" + ConstDefine.IS_CURRENT_TASK + ",");
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		if(iWorkOrderValues[0].getIsLock() == ConstDefine.LOCK){
			throw new Exception("当前工单已被锁定，请先解除锁定！");
		}
		
		if(iWorkOrderValues[0].getFinishPrint() == ConstDefine.NO_FINISH_PRINT){
			throw new Exception("当前工单需要先进行打单！");
		}
		iWorkOrderValues[0].setExecTimes(iWorkOrderValues[0].getExecTimes() + ServiceManager.getOpDateTime().getTime()-iWorkOrderValues[0].getExecTime().getTime());
		iWorkOrderValues[0].setFinishTime(ServiceManager.getOpDateTime());
		iWorkOrderValues[0].setStatus(ConstDefine.WO_STATUS_COMPLETE);
		iWorkOrderValues[0].setIsCurrentTask(ConstDefine.IS_NOT_CURRENT_TASK);
		iAlmWorkorderSV.saveAlmWorkorder(iWorkOrderValues);
		
		this.extraMethod(iWorkOrderValues[0].getOrderId(), objId, objType, "userRearTask");
	}
	
	//会签前置任务
	public void signPreTask(long workflowId, String workflowTag,
			long taskId, String taskTag, String objId, String objType)
			throws Exception {
		try{
			Criteria sql = new Criteria();
			sql.addEqual(IBOAlmWorkflowTemplateValue.S_TemplateName, workflowTag);
			IBOAlmWorkflowTemplateValue[] iBOAlmWorkflowTemplateValues =iAlmWorkflowTemplateSV.getAlmWorkflowTemplateByCondition(sql.toString(), sql.getParameters());
			if(iBOAlmWorkflowTemplateValues.length != 1){
				if (log.isErrorEnabled()) {
					StringBuffer sb = new StringBuffer();
					sb.append("同一模板编号查询到不唯一的配置信息,查询表：ALM_WORKFLOW_TEMPLATE；查询条件为【");
					sb.append(IBOAlmWorkflowTemplateValue.S_TemplateName +":" + workflowTag + ",");
					sb.append("】");
					sb.append("SQL:" + sql.toString());
					log.error(sb);	
					throw new Exception(sb.toString());
				}
			}
			sql = new Criteria();
			sql.addEqual(IBOAlmWorkflowValue.S_TemplateName, workflowTag);
			sql.addEqual(IBOAlmWorkflowValue.S_LinkNo, taskTag);
			IBOAlmWorkflowValue[] iBOAlmWorkflowValues =  iAlmWorkflowSV.getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
			if(iBOAlmWorkflowValues.length != 1){
				if (log.isErrorEnabled()) {
					StringBuffer sb = new StringBuffer();
					sb.append("同一环节查询到不唯一的配置信息,查询表：ALM_WORKFLOW；查询条件为【");
					sb.append(IBOAlmWorkflowValue.S_TemplateName +":" + workflowTag + ",");
					sb.append(IBOAlmWorkflowValue.S_LinkNo + ":" + taskTag);
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
			if(iBOStakeholders.length == 0){
				if (log.isErrorEnabled()) {
					StringBuffer sb = new StringBuffer();
					sb.append("人工前置任务查询当前环节干系人出错,干系人查询结果未查到干系人；查询条件为【");
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
			//生成会签主工单
			IBOAlmWorkorderValue iParentWorkOrderValue = new BOAlmWorkorderBean();
			//查询上一条工单ID
			IBOAlmWorkorderValue lastWorkorder = null;
			lastWorkorder = iAlmWorkorderSV.getLastWorkorderByObjIdAndObjType(objId,objType);
			if(lastWorkorder != null){
					//如果当前环节为前一个环节回退后流转到此处
					if("N".equals(lastWorkorder.getResult())){
						lastWorkorder = iAlmWorkorderSV.getFristWorkorderByObjIdAndObjTypeAndLinkNo(objId,objType, taskTag);
						if(lastWorkorder != null){
							//woValue.setLastOrderId(lastWorkorder.getOrderId());
							iParentWorkOrderValue.setLastOrderId(lastWorkorder.getLastOrderId());
						}
					}
					//当前环节的前一个环节正常向下流转
					else{
						lastWorkorder = iAlmWorkorderSV.getLastWorkorderByObjIdAndObjType(objId,objType);
						if(lastWorkorder != null){
							iParentWorkOrderValue.setLastOrderId(lastWorkorder.getOrderId());
						}
					}
			}
			
			iParentWorkOrderValue.setWorkflowId(workflowId);
			iParentWorkOrderValue.setParentOrderId(ConstDefine.WO_NO_PARENT);
			//查询上一条工单ID
			iParentWorkOrderValue.setVmTaskId(taskId);
			iParentWorkOrderValue.setLinkId(iBOAlmWorkflowValues[0].getLinkId());
			iParentWorkOrderValue.setLinkNo(iBOAlmWorkflowValues[0].getLinkNo());
			iParentWorkOrderValue.setLinkNoType(ConstDefine.LINK_NO_TYPE_SIGN);
			//VM与矩阵流程 在创建会签主工单时，IsCurrentTask字段填写有差异，矩阵流程依靠IsCurrentTask=Y找到最后一条完成的工单并生成下一条工单。VM流程会签主工单只用于流程展示 所以创建上直接IsCurrentTask=N
			iParentWorkOrderValue.setIsCurrentTask(ConstDefine.IS_NOT_CURRENT_TASK);
			iParentWorkOrderValue.setOrderType(ConstDefine.STAKEHOLDERTYPE_WF);
			iParentWorkOrderValue.setObjId(Long.parseLong(objId));
			iParentWorkOrderValue.setObjType(objType);
			iParentWorkOrderValue.setDealType(ConstDefine.WO_DEAL_TYPE_APPROVE);
			iParentWorkOrderValue.setFinishPrint(ConstDefine.NOT_NEED_PRINT);
			iParentWorkOrderValue.setExecStaffId(ConstDefine.ADMIN_ID);
			iParentWorkOrderValue.setExecStaffNo(ConstDefine.ADMIN_NO);
			iParentWorkOrderValue.setStatus(ConstDefine.WO_STATUS_RECEIVE);
			iParentWorkOrderValue.setCreateTime(ServiceManager.getOpDateTime());
			iParentWorkOrderValue.setRecvTime(ServiceManager.getOpDateTime());
			iParentWorkOrderValue.setExecTime(ServiceManager.getOpDateTime());
			IBOAlmWorkorderValue[] iBOParentAlmWorkorderValues =	{iParentWorkOrderValue};
			iAlmWorkorderSV.saveAlmWorkorder(iBOParentAlmWorkorderValues);
			//生成会签子工单
			for(IBOAlmStakeholderValue iBOStakeholder : iBOStakeholders){
				IBOAlmWorkorderValue iWorkOrderValue = new BOAlmWorkorderBean();
				iWorkOrderValue.setWorkflowId(workflowId);
				iWorkOrderValue.setParentOrderId(iParentWorkOrderValue.getOrderId());
				iWorkOrderValue.setLastOrderId(iParentWorkOrderValue.getOrderId());
				iWorkOrderValue.setParentVmTaskId(taskId);
				iWorkOrderValue.setLinkId(iBOAlmWorkflowValues[0].getLinkId());
				iWorkOrderValue.setLinkNo(iBOAlmWorkflowValues[0].getLinkNo());
				iWorkOrderValue.setLinkNoType(ConstDefine.LINK_NO_TYPE_SIGN);
				iWorkOrderValue.setIsCurrentTask(ConstDefine.IS_CURRENT_TASK);
				iWorkOrderValue.setOrderType(ConstDefine.STAKEHOLDERTYPE_WF);
				iWorkOrderValue.setObjId(Long.parseLong(objId));
				iWorkOrderValue.setObjType(objType);
				iWorkOrderValue.setDealType(ConstDefine.WO_DEAL_TYPE_APPROVE);
				iWorkOrderValue.setIsLock(ConstDefine.NO_LOCK);
				if(!"".equals(iBOStakeholder.getRoleCode()) && "".equals(iBOStakeholder.getStdholderStaffNo())){
					if (log.isErrorEnabled()) {
						StringBuffer sb = new StringBuffer();
						sb.append("会签环节不能使用角色！");
						log.error(sb);	
						throw new Exception(sb.toString());
					}
				}else{
					if(ConstDefine.PRINT == iBOAlmWorkflowValues[0].getIsPrint())
						iWorkOrderValue.setFinishPrint(ConstDefine.NO_FINISH_PRINT);
					if(ConstDefine.NO_PRINT == iBOAlmWorkflowValues[0].getIsPrint())
						iWorkOrderValue.setFinishPrint(ConstDefine.NOT_NEED_PRINT);
				}
				iWorkOrderValue.setExecRoleId(iBOStakeholder.getRoleId());
				iWorkOrderValue.setExecRoleCode(iBOStakeholder.getRoleCode());
				iWorkOrderValue.setExecStaffId(iBOStakeholder.getStdholderStaffId());
				iWorkOrderValue.setExecStaffNo(iBOStakeholder.getStdholderStaffNo());
				//***
				//工单加锁代码 为解决
				//****
				if(ConstDefine.PRINT == iBOAlmWorkflowValues[0].getIsPrint())
					iWorkOrderValue.setStatus(ConstDefine.WO_STATUS_CREATE);
				if(ConstDefine.NO_PRINT == iBOAlmWorkflowValues[0].getIsPrint())
					iWorkOrderValue.setStatus(ConstDefine.WO_STATUS_RECEIVE);
				iWorkOrderValue.setCreateTime(ServiceManager.getOpDateTime());
				if(ConstDefine.NO_PRINT == iBOAlmWorkflowValues[0].getIsPrint()){
					iWorkOrderValue.setRecvTime(ServiceManager.getOpDateTime());
					iWorkOrderValue.setExecTime(ServiceManager.getOpDateTime());
				}
				IBOAlmWorkorderValue[] iBOAlmWorkorderValues =	{iWorkOrderValue};
				iAlmWorkorderSV.saveAlmWorkorder(iBOAlmWorkorderValues);
				//将干系人信息移到干系人历史表中
				iAlmHisStakeholderSV.copyHisStakeholderByStakeholder(iWorkOrderValue, iBOStakeholder);
				
				this.extraMethod(iWorkOrderValue.getOrderId(), objId, objType,"signPreTask");
			}
			//更业务对象的阶段和状态
			this.updateObjCurPhaseAndCurStatus(objId,objType,String.valueOf(iBOAlmWorkflowValues[0].getLinkId()));			
		}catch(Exception e){
			e.printStackTrace();
			throw e;
		}
	}
	//会签环节后置任务
	public String signRearTask(long workflowId, String workflowTag,
			long taskId, String taskTag, String objId, String objType)
			throws Exception {//会签后置任务
		try{
			return null;
		}catch(Exception e){
			throw e;
		}
	}
	//流程结果环节任务
	//目的将所有工单移至历史表中
	public void finishTask(long workflowId, String workflowTag, String objId, String objType) throws Exception{
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowValue.S_TemplateName, workflowTag);
		sql.addEqual(IBOAlmWorkflowValue.S_LinkNoType, ConstDefine.LINK_NO_TYPE_END);
		IBOAlmWorkflowValue[] iBOAlmWorkflowValues =  iAlmWorkflowSV.getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一环节查询到不唯一的配置信息,查询表：ALM_WORKFLOW；查询条件为【");
				sb.append(IBOAlmWorkflowValue.S_TemplateName +":" + workflowTag + ",");
				sb.append(IBOAlmWorkflowValue.S_LinkNoType + ":" + ConstDefine.LINK_NO_TYPE_END);
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);	
				throw new Exception(sb.toString());
			}
		}
		///////////////////////////////////////////////
		IBOAlmWorkorderValue iWorkOrderValue = new BOAlmWorkorderBean();
		iWorkOrderValue.setWorkflowId(workflowId);
		iWorkOrderValue.setParentOrderId(ConstDefine.WO_NO_PARENT);
		//查询上一条工单ID
		IBOAlmWorkorderValue lastWorkorder = null;
		IBOAlmWorkorderValue lastWorkorder1=null;
		lastWorkorder = iAlmWorkorderSV.getLastWorkorderByObjIdAndObjType(objId,objType);
		if(lastWorkorder != null){
				//如果当前环节为前一个环节回退后流转到此处
				if("N".equals(lastWorkorder.getResult())){
					lastWorkorder1 = iAlmWorkorderSV.getFristWorkorderByObjIdAndObjTypeAndLinkNo(objId,objType, iBOAlmWorkflowValues[0].getLinkNo());
					if(lastWorkorder1 != null){
						//woValue.setLastOrderId(lastWorkorder.getOrderId());
						iWorkOrderValue.setLastOrderId(lastWorkorder1.getLastOrderId());
					}else{
						iWorkOrderValue.setLastOrderId(lastWorkorder.getLastOrderId());
					}
				}
				//当前环节的前一个环节正常向下流转
				else{
					lastWorkorder = iAlmWorkorderSV.getLastWorkorderByObjIdAndObjType(objId,objType);
					if(lastWorkorder != null){
						iWorkOrderValue.setLastOrderId(lastWorkorder.getOrderId());
					}
				}
		}
		iWorkOrderValue.setVmTaskId(ConstDefine.WO_NO_VM_TASK_ID);
		iWorkOrderValue.setParentVmTaskId(ConstDefine.WO_NO_PARENT_VM_TASK_ID);
		iWorkOrderValue.setLastVmTaskId(ConstDefine.WO_NO_LAST_VM_TASK_ID);
		iWorkOrderValue.setLinkId(iBOAlmWorkflowValues[0].getLinkId());
		iWorkOrderValue.setLinkNo(iBOAlmWorkflowValues[0].getLinkNo());
		iWorkOrderValue.setLinkNoType(ConstDefine.LINK_NO_TYPE_END);
		iWorkOrderValue.setIsCurrentTask(ConstDefine.IS_NOT_CURRENT_TASK);
		iWorkOrderValue.setOrderType(ConstDefine.STAKEHOLDERTYPE_WF);
		iWorkOrderValue.setObjId(Long.parseLong(objId));
		iWorkOrderValue.setObjType(objType);
		iWorkOrderValue.setDealType(ConstDefine.WO_DEAL_TYPE_APPROVE);
		iWorkOrderValue.setIsLock(ConstDefine.NO_LOCK);
		iWorkOrderValue.setFinishPrint(ConstDefine.NO_PRINT);
		iWorkOrderValue.setExecStaffId(ConstDefine.ADMIN_ID);
		iWorkOrderValue.setExecStaffNo(ConstDefine.ADMIN_NO);
		iWorkOrderValue.setStatus(ConstDefine.WO_STATUS_COMPLETE);
		iWorkOrderValue.setCreateTime(ServiceManager.getOpDateTime());
		iWorkOrderValue.setRecvTime(ServiceManager.getOpDateTime());
		iWorkOrderValue.setExecTime(ServiceManager.getOpDateTime());
		iWorkOrderValue.setFinishTime(ServiceManager.getOpDateTime());
		iWorkOrderValue.setExecTimes(0);
		IBOAlmWorkorderValue[] iBOAlmWorkorderValues =	{iWorkOrderValue};
		iAlmWorkorderSV.saveAlmWorkorder(iBOAlmWorkorderValues);
		//////////////////////////////////////////////
		
		
		
		sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_WorkflowId, workflowId);
		sql.addEqual(IBOAlmWorkorderValue.S_ObjId, Long.parseLong(objId));
		sql.addEqual(IBOAlmWorkorderValue.S_ObjType, objType);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
		sql.addEqual(IBOAlmWorkorderValue.S_IsCurrentTask, ConstDefine.IS_CURRENT_TASK);

		IBOAlmWorkorderValue[] iWorkOrderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(iWorkOrderValues.length > 0){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("存在待处理工单，不能将工单移至工单历史表。查询表：ALM_WORKORDER；查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_WorkflowId +":" + workflowId + ",");
				sb.append(IBOAlmWorkorderValue.S_ObjId + ":" + Long.parseLong(objId) + ",");
				sb.append(IBOAlmWorkorderValue.S_ObjType + ":" + objType + ",");
				sb.append(IBOAlmWorkorderValue.S_IsCurrentTask + ":" + ConstDefine.IS_CURRENT_TASK + ",");
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		
		sql = new Criteria();
		//管理工单无WorkflowId
		sql.addEqual(IBOAlmWorkorderValue.S_ObjId, Long.parseLong(objId));
		sql.addEqual(IBOAlmWorkorderValue.S_ObjType, objType);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);

		iWorkOrderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		for(IBOAlmWorkorderValue iBOAlmWorkorderValue : iWorkOrderValues){
			//将工单copy到工单历史表中
			iAlmHisWorkorderSV.capyHisWorkorderByWorkorder(iBOAlmWorkorderValue);
			//删除工单表中工单
			iBOAlmWorkorderValue.delete();
		}
		iAlmWorkorderSV.saveAlmWorkorder(iWorkOrderValues);
		//修改业务对象状态
		this.updateObjCurPhaseAndCurStatus(objId,objType,String.valueOf(iBOAlmWorkflowValues[0].getLinkId()));
		//this.finishTaskUpdateOther(objId, objType);
		
	}
	
	//流程结果环节任务 此方法需要人为制定工作流完成时 业务对象当前环节编号
	//目的将所有工单移至历史表中
	public void finishTask(long workflowId, String workflowTag, String objId, String objType, String linkNo) throws Exception{
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowValue.S_TemplateName, workflowTag);
		sql.addEqual(IBOAlmWorkflowValue.S_LinkNo, linkNo);
		sql.addEqual(IBOAlmWorkflowValue.S_LinkNoType, ConstDefine.LINK_NO_TYPE_END);
		IBOAlmWorkflowValue[] iBOAlmWorkflowValues =  iAlmWorkflowSV.getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一环节查询到不唯一的配置信息,查询表：ALM_WORKFLOW；查询条件为【");
				sb.append(IBOAlmWorkflowValue.S_TemplateName +":" + workflowTag + ",");
				sb.append(IBOAlmWorkflowValue.S_LinkNo +":" + linkNo + ",");
				sb.append(IBOAlmWorkflowValue.S_LinkNoType + ":" + ConstDefine.LINK_NO_TYPE_END);
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);	
				throw new Exception(sb.toString());
			}
		}
		
		///////////////////////////////////////////////
		IBOAlmWorkorderValue iWorkOrderValue = new BOAlmWorkorderBean();
		iWorkOrderValue.setWorkflowId(workflowId);
		iWorkOrderValue.setParentOrderId(ConstDefine.WO_NO_PARENT);
		//查询上一条工单ID
		IBOAlmWorkorderValue lastWorkorder = null;
		IBOAlmWorkorderValue lastWorkorder1=null;
		lastWorkorder = iAlmWorkorderSV.getLastWorkorderByObjIdAndObjType(objId,objType);
		if(lastWorkorder != null){
				//如果当前环节为前一个环节回退后流转到此处
				if("N".equals(lastWorkorder.getResult())){
					lastWorkorder1 = iAlmWorkorderSV.getFristWorkorderByObjIdAndObjTypeAndLinkNo(objId,objType, iBOAlmWorkflowValues[0].getLinkNo());
					if(lastWorkorder1 != null){
						//woValue.setLastOrderId(lastWorkorder.getOrderId());
						iWorkOrderValue.setLastOrderId(lastWorkorder1.getLastOrderId());
					}else{
						iWorkOrderValue.setLastOrderId(lastWorkorder.getLastOrderId());
					}
				}
				//当前环节的前一个环节正常向下流转
				else{
					lastWorkorder = iAlmWorkorderSV.getLastWorkorderByObjIdAndObjType(objId,objType);
					if(lastWorkorder != null){
						iWorkOrderValue.setLastOrderId(lastWorkorder.getOrderId());
					}
				}
		}
		iWorkOrderValue.setVmTaskId(ConstDefine.WO_NO_VM_TASK_ID);
		iWorkOrderValue.setParentVmTaskId(ConstDefine.WO_NO_PARENT_VM_TASK_ID);
		iWorkOrderValue.setLastVmTaskId(ConstDefine.WO_NO_LAST_VM_TASK_ID);
		iWorkOrderValue.setLinkId(iBOAlmWorkflowValues[0].getLinkId());
		iWorkOrderValue.setLinkNo(iBOAlmWorkflowValues[0].getLinkNo());
		iWorkOrderValue.setLinkNoType(ConstDefine.LINK_NO_TYPE_END);
		iWorkOrderValue.setIsCurrentTask(ConstDefine.IS_NOT_CURRENT_TASK);
		iWorkOrderValue.setOrderType(ConstDefine.STAKEHOLDERTYPE_WF);
		iWorkOrderValue.setObjId(Long.parseLong(objId));
		iWorkOrderValue.setObjType(objType);
		iWorkOrderValue.setDealType(ConstDefine.WO_DEAL_TYPE_APPROVE);
		iWorkOrderValue.setIsLock(ConstDefine.NO_LOCK);
		iWorkOrderValue.setFinishPrint(ConstDefine.NO_PRINT);
		iWorkOrderValue.setExecStaffId(ConstDefine.ADMIN_ID);
		iWorkOrderValue.setExecStaffNo(ConstDefine.ADMIN_NO);
		iWorkOrderValue.setStatus(ConstDefine.WO_STATUS_COMPLETE);
		iWorkOrderValue.setCreateTime(ServiceManager.getOpDateTime());
		iWorkOrderValue.setRecvTime(ServiceManager.getOpDateTime());
		iWorkOrderValue.setExecTime(ServiceManager.getOpDateTime());
		iWorkOrderValue.setFinishTime(ServiceManager.getOpDateTime());
		iWorkOrderValue.setExecTimes(0);
		IBOAlmWorkorderValue[] iBOAlmWorkorderValues =	{iWorkOrderValue};
		iAlmWorkorderSV.saveAlmWorkorder(iBOAlmWorkorderValues);
		//////////////////////////////////////////////
		
		
		sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_WorkflowId, workflowId);
		sql.addEqual(IBOAlmWorkorderValue.S_ObjId, Long.parseLong(objId));
		sql.addEqual(IBOAlmWorkorderValue.S_ObjType, objType);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);
		sql.addEqual(IBOAlmWorkorderValue.S_IsCurrentTask, ConstDefine.IS_CURRENT_TASK);

		IBOAlmWorkorderValue[] iWorkOrderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(iWorkOrderValues.length > 0){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("存在待处理工单，不能将工单移至工单历史表。查询表：ALM_WORKORDER；查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_WorkflowId +":" + workflowId + ",");
				sb.append(IBOAlmWorkorderValue.S_ObjId + ":" + Long.parseLong(objId) + ",");
				sb.append(IBOAlmWorkorderValue.S_ObjType + ":" + objType + ",");
				sb.append(IBOAlmWorkorderValue.S_IsCurrentTask + ":" + ConstDefine.IS_CURRENT_TASK + ",");
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				throw new Exception(sb.toString());
			}
		}
		
		sql = new Criteria();
		//管理工单无WorkflowId
		sql.addEqual(IBOAlmWorkorderValue.S_ObjId, Long.parseLong(objId));
		sql.addEqual(IBOAlmWorkorderValue.S_ObjType, objType);
		sql.addEqual(IBOAlmWorkorderValue.S_OrderType, ConstDefine.STAKEHOLDERTYPE_WF);

		iWorkOrderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		for(IBOAlmWorkorderValue iBOAlmWorkorderValue : iWorkOrderValues){
			//将工单copy到工单历史表中
			iAlmHisWorkorderSV.capyHisWorkorderByWorkorder(iBOAlmWorkorderValue);
			//删除工单表中工单
			iBOAlmWorkorderValue.delete();
		}
		iAlmWorkorderSV.saveAlmWorkorder(iWorkOrderValues);
		//修改业务对象状态
		this.updateObjCurPhaseAndCurStatus(objId,objType,String.valueOf(iBOAlmWorkflowValues[0].getLinkId()));
		//this.finishTaskUpdateOther(objId, objType);
	}
	
	
	//抽象函数 用于实现业务对象当前阶段和当前环节状态更新
	public abstract void updateObjCurPhaseAndCurStatus(String objId,String objType,String linkId) throws Exception;
	
	public abstract void extraMethod(long orderId,String objId,String objType,String methodType) throws Exception;
	
	// abstract void finishTaskUpdateOther(String objId,String objType) throws Exception;
	
	//新增函数，为自动节点添加工单
	public void autoTask(long workflowId, String workflowTag, long taskId, String taskTag, String objId, String objType) throws Exception {
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowValue.S_TemplateName, workflowTag);
		sql.addEqual(IBOAlmWorkflowValue.S_LinkNo, taskTag);
		IBOAlmWorkflowValue[] iBOAlmWorkflowValues =  iAlmWorkflowSV.getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一环节查询到不唯一的配置信息,查询表：ALM_WORKFLOW；查询条件为【");
				sb.append(IBOAlmWorkflowValue.S_TemplateName +":" + workflowTag + ",");
				sb.append(IBOAlmWorkflowValue.S_LinkNo + ":" + taskTag);
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);	
				throw new Exception(sb.toString());
			}
		}
		IBOAlmStakeholderValue holder = new BOAlmStakeholderBean();
		holder.setCreateTime(new Timestamp(new Date().getTime()));
		holder.setObjId(Long.valueOf(objId));
		holder.setObjType(objType);
		holder.setLinkId(iBOAlmWorkflowValues[0].getLinkId());
		holder.setLinkNo(iBOAlmWorkflowValues[0].getLinkNo());
		holder.setStdholdeType(IStakeholderType.STDHOLDETYPE_APPROVAL);
		holder.setStdholderStaffId(12729);
		holder.setStdholderStaffName("自动机");
		holder.setStdholderStaffNo("AUTOER");
		holder.setTemplateId(iBOAlmWorkflowValues[0].getTemplateId());
		BusiFactory.getAlmStakeholderSV().saveStakeholder(new IBOAlmStakeholderValue[]{holder});
		
		userPreTask(workflowId, workflowTag, taskId, taskTag, objId, objType);
		
		IBOAlmWorkorderValue lastWorkorder = null;
		lastWorkorder = iAlmWorkorderSV.getLastWorkorderByObjIdAndObjType(objId,objType);
		lastWorkorder.setIsCurrentTask(com.asiainfo.csc.matrix.common.ConstDefine.IS_CURRENT_TASK);
		lastWorkorder.setStatus(com.asiainfo.csc.matrix.common.ConstDefine.WO_STATUS_COMPLETE);
		lastWorkorder.setLinkNoType("auto");
		lastWorkorder.setExecStaffId(12729);
		lastWorkorder.setExecStaffNo("AUTOER");
		lastWorkorder.setExecTime(new Timestamp(new Date().getTime()));
		lastWorkorder.setOpinion("自动环节回单");
		lastWorkorder.setResult("Y");
		
		List<IBOAlmStakeholderValue> iBOAlmStakeholderValue = new ArrayList<IBOAlmStakeholderValue>();
		iBOAlmStakeholderValue.add(holder);
		new AlmMatrixClient().saveWorkorder(lastWorkorder, iBOAlmStakeholderValue, "<conds><cond name=\"staffId\" value=\"12729\"></conds>");
		
		userRearTask(workflowId, workflowTag, taskId, taskTag, objId, objType);
		
	}
}
