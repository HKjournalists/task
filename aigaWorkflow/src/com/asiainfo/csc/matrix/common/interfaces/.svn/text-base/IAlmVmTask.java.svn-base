package com.asiainfo.csc.matrix.common.interfaces;


public interface IAlmVmTask {
	//人工环节前置任务
	public void userPreTask(long workflowId, String workflowTag, long taskId, String taskTag, String objId, String objType) throws Exception;
	//人工环节后置任务
	public void userRearTask(long workflowId, String workflowTag, long taskId, String taskTag, String objId, String objType) throws Exception;
	//会签前置任务
	public void signPreTask(long workflowId, String workflowTag,
			long taskId, String taskTag, String objId, String objType)
			throws Exception ;
	//会签环节后置任务
	public String signRearTask(long workflowId, String workflowTag,
					long taskId, String taskTag, String objId, String objType)
					throws Exception ;
	public void finishTask(long workflowId, String workflowTag, String objId, String objType) throws Exception;
	//流程结果环节任务 此方法需要人为制定工作流完成时 业务对象当前环节编号
	//目的将所有工单移至历史表中
	public void finishTask(long workflowId, String workflowTag, String objId, String objType, String linkNo) throws Exception;
	//抽象函数 用于实现业务对象当前阶段和当前环节状态更新
	public abstract void updateObjCurPhaseAndCurStatus(String objId,String objType,String linkId) throws Exception;
	
	public abstract void extraMethod(long orderId,String objId,String objType,String methodType) throws Exception;
	
	//public abstract void finishTaskUpdateOther(String objId,String objType) throws Exception;
	
	//新增函数，为自动节点添加工单
	public void autoTask(long workflowId, String workflowTag, long taskId, String taskTag, String objId, String objType) throws Exception;
}
