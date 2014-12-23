package com.asiainfo.aiga.groupJointDebug.service.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.groupCase.bo.AigaRGroupChangeCase;
import com.asiainfo.aiga.groupJointDebug.service.IAigaJointDebugSV;
import com.asiainfo.aiga.groupJointDebug.dao.IAigaJointDebugDao;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugChange;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugReqForm;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugSubTaskForm;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugTaskForm;

public class AigaJointDebugSVImpl implements IAigaJointDebugSV {
	
	private IAigaJointDebugDao aigaJointDebugDao;

	public IAigaJointDebugDao getAigaJointDebugDao() {
		return aigaJointDebugDao;
	}

	public void setAigaJointDebugDao(IAigaJointDebugDao aigaJointDebugDao) {
		this.aigaJointDebugDao = aigaJointDebugDao;
	}

	@Override
	public void saveAigaJointDebugReqForm(AigaJointDebugReqForm aValue)
			throws Exception {
		if(aValue.getReqId()!=null){
			/***************  更新关联的集团联调测试任务信息的数据  *******************/
			//修改需要往任务单同步一部分数据,这对于系统数据的完整性非常重要.
			//省公司要求开发完成时间/联调开始日期/联调结束日期/是否造报文/造报文原因说明
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaJointDebugTaskForm.class);
			criteria.add(Restrictions.eq("reqTag",aValue.getReqTag()));
			AigaJointDebugTaskForm[] aigaJointDebugTaskForms = aigaJointDebugDao.getAigaJointDebugTaskForm(criteria);
			if(aigaJointDebugTaskForms.length>=1){
				for(AigaJointDebugTaskForm aigaJointDebugTaskForm : aigaJointDebugTaskForms){
					aigaJointDebugTaskForm.setProvincialReqDevEndTime(aValue.getProvincialReqDevEndTime());//省公司要求开发完成时间
					aigaJointDebugTaskForm.setJointDebugPlanBeginTime(aValue.getJointDebugPlanBeginTime());//集团联调开始日期
					aigaJointDebugTaskForm.setJointDebugPlanEndTime(aValue.getJointDebugPlanEndTime());//集团联调结束日期
					aigaJointDebugTaskForm.setIsNeedMessage(aValue.getIsNeedMessage());//是否需要造报文
					aigaJointDebugTaskForm.setMessageRemarks(aValue.getMessageRemarks());//造报文原因说明
					aigaJointDebugDao.saveAigaJointDebugTaskForm(aigaJointDebugTaskForm);
				}
			}
		}
		aigaJointDebugDao.saveAigaJointDebugReqForm(aValue);
	}

	@Override
	public AigaJointDebugReqForm[] getAigaJointDebugReqForm(
			DetachedCriteria criteria) throws Exception {
		return aigaJointDebugDao.getAigaJointDebugReqForm(criteria);
	}

	@Override
	public AigaJointDebugReqForm[] getAigaJointDebugReqForm(String querySql)
			throws Exception {
		return aigaJointDebugDao.getAigaJointDebugReqForm(querySql);
	}

	@Override
	public void deleteAigaJointDebugReqForm(AigaJointDebugReqForm aValue)
			throws Exception {
		aigaJointDebugDao.deleteAigaJointDebugReqForm(aValue);
	}

	@Override
	public void deleteAigaJointDebugReqForm(String reqIds) throws Exception {
		String[] reqIdArray = reqIds.split(",");
		for(String reqId : reqIdArray){
			AigaJointDebugReqForm[] aigaJointDebugReqForm = aigaJointDebugDao.getAigaJointDebugReqForm("FROM AigaJointDebugReqForm a WHERE a.reqId="+reqId);
			if(aigaJointDebugReqForm.length==1){
				aigaJointDebugReqForm[0].setIsDelete((short)1);//标识不可用
				aigaJointDebugDao.saveAigaJointDebugReqForm(aigaJointDebugReqForm[0]);
			}else{
				throw new Exception("参数错误");
			}
		}
	}

	@Override
	public void saveAigaJointDebugTaskForm(AigaJointDebugTaskForm aValue)
			throws Exception {
		if(aValue.getTaskId()!=null){
			/***************  更新关联的集团联调测试子任务信息的数据  *******************/
			//修改需要往子任务单同步一部分数据,这对于系统数据的完整性非常重要.
			//任务名称/系统大类/系统子类/任务类型/开发任务计划开始提交日期/开发任务计划完成提交日期/开发负责人/开发负责人ID/是否造报文/造报文原因说明
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaJointDebugSubTaskForm.class);
			criteria.add(Restrictions.eq("taskTag",aValue.getTaskTag()));
			AigaJointDebugSubTaskForm[] aigaJointDebugSubTaskForms = aigaJointDebugDao.getAigaJointDebugSubTaskForm(criteria);
			if(aigaJointDebugSubTaskForms.length>=1){
				for(AigaJointDebugSubTaskForm aigaJointDebugSubTaskForm : aigaJointDebugSubTaskForms){
					aigaJointDebugSubTaskForm.setTaskName(aValue.getTaskName());//任务名称
					aigaJointDebugSubTaskForm.setBigType(aValue.getBigType());//系统大类
					aigaJointDebugSubTaskForm.setSubType(aValue.getSubType());//系统子类
					aigaJointDebugSubTaskForm.setTaskType(aValue.getTaskType());//任务类型
					aigaJointDebugSubTaskForm.setTaskPlanBeginCommitTime(aValue.getTaskPlanBeginCommitTime());//开发任务计划开始提交日期
					aigaJointDebugSubTaskForm.setTaskPlanEndCommitTime(aValue.getTaskPlanEndCommitTime());//开发任务计划完成提交日期
					aigaJointDebugSubTaskForm.setDevManagerName(aValue.getDevManagerName());//开发负责人
					aigaJointDebugSubTaskForm.setDevManagerId(aValue.getDevManagerId());//开发负责人ID
					aigaJointDebugSubTaskForm.setIsNeedMessage(aValue.getIsNeedMessage());//是否需要造报文
					aigaJointDebugSubTaskForm.setMessageRemarks(aValue.getMessageRemarks());//造报文原因说明
					aigaJointDebugDao.saveAigaJointDebugSubTaskForm(aigaJointDebugSubTaskForm);
				}
			}
		}
		aigaJointDebugDao.saveAigaJointDebugTaskForm(aValue);
	}

	@Override
	public AigaJointDebugTaskForm[] getAigaJointDebugTaskForm(
			DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return aigaJointDebugDao.getAigaJointDebugTaskForm(criteria);
	}

	@Override
	public AigaJointDebugTaskForm[] getAigaJointDebugTaskForm(String querySql)
			throws Exception {
		// TODO Auto-generated method stub
		return aigaJointDebugDao.getAigaJointDebugTaskForm(querySql);
	}

	@Override
	public void deleteAigaJointDebugTaskForm(AigaJointDebugTaskForm aValue)
			throws Exception {
		aigaJointDebugDao.deleteAigaJointDebugTaskForm(aValue);
		
	}

	@Override
	public void deleteAigaJointDebugTaskForm(String taskIds) throws Exception {
		String[] taskIdArray = taskIds.split(",");
		for(String taskId : taskIdArray){
			AigaJointDebugTaskForm[] aigaJointDebugTaskForm = aigaJointDebugDao.getAigaJointDebugTaskForm("FROM AigaJointDebugTaskForm a WHERE a.taskId="+taskId);
			if(aigaJointDebugTaskForm.length==1){
				aigaJointDebugTaskForm[0].setIsDelete((short)1);//标识不可用
				aigaJointDebugDao.saveAigaJointDebugTaskForm(aigaJointDebugTaskForm[0]);
			}else{
				throw new Exception("参数错误");
			}
		}
		
	}

	@Override
	public void deleteAigaJointDebugSubTaskForm(AigaJointDebugSubTaskForm aValue)
			throws Exception {
		aigaJointDebugDao.deleteAigaJointDebugSubTaskForm(aValue);
		
	}

	@Override
	public void deleteAigaJointDebugSubTaskForm(String subTaskIds)
			throws Exception {
		String[] subTaskIdArray = subTaskIds.split(",");
		for(String subTaskId : subTaskIdArray){
			AigaJointDebugSubTaskForm[] aigaJointDebugSubTaskForm = aigaJointDebugDao.getAigaJointDebugSubTaskForm("FROM AigaJointDebugSubTaskForm a WHERE a.subTaskId="+subTaskId);
			if(aigaJointDebugSubTaskForm.length==1){
				aigaJointDebugSubTaskForm[0].setIsDelete((short)1);//标识不可用
				aigaJointDebugDao.saveAigaJointDebugSubTaskForm(aigaJointDebugSubTaskForm[0]);
			}else{
				throw new Exception("参数错误");
			}
		}
		
	}

	@Override
	public AigaJointDebugSubTaskForm[] getAigaJointDebugSubTaskForm(
			DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return aigaJointDebugDao.getAigaJointDebugSubTaskForm(criteria);
	}

	@Override
	public AigaJointDebugSubTaskForm[] getAigaJointDebugSubTaskForm(
			String querySql) throws Exception {
		// TODO Auto-generated method stub
		return aigaJointDebugDao.getAigaJointDebugSubTaskForm(querySql);
	}

	@Override
	public void saveAigaJointDebugSubTaskForm(AigaJointDebugSubTaskForm aValue)
			throws Exception {
		// TODO Auto-generated method stub
		aigaJointDebugDao.saveAigaJointDebugSubTaskForm(aValue);
	}

	@Override
	public void saveAigaJointDebugChange(AigaJointDebugChange aValue)
			throws Exception {
		// TODO Auto-generated method stub
		if(aValue.getChangeTaskType()==1){//需求单
			//设置需求单编号
			aValue.setReqTag(aValue.getChangeTaskTag());
		}else if(aValue.getChangeTaskType()==2){//任务单
			//获取任务单
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaJointDebugTaskForm.class);
			criteria.add(Restrictions.eq("taskTag",aValue.getChangeTaskTag()));
			AigaJointDebugTaskForm[] aigaJointDebugTaskForms = aigaJointDebugDao.getAigaJointDebugTaskForm(criteria);
			if(aigaJointDebugTaskForms.length==1){
				//设置归属需求单编号
				aValue.setReqTag(aigaJointDebugTaskForms[0].getReqTag());
			}
			//设置任务单编号
			aValue.setTaskTag(aValue.getChangeTaskTag());
			
		}else if(aValue.getChangeTaskType()==3){//子任务单
			//获取子任务单
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaJointDebugSubTaskForm.class);
			criteria.add(Restrictions.eq("subTaskTag",aValue.getChangeTaskTag()));
			AigaJointDebugSubTaskForm[] aigaJointDebugSubTaskForms = aigaJointDebugDao.getAigaJointDebugSubTaskForm(criteria);
			if(aigaJointDebugSubTaskForms.length==1){
				//设置归属任务单编号
				aValue.setTaskTag(aigaJointDebugSubTaskForms[0].getTaskTag());
				//获取任务单
				criteria = DetachedCriteria.forClass(AigaJointDebugTaskForm.class);
				criteria.add(Restrictions.eq("reqTag",aigaJointDebugSubTaskForms[0].getTaskTag()));
				AigaJointDebugTaskForm[] aigaJointDebugTaskForms = aigaJointDebugDao.getAigaJointDebugTaskForm(criteria);
				if(aigaJointDebugTaskForms.length==1){
					//设置归属需求单编号
					aValue.setReqTag(aigaJointDebugTaskForms[0].getReqTag());
				}
			}
			//设置子任务单编号
			aValue.setSubTaskTag(aValue.getChangeTaskTag());
		}
		aigaJointDebugDao.saveAigaJointDebugChange(aValue);
	}

	@Override
	public AigaJointDebugChange[] getAigaJointDebugChange(
			DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return aigaJointDebugDao.getAigaJointDebugChange(criteria);
	}

	@Override
	public AigaJointDebugChange[] getAigaJointDebugChange(String querySql)
			throws Exception {
		// TODO Auto-generated method stub
		return aigaJointDebugDao.getAigaJointDebugChange(querySql);
	}

	@Override
	public void deleteAigaJointDebugChange(AigaJointDebugChange aValue)
			throws Exception {
		// TODO Auto-generated method stub
		aigaJointDebugDao.deleteAigaJointDebugChange(aValue);
	}

	@Override
	public void saveAigaRGroupChangeCase(AigaRGroupChangeCase aValue)
			throws Exception {
		// TODO Auto-generated method stub
		aigaJointDebugDao.saveAigaRGroupChangeCase(aValue);
	}
	
	

}
