package com.asiainfo.csc.matrix.common.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.matrix.bo.BOAlmHisWorkflowCaseBean;
import com.asiainfo.csc.matrix.bo.BOAlmWorkflowCaseBean;
import com.asiainfo.csc.matrix.bo.BOAlmWorkorderBean;
import com.asiainfo.csc.matrix.bo.BOScheduleBean;
import com.asiainfo.csc.matrix.common.ConstDefine;
import com.asiainfo.csc.matrix.common.interfaces.IAlmMatrixFun;
import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOAlmHisWorkflowCaseValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowCaseValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowTemplateValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;
import com.asiainfo.csc.matrix.ivalues.IBOScheduleValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmHisStakeholderSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmHisWorkorderSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmStakeholderSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkflowSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkflowTemplateSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkorderSV;

public abstract class AlmMatrixFunImpl implements IAlmMatrixFun{
	private final static transient Log log = LogFactory.getLog(AlmMatrixFunImpl.class);
	IAlmWorkorderSV iAlmWorkorderSV = BusiFactory.getAlmWorkorderSV();
	IAlmHisWorkorderSV iAlmHisWorkorderSV = BusiFactory.getAlmHisWorkorderSV();
	IAlmStakeholderSV iAlmStakeholderSV = BusiFactory.getAlmStakeholderSV();
	IAlmWorkflowSV iAlmWorkflowSV = BusiFactory.getAlmWorkflowSV();
	IAlmWorkflowTemplateSV iAlmWorkflowTemplateSV = BusiFactory.getAlmWorkflowTemplateSV();
	IAlmHisStakeholderSV iAlmHisStakeholderSV = BusiFactory.getAlmHisStakeholderSV();
	public long generatUserWorkorder(Long workflow_id,Long last_order_id,Long obj_id,String obj_type,String link_no,Long link_id,String Link_no_type) throws Exception{
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowValue.S_LinkId, link_id);
		sql.addEqual(IBOAlmWorkflowValue.S_LinkNo, link_no);
		IBOAlmWorkflowValue[] iBOAlmWorkflowValues =  iAlmWorkflowSV.getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
		if(iBOAlmWorkflowValues.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("同一环节查询到不唯一的配置信息,查询表：ALM_WORKFLOW；查询条件为【");
				sb.append(IBOAlmWorkflowValue.S_LinkId +":" + link_id + ",");
				sb.append(IBOAlmWorkflowValue.S_LinkNo + ":" + link_no);
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
		sql.addEqual(IBOAlmStakeholderValue.S_TemplateId, iBOAlmWorkflowTemplateValues[0].getTemplateId());
		sql.addEqual(IBOAlmStakeholderValue.S_LinkId, iBOAlmWorkflowValues[0].getLinkId());
		sql.addEqual(IBOAlmStakeholderValue.S_LinkNo, iBOAlmWorkflowValues[0].getLinkNo());
		sql.addEqual(IBOAlmStakeholderValue.S_ObjId, obj_id);
		sql.addEqual(IBOAlmStakeholderValue.S_ObjType, Long.parseLong(obj_type));
		sql.addEqual(IBOAlmStakeholderValue.S_StdholdeType, ConstDefine.STAKEHOLDERTYPE_WF);
		IBOAlmStakeholderValue[] stakeholders = iAlmStakeholderSV.getStakeholderByCondition(sql.toString(), sql.getParameters());
		if(!ConstDefine.LINK_NO_TYPE_END.equals(Link_no_type)){
			if(stakeholders.length != 1){
				if (log.isErrorEnabled()) {
					StringBuffer sb = new StringBuffer();
					sb.append("人工前置任务查询当前环节干系人出错,干系人查询结果不唯一或未查到干系人；查询条件为【");
					sb.append(IBOAlmStakeholderValue.S_TemplateId +":" + iBOAlmWorkflowTemplateValues[0].getTemplateId() + ",");
					sb.append(IBOAlmStakeholderValue.S_LinkId +":" + iBOAlmWorkflowValues[0].getLinkId() + ",");
					sb.append(IBOAlmStakeholderValue.S_LinkNo +":" + iBOAlmWorkflowValues[0].getLinkNo() + ",");
					sb.append(IBOAlmStakeholderValue.S_ObjId +":" + obj_id + ",");
					sb.append(IBOAlmStakeholderValue.S_ObjType +":" + Long.parseLong(obj_type) + ",");
					sb.append(IBOAlmStakeholderValue.S_StdholdeType + ":" + ConstDefine.STAKEHOLDERTYPE_WF);
					sb.append("】");
					sb.append("SQL:" + sql.toString());
					log.error(sb);
					throw new Exception(sb.toString());
				}
			}
			if(ConstDefine.LINK_NO_TYPE_USER.equals(Link_no_type)){
				IBOAlmWorkorderValue iWorkOrderValue = new BOAlmWorkorderBean();
				iWorkOrderValue.setWorkflowId(workflow_id);
				iWorkOrderValue.setParentOrderId(ConstDefine.WO_NO_PARENT);
				//查询上一条工单ID
				IBOAlmWorkorderValue lastWorkorder = null;
				lastWorkorder = iAlmWorkorderSV.getLastWorkorderByObjIdAndObjType(obj_id.toString(),obj_type);
				if(lastWorkorder != null){
						//如果当前环节为前一个环节回退后流转到此处
						if("N".equals(lastWorkorder.getResult())){
							lastWorkorder = iAlmWorkorderSV.getFristWorkorderByObjIdAndObjTypeAndLinkNo(obj_id.toString(),obj_type, iBOAlmWorkflowValues[0].getLinkNo());
							if(lastWorkorder != null){
								iWorkOrderValue.setLastOrderId(lastWorkorder.getLastOrderId());
							}
						}
						//当前环节的前一个环节正常向下流转
						else{
							lastWorkorder = iAlmWorkorderSV.getLastWorkorderByObjIdAndObjType(obj_id.toString(),iBOAlmWorkflowValues[0].getLinkNo());
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
				iWorkOrderValue.setLinkNoType(iBOAlmWorkflowValues[0].getLinkNoType());
				iWorkOrderValue.setIsCurrentTask(ConstDefine.IS_CURRENT_TASK);
				iWorkOrderValue.setOrderType(ConstDefine.STAKEHOLDERTYPE_WF);
				iWorkOrderValue.setObjId(obj_id);
				iWorkOrderValue.setObjType(obj_type);
				iWorkOrderValue.setDealType(ConstDefine.WO_DEAL_TYPE_APPROVE);
				iWorkOrderValue.setIsLock(ConstDefine.NO_LOCK);
				if(!"".equals(stakeholders[0].getRoleCode()) && "".equals(stakeholders[0].getStdholderStaffNo())){
					iWorkOrderValue.setFinishPrint(ConstDefine.NO_FINISH_PRINT);
				}else{
					if(ConstDefine.PRINT == iBOAlmWorkflowValues[0].getIsPrint());
						iWorkOrderValue.setFinishPrint(ConstDefine.NO_FINISH_PRINT);
					if(ConstDefine.NO_PRINT == iBOAlmWorkflowValues[0].getIsPrint());
						iWorkOrderValue.setFinishPrint(ConstDefine.NOT_NEED_PRINT);
				}
				iWorkOrderValue.setExecRoleId(stakeholders[0].getRoleId());
				iWorkOrderValue.setExecRoleCode(stakeholders[0].getRoleCode());
				iWorkOrderValue.setExecStaffId(stakeholders[0].getStdholderStaffId());
				iWorkOrderValue.setExecStaffNo(stakeholders[0].getStdholderStaffNo());
				//***
				//工单加锁代码 为解决
				//****
				if(!"".equals(stakeholders[0].getRoleCode()) && "".equals(stakeholders[0].getStdholderStaffNo())){
					iWorkOrderValue.setStatus(ConstDefine.WO_STATUS_CREATE);
				}else{
					if(ConstDefine.PRINT == iBOAlmWorkflowValues[0].getIsPrint());
						iWorkOrderValue.setStatus(ConstDefine.WO_STATUS_CREATE);
					if(ConstDefine.NO_PRINT == iBOAlmWorkflowValues[0].getIsPrint());
						iWorkOrderValue.setStatus(ConstDefine.WO_STATUS_RECEIVE);
				}
				iWorkOrderValue.setCreateTime(ServiceManager.getOpDateTime());
				if(!"".equals(stakeholders[0].getRoleCode()) && "".equals(stakeholders[0].getStdholderStaffNo())){

				}else{
					if(ConstDefine.NO_PRINT == iBOAlmWorkflowValues[0].getIsPrint());
						iWorkOrderValue.setRecvTime(ServiceManager.getOpDateTime());
				}
				IBOAlmWorkorderValue[] iBOAlmWorkorderValues =	{iWorkOrderValue};
				iAlmWorkorderSV.saveAlmWorkorder(iBOAlmWorkorderValues);
				//将干系人信息移到干系人历史表中
				iAlmHisStakeholderSV.copyHisStakeholderByStakeholder(iWorkOrderValue, stakeholders[0]);
				
				this.updateObjCurPhaseAndCurStatus(obj_id.toString(),obj_type, String.valueOf(iBOAlmWorkflowValues[0].getLinkId()));
			}
			if(ConstDefine.LINK_NO_TYPE_SIGN.equals(Link_no_type)){
				//生成会签主工单
				IBOAlmWorkorderValue iParentWorkOrderValue = new BOAlmWorkorderBean();
				//查询上一条工单ID
				IBOAlmWorkorderValue lastWorkorder = null;
				lastWorkorder = iAlmWorkorderSV.getLastWorkorderByObjIdAndObjType(obj_id.toString(),obj_type);
				if(lastWorkorder != null){
						//如果当前环节为前一个环节回退后流转到此处
						if("N".equals(lastWorkorder.getResult())){
							lastWorkorder = iAlmWorkorderSV.getFristWorkorderByObjIdAndObjTypeAndLinkNo(obj_id.toString(),obj_type, iBOAlmWorkflowValues[0].getLinkNo());
							if(lastWorkorder != null){
								//woValue.setLastOrderId(lastWorkorder.getOrderId());
								iParentWorkOrderValue.setLastOrderId(lastWorkorder.getLastOrderId());
							}
						}
						//当前环节的前一个环节正常向下流转
						else{
							lastWorkorder = iAlmWorkorderSV.getLastWorkorderByObjIdAndObjType(obj_id.toString(),obj_type);
							if(lastWorkorder != null){
								iParentWorkOrderValue.setLastOrderId(lastWorkorder.getOrderId());
							}
						}
				}
				
				iParentWorkOrderValue.setWorkflowId(workflow_id);
				iParentWorkOrderValue.setParentOrderId(ConstDefine.WO_NO_PARENT);
				iParentWorkOrderValue.setVmTaskId(ConstDefine.WO_NO_VM_TASK_ID);
				iParentWorkOrderValue.setParentVmTaskId(ConstDefine.WO_NO_PARENT_VM_TASK_ID);
				iParentWorkOrderValue.setLastVmTaskId(ConstDefine.WO_NO_LAST_VM_TASK_ID);
				iParentWorkOrderValue.setLinkId(iBOAlmWorkflowValues[0].getLinkId());
				iParentWorkOrderValue.setLinkNo(iBOAlmWorkflowValues[0].getLinkNo());
				iParentWorkOrderValue.setLinkNoType(ConstDefine.LINK_NO_TYPE_SIGN);
				//VM与矩阵流程 在创建会签主工单时，IsCurrentTask字段填写有差异，矩阵流程依靠IsCurrentTask=Y找到最后一条完成的工单并生成下一条工单。VM流程会签主工单只用于流程展示 所以创建上直接IsCurrentTask=N
				iParentWorkOrderValue.setIsCurrentTask(ConstDefine.IS_CURRENT_TASK);
				iParentWorkOrderValue.setOrderType(ConstDefine.STAKEHOLDERTYPE_WF);
				iParentWorkOrderValue.setObjId(obj_id);
				iParentWorkOrderValue.setObjType(obj_type);
				iParentWorkOrderValue.setDealType(ConstDefine.WO_DEAL_TYPE_APPROVE);
				iParentWorkOrderValue.setFinishPrint(ConstDefine.NOT_NEED_PRINT);
				iParentWorkOrderValue.setExecStaffId(ConstDefine.ADMIN_ID);
				iParentWorkOrderValue.setExecStaffNo(ConstDefine.ADMIN_NO);
				iParentWorkOrderValue.setStatus(ConstDefine.WO_STATUS_RECEIVE);
				iParentWorkOrderValue.setCreateTime(ServiceManager.getOpDateTime());
				iParentWorkOrderValue.setRecvTime(ServiceManager.getOpDateTime());
				IBOAlmWorkorderValue[] iBOParentAlmWorkorderValues =	{iParentWorkOrderValue};
				iAlmWorkorderSV.saveAlmWorkorder(iBOParentAlmWorkorderValues);
				//生成会签子工单
				for(IBOAlmStakeholderValue iBOStakeholder : stakeholders){
					IBOAlmWorkorderValue iWorkOrderValue = new BOAlmWorkorderBean();
					iWorkOrderValue.setWorkflowId(workflow_id);
					iWorkOrderValue.setParentOrderId(iParentWorkOrderValue.getOrderId());
					iWorkOrderValue.setLastOrderId(iParentWorkOrderValue.getOrderId());
					iWorkOrderValue.setVmTaskId(ConstDefine.WO_NO_VM_TASK_ID);
					iWorkOrderValue.setParentVmTaskId(ConstDefine.WO_NO_PARENT_VM_TASK_ID);
					iWorkOrderValue.setLastVmTaskId(ConstDefine.WO_NO_LAST_VM_TASK_ID);
					iWorkOrderValue.setLinkId(iBOAlmWorkflowValues[0].getLinkId());
					iWorkOrderValue.setLinkNo(iBOAlmWorkflowValues[0].getLinkNo());
					iWorkOrderValue.setLinkNoType(ConstDefine.LINK_NO_TYPE_SIGN);
					iWorkOrderValue.setIsCurrentTask(ConstDefine.IS_CURRENT_TASK);
					iWorkOrderValue.setOrderType(ConstDefine.STAKEHOLDERTYPE_WF);
					iWorkOrderValue.setObjId(obj_id);
					iWorkOrderValue.setObjType(obj_type.toString());
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
						if(ConstDefine.PRINT == iBOAlmWorkflowValues[0].getIsPrint());
							iWorkOrderValue.setFinishPrint(ConstDefine.NO_FINISH_PRINT);
						if(ConstDefine.NO_PRINT == iBOAlmWorkflowValues[0].getIsPrint());
							iWorkOrderValue.setFinishPrint(ConstDefine.NOT_NEED_PRINT);
					}
					iWorkOrderValue.setExecRoleId(iBOStakeholder.getRoleId());
					iWorkOrderValue.setExecRoleCode(iBOStakeholder.getRoleCode());
					iWorkOrderValue.setExecStaffId(iBOStakeholder.getStdholderStaffId());
					iWorkOrderValue.setExecStaffNo(iBOStakeholder.getStdholderStaffNo());
					//***
					//工单加锁代码 为解决
					//****
					if(ConstDefine.PRINT == iBOAlmWorkflowValues[0].getIsPrint());
						iWorkOrderValue.setStatus(ConstDefine.WO_STATUS_CREATE);
					if(ConstDefine.NO_PRINT == iBOAlmWorkflowValues[0].getIsPrint());
						iWorkOrderValue.setStatus(ConstDefine.WO_STATUS_RECEIVE);
					iWorkOrderValue.setCreateTime(ServiceManager.getOpDateTime());
					if(ConstDefine.NO_PRINT == iBOAlmWorkflowValues[0].getIsPrint());
						iWorkOrderValue.setRecvTime(ServiceManager.getOpDateTime());
					IBOAlmWorkorderValue[] iBOAlmWorkorderValues =	{iWorkOrderValue};
					iAlmWorkorderSV.saveAlmWorkorder(iBOAlmWorkorderValues);
					//将干系人信息移到干系人历史表中
					iAlmHisStakeholderSV.copyHisStakeholderByStakeholder(iWorkOrderValue, iBOStakeholder);
				}
				this.updateObjCurPhaseAndCurStatus(obj_id.toString(),obj_type ,String.valueOf(iBOAlmWorkflowValues[0].getLinkId()));
			}
	//		if("auto".equals(Link_no_type)){
	//			
	//		}
		}else{
			Criteria condition=new Criteria();
			condition.addEqual(BOAlmWorkflowCaseBean.S_TaskId, workflow_id);
			IBOAlmWorkflowCaseValue[] workflowCases=BusiFactory.getAlmWorkflowCaseSV().getAlmWorkflowCaseByCondition(condition.toString(),condition.getParameters());
			if(workflowCases.length==0||workflowCases==null)
				throw new Exception("未找到相应的流程实例，函数generatUserWorkorder");
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
			condition.addEqual(BOScheduleBean.S_WorkflowId, workflow_id);
			IBOScheduleValue[] scheduleValues=BusiFactory.getAlmScheduleSV().getScheduleByCondition(condition.toString(),condition.getParameters());
			if(scheduleValues.length==0||scheduleValues==null)
				throw new Exception("未找到相应的调度队列，函数generatUserWorkorder");
			scheduleValues[0].delete();
			BusiFactory.getAlmScheduleSV().saveSchedule(new IBOScheduleValue[]{scheduleValues[0]});
				
			condition.clear();
			condition.addEqual(IBOAlmStakeholderValue.S_StdholdeType, ConstDefine.STAKEHOLDERTYPE_WF);
			condition.addEqual(IBOAlmStakeholderValue.S_ObjId,obj_id);
			condition.addEqual(IBOAlmStakeholderValue.S_ObjType, obj_type);
			stakeholders=BusiFactory.getAlmStakeholderSV().getStakeholderByCondition(condition.toString(), condition.getParameters());
			for(IBOAlmStakeholderValue stakeholder : stakeholders){
				stakeholder.delete();
				BusiFactory.getAlmStakeholderSV().saveStakeholder(new IBOAlmStakeholderValue[]{stakeholder});
			}
			
			condition.clear();
			condition.addEqual(BOAlmWorkorderBean.S_ObjId,obj_id);
			condition.addEqual(BOAlmWorkorderBean.S_ObjType, obj_type);
			condition.addEqual(BOAlmWorkorderBean.S_OrderType,ConstDefine.STAKEHOLDERTYPE_WF);
			IBOAlmWorkorderValue[] workorders=BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(condition.toString(),condition.getParameters());
			for(IBOAlmWorkorderValue workorder : workorders){
				//将工单copy到工单历史表中
				iAlmHisWorkorderSV.capyHisWorkorderByWorkorder(workorder);
				//删除工单表中工单
				workorder.delete();
			}
			iAlmWorkorderSV.saveAlmWorkorder(workorders);
			this.updateObjCurPhaseAndCurStatus(obj_id.toString(), obj_type,String.valueOf(iBOAlmWorkflowValues[0].getLinkId()));
		}
		
		return 0;
	}

	//抽象函数 用于实现业务对象当前阶段和当前环节状态更新
	public abstract void updateObjCurPhaseAndCurStatus(String objId,String objType,String linkId) throws Exception;
}
