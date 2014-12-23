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

	* ִ���ƶ������ŵ�����

	* @param taskId queryTaskList()���ص�list�е�Ԫ��

	* @return boolean �Ƿ���ɹ�������ķ���ֵֻ������ͳ�ƴ���ĳɹ�ʧ����������ɨ�����û�����⴦��

	*/
	public boolean execute(Object taskId) throws Exception {
		//2��ALM_WORKORDER ���в��� IS_CURRENT_TASK is null  status=3��������
		Criteria sql = new Criteria();
		sql.addEqual(IBOAlmWorkorderValue.S_IsCurrentTask, ConstDefine.IS_CURRENT_TASK);
		sql.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_COMPLETE);
		sql.addEqual(IBOAlmWorkorderValue.S_WorkflowId, taskId.toString());
		IBOAlmWorkorderValue[] workorders = BusiFactory.getAlmWorkorderSV().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
		if(workorders.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("�����������ȳ�����ҵ�ǰ����ʱ�������ҵ��Ĺ�������Ψһ����ѯ����Ϊ��");
				sb.append(IBOAlmWorkorderValue.S_IsCurrentTask +":" + ConstDefine.IS_CURRENT_TASK + ",");
				sb.append(IBOAlmWorkorderValue.S_Status +":" + ConstDefine.WO_STATUS_COMPLETE + ",");
				sb.append(IBOAlmWorkorderValue.S_WorkflowId +":" + taskId.toString());
				sb.append("��");
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
		//4.ִ��cond ����fun����
		IBOTopoViewValue[] topoViewValue = BusiFactory.getAlmTopoViewSV().getTopoByFpointAndCond(String.valueOf(workorders[0].getLinkId()),workorders[0].getCond());
		if(topoViewValue.length != 1){
			if (log.isErrorEnabled()) {
				StringBuffer sb = new StringBuffer();
				sb.append("�ҵ���Ӧ�Ĺ�ϵ���ô�����ѯ�����Ψһ����ѯ����Ϊ��");
				sb.append(IBOTopoViewValue.S_Fpoint +":" + workorders[0].getLinkId() + ",");
				sb.append(IBOTopoViewValue.S_Cond +":" + workorders[0].getCond());
				sb.append("��");
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
				sb.append("δ�ҵ���Ӧ�Ĺ�ϵ���ã���ѯ����Ϊ��");
				sb.append(IBOAlmWorkflowValue.S_LinkId +":" + topoViewValue[0].getTpoint());
				sb.append("��");
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
		//fun�в������ workflow_id��last_order_id��obj_id��obj_type��Link_no,Link_no_type
		Class[] parameterTypes = {Long.class,Long.class,Long.class,String.class,String.class,Long.class,String.class};
		Object[] parameterValues = {workorders[0].getWorkflowId(),workorders[0].getOrderId(),workorders[0].getObjId(),workorders[0].getObjType(),workflows[0].getLinkNo(),workflows[0].getLinkId(),workflows[0].getLinkNoType()};
		Method method = funClass.getMethod(methodName, parameterTypes);
		method.invoke(funCase, parameterValues);
		
		//is_current_task��ΪN
		workorders[0].setIsCurrentTask(ConstDefine.IS_NOT_CURRENT_TASK);
		BusiFactory.getAlmWorkorderSV().saveAlmWorkorder(workorders);
		//�޸�ALM_SCHEDULE���ȱ�״̬
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

	* ���ݸ�����������ȡ�����б�

	* @param queueNum �ڱ�queue_schedule_list��Ϊĳ�����������õĴ�����еĸ���

	* @param queryCondition ��ȡ���������

	* @param fetchNum ÿ��ȡ�õ���������

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
			System.out.println("�����ļ�interfaceConfig.properties��OAJob_interval���ô���");
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
		//1��ALM_SCHEDULE ���ҿ��Ե���������
		IBOScheduleValue[] schedules = BusiFactory.getAlmScheduleSV().getScheduleByCondition(condition, paramter);
		for(IBOScheduleValue schedule : schedules){
			taskIds.add(schedule.getWorkflowId());
		}
		return taskIds;
	}
	
}
