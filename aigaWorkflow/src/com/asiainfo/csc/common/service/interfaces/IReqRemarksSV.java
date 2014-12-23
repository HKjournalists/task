package com.asiainfo.csc.common.service.interfaces;

import com.asiainfo.csc.common.ivalues.IBOReqRemarksValue;

public interface IReqRemarksSV {

	public void saveReqRemarks(IBOReqRemarksValue value)throws Exception;
	
	public void delReqRemarks(String remarkId)throws Exception;
	
	public IBOReqRemarksValue[] queryReqRemarks(String objTag,String objType,int startindex, int endindex)throws Exception;
	
	public int countReqRemarks(String objTag,String objType)throws Exception;
}
