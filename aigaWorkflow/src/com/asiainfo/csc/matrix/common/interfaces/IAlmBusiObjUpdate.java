package com.asiainfo.csc.matrix.common.interfaces;

public interface IAlmBusiObjUpdate {
	//抽象函数 用于实现业务对象当前阶段和当前环节状态更新
	public abstract void updateObjCurPhaseAndCurStatus(String objId,String objType,String linkId) throws Exception;
	
	public abstract void extraMethod(long orderId,String objId,String objType,String methodType) throws Exception;
}
