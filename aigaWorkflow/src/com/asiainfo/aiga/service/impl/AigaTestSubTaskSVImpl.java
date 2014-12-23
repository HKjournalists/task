package com.asiainfo.aiga.service.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.ai.secframe.common.Constants;
import com.ai.secframe.ivalues.orgmodel.IStaffValue;
import com.ai.secframe.ivalues.orgmodel.ISysEmployeeValue;
import com.ai.secframe.ivalues.orgmodel.ISysStaffValue;
import com.ai.secframe.service.pubapi.interfaces.ISecframe;
import com.asiainfo.aiga.bo.BOAigaTestSubTaskBean;
import com.asiainfo.aiga.dao.interfaces.IAigaTestSubTaskDao;
import com.asiainfo.aiga.ivalues.IBOAigaSubTaskProblemValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestSubTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestTaskValue;
import com.asiainfo.aiga.service.interfaces.IAigaPublicSV;
import com.asiainfo.aiga.service.interfaces.IAigaTestSubTaskSV;
import com.asiainfo.csc.common.common.ConstDefine;
import com.asiainfo.csc.common.define.IObjectType;
import com.asiainfo.csc.common.define.IStakeholderType;
import com.asiainfo.csc.common.define.WorkFlowParam;
import com.asiainfo.csc.matrix.bo.BOAlmStakeholderBean;
import com.asiainfo.csc.matrix.common.AlmMatrixClient;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmStakeholderDao;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;
import com.ibm.db2.jcc.a.g;
import com.sun.tools.internal.ws.processor.generator.ServiceGenerator;

public class AigaTestSubTaskSVImpl implements IAigaTestSubTaskSV{

	IAigaTestSubTaskDao iAigaTestSubTaskDao = (IAigaTestSubTaskDao)ServiceFactory.getService(IAigaTestSubTaskDao.class);
	@Override
	public IBOAigaTestSubTaskValue getAigaTestSubTaskBySubTaskId(String taskId)
			throws Exception {
		// TODO Auto-generated method stub
		return iAigaTestSubTaskDao.getAigaTestSubTaskBySubTaskId(taskId);
	}

	@Override
	public IBOAigaTestSubTaskValue[] getAigaTestSubTasks(String conditions,
			Map params) throws Exception {
		// TODO Auto-generated method stub
		return iAigaTestSubTaskDao.getAigaTestSubTasks(conditions, params);
	}

	@Override
	public IBOAigaTestSubTaskValue saveAigaTestSubTask(
			IBOAigaTestSubTaskValue value) throws Exception {
		// TODO Auto-generated method stub
		return iAigaTestSubTaskDao.saveAigaTestSubTask(value);
	}

	@Override
	public IBOAigaTestSubTaskValue saveAigaTestSubTaskByTestTask(
			IBOAigaTestSubTaskValue aigaTestSubTaskValue,
			IBOAigaTestTaskValue aigaTestTaskValue) throws Exception {
		// TODO Auto-generated method stub
		aigaTestSubTaskValue.setTaskId(aigaTestTaskValue.getTaskId());
		aigaTestSubTaskValue.setTaskTag(aigaTestTaskValue.getTaskTag());
		return iAigaTestSubTaskDao.saveAigaTestSubTask(aigaTestSubTaskValue);
	}

	@Override
	public void startAigaTestSubTaskWorkflow(
			IBOAigaTestTaskValue aigaTestTaskValue,
			IBOAigaTestSubTaskValue aigaTestSubTaskValue) throws Exception {
		// TODO Auto-generated method stub
		//�������������̻��߶˵�������
		
		//����������
		saveAigaTestSubTaskByTestTask(aigaTestSubTaskValue,aigaTestTaskValue);
		
		IAigaPublicSV iAigaPublicSV = (IAigaPublicSV)ServiceFactory.getService(IAigaPublicSV.class);
		WorkFlowParam workFlowParam = WorkFlowParam.getInstance();
		IAlmStakeholderDao iAlmStakeholderDao = (IAlmStakeholderDao)ServiceFactory.getService(IAlmStakeholderDao.class);
		
		List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
		IBOAlmStakeholderValue approvalStakeholderCreate = null;
		IBOAlmStakeholderValue approvalStakeholderAys = null;
		IBOAlmStakeholderValue approvalStakeholderDesign = null;
		IBOAlmStakeholderValue approvalStakeholder2 = null;
		IBOAlmStakeholderValue approvalStakeholder3 = null;
		IBOAlmStakeholderValue approvalStakeholder4 = null;


		String wfTemplateString = "";
		String wfName = "";
		String condString = "";
		//�������������̸�ϵ�ˣ��������ڡ���������Ͳ�����ƻ���
		if(String.valueOf(aigaTestSubTaskValue.getSubTaskType()).equals(IObjectType.SUBTESTTASK))
		{
			approvalStakeholderCreate = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getCREATESUBTESTTASK().getLinkId(),
					workFlowParam.getCREATESUBTESTTASK().getLinkNo(), //���봴����ͨ�����������ϵ��
					workFlowParam.getCREATESUBTESTTASK().getTemplateId(),
					Long.valueOf(aigaTestTaskValue.getDistributeStaffid()), 
					aigaTestTaskValue.getDistributeStaffname(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholderAys = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getSUBTESTTASKAYS().getLinkId(),
					workFlowParam.getSUBTESTTASKAYS().getLinkNo(), //���봴����ͨ�������������������ϵ��
					workFlowParam.getSUBTESTTASKAYS().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholderDesign = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getSUBTESTTASKDSGN().getLinkId(),
					workFlowParam.getSUBTESTTASKDSGN().getLinkNo(), //���봴����ͨ���������������Ƹ�ϵ��
					workFlowParam.getSUBTESTTASKDSGN().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholder2 = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getSUBTESTTASKFUNCTEST().getLinkId(),
					workFlowParam.getSUBTESTTASKFUNCTEST().getLinkNo(), //���봴����ͨ�����������ܲ��Ը�ϵ��
					workFlowParam.getSUBTESTTASKFUNCTEST().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			approvalStakeholder3 = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getSUBTESTTASKQUAREL().getLinkId(),
					workFlowParam.getSUBTESTTASKQUAREL().getLinkNo(), //���봴����ͨ����������׼�������Ը�ϵ��
					workFlowParam.getSUBTESTTASKQUAREL().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			approvalStakeholder4 = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getSUBTESTTASKPRODUCE().getLinkId(),
					workFlowParam.getSUBTESTTASKPRODUCE().getLinkNo(), //���봴����ͨ�����������������Ը�ϵ��
					workFlowParam.getSUBTESTTASKPRODUCE().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			wfTemplateString = ConstDefine.TEMPLATE_NAME_TESTSUBTASKWF;
			wfName = "�������������";
			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
		}else if(String.valueOf(aigaTestSubTaskValue.getSubTaskType()).equals(IObjectType.EAESUBTEST))
		{
			approvalStakeholderCreate = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getCREATEEAESUBTASKTEST().getLinkId(),
					workFlowParam.getCREATEEAESUBTASKTEST().getLinkNo(), //���봴���˵��˲����������ϵ��
					workFlowParam.getCREATEEAESUBTASKTEST().getTemplateId(),
					Long.valueOf(aigaTestTaskValue.getDistributeStaffid()), 
					aigaTestTaskValue.getDistributeStaffname(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholderAys = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getEAESUBTASKTESTBTVERIFY().getLinkId(),
					workFlowParam.getEAESUBTASKTESTBTVERIFY().getLinkNo(), //��������ǰ������˸�ϵ��
					workFlowParam.getEAESUBTASKTESTBTVERIFY().getTemplateId(),
					Long.valueOf(aigaTestTaskValue.getDistributeStaffid()), 
					aigaTestTaskValue.getDistributeStaffname(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholderDesign = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getEAESUBTASKTESTDSGN().getLinkId(),
					workFlowParam.getEAESUBTASKTESTDSGN().getLinkNo(), //���봴���˵��˲�����Ƹ�ϵ��
					workFlowParam.getEAESUBTASKTESTDSGN().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholder2 = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getEAESUBTASKTESTONLINEVERIFY().getLinkId(),
					workFlowParam.getEAESUBTASKTESTONLINEVERIFY().getLinkNo(), //����˵�������������˸�ϵ��
					workFlowParam.getEAESUBTASKTESTONLINEVERIFY().getTemplateId(),
					Long.valueOf(aigaTestTaskValue.getDistributeStaffid()), 
					aigaTestTaskValue.getDistributeStaffname(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholder3 = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getEAESUBTASKTESTQUAREL().getLinkId(),
					workFlowParam.getEAESUBTASKTESTQUAREL().getLinkNo(), //���봴���˵���׼�����������Ը�ϵ��
					workFlowParam.getEAESUBTASKTESTQUAREL().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholder4 = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getEAESUBTASKTESTPRODUCE().getLinkId(),
					workFlowParam.getEAESUBTASKTESTPRODUCE().getLinkNo(), //���봴���˵��������������Ը�ϵ��
					workFlowParam.getEAESUBTASKTESTPRODUCE().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			wfTemplateString = ConstDefine.TEMPLATE_NAME_TESTEAESUBWF;
			wfName = "�˵����Ӳ���";
			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
		}else if(String.valueOf(aigaTestSubTaskValue.getSubTaskType()).equals(IObjectType.PERFSUBTEST))
		{
			approvalStakeholderCreate = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getCREATEPERFSUBTEST().getLinkId(),
					workFlowParam.getCREATEPERFSUBTEST().getLinkNo(), //���봴�������Ӳ��Ը�ϵ��
					workFlowParam.getCREATEPERFSUBTEST().getTemplateId(),
					Long.valueOf(aigaTestTaskValue.getDistributeStaffid()), 
					aigaTestTaskValue.getDistributeStaffname(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholderAys = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getPERFSUBTASKAYS().getLinkId(),
					workFlowParam.getPERFSUBTASKAYS().getLinkNo(), //���봴����ͨ�������������������ϵ��
					workFlowParam.getPERFSUBTASKAYS().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholderDesign = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getPERFSUBTASKDSGN().getLinkId(),
					workFlowParam.getPERFSUBTASKDSGN().getLinkNo(), //���봴����ͨ���������������Ƹ�ϵ��
					workFlowParam.getPERFSUBTASKDSGN().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholder2 = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getPERFSUBTASKFUNCTEST().getLinkId(),
					workFlowParam.getPERFSUBTASKFUNCTEST().getLinkNo(), //���봴����ͨ�����������ܲ��Ը�ϵ��
					workFlowParam.getPERFSUBTASKFUNCTEST().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			approvalStakeholder3 = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getPERFSUBTASKQUAREL().getLinkId(),
					workFlowParam.getPERFSUBTASKQUAREL().getLinkNo(), //���봴����ͨ����������׼�������Ը�ϵ��
					workFlowParam.getPERFSUBTASKQUAREL().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			approvalStakeholder4 = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getPERFSUBTASKPRODUCE().getLinkId(),
					workFlowParam.getPERFSUBTASKPRODUCE().getLinkNo(), //���봴����ͨ�����������������Ը�ϵ��
					workFlowParam.getPERFSUBTASKPRODUCE().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			wfTemplateString = ConstDefine.TEMPLATE_NAME_PERFSUBTESTWF;
			wfName = "�����Ӳ���";
			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
		}

		iBOAlmStakeholderList.add(approvalStakeholderCreate);
		iBOAlmStakeholderList.add(approvalStakeholderAys);
		iBOAlmStakeholderList.add(approvalStakeholderDesign);
		if(approvalStakeholder2 !=null)
			iBOAlmStakeholderList.add(approvalStakeholder2);
		if(approvalStakeholder3 !=null)
			iBOAlmStakeholderList.add(approvalStakeholder3);
		if(approvalStakeholder4 !=null)
			iBOAlmStakeholderList.add(approvalStakeholder4);
		iAlmStakeholderDao.saveStakeholder(iBOAlmStakeholderList, aigaTestSubTaskValue.getSubTaskId(), String.valueOf(aigaTestSubTaskValue.getSubTaskType()));

		AlmMatrixClient amc = new AlmMatrixClient();
		//������һ������
		amc.createStartSaveOrder(String.valueOf(aigaTestSubTaskValue.getSubTaskId()), String.valueOf(aigaTestSubTaskValue.getSubTaskType()), wfTemplateString,condString,wfName);
		//��������
		amc.createWorkflow(wfTemplateString, "1", String.valueOf(aigaTestSubTaskValue.getSubTaskType()), String.valueOf(aigaTestSubTaskValue.getSubTaskId()), ServiceManager.getOpDateTime(), wfName, condString);
	}
	

	@Override
	public void startAigaPerfSubTaskWorkflow(IBOAigaTestSubTaskValue aigaTestSubTaskValue,
			List<IBOAlmStakeholderValue> stds,
			List<IBOAlmWorkorderValue> orders) throws Exception {
		// TODO Auto-generated method stub
		//�������������̻��߶˵�������

		//����������
		saveAigaTestSubTask(aigaTestSubTaskValue);
		
		IAigaPublicSV iAigaPublicSV = (IAigaPublicSV)ServiceFactory.getService(IAigaPublicSV.class);
		WorkFlowParam workFlowParam = WorkFlowParam.getInstance();
		IAlmStakeholderDao iAlmStakeholderDao = (IAlmStakeholderDao)ServiceFactory.getService(IAlmStakeholderDao.class);
		
//		List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
		IBOAlmStakeholderValue approvalStakeholderCreate = null;
		IBOAlmStakeholderValue approvalStakeholderAys = null;
		IBOAlmStakeholderValue approvalStakeholderDesign = null;
		IBOAlmStakeholderValue approvalStakeholder2 = null;
		IBOAlmStakeholderValue approvalStakeholder3 = null;
		IBOAlmStakeholderValue approvalStakeholder4 = null;

		
		String wfTemplateString = "";
		String wfName = "";
		String condString = "";
		//�������������̸�ϵ�ˣ��������ڡ���������Ͳ�����ƻ���
		if(String.valueOf(aigaTestSubTaskValue.getSubTaskType()).equals(IObjectType.SUBTESTTASK))
		{
			approvalStakeholderAys = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getSUBTESTTASKAYS().getLinkId(),
					workFlowParam.getSUBTESTTASKAYS().getLinkNo(), //���봴����ͨ�������������������ϵ��
					workFlowParam.getSUBTESTTASKAYS().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getCreator()), 
					aigaTestSubTaskValue.getCreatorStaff(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholderDesign = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getSUBTESTTASKDSGN().getLinkId(),
					workFlowParam.getSUBTESTTASKDSGN().getLinkNo(), //���봴����ͨ���������������Ƹ�ϵ��
					workFlowParam.getSUBTESTTASKDSGN().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholder2 = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getSUBTESTTASKFUNCTEST().getLinkId(),
					workFlowParam.getSUBTESTTASKFUNCTEST().getLinkNo(), //���봴����ͨ�����������ܲ��Ը�ϵ��
					workFlowParam.getSUBTESTTASKFUNCTEST().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			approvalStakeholder3 = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getSUBTESTTASKQUAREL().getLinkId(),
					workFlowParam.getSUBTESTTASKQUAREL().getLinkNo(), //���봴����ͨ����������׼�������Ը�ϵ��
					workFlowParam.getSUBTESTTASKQUAREL().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			approvalStakeholder4 = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getSUBTESTTASKPRODUCE().getLinkId(),
					workFlowParam.getSUBTESTTASKPRODUCE().getLinkNo(), //���봴����ͨ�����������������Ը�ϵ��
					workFlowParam.getSUBTESTTASKPRODUCE().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			wfTemplateString = ConstDefine.TEMPLATE_NAME_TESTSUBTASKWF;
			wfName = "�������������";
			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
		}else if(String.valueOf(aigaTestSubTaskValue.getSubTaskType()).equals(IObjectType.EAESUBTEST))
		{

			approvalStakeholderAys = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getEAESUBTASKTESTAYS().getLinkId(),
					workFlowParam.getEAESUBTASKTESTAYS().getLinkNo(), //���봴���˵������������ϵ��
					workFlowParam.getEAESUBTASKTESTAYS().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getCreator()), 
					aigaTestSubTaskValue.getCreatorStaff(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholderDesign = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getEAESUBTASKTESTDSGN().getLinkId(),
					workFlowParam.getEAESUBTASKTESTDSGN().getLinkNo(), //���봴���˵��˲�����Ƹ�ϵ��
					workFlowParam.getEAESUBTASKTESTDSGN().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholder2 = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getEAESUBTASKTESTQUAREL().getLinkId(),
					workFlowParam.getEAESUBTASKTESTQUAREL().getLinkNo(), //���봴���˵���׼�����������Ը�ϵ��
					workFlowParam.getEAESUBTASKTESTQUAREL().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			approvalStakeholder3 = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getEAESUBTASKTESTPRODUCE().getLinkId(),
					workFlowParam.getEAESUBTASKTESTPRODUCE().getLinkNo(), //���봴���˵��������������Ը�ϵ��
					workFlowParam.getEAESUBTASKTESTPRODUCE().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaTestSubTaskValue.getSubTaskId(), 
					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			
			wfTemplateString = ConstDefine.TEMPLATE_NAME_TESTEAESUBWF;
			wfName = "�˵����Ӳ���";
			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
		}else if(String.valueOf(aigaTestSubTaskValue.getSubTaskType()).equals(IObjectType.PERFSUBTEST))
		{

//			approvalStakeholderAys = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getPERFSUBTESTALLOT().getLinkId(),
//					workFlowParam.getPERFSUBTESTALLOT().getLinkNo(), //���������Ӳ��Է����ϵ��
//					workFlowParam.getPERFSUBTESTALLOT().getTemplateId(),
//					Long.valueOf(aigaTestSubTaskValue.getCreator()), 
//					aigaTestSubTaskValue.getCreatorStaff(),
//					IStakeholderType.STDHOLDETYPE_APPROVAL, 
//					aigaTestSubTaskValue.getSubTaskId(), 
//					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
//			
//			approvalStakeholderDesign = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getPERFSUBTESTDESIGN().getLinkId(),
//					workFlowParam.getPERFSUBTESTDESIGN().getLinkNo(), //���������Ӳ���������Ƹ�ϵ��
//					workFlowParam.getPERFSUBTESTDESIGN().getTemplateId(),
//					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
//					aigaTestSubTaskValue.getTestorName(),
//					IStakeholderType.STDHOLDETYPE_APPROVAL, 
//					aigaTestSubTaskValue.getSubTaskId(), 
//					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
//			
//			approvalStakeholder2 = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getPERFSUBTESTRUNNING().getLinkId(),
//					workFlowParam.getPERFSUBTESTRUNNING().getLinkNo(), //���������Ӳ��Բ���ִ�и�ϵ��
//					workFlowParam.getPERFSUBTESTRUNNING().getTemplateId(),
//					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
//					aigaTestSubTaskValue.getTestorName(),
//					IStakeholderType.STDHOLDETYPE_APPROVAL, 
//					aigaTestSubTaskValue.getSubTaskId(), 
//					String.valueOf(aigaTestSubTaskValue.getSubTaskType()));
			wfTemplateString = ConstDefine.TEMPLATE_NAME_PERFSUBTESTWF;
			wfName = "�����Ӳ���";
			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
		}

		stds.add(approvalStakeholderCreate);
		stds.add(approvalStakeholderAys);
		stds.add(approvalStakeholderDesign);
		if(approvalStakeholder2 !=null)
			stds.add(approvalStakeholder2);
		if(approvalStakeholder3 !=null)
			stds.add(approvalStakeholder3);
		if(approvalStakeholder4 !=null)
			stds.add(approvalStakeholder4);
		iAlmStakeholderDao.saveStakeholder(stds, aigaTestSubTaskValue.getSubTaskId(), String.valueOf(aigaTestSubTaskValue.getSubTaskType()));

		AlmMatrixClient amc = new AlmMatrixClient();
		//������һ������
		amc.createStartSaveOrder(String.valueOf(aigaTestSubTaskValue.getSubTaskId()), String.valueOf(aigaTestSubTaskValue.getSubTaskType()), wfTemplateString,condString,wfName);
		//��������
		amc.createWorkflow(wfTemplateString, "1", String.valueOf(aigaTestSubTaskValue.getSubTaskType()), String.valueOf(aigaTestSubTaskValue.getSubTaskId()), ServiceManager.getOpDateTime(), wfName, condString);
	}

	
	public void batchSubTaskReview(JSONArray subTasks, String StaffId,
			String StaffName) throws Exception {
		// TODO Auto-generated method stub
		IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
		//����������
		if(subTasks != null && subTasks.length()>0)//������ϵ��JSONArray
		{
			int length = subTasks.length();
			for(int i = 0; i < length; i++)
			{	
				String subTaskId = "0";
				String reviewResult = "";
				JSONObject st = subTasks.getJSONObject(i);  
				IBOAigaTestSubTaskValue aigaTestSubTaskValue = new BOAigaTestSubTaskBean();
				if(st.has("subTaskId"))
					subTaskId = st.getString("subTaskId");
				if(st.has("reviewResult"))
					reviewResult = st.getString("reviewResult");
				aigaTestSubTaskValue = iAigaTestSubTaskSV.getAigaTestSubTaskBySubTaskId(subTaskId);
				aigaTestSubTaskValue.setOperId(Long.valueOf(StaffId));
				aigaTestSubTaskValue.setOperName(StaffName);
				aigaTestSubTaskValue.setReviewResult(Long.valueOf(reviewResult));
				aigaTestSubTaskValue.setReviewTime(new Timestamp(new Date().getTime()));
				iAigaTestSubTaskSV.saveAigaTestSubTask(aigaTestSubTaskValue);
			}
		}
		//���������������
//		IAigaPublicSV iAigaPublicSV = (IAigaPublicSV)ServiceFactory.getService(IAigaPublicSV.class);
//		WorkFlowParam workFlowParam = WorkFlowParam.getInstance();
//		IAlmStakeholderDao iAlmStakeholderDao = (IAlmStakeholderDao)ServiceFactory.getService(IAlmStakeholderDao.class);
//		
//		Criteria sqlCriteria = new Criteria();
//		sqlCriteria.addEqual(IBOAigaSubTaskProblemValue.S_StartMark, "0");
//		IBOAigaSubTaskProblemValue[] aigaSubTaskProblemValues = getAigaSubTaskProblems(sqlCriteria.toString(),sqlCriteria.getParameters());
//		for(IBOAigaSubTaskProblemValue value : aigaSubTaskProblemValues)
//		{
//			List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
//			IBOAlmStakeholderValue approvalStakeholderCreate = null;
//			IBOAlmStakeholderValue approvalStakeholderModify = null;
//			IBOAigaTestSubTaskValue aigaTestSubTaskValue = iAigaTestSubTaskSV.getAigaTestSubTaskBySubTaskId(String.valueOf(value.getSubTaskId()));
//			
//			String wfTemplateString = "";
//			String wfName = "";
//			String condString = "";
//			//�������������̸�ϵ�ˣ��������ڡ���������Ͳ�����ƻ���
//			approvalStakeholderCreate = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getCREATEPROBLEMFOLLOW().getLinkId(),
//				workFlowParam.getCREATEPROBLEMFOLLOW().getLinkNo(), //���봴����ͨ�������������������ϵ��
//				workFlowParam.getCREATEPROBLEMFOLLOW().getTemplateId(),
//				Long.valueOf(StaffId), 
//				StaffName,
//				IStakeholderType.STDHOLDETYPE_APPROVAL, 
//				value.getId(), 
//				IObjectType.PROBLEM_FOLLOW);
//				
//			approvalStakeholderModify = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getTESTERMODIFY().getLinkId(),
//				workFlowParam.getTESTERMODIFY().getLinkNo(), //���봴����ͨ���������������Ƹ�ϵ��
//				workFlowParam.getTESTERMODIFY().getTemplateId(),
//				Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
//				aigaTestSubTaskValue.getTestorName(),
//				IStakeholderType.STDHOLDETYPE_APPROVAL, 
//				value.getId(), 
//				IObjectType.PROBLEM_FOLLOW);
//				
//			wfTemplateString = ConstDefine.TEMPLATE_NAME_PROBLEMFOLLOWWF;
//			wfName = "���������������";
//			condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
//			iBOAlmStakeholderList.add(approvalStakeholderCreate);
//			iBOAlmStakeholderList.add(approvalStakeholderModify);
//			iAlmStakeholderDao.saveStakeholder(iBOAlmStakeholderList, value.getId(),IObjectType.PROBLEM_FOLLOW);
//
//			AlmMatrixClient amc = new AlmMatrixClient();
//			//������һ������
//			amc.createStartSaveOrder(String.valueOf(value.getId()), IObjectType.PROBLEM_FOLLOW, wfTemplateString,condString,wfName);
//			//��������
//			amc.createWorkflow(wfTemplateString, "1", IObjectType.PROBLEM_FOLLOW, String.valueOf(value.getId()), ServiceManager.getOpDateTime(), wfName, condString);
//			value.setStartMark(1);
//			iAigaTestSubTaskSV.saveAigaSubTaskProblem(value);
//		}
	}

	@Override
	public IBOAigaSubTaskProblemValue[] getAigaSubTaskProblems(
			String conditions, Map params) throws Exception {
		// TODO Auto-generated method stub
		return iAigaTestSubTaskDao.getAigaSubTaskProblems(conditions, params);
	}

	@Override
	public IBOAigaSubTaskProblemValue saveAigaSubTaskProblem(
			IBOAigaSubTaskProblemValue value) throws Exception {
		// TODO Auto-generated method stub
		return iAigaTestSubTaskDao.saveAigaSubTaskProblem(value);
	}

	@Override
	public IBOAigaSubTaskProblemValue getAigaSubTaskProblemById(String id)
			throws Exception {
		// TODO Auto-generated method stub
		return iAigaTestSubTaskDao.getAigaSubTaskProblemById(id);
	}

	@Override
	public void startProblemWF(IBOAigaSubTaskProblemValue aigaSubTaskProblemValue,
			String subTask, String problemTag,
			String StaffId, String StaffName) throws Exception {
		// TODO Auto-generated method stub
		saveAigaSubTaskProblem(aigaSubTaskProblemValue);
		
		IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
		//���������������
		IAigaPublicSV iAigaPublicSV = (IAigaPublicSV)ServiceFactory.getService(IAigaPublicSV.class);
		WorkFlowParam workFlowParam = WorkFlowParam.getInstance();
		IAlmStakeholderDao iAlmStakeholderDao = (IAlmStakeholderDao)ServiceFactory.getService(IAlmStakeholderDao.class);
		
		//����������
		if(subTask != null && !subTask.equals(""))//������id
		{
			IBOAigaTestSubTaskValue aigaTestSubTaskValue = new BOAigaTestSubTaskBean();
			aigaTestSubTaskValue = iAigaTestSubTaskSV.getAigaTestSubTaskBySubTaskId(subTask);
			if(problemTag != null && !problemTag.equals(""))//������ϵ��JSONArray
			{
				List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
				IBOAlmStakeholderValue approvalStakeholderCreate = null;
				IBOAlmStakeholderValue approvalStakeholderModify = null;
				
				String wfTemplateString = "";
				String wfName = "";
				String condString = "";
				//�������������̸�ϵ�ˣ��������ڡ���������Ͳ�����ƻ���
				approvalStakeholderCreate = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getCREATEPROBLEMFOLLOW().getLinkId(),
					workFlowParam.getCREATEPROBLEMFOLLOW().getLinkNo(), //���봴����ͨ�������������������ϵ��
					workFlowParam.getCREATEPROBLEMFOLLOW().getTemplateId(),
					Long.valueOf(StaffId), 
					StaffName,
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaSubTaskProblemValue.getId(), 
					IObjectType.PROBLEM_FOLLOW);
					
				approvalStakeholderModify = iAigaPublicSV.generateAlmStakeholderValue(workFlowParam.getTESTERMODIFY().getLinkId(),
					workFlowParam.getTESTERMODIFY().getLinkNo(), //���봴����ͨ���������������Ƹ�ϵ��
					workFlowParam.getTESTERMODIFY().getTemplateId(),
					Long.valueOf(aigaTestSubTaskValue.getTestorId()), 
					aigaTestSubTaskValue.getTestorName(),
					IStakeholderType.STDHOLDETYPE_APPROVAL, 
					aigaSubTaskProblemValue.getId(), 
					IObjectType.PROBLEM_FOLLOW);
					
				wfTemplateString = ConstDefine.TEMPLATE_NAME_PROBLEMFOLLOWWF;
				wfName = "���������������";
				condString = "<conds><cond name=\"orderType\" value=\"1\"></cond><cond name=\"result\" value=\"pass\"></cond><cond name=\"staffId\" value=\"1\"></cond></conds>";
				iBOAlmStakeholderList.add(approvalStakeholderCreate);
				iBOAlmStakeholderList.add(approvalStakeholderModify);
				iAlmStakeholderDao.saveStakeholder(iBOAlmStakeholderList,aigaSubTaskProblemValue.getId(),IObjectType.PROBLEM_FOLLOW);

				AlmMatrixClient amc = new AlmMatrixClient();
				//������һ������
				amc.createStartSaveOrder(String.valueOf(aigaSubTaskProblemValue.getId()), IObjectType.PROBLEM_FOLLOW, wfTemplateString,condString,wfName);
				//��������
				amc.createWorkflow(wfTemplateString, "1", IObjectType.PROBLEM_FOLLOW, String.valueOf(aigaSubTaskProblemValue.getId()), ServiceManager.getOpDateTime(), wfName, condString);
				aigaSubTaskProblemValue.setStartMark(1);
				iAigaTestSubTaskSV.saveAigaSubTaskProblem(aigaSubTaskProblemValue);
			}
			
		}
	}

	
}
