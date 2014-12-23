package com.asiainfo.csc.matrix.threads;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ai.appframe2.queue.QueueTask;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.common.define.ParametersUtil;
import com.asiainfo.csc.matrix.common.ConstDefine;
import com.asiainfo.csc.matrix.common.impl.AlmVmTaskImpl;
import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowCaseValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;
import com.asiainfo.csc.matrix.ivalues.IBOScheduleValue;
import com.asiainfo.csc.matrix.ivalues.IBOTopoViewValue;


public class AlmMatrixQueue implements QueueTask{
	
	private final static transient Log log = LogFactory.getLog(AlmMatrixQueue.class);
	 

	/**

	* 执行制定任务编号的任务

	* @param taskId queryTaskList()返回的list中的元素

	* @return boolean 是否处理成功，这里的返回值只是用于统计处理的成功失败数量，对扫描对象没有特殊处理

	*/
	public boolean execute(Object taskId) throws Exception {
		//2在ALM_WORKORDER 表中查找 IS_CURRENT_TASK is null  status=3的主工单
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_IsCurrentTask, ConstDefine.IS_CURRENT_TASK);
		sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_COMPLETE);
		sql.addEqual(IBOAlmWorkorderValue.S_WorkflowId, taskId.toString());
		IBOAlmWorkorderValue[] workorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(workorders.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("矩阵工作流调度程序查找当前工单时出错，查找到的工单数不唯一；查询条件为【");
				sb.append(IBOAlmWorkorderValue.S_IsCurrentTask +":" + ConstDefine.IS_CURRENT_TASK + ",");
				sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_COMPLETE + ",");
				sb.append(IBOAlmWorkorderValue.S_WorkflowId +":" + taskId.toString());
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				sql = new Criteria();
				sql.addEqual(IBOScheduleValue.S_WorkflowId, Long.parseLong(taskId.toString()));
				IBOScheduleValue[] schedules = BusiFactory.getAlmScheduleSV().getScheduleByCondition(sql.toString(), sql.getParameters());
				if(schedules.length!=0&&schedules!=null){
					schedules[0].setState(ConstDefine.WO_SCHEDULE_STATUS_END);
					BusiFactory.getAlmScheduleSV().saveSchedule(schedules);
				}
				sql = new Criteria();
				sql.addEqual(IBOAlmWorkflowCaseValue.S_TaskId, Long.parseLong(taskId.toString()));
				IBOAlmWorkflowCaseValue[] iBOAlmWorkflowCaseValues = BusiFactory.getAlmWorkflowCaseSV().getAlmWorkflowCaseByCondition(sql.toString(), sql.getParameters());
				if(iBOAlmWorkflowCaseValues.length!=0&&iBOAlmWorkflowCaseValues!=null){
					iBOAlmWorkflowCaseValues[0].setState(ConstDefine.WF_CASE_STATUS_EX);
					BusiFactory.getAlmWorkflowCaseSV().saveAlmWorkflowCase(iBOAlmWorkflowCaseValues);
				}
				throw new Exception(sb.toString());
			}
		}
		//4.执行cond 关联fun函数
		IBOTopoViewValue[] topoViewValue = BusiFactory.getAlmTopoViewSV().getTopoByFpointAndCond(String.valueOf(workorders[0].getLinkId()),workorders[0].getCond());
		if(topoViewValue.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("找到相应的关系配置处理，查询结果不唯一；查询条件为【");
				sb.append(IBOTopoViewValue.S_Fpoint +":" + workorders[0].getLinkId() + ",");
				sb.append(IBOTopoViewValue.S_Cond +":" + workorders[0].getCond());
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				sql = new Criteria();
				sql.addEqual(IBOScheduleValue.S_WorkflowId, Long.parseLong(taskId.toString()));
				IBOScheduleValue[] schedules = BusiFactory.getAlmScheduleSV().getScheduleByCondition(sql.toString(), sql.getParameters());
				if(schedules.length!=0&&schedules!=null){
					schedules[0].setState(ConstDefine.WO_SCHEDULE_STATUS_END);
					BusiFactory.getAlmScheduleSV().saveSchedule(schedules);
				}
				sql = new Criteria();
				sql.addEqual(IBOAlmWorkflowCaseValue.S_TaskId, Long.parseLong(taskId.toString()));
				IBOAlmWorkflowCaseValue[] iBOAlmWorkflowCaseValues = BusiFactory.getAlmWorkflowCaseSV().getAlmWorkflowCaseByCondition(sql.toString(), sql.getParameters());
				if(iBOAlmWorkflowCaseValues.length!=0&&iBOAlmWorkflowCaseValues!=null){
					iBOAlmWorkflowCaseValues[0].setState(ConstDefine.WF_CASE_STATUS_EX);
					BusiFactory.getAlmWorkflowCaseSV().saveAlmWorkflowCase(iBOAlmWorkflowCaseValues);
				}
				throw new Exception(sb.toString());
			}
		}
		
		sql = new Criteria();
		sql.addEqual(IBOAlmWorkflowValue.S_LinkId, topoViewValue[0].getTpoint());
		IBOAlmWorkflowValue[] workflows = BusiFactory.getAlmWorkflowSV().getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
		if(workflows.length == 0){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("未找到相应的关系配置；查询条件为【");
				sb.append(IBOAlmWorkflowValue.S_LinkId +":" + topoViewValue[0].getTpoint());
				sb.append("】");
				sb.append("SQL:" + sql.toString());
				log.error(sb);
				sql = new Criteria();
				sql.addEqual(IBOScheduleValue.S_WorkflowId, Long.parseLong(taskId.toString()));
				IBOScheduleValue[] schedules = BusiFactory.getAlmScheduleSV().getScheduleByCondition(sql.toString(), sql.getParameters());
				if(schedules.length!=0&&schedules!=null){
					schedules[0].setState(ConstDefine.WO_SCHEDULE_STATUS_END);
					BusiFactory.getAlmScheduleSV().saveSchedule(schedules);
				}
				sql = new Criteria();
				sql.addEqual(IBOAlmWorkflowCaseValue.S_TaskId, Long.parseLong(taskId.toString()));
				IBOAlmWorkflowCaseValue[] iBOAlmWorkflowCaseValues = BusiFactory.getAlmWorkflowCaseSV().getAlmWorkflowCaseByCondition(sql.toString(), sql.getParameters());
				if(iBOAlmWorkflowCaseValues.length!=0&&iBOAlmWorkflowCaseValues!=null){
					iBOAlmWorkflowCaseValues[0].setState(ConstDefine.WF_CASE_STATUS_EX);
					BusiFactory.getAlmWorkflowCaseSV().saveAlmWorkflowCase(iBOAlmWorkflowCaseValues);
				}
				throw new Exception(sb.toString());
			}
		}
		String fun = topoViewValue[0].getFun();
		int endIndex = fun.lastIndexOf(".");
		String serviceId = fun.substring(0,endIndex);
		String methodName = fun.substring(endIndex+1);
		Object funCase = ServiceFactory.getService(serviceId);
		Class funClass = funCase.getClass();
		//fun中参数类表 workflow_id、last_order_id、obj_id、obj_type、Link_no,Link_no_type
		Class[] parameterTypes = {Long.class,Long.class,Long.class,String.class,String.class,Long.class,String.class};
		Object[] parameterValues = {workorders[0].getWorkflowId(),workorders[0].getOrderId(),workorders[0].getObjId(),workorders[0].getObjType(),workflows[0].getLinkNo(),workflows[0].getLinkId(),workflows[0].getLinkNoType()};
		Method method = funClass.getMethod(methodName, parameterTypes);
		method.invoke(funCase, parameterValues);
		
		//is_current_task置为N
		workorders[0].setIsCurrentTask(ConstDefine.IS_NOT_CURRENT_TASK);
		BusiFactory.getAlmWorkorderSV().saveAlmWorkorder(workorders);
		//修改ALM_SCHEDULE调度表状态
		sql = new Criteria();
		sql.addEqual(IBOScheduleValue.S_WorkflowId, Long.parseLong(taskId.toString()));
		IBOScheduleValue[] schedules = BusiFactory.getAlmScheduleSV().getScheduleByCondition(sql.toString(), sql.getParameters());
		if(schedules.length!=0&&schedules!=null){
			schedules[0].setState(ConstDefine.WO_SCHEDULE_STATUS_END);
			BusiFactory.getAlmScheduleSV().saveSchedule(schedules);
		}
		return true;
	}
	/**

	* 根据给定的条件获取任务列表

	* @param queueNum 在表queue_schedule_list中为某任务类型配置的处理队列的个数

	* @param queryCondition 获取任务的条件

	* @param fetchNum 每次取得的任务数量

	* @return List

	*/


	public List queryTaskList(int queueNum, List queryCondition, int fetchNum) throws Exception {
		int intervalInt = 1;
		try 
		{
			String interval = ParametersUtil.getPro("OAJob_interval");
			intervalInt = Integer.parseInt(interval);
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("配置文件interfaceConfig.properties中OAJob_interval配置错误");
			intervalInt = 1;
		}
		Thread.sleep(intervalInt*60*1000);
		List taskIds = new ArrayList();
		String condition = "";
		Map<String,String> paramter = new HashMap<String,String>();
		paramter.put("state", ConstDefine.WO_SCHEDULE_STATUS_WAIT);
		for(Object i : queryCondition){
			if("".equals(condition))
				condition = i.toString();
			else
				condition = condition + "," + i.toString();
		}
		condition = " mod(WORKFLOW_ID," + queueNum + ") in(" + condition + ") and rownum<=" + fetchNum + " and STATE=:state";
		//1在ALM_SCHEDULE 查找可以调动的流程
		IBOScheduleValue[] schedules = BusiFactory.getAlmScheduleSV().getScheduleByCondition(condition, paramter);
		for(IBOScheduleValue schedule : schedules){
			taskIds.add(schedule.getWorkflowId());
		}
		return taskIds;
	}
	
}
