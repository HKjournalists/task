package com.asiainfo.csc.common.service.impl;

import com.ai.appframe2.service.ServiceFactory;
import com.asiainfo.csc.common.dao.interfaces.IWorkorderDao;
import com.asiainfo.csc.common.service.interfaces.IWorkflowFinishSV;

public class WorkflowFinishSVImpl implements IWorkflowFinishSV{

	IWorkorderDao iWorkorderDao = (IWorkorderDao) ServiceFactory.getService(IWorkorderDao.class);
	
	
	public void finishWorkflow(String objId, String objType)throws Exception {
		// TODO Auto-generated method stub
		this.updateReqCurPhaseAndCurStatus(Long.valueOf(objId),objType);
	}

	/**
	 * 更新阶段
	 * @param productId
	 * @param taskTag
	 * @throws Exception
	 */
	public void updateReqCurPhaseAndCurStatus(Long objId,String objType)
	throws Exception {
//	try {
//			//需求
//			if(objType.equals("1")){
//				IAlmReqSV reqSV = (IAlmReqSV)ServiceFactory.getService(IAlmReqSV.class);
//				IRequisitionValue reqValue = reqSV.getReqById(objId);
////				reqValue.setCurPhase(Long.valueOf(WorkFlowParam.getInstance().getREQFINISH().getPhaseId()));
////				reqValue.setCurStatus(WorkFlowParam.getInstance().getREQFINISH().getLinkId());
//				reqSV.saveReq(reqValue);
//			}
//			else if(objType.equals("2")){
//				IAlmSubReqDao subReqDao = (IAlmSubReqDao)ServiceFactory.getService(IAlmSubReqDao.class);
//				Criteria sql = new Criteria();
//				sql.addEqual(BOAlmSubReqBean.S_SubReqId, objId);
//				IBOAlmSubReqValue[] subReqValue = subReqDao.getSubReq(sql.toString(), sql.getParameters());
//				if(subReqValue.length!=1)
//					throw new Exception("查询到的子需求不为1，函数updateReqCurPhaseAndCurStatus");
////				subReqValue[0].setStatus(Long.valueOf(WorkFlowParam.getInstance().getEND().getPhaseId()));
//				subReqDao.saveSubReq(subReqValue[0]);
//			}
//			//版本
//			else if(objType.equals("4")){
//				IVersionSV verSV = (IVersionSV)ServiceFactory.getService(IVersionSV.class);
//				IBOVersionValue[] verValue = verSV.queryVersion(String.valueOf(objId));
//				if(verValue.length!=1)
//					throw new Exception("查询到的版本不为1，函数updateReqCurPhaseAndCurStatus");
////				verValue[0].setCurPhase(Long.valueOf(WorkFlowParam.getInstance().getVERFINISH().getPhaseId()));
////				verValue[0].setCurStatus(WorkFlowParam.getInstance().getVERFINISH().getLinkId());
//				IVersionDao verDao = (IVersionDao)ServiceFactory.getService(IVersionDao.class);
//				verDao.saveVersion(verValue[0]);
//			}
//			//值班问题管理
//			else if(objType.equals("9")){
//				IDutyProblemDao dutyDao = (IDutyProblemDao)ServiceFactory.getService(IDutyProblemDao.class);
//				IBODutyProblemValue dutyValue = dutyDao.getDutyProblemById(objId);
////				dutyValue.setCurPhase(Integer.valueOf(WorkFlowParam.getInstance().getMODIFYFINISH().getPhaseId()));
////				dutyValue.setCurStatus(Integer.valueOf(String.valueOf(WorkFlowParam.getInstance().getMODIFYFINISH().getLinkId())));
//				dutyDao.saveProblem(dutyValue);
//			}
//			//员工培训管理
//			else if(objType.equals("11")){
//				IStaffTrainDao staffDao = (IStaffTrainDao)ServiceFactory.getService(IStaffTrainDao.class);
//				IBOStaffTrainValue staffValue = staffDao.getStaffTrainById(objId);
////				staffValue.setCurPhase(Integer.valueOf(WorkFlowParam.getInstance().getSTAFFFINISH().getPhaseId()));
////				staffValue.setCurStatus(Integer.valueOf(String.valueOf(WorkFlowParam.getInstance().getSTAFFFINISH().getLinkId())));
//				staffDao.saveStaffTrain(staffValue);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			throw new Exception("状态和阶段失败！\n\n错误原因："
//					+ (e.getCause() == null ? e.getMessage() : e.getCause()
//							.getMessage()), e);
//		}
	}
}
