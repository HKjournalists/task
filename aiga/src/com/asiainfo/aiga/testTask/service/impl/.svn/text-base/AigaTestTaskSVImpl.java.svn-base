package com.asiainfo.aiga.testTask.service.impl;

import java.sql.Timestamp;

import javax.annotation.Resource;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.testPlan.service.IAigaTestPlanSV;
import com.asiainfo.aiga.testTask.bo.AigaTestTask;
import com.asiainfo.aiga.testTask.bo.AigaTestTaskChange;
import com.asiainfo.aiga.testTask.dao.IAigaTestTaskDAO;
import com.asiainfo.aiga.testTask.service.IAigaTestTaskSV;

public class AigaTestTaskSVImpl implements IAigaTestTaskSV{
	
	IAigaTestTaskDAO testTaskDAO;
	IAigaTestPlanSV testPlanSV;
	
	public void setTestTaskDAO(IAigaTestTaskDAO testTaskDAO) {
		this.testTaskDAO = testTaskDAO;
	}

	public void setTestPlanSV(IAigaTestPlanSV testPlanSV) {
		this.testPlanSV = testPlanSV;
	}

	public void deleteAigaTestTask(AigaTestTask value) throws Exception {
		// TODO Auto-generated method stub
		testTaskDAO.delete(value);
	}

	public void saveAigaTestTask(AigaTestTask value) throws Exception {
		// TODO Auto-generated method stub
		testTaskDAO.saveOrUpdate(value);
	}

	public AigaTestTask[] getAigaTestTaskByFunPointId(String funPointId) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestTask.class);
		criteria.add(Restrictions.eq("funPointId", funPointId));
		return testTaskDAO.getAigaTestTaskByCriteria(criteria);
	}
	
	public AigaTestTask[] getAigaTestTaskBySql(String querySql) throws Exception {
		return testTaskDAO.getAigaTestTaskBySql(querySql);
	}

	@Override
	public boolean changeAigaTestTask(AigaTestTask o,String changeStaffid,String changeStaffName) throws Exception {
		// TODO Auto-generated method stub
		try {
			//获取测试任务未变更信息
			Timestamp  onlineTimeOld = null;
			Integer  planIdOld = null;
			String querySql = "from AigaTestTask where task_id=" + o.getTaskId();
			AigaTestTask[] tasks = getAigaTestTaskBySql(querySql);
			AigaTestTask taskOld = null;
			if(tasks != null && tasks.length != 0) {
				taskOld = tasks[0];
				onlineTimeOld = taskOld.getFactCompleteTime(); 
				planIdOld = taskOld.getPlanId();
			}
			
			//保存变更
			saveAigaTestTask(o);
			String  updateSQL="";
			if(o.getPlanId()!=null){
				if(o.getFactCompleteTime()!=null){
					updateSQL="UPDATE aiga_test_sub_task atst SET atst.fact_complete_time=to_timestamp('"+o.getFactCompleteTime()+"','YYYY-MM-DD HH24:MI:ss.ff') WHERE atst.task_id ='"+o.getTaskId()+"'";
				}else{
					updateSQL="UPDATE aiga_test_sub_task atst SET atst.fact_complete_time=null where atst.task_id='"+o.getTaskId()+"'";
				}
			}else if(o.getPlanId()==null){
				updateSQL="UPDATE aiga_test_sub_task atst SET atst.fact_complete_time=null where atst.task_id='"+o.getTaskId()+"'";
			} 
			testPlanSV.updateBySQL(updateSQL);
			
			//保存变更记录
			AigaTestTaskChange testTaskChange = new AigaTestTaskChange();
			testTaskChange.setChangeReson("批量排期变更");
			testTaskChange.setCreateTime(new Timestamp(System.currentTimeMillis()));
			testTaskChange.setChangeTaskId(o.getTaskId());
			testTaskChange.setChangeTaskTag(o.getTaskTag());
			testTaskChange.setPlanIdo(planIdOld);
			testTaskChange.setPlanIdn(o.getPlanId());
			testTaskChange.setOnlineTimeo(onlineTimeOld);
			testTaskChange.setOnlineTimen(o.getFactCompleteTime());
			testTaskChange.setChangeStaffId(Integer.valueOf(changeStaffid));
			testTaskChange.setChangeStaffName(changeStaffName);
			saveAigaTestTaskChange(testTaskChange);
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}
		
	}

	@Override
	public void saveAigaTestTaskChange(AigaTestTaskChange o) throws Exception {
		// TODO Auto-generated method stub
		testTaskDAO.saveOrUpdateAigaTestTaskChange(o);
	}
}
