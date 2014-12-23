package com.asiainfo.csc.matrix.common.interfaces;

import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public interface IAlmWorkflowAssociationDrivingFun {
	public IBOAlmWorkorderValue[] fristActiveWODrivePassiveWO(Long active_obj_ID,String active_obj_type,String activeTopoNo,String passiveTopoNo) throws Exception;
	public IBOAlmWorkorderValue[] allActiveWODrivePassiveWO(Long active_obj_ID,String active_obj_type,String activeTopoNo,String passiveTopoNo) throws Exception;
}
