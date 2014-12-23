package com.asiainfo.aiga.service.impl;

import java.util.List;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.secframe.common.Constants;
import com.ai.secframe.ivalues.orgmodel.IStaffValue;
import com.ai.secframe.service.pubapi.interfaces.ISecframe;
import com.asiainfo.aiga.ivalues.IBOAigaSolidTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaSubTaskProblemValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestPlanValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestSubTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestTaskValue;
import com.asiainfo.aiga.service.interfaces.IAigaPublicSV;
import com.asiainfo.csc.common.define.IStakeholderType;
import com.asiainfo.csc.matrix.bo.BOAlmStakeholderBean;
import com.asiainfo.csc.matrix.common.AlmMatrixClient;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmStakeholderDao;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public class AigaPublicSVImpl implements IAigaPublicSV{

	@Override
	public void orderSubmitPublicFun(
			List<IBOAlmStakeholderValue> almStakeholderList,
			List<IBOAlmWorkorderValue> almWorkorderList,
			List<IBOAigaTestPlanValue> aigaTestPlanList,
			List<IBOAigaTestTaskValue> aigaTestTaskList,
			List<IBOAigaSolidTaskValue> aigaSolidTaskList,
			List<IBOAigaTestSubTaskValue> aigaTestSubTaskValue,
			List<IBOAigaSubTaskProblemValue> iBOAigaSubTaskProblemValue,String objType)
			throws Exception {
		// TODO Auto-generated method stub
		IAlmStakeholderDao iAlmStakeholderDao = (IAlmStakeholderDao)ServiceFactory.getService(IAlmStakeholderDao.class);
		//保存干系人
		
		if(objType.equals("1"))//处理测试计划
		{
			iAlmStakeholderDao.saveStakeholder(almStakeholderList, aigaTestPlanList.get(0).getPlanId(), objType);
		}else if(objType.equals("3")){//处理测试任务
			iAlmStakeholderDao.saveStakeholder(almStakeholderList, aigaTestTaskList.get(0).getTaskId(), objType);
		}else if(objType.equals("4") || objType.equals("5") || objType.equals("6")){//处理测试子任务或者端到端测试或者性能测试子流程
			iAlmStakeholderDao.saveStakeholder(almStakeholderList, aigaTestSubTaskValue.get(0).getSubTaskId(), objType);
		}else if(objType.equals("21")){//处理安全测试
			iAlmStakeholderDao.saveStakeholder(almStakeholderList, aigaSolidTaskList.get(0).getTaskId(), objType);
		}else if(objType.equals("22")){//处理性能测试
			iAlmStakeholderDao.saveStakeholder(almStakeholderList, aigaSolidTaskList.get(0).getTaskId(), objType);
		}else if(objType.equals("23")){//处理代码扫描
			iAlmStakeholderDao.saveStakeholder(almStakeholderList, aigaSolidTaskList.get(0).getTaskId(), objType);
		}else if(objType.equals("24")){//处理自动回归测试
			iAlmStakeholderDao.saveStakeholder(almStakeholderList, aigaSolidTaskList.get(0).getTaskId(), objType);
		}else if(objType.equals("25")){//处理手工回归测试
			iAlmStakeholderDao.saveStakeholder(almStakeholderList, aigaSolidTaskList.get(0).getTaskId(), objType);
		}else if(objType.equals("8")){//处理问题跟踪流程
			iAlmStakeholderDao.saveStakeholder(almStakeholderList, iBOAigaSubTaskProblemValue.get(0).getId(), objType);
		}else if(objType.equals("9")){//处理性能任务流程
			iAlmStakeholderDao.saveStakeholder(almStakeholderList, aigaTestTaskList.get(0).getTaskId(), objType);
		}
		AlmMatrixClient amc = new AlmMatrixClient();
		amc.finishUserTask(almWorkorderList.get(0).getOrderId(), almWorkorderList.get(0).getResult(), 
				almWorkorderList.get(0).getOpinion(), almWorkorderList.get(0).getCond());
	}

	@Override
	public IBOAlmStakeholderValue generateAlmStakeholderValue(long linkId,
			String linkNo, long templateId, long staffId, String staffName,
			String stdType, long objId, String objType)throws Exception {
		// TODO Auto-generated method stub
		ISecframe secframe = (ISecframe) ServiceFactory.getService(Constants.SERVICE_SECFRAME);
		IBOAlmStakeholderValue approvalStakeholder = new BOAlmStakeholderBean();
		approvalStakeholder.setLinkId(linkId);
		approvalStakeholder.setLinkNo(linkNo);
		approvalStakeholder.setTemplateId(templateId);
		approvalStakeholder.setStdholderStaffId(staffId);
		IStaffValue staff = secframe.getStaffByStaffId(staffId);
		approvalStakeholder.setStdholderStaffNo(staff.getCode());
		approvalStakeholder.setStdholderStaffName(staffName);
		approvalStakeholder.setStdholdeType(stdType);
		approvalStakeholder.setObjId(objId);
		approvalStakeholder.setObjType(objType);
		return approvalStakeholder;
	}

}
