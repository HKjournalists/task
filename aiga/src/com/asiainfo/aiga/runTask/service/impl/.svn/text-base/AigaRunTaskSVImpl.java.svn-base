package com.asiainfo.aiga.runTask.service.impl;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.log.bo.AigaLogTestCase;
import com.asiainfo.aiga.log.dao.IAigaLogDao;
import com.asiainfo.aiga.r_collect_case.bo.AigaRFunCase;
import com.asiainfo.aiga.runPlan.bo.AigaRunPlan;
import com.asiainfo.aiga.runPlan.dao.IAigaRunPlanDAO;
import com.asiainfo.aiga.runTask.bo.AigaHisRunTaskResult;
import com.asiainfo.aiga.runTask.bo.AigaRunTask;
import com.asiainfo.aiga.runTask.dao.IAigaRunTaskDAO;
import com.asiainfo.aiga.runTask.service.IAigaRunTaskSV;

public class AigaRunTaskSVImpl implements IAigaRunTaskSV {

	private IAigaRunTaskDAO aigaRunTaskDAO;
	private IAigaLogDao aigaLogDao;
	private IAigaRunPlanDAO aigaRunPlanDAO;
	
	public void setAigaRunPlanDAO(IAigaRunPlanDAO aigaRunPlanDAO) {
		this.aigaRunPlanDAO = aigaRunPlanDAO;
	}

	public void setAigaLogDao(IAigaLogDao aigaLogDao) {
		this.aigaLogDao = aigaLogDao;
	}

	public void setAigaRunTaskDAO(IAigaRunTaskDAO aigaRunTaskDAO) {
		this.aigaRunTaskDAO = aigaRunTaskDAO;
	}

	@Override
	public void saveAigaRunTask(AigaRunTask aValue) throws Exception {
		aigaRunTaskDAO.saveOrUpdate(aValue);
	}

	@Override
	public void deleteAigaRunTask(AigaRunTask aValue) throws Exception {
		aigaRunTaskDAO.delete(aValue);
	}

	@Override
	public AigaLogTestCase[] getAigaLogTestCaseByRunId(Integer runId)
			throws Exception {
		DetachedCriteria criteria = DetachedCriteria
				.forClass(AigaLogTestCase.class);
		criteria.createAlias("aigaLogSteps", "steps");
		criteria.add(Restrictions.eq("runId", runId));
		return aigaLogDao.getLog(criteria);
	}

	@Override
	public AigaRunTask[] getAigaRunTaskBySubTaskId(Integer subTaskId)
			throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRunTask.class);
		criteria.add(Restrictions.eq("subTaskId", subTaskId));
		return aigaRunTaskDAO.getRunTaskByCriteria(criteria);
	}

	@Override
	public void saveStartTask(String taskId) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRunTask.class);
		criteria.add(Restrictions.eq("taskId", taskId));
		AigaRunTask[] aigaRunTasks = aigaRunTaskDAO.getRunTaskByCriteria(criteria);
		if(aigaRunTasks.length!=1)
			throw new Exception("查找到的执行任务不唯一");
		aigaRunTasks[0].setTaskStatus("2");
		aigaRunTaskDAO.saveOrUpdate(aigaRunTasks[0]);
		
		criteria = DetachedCriteria.forClass(AigaRunPlan.class);
		criteria.add(Restrictions.eq("taskId", taskId));
		AigaRunPlan[] aigaRunPlans = aigaRunPlanDAO.getAigaCaseByCriteria(criteria);
		if(aigaRunPlans.length==1){
			aigaRunPlans[0].setRunTime(new Timestamp(new Date().getTime()));
			aigaRunPlanDAO.saveOrUpdate(aigaRunPlans[0]);
		}
	}

	@Override
	public void deleteAigaRunTask(String taskId) throws Exception {
		// TODO Auto-generated method stub
		AigaRunTask[] aigaRunTasks = aigaRunTaskDAO.getAigaRunTaskBySql("from AigaRunTask where taskId='"+taskId+"'");
		if(aigaRunTasks.length==1){
			aigaRunTaskDAO.delete(aigaRunTasks[0]);
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaRunPlan.class);
			criteria.add(Restrictions.eq("taskId", aigaRunTasks[0].getTaskId()));
			AigaRunPlan[] aigaRunPlans = aigaRunPlanDAO.getAigaCaseByCriteria(criteria);
			for(AigaRunPlan aigaRunPlan : aigaRunPlans){
				aigaRunPlanDAO.delete(aigaRunPlan);
			}
		}
	}

	@Override
	public void saveRunTask(String subTaskId,
			String taskName, Object[] objs)throws Exception {
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRunTask.class);
		AigaRunTask[] aigaRunTasks=new AigaRunTask[3];
		boolean isNull=true;//是否已存在测试任务 true不存在 false存在
		for(int i=0;i<3;i++){
			criteria = DetachedCriteria.forClass(AigaRunTask.class);
			criteria.add(Restrictions.eq("subTaskId", Integer.valueOf(subTaskId)));
			criteria.add(Restrictions.eq("collectType",i+1));
			AigaRunTask aigaRunTask=(aigaRunTaskDAO.getRunTaskByCriteria(criteria).length>0)?aigaRunTaskDAO.getRunTaskByCriteria(criteria)[0]:null;
			if(isNull&&aigaRunTask!=null){isNull=false;}
			aigaRunTasks[i]=aigaRunTask;
		}
		if(isNull){
			//子任务下没有测试任务
			AigaRunTask[] runTask=new AigaRunTask[3];
			List<AigaRunPlan> runPlanList=new ArrayList<AigaRunPlan>();
			for(Object obj:objs){//遍历用例数据
				AigaRFunCase aigaRFunCase=(AigaRFunCase)obj;
				char[] refs=aigaRFunCase.getRefValue().toCharArray();
				for(int i=0;i<refs.length;i++){
					if(refs[i]=='1'){//判断是否测试（准发布/生产）环境用例
						if(runTask[i]==null){
							runTask[i]=createAndSaveAigaRunTask(i+1,Integer.valueOf(subTaskId),taskName);
						}
						//保存测试执行计划
						runPlanList.add(createAigaRunPlan(aigaRFunCase.getCaseId(),runTask[i].getTaskId()));
					}
				}
			}
			aigaRunPlanDAO.saveAigaRunPlan(runPlanList);
		}else{
			//map存放测试（准发布/生产）环境任务
			Map<Integer,List<Integer>> map=new HashMap<Integer,List<Integer>>(){{put(0,new ArrayList<Integer>());put(1,new ArrayList<Integer>());put(2,new ArrayList<Integer>());}};
			for(Object obj:objs){//遍历用例数据
				AigaRFunCase aigaRFunCase=(AigaRFunCase)obj;
				char[] refs=aigaRFunCase.getRefValue().toCharArray();
				for(int i=0;i<refs.length;i++){
					if(refs[i]=='1'){//判断是否测试（准发布/生产）环境用例
						map.get(i).add(aigaRFunCase.getCaseId());
					}
				}
			}
			List<AigaRunPlan> runPlanList=new ArrayList<AigaRunPlan>();
			for(int i=0;i<3;i++){
				if(map.get(i).size()==0&&aigaRunTasks[i]!=null){//删除原有测试任务及所对应的测试执行计划
					aigaRunTaskDAO.delete(aigaRunTasks[i]);//删除测试任务
					AigaRunPlan[] values=aigaRunPlanDAO.getAigaRunPlanBySql("from AigaRunPlan where taskId='"+aigaRunTasks[i].getTaskId()+"'");
					aigaRunPlanDAO.deleteAll(Arrays.asList(values));//删除测试计划
				}else if(map.get(i).size()>0&&aigaRunTasks[i]==null){//新增测试任务
					AigaRunTask aigaRunTask=createAndSaveAigaRunTask(i+1,Integer.valueOf(subTaskId),taskName);//保存测试任务
					//保存测试计划
					for(Integer caseId:map.get(i)){
						runPlanList.add(createAigaRunPlan(caseId,aigaRunTask.getTaskId()));
					}
					aigaRunPlanDAO.saveAigaRunPlan(runPlanList);
				}else if(map.get(i).size()>0&&aigaRunTasks[i]!=null){//变更
					//查询有效及失效数据
					AigaRunPlan[] values=aigaRunPlanDAO.getAigaRunPlanBySql("from AigaRunPlan where taskId='"+aigaRunTasks[i].getTaskId()+"' and status='1'");
					AigaRunPlan[] invalidValues=aigaRunPlanDAO.getAigaRunPlanBySql("from AigaRunPlan where taskId='"+aigaRunTasks[i].getTaskId()+"' and status='0'");
					Map<Integer,AigaRunPlan> oldMap=new HashMap<Integer,AigaRunPlan>();//有效数据
					for(AigaRunPlan aigaRunPlan:values){
						oldMap.put(aigaRunPlan.getCaseId(), aigaRunPlan);
					}
					Map<Integer,AigaRunPlan> invalidMap=new HashMap<Integer,AigaRunPlan>();//失效数据
					if(invalidValues.length>0&&invalidValues[0]!=null){
						for(AigaRunPlan aigaRunPlan:invalidValues){
							invalidMap.put(aigaRunPlan.getCaseId(), aigaRunPlan);
						}
					}
					List<Integer> oldList=new ArrayList<Integer>();
					oldList.addAll(oldMap.keySet());
					List<Integer> newList=new ArrayList<Integer>();
					newList.addAll(map.get(i));
					newList.removeAll(oldList);//新增测试执行计划
					oldList.removeAll(map.get(i));//失效测试计划
					for(Integer caseId:newList){
						if(invalidMap==null||invalidMap.get(caseId)==null){
							runPlanList.add(createAigaRunPlan(caseId,aigaRunTasks[i].getTaskId()));
						}else if(invalidMap!=null&&invalidMap.get(caseId)!=null){
							AigaRunPlan aigaRunPlan=invalidMap.get(caseId);
							aigaRunPlan.setStatus("1");
							runPlanList.add(aigaRunPlan);
						}
					}
					for(Integer caseId:oldList){
						AigaRunPlan aigaRunPlan=oldMap.get(caseId);
						aigaRunPlan.setStatus("0");
						runPlanList.add(aigaRunPlan);
					}
					aigaRunPlanDAO.saveAigaRunPlan(runPlanList);
				}
			}
		}
		
	}

	@Override
	public AigaRunTask[] getAigaRunTask(String querySql) throws Exception {
		return aigaRunTaskDAO.getAigaRunTaskBySql(querySql);
	}

	@Override
	public AigaRunTask getAigaRunTaskByTaskId(String taskId)
			throws Exception {
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRunTask.class);
		criteria.add(Restrictions.eq("taskId", taskId));
		return aigaRunTaskDAO.getRunTaskByCriteria(criteria)[0];
	}

	@Override
	public void saveAigaHisRunTaskResult(AigaHisRunTaskResult[] hisValues)
			throws Exception {
		aigaRunTaskDAO.saveAigaHisRunTaskResult(hisValues);
	}
	
	/**
	 * 根据测试环境创建并保存测试任务
	 * @param environment 测试环境 1测试环境 2准发布环境 3生产环境
	 * @return
	 * @throws Exception
	 */
	private AigaRunTask createAndSaveAigaRunTask(int environment,int subTaskId,String taskName)throws Exception{
		AigaRunTask runTaskBean=new AigaRunTask();
		runTaskBean.setSubTaskId(subTaskId);
		runTaskBean.setTaskFlag(environment);
		runTaskBean.setTaskStatus("1");
		runTaskBean.setTaskTag("RUNTASK"+new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
		runTaskBean.setTaskName(taskName);
		runTaskBean.setCollectType(environment);
		runTaskBean.setCreateTime(new Timestamp(new Date().getTime()));
		this.saveAigaRunTask(runTaskBean);
		runTaskBean.setTaskId(runTaskBean.getTaskId());
		return runTaskBean;
	}
	/**
	 * 创建测试执行计划
	 * @param aigaRFunCase 功能点用例关联表
	 * @param aigaRunTask 测试任务表
	 * @return
	 * @throws Exception
	 */
	private AigaRunPlan createAigaRunPlan(Integer caseId,String taskId)throws Exception{
		AigaRunPlan runPlan=new AigaRunPlan();
		runPlan.setCaseId(caseId);
		runPlan.setTaskId(taskId);
		runPlan.setStatus("1");
		return runPlan;
	}
	
	public static void main(String[] args) throws Exception{
		
		List list1 =new ArrayList();
		  list1.add("1111");
		  list1.add("2222");
		  list1.add("3333");
		  
		  List list2 =new ArrayList();
		  list2.add("3333");
		  list2.add("4444");
		  list2.add("5555");
		  
		  //并集
		  //list1.addAll(list2);
		  //交集
		  //list1.retainAll(list2);
		  //差集
		 // list1.removeAll(list2);
		  list2.removeAll(list1);
		  //无重复并集
		   // list2.removeAll(list1);
		   // list1.addAll(list2);
		  
//		  Iterator<String> it=list1.iterator();
//		  while (it.hasNext()) {
//		   System.out.println(it.next());
//		   
//		  }
		  System.out.println(list2.size());
		  System.out.println("-------------------");
		  Iterator<String> its=list2.iterator();
		  while (its.hasNext()) {
		   System.out.println(its.next());
		   
		  }
		  //System.out.println("-----------------------------------\n");
		  //printStr(list1);
		  
		 }
		 
}
