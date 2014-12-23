package com.asiainfo.csc.matrix.service.interfaces;

import java.util.Map;

import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public interface IAlmWorkorderSV {
	public IBOAlmWorkorderValue[] getAlmWorkorderByCondition(String condition,Map paramter) throws Exception;
	public void saveAlmWorkorder(IBOAlmWorkorderValue[] workorders) throws Exception;
	public void saveAlmWorkorder(IBOAlmWorkorderValue workorder) throws Exception;
	public IBOAlmWorkorderValue getLastWorkorderByObjIdAndObjType(String objId,
			String objType) throws Exception;
	
	public IBOAlmWorkorderValue getFristWorkorderByObjIdAndObjTypeAndLinkNo(String objId,String objType,String linkNo) throws Exception;
	
	public IBOAlmWorkorderValue capyWorkorderByWorkorder(
			IBOAlmWorkorderValue almWorkorderValue) throws Exception ;
	
	public IBOAlmWorkorderValue capyWorkorderByWorkorderNoSave(
			IBOAlmWorkorderValue almWorkorderValue) throws Exception ;
	
	public IBOAlmWorkorderValue queryWorkOrderById(String workOrderID) throws NumberFormatException, Exception;
	
	public IBOAlmWorkorderValue queryUpperOrder(String objId,String objType) throws Exception;
}
