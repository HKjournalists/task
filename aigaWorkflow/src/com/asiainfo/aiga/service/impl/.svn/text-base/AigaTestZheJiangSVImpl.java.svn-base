package com.asiainfo.aiga.service.impl;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.aiga.ivalues.IBOAigaLinkTimeConfigValue;
import com.asiainfo.aiga.ivalues.IBOAigaSolidTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaSpecialDayConfigValue;
import com.asiainfo.aiga.ivalues.IBOAigaSubTaskProblemValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestPlanValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestSubTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestTaskValue;
import com.asiainfo.aiga.service.interfaces.IAigaLinkTimeConfigSV;
import com.asiainfo.aiga.service.interfaces.IAigaSolidTaskSV;
import com.asiainfo.aiga.service.interfaces.IAigaSpecialDayConfigSV;
import com.asiainfo.aiga.service.interfaces.IAigaTestPlanSV;
import com.asiainfo.aiga.service.interfaces.IAigaTestSubTaskSV;
import com.asiainfo.aiga.service.interfaces.IAigaTestTaskSV;
import com.asiainfo.aiga.service.interfaces.IAigaTestZheJiangSV;
import com.asiainfo.csc.common.define.IObjectType;
import com.asiainfo.csc.common.define.WorkFlowParam;
import com.asiainfo.csc.matrix.common.AlmMatrixClient;
import com.asiainfo.csc.matrix.common.ConstDefine;
import com.asiainfo.csc.matrix.common.impl.AlmVmTaskImpl;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkorderSV;
import com.ibm.db2.jcc.b.i;
import com.sun.tools.internal.xjc.reader.xmlschema.bindinfo.BIConversion.Static;

public class AigaTestZheJiangSVImpl extends AlmVmTaskImpl implements IAigaTestZheJiangSV{
	
	private final static transient Log log = LogFactory.getLog(AlmVmTaskImpl.class);
	public void userPreTask(long workflowId, String workflowTag, long taskId, String taskTag, String objId, String objType) throws Exception
	{
		super.userPreTask(workflowId, workflowTag, taskId, taskTag, objId, objType);
	}
	public void userRearTask(long workflowId, String workflowTag, long taskId, String taskTag, String objId, String objType) throws Exception
	{
		super.userRearTask(workflowId, workflowTag, taskId, taskTag, objId, objType);
	}
	
	public void signPreTask(long workflowId, String workflowTag,
			long taskId, String taskTag, String objId, String objType)
			throws Exception
	{
		super.signPreTask(workflowId, workflowTag, taskId, taskTag, objId, objType);
	}
	//会签环节后置任务
	public String signRearTask(long workflowId, String workflowTag,long taskId, String taskTag, String objId, String objType)throws Exception 
	{
		return super.signRearTask(workflowId, workflowTag, taskId, taskTag, objId, objType);
		
	}
	public void finishTask(long workflowId, String workflowTag, String objId, String objType) throws Exception
	{
		super.finishTask(workflowId, workflowTag, objId, objType);
		
		if(objType.equals(IObjectType.SUBTESTTASK) || objType.equals(IObjectType.EAESUBTEST) || objType.equals(IObjectType.PERFTASK_FOLLOW))//如果是不同子任务回单
		{
			//根据子任务id找到taskid
			IAigaTestSubTaskSV iAigaTestSubTaskSV  = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
			IAlmWorkorderSV iAlmWorkorderSV  = (IAlmWorkorderSV)ServiceFactory.getService(IAlmWorkorderSV.class);
			
			IBOAigaTestSubTaskValue iBOAigaTestSubTaskValue = iAigaTestSubTaskSV.getAigaTestSubTaskBySubTaskId(objId);
			if(iBOAigaTestSubTaskValue != null)
			{
				//根据taskid查到所有子任务，判断子任务状态，如果都为结束，则结束taskid的工单
				//如果有一条不是，则跳出
				boolean temp = true;
				Criteria sqlCriteria = new Criteria();
				sqlCriteria.addEqual(IBOAigaTestSubTaskValue.S_TaskId, iBOAigaTestSubTaskValue.getTaskId());
				IBOAigaTestSubTaskValue[] iAigaTestSubTaskValues = iAigaTestSubTaskSV.getAigaTestSubTasks(sqlCriteria.toString(),sqlCriteria.getParameters());
				if(iAigaTestSubTaskValues!=null && iAigaTestSubTaskValues.length>0)
				{
					for(IBOAigaTestSubTaskValue value : iAigaTestSubTaskValues)
					{
						if(value.getSubTaskStatus() == 699 || value.getSubTaskStatus() == 799 || value.getSubTaskStatus() == 899 )
						{
							temp = true;
						}else {
							temp = false;
							break;
						}
					}
					if(temp)//如果都完成，则查询测试任务工单，然后结束工单
					{
						sqlCriteria.clear();
						sqlCriteria.addEqual(IBOAlmWorkorderValue.S_ObjId, iBOAigaTestSubTaskValue.getTaskId());
						if(objType.equals(IObjectType.SUBTESTTASK))
							sqlCriteria.addEqual(IBOAlmWorkorderValue.S_ObjType, IObjectType.TESTTASK);
						else if(objType.equals(IObjectType.EAESUBTEST))
							sqlCriteria.addEqual(IBOAlmWorkorderValue.S_ObjType, IObjectType.UETTASKT);
						else if(objType.equals(IObjectType.PERFTASK_FOLLOW))
							sqlCriteria.addEqual(IBOAlmWorkorderValue.S_ObjType, IObjectType.PERFTASK_FOLLOW);
						sqlCriteria.addEqual(IBOAlmWorkorderValue.S_Status, ConstDefine.WO_STATUS_RECEIVE);
						IBOAlmWorkorderValue[] iWorkorderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sqlCriteria.toString(), sqlCriteria.getParameters());
						if(iWorkorderValues!=null && iWorkorderValues.length>0)
						{
							String condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";

							AlmMatrixClient amc = new AlmMatrixClient();
							amc.finishUserTask(iWorkorderValues[0].getOrderId(), "Y", "所有子任务都已完成", condString);
						}
						
					}
				}
			}

		}
		
	}
	//流程结果环节任务 此方法需要人为制定工作流完成时 业务对象当前环节编号
	//目的将所有工单移至历史表中
	public void finishTask(long workflowId, String workflowTag, String objId, String objType, String linkNo) throws Exception
	{
		WorkFlowParam workflowParam = WorkFlowParam.getInstance();
		super.finishTask(workflowId, workflowTag, objId, objType, linkNo);

	}

	@Override
	public void extraMethod(long orderId, String objId, String objType,
			String methodType) throws Exception {
		// TODO Auto-generated method stub
		WorkFlowParam workflowParam = WorkFlowParam.getInstance();
		IAigaLinkTimeConfigSV iAigaLinkTimeConfigSV = (IAigaLinkTimeConfigSV)ServiceFactory.getService(IAigaLinkTimeConfigSV.class);
		
		if(methodType.equals("userPreTask"))//人工前置任务时，计算建议玩完成时间
		{
			IAlmWorkorderSV iAlmWorkorderSV  = (IAlmWorkorderSV)ServiceFactory.getService(IAlmWorkorderSV.class);
			Criteria sqlCriteria = new Criteria();
			sqlCriteria.addEqual(IBOAlmWorkorderValue.S_OrderId, orderId);
			IBOAlmWorkorderValue[] iWorkorderValues = iAlmWorkorderSV.getAlmWorkorderByCondition(sqlCriteria.toString(), sqlCriteria.getParameters());
			if(iWorkorderValues !=null && iWorkorderValues.length == 1)
			{
				if(objType.equals(IObjectType.TESTPLAN))
				{
					//查询测试计划
					IAigaTestPlanSV iAigaTestPlanSV = (IAigaTestPlanSV)ServiceFactory.getService(IAigaTestPlanSV.class);
					IBOAigaTestPlanValue aigaTestPlanValue = iAigaTestPlanSV.getAigaTestPlanByPlanId(String.valueOf(objId));
					//根据测试计划的计划上线时间factCompleteTime，和上线类型onLineType判断
					if(aigaTestPlanValue !=null )
					{
						IBOAigaLinkTimeConfigValue[] aigaLinkTimeConfigValues = iAigaLinkTimeConfigSV.getLinkTimeConfigByLinkMark(iWorkorderValues[0].getLinkNo(),String.valueOf(aigaTestPlanValue.getOnLineType()));
						if(aigaLinkTimeConfigValues !=null && aigaLinkTimeConfigValues.length>0)
						{
							if(aigaLinkTimeConfigValues[0].getBase() == 0){
								Timestamp now = new Timestamp(System.currentTimeMillis());
								iWorkorderValues[0].setAdviceCompTime(generateAdviceTime(now,aigaLinkTimeConfigValues[0].getDayNum(),aigaLinkTimeConfigValues[0].getOperate()));
							}else if(aigaLinkTimeConfigValues[0].getBase() == 1)
								if(aigaTestPlanValue.getFactCompleteTime() !=null)
									iWorkorderValues[0].setAdviceCompTime(generateAdviceTime(aigaTestPlanValue.getFactCompleteTime(),aigaLinkTimeConfigValues[0].getDayNum(),aigaLinkTimeConfigValues[0].getOperate()));
						}	
					}
					
				}else if(objType.equals(IObjectType.TESTTASK))
				{
					System.out.println("进入测试任务extend函数");
					System.out.println("iWorkorderValues[0].getLinkNo()="+iWorkorderValues[0].getLinkNo());
					if(iWorkorderValues[0].getLinkNo().equals(workflowParam.getTESTTASKSPLIT().getLinkNo()))
					{
						IBOAigaLinkTimeConfigValue[] aigaLinkTimeConfigValues = iAigaLinkTimeConfigSV.getLinkTimeConfigByLinkMark(iWorkorderValues[0].getLinkNo(),"0");
						if(aigaLinkTimeConfigValues !=null && aigaLinkTimeConfigValues.length>0)
						{
							Timestamp now = new Timestamp(System.currentTimeMillis());
							iWorkorderValues[0].setAdviceCompTime(generateAdviceTime(now,aigaLinkTimeConfigValues[0].getDayNum(),aigaLinkTimeConfigValues[0].getOperate()));
						}	
					}
				}else if(objType.equals(IObjectType.SUBTESTTASK))
				{
					IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
					IBOAigaTestSubTaskValue aigaTestSubTaskValue = iAigaTestSubTaskSV.getAigaTestSubTaskBySubTaskId(String.valueOf(objId));
					if(aigaTestSubTaskValue != null)
					{
						IBOAigaLinkTimeConfigValue[] aigaLinkTimeConfigValues = iAigaLinkTimeConfigSV.getLinkTimeConfigByLinkMark(iWorkorderValues[0].getLinkNo(),"0");
						if(aigaLinkTimeConfigValues !=null && aigaLinkTimeConfigValues.length>0)
						{
							if(aigaLinkTimeConfigValues[0].getBase() == 0){
								Timestamp now = new Timestamp(System.currentTimeMillis());
								iWorkorderValues[0].setAdviceCompTime(generateAdviceTime(now,aigaLinkTimeConfigValues[0].getDayNum(),aigaLinkTimeConfigValues[0].getOperate()));
							}else if(aigaLinkTimeConfigValues[0].getBase() == 1)
							{
								if(aigaTestSubTaskValue.getFactCompleteTime() !=null)
									iWorkorderValues[0].setAdviceCompTime(generateAdviceTime(aigaTestSubTaskValue.getFactCompleteTime(),aigaLinkTimeConfigValues[0].getDayNum(),aigaLinkTimeConfigValues[0].getOperate()));
							}
						}	
					}
				}else if(objType.equals(IObjectType.EAESUBTEST))
				{
					IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
					IBOAigaTestSubTaskValue aigaTestSubTaskValue = iAigaTestSubTaskSV.getAigaTestSubTaskBySubTaskId(String.valueOf(objId));
					if(aigaTestSubTaskValue != null)
					{
						IBOAigaLinkTimeConfigValue[] aigaLinkTimeConfigValues = iAigaLinkTimeConfigSV.getLinkTimeConfigByLinkMark(iWorkorderValues[0].getLinkNo(),"0");
						if(aigaLinkTimeConfigValues !=null && aigaLinkTimeConfigValues.length>0)
						{
							if(aigaLinkTimeConfigValues[0].getBase() == 0){
								Timestamp now = new Timestamp(System.currentTimeMillis());
								iWorkorderValues[0].setAdviceCompTime(generateAdviceTime(now,aigaLinkTimeConfigValues[0].getDayNum(),aigaLinkTimeConfigValues[0].getOperate()));
							}else if(aigaLinkTimeConfigValues[0].getBase() == 1)
								if(aigaTestSubTaskValue.getFactCompleteTime() !=null)
									iWorkorderValues[0].setAdviceCompTime(generateAdviceTime(aigaTestSubTaskValue.getFactCompleteTime(),aigaLinkTimeConfigValues[0].getDayNum(),aigaLinkTimeConfigValues[0].getOperate()));
						}	
					}
				}else if(objType.equals(IObjectType.PERFSUBTEST))
				{
					
				}else if(objType.equals(IObjectType.PERFTASK_FOLLOW))
				{
					
				}else if(objType.equals(IObjectType.PROBLEM_FOLLOW))
				{
					IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
					IBOAigaSubTaskProblemValue aigaSubTaskProblemValue = iAigaTestSubTaskSV.getAigaSubTaskProblemById(String.valueOf(objId));
					if(aigaSubTaskProblemValue != null)
					{
						Timestamp now = new Timestamp(System.currentTimeMillis());
						iWorkorderValues[0].setAdviceCompTime(generateAdviceTime(now,1,1));
//						IBOAigaLinkTimeConfigValue[] aigaLinkTimeConfigValues = iAigaLinkTimeConfigSV.getLinkTimeConfigByLinkMark(iWorkorderValues[0].getLinkNo(),"0");
//						if(aigaLinkTimeConfigValues !=null && aigaLinkTimeConfigValues.length>0)
//						{
//							if(aigaLinkTimeConfigValues[0].getBase() == 0){
//								Timestamp now = new Timestamp(System.currentTimeMillis());
//								iWorkorderValues[0].setAdviceCompTime(generateAdviceTime(now,aigaLinkTimeConfigValues[0].getDayNum(),aigaLinkTimeConfigValues[0].getOperate()));
//							}else if(aigaLinkTimeConfigValues[0].getBase() == 1)
//							{
//								if(aigaTestSubTaskValue.getPlCompleteTime() !=null)
//									iWorkorderValues[0].setAdviceCompTime(generateAdviceTime(aigaTestSubTaskValue.getPlCompleteTime(),aigaLinkTimeConfigValues[0].getDayNum(),aigaLinkTimeConfigValues[0].getOperate()));
//							}
//						}	
					}
				}else if(objType.equals(IObjectType.SOLIDTESTTASK_SECUTEST) || objType.equals(IObjectType.SOLIDTESTTASK_PERFTEST)
						|| objType.equals(IObjectType.SOLIDTESTTASK_CODESCAN) || objType.equals(IObjectType.SOLIDTESTTASK_REGRTEST)
						|| objType.equals(IObjectType.SOLIDTESTTASK_REGRTEST_HW))
				{
					IAigaSolidTaskSV iAigaSolidTaskSV = (IAigaSolidTaskSV)ServiceFactory.getService(IAigaSolidTaskSV.class);
					IBOAigaSolidTaskValue aigaSolidTaskValue = iAigaSolidTaskSV.getAigaSolidTaskByTaskId(String.valueOf(objId));
					//根据测试计划的计划上线时间factCompleteTime，和上线类型onLineType判断
					if(aigaSolidTaskValue !=null )
					{
						IBOAigaLinkTimeConfigValue[] aigaLinkTimeConfigValues = iAigaLinkTimeConfigSV.getLinkTimeConfigByLinkMark(iWorkorderValues[0].getLinkNo(),String.valueOf(aigaSolidTaskValue.getOnLineType()));
						if(aigaLinkTimeConfigValues !=null && aigaLinkTimeConfigValues.length>0)
						{
							if(aigaLinkTimeConfigValues[0].getBase() == 0){
								Timestamp now = new Timestamp(System.currentTimeMillis());
								iWorkorderValues[0].setAdviceCompTime(generateAdviceTime(now,aigaLinkTimeConfigValues[0].getDayNum(),aigaLinkTimeConfigValues[0].getOperate()));
							}else if(aigaLinkTimeConfigValues[0].getBase() == 1)
								iWorkorderValues[0].setAdviceCompTime(generateAdviceTime(aigaSolidTaskValue.getFactCompleteTime(),aigaLinkTimeConfigValues[0].getDayNum(),aigaLinkTimeConfigValues[0].getOperate()));
							
						}	
					}
				}
//				else if(objType.equals(IObjectType.SOLIDTESTTASK_PERFTEST))
//				{
//					
//				}else if(objType.equals(IObjectType.SOLIDTESTTASK_CODESCAN))
//				{
//					
//				}else if(objType.equals(IObjectType.SOLIDTESTTASK_REGRTEST))
//				{
//					
//				}else if(objType.equals(IObjectType.SOLIDTESTTASK_REGRTEST_HW))
//				{
//					
//				}
				//保存建议处理时间
				iAlmWorkorderSV.saveAlmWorkorder(iWorkorderValues[0]);
			}
		}
	}
	
	public Timestamp generateAdviceTime(Timestamp startTime, long dayNum, long operate) throws Exception
	{
		//计算时间，并计算节假日，跨年情况
		Timestamp returnTimestamp = startTime;
		if(operate == 0)//T减
		{
			for(int i = (int)dayNum; i>0; i--)
			{
				if(isHoliday(returnTimestamp)){
					returnTimestamp = new Timestamp(returnTimestamp.getTime() - 86400000);
					i++;
					continue;
				}
				returnTimestamp = new Timestamp(returnTimestamp.getTime() - 86400000);
			}
			
		}else if(operate == 1)//T加
		{
			for(int i = 0; i<dayNum; i++)
			{
				if(isHoliday(returnTimestamp)){
					returnTimestamp = new Timestamp(returnTimestamp.getTime() + 86400000);
					i--;
					continue;
				}
				returnTimestamp = new Timestamp(returnTimestamp.getTime() + 86400000);
			}
		}
		
		return returnTimestamp;
	}
	
	public boolean isHoliday(Timestamp dayTime) throws Exception
	{
		boolean isHoliday = false;
		IAigaSpecialDayConfigSV iAigaSpecialDayConfigSV = (IAigaSpecialDayConfigSV)ServiceFactory.getService(IAigaSpecialDayConfigSV.class);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//定义格式
	    String str = sdf.format(dayTime);
	    Date date =sdf.parse(str);  
	    Calendar calendar = Calendar.getInstance();  
	    calendar.setTime(date); 
	    int nowDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);//周日周一到周六返回值分别为1--7
	    
	    if(nowDayOfWeek == 1 || nowDayOfWeek == 7)//判断是否为周六日
	    {
	    	IBOAigaSpecialDayConfigValue[] aigaSpecialDayConfigValue = iAigaSpecialDayConfigSV.getSpecialDayByDayTimeMark(str,"0");
	    	if(aigaSpecialDayConfigValue!=null && aigaSpecialDayConfigValue.length >0)
	    		isHoliday = false;
	    	else {
	    		isHoliday = true;
			}
	    }else if (nowDayOfWeek>1 && nowDayOfWeek<7)//判断是否为周一到周五
	    {
	    	IBOAigaSpecialDayConfigValue[] aigaSpecialDayConfigValue = iAigaSpecialDayConfigSV.getSpecialDayByDayTimeMark(str,"1");
	    	if(aigaSpecialDayConfigValue!=null && aigaSpecialDayConfigValue.length >0)
	    		isHoliday = true;
	    	else {
	    		isHoliday = false;
			}
	    }
		return isHoliday;
		
	}
//	public static void main(String[] args) throws Exception
//	{
//		 Timestamp now = new Timestamp(System.currentTimeMillis());//获取系统当前时间
//		 
//		 Timestamp ts = new Timestamp(System.currentTimeMillis());   
//	     String tsStr = "2014-10-14 00:00:00";   
//	     ts = Timestamp.valueOf(tsStr);  
//		 AigaTestZheJiangSVImpl aAigaTestZheJiangSVImpl = new AigaTestZheJiangSVImpl();
//
//		 System.out.println(aAigaTestZheJiangSVImpl.generateAdviceTime(ts, 10, 1));
//	}
	
	
	@Override
	public void updateObjCurPhaseAndCurStatus(String objId, String objType,
			String linkId) throws Exception {
		// TODO Auto-generated method stub
		try{
			WorkFlowParam workflowParam = WorkFlowParam.getInstance();
			IBOAlmWorkflowValue iWorkflowValue = workflowParam.getWorkflowByLinkId(Long.parseLong(linkId));
			if(objType.equals(IObjectType.TESTPLAN))
			{
				
				if(iWorkflowValue==null){
					throw new Exception("更新测试计划状态失败,环节数据:【"+"planId:"+objId+",环节编号"+linkId+"】,出错原因:没有在WorkFlowParam对象中找到环节" + linkId +"的配置信息！");
				}
				IAigaTestPlanSV iAigaTestPlanSV = (IAigaTestPlanSV)ServiceFactory.getService(IAigaTestPlanSV.class);
				IBOAigaTestPlanValue iBOAigaTestPlanValue = iAigaTestPlanSV.getAigaTestPlanByPlanId(objId);
				iBOAigaTestPlanValue.setPlanPhase(Integer.parseInt(iWorkflowValue.getPhaseId()));
				iBOAigaTestPlanValue.setPlanStatus((int)iWorkflowValue.getLinkId());
				iAigaTestPlanSV.saveAigaTestPlan(iBOAigaTestPlanValue);
			}else if(objType.equals(IObjectType.TESTTASK) || objType.equals(IObjectType.UETTASKT) || objType.equals(IObjectType.PERFTASK_FOLLOW))
			{
				if(iWorkflowValue==null){
					throw new Exception("更新测试任务失败,环节数据:【"+"reqId:"+objId+",环节编号"+linkId+"】,出错原因:没有在WorkFlowParam对象中找到环节" + linkId +"的配置信息！");
				}
				IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
				IBOAigaTestTaskValue iBOAigaTestTaskValue = iAigaTestTaskSV.getAigaTestTaskByTaskId(objId);	
				iBOAigaTestTaskValue.setTaskPhase(Long.valueOf(iWorkflowValue.getPhaseId()));
				iBOAigaTestTaskValue.setCurrentStatus((int)iWorkflowValue.getLinkId());
				iAigaTestTaskSV.saveAigaTestTask(iBOAigaTestTaskValue);
			}else if(objType.equals(IObjectType.SUBTESTTASK) || objType.equals(IObjectType.EAESUBTEST) ||
					objType.equals(IObjectType.PERFSUBTEST))
			{
				if(iWorkflowValue==null){
					throw new Exception("更新子任务状态失败,环节数据:【"+"reqId:"+objId+",环节编号"+linkId+"】,出错原因:没有在WorkFlowParam对象中找到环节" + linkId +"的配置信息！");
				}
				IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
				IBOAigaTestSubTaskValue iAigaTestSubTaskValue = iAigaTestSubTaskSV.getAigaTestSubTaskBySubTaskId(objId);
				iAigaTestSubTaskValue.setCurPhase(Integer.parseInt(iWorkflowValue.getPhaseId()));
				iAigaTestSubTaskValue.setSubTaskStatus((int)iWorkflowValue.getLinkId());
				iAigaTestSubTaskSV.saveAigaTestSubTask(iAigaTestSubTaskValue);
			}else if(objType.equals(IObjectType.SOLIDTESTTASK_SECUTEST) || objType.equals(IObjectType.SOLIDTESTTASK_PERFTEST)
					|| objType.equals(IObjectType.SOLIDTESTTASK_REGRTEST) || objType.equals(IObjectType.SOLIDTESTTASK_CODESCAN)
					|| objType.equals(IObjectType.SOLIDTESTTASK_REGRTEST_HW))
			{
				if(iWorkflowValue==null){
					throw new Exception("更新固化任务状态失败,环节数据:【"+"taskId:"+objId+",环节编号"+linkId+"】,出错原因:没有在WorkFlowParam对象中找到环节" + linkId +"的配置信息！");
				}
				IAigaSolidTaskSV iAigaSolidTaskSV = (IAigaSolidTaskSV)ServiceFactory.getService(IAigaSolidTaskSV.class);
				IBOAigaSolidTaskValue iasTaskValue = iAigaSolidTaskSV.getAigaSolidTaskByTaskId(objId);				
				iasTaskValue.setTaskStatus((int)iWorkflowValue.getLinkId());
				iasTaskValue.setTaskPhase(Integer.parseInt(iWorkflowValue.getPhaseId()));
				iAigaSolidTaskSV.saveAigaSolidTask(iasTaskValue);
			}else if(objType.equals(IObjectType.PROBLEM_FOLLOW) )
			{
				if(iWorkflowValue==null){
					throw new Exception("更新问题跟踪状态失败,环节数据:【"+"taskId:"+objId+",环节编号"+linkId+"】,出错原因:没有在WorkFlowParam对象中找到环节" + linkId +"的配置信息！");
				}
				IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
				IBOAigaSubTaskProblemValue aigaSubTaskProblemValue = iAigaTestSubTaskSV.getAigaSubTaskProblemById(objId);				
				aigaSubTaskProblemValue.setStpStatus((int)iWorkflowValue.getLinkId());
				aigaSubTaskProblemValue.setStpPhase(Integer.parseInt(iWorkflowValue.getPhaseId()));
				iAigaTestSubTaskSV.saveAigaSubTaskProblem(aigaSubTaskProblemValue);
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception("在前后置任务总更新对象状态失败失败！\n\n错误原因："+ (e.getCause() == null ? e.getMessage() : e.getCause().getMessage()),e);
		}
	}

}
